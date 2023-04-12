Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3516DFD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLSBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDLSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:01:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED47286
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:01:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso70455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681322477; x=1683914477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEnJIeAKThoD+qiI9N4XqbUOz5MDQWDyP1vWr3YrWyQ=;
        b=vUnwZsN1UM/zPp93urx5LrIdPimKtZTvas+5oCiZD3RmtgVUI1l0dlxqTZ+eH4W5y2
         t2JNVKtn2M7WDOi3WQ1QyDYicuUjLV6IeT+NKAmUwUydYu/y89b4XmXPxGaFsKmr5iW4
         9M+wMSyMtwli+u+S01JvsOCT4B8hFxV/tBVcwYfrf2r1nZ3vE+4ojYGzXmMVRfopdEcT
         FkYTDKtp3Lr80t/R8YbUnOwwYODUUMhyefqgcP6pbNOPqRA2ES4r7YeLmrJsGOBq2QXO
         dyhvWr1XybKsUqWScSaeZUxsXjuirymveXKu8TH8JEvmckGZEcekd2a038a69CpH7w02
         8d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322477; x=1683914477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEnJIeAKThoD+qiI9N4XqbUOz5MDQWDyP1vWr3YrWyQ=;
        b=eTzEaqVuHPGbfnqmciS21WG7AIA8t4xOffzOyfmYhx1yS5G2enc7j3ZVqR5b3sAUKJ
         kKKZon82d2BqH+FjP3qdCv8uSRXeTKDsGhkeN++5kD6iD1n2N65IT1hDz0ClsTWZ7q5V
         en6KgVG1iYxGzxSH+AZ07017ulIulhCawExnYssNMZ8ianfNBKxGBa9EXNm2mTO46hCn
         7fJI9cfjPnCz0RqNhMsTEFAkGHaE9FEumbnVX8/GaPZSe8TIA7KuaOMWq/dSroQMs/nN
         0aPWsl+hCBdFH0J4m8BnDPE6O8vwgMRkekcXOqPx20VjPn6bPGDfn0WzF48DPRyILWgq
         UnIA==
X-Gm-Message-State: AAQBX9cUr1hwq+zWptuFA3S7JtF2rdIWZ5Y4yK8U58TYIJexpMonerdK
        CfAdYh2yjwFmmjGn+JVO5Ep7jB0nnU3ZsL2EfgV73Q==
X-Google-Smtp-Source: AKy350biw0VQoxCcPfq//BeD7NhLAQrqxgBwmIvgC4Cz7pKR7FIEUETJun7V05paylP2RUHeH709NWawm9bseo4cHXs=
X-Received: by 2002:a05:600c:45c8:b0:3ee:113f:4fd9 with SMTP id
 s8-20020a05600c45c800b003ee113f4fd9mr482644wmo.1.1681322476709; Wed, 12 Apr
 2023 11:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230411205622.3266490-1-irogers@google.com> <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
 <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com> <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com>
In-Reply-To: <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Apr 2023 11:01:04 -0700
Message-ID: <CAP-5=fUELu6nT8sGjkPvzKOX2qxH-w9q5mJgsjLBoYwAQ5bP6Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:32=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
> On 2023-04-12 12:04 p.m., Ian Rogers wrote:
> > On Wed, Apr 12, 2023 at 6:44=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >> On 2023-04-11 4:56 p.m., Ian Rogers wrote:
> >>> Perf stat with no arguments will use default events and metrics. Thes=
e
> >>> events may fail to open even with kernel and hypervisor disabled. Whe=
n
> >>> these fail then the permissions error appears even though they were
> >>> implicitly selected. This is particularly a problem with the automati=
c
> >>> selection of the TopdownL1 metric group on certain architectures like
> >>> Skylake:
> >>>
> >>> ```
> >>> $ perf stat true
> >>> Error:
> >>> Access to performance monitoring and observability operations is limi=
ted.
> >>> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to op=
en
> >>> access to performance monitoring and observability operations for pro=
cesses
> >>> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability=
.
> >>> More information can be found at 'Perf events and tool security' docu=
ment:
> >>> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> >>> perf_event_paranoid setting is 2:
> >>>   -1: Allow use of (almost) all events by all users
> >>>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LO=
CK
> >>>> =3D 0: Disallow raw and ftrace function tracepoint access
> >>>> =3D 1: Disallow CPU event access
> >>>> =3D 2: Disallow kernel profiling
> >>> To make the adjusted perf_event_paranoid setting permanent preserve i=
t
> >>> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> >>> ```
> >>>
> >>> This patch adds skippable evsels that when they fail to open will be
> >>> skipped. The TopdownL1 events are marked as skippable. This turns the
> >>> failure above to:
> >>>
> >>> ```
> >>> $ perf stat true
> >>>
> >>>  Performance counter stats for 'true':
> >>>
> >>>               1.28 msec task-clock:u                     #    0.323 C=
PUs utilized
> >>>                  0      context-switches:u               #    0.000 /=
sec
> >>>                  0      cpu-migrations:u                 #    0.000 /=
sec
> >>>                 48      page-faults:u                    #   37.550 K=
/sec
> >>>            206,228      cycles:u                         #    0.161 G=
Hz                         (44.07%)
> >>>            122,904      instructions:u                   #    0.60  i=
nsn per cycle
> >>>             28,263      branches:u                       #   22.110 M=
/sec
> >>>              2,461      branch-misses:u                  #    8.71% o=
f all branches
> >>>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
> >>>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
> >>>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
> >>>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
> >>>      <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
> >>>      <not counted>      UOPS_ISSUED.ANY:u
> >>>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
> >>>      <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
> >>>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
> >>>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
> >>>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
> >>>      <not counted>      UOPS_ISSUED.ANY:u
> >>>
> >>>        0.003958627 seconds time elapsed
> >>>
> >>>        0.000000000 seconds user
> >>>        0.004263000 seconds sys
> >>>
> >>> Some events weren't counted. Try disabling the NMI watchdog:
> >>>         echo 0 > /proc/sys/kernel/nmi_watchdog
> >>>         perf stat ...
> >>>         echo 1 > /proc/sys/kernel/nmi_watchdog
> >>> The events in group usually have to be from the same PMU. Try reorgan=
izing the group.
> >>> ```
> >>>
> >>
> >> I don't think that's how the perf stat default was designed.
> >> There should be no multiplexing or <not counted> with perf stat true.
> >>
> >>
> >>> When the events can have kernel/hypervisor disabled, like on
> >>> Tigerlake, then it continues to succeed as:
> >>>
> >>> ```
> >>> $ perf stat true
> >>>
> >>>  Performance counter stats for 'true':
> >>>
> >>>               0.57 msec task-clock:u                     #    0.385 C=
PUs utilized
> >>>                  0      context-switches:u               #    0.000 /=
sec
> >>>                  0      cpu-migrations:u                 #    0.000 /=
sec
> >>>                 47      page-faults:u                    #   82.329 K=
/sec
> >>>            287,017      cycles:u                         #    0.503 G=
Hz
> >>>            133,318      instructions:u                   #    0.46  i=
nsn per cycle
> >>>             31,396      branches:u                       #   54.996 M=
/sec
> >>>              2,442      branch-misses:u                  #    7.78% o=
f all branches
> >>>            998,790      TOPDOWN.SLOTS:u                  #     14.5 %=
  tma_retiring
> >>>                                                   #     27.6 %  tma_b=
ackend_bound
> >>>                                                   #     40.9 %  tma_f=
rontend_bound
> >>>                                                   #     17.0 %  tma_b=
ad_speculation
> >>>            144,922      topdown-retiring:u
> >>>            411,266      topdown-fe-bound:u
> >>>            258,510      topdown-be-bound:u
> >>>            184,090      topdown-bad-spec:u
> >>>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M=
/sec
> >>>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u=
 #    6.015 M/sec
> >>>
> >>>        0.001480954 seconds time elapsed
> >>>
> >>>        0.000000000 seconds user
> >>>        0.001686000 seconds sys
> >>> ```
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/builtin-stat.c | 39 ++++++++++++++++++++++++++++++-------=
--
> >>>  tools/perf/util/evsel.c   | 15 +++++++++++++--
> >>>  tools/perf/util/evsel.h   |  1 +
> >>>  3 files changed, 44 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>> index 38133afda7fc..024fda0dd943 100644
> >>> --- a/tools/perf/builtin-stat.c
> >>> +++ b/tools/perf/builtin-stat.c
> >>> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(s=
truct evsel *counter)
> >>>                       evsel_list->core.threads->err_thread =3D -1;
> >>>                       return COUNTER_RETRY;
> >>>               }
> >>> +     } else if (counter->skippable) {
> >>> +             if (verbose > 0)
> >>> +                     ui__warning("skipping event %s that kernel fail=
ed to open .\n",
> >>> +                                 evsel__name(counter));
> >>> +             counter->supported =3D false;
> >>> +             counter->errored =3D true;
> >>> +             return COUNTER_SKIP;
> >>>       }
> >>>
> >>>       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg))=
;
> >>> @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
> >>>                * Add TopdownL1 metrics if they exist. To minimize
> >>>                * multiplexing, don't request threshold computation.
> >>>                */
> >>> -             if (metricgroup__has_metric("TopdownL1") &&
> >>> -                 metricgroup__parse_groups(evsel_list, "TopdownL1",
> >>> -                                         /*metric_no_group=3D*/false=
,
> >>> -                                         /*metric_no_merge=3D*/false=
,
> >>> -                                         /*metric_no_threshold=3D*/t=
rue,
> >>> -                                         stat_config.user_requested_=
cpu_list,
> >>> -                                         stat_config.system_wide,
> >>> -                                         &stat_config.metric_events)=
 < 0)
> >>> -                     return -1;
> >>
> >>
> >> I think we should move these to X86 specific code. Maybe we should
> >> provide something like, arch_perf_stat_default(), for different ARCHs =
to
> >> append their specific events with perf stat default, such as
> >> TopdownL1/L2 on newer Intel machines.
> >>
> >> I still don't think we should only rely on the event list for the
> >> availability of the Topdown feature. For example, the topdown metrics
> >> hasn't been supported by the KVM yet. If perf stat is launched on a IC=
L
> >> VM, you should at least get "not supported" with perf stat true, which
> >> breaks the design. We need to check the events which are exposed in th=
e
> >> sysfs, or add a new ABI to expose the capability in
> >> /sys/devices/cpu/caps/, before appending events to perf stat default.
> >>
> >> Thanks,
> >> Kan
> >
> > Thanks Kan,
> >
> > you are talking about a few different things here so let's break it apa=
rt.
> >
> > 1) default metrics and TopdownL2. Firstly, this isn't something this
> > change is seeking to alter.
>
> Yes, I agree. TopdownL2 is not my intention here either. We can discuss
> it later.
>
> > I'm not opposed to defaulting to TopdownL2
> > when the events are available, so sapphirerapids. The problem is that
> > when the events are present we may be on a hybrid system and then we
> > need to mix TopdownL2 and TopdownL1. It seems cleanest to just show
> > TopdownL1, at least on hybrid. On non-hybrid sapphirerapids it also
> > seems logical to always show TopdownL1 as, to derive thresholds for
> > TopdownL2 you need TopdownL1. So what we're really talking about is
> > that on sapphirerapids it'd be nice to add TopdownL2 to the default
> > metrics, and as we add default events for particular architectures we
> > can likewise do it for metrics. To avoid multiplexing in that
> > scenario, if it is possible with the metrics, the metrics just need
> > parsing with metric_no_group set to match the previous behavior -
> > although, something better may be desired to keep groups. We may just
> > be able to add this logic to evlist__add_default_attrs and it doesn't
> > strike me as a big deal. When running perf stat with no arguments, I
> > think defaulting to including the TopdownL1 metrics, when available,
> > is both useful and good marketing of the feature.
> >
> > 2) perf in kvm support for default metrics. Firstly, perf in kvm
> > failing to display default metrics is a pre-existing condition and not
> > one that has changed in the perf-tools-next branch.
>
> I don't think it's a pre-existing condition. KVM doesn't support the
> perf metrics, so the feature will not be enumerated in a VM. The VM
> kernel doesn't expose the related Topdown events.
>
> Before the below patch, perf tool checks whether the topdown metrics
> events are exposed by the kernel. If yes, it appends the topdown events
> to perf stat default. If you run the previous perf tool in a ICX/SPR VM,
> you should not see the topdown events.
> https://lore.kernel.org/lkml/20230219092848.639226-40-irogers@google.com/
>
> However, the above patch delete the runtime check. It only relies on the
> event list file, which doesn't have enough informatiom to tell whether
> the feature/event is supported.

Even if you see the file in sysfs, is it programmable? Currently yes
for topdown events when they are restricted to not kernel, etc., but
we're probably only some hardware bug away from that not being the
case - then we end up with the Skylake more restricted behavior. And
when we end up there we'll want the skippable evsels (or some other
solution) to avoid getting <not counted>.

> > The particular
> > events/metrics have changed. In general perf stat hasn't tried to be
> > proactive in seeing if a perf_event_open will fail before doing it,
> > the fact that the perf_event_open fails is the signal to switch off
> > kernel/hypervisor profiling. There's the sandybridge and later problem
> > that we have with using perf_event_open, for these PMUs the
> > perf_event_open will succeed but potentially nothing will be counted
> > to workaround a hardware bug. Detecting all the failure modes for
> > perf_event_open to me sounds tricky, it will also inherently replicate
> > what the kernel is already doing, for these reasons I'm comfortable
> > just using perf_event_open as the way to detect features are present
> > imperfect as it is - and this will yield not supported/counted as
> > currently happens.
> The kernel has been exposed the available events to
> /sys/devices/cpu/events/. Why cannot we just check the availability
> there, before invoking the perf_event_open?

Because the metrics come from the TMA metrics that use the json
events. We even verify that the metrics don't reference non-json
events. What is available in sysfs is only a small subset, or very
often nothing for uncore PMUs.

> >
> > 3) getting not supported/counted in stat output "breaking the design".
> > So, as mentioned in 2 we already have this breakage in the current
> > design.
>
> To be honest, I don't think the current behavior is a new design.
>
> I think I've mentioned the breakage when the change was introduced.
> https://lore.kernel.org/lkml/231233ec-a098-fab6-6444-3da46bdad039@linux.i=
ntel.com/
>
> Before the above change, I think perf stat default works well, (no
> multiplexing or <not counted>). I really wish we can be back to the
> previous behavior.

So it didn't work well and we shouldn't go back. The metrics and the
thresholds were both inaccurate compared to the TMA metrics. The code
relied on saved values that had broken aggregation. There is also no
multiplexing or <not counted> with TopdownL1:

```
$ /tmp/perf/perf stat /tmp/perf/perf bench mem memcpy
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 1MB bytes ...

     18.780048 GB/sec
# function 'x86-64-unrolled' (unrolled memcpy() in arch/x86/lib/memcpy_64.S=
)
# Copying 1MB bytes ...

     22.194602 GB/sec
# function 'x86-64-movsq' (movsq-based memcpy() in arch/x86/lib/memcpy_64.S=
)
# Copying 1MB bytes ...

     13.754401 GB/sec
# function 'x86-64-movsb' (movsb-based memcpy() in arch/x86/lib/memcpy_64.S=
)
# Copying 1MB bytes ...

     10.388963 GB/sec

Performance counter stats for '/tmp/perf/perf bench mem memcpy':

            12.68 msec task-clock:u                     #    0.919
CPUs utilized
                0      context-switches:u               #    0.000
/sec
                0      cpu-migrations:u                 #    0.000
/sec
            3,162      page-faults:u                    #  249.291
K/sec
       17,182,349      cycles:u                         #    1.355 GHz
       20,155,488      instructions:u                   #    1.17
insn per cycle
        3,872,218      branches:u                       #  305.284
M/sec
           88,957      branch-misses:u                  #    2.30% of
all branches
       85,049,800      TOPDOWN.SLOTS:u                  #     24.3 %
tma_retiring
                                                 #     41.5 %
tma_backend_bound
                                                 #     14.8 %
tma_frontend_bound
                                                 #     19.4 %
tma_bad_speculation
       20,678,774      topdown-retiring:u
       12,674,087      topdown-fe-bound:u
       34,686,977      topdown-be-bound:u
       17,009,960      topdown-bad-spec:u
          115,363      INT_MISC.UOP_DROPPING:u          #    9.095
M/sec
          127,399      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #
10.044 M/sec


      0.013806386 seconds time elapsed

      0.009324000 seconds user
      0.004662000 seconds sys
```

I think we need to fix multiplexing for TopdownL2 but that's something
that comes from having accurate metrics making sharing of event groups
more of a challenge - metric_no_group already solves this. TopdownL2
is also off-topic here.

> > Something that is different here is that we know that the
> > events that fail are ones marked skippable. We could (1) remove
> > skippable events from the evlist that couldn't be opened or we could
> > (2) not display skippable events without counts. Doing 2 is the less
> > invasive change as (1) would need to resolve state with things like
> > metrics. Perhaps if we do (2) then we can also warn that events
> > weren't displayed because of permissions. As this sounds like the most
> > acceptable thing to do, I'll put together a v2 patch set with it.
> >
> > There are other failures with perf, for example system wide fails with:
> >
> > ```
> > $ perf stat -a sleep 1
> > Error:
> > Access to performance monitoring and observability operations is limite=
d.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for proce=
sses
> > without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > More information can be found at 'Perf events and tool security' docume=
nt:
> > https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> > perf_event_paranoid setting is 2:
> >  -1: Allow use of (almost) all events by all users
> >      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> =3D 0: Disallow raw and ftrace function tracepoint access
> >> =3D 1: Disallow CPU event access
> >> =3D 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > ```
> >
>
> I think the security/permission check is a different thing. We should
> not return anything to a user but a warning when they don't have a
> permission.
>
> If they have the permission, I think the perf stat default should return
> the available essential statistic information. No <not counted>, no
> multiplexing, no warnings.
>
> To summarize, I mainly have two comments.
> - We need a clean perf stat default.

Agreed.

> - We shouldn't only rely on the event list file. We need to do runtime
> check on the availability of events. Either perf_event_open() or
> /sys/devices/cpu/events/ is fine (althourh personally I prefer sys way,
> since I think it's easier).

Using perf_event_open is the status quo and the sysfs approach is
impractical imo. I think the only thing that is needed in v2 is for
<not counted> to be displayed for skippable evsels.

Thanks,
Ian

> Thanks,
> Kan
>
> > I'm not sure this is the most useful error message. We could be more
> > specific and say the failure relates to system wide events, and
> > removing those would hopefully yield success. There is also a lack of
> > testing on these error paths, which if nothing else would document
> > what the expected behavior should be.
> >
> > Thanks,
> > Ian
> >
> >>> +             if (metricgroup__has_metric("TopdownL1")) {
> >>> +                     struct evlist *metric_evlist =3D evlist__new();
> >>> +                     struct evsel *metric_evsel;
> >>> +
> >>> +                     if (!metric_evlist)
> >>> +                             return -1;
> >>> +
> >>> +                     if (metricgroup__parse_groups(metric_evlist, "T=
opdownL1",
> >>> +                                                     /*metric_no_gro=
up=3D*/false,
> >>> +                                                     /*metric_no_mer=
ge=3D*/false,
> >>> +                                                     /*metric_no_thr=
eshold=3D*/true,
> >>> +                                                     stat_config.use=
r_requested_cpu_list,
> >>> +                                                     stat_config.sys=
tem_wide,
> >>> +                                                     &stat_config.me=
tric_events) < 0)
> >>> +                             return -1;
> >>> +
> >>> +                     evlist__for_each_entry(metric_evlist, metric_ev=
sel) {
> >>> +                             metric_evsel->skippable =3D true;
> >>> +                     }
> >>> +                     evlist__splice_list_tail(evsel_list, &metric_ev=
list->core.entries);
> >>> +                     evlist__delete(metric_evlist);
> >>> +             }
> >>> +
> >>>               /* Platform specific attrs */
> >>>               if (evlist__add_default_attrs(evsel_list, default_null_=
attrs) < 0)
> >>>                       return -1;
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index dc3faf005c3b..a09654ea18ec 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
> >>>       evsel->per_pkg_mask  =3D NULL;
> >>>       evsel->collect_stat  =3D false;
> >>>       evsel->pmu_name      =3D NULL;
> >>> +     evsel->skippable     =3D false;
> >>>  }
> >>>
> >>>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
> >>> @@ -1717,9 +1718,13 @@ static int get_group_fd(struct evsel *evsel, i=
nt cpu_map_idx, int thread)
> >>>               return -1;
> >>>
> >>>       fd =3D FD(leader, cpu_map_idx, thread);
> >>> -     BUG_ON(fd =3D=3D -1);
> >>> +     BUG_ON(fd =3D=3D -1 && !leader->skippable);
> >>>
> >>> -     return fd;
> >>> +     /*
> >>> +      * When the leader has been skipped, return -2 to distinguish f=
rom no
> >>> +      * group leader case.
> >>> +      */
> >>> +     return fd =3D=3D -1 ? -2 : fd;
> >>>  }
> >>>
> >>>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_=
threads, int thread_idx)
> >>> @@ -2101,6 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel=
, struct perf_cpu_map *cpus,
> >>>
> >>>                       group_fd =3D get_group_fd(evsel, idx, thread);
> >>>
> >>> +                     if (group_fd =3D=3D -2) {
> >>> +                             pr_debug("broken group leader for %s\n"=
, evsel->name);
> >>> +                             err =3D -EINVAL;
> >>> +                             goto out_close;
> >>> +                     }
> >>> +
> >>>                       test_attr__ready();
> >>>
> >>>                       /* Debug message used by test scripts */
> >>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >>> index 68072ec655ce..98afe3351176 100644
> >>> --- a/tools/perf/util/evsel.h
> >>> +++ b/tools/perf/util/evsel.h
> >>> @@ -95,6 +95,7 @@ struct evsel {
> >>>               bool                    weak_group;
> >>>               bool                    bpf_counter;
> >>>               bool                    use_config_name;
> >>> +             bool                    skippable;
> >>>               int                     bpf_fd;
> >>>               struct bpf_object       *bpf_obj;
> >>>               struct list_head        config_terms;
