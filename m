Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14436F0CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjD0UCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0UCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:02:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB9359D;
        Thu, 27 Apr 2023 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625757; x=1714161757;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9e4/YqMXyoBnn1jPIF7cYj7Exl/lR9jrAZBauXk1HN8=;
  b=eB/amGSgabBKJJyyO6hFA/V6Ab6oW7JrQLWKyCDesqf15rz6EbAA5NLK
   hoQx3iIyouRJOy64PRv/Sc0tUAFfImxjl2ut1Fh4i4pXebWTMt1qe46TM
   4W3aswF6G4t3oS1osocTlYV5HD5CVn4F/g6XC5y/pEPihSJ/30kLvu2s7
   /FKRHMhL/HZ5KpPQiw6yHJKkE9/aBZhxLJRYmXXr64YIjN02aUeVcFB6O
   JG1jiYAl+Qnz6Y95r4Lsg61KcYldi340F0nJxjTfe9X59fcWHx35P2LH+
   FP7i6ErbbwrZEyxiXNBYXVGRMwy/KyE6MC6p/Kha+3hCyZColi4Q2kBPr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410616712"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410616712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 13:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="759294092"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="759294092"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2023 13:01:23 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AC75A580CD0;
        Thu, 27 Apr 2023 13:01:19 -0700 (PDT)
Message-ID: <528dd99d-6a2f-8b10-e3e3-21f682ab9101@linux.intel.com>
Date:   Thu, 27 Apr 2023 16:01:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 14/40] perf print-events: Avoid unnecessary strlist
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
References: <20230426070050.1315519-1-irogers@google.com>
 <20230426070050.1315519-15-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-15-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> The strlist in print_hwcache_events holds the event names as they are
> generated, and then it is iterated and printed. This is unnecessary
> and each event can just be printed as it is processed.
> Rename the variable i to res, to be more intention revealing and
> consistent with other code.
> 

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Signed-off-by: Ian Rogers <irogers@google.com>> ---
>  tools/perf/util/print-events.c | 60 ++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 386b1ab0b60e..93bbb868d400 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -226,58 +226,60 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
>  
>  int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
>  {
> -	struct strlist *evt_name_list = strlist__new(NULL, NULL);
> -	struct str_node *nd;
> +	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
>  
> -	if (!evt_name_list) {
> -		pr_debug("Failed to allocate new strlist for hwcache events\n");
> -		return -ENOMEM;
> -	}
>  	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
>  		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
>  			/* skip invalid cache type */
>  			if (!evsel__is_cache_op_valid(type, op))
>  				continue;
>  
> -			for (int i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
> +			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
>  				struct perf_pmu *pmu = NULL;
>  				char name[64];
>  
> -				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
> +				__evsel__hw_cache_type_op_res_name(type, op, res,
> +								   name, sizeof(name));
>  				if (!perf_pmu__has_hybrid()) {
>  					if (is_event_supported(PERF_TYPE_HW_CACHE,
> -							       type | (op << 8) | (i << 16)))
> -						strlist__add(evt_name_list, name);
> +								type | (op << 8) | (res << 16))) {
> +						print_cb->print_event(print_state,
> +								"cache",
> +								/*pmu_name=*/NULL,
> +								name,
> +								/*event_alias=*/NULL,
> +								/*scale_unit=*/NULL,
> +								/*deprecated=*/false,
> +								event_type_descriptor,
> +								/*desc=*/NULL,
> +								/*long_desc=*/NULL,
> +								/*encoding_desc=*/NULL);
> +					}
>  					continue;
>  				}
>  				perf_pmu__for_each_hybrid_pmu(pmu) {
>  					if (is_event_supported(PERF_TYPE_HW_CACHE,
> -					    type | (op << 8) | (i << 16) |
> +					    type | (op << 8) | (res << 16) |
>  					    ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT))) {
>  						char new_name[128];
> -							snprintf(new_name, sizeof(new_name),
> -								 "%s/%s/", pmu->name, name);
> -							strlist__add(evt_name_list, new_name);
> +						snprintf(new_name, sizeof(new_name),
> +							"%s/%s/", pmu->name, name);
> +						print_cb->print_event(print_state,
> +								"cache",
> +								pmu->name,
> +								name,
> +								new_name,
> +								/*scale_unit=*/NULL,
> +								/*deprecated=*/false,
> +								event_type_descriptor,
> +								/*desc=*/NULL,
> +								/*long_desc=*/NULL,
> +								/*encoding_desc=*/NULL);
>  					}
>  				}
>  			}
>  		}
>  	}
> -
> -	strlist__for_each_entry(nd, evt_name_list) {
> -		print_cb->print_event(print_state,
> -				"cache",
> -				/*pmu_name=*/NULL,
> -				nd->s,
> -				/*event_alias=*/NULL,
> -				/*scale_unit=*/NULL,
> -				/*deprecated=*/false,
> -				event_type_descriptors[PERF_TYPE_HW_CACHE],
> -				/*desc=*/NULL,
> -				/*long_desc=*/NULL,
> -				/*encoding_desc=*/NULL);
> -	}
> -	strlist__delete(evt_name_list);
>  	return 0;
>  }
>  
