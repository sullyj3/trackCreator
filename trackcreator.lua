-- create tracks based on text file supplied by user

-- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
function lines_from(filename)
  local lines = {}
  for line in io.lines(filename) do 
    lines[#lines + 1] = line
  end
  return lines
end

function main()
  local tracklist = ""
  local gotPath, tracklist = reaper.GetUserFileNameForRead(tracklist, "Select track list file", "txt")
  if not gotPath then
    return
  end

  local lines = lines_from(tracklist)

  for i = 1, #lines do
    reaper.InsertTrackAtIndex(reaper.GetNumTracks(), true)
    local newTrack = reaper.GetTrack(0, reaper.GetNumTracks()-1)
    reaper.GetSetMediaTrackInfo_String(newTrack, "P_NAME", lines[i], true)

  end
end

main()
