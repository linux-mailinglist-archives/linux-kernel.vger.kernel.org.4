Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD25646068
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLGRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLGRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:38:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B722ED4A;
        Wed,  7 Dec 2022 09:37:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDF061B8D;
        Wed,  7 Dec 2022 17:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A441C433C1;
        Wed,  7 Dec 2022 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434677;
        bh=hbb2cAPOpDuuUsSuu7vsrOvrU2941h3tDeYTNa+km/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmNowapVl13yAcykKs2YqvqH5xMA6/6BP3dyFIZpfflFpV4QkIpoWiwRVDcQc1n0x
         gJLvCn8glQNSvVs6qxmknG+T6pyV1cL1ft80C+k9dQ5UvC+Km2BtvjdknEaf2o1ypI
         9hDNuTqSFyOhx1ne0riXGtmVAYjhsplo4idFTtXpa9wK8W4NQws/2lpJfCUfHVEo5A
         0LNmybYF0lnmQapqZG6CTuh21lpJwGHNhkR17J9Z3lSmFJpR9QFQxqdEcCFeMv+sqh
         GTLj+emaScrFmdgcyhLgnUzKRIhsMl7c53RBM4cFJ8FUlBMZJqHQYTUn2sbSa0Fe1i
         Ncb0buW/ytVpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B1E940404; Wed,  7 Dec 2022 14:37:53 -0300 (-03)
Date:   Wed, 7 Dec 2022 14:37:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf stat: Update event skip condition
Message-ID: <Y5DPcYOSRw8GljeO@kernel.org>
References: <20221206175804.391387-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206175804.391387-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 06, 2022 at 09:58:04AM -0800, Namhyung Kim escreveu:
> In print_counter_aggrdata(), it skips some events that has no aggregate
> count.  It's actually for system-wide per-thread mode and merged uncore
> and hybrid events.
> 
> Let's update the condition to check them explicitly.

Thanks, applied.

- Arnaldo

 
> Fixes: 91f85f98da7a ("Display event stats using aggr counts")
> Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 847acdb5dc40..a45aacc9df64 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -814,7 +814,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  	os->nr = aggr->nr;
>  	os->evsel = counter;
>  
> -	if (counter->supported && aggr->nr == 0)
> +	/* Skip already merged uncore/hybrid events */
> +	if (counter->merged_stat)
>  		return;
>  
>  	uniquify_counter(config, counter);
> @@ -823,6 +824,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  	ena = aggr->counts.ena;
>  	run = aggr->counts.run;
>  
> +	/*
> +	 * Skip value 0 when enabling --per-thread globally, otherwise it will
> +	 * have too many 0 output.
> +	 */
> +	if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> +		return;
> +
>  	if (!metric_only) {
>  		if (config->json_output)
>  			fputc('{', output);
> @@ -899,9 +907,6 @@ static void print_aggr(struct perf_stat_config *config,
>  		print_metric_begin(config, evlist, os, s);
>  
>  		evlist__for_each_entry(evlist, counter) {
> -			if (counter->merged_stat)
> -				continue;
> -
>  			print_counter_aggrdata(config, counter, s, os);
>  		}
>  		print_metric_end(config, os);
> @@ -928,9 +933,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>  			print_metric_begin(config, evlist, os, s);
>  
>  			evlist__for_each_entry(evlist, counter) {
> -				if (counter->merged_stat)
> -					continue;
> -
>  				if (counter->cgrp != os->cgrp)
>  					continue;
>  
> @@ -950,9 +952,6 @@ static void print_counter(struct perf_stat_config *config,
>  	if (!config->aggr_map)
>  		return;
>  
> -	if (counter->merged_stat)
> -		return;
> -
>  	for (s = 0; s < config->aggr_map->nr; s++) {
>  		print_counter_aggrdata(config, counter, s, os);
>  	}
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog

-- 

- Arnaldo
