Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3683064CC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiLNOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLNOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:41:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF25E66;
        Wed, 14 Dec 2022 06:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3671EB818DD;
        Wed, 14 Dec 2022 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C011FC433EF;
        Wed, 14 Dec 2022 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671028876;
        bh=rnF8BYhs3a7GcUzKlPWhrkA/AEQT2Fik/pkx61vPfjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlEDkTw1r2anm17vm2Xvh7DhLALkbuhw4YTRQ6UzrU9mbEOvaSv7cymERo5iWDwhd
         /KZWN6yt0bCHuA2lqrCFFXQu1toDSiybtX5GO6yjJWCbqAUhda4J3Bh6N3VOioSlPr
         Y6Sm9oufIS5ufv2vhxSWq5W0ddPNaMGCiUmxqvgWxdSs8IwCatKeb2nS6Eo+t8/GEU
         uL4/qd5bs6x6mohaKmqlpx2STjOnV6yV9P7XdCqXaQ6IZfowLe+Vcgz3xb9ATdfoEc
         HXAW52o1ZFFxrbWK6QE/pF0npx1ceiHXSfqsLHdW2K+r5iPnTKFGbGwtpSIwYYvEYa
         ltMjDmr31ooCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C893840367; Wed, 14 Dec 2022 11:41:14 -0300 (-03)
Date:   Wed, 14 Dec 2022 11:41:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
Message-ID: <Y5ngitdB3eTts62Q@kernel.org>
References: <20221212230820.901382-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 12, 2022 at 03:08:20PM -0800, Namhyung Kim escreveu:
> The -D/--delay option is to delay the measure after the program starts.
> But the current code goes to sleep before starting the program so the
> program is delayed too.  This is not the intention, let's fix it.
> 
> Before:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        4,326,949,337      cycles
> 
>          4.007494118 seconds time elapsed
> 
>   real	0m7.474s
>   user	0m0.356s
>   sys	0m0.120s
> 
> It ran the workload for 4 seconds and gave the 3 second delay.  So it
> should skip the first 3 second and measure the last 1 second only.  But
> as you can see, it delays 3 seconds and ran the workload after that for
> 4 seconds.  So the total time (real) was 7 seconds.
> 
> After:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        1,063,551,013      cycles
> 
>          1.002769510 seconds time elapsed
> 
>   real	0m4.484s
>   user	0m0.385s
>   sys	0m0.086s
> 
> The bug was introduced when it changed enablement of system-wide events
> with a command line workload.  But it should've considered the initial
> delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
> afraid it won't be applied cleanly.

Ok, I took up this one instead of Adrian's.

- Arnaldo
 
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d040fbcdcc5a..b39bf785a16e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -540,26 +540,14 @@ static int enable_counters(void)
>  			return err;
>  	}
>  
> -	if (stat_config.initial_delay < 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		return 0;
> -	}
> -
> -	if (stat_config.initial_delay > 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> -	}
> -
>  	/*
>  	 * We need to enable counters only if:
>  	 * - we don't have tracee (attaching to task or cpu)
>  	 * - we have initial delay configured
>  	 */
> -	if (!target__none(&target) || stat_config.initial_delay) {
> +	if (!target__none(&target)) {
>  		if (!all_counters_use_bpf)
>  			evlist__enable(evsel_list);
> -		if (stat_config.initial_delay > 0)
> -			pr_info(EVLIST_ENABLED_MSG);
>  	}
>  	return 0;
>  }
> @@ -930,14 +918,27 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			return err;
>  	}
>  
> -	err = enable_counters();
> -	if (err)
> -		return -1;
> +	if (stat_config.initial_delay) {
> +		pr_info(EVLIST_DISABLED_MSG);
> +	} else {
> +		err = enable_counters();
> +		if (err)
> +			return -1;
> +	}
>  
>  	/* Exec the command, if any */
>  	if (forks)
>  		evlist__start_workload(evsel_list);
>  
> +	if (stat_config.initial_delay > 0) {
> +		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +		err = enable_counters();
> +		if (err)
> +			return -1;
> +
> +		pr_info(EVLIST_ENABLED_MSG);
> +	}
> +
>  	t0 = rdclock();
>  	clock_gettime(CLOCK_MONOTONIC, &ref_time);
>  
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog

-- 

- Arnaldo
