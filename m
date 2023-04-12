Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0258B6DF78F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDLNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjDLNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:44:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B3448E;
        Wed, 12 Apr 2023 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681307061; x=1712843061;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cyWKiS1RSxU/uwSpPjQPjlBqvJ8kxFGZIWRB9JB4jbQ=;
  b=f8owaBOIZgnPAZn65Y/IDqgBbDXKPLNyp6BAJBhIuie9U59YVI5i8g8W
   rRvl02Q9KjPcUlp8TGX/pVyYWgc8g5gL7VUxKL9wKkssKuAs5PGm8ll9z
   dKoxqwExSzqAT6wqL6Pd2mvOssb3Ju7OiX0XieTJUVYdWp4BLkt/uuJXh
   1CbxxBBkVkCNj5OLgwgx9J+AM59YcgEEmaEMGTrQVmoRlg7WXyXxDNhXp
   fL4WLtS0L7mwKDQ8AtZDFQtPY08NAedI0qZ7z57LCxjWsFliDAVoxMVMn
   rcgS8V0WyOVhx6GqtFEsY7qFHg/569y1Kdq6gkYSOH2lCSnJMXld1z3j9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328008900"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328008900"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863310736"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863310736"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 06:44:20 -0700
Received: from [10.251.4.46] (kliang2-mobl1.ccr.corp.intel.com [10.251.4.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BBE89580871;
        Wed, 12 Apr 2023 06:44:18 -0700 (PDT)
Message-ID: <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:44:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230411205622.3266490-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-11 4:56 p.m., Ian Rogers wrote:
> Perf stat with no arguments will use default events and metrics. These
> events may fail to open even with kernel and hypervisor disabled. When
> these fail then the permissions error appears even though they were
> implicitly selected. This is particularly a problem with the automatic
> selection of the TopdownL1 metric group on certain architectures like
> Skylake:
> 
> ```
> $ perf stat true
> Error:
> Access to performance monitoring and observability operations is limited.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> access to performance monitoring and observability operations for processes
> without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> More information can be found at 'Perf events and tool security' document:
> https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> perf_event_paranoid setting is 2:
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>> = 0: Disallow raw and ftrace function tracepoint access
>> = 1: Disallow CPU event access
>> = 2: Disallow kernel profiling
> To make the adjusted perf_event_paranoid setting permanent preserve it
> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> ```
> 
> This patch adds skippable evsels that when they fail to open will be
> skipped. The TopdownL1 events are marked as skippable. This turns the
> failure above to:
> 
> ```
> $ perf stat true
> 
>  Performance counter stats for 'true':
> 
>               1.28 msec task-clock:u                     #    0.323 CPUs utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 48      page-faults:u                    #   37.550 K/sec
>            206,228      cycles:u                         #    0.161 GHz                         (44.07%)
>            122,904      instructions:u                   #    0.60  insn per cycle
>             28,263      branches:u                       #   22.110 M/sec
>              2,461      branch-misses:u                  #    8.71% of all branches
>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
>      <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
>      <not counted>      UOPS_ISSUED.ANY:u
>      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
>      <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
>      <not counted>      CPU_CLK_UNHALTED.THREAD:u
>      <not counted>      UOPS_ISSUED.ANY:u
> 
>        0.003958627 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.004263000 seconds sys
> 
> Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
> The events in group usually have to be from the same PMU. Try reorganizing the group.
> ```
>

I don't think that's how the perf stat default was designed.
There should be no multiplexing or <not counted> with perf stat true.


> When the events can have kernel/hypervisor disabled, like on
> Tigerlake, then it continues to succeed as:
> 
> ```
> $ perf stat true
> 
>  Performance counter stats for 'true':
> 
>               0.57 msec task-clock:u                     #    0.385 CPUs utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 47      page-faults:u                    #   82.329 K/sec
>            287,017      cycles:u                         #    0.503 GHz
>            133,318      instructions:u                   #    0.46  insn per cycle
>             31,396      branches:u                       #   54.996 M/sec
>              2,442      branch-misses:u                  #    7.78% of all branches
>            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  tma_retiring
>                                                   #     27.6 %  tma_backend_bound
>                                                   #     40.9 %  tma_frontend_bound
>                                                   #     17.0 %  tma_bad_speculation
>            144,922      topdown-retiring:u
>            411,266      topdown-fe-bound:u
>            258,510      topdown-be-bound:u
>            184,090      topdown-bad-spec:u
>              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/sec
>              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/u #    6.015 M/sec
> 
>        0.001480954 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.001686000 seconds sys
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 39 ++++++++++++++++++++++++++++++---------
>  tools/perf/util/evsel.c   | 15 +++++++++++++--
>  tools/perf/util/evsel.h   |  1 +
>  3 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 38133afda7fc..024fda0dd943 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>  			evsel_list->core.threads->err_thread = -1;
>  			return COUNTER_RETRY;
>  		}
> +	} else if (counter->skippable) {
> +		if (verbose > 0)
> +			ui__warning("skipping event %s that kernel failed to open .\n",
> +				    evsel__name(counter));
> +		counter->supported = false;
> +		counter->errored = true;
> +		return COUNTER_SKIP;
>  	}
>  
>  	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
> @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
>  		 * Add TopdownL1 metrics if they exist. To minimize
>  		 * multiplexing, don't request threshold computation.
>  		 */
> -		if (metricgroup__has_metric("TopdownL1") &&
> -		    metricgroup__parse_groups(evsel_list, "TopdownL1",
> -					    /*metric_no_group=*/false,
> -					    /*metric_no_merge=*/false,
> -					    /*metric_no_threshold=*/true,
> -					    stat_config.user_requested_cpu_list,
> -					    stat_config.system_wide,
> -					    &stat_config.metric_events) < 0)
> -			return -1;


I think we should move these to X86 specific code. Maybe we should
provide something like, arch_perf_stat_default(), for different ARCHs to
append their specific events with perf stat default, such as
TopdownL1/L2 on newer Intel machines.

I still don't think we should only rely on the event list for the
availability of the Topdown feature. For example, the topdown metrics
hasn't been supported by the KVM yet. If perf stat is launched on a ICL
VM, you should at least get "not supported" with perf stat true, which
breaks the design. We need to check the events which are exposed in the
sysfs, or add a new ABI to expose the capability in
/sys/devices/cpu/caps/, before appending events to perf stat default.

Thanks,
Kan

> +		if (metricgroup__has_metric("TopdownL1")) {
> +			struct evlist *metric_evlist = evlist__new();
> +			struct evsel *metric_evsel;
> +
> +			if (!metric_evlist)
> +				return -1;
> +
> +			if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
> +							/*metric_no_group=*/false,
> +							/*metric_no_merge=*/false,
> +							/*metric_no_threshold=*/true,
> +							stat_config.user_requested_cpu_list,
> +							stat_config.system_wide,
> +							&stat_config.metric_events) < 0)
> +				return -1;
> +
> +			evlist__for_each_entry(metric_evlist, metric_evsel) {
> +				metric_evsel->skippable = true;
> +			}
> +			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
> +			evlist__delete(metric_evlist);
> +		}
> +
>  		/* Platform specific attrs */
>  		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
>  			return -1;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dc3faf005c3b..a09654ea18ec 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
>  	evsel->per_pkg_mask  = NULL;
>  	evsel->collect_stat  = false;
>  	evsel->pmu_name      = NULL;
> +	evsel->skippable     = false;
>  }
>  
>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
> @@ -1717,9 +1718,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>  		return -1;
>  
>  	fd = FD(leader, cpu_map_idx, thread);
> -	BUG_ON(fd == -1);
> +	BUG_ON(fd == -1 && !leader->skippable);
>  
> -	return fd;
> +	/*
> +	 * When the leader has been skipped, return -2 to distinguish from no
> +	 * group leader case.
> +	 */
> +	return fd == -1 ? -2 : fd;
>  }
>  
>  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int thread_idx)
> @@ -2101,6 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			group_fd = get_group_fd(evsel, idx, thread);
>  
> +			if (group_fd == -2) {
> +				pr_debug("broken group leader for %s\n", evsel->name);
> +				err = -EINVAL;
> +				goto out_close;
> +			}
> +
>  			test_attr__ready();
>  
>  			/* Debug message used by test scripts */
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 68072ec655ce..98afe3351176 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -95,6 +95,7 @@ struct evsel {
>  		bool			weak_group;
>  		bool			bpf_counter;
>  		bool			use_config_name;
> +		bool			skippable;
>  		int			bpf_fd;
>  		struct bpf_object	*bpf_obj;
>  		struct list_head	config_terms;
