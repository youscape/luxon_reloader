%%%-------------------------------------------------------------------
%% @doc luxon_reloader top level supervisor.
%% @end
%%%-------------------------------------------------------------------
-module(luxon_reloader_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    ReloaderWorker = {luxon_reloader, {luxon_reloader, start_link, []},
        permanent, 5000, worker, [luxon_reloader]},

    {ok, { {one_for_one, 5, 5}, [ReloaderWorker]} }.

%%====================================================================
%% Internal functions
%%====================================================================
