Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31470AFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEUTMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEUTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:12:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A4CF;
        Sun, 21 May 2023 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684696356; x=1716232356;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ChPVyakJI93U5nM7CZQnTqmHdtFSHX5KNrTe71+bd2Y=;
  b=alykwC1cfC72a6Lb9dz38i3BARpn3BlmlSiy6ghyHGodY6lbUx85DZjo
   oJeRA2NYx7WDFJ0A2Nk7gp+V3dqgQDdPX3fMTKsZGNMpi40pdao8SipaI
   kY2+2b7ZaQ329HlFACHYULbm2jh01AOeWNbiK/MJMJzm0B6ypwJiulWYj
   Y9SPAirNrx4cq6epDhlAyEGmXG5MUMowOeunb1XJ/p24T0lAUtnBABgXW
   hPlU+UO/98VaiMEblaYSHvqp/dzJk1QJqTXNZGX1zrkJ4MoRJxyVqWu5Y
   PZj6miq3Vf/CXR0YMNsay+Ns1FKl2PT5NBldQro93vreqMlvK1I1jdnas
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="355974491"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="355974491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 12:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="653698723"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="653698723"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2023 12:12:36 -0700
Received: from [10.212.161.251] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7A857580ABD;
        Sun, 21 May 2023 12:12:31 -0700 (PDT)
Message-ID: <ba6ab7b6-4ce0-2f07-2b8b-a4373d96c742@linux.intel.com>
Date:   Sun, 21 May 2023 15:12:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 03/23] perf evlist: Remove __evlist__add_default
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
 <20230517145803.559429-4-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517145803.559429-4-irogers@google.com>
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
> __evlist__add_default adds a cycles event to a typically empty evlist
> and was extended for hybrid with evlist__add_default_hybrid, as more
> than 1 PMU was necessary. Rather than have dedicated logic for the
> cycles event, this change switches to parsing 'cycles' which will
> handle wildcarding the PMUs appropriately for hybrid.

I think the default event for the perf record was cycles:P, but this
patch changes the default event to cycles. I think it's better to use
cycles:P which is more accurate.

Thanks,
Kan

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 20 --------------
>  tools/perf/builtin-record.c      | 13 +++------
>  tools/perf/builtin-top.c         | 10 ++++---
>  tools/perf/util/evlist-hybrid.c  | 25 -----------------
>  tools/perf/util/evlist-hybrid.h  |  1 -
>  tools/perf/util/evlist.c         | 22 ++++++---------
>  tools/perf/util/evlist.h         |  7 -----
>  tools/perf/util/evsel.c          | 46 --------------------------------
>  tools/perf/util/evsel.h          |  3 ---
>  9 files changed, 17 insertions(+), 130 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ea3972d785d1..153cdca94cd4 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -16,26 +16,6 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
>  	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>  }
>  
> -void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
> -{
> -	struct perf_env env = { .total_mem = 0, } ;
> -
> -	if (!perf_env__cpuid(&env))
> -		return;
> -
> -	/*
> -	 * On AMD, precise cycles event sampling internally uses IBS pmu.
> -	 * But IBS does not have filtering capabilities and perf by default
> -	 * sets exclude_guest = 1. This makes IBS pmu event init fail and
> -	 * thus perf ends up doing non-precise sampling. Avoid it by clearing
> -	 * exclude_guest.
> -	 */
> -	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
> -		attr->exclude_guest = 0;
> -
> -	free(env.cpuid);
> -}
> -
>  /* Check whether the evsel's PMU supports the perf metrics */
>  bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>  {
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9d212236c75a..85f2bd035a94 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4161,18 +4161,11 @@ int cmd_record(int argc, const char **argv)
>  		record.opts.tail_synthesize = true;
>  
>  	if (rec->evlist->core.nr_entries == 0) {
> -		if (perf_pmu__has_hybrid()) {
> -			err = evlist__add_default_hybrid(rec->evlist,
> -							 !record.opts.no_samples);
> -		} else {
> -			err = __evlist__add_default(rec->evlist,
> -						    !record.opts.no_samples);
> -		}
> +		bool can_profile_kernel = perf_event_paranoid_check(1);
>  
> -		if (err < 0) {
> -			pr_err("Not enough memory for event selector list\n");
> +		err = parse_event(rec->evlist, can_profile_kernel ? "cycles" : "cycles:u");
> +		if (err)
>  			goto out;
> -		}
>  	}
>  
>  	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 48ee49e95c5e..d1e6d23bee3e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1653,10 +1653,12 @@ int cmd_top(int argc, const char **argv)
>  	if (annotate_check_args(&top.annotation_opts) < 0)
>  		goto out_delete_evlist;
>  
> -	if (!top.evlist->core.nr_entries &&
> -	    evlist__add_default(top.evlist) < 0) {
> -		pr_err("Not enough memory for event selector list\n");
> -		goto out_delete_evlist;
> +	if (!top.evlist->core.nr_entries) {
> +		bool can_profile_kernel = perf_event_paranoid_check(1);
> +		int err = parse_event(top.evlist, can_profile_kernel ? "cycles" : "cycles:u");
> +
> +		if (err)
> +			goto out_delete_evlist;
>  	}
>  
>  	status = evswitch__init(&top.evswitch, top.evlist, stderr);
> diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
> index 0f59c80f27b2..64f78d06fe19 100644
> --- a/tools/perf/util/evlist-hybrid.c
> +++ b/tools/perf/util/evlist-hybrid.c
> @@ -16,31 +16,6 @@
>  #include <perf/evsel.h>
>  #include <perf/cpumap.h>
>  
> -int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
> -{
> -	struct evsel *evsel;
> -	struct perf_pmu *pmu;
> -	__u64 config;
> -	struct perf_cpu_map *cpus;
> -
> -	perf_pmu__for_each_hybrid_pmu(pmu) {
> -		config = PERF_COUNT_HW_CPU_CYCLES |
> -			 ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
> -		evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
> -					  config);
> -		if (!evsel)
> -			return -ENOMEM;
> -
> -		cpus = perf_cpu_map__get(pmu->cpus);
> -		evsel->core.cpus = cpus;
> -		evsel->core.own_cpus = perf_cpu_map__get(cpus);
> -		evsel->pmu_name = strdup(pmu->name);
> -		evlist__add(evlist, evsel);
> -	}
> -
> -	return 0;
> -}
> -
>  bool evlist__has_hybrid(struct evlist *evlist)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
> index 4b000eda6626..0cded76eb344 100644
> --- a/tools/perf/util/evlist-hybrid.h
> +++ b/tools/perf/util/evlist-hybrid.h
> @@ -7,7 +7,6 @@
>  #include "evlist.h"
>  #include <unistd.h>
>  
> -int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
>  bool evlist__has_hybrid(struct evlist *evlist);
>  
>  #endif /* __PERF_EVLIST_HYBRID_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 5d0d99127a90..b8ca99afdfe5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -93,8 +93,15 @@ struct evlist *evlist__new(void)
>  struct evlist *evlist__new_default(void)
>  {
>  	struct evlist *evlist = evlist__new();
> +	bool can_profile_kernel;
> +	int err;
> +
> +	if (!evlist)
> +		return NULL;
>  
> -	if (evlist && evlist__add_default(evlist)) {
> +	can_profile_kernel = perf_event_paranoid_check(1);
> +	err = parse_event(evlist, can_profile_kernel ? "cycles" : "cycles:u");
> +	if (err) {
>  		evlist__delete(evlist);
>  		evlist = NULL;
>  	}
> @@ -237,19 +244,6 @@ static void evlist__set_leader(struct evlist *evlist)
>  	perf_evlist__set_leader(&evlist->core);
>  }
>  
> -int __evlist__add_default(struct evlist *evlist, bool precise)
> -{
> -	struct evsel *evsel;
> -
> -	evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
> -				  PERF_COUNT_HW_CPU_CYCLES);
> -	if (evsel == NULL)
> -		return -ENOMEM;
> -
> -	evlist__add(evlist, evsel);
> -	return 0;
> -}
> -
>  static struct evsel *evlist__dummy_event(struct evlist *evlist)
>  {
>  	struct perf_event_attr attr = {
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5e7ff44f3043..664c6bf7b3e0 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -100,13 +100,6 @@ void evlist__delete(struct evlist *evlist);
>  void evlist__add(struct evlist *evlist, struct evsel *entry);
>  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
>  
> -int __evlist__add_default(struct evlist *evlist, bool precise);
> -
> -static inline int evlist__add_default(struct evlist *evlist)
> -{
> -	return __evlist__add_default(evlist, true);
> -}
> -
>  int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
>  
>  int __evlist__add_default_attrs(struct evlist *evlist,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2f5910b31fa9..b39615124672 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -316,48 +316,6 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
>  	return evsel;
>  }
>  
> -static bool perf_event_can_profile_kernel(void)
> -{
> -	return perf_event_paranoid_check(1);
> -}
> -
> -struct evsel *evsel__new_cycles(bool precise __maybe_unused, __u32 type, __u64 config)
> -{
> -	struct perf_event_attr attr = {
> -		.type	= type,
> -		.config	= config,
> -		.exclude_kernel	= !perf_event_can_profile_kernel(),
> -	};
> -	struct evsel *evsel;
> -
> -	event_attr_init(&attr);
> -
> -	/*
> -	 * Now let the usual logic to set up the perf_event_attr defaults
> -	 * to kick in when we return and before perf_evsel__open() is called.
> -	 */
> -	evsel = evsel__new(&attr);
> -	if (evsel == NULL)
> -		goto out;
> -
> -	arch_evsel__fixup_new_cycles(&evsel->core.attr);
> -
> -	evsel->precise_max = true;
> -
> -	/* use asprintf() because free(evsel) assumes name is allocated */
> -	if (asprintf(&evsel->name, "cycles%s%s%.*s",
> -		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
> -		     attr.exclude_kernel ? "u" : "",
> -		     attr.precise_ip ? attr.precise_ip + 1 : 0, "ppp") < 0)
> -		goto error_free;
> -out:
> -	return evsel;
> -error_free:
> -	evsel__delete(evsel);
> -	evsel = NULL;
> -	goto out;
> -}
> -
>  int copy_config_terms(struct list_head *dst, struct list_head *src)
>  {
>  	struct evsel_config_term *pos, *tmp;
> @@ -1130,10 +1088,6 @@ void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
>  	evsel__set_sample_bit(evsel, WEIGHT);
>  }
>  
> -void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_unused)
> -{
> -}
> -
>  void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
>  				    struct perf_event_attr *attr __maybe_unused)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index df8928745fc6..429b172cc94d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -243,8 +243,6 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
>  }
>  #endif
>  
> -struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
> -
>  #ifdef HAVE_LIBTRACEEVENT
>  struct tep_event *event_format__new(const char *sys, const char *name);
>  #endif
> @@ -312,7 +310,6 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
>  void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>  
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
> -void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
>  void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
>  
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
