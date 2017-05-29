#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Icon=firewall.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;*****************************************
;FirewallFix_for_Client.au3 by typekit

;Lizenzhinweise:
;Dieses Programm ist Freie Software: Sie können es unter den Bedingungen
;der GNU General Public License, wie von der Free Software Foundation,
;Version 3 der Lizenz oder (nach Ihrer Wahl) jeder neueren
;veröffentlichten Version, weiterverbreiten und/oder modifizieren.

;Dieses Programm wird in der Hoffnung, dass es nützlich sein wird, aber
;OHNE JEDE GEWÄHRLEISTUNG, bereitgestellt; sogar ohne die implizite
;Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK.
;Siehe die GNU General Public License für weitere Details.

;Sie sollten eine Kopie der GNU General Public License zusammen mit diesem
;Programm erhalten haben. Wenn nicht, siehe <http://www.gnu.org/licenses/>.
;*****************************************

;Willkommen im Quellcode!
;Hier wird Schritt für Schritt erklärt, wie das Script funktioniert.
;Zuerst werden Administrator-Rechte benötigt, da ansonsten keine Firewall-Veränderung vorgenommen werden kann
; Notwendige Rechte für die Firewall-Ausnahme
; Grafische Benutzeroberfläche
#include "GUI.isf"

;Parameter, um die Firewall-Ausnahme hinzuzufügen
$CMD = 'netsh advfirewall firewall add rule name="Tanki Online Client" dir=in action=allow program="C:\Program Files (x86)\Tanki Online\Tanki Online.exe"'

;Diese Variable wird später nützlich sein
$check = 0

;Grafische Benutzeroberfläche aufrufen
GUISetState(@SW_SHOW)

;Auf Eingabe des Benutzers warten
While 1
	$msg = GUIGetMsg()
	Select
	; Sollte der Button geklickt werden...
		Case $msg = $run
			;...und zwar zum ersten Mal...
			If $check = 0 Then
				;...wird die Ausnahme hinzugefügt,
				RunWait(@ComSpec & " /c " & $CMD)
				;... der Button modifiziert...
				GUICtrlSetData($run, "Fertig!")
				;...und unsere Variable um 1 erhöht.
				$check = $check + 1
			;Sollte die Aktion schon einmal ausgeführt worden sein...
			ElseIf $check = 1 Then
				;...wird das Fenster geschlossen...
				GUIDelete()
				;...und das Programm beendet...
				ExitLoop
			EndIf

		;Natürlich lässt sich das Programm auch über den herkömmlichen Weg beenden:
		Case $msg = $GUI_EVENT_CLOSE
			GUIDelete()
			ExitLoop

		;Zudem noch der Link zur Lizenz:
		Case $msg = $liget
			ShellExecute("https://www.gnu.org/licenses/gpl-3.0.en.html")
	EndSelect
Wend

;Fertig ist der Workaround