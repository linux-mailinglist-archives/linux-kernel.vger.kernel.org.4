Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31CC6B1317
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCHUcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:32:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7888C8582;
        Wed,  8 Mar 2023 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678307559; x=1709843559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W7+FDmb405aioLscUiv7KZXsXPW1dsNQijchURHTe3k=;
  b=IG7+K18LcyQDNpl52zTCuRhJu2dWcoUBVPKPTPXkBIll2Mx1v/WY8Jx1
   X885yDz4l7Ncy40ZwePRqsCMpJ59HYJpuitgp5WlCD3+6yweRoHvM8Jk9
   1p29VP3g1Iwnwk+3rkF8EQjfB3TIM1NaweDdoSCCGznKziuGL8q/8Wteq
   M6Xm1ZfFqg4gxrdMjbPpGiBfMEv0xPPdKLvXWb+VKqXvl2XqAgpVEFmPN
   /rX9hmGT6wBJSAqtkaDcFul2sQzvh8W40ps114k1JsuBZDCl0FjHQ/qng
   GQj3Vokid5PyupqrPxKkCDdZ71h86NpGu2oURlC5XhgOHgG1RGgQeBMn+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="336283633"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="336283633"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 12:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820362733"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="820362733"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2023 12:32:36 -0800
Received: from [10.209.73.193] (kliang2-mobl1.ccr.corp.intel.com [10.209.73.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6D53E580377;
        Wed,  8 Mar 2023 12:32:33 -0800 (PST)
Message-ID: <a39b7055-3fde-b351-89af-525d4f5ccee6@linux.intel.com>
Date:   Wed, 8 Mar 2023 15:32:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 03/11] perf record: Early auxtrace initialization
 before event parsing
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20230308081731.1887278-1-irogers@google.com>
 <20230308081731.1887278-4-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230308081731.1887278-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-08 3:17 a.m., Ian Rogers wrote:
> This allows event parsing to use the evsel__is_aux_event function,
> which is important when determining event grouping.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
>  tools/perf/builtin-record.c         |  6 ++++++
>  tools/perf/util/auxtrace.h          |  2 ++
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
> index 3da506e13f49..de1e4842ea2e 100644
> --- a/tools/perf/arch/x86/util/auxtrace.c
> +++ b/tools/perf/arch/x86/util/auxtrace.c
> @@ -15,6 +15,19 @@
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/evlist.h"
>  
> +void auxtrace__early_init(void)
> +{
> +	struct perf_pmu *intel_pt_pmu;
> +	struct perf_pmu *intel_bts_pmu;
> +
> +	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
> +	if (intel_pt_pmu)
> +		intel_pt_pmu->auxtrace = true;
> +	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
> +	if (intel_bts_pmu)
> +		intel_bts_pmu->auxtrace = true;
> +}
> +
>  static
>  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>  						    int *err)
> @@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>  	bool found_bts = false;
>  
>  	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
> -	if (intel_pt_pmu)
> -		intel_pt_pmu->auxtrace = true;
>  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
> -	if (intel_bts_pmu)
> -		intel_bts_pmu->auxtrace = true;
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8374117e66f6..a0870c076dc0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
>  	return ret;
>  }
>  
> +__weak void auxtrace__early_init(void)
> +{
> +}
> +

Does the method which Adrian suggested work for you?

https://lore.kernel.org/lkml/9788f0f1-087f-7f0b-048a-0146afe1f632@intel.com/

With that, we don't need to introduce another weak function.

Thanks,
Kan


>  int cmd_record(int argc, const char **argv)
>  {
>  	int err;
> @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>  	if (err)
>  		return err;
>  
> +	auxtrace__early_init();
> +
>  	argc = parse_options(argc, argv, record_options, record_usage,
>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>  	if (quiet)
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 29eb82dff574..49a86aa6ac94 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -457,6 +457,8 @@ struct addr_filters {
>  
>  struct auxtrace_cache;
>  
> +void auxtrace__early_init(void);
> +
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  
>  u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
