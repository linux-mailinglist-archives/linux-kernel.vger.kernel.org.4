Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D946B3761
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCJHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCJHb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:31:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7D1086B4;
        Thu,  9 Mar 2023 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678433465; x=1709969465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ues8K1rbbmSbV4giJMVOoYdWCIi5U3vegUW4qxbAD1E=;
  b=QGnUvb0PsuVGPCFSYTZIMRIdHhKumSdSX5Dj/OdN5MnsEy8GROB4b+Sc
   73c5PcXBo9LPt/p1gRp2hdqmrhVBGp/IUOZdHW+Cwv/hz+rhqpYqp6BMl
   qq+6/T+4Ip5xKTRqkw73GR7lwcdaIxsUT90oGcWYKAHwz0YrgBHGB1Vdx
   LJ01cuy7V4jAwBcEOJUdWcSo0UaJmaziEiaPcgWLWeS97h/UR1tg3uOSQ
   kB1yUNqfsfggBXTODY1OMLkQNnMWNFRNGTobn36m124Beg1grzOyCFY4G
   XW344S/xpOkDlaxEBiRomuhvOsGHbX3bizpq7gQ5yY7eJNDAmw/GxKjhF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422935886"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="422935886"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923562872"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923562872"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:30:34 -0800
Message-ID: <4d99fb75-d1f2-49a6-aed3-d4b0848201ca@intel.com>
Date:   Fri, 10 Mar 2023 09:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 03/11] perf pmu: Earlier PMU auxtrace initialization
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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
References: <20230308225912.1960990-1-irogers@google.com>
 <20230308225912.1960990-4-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230308225912.1960990-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/03/23 00:59, Ian Rogers wrote:
> This allows event parsing to use the evsel__is_aux_event function,
> which is important when determining event grouping.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thank you!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/auxtrace.c | 4 ----
>  tools/perf/arch/x86/util/pmu.c      | 8 ++++++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
> index 3da506e13f49..330d03216b0e 100644
> --- a/tools/perf/arch/x86/util/auxtrace.c
> +++ b/tools/perf/arch/x86/util/auxtrace.c
> @@ -26,11 +26,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
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
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 358340b34243..f73b80dcd8bd 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -27,10 +27,14 @@ static bool cached_list;
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>  {
>  #ifdef HAVE_AUXTRACE_SUPPORT
> -	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
> +	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
> +		pmu->auxtrace = true;
>  		return intel_pt_pmu_default_config(pmu);
> -	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
> +	}
> +	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
> +		pmu->auxtrace = true;
>  		pmu->selectable = true;
> +	}
>  #endif
>  	return NULL;
>  }

