Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79E16A9BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCCQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCCQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:40:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45628206;
        Fri,  3 Mar 2023 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677861614; x=1709397614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qFuP52u/hk29+iJGCaH/iY8OktY9rmftf25HJ4x/aDs=;
  b=P7voRbGjTApfBgjtNlBlcXjbDYOkUuWlIcDWa2r5+xNpK9MN9Qf10jR2
   RmHqXPoKkdTvLv4VCICmTHK9rbC9z2nEDGg1lKNUwyhaiyEanXkWig+MP
   sPVh3MwiY7km675Qou8tZUd/IlLRXHG7aQZ4OcDeRpsuzqsg9SsSCz8Ep
   XktbUuiX8Axhxc1ZLa668jrWct+69Utm+hZ2/sfD8eqhfl9YlMQrrNFUk
   N7RHBzdRO2BAGoJIXs14N944skIBLQ377upNnTl6nCdIMR4vBq+8kfATi
   wL9a9kgWNzWnyagu9CfYu+qOdoHyPn1OLp1P59TBR1C7T2+1S1BM/H/z9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="318911453"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="318911453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 08:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818531170"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="818531170"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2023 08:40:12 -0800
Received: from [10.212.168.11] (kliang2-mobl1.ccr.corp.intel.com [10.212.168.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B3325580689;
        Fri,  3 Mar 2023 08:40:09 -0800 (PST)
Message-ID: <2aed81ff-2d28-3af5-0657-16ee69705c03@linux.intel.com>
Date:   Fri, 3 Mar 2023 11:40:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/10] perf record: Early auxtrace initialization
 before event parsing
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
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
References: <20230302212531.1043318-1-irogers@google.com>
 <20230302212531.1043318-4-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230302212531.1043318-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-02 4:25 p.m., Ian Rogers wrote:
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
>  int cmd_record(int argc, const char **argv)
>  {
>  	int err;
> @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>  	if (err)
>  		return err;
>  
> +	auxtrace__early_init();

So the auxtrace__early_init() will be unconditionally invoked even there
is no PT or BTS events, right?

Maybe we should move the auxtrace__early_init() to evsel__is_aux_event()
and cache the value. The initialization will only be invoked when it's
required.
Something as below (not tested.)

+void auxtrace__init(void)
+{
+	struct perf_pmu *intel_pt_pmu;
+	struct perf_pmu *intel_bts_pmu;
+	static bool cached;
+
+	if (cached)
+		return;
+	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
+	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
+}

bool evsel__is_aux_event(struct evsel *evsel)
{
	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+	auxtrace__init();
	return pmu && pmu->auxtrace;
}



Thanks,
Kan

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
