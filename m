Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153A6E4FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjDQSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:14:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A3BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:14:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso234845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681755250; x=1684347250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV+uHUYTcKS1IWQ+5og8mXkg368MBGsQWHzt+bePWQs=;
        b=MEG+JH13jhSNjFT8RxJaDb2qX8WeW8649xEXV1jCm8Az83mBlJpZ6CdUka69112ThI
         m8ilbE9kKx0lwt4ljUzAP/di6+0vz/A0ofzy5wRhVUQrMqDJ/OGXmfo2ihLimXsoFUss
         AdmCcs8jvukR2j/0lvCSO1nBBurPWUiYIOSCFDLyGXDV8pD1bVaWs5OOxpL95RUdedMM
         GkbBVw7ruS48AL100a0A6Pj7ZihY74I7etft2CGTRI0tke4zwFHHDxs6mAvpO65u+IPy
         jCX77jNhOb6rbnCqDonUVdcn+NcTtJhZAyyvK+BjZt/LXR9IjXl2mggBq9AOenKxaCMv
         lcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681755250; x=1684347250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV+uHUYTcKS1IWQ+5og8mXkg368MBGsQWHzt+bePWQs=;
        b=MPLI2PboGPLeahR2WDnbwfUyCIanE8fCLQaXFF0XV2XU5YgKHsWFo6zug/83TrDWFN
         t6po3EklkQo9Y0uiyXp57OcaFSLxR7QVC/fIDCjMarPzjU547itmCN/wxx10CyLAV2Ws
         wz4cgrh3UpL4mgXCrCiZGFBGrSn/5eGKODuJHfmfg7VxXXI9vdJtYUiqN2FgMqKPqVwB
         HkSoScS1yD+zKEZPyVwu+hEax/LMqyf1lR/MY0mb1Y7ZjmFI1iPNmfUK3DS8ksFDWHoG
         HSF6PDRzWcwm3tOU5cy3ta5gbQt6WhF8QgeoKJUUUslDUPmamsd/lUliRlEaXRrEgc5O
         4V4Q==
X-Gm-Message-State: AAQBX9egtGEtz/3PSEUt4zR9si2bKSerxjpEmcCW+Lz0sCQowesgeOe0
        89q/xQJd2o3SWMpyEN4GWicXMwE4hykZ8+e+F6yQ4A==
X-Google-Smtp-Source: AKy350ZaTxXQbtCzOblkTybxJO39i/5eFwjoaLv+oQJY5lLGRktuPnQ//BDHym2WXfNJS/FAFiT6IsqtiihjBEC1/oY=
X-Received: by 2002:a05:600c:450d:b0:3f1:7238:edd5 with SMTP id
 t13-20020a05600c450d00b003f17238edd5mr11065wmo.1.1681755250193; Mon, 17 Apr
 2023 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
In-Reply-To: <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Apr 2023 11:13:55 -0700
Message-ID: <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:31=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-17 11:59 a.m., Ian Rogers wrote:
> > On Mon, Apr 17, 2023 at 6:58=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-04-14 7:03 p.m., Ian Rogers wrote:
> >>> On Fri, Apr 14, 2023 at 11:07=E2=80=AFAM Liang, Kan <kan.liang@linux.=
intel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2023-04-14 1:19 a.m., Ian Rogers wrote:
> >>>>> Perf stat with no arguments will use default events and metrics. Th=
ese
> >>>>> events may fail to open even with kernel and hypervisor disabled. W=
hen
> >>>>> these fail then the permissions error appears even though they were
> >>>>> implicitly selected. This is particularly a problem with the automa=
tic
> >>>>> selection of the TopdownL1 metric group on certain architectures li=
ke
> >>>>> Skylake:
> >>>>>
> >>>>> ```
> >>>>> $ perf stat true
> >>>>> Error:
> >>>>> Access to performance monitoring and observability operations is li=
mited.
> >>>>> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to =
open
> >>>>> access to performance monitoring and observability operations for p=
rocesses
> >>>>> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capabili=
ty.
> >>>>> More information can be found at 'Perf events and tool security' do=
cument:
> >>>>> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml
> >>>>> perf_event_paranoid setting is 2:
> >>>>>   -1: Allow use of (almost) all events by all users
> >>>>>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_=
LOCK
> >>>>>> =3D 0: Disallow raw and ftrace function tracepoint access
> >>>>>> =3D 1: Disallow CPU event access
> >>>>>> =3D 2: Disallow kernel profiling
> >>>>> To make the adjusted perf_event_paranoid setting permanent preserve=
 it
> >>>>> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> >>>>> ```
> >>>>>
> >>>>> This patch adds skippable evsels that when they fail to open won't
> >>>>> fail and won't appear in output. The TopdownL1 events, from the met=
ric
> >>>>> group, are marked as skippable. This turns the failure above to:
> >>>>>
> >>>>> ```
> >>>>> $ perf stat true
> >>>>>
> >>>>>  Performance counter stats for 'true':
> >>>>>
> >>>>>               1.26 msec task-clock:u                     #    0.328=
 CPUs utilized
> >>>>>                  0      context-switches:u               #    0.000=
 /sec
> >>>>>                  0      cpu-migrations:u                 #    0.000=
 /sec
> >>>>>                 49      page-faults:u                    #   38.930=
 K/sec
> >>>>>            176,449      cycles:u                         #    0.140=
 GHz                         (48.99%)
> >>>>
> >>>> Multiplexing?
> >>>>
> >>>> Thanks,
> >>>> Kan
> >>>
> >>> I may have been running a test in the background otherwise I can't
> >>> explain it. Repeating the test yields no multiplexing:
> >>
> >>
> >> The above multiplexing should be on a Skylake (since there is no
> >> topdownL1 printed), but the test which you repeat seems on a Tigerlake
> >> (has topdownL1). Could you please double check on a Skylake?
> >
> > In the best circumstances (ie no EBS_Mode, no other events, nmi
> > watchdog disabled) Skylake has multiplexing for TopdownL1:
> >
>
> No I mean the perf stat default on Skylake.
>
> With this patch, on a Skylake machine, there should be no TopdownL1
> event and no multiplexing.

There are no top down events in:
```
$ perf stat true

 Performance counter stats for 'true':

              1.26 msec task-clock:u                     #    0.328
CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                49      page-faults:u                    #   38.930 K/sec
           176,449      cycles:u                         #    0.140
GHz                         (48.99%)
           122,905      instructions:u                   #    0.70
insn per cycle
            28,264      branches:u                       #   22.456 M/sec
             2,405      branch-misses:u                  #    8.51% of
all branches

       0.003834565 seconds time elapsed

       0.000000000 seconds user
       0.004130000 seconds sys
```
The json TopdownL1 is enabled if present unconditionally for perf stat
default. Enabling it on Skylake has multiplexing as TopdownL1 on
Skylake has multiplexing unrelated to this change - at least on the
machine I was testing on. We can remove the metric group TopdownL1 on
Skylake so that we don't enable it by default, there is still the
group TmaL1. To me, disabling TopdownL1 seems less desirable than
running with multiplexing - previously to get into topdown analysis
there has to be knowledge that "perf stat -M TopdownL1" is the way to
do this.

This doesn't relate to this change which is about making it so that
failing to set up TopdownL1 doesn't cause an early exit. The reason I
showed TigerLake output was that on TigerLake the skip/fallback
approach works while Skylake just needs the events disabled/skipped
unless it has sufficient permissions. Note the :u on the events in:

```
$ perf stat true

 Performance counter stats for 'true':

              0.57 msec task-clock:u                     #    0.385
CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                47      page-faults:u                    #   82.329 K/sec
           287,017      cycles:u                         #    0.503 GHz
           133,318      instructions:u                   #    0.46
insn per cycle
            31,396      branches:u                       #   54.996 M/sec
             2,442      branch-misses:u                  #    7.78% of
all branches
           998,790      TOPDOWN.SLOTS:u                  #     14.5 %
tma_retiring
                                                  #     27.6 %
tma_backend_bound
                                                  #     40.9 %
tma_frontend_bound
                                                  #     17.0 %
tma_bad_speculation
           144,922      topdown-retiring:u
           411,266      topdown-fe-bound:u
           258,510      topdown-be-bound:u
           184,090      topdown-bad-spec:u
             2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
             3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #
  6.015 M/sec

       0.001480954 seconds time elapsed

       0.000000000 seconds user
       0.001686000 seconds sys
```

> From your test result in the v2 description, we can see that there is no
> TopdownL1, which is good and expected. However, there is a (48.99%) with
> cycles:u event, which implies multiplexing. Could you please check
> what's the problem here?
> Also, if it's because of the backgroud, all the events should be
> multiplexing. But it looks like only cycle:u has multiplexing. Other
> events, instructions:u, branches:u and branch-misses:u work without
> multiplexing. That's very strange.

I wasn't able to reproduce it and suspect it was a transient thing. I
think there are multiplexing things to look into, 2 events on a fixed
counter on Icelake+ will trigger multiplexing on all counters, and
Skylake's 3 fixed and 4 generic should fit TopdownL1.

Thanks,
Ian

> > ```
> > $ sudo perf stat --metric-no-group -M TopdownL1 --metric-no-group -a sl=
eep 1
> >
> > Performance counter stats for 'system wide':
> >
> >       500,145,019      INST_RETIRED.ANY                 #     14.2 %
> > tma_retiring             (71.07%)
> >     2,402,640,337      CPU_CLK_UNHALTED.THREAD_ANY      #     41.1 %
> > tma_frontend_bound
> >                                                  #     36.2 %
> > tma_backend_bound
> >                                                  #      8.4 %
> > tma_bad_speculation      (85.63%)
> >     1,976,769,761      IDQ_UOPS_NOT_DELIVERED.CORE
> >                         (85.81%)
> >       114,069,133      INT_MISC.RECOVERY_CYCLES_ANY
> >                         (85.83%)
> >       684,605,487      UOPS_RETIRED.RETIRE_SLOTS
> >                         (85.83%)
> >        49,695,823      UOPS_RETIRED.MACRO_FUSED
> >                         (85.83%)
> >       860,603,122      UOPS_ISSUED.ANY
> >                         (56.70%)
> >
> >       1.014011174 seconds time elapsed
> > ```
> >
> > but this isn't a regression:
> > https://lore.kernel.org/lkml/20200520072814.128267-1-irogers@google.com=
/
> >
> > I think this is off-topic for this change.
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>>
> >>> ```
> >>> $ perf stat true
> >>>
> >>> Performance counter stats for 'true':
> >>>
> >>>              0.78 msec task-clock:u                     #    0.383
> >>> CPUs utilized
> >>>                 0      context-switches:u               #    0.000
> >>> /sec
> >>>                 0      cpu-migrations:u                 #    0.000
> >>> /sec
> >>>                47      page-faults:u                    #   60.174
> >>> K/sec
> >>>           233,420      cycles:u                         #    0.299 GH=
z
> >>>           133,318      instructions:u                   #    0.57
> >>> insn per cycle
> >>>            31,396      branches:u                       #   40.196
> >>> M/sec
> >>>             2,334      branch-misses:u                  #    7.43% of
> >>> all branches
> >>>         1,167,100      TOPDOWN.SLOTS:u                  #     12.2 %
> >>> tma_retiring
> >>>                                                  #     28.9 %
> >>> tma_backend_bound
> >>>                                                  #     41.0 %
> >>> tma_frontend_bound
> >>>                                                  #     18.0 %
> >>> tma_bad_speculation
> >>>           141,882      topdown-retiring:u
> >>>           480,570      topdown-fe-bound:u
> >>>           320,380      topdown-be-bound:u
> >>>           224,266      topdown-bad-spec:u
> >>>             2,173      INT_MISC.UOP_DROPPING:u          #    2.782
> >>> M/sec
> >>>             3,323      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u =
#
> >>>  4.254 M/sec
> >>>
> >>>
> >>>       0.002036744 seconds time elapsed
> >>>
> >>>       0.002252000 seconds user
> >>>       0.000000000 seconds sys
> >>> ```
> >>>
>
> This is apparently on a TigerLake, which has TopdownL1 with the perf
> stat default. I don't have a problem with this.
>
> Thanks,
> Kan
>
> >>> Thanks,
> >>> Ian
> >>>
> >>>>>            122,905      instructions:u                   #    0.70 =
 insn per cycle
> >>>>>             28,264      branches:u                       #   22.456=
 M/sec
> >>>>>              2,405      branch-misses:u                  #    8.51%=
 of all branches
> >>>>>
> >>>>>        0.003834565 seconds time elapsed
> >>>>>
> >>>>>        0.000000000 seconds user
> >>>>>        0.004130000 seconds sys
> >>>>> ```
> >>>>>
> >>>>> When the events can have kernel/hypervisor disabled, like on
> >>>>> Tigerlake, then it continues to succeed as:
> >>>>>
> >>>>> ```
> >>>>> $ perf stat true
> >>>>>
> >>>>>  Performance counter stats for 'true':
> >>>>>
> >>>>>               0.57 msec task-clock:u                     #    0.385=
 CPUs utilized
> >>>>>                  0      context-switches:u               #    0.000=
 /sec
> >>>>>                  0      cpu-migrations:u                 #    0.000=
 /sec
> >>>>>                 47      page-faults:u                    #   82.329=
 K/sec
> >>>>>            287,017      cycles:u                         #    0.503=
 GHz
> >>>>>            133,318      instructions:u                   #    0.46 =
 insn per cycle
> >>>>>             31,396      branches:u                       #   54.996=
 M/sec
> >>>>>              2,442      branch-misses:u                  #    7.78%=
 of all branches
> >>>>>            998,790      TOPDOWN.SLOTS:u                  #     14.5=
 %  tma_retiring
> >>>>>                                                   #     27.6 %  tma=
_backend_bound
> >>>>>                                                   #     40.9 %  tma=
_frontend_bound
> >>>>>                                                   #     17.0 %  tma=
_bad_speculation
> >>>>>            144,922      topdown-retiring:u
> >>>>>            411,266      topdown-fe-bound:u
> >>>>>            258,510      topdown-be-bound:u
> >>>>>            184,090      topdown-bad-spec:u
> >>>>>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528=
 M/sec
> >>>>>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge=
/u #    6.015 M/sec
> >>>>>
> >>>>>        0.001480954 seconds time elapsed
> >>>>>
> >>>>>        0.000000000 seconds user
> >>>>>        0.001686000 seconds sys
> >>>>> ```
> >>>>>
> >>>>> And this likewise works if paranoia allows or running as root.
> >>>>>
> >>>>> v2. Don't display the skipped events as <not counted> or <not suppo=
rted>.
> >>>>>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>> ---
> >>>>>  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++----=
----
> >>>>>  tools/perf/util/evsel.c        | 15 +++++++++++--
> >>>>>  tools/perf/util/evsel.h        |  1 +
> >>>>>  tools/perf/util/stat-display.c |  4 ++++
> >>>>>  4 files changed, 48 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>>>> index d3cbee7460fc..7a641a67486d 100644
> >>>>> --- a/tools/perf/builtin-stat.c
> >>>>> +++ b/tools/perf/builtin-stat.c
> >>>>> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error=
(struct evsel *counter)
> >>>>>                       evsel_list->core.threads->err_thread =3D -1;
> >>>>>                       return COUNTER_RETRY;
> >>>>>               }
> >>>>> +     } else if (counter->skippable) {
> >>>>> +             if (verbose > 0)
> >>>>> +                     ui__warning("skipping event %s that kernel fa=
iled to open .\n",
> >>>>> +                                 evsel__name(counter));
> >>>>> +             counter->supported =3D false;
> >>>>> +             counter->errored =3D true;
> >>>>> +             return COUNTER_SKIP;
> >>>>>       }
> >>>>>
> >>>>>       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg=
));
> >>>>> @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
> >>>>>                * Add TopdownL1 metrics if they exist. To minimize
> >>>>>                * multiplexing, don't request threshold computation.
> >>>>>                */
> >>>>> -             if (metricgroup__has_metric("TopdownL1") &&
> >>>>> -                 metricgroup__parse_groups(evsel_list, "TopdownL1"=
,
> >>>>> -                                         /*metric_no_group=3D*/fal=
se,
> >>>>> -                                         /*metric_no_merge=3D*/fal=
se,
> >>>>> -                                         /*metric_no_threshold=3D*=
/true,
> >>>>> -                                         stat_config.user_requeste=
d_cpu_list,
> >>>>> -                                         stat_config.system_wide,
> >>>>> -                                         &stat_config.metric_event=
s) < 0)
> >>>>> -                     return -1;
> >>>>> +             if (metricgroup__has_metric("TopdownL1")) {
> >>>>> +                     struct evlist *metric_evlist =3D evlist__new(=
);
> >>>>> +                     struct evsel *metric_evsel;
> >>>>> +
> >>>>> +                     if (!metric_evlist)
> >>>>> +                             return -1;
> >>>>> +
> >>>>> +                     if (metricgroup__parse_groups(metric_evlist, =
"TopdownL1",
> >>>>> +                                                     /*metric_no_g=
roup=3D*/false,
> >>>>> +                                                     /*metric_no_m=
erge=3D*/false,
> >>>>> +                                                     /*metric_no_t=
hreshold=3D*/true,
> >>>>> +                                                     stat_config.u=
ser_requested_cpu_list,
> >>>>> +                                                     stat_config.s=
ystem_wide,
> >>>>> +                                                     &stat_config.=
metric_events) < 0)
> >>>>> +                             return -1;
> >>>>> +
> >>>>> +                     evlist__for_each_entry(metric_evlist, metric_=
evsel) {
> >>>>> +                             metric_evsel->skippable =3D true;
> >>>>> +                     }
> >>>>> +                     evlist__splice_list_tail(evsel_list, &metric_=
evlist->core.entries);
> >>>>> +                     evlist__delete(metric_evlist);
> >>>>> +             }
> >>>>> +
> >>>>>               /* Platform specific attrs */
> >>>>>               if (evlist__add_default_attrs(evsel_list, default_nul=
l_attrs) < 0)
> >>>>>                       return -1;
> >>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>>> index a85a987128aa..83a65f771666 100644
> >>>>> --- a/tools/perf/util/evsel.c
> >>>>> +++ b/tools/perf/util/evsel.c
> >>>>> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
> >>>>>       evsel->per_pkg_mask  =3D NULL;
> >>>>>       evsel->collect_stat  =3D false;
> >>>>>       evsel->pmu_name      =3D NULL;
> >>>>> +     evsel->skippable     =3D false;
> >>>>>  }
> >>>>>
> >>>>>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx=
)
> >>>>> @@ -1720,9 +1721,13 @@ static int get_group_fd(struct evsel *evsel,=
 int cpu_map_idx, int thread)
> >>>>>               return -1;
> >>>>>
> >>>>>       fd =3D FD(leader, cpu_map_idx, thread);
> >>>>> -     BUG_ON(fd =3D=3D -1);
> >>>>> +     BUG_ON(fd =3D=3D -1 && !leader->skippable);
> >>>>>
> >>>>> -     return fd;
> >>>>> +     /*
> >>>>> +      * When the leader has been skipped, return -2 to distinguish=
 from no
> >>>>> +      * group leader case.
> >>>>> +      */
> >>>>> +     return fd =3D=3D -1 ? -2 : fd;
> >>>>>  }
> >>>>>
> >>>>>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int n=
r_threads, int thread_idx)
> >>>>> @@ -2104,6 +2109,12 @@ static int evsel__open_cpu(struct evsel *evs=
el, struct perf_cpu_map *cpus,
> >>>>>
> >>>>>                       group_fd =3D get_group_fd(evsel, idx, thread)=
;
> >>>>>
> >>>>> +                     if (group_fd =3D=3D -2) {
> >>>>> +                             pr_debug("broken group leader for %s\=
n", evsel->name);
> >>>>> +                             err =3D -EINVAL;
> >>>>> +                             goto out_close;
> >>>>> +                     }
> >>>>> +
> >>>>>                       test_attr__ready();
> >>>>>
> >>>>>                       /* Debug message used by test scripts */
> >>>>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >>>>> index 68072ec655ce..98afe3351176 100644
> >>>>> --- a/tools/perf/util/evsel.h
> >>>>> +++ b/tools/perf/util/evsel.h
> >>>>> @@ -95,6 +95,7 @@ struct evsel {
> >>>>>               bool                    weak_group;
> >>>>>               bool                    bpf_counter;
> >>>>>               bool                    use_config_name;
> >>>>> +             bool                    skippable;
> >>>>>               int                     bpf_fd;
> >>>>>               struct bpf_object       *bpf_obj;
> >>>>>               struct list_head        config_terms;
> >>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-=
display.c
> >>>>> index e6035ecbeee8..6b46bbb3d322 100644
> >>>>> --- a/tools/perf/util/stat-display.c
> >>>>> +++ b/tools/perf/util/stat-display.c
> >>>>> @@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct pe=
rf_stat_config *config,
> >>>>>       struct perf_cpu cpu;
> >>>>>       int idx;
> >>>>>
> >>>>> +     /* Skip counters that were speculatively/default enabled rath=
er than requested. */
> >>>>> +     if (counter->skippable)
> >>>>> +             return true;
> >>>>> +
> >>>>>       /*
> >>>>>        * Skip value 0 when enabling --per-thread globally,
> >>>>>        * otherwise it will have too many 0 output.
