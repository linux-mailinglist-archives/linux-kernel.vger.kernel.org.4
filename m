Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAE6F6058
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjECU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjECU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:57:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF868A40;
        Wed,  3 May 2023 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683147448; x=1714683448;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LP6aJsbAslWxtPOKTpN6qXrdWcQD2USlo7JFwiBp9sU=;
  b=A7in0AJcqoulsv2rQeSaSAifnFw43F1PTAmbpOOmdrrZ3fs6NFyHykeT
   KJWoxdAj43O8kn2S+UCB9TAcvMH5kAeYVSfNBitUww8Re1Z1wFNmg5ukF
   q/9UrbvxOUoUwPGZNvAElGI7d9F6t8xktqzDfPPQvBXFJ3D/4xz+Q0lm8
   pDJpIZfwOoKAK4zJXrJ6UMu3IvMNhbwnCS/KfYenRUFGKPJv08QhBlS5l
   vSp/LwAJPB6STwdk88L77WgjNiPYMu9sTG0Rn/8hrpaF5Ny+RZNUyw/Zu
   9Mb4Kwp1zrfnY0UbhP8jh6qgeDFShKtjMb3PhflIHtVW6PJmBOd+XRi4R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="411922222"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="411922222"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="727297487"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="727297487"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2023 13:57:27 -0700
Received: from [10.209.46.175] (kliang2-mobl1.ccr.corp.intel.com [10.209.46.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 58A8C580D43;
        Wed,  3 May 2023 13:57:23 -0700 (PDT)
Message-ID: <01bb74d6-9240-5a42-f936-2106d1488800@linux.intel.com>
Date:   Wed, 3 May 2023 16:57:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 02/44] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230502223851.2234828-1-irogers@google.com>
 <20230502223851.2234828-3-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230502223851.2234828-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> Perf stat with no arguments will use default events and metrics. These
> events may fail to open even with kernel and hypervisor disabled. When
> these fail then the permissions error appears even though they were
> implicitly selected. This is particularly a problem with the automatic
> selection of the TopdownL1 metric group on certain architectures like
> Skylake:
> 
> '''
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
> '''
> 
> This patch adds skippable evsels that when they fail to open won't
> cause termination and will appear as "<not supported>" in output. The
> TopdownL1 events, from the metric group, are marked as skippable. This
> turns the failure above to:
> 
> '''
> $ perf stat perf bench internals synthesize
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 49.287 usec (+- 0.083 usec)
>   Average num. events: 3.000 (+- 0.000)
>   Average time per event 16.429 usec
>   Average data synthesis took: 49.641 usec (+- 0.085 usec)
>   Average num. events: 11.000 (+- 0.000)
>   Average time per event 4.513 usec
> 
>  Performance counter stats for 'perf bench internals synthesize':
> 
>           1,222.38 msec task-clock:u                     #    0.993 CPUs utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                162      page-faults:u                    #  132.529 /sec
>        774,445,184      cycles:u                         #    0.634 GHz                         (49.61%)
>      1,640,969,811      instructions:u                   #    2.12  insn per cycle              (59.67%)
>        302,052,148      branches:u                       #  247.102 M/sec                       (59.69%)
>          1,807,718      branch-misses:u                  #    0.60% of all branches             (59.68%)
>          5,218,927      CPU_CLK_UNHALTED.REF_XCLK:u      #    4.269 M/sec
>                                                   #     17.3 %  tma_frontend_bound
>                                                   #     56.4 %  tma_retiring
>                                                   #      nan %  tma_backend_bound
>                                                   #      nan %  tma_bad_speculation      (60.01%)
>        536,580,469      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  438.965 M/sec                       (60.33%)
>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>          5,223,936      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u #    4.274 M/sec                       (40.31%)
>        774,127,250      CPU_CLK_UNHALTED.THREAD:u        #  633.297 M/sec                       (50.34%)
>      1,746,579,518      UOPS_RETIRED.RETIRE_SLOTS:u      #    1.429 G/sec                       (50.12%)
>      1,940,625,702      UOPS_ISSUED.ANY:u                #    1.588 G/sec                       (49.70%)
> 
>        1.231055525 seconds time elapsed
> 
>        0.258327000 seconds user
>        0.965749000 seconds sys
> '''
> 
> The event INT_MISC.RECOVERY_CYCLES_ANY:u is skipped as it can't be
> opened with paranoia 2 on Skylake. With a lower paranoia, or as root,
> all events/metrics are computed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/builtin-stat.c | 38 +++++++++++++++++++++++++++++---------
>  tools/perf/util/evsel.c   | 15 +++++++++++++--
>  tools/perf/util/evsel.h   |  1 +
>  3 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index be9677aa642f..ffb47b166098 100644
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
> @@ -1890,15 +1897,28 @@ static int add_default_attributes(void)
>  		 * caused by exposing latent bugs. This is fixed properly in:
>  		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
>  		 */
> -		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid() &&
> -		    metricgroup__parse_groups(evsel_list, "TopdownL1",
> -					    /*metric_no_group=*/false,
> -					    /*metric_no_merge=*/false,
> -					    /*metric_no_threshold=*/true,
> -					    stat_config.user_requested_cpu_list,
> -					    stat_config.system_wide,
> -					    &stat_config.metric_events) < 0)
> -			return -1;
> +		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid()) {
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
>  
>  		/* Platform specific attrs */
>  		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 356c07f03be6..1cd04b5998d2 100644
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
> @@ -1725,9 +1726,13 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
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
> @@ -2109,6 +2114,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
> index 35805dcdb1b9..bf8f01af1c0b 100644
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
