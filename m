Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAE6FE35B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjEJRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjEJRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65835258;
        Wed, 10 May 2023 10:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E1B6321A;
        Wed, 10 May 2023 17:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA51CC433EF;
        Wed, 10 May 2023 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683740473;
        bh=7jyUz/5yrkPTUkgdmkl8e6tbTacmZS0y9mccVF474dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCayMgWr5t/J0iQmhB0w6bxRqi0ngobCSra6FcU5zz2A9DJIQjk1/XJM5bzq3nqem
         FNm7y6PZyPfb7iKJTVCRBPw6fEOcvu4kUgXPZ4VT5yD1S4ziFWs1W2hgX3P1MsoBxm
         nlBped8/7OvRNpk58ObNKPMUSQjv6SIDxr9pkv6B6h/XpuO0AFsIye+uXp8vZ3n0gw
         uZ27LfbvuS9rKHVH1DBC4XPFZKxQo8WscGrDUYb4PnDxRHIwmvYM8Wepcldy1Vhrbd
         DtTIjeqKcq+jwC/hbukVscmkhTtidX9roPpjExoLiBU7Vq2+2z4zoDOnR1pTEG3TDS
         OAuXhY/C+UwLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63EBE403B5; Wed, 10 May 2023 14:41:11 -0300 (-03)
Date:   Wed, 10 May 2023 14:41:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Fix contextid validation
Message-ID: <ZFvXN8uS+041W87u@kernel.org>
References: <20230504144822.1938717-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504144822.1938717-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 04, 2023 at 03:48:22PM +0100, James Clark escreveu:
> Pre 5.11 kernels don't support 'contextid1' and 'contextid2' so
> validation would be skipped. By adding an additional check for
> 'contextid', old kernels will still have validation done even though
> contextid would either be contextid1 or contextid2.
> 
> Additionally now that it's possible to override options, an existing bug
> in the validation is revealed. 'val' is overwritten by the contextid1
> validation, and re-used for contextid2 validation causing it to always
> fail. '!val || val != 0x4' is the same as 'val != 0x4' because 0 is also
> != 4, so that expression can be simplified and the temp variable not
> overwritten.
> 
> Fixes: 35c51f83dd1e ("perf cs-etm: Validate options after applying them")

Thanks, applied to perf-tools, for v6.4.

- Arnaldo

> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Link: https://lore.kernel.org/all/20230501073452.GA4660@leoy-yangtze.lan
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 77cb03e6ff87..9ca040bfb1aa 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -78,9 +78,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>  	char path[PATH_MAX];
>  	int err;
>  	u32 val;
> -	u64 contextid =
> -		evsel->core.attr.config &
> -		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
> +	u64 contextid = evsel->core.attr.config &
> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
>  		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
>  
>  	if (!contextid)
> @@ -114,8 +114,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>  		 *  0b00100 Maximum of 32-bit Context ID size.
>  		 *  All other values are reserved.
>  		 */
> -		val = BMVAL(val, 5, 9);
> -		if (!val || val != 0x4) {
> +		if (BMVAL(val, 5, 9) != 0x4) {
>  			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
>  			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>  			return -EINVAL;
> -- 
> 2.34.1
> 

-- 

- Arnaldo
