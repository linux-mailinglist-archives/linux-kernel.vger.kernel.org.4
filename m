Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916096A8437
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCBOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:32:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76F3A88;
        Thu,  2 Mar 2023 06:32:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99AD7615D4;
        Thu,  2 Mar 2023 14:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98650C433EF;
        Thu,  2 Mar 2023 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767570;
        bh=4kWn2IUOqTgbuPNR7J4g0aISgONkKWz1waYvnH8empk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkkIEyq0IRXUm4Vrc0c7Kh9DKTxUvUemhN6YlRmM6E4OclRg3z3vuklxMRcZ3jxg2
         AThhMXlTnOohw04BC+gKnTf92taSteFgy5JdPF+U0j/KBiWgXShmPjekpVz70JG4/N
         pssmglc7IBnJ5tQ/ot+Vv7WrxRA8VPSaKkQihEZb6cIj/YvTgbFswNQQI3xxzA/H0x
         AhnGmab+mpSxX7AfllzWg8bnvU9agleWXloyGxI78EQ8pJS7bB/i6wRmBpBDSEfdfW
         No0unzTjL54P8HtijPCNyJThUCekfVZdBEeTf65vhXzNKBaKnfDmo/kqDfI0pLjyZ9
         4nSf16QZWDMVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E7E54049F; Thu,  2 Mar 2023 11:32:48 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:32:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 03/10] perf record: Early auxtrace initialization
 before event parsing
Message-ID: <ZACzkOmDFuRQ5MiR@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:04PM -0800, Ian Rogers escreveu:
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

In this case, can't we do it as:

	if (intel_pt_pmu == NULL && intel_bts_pmu == NULL)
		auxtrace__early_init();

To avoid possibly doing the finds again?

- Arnaldo

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
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
