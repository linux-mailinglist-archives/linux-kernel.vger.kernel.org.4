Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C59627823
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiKNIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKNIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:51:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36719C35;
        Mon, 14 Nov 2022 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668415888; x=1699951888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xFTYNBP+TcEy3dDL/kF6xEoY/vWH2jxHcttCdo+RdSg=;
  b=PSsQGYoKxMTwLQfmrxDc9OYL8M63IHfwHURc6kCiM6k4MxS9Qw+/jXjh
   96tc1zL4hYMJoyzDNKldQZCg1ZEZ/W96Me0YKlPiuWqlO4BPXrVDglSH1
   C48mqQXzBlFRSF7XACKsMJmA12tx8Gs5DnLa2F/eorFExn+3etFbOZ26K
   DmUGu0uqwqrsrKeTILPKfSyugEZDcw6yNO5oPv9TzmuIFxhrzsAaDpG8c
   4Yar/q7VKq+EQTqsPSDcB2I1qissYE15QVVjXUC7KdopgTn82yU4fhaCD
   myGAqmXw2scTqwCgKcJb3dETxPNrDzEtTBNZQRnK1p2nnGONDJjVT/CiO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="374046209"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="374046209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:51:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669562754"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669562754"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.254.211.184]) ([10.254.211.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:51:22 -0800
Message-ID: <63b7b6d5-f441-7ebc-fd3f-9d5f36d2938d@linux.intel.com>
Date:   Mon, 14 Nov 2022 16:51:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/9] perf list: Generalize limiting to a PMU name
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20221114075127.2650315-1-irogers@google.com>
 <20221114075127.2650315-5-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20221114075127.2650315-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2022 3:51 PM, Ian Rogers wrote:
> Deprecate the --cputype option and add a --unit option where '--unit
> cpu_atom' behaves like '--cputype atom'. The --unit option can be used
> with arbitrary PMUs, for example:
> 
> ```
> $ perf list --unit msr pmu
> 
> List of pre-defined events (to be used in -e or -M):
> 
>    msr/aperf/                                         [Kernel PMU event]
>    msr/cpu_thermal_margin/                            [Kernel PMU event]
>    msr/mperf/                                         [Kernel PMU event]
>    msr/pperf/                                         [Kernel PMU event]
>    msr/smi/                                           [Kernel PMU event]
>    msr/tsc/                                           [Kernel PMU event]
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/Documentation/perf-list.txt |  6 +++---
>   tools/perf/builtin-list.c              | 18 ++++++++++++------
>   tools/perf/util/metricgroup.c          |  3 ++-
>   tools/perf/util/pmu.c                  |  4 +---
>   4 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 57384a97c04f..44a819af573d 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -39,9 +39,9 @@ any extra expressions computed by perf stat.
>   --deprecated::
>   Print deprecated events. By default the deprecated events are hidden.
>   
> ---cputype::
> -Print events applying cpu with this type for hybrid platform
> -(e.g. --cputype core or --cputype atom)
> +--unit::
> +Print PMU events and metrics limited to the specific PMU name.
> +(e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
>   
>   [[EVENT_MODIFIERS]]
>   EVENT MODIFIERS
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 58e1ec1654ef..cc84ced6da26 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -21,7 +21,6 @@
>   
>   static bool desc_flag = true;
>   static bool details_flag;
> -static const char *hybrid_type;
>   
>   int cmd_list(int argc, const char **argv)
>   {
> @@ -30,6 +29,8 @@ int cmd_list(int argc, const char **argv)
>   	bool long_desc_flag = false;
>   	bool deprecated = false;
>   	char *pmu_name = NULL;
> +	const char *hybrid_name = NULL;
> +	const char *unit_name = NULL;
>   	struct option list_options[] = {
>   		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>   		OPT_BOOLEAN('d', "desc", &desc_flag,
> @@ -40,9 +41,10 @@ int cmd_list(int argc, const char **argv)
>   			    "Print information on the perf event names and expressions used internally by events."),
>   		OPT_BOOLEAN(0, "deprecated", &deprecated,
>   			    "Print deprecated events."),
> -		OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
> -			   "Print events applying cpu with this type for hybrid platform "
> -			   "(e.g. core or atom)"),
> +		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> +			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
> +		OPT_STRING(0, "unit", &unit_name, "PMU name",
> +			   "Limit PMU or metric printing to the specified PMU."),
>   		OPT_INCR(0, "debug", &verbose,
>   			     "Enable debugging output"),
>   		OPT_END()
> @@ -53,6 +55,8 @@ int cmd_list(int argc, const char **argv)
>   	};
>   
>   	set_option_flag(list_options, 0, "raw-dump", PARSE_OPT_HIDDEN);
> +	/* Hide hybrid flag for the more generic 'unit' flag. */
> +	set_option_flag(list_options, 0, "cputype", PARSE_OPT_HIDDEN);
>   
>   	argc = parse_options(argc, argv, list_options, list_usage,
>   			     PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -62,8 +66,10 @@ int cmd_list(int argc, const char **argv)
>   	if (!raw_dump && pager_in_use())
>   		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
>   
> -	if (hybrid_type) {
> -		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
> +	if (unit_name)
> +		pmu_name = strdup(unit_name);
> +	else if (hybrid_name) {
> +		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_name);
>   		if (!pmu_name)
>   			pr_warning("WARNING: hybrid cputype is not supported!\n");
>   	}
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4c98ac29ee13..1943fed9b6d9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -556,11 +556,12 @@ static int metricgroup__print_callback(const struct pmu_event *pe,
>   				       void *vdata)
>   {
>   	struct metricgroup_print_data *data = vdata;
> +	const char *pmu = pe->pmu ?: "cpu";
>   
>   	if (!pe->metric_expr)
>   		return 0;
>   
> -	if (data->pmu_name && perf_pmu__is_hybrid(pe->pmu) && strcmp(data->pmu_name, pe->pmu))
> +	if (data->pmu_name && strcmp(data->pmu_name, pmu))
>   		return 0;
>   
>   	return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a8f9f47c6ed9..9c771f136b81 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1694,10 +1694,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>   	pmu = NULL;
>   	j = 0;
>   	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> -		if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
> -		    strcmp(pmu_name, pmu->name)) {
> +		if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))

Why remove perf_pmu__is_hybrid check?

>   			continue;
> -		}
>   
>   		list_for_each_entry(alias, &pmu->aliases, list) {
>   			char *name = alias->desc ? alias->name :

-- 
Zhengjun Xing
