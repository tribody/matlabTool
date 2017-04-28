function varargout = imageResizeTool(varargin)
% IMAGERESIZETOOL MATLAB code for imageResizeTool.fig
%      IMAGERESIZETOOL, by itself, creates a new IMAGERESIZETOOL or raises the existing
%      singleton*.
%
%      H = IMAGERESIZETOOL returns the handle to a new IMAGERESIZETOOL or the handle to
%      the existing singleton*.
%
%      IMAGERESIZETOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGERESIZETOOL.M with the given input arguments.
%
%      IMAGERESIZETOOL('Property','Value',...) creates a new IMAGERESIZETOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageResizeTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageResizeTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageResizeTool

% Last Modified by GUIDE v2.5 27-Apr-2017 15:09:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageResizeTool_OpeningFcn, ...
                   'gui_OutputFcn',  @imageResizeTool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imageResizeTool is made visible.
function imageResizeTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageResizeTool (see VARARGIN)

% Choose default command line output for imageResizeTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageResizeTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageResizeTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_input_folders.
function select_input_folders_Callback(hObject, eventdata, handles)
% hObject    handle to select_input_folders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.input_folders = uigetdir;

guidata(hObject, handles);


% --- Executes on button press in select_output_folders.
function select_output_folders_Callback(hObject, eventdata, handles)
% hObject    handle to select_output_folders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output_folders = uigetdir;

guidata(hObject, handles);



% --- Executes on button press in resize.
function resize_Callback(hObject, eventdata, handles)
% hObject    handle to resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 批量剪裁给定文件夹的图片

input_folder = handles.input_folders;
output_folder = handles.output_folders;
scale = handles.scale;

dirs = dir(input_folder);
isimg = ~[dirs(:).isdir];

img_path_list = dirs(isimg);
tic
fprintf('%u 张图片待处理...\n', length(img_path_list));

for i = 1 : 1 : length(img_path_list)
    img_name = img_path_list(i).name;
    I = imread(strcat(input_folder, '\',  img_name));
    [h, w, t] = size(I);
    I = imresize(I, [h * scale, w * scale]);
    imwrite(I, strcat(output_folder, '\',  img_name));
end
fprintf('处理完成，耗时：%f 秒\n', toc);
fprintf('照片尺寸从%u * %u剪裁到%u * %u', w, h, w * scale, h * scale);



% --- Executes during object creation, after setting all properties.
function zoom_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoom_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zoom_scale_set.
function zoom_scale_set_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_scale_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function zoom_scale_setting_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_scale_setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zoom_scale_setting as text
%        str2double(get(hObject,'String')) returns contents of zoom_scale_setting as a double

scale = str2num(get(handles.zoom_scale_setting, 'String'));

if isempty(scale)
    scale = 1;
end

handles.scale = scale;
set(handles.zoom_scale_setting, 'String', num2str(handles.scale));

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function zoom_scale_setting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoom_scale_setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
