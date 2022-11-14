Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40206277D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiKNIgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiKNIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:36:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CAC1C114;
        Mon, 14 Nov 2022 00:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668414961; x=1699950961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fdpZZ4r1hTVkoO3kGE4DlZQf60aaP2bmV66mBFHDQ/U=;
  b=C2Wg0o2p64l9epkj4axYH6U+R/sMR/Du/H79RR1+XV7jxrn/V+dK5TL4
   +XlL1RyOmLSpy2K/5o/FBAJd4vDn5/IDArmo0LyEwCNdMPEMjNiFZ67b7
   KFY3Asrw+q01CbnV7BGS0eDdYle87O6AGv+WRKz3x9L7NrCRNhJo8saUA
   iWyYVU7v9iFcSpJwDQ7ajNvlfOa4oHXI+hhWtjQeReX91Hl0OrVjvzFUs
   uh/stjv8jfHBKK5DICrzCYZYORd5CgWAWi2h0VSPC4I1bc6iujbxDXJ+A
   5YV2gkDLofyLkjn16G7LXMluPiLXZVsOOKMziu9mhnZ9BXg526AQK7eTG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="295277104"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="295277104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:36:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="967483826"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967483826"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.254.211.184]) ([10.254.211.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:35:56 -0800
Message-ID: <b39171e6-4af3-6102-2207-aad57dc92226@linux.intel.com>
Date:   Mon, 14 Nov 2022 16:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 3/6] perf vendor events arm64: Add cache metrics
 for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <1668411720-3581-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2022 3:41 PM, Jing Zhang wrote:
> Add cache related metrics.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   .../arch/arm64/arm/neoverse-n2/metrics.json        | 77 ++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> index 324ca12..1690ef6 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -54,5 +54,82 @@
>           "BriefDescription": "The rate of DTLB Walks to the overall TLB lookups",
>           "MetricGroup": "TLB",
>           "MetricName": "dtlb_walk_rate"
> +    },
> +    {
> +        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
> +        "PublicDescription": "The rate of L1 I-Cache misses per kilo instructions",
> +        "BriefDescription": "The rate of L1 I-Cache misses per kilo instructions",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l1i_cache_mpki"
> +    },
> +    {
> +        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
> +        "PublicDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
> +        "BriefDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l1i_cache_miss_rate"
> +    },
> +    {
> +        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "PublicDescription": "The rate of L1 D-Cache misses per kilo instructions",
> +        "BriefDescription": "The rate of L1 D-Cache misses per kilo instructions",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l1d_cache_mpki"
> +    },
> +    {
> +        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
> +        "PublicDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
> +        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l1d_cache_miss_rate"
> +    },
> +    {
> +        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "PublicDescription": "The rate of L2 D-Cache misses per kilo instructions",
> +        "BriefDescription": "The rate of L2 D-Cache misses per kilo instructions",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l2d_cache_mpki"
> +    },
> +    {
> +        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
> +        "PublicDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
> +        "BriefDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l2d_cache_miss_rate"
> +    },
> +    {
> +        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "PublicDescription": "The rate of L3 D-Cache misses per kilo instructions",
> +        "BriefDescription": "The rate of L3 D-Cache misses per kilo instructions",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l3d_cache_mpki"
> +    },
> +    {
> +        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
> +        "PublicDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
> +        "BriefDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
> +        "MetricGroup": "Cache",
> +        "MetricName": "l3d_cache_miss_rate"
> +    },
> +    {
> +        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
> +        "PublicDescription": "The rate of LL Cache read misses per kilo instructions",
> +        "BriefDescription": "The rate of LL Cache read misses per kilo instructions",
> +        "MetricGroup": "Cache",
> +        "MetricName": "ll_cache_read_mpki"
> +    },
> +    {
> +        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
> +        "PublicDescription": "The rate of LL Cache read misses to the overall LL Cache read",
> +        "BriefDescription": "The rate of LL Cache read misses to the overall LL Cache read",
> +        "MetricGroup": "Cache",
> +        "MetricName": "ll_cache_read_miss_rate"
> +    },
> +    {
> +        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
> +        "PublicDescription": "The rate of LL Cache read hit to the overall LL Cache read",
> +        "BriefDescription": "The rate of LL Cache read hit to the overall LL Cache read",
> +        "MetricGroup": "Cache",
> +        "MetricName": "ll_cache_read_hit_rate"
>       }
>   ]
> \ No newline at end of file

It is better to fix this by adding a newline at the end of the file.

-- 
Zhengjun Xing
