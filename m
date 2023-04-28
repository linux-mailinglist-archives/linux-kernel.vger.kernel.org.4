Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D146F198D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjD1Nbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346198AbjD1Nbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:31:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357191FF5;
        Fri, 28 Apr 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682688697; x=1714224697;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JKJX8OIwrYW1IiYZfvoJYOgISllpu9BWAtbOG2WofMo=;
  b=KVx7UxRFguLBhtG/cUxW5TtNfcw7ArSGJ6i++kHrOy/fCxKCXOyKx6hC
   i06eDlCiMcIbpzG4yfZXFKJk9JHEomKetEYW9nFYR0GpopYb99K3ZgsjQ
   qlZjF4mPND9J0OFjQdAaGZ84wwNexYaOAyTKC42LOg3I4zu/xTNhWFPWo
   OnLq8nrsiuD8+WJjSZvu6sWAmy5piq0lNA2/saE86o3HxJxXE5O0WkBLr
   QNkXL7snXpxi4ATQiol2VCwV7ncfrpIUizuNyKkZsfFF4xA77GDAu4pVv
   wypRwuKtSC25lkgSx2FXcTSUp75Z7txJM8iJytHPayBZRlC7tpdLPMvAt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="410845727"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="410845727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 06:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="764281486"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764281486"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 06:31:35 -0700
Received: from [10.212.155.101] (kliang2-mobl1.ccr.corp.intel.com [10.212.155.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9105A580A5D;
        Fri, 28 Apr 2023 06:31:31 -0700 (PDT)
Message-ID: <920c682a-3789-51fb-805e-4561c85f4219@linux.intel.com>
Date:   Fri, 28 Apr 2023 09:31:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/43] perf stat: Disable TopdownL1 on hybrid
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
References: <20230428073809.1803624-1-irogers@google.com>
 <20230428073809.1803624-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230428073809.1803624-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-28 3:37 a.m., Ian Rogers wrote:
> Bugs with event parsing, event grouping and metrics causes the
> TopdownL1 metricgroup to crash the perf command. Temporarily disable
> the group if no events/metrics are spcecified.
> 

I think it's OK to only disable the metric for perf stat default
temporarily on hybrid as a workaround for 6.4.
Now, the only problem is the default of perf stat on pre-icl in 6.4.

> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Arnaldo, could you please back port this for 6.4 as well?

Thanks,
Kan
> ---
>  tools/perf/builtin-stat.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index efda63f6bf32..be9677aa642f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1885,7 +1885,12 @@ static int add_default_attributes(void)
>  		 * Add TopdownL1 metrics if they exist. To minimize
>  		 * multiplexing, don't request threshold computation.
>  		 */
> -		if (metricgroup__has_metric("TopdownL1") &&
> +		/*
> +		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
> +		 * caused by exposing latent bugs. This is fixed properly in:
> +		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> +		 */
> +		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid() &&
>  		    metricgroup__parse_groups(evsel_list, "TopdownL1",
>  					    /*metric_no_group=*/false,
>  					    /*metric_no_merge=*/false,
> @@ -1894,6 +1899,7 @@ static int add_default_attributes(void)
>  					    stat_config.system_wide,
>  					    &stat_config.metric_events) < 0)
>  			return -1;
> +
>  		/* Platform specific attrs */
>  		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
>  			return -1;
