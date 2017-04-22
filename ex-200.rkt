#lang htdp/bsl+

(require 2htdp/itunes)

; ### Data Definitions

; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; year, 
; month (between 1 and 12 inclusive), 
; day (between 1 and 31), 
; hour (between 0 and 23),
; minute (between 0 and 59),
; and second (also between 0 and 59).


; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: 
; - the track's title, 
; - artist, 
; - album
; - length in milliseconds, 
; - position within the album
; - the date it was added
; - how often it has been played, 
; - and the date when it was last played
; Examples:
(define 
  track1 
  (create-track
    "Pacman in the dark"
    "Johnny and the drunken squirrels"
    "Once upon a time"
    (* 3 60 1000)
    1
    (create-date 2015 6 3 12 30 30)
    42
    (create-date 2017 9 2 21 45 15)
    ))

(define 
  track2
  (create-track
    "My little goat"
    "Johnny and the drunken squirrels"
    "Once upon a time"
    (* 2 60 1000)
    2
    (create-date 2014 7 2 12 0 0)
    93
    (create-date 2017 9 3 21 0 0)
    ))

(define 
  track3
  (create-track
    "Eating cookies after the dusk"
    "Marieta Marieta"
    "My last album"
    (* 180 1000)
    1
    (create-date 2000 3 2 12 1 0)
    600
    (create-date 2017 9 3 21 0 0)
    ))

; A LTracks is one of:
; - '()
; - (cons Track LTracks)
; Example:
(define track-list (list track1 track2 track3))


; ### Functions

; LTracks -> Number
; Calculates the total amount of play time of a track list
(check-expect (total-time track-list) (+ (track-time track1) (track-time track2) (track-time track3)))
(define (total-time track-list)
  (cond
    [(empty? track-list) 0]
    [else
      (+
        (track-time (first track-list))
        (total-time (rest track-list))
        )]))

(require test-engine/racket-tests)
(test)

; NOTE: the exercise suggests to source data from an external XML file, but I don't have one
; and to me it is not an interesting thing to do. If you want to do it, just use the following 
; lines:
; (require 2htdp/batch-io)
; (total-time (read-itunes-as-tracks "path-to-your-library"))