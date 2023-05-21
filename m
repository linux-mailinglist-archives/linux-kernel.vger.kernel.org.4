Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC470AFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEUTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEUTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:04:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6EC7;
        Sun, 21 May 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684695854; x=1716231854;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=o/nBIXYQuJa1U9R6oXDACiDyRKKcHg1DHMthJla02HY=;
  b=kbdv3OtmJkxM8bvjg7X3sDM/wkiycy1MUEaEdWE2TDkHGCt/xVp/kQ+I
   vaXX1irLR7SFaLnZXhRHH5Zq+Bx2QfukYfxW62RwcWUporezLcUbcrSOT
   yTHvHmZbWTxDZkohFm5E7jecAvXOwQP2oMUc+R1ymvsigH/XbhecUSMhh
   5w5jHs87Mk58S4sijSmY7zWeqPvb7lpqIRi72iErCo2iCbFcRmS70C0Sz
   4eKnMmKNtoCo32eIp8TGkVoIqLlo9cj3kY0WfQbvcf96aNXJTas2u5cDh
   JO7B59rjsh1ZS8RSfLok93f+PPeBlTkRq0LH+AeR82kDjlV9ur48AuBPi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="439102311"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="439102311"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 12:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="815399419"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="815399419"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2023 12:04:12 -0700
Received: from [10.212.161.251] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5F003580ABD;
        Sun, 21 May 2023 12:04:08 -0700 (PDT)
Message-ID: <3586d413-b7c9-9790-ec4e-4132502c806d@linux.intel.com>
Date:   Sun, 21 May 2023 15:04:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 01/23] perf tools: Warn if no user requested CPUs match
 PMU's CPUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230517145803.559429-1-irogers@google.com>
 <20230517145803.559429-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517145803.559429-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> In commit 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybrid")
> perf on hybrid will warn if a user requested CPU doesn't match the PMU
> of the given event but only for hybrid PMUs. Make the logic generic
> for all PMUs and remove the hybrid logic.

The logic may not work for all PMUs, especially for uncore.

For uncore, the user should be able to read counters from any CPU of a
socket/die, not just the CPU from the cpumask.
Please see d6a2f9035bfc ("perf/core: Introduce PMU_EV_CAP_READ_ACTIVE_PKG").

Thanks,
Kan
> 
> Warn if a CPU is requested that is offline for uncore events. Warn if
> a CPU is requested for a core PMU, but the CPU isn't within the cpu
> map of that PMU.
> 
> For example on a 16 (0-15) CPU system:
> ```
> $ perf stat -e imc_free_running/data_read/,cycles -C 16 true
> WARNING: Requested CPU(s) '16' not supported by PMU 'uncore_imc_free_running_1' for event 'imc_free_running/data_read/'
> WARNING: Requested CPU(s) '16' not supported by PMU 'uncore_imc_free_running_0' for event 'imc_free_running/data_read/'
> WARNING: Requested CPU(s) '16' not supported by PMU 'cpu' for event 'cycles'
> 
>  Performance counter stats for 'CPU(s) 16':
> 
>    <not supported> MiB  imc_free_running/data_read/
>    <not supported>      cycles
> 
>        0.000570094 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c     |  6 +--
>  tools/perf/builtin-stat.c       |  5 +--
>  tools/perf/util/cpumap.h        |  2 +-
>  tools/perf/util/evlist-hybrid.c | 74 ---------------------------------
>  tools/perf/util/evlist-hybrid.h |  1 -
>  tools/perf/util/evlist.c        | 44 ++++++++++++++++++++
>  tools/perf/util/evlist.h        |  2 +
>  tools/perf/util/pmu.c           | 33 ---------------
>  tools/perf/util/pmu.h           |  4 --
>  9 files changed, 49 insertions(+), 122 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ec0f2d5f189f..9d212236c75a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4198,11 +4198,7 @@ int cmd_record(int argc, const char **argv)
>  	/* Enable ignoring missing threads when -u/-p option is defined. */
>  	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
>  
> -	if (evlist__fix_hybrid_cpus(rec->evlist, rec->opts.target.cpu_list)) {
> -		pr_err("failed to use cpu list %s\n",
> -		       rec->opts.target.cpu_list);
> -		goto out;
> -	}
> +	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
>  
>  	rec->opts.target.hybrid = perf_pmu__has_hybrid();
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index bc45cee3f77c..612467216306 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2462,10 +2462,7 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
> -		pr_err("failed to use cpu list %s\n", target.cpu_list);
> -		goto out;
> -	}
> +	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
>  
>  	target.hybrid = perf_pmu__has_hybrid();
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index e3426541e0aa..c1de993c083f 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -59,7 +59,7 @@ struct perf_cpu cpu__max_present_cpu(void);
>  /**
>   * cpu_map__is_dummy - Events associated with a pid, rather than a CPU, use a single dummy map with an entry of -1.
>   */
> -static inline bool cpu_map__is_dummy(struct perf_cpu_map *cpus)
> +static inline bool cpu_map__is_dummy(const struct perf_cpu_map *cpus)
>  {
>  	return perf_cpu_map__nr(cpus) == 1 && perf_cpu_map__cpu(cpus, 0).cpu == -1;
>  }
> diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
> index 57f02beef023..db3f5fbdebe1 100644
> --- a/tools/perf/util/evlist-hybrid.c
> +++ b/tools/perf/util/evlist-hybrid.c
> @@ -86,77 +86,3 @@ bool evlist__has_hybrid(struct evlist *evlist)
>  
>  	return false;
>  }
> -
> -int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
> -{
> -	struct perf_cpu_map *cpus;
> -	struct evsel *evsel, *tmp;
> -	struct perf_pmu *pmu;
> -	int ret, unmatched_count = 0, events_nr = 0;
> -
> -	if (!perf_pmu__has_hybrid() || !cpu_list)
> -		return 0;
> -
> -	cpus = perf_cpu_map__new(cpu_list);
> -	if (!cpus)
> -		return -1;
> -
> -	/*
> -	 * The evsels are created with hybrid pmu's cpus. But now we
> -	 * need to check and adjust the cpus of evsel by cpu_list because
> -	 * cpu_list may cause conflicts with cpus of evsel. For example,
> -	 * cpus of evsel is cpu0-7, but the cpu_list is cpu6-8, we need
> -	 * to adjust the cpus of evsel to cpu6-7. And then propatate maps
> -	 * in evlist__create_maps().
> -	 */
> -	evlist__for_each_entry_safe(evlist, tmp, evsel) {
> -		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> -		char buf1[128], buf2[128];
> -
> -		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> -		if (!pmu)
> -			continue;
> -
> -		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
> -					   &unmatched_cpus);
> -		if (ret)
> -			goto out;
> -
> -		events_nr++;
> -
> -		if (perf_cpu_map__nr(matched_cpus) > 0 &&
> -		    (perf_cpu_map__nr(unmatched_cpus) > 0 ||
> -		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(cpus) ||
> -		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(pmu->cpus))) {
> -			perf_cpu_map__put(evsel->core.cpus);
> -			perf_cpu_map__put(evsel->core.own_cpus);
> -			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
> -			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
> -
> -			if (perf_cpu_map__nr(unmatched_cpus) > 0) {
> -				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
> -				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
> -					   buf1, pmu->name, evsel->name);
> -			}
> -		}
> -
> -		if (perf_cpu_map__nr(matched_cpus) == 0) {
> -			evlist__remove(evlist, evsel);
> -			evsel__delete(evsel);
> -
> -			cpu_map__snprint(cpus, buf1, sizeof(buf1));
> -			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
> -			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
> -				   buf1, pmu->name, pmu->name, buf2);
> -			unmatched_count++;
> -		}
> -
> -		perf_cpu_map__put(matched_cpus);
> -		perf_cpu_map__put(unmatched_cpus);
> -	}
> -	if (events_nr)
> -		ret = (unmatched_count == events_nr) ? -1 : 0;
> -out:
> -	perf_cpu_map__put(cpus);
> -	return ret;
> -}
> diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
> index aacdb1b0f948..19f74b4c340a 100644
> --- a/tools/perf/util/evlist-hybrid.h
> +++ b/tools/perf/util/evlist-hybrid.h
> @@ -10,6 +10,5 @@
>  int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
>  void evlist__warn_hybrid_group(struct evlist *evlist);
>  bool evlist__has_hybrid(struct evlist *evlist);
> -int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list);
>  
>  #endif /* __PERF_EVLIST_HYBRID_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a0504316b06f..5d0d99127a90 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2465,3 +2465,47 @@ void evlist__check_mem_load_aux(struct evlist *evlist)
>  		}
>  	}
>  }
> +
> +/**
> + * evlist__warn_user_requested_cpus() - Check each evsel against requested CPUs
> + *     and warn if the user CPU list is inapplicable for the event's PMUs
> + *     CPUs. Uncore PMUs list a CPU in sysfs, but this may be overwritten by a
> + *     user requested CPU and so any online CPU is applicable. Core PMUs handle
> + *     events on the CPUs in their list and otherwise the event isn't supported.
> + * @evlist: The list of events being checked.
> + * @cpu_list: The user provided list of CPUs.
> + */
> +void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list)
> +{
> +	struct perf_cpu_map *user_requested_cpus;
> +	struct evsel *pos;
> +
> +	if (!cpu_list)
> +		return;
> +
> +	user_requested_cpus = perf_cpu_map__new(cpu_list);
> +	if (!user_requested_cpus)
> +		return;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		const struct perf_cpu_map *to_test;
> +		struct perf_cpu cpu;
> +		int idx;
> +		bool warn = true;
> +		const struct perf_pmu *pmu = evsel__find_pmu(pos);
> +
> +		to_test = pmu && pmu->is_uncore ? cpu_map__online() : evsel__cpus(pos);
> +
> +		perf_cpu_map__for_each_cpu(cpu, idx, to_test) {
> +			if (perf_cpu_map__has(user_requested_cpus, cpu)) {
> +				warn = false;
> +				break;
> +			}
> +		}
> +		if (warn) {
> +			pr_warning("WARNING: Requested CPU(s) '%s' not supported by PMU '%s' for event '%s'\n",
> +				cpu_list, pmu ? pmu->name : "cpu", evsel__name(pos));
> +		}
> +	}
> +	perf_cpu_map__put(user_requested_cpus);
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e7e5540cc970..5e7ff44f3043 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -447,4 +447,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
>  
>  int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
>  void evlist__check_mem_load_aux(struct evlist *evlist);
> +void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
> +
>  #endif /* __PERF_EVLIST_H */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f4f0afbc391c..1e0be23d4dd7 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2038,39 +2038,6 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
>  	return 0;
>  }
>  
> -int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
> -			 struct perf_cpu_map **mcpus_ptr,
> -			 struct perf_cpu_map **ucpus_ptr)
> -{
> -	struct perf_cpu_map *pmu_cpus = pmu->cpus;
> -	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> -	struct perf_cpu cpu;
> -	int i, matched_nr = 0, unmatched_nr = 0;
> -
> -	matched_cpus = perf_cpu_map__default_new();
> -	if (!matched_cpus)
> -		return -1;
> -
> -	unmatched_cpus = perf_cpu_map__default_new();
> -	if (!unmatched_cpus) {
> -		perf_cpu_map__put(matched_cpus);
> -		return -1;
> -	}
> -
> -	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
> -		if (!perf_cpu_map__has(pmu_cpus, cpu))
> -			RC_CHK_ACCESS(unmatched_cpus)->map[unmatched_nr++] = cpu;
> -		else
> -			RC_CHK_ACCESS(matched_cpus)->map[matched_nr++] = cpu;
> -	}
> -
> -	perf_cpu_map__set_nr(unmatched_cpus, unmatched_nr);
> -	perf_cpu_map__set_nr(matched_cpus, matched_nr);
> -	*mcpus_ptr = matched_cpus;
> -	*ucpus_ptr = unmatched_cpus;
> -	return 0;
> -}
> -
>  double __weak perf_pmu__cpu_slots_per_cycle(void)
>  {
>  	return NAN;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 0e0cb6283594..49033bb134f3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -257,10 +257,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
>  bool perf_pmu__has_hybrid(void);
>  int perf_pmu__match(char *pattern, char *name, char *tok);
>  
> -int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
> -			 struct perf_cpu_map **mcpus_ptr,
> -			 struct perf_cpu_map **ucpus_ptr);
> -
>  char *pmu_find_real_name(const char *name);
>  char *pmu_find_alias_name(const char *name);
>  double perf_pmu__cpu_slots_per_cycle(void);
