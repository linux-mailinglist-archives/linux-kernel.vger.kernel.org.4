Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947386DFCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDLRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:32:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E4618F;
        Wed, 12 Apr 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681320750; x=1712856750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sN8Yg84QIUdadpP3apVzNkBCXwpWjlySQSrnS7GBSQQ=;
  b=IBwcidvxelTg+YxdgxDWcUHA5E7BwIislZduldzryZBmiH4j9B6f6RUq
   yULlkI+pwIwG80ACSuoqdNBfvIe7O9NjgPO7kQW165xqhCCIK1p41e6Us
   TpgxboHUcZ+H3qBC0/ZS1GzzkEquGG8A9v2dSist+U7C5eYj7BTrOsJDk
   5MM3/w2uSNUBDbvrdc9Ne4pqo8/SoZCOeyyVRzS+bsge7lv5CLHxhl7sT
   +JGtDf37hs2pdobzAaDFQ6ifW37gg+U8UUVJjzGY55W8KWECjzD+pRiAa
   51UldCi7w8Q7s2p0JFOVf5NnDb9dm/TFegjHwHvBVmLrk0h7bzhXrX13V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332667758"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332667758"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813077637"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="813077637"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2023 10:32:22 -0700
Received: from [10.251.4.46] (kliang2-mobl1.ccr.corp.intel.com [10.251.4.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ADA1C580AFF;
        Wed, 12 Apr 2023 10:32:20 -0700 (PDT)
Message-ID: <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com>
Date:   Wed, 12 Apr 2023 13:32:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
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
References: <20230411205622.3266490-1-irogers@google.com>
 <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
 <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-12 12:04 p.m., Ian Rogers wrote:
> On Wed, Apr 12, 2023 at 6:44 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2023-04-11 4:56 p.m., Ian Rogers wrote:
>>> Perf stat with no arguments will use default events and metrics. These
>>> events may fail to open even with kernel and hypervisor disabled. When
>>> these fail then the permissions error appears even though they were
>>> implicitly selected. This is particularly a problem with the automatic
>>> selection of the TopdownL1 metric group on certain architectures like
>>> Skylake:
>>>
>>> ```
>>> $ perf stat true
>>> Error:
>>> Access to performance monitoring and observability operations is limited.
>>> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>>> access to performance monitoring and observability operations for processes
>>> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>>> More information can be found at 'Perf events and tool security' document:
>>> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>>> perf_event_paranoid setting is 2:
>>>   -1: Allow use of (almost) all events by all users
>>>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>>>> = 0: Disallow raw and ftrace function tracepoint access
>>>> = 1: Disallow CPU event access
>>>> = 2: Disallow kernel profiling
>>> To make the adjusted perf_event_paranoid setting permanent preserve it
>>> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
>>> ```
>>>
>>> This patch adds skippable evsels that when they fail to open will be
>>> skipped. The TopdownL1 events are marked as skippable. This turns the
>>> failure above to:
>>>
>>> ```
>>> $ perf stat true
>>>
>>>  Performance counter stats for 'true':
>>>
>>>               1.28 msec task-clock:u                     #    0.323 CPUs utilized
>>>                  0      context-switches:u               #    0.000 /sec
>>>                  0      cpu-migrations:u                 #    0.000 /sec
>>>                 48      page-faults:u                    #   37.550 K/sec
>>>            206,228      cycles:u                         #    0.161 GHz                         (44.07%)
>>>            122,904      instructions:u                   #    0.60  insn per cycle
>>>             28,263      branches:u                       #   22.110 M/sec
>>>              2,461      branch-misses:u                  #    8.71% of all branches
>>>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
>>>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>>>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
>>>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
>>>      <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
>>>      <not counted>      UOPS_ISSUED.ANY:u
>>>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
>>>      <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
>>>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>>>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
>>>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
>>>      <not counted>      UOPS_ISSUED.ANY:u
>>>
>>>        0.003958627 seconds time elapsed
>>>
>>>        0.000000000 seconds user
>>>        0.004263000 seconds sys
>>>
>>> Some events weren't counted. Try disabling the NMI watchdog:
>>>         echo 0 > /proc/sys/kernel/nmi_watchdog
>>>         perf stat ...
>>>         echo 1 > /proc/sys/kernel/nmi_watchdog
>>> The events in group usually have to be from the same PMU. Try reorganizing the group.
>>> ```
>>>
>>
>> I don't think that's how the perf stat default was designed.
>> There should be no multiplexing or <not counted> with perf stat true.
>>
>>
>>> When the events can have kernel/hypervisor disabled, like on
>>> Tigerlake, then it continues to succeed as:
>>>
>>> ```
>>> $ perf stat true
>>>
>>>  Performance counter stats for 'true':
>>>
>>>               0.57 msec task-clock:u                     #    0.385 CPUs utilized
>>>                  0      context-switches:u               #    0.000 /sec
>>>                  0      cpu-migrations:u                 #    0.000 /sec
>>>                 47      page-faults:u                    #   82.329 K/sec
>>>            287,017      cycles:u                         #    0.503 GHz
>>>            133,318      instructions:u                   #    0.46  insn per cycle
>>>             31,396      branches:u                       #   54.996 M/sec
>>>              2,442      branch-misses:u                  #    7.78% of all branches
>>>            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  tma_retiring
>>>                                                   #     27.6 %  tma_backend_bound
>>>                                                   #     40.9 %  tma_frontend_bound
>>>                                                   #     17.0 %  tma_bad_speculation
>>>            144,922      topdown-retiring:u
>>>            411,266      topdown-fe-bound:u
>>>            258,510      topdown-be-bound:u
>>>            184,090      topdown-bad-spec:u
>>>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
>>>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/u #    6.015 M/sec
>>>
>>>        0.001480954 seconds time elapsed
>>>
>>>        0.000000000 seconds user
>>>        0.001686000 seconds sys
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/builtin-stat.c | 39 ++++++++++++++++++++++++++++++---------
>>>  tools/perf/util/evsel.c   | 15 +++++++++++++--
>>>  tools/perf/util/evsel.h   |  1 +
>>>  3 files changed, 44 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index 38133afda7fc..024fda0dd943 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>>>                       evsel_list->core.threads->err_thread = -1;
>>>                       return COUNTER_RETRY;
>>>               }
>>> +     } else if (counter->skippable) {
>>> +             if (verbose > 0)
>>> +                     ui__warning("skipping event %s that kernel failed to open .\n",
>>> +                                 evsel__name(counter));
>>> +             counter->supported = false;
>>> +             counter->errored = true;
>>> +             return COUNTER_SKIP;
>>>       }
>>>
>>>       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
>>> @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
>>>                * Add TopdownL1 metrics if they exist. To minimize
>>>                * multiplexing, don't request threshold computation.
>>>                */
>>> -             if (metricgroup__has_metric("TopdownL1") &&
>>> -                 metricgroup__parse_groups(evsel_list, "TopdownL1",
>>> -                                         /*metric_no_group=*/false,
>>> -                                         /*metric_no_merge=*/false,
>>> -                                         /*metric_no_threshold=*/true,
>>> -                                         stat_config.user_requested_cpu_list,
>>> -                                         stat_config.system_wide,
>>> -                                         &stat_config.metric_events) < 0)
>>> -                     return -1;
>>
>>
>> I think we should move these to X86 specific code. Maybe we should
>> provide something like, arch_perf_stat_default(), for different ARCHs to
>> append their specific events with perf stat default, such as
>> TopdownL1/L2 on newer Intel machines.
>>
>> I still don't think we should only rely on the event list for the
>> availability of the Topdown feature. For example, the topdown metrics
>> hasn't been supported by the KVM yet. If perf stat is launched on a ICL
>> VM, you should at least get "not supported" with perf stat true, which
>> breaks the design. We need to check the events which are exposed in the
>> sysfs, or add a new ABI to expose the capability in
>> /sys/devices/cpu/caps/, before appending events to perf stat default.
>>
>> Thanks,
>> Kan
> 
> Thanks Kan,
> 
> you are talking about a few different things here so let's break it apart.
> 
> 1) default metrics and TopdownL2. Firstly, this isn't something this
> change is seeking to alter. 

Yes, I agree. TopdownL2 is not my intention here either. We can discuss
it later.

> I'm not opposed to defaulting to TopdownL2
> when the events are available, so sapphirerapids. The problem is that
> when the events are present we may be on a hybrid system and then we
> need to mix TopdownL2 and TopdownL1. It seems cleanest to just show
> TopdownL1, at least on hybrid. On non-hybrid sapphirerapids it also
> seems logical to always show TopdownL1 as, to derive thresholds for
> TopdownL2 you need TopdownL1. So what we're really talking about is
> that on sapphirerapids it'd be nice to add TopdownL2 to the default
> metrics, and as we add default events for particular architectures we
> can likewise do it for metrics. To avoid multiplexing in that
> scenario, if it is possible with the metrics, the metrics just need
> parsing with metric_no_group set to match the previous behavior -
> although, something better may be desired to keep groups. We may just
> be able to add this logic to evlist__add_default_attrs and it doesn't
> strike me as a big deal. When running perf stat with no arguments, I
> think defaulting to including the TopdownL1 metrics, when available,
> is both useful and good marketing of the feature.
> 
> 2) perf in kvm support for default metrics. Firstly, perf in kvm
> failing to display default metrics is a pre-existing condition and not
> one that has changed in the perf-tools-next branch. 

I don't think it's a pre-existing condition. KVM doesn't support the
perf metrics, so the feature will not be enumerated in a VM. The VM
kernel doesn't expose the related Topdown events.

Before the below patch, perf tool checks whether the topdown metrics
events are exposed by the kernel. If yes, it appends the topdown events
to perf stat default. If you run the previous perf tool in a ICX/SPR VM,
you should not see the topdown events.
https://lore.kernel.org/lkml/20230219092848.639226-40-irogers@google.com/

However, the above patch delete the runtime check. It only relies on the
event list file, which doesn't have enough informatiom to tell whether
the feature/event is supported.


> The particular
> events/metrics have changed. In general perf stat hasn't tried to be
> proactive in seeing if a perf_event_open will fail before doing it,
> the fact that the perf_event_open fails is the signal to switch off
> kernel/hypervisor profiling. There's the sandybridge and later problem
> that we have with using perf_event_open, for these PMUs the
> perf_event_open will succeed but potentially nothing will be counted
> to workaround a hardware bug. Detecting all the failure modes for
> perf_event_open to me sounds tricky, it will also inherently replicate
> what the kernel is already doing, for these reasons I'm comfortable
> just using perf_event_open as the way to detect features are present
> imperfect as it is - and this will yield not supported/counted as
> currently happens.
The kernel has been exposed the available events to
/sys/devices/cpu/events/. Why cannot we just check the availability
there, before invoking the perf_event_open?


> 
> 3) getting not supported/counted in stat output "breaking the design".
> So, as mentioned in 2 we already have this breakage in the current
> design. 

To be honest, I don't think the current behavior is a new design.

I think I've mentioned the breakage when the change was introduced.
https://lore.kernel.org/lkml/231233ec-a098-fab6-6444-3da46bdad039@linux.intel.com/

Before the above change, I think perf stat default works well, (no
multiplexing or <not counted>). I really wish we can be back to the
previous behavior.


> Something that is different here is that we know that the
> events that fail are ones marked skippable. We could (1) remove
> skippable events from the evlist that couldn't be opened or we could
> (2) not display skippable events without counts. Doing 2 is the less
> invasive change as (1) would need to resolve state with things like
> metrics. Perhaps if we do (2) then we can also warn that events
> weren't displayed because of permissions. As this sounds like the most
> acceptable thing to do, I'll put together a v2 patch set with it.
> 
> There are other failures with perf, for example system wide fails with:
> 
> ```
> $ perf stat -a sleep 1
> Error:
> Access to performance monitoring and observability operations is limited.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> access to performance monitoring and observability operations for processes
> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> More information can be found at 'Perf events and tool security' document:
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> perf_event_paranoid setting is 2:
>  -1: Allow use of (almost) all events by all users
>      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>> = 0: Disallow raw and ftrace function tracepoint access
>> = 1: Disallow CPU event access
>> = 2: Disallow kernel profiling
> To make the adjusted perf_event_paranoid setting permanent preserve it
> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> ```
> 

I think the security/permission check is a different thing. We should
not return anything to a user but a warning when they don't have a
permission.

If they have the permission, I think the perf stat default should return
the available essential statistic information. No <not counted>, no
multiplexing, no warnings.

To summarize, I mainly have two comments.
- We need a clean perf stat default.
- We shouldn't only rely on the event list file. We need to do runtime
check on the availability of events. Either perf_event_open() or
/sys/devices/cpu/events/ is fine (althourh personally I prefer sys way,
since I think it's easier).

Thanks,
Kan

> I'm not sure this is the most useful error message. We could be more
> specific and say the failure relates to system wide events, and
> removing those would hopefully yield success. There is also a lack of
> testing on these error paths, which if nothing else would document
> what the expected behavior should be.
> 
> Thanks,
> Ian
> 
>>> +             if (metricgroup__has_metric("TopdownL1")) {
>>> +                     struct evlist *metric_evlist = evlist__new();
>>> +                     struct evsel *metric_evsel;
>>> +
>>> +                     if (!metric_evlist)
>>> +                             return -1;
>>> +
>>> +                     if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
>>> +                                                     /*metric_no_group=*/false,
>>> +                                                     /*metric_no_merge=*/false,
>>> +                                                     /*metric_no_threshold=*/true,
>>> +                                                     stat_config.user_requested_cpu_list,
>>> +                                                     stat_config.system_wide,
>>> +                                                     &stat_config.metric_events) < 0)
>>> +                             return -1;
>>> +
>>> +                     evlist__for_each_entry(metric_evlist, metric_evsel) {
>>> +                             metric_evsel->skippable = true;
>>> +                     }
>>> +                     evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
>>> +                     evlist__delete(metric_evlist);
>>> +             }
>>> +
>>>               /* Platform specific attrs */
>>>               if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
>>>                       return -1;
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index dc3faf005c3b..a09654ea18ec 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
>>>       evsel->per_pkg_mask  = NULL;
>>>       evsel->collect_stat  = false;
>>>       evsel->pmu_name      = NULL;
>>> +     evsel->skippable     = false;
>>>  }
>>>
>>>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
>>> @@ -1717,9 +1718,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>>>               return -1;
>>>
>>>       fd = FD(leader, cpu_map_idx, thread);
>>> -     BUG_ON(fd == -1);
>>> +     BUG_ON(fd == -1 && !leader->skippable);
>>>
>>> -     return fd;
>>> +     /*
>>> +      * When the leader has been skipped, return -2 to distinguish from no
>>> +      * group leader case.
>>> +      */
>>> +     return fd == -1 ? -2 : fd;
>>>  }
>>>
>>>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int thread_idx)
>>> @@ -2101,6 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>>
>>>                       group_fd = get_group_fd(evsel, idx, thread);
>>>
>>> +                     if (group_fd == -2) {
>>> +                             pr_debug("broken group leader for %s\n", evsel->name);
>>> +                             err = -EINVAL;
>>> +                             goto out_close;
>>> +                     }
>>> +
>>>                       test_attr__ready();
>>>
>>>                       /* Debug message used by test scripts */
>>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>>> index 68072ec655ce..98afe3351176 100644
>>> --- a/tools/perf/util/evsel.h
>>> +++ b/tools/perf/util/evsel.h
>>> @@ -95,6 +95,7 @@ struct evsel {
>>>               bool                    weak_group;
>>>               bool                    bpf_counter;
>>>               bool                    use_config_name;
>>> +             bool                    skippable;
>>>               int                     bpf_fd;
>>>               struct bpf_object       *bpf_obj;
>>>               struct list_head        config_terms;
