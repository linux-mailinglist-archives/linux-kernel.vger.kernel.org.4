Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995696E4F39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:31:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C743E6;
        Mon, 17 Apr 2023 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681752679; x=1713288679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g4AzBVEKauljUK1zQa8QNsPzUyopAAURR4dQIly5CDI=;
  b=A1xU4mZipM6cmKyvxx8D8+r9oJdbU/SMnmupxPJfV2NVgMZiniIAC8zQ
   5IdmJW/VBYxzVcKR4T/83lfsz4ph0iiWDg4+WrzQ6NVU+Juo6TcaBghru
   eCfv8UjnP07/1VevSo7EtVW9dCAy54D7E9eoa3nxw62KUZFtdGXRxF75e
   k/EZjeCWbmKtemlBA63UoU9YIX1p9T7bJaL/Gpi/t3J8v6B12gXIiU1XE
   HN/zyTOlj+vaLgPGLh7E5LtiGsQquRrN/lPzTiBqI+plFyBuQc17U2TBO
   GnosaWcYYAS4JVVWUVA0Kr/nDw6ddNon9Q/xWGxz4BiLYCssyXvRadVCG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346800365"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="346800365"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 10:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="690742740"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="690742740"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2023 10:31:18 -0700
Received: from [10.212.151.175] (kliang2-mobl1.ccr.corp.intel.com [10.212.151.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E7CF5580677;
        Mon, 17 Apr 2023 10:31:16 -0700 (PDT)
Message-ID: <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
Date:   Mon, 17 Apr 2023 13:31:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
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
References: <20230414051922.3625666-1-irogers@google.com>
 <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com>
 <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-17 11:59 a.m., Ian Rogers wrote:
> On Mon, Apr 17, 2023 at 6:58 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-04-14 7:03 p.m., Ian Rogers wrote:
>>> On Fri, Apr 14, 2023 at 11:07 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023-04-14 1:19 a.m., Ian Rogers wrote:
>>>>> Perf stat with no arguments will use default events and metrics. These
>>>>> events may fail to open even with kernel and hypervisor disabled. When
>>>>> these fail then the permissions error appears even though they were
>>>>> implicitly selected. This is particularly a problem with the automatic
>>>>> selection of the TopdownL1 metric group on certain architectures like
>>>>> Skylake:
>>>>>
>>>>> ```
>>>>> $ perf stat true
>>>>> Error:
>>>>> Access to performance monitoring and observability operations is limited.
>>>>> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>>>>> access to performance monitoring and observability operations for processes
>>>>> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>>>>> More information can be found at 'Perf events and tool security' document:
>>>>> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>>>>> perf_event_paranoid setting is 2:
>>>>>   -1: Allow use of (almost) all events by all users
>>>>>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>>>>>> = 0: Disallow raw and ftrace function tracepoint access
>>>>>> = 1: Disallow CPU event access
>>>>>> = 2: Disallow kernel profiling
>>>>> To make the adjusted perf_event_paranoid setting permanent preserve it
>>>>> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
>>>>> ```
>>>>>
>>>>> This patch adds skippable evsels that when they fail to open won't
>>>>> fail and won't appear in output. The TopdownL1 events, from the metric
>>>>> group, are marked as skippable. This turns the failure above to:
>>>>>
>>>>> ```
>>>>> $ perf stat true
>>>>>
>>>>>  Performance counter stats for 'true':
>>>>>
>>>>>               1.26 msec task-clock:u                     #    0.328 CPUs utilized
>>>>>                  0      context-switches:u               #    0.000 /sec
>>>>>                  0      cpu-migrations:u                 #    0.000 /sec
>>>>>                 49      page-faults:u                    #   38.930 K/sec
>>>>>            176,449      cycles:u                         #    0.140 GHz                         (48.99%)
>>>>
>>>> Multiplexing?
>>>>
>>>> Thanks,
>>>> Kan
>>>
>>> I may have been running a test in the background otherwise I can't
>>> explain it. Repeating the test yields no multiplexing:
>>
>>
>> The above multiplexing should be on a Skylake (since there is no
>> topdownL1 printed), but the test which you repeat seems on a Tigerlake
>> (has topdownL1). Could you please double check on a Skylake?
> 
> In the best circumstances (ie no EBS_Mode, no other events, nmi
> watchdog disabled) Skylake has multiplexing for TopdownL1:
>

No I mean the perf stat default on Skylake.

With this patch, on a Skylake machine, there should be no TopdownL1
event and no multiplexing.
From your test result in the v2 description, we can see that there is no
TopdownL1, which is good and expected. However, there is a (48.99%) with
cycles:u event, which implies multiplexing. Could you please check
what's the problem here?
Also, if it's because of the backgroud, all the events should be
multiplexing. But it looks like only cycle:u has multiplexing. Other
events, instructions:u, branches:u and branch-misses:u work without
multiplexing. That's very strange.


> ```
> $ sudo perf stat --metric-no-group -M TopdownL1 --metric-no-group -a sleep 1
> 
> Performance counter stats for 'system wide':
> 
>       500,145,019      INST_RETIRED.ANY                 #     14.2 %
> tma_retiring             (71.07%)
>     2,402,640,337      CPU_CLK_UNHALTED.THREAD_ANY      #     41.1 %
> tma_frontend_bound
>                                                  #     36.2 %
> tma_backend_bound
>                                                  #      8.4 %
> tma_bad_speculation      (85.63%)
>     1,976,769,761      IDQ_UOPS_NOT_DELIVERED.CORE
>                         (85.81%)
>       114,069,133      INT_MISC.RECOVERY_CYCLES_ANY
>                         (85.83%)
>       684,605,487      UOPS_RETIRED.RETIRE_SLOTS
>                         (85.83%)
>        49,695,823      UOPS_RETIRED.MACRO_FUSED
>                         (85.83%)
>       860,603,122      UOPS_ISSUED.ANY
>                         (56.70%)
> 
>       1.014011174 seconds time elapsed
> ```
> 
> but this isn't a regression:
> https://lore.kernel.org/lkml/20200520072814.128267-1-irogers@google.com/
> 
> I think this is off-topic for this change.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>>
>>> ```
>>> $ perf stat true
>>>
>>> Performance counter stats for 'true':
>>>
>>>              0.78 msec task-clock:u                     #    0.383
>>> CPUs utilized
>>>                 0      context-switches:u               #    0.000
>>> /sec
>>>                 0      cpu-migrations:u                 #    0.000
>>> /sec
>>>                47      page-faults:u                    #   60.174
>>> K/sec
>>>           233,420      cycles:u                         #    0.299 GHz
>>>           133,318      instructions:u                   #    0.57
>>> insn per cycle
>>>            31,396      branches:u                       #   40.196
>>> M/sec
>>>             2,334      branch-misses:u                  #    7.43% of
>>> all branches
>>>         1,167,100      TOPDOWN.SLOTS:u                  #     12.2 %
>>> tma_retiring
>>>                                                  #     28.9 %
>>> tma_backend_bound
>>>                                                  #     41.0 %
>>> tma_frontend_bound
>>>                                                  #     18.0 %
>>> tma_bad_speculation
>>>           141,882      topdown-retiring:u
>>>           480,570      topdown-fe-bound:u
>>>           320,380      topdown-be-bound:u
>>>           224,266      topdown-bad-spec:u
>>>             2,173      INT_MISC.UOP_DROPPING:u          #    2.782
>>> M/sec
>>>             3,323      cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/u #
>>>  4.254 M/sec
>>>
>>>
>>>       0.002036744 seconds time elapsed
>>>
>>>       0.002252000 seconds user
>>>       0.000000000 seconds sys
>>> ```
>>>

This is apparently on a TigerLake, which has TopdownL1 with the perf
stat default. I don't have a problem with this.

Thanks,
Kan

>>> Thanks,
>>> Ian
>>>
>>>>>            122,905      instructions:u                   #    0.70  insn per cycle
>>>>>             28,264      branches:u                       #   22.456 M/sec
>>>>>              2,405      branch-misses:u                  #    8.51% of all branches
>>>>>
>>>>>        0.003834565 seconds time elapsed
>>>>>
>>>>>        0.000000000 seconds user
>>>>>        0.004130000 seconds sys
>>>>> ```
>>>>>
>>>>> When the events can have kernel/hypervisor disabled, like on
>>>>> Tigerlake, then it continues to succeed as:
>>>>>
>>>>> ```
>>>>> $ perf stat true
>>>>>
>>>>>  Performance counter stats for 'true':
>>>>>
>>>>>               0.57 msec task-clock:u                     #    0.385 CPUs utilized
>>>>>                  0      context-switches:u               #    0.000 /sec
>>>>>                  0      cpu-migrations:u                 #    0.000 /sec
>>>>>                 47      page-faults:u                    #   82.329 K/sec
>>>>>            287,017      cycles:u                         #    0.503 GHz
>>>>>            133,318      instructions:u                   #    0.46  insn per cycle
>>>>>             31,396      branches:u                       #   54.996 M/sec
>>>>>              2,442      branch-misses:u                  #    7.78% of all branches
>>>>>            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  tma_retiring
>>>>>                                                   #     27.6 %  tma_backend_bound
>>>>>                                                   #     40.9 %  tma_frontend_bound
>>>>>                                                   #     17.0 %  tma_bad_speculation
>>>>>            144,922      topdown-retiring:u
>>>>>            411,266      topdown-fe-bound:u
>>>>>            258,510      topdown-be-bound:u
>>>>>            184,090      topdown-bad-spec:u
>>>>>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
>>>>>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/u #    6.015 M/sec
>>>>>
>>>>>        0.001480954 seconds time elapsed
>>>>>
>>>>>        0.000000000 seconds user
>>>>>        0.001686000 seconds sys
>>>>> ```
>>>>>
>>>>> And this likewise works if paranoia allows or running as root.
>>>>>
>>>>> v2. Don't display the skipped events as <not counted> or <not supported>.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
>>>>>  tools/perf/util/evsel.c        | 15 +++++++++++--
>>>>>  tools/perf/util/evsel.h        |  1 +
>>>>>  tools/perf/util/stat-display.c |  4 ++++
>>>>>  4 files changed, 48 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>>> index d3cbee7460fc..7a641a67486d 100644
>>>>> --- a/tools/perf/builtin-stat.c
>>>>> +++ b/tools/perf/builtin-stat.c
>>>>> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>>>>>                       evsel_list->core.threads->err_thread = -1;
>>>>>                       return COUNTER_RETRY;
>>>>>               }
>>>>> +     } else if (counter->skippable) {
>>>>> +             if (verbose > 0)
>>>>> +                     ui__warning("skipping event %s that kernel failed to open .\n",
>>>>> +                                 evsel__name(counter));
>>>>> +             counter->supported = false;
>>>>> +             counter->errored = true;
>>>>> +             return COUNTER_SKIP;
>>>>>       }
>>>>>
>>>>>       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
>>>>> @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
>>>>>                * Add TopdownL1 metrics if they exist. To minimize
>>>>>                * multiplexing, don't request threshold computation.
>>>>>                */
>>>>> -             if (metricgroup__has_metric("TopdownL1") &&
>>>>> -                 metricgroup__parse_groups(evsel_list, "TopdownL1",
>>>>> -                                         /*metric_no_group=*/false,
>>>>> -                                         /*metric_no_merge=*/false,
>>>>> -                                         /*metric_no_threshold=*/true,
>>>>> -                                         stat_config.user_requested_cpu_list,
>>>>> -                                         stat_config.system_wide,
>>>>> -                                         &stat_config.metric_events) < 0)
>>>>> -                     return -1;
>>>>> +             if (metricgroup__has_metric("TopdownL1")) {
>>>>> +                     struct evlist *metric_evlist = evlist__new();
>>>>> +                     struct evsel *metric_evsel;
>>>>> +
>>>>> +                     if (!metric_evlist)
>>>>> +                             return -1;
>>>>> +
>>>>> +                     if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
>>>>> +                                                     /*metric_no_group=*/false,
>>>>> +                                                     /*metric_no_merge=*/false,
>>>>> +                                                     /*metric_no_threshold=*/true,
>>>>> +                                                     stat_config.user_requested_cpu_list,
>>>>> +                                                     stat_config.system_wide,
>>>>> +                                                     &stat_config.metric_events) < 0)
>>>>> +                             return -1;
>>>>> +
>>>>> +                     evlist__for_each_entry(metric_evlist, metric_evsel) {
>>>>> +                             metric_evsel->skippable = true;
>>>>> +                     }
>>>>> +                     evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
>>>>> +                     evlist__delete(metric_evlist);
>>>>> +             }
>>>>> +
>>>>>               /* Platform specific attrs */
>>>>>               if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
>>>>>                       return -1;
>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>> index a85a987128aa..83a65f771666 100644
>>>>> --- a/tools/perf/util/evsel.c
>>>>> +++ b/tools/perf/util/evsel.c
>>>>> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
>>>>>       evsel->per_pkg_mask  = NULL;
>>>>>       evsel->collect_stat  = false;
>>>>>       evsel->pmu_name      = NULL;
>>>>> +     evsel->skippable     = false;
>>>>>  }
>>>>>
>>>>>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
>>>>> @@ -1720,9 +1721,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>>>>>               return -1;
>>>>>
>>>>>       fd = FD(leader, cpu_map_idx, thread);
>>>>> -     BUG_ON(fd == -1);
>>>>> +     BUG_ON(fd == -1 && !leader->skippable);
>>>>>
>>>>> -     return fd;
>>>>> +     /*
>>>>> +      * When the leader has been skipped, return -2 to distinguish from no
>>>>> +      * group leader case.
>>>>> +      */
>>>>> +     return fd == -1 ? -2 : fd;
>>>>>  }
>>>>>
>>>>>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int thread_idx)
>>>>> @@ -2104,6 +2109,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>>>>
>>>>>                       group_fd = get_group_fd(evsel, idx, thread);
>>>>>
>>>>> +                     if (group_fd == -2) {
>>>>> +                             pr_debug("broken group leader for %s\n", evsel->name);
>>>>> +                             err = -EINVAL;
>>>>> +                             goto out_close;
>>>>> +                     }
>>>>> +
>>>>>                       test_attr__ready();
>>>>>
>>>>>                       /* Debug message used by test scripts */
>>>>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>>>>> index 68072ec655ce..98afe3351176 100644
>>>>> --- a/tools/perf/util/evsel.h
>>>>> +++ b/tools/perf/util/evsel.h
>>>>> @@ -95,6 +95,7 @@ struct evsel {
>>>>>               bool                    weak_group;
>>>>>               bool                    bpf_counter;
>>>>>               bool                    use_config_name;
>>>>> +             bool                    skippable;
>>>>>               int                     bpf_fd;
>>>>>               struct bpf_object       *bpf_obj;
>>>>>               struct list_head        config_terms;
>>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>>>> index e6035ecbeee8..6b46bbb3d322 100644
>>>>> --- a/tools/perf/util/stat-display.c
>>>>> +++ b/tools/perf/util/stat-display.c
>>>>> @@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>>>>>       struct perf_cpu cpu;
>>>>>       int idx;
>>>>>
>>>>> +     /* Skip counters that were speculatively/default enabled rather than requested. */
>>>>> +     if (counter->skippable)
>>>>> +             return true;
>>>>> +
>>>>>       /*
>>>>>        * Skip value 0 when enabling --per-thread globally,
>>>>>        * otherwise it will have too many 0 output.
