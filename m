Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD264B673
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiLMNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiLMNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:39:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24A18B41;
        Tue, 13 Dec 2022 05:39:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408A22F4;
        Tue, 13 Dec 2022 05:40:33 -0800 (PST)
Received: from [10.57.9.141] (unknown [10.57.9.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 041D13F71E;
        Tue, 13 Dec 2022 05:39:50 -0800 (PST)
Message-ID: <c0ebfb40-382d-8d38-a8e7-8fbaad871937@arm.com>
Date:   Tue, 13 Dec 2022 13:39:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
References: <20221212230820.901382-1-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 23:08, Namhyung Kim wrote:
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
> 
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")

Looks like the same fix as here, but it was only partially applied:

https://lore.kernel.org/linux-perf-users/20220801112726.GA73228@leoy-ThinkPad-X240s/T/#mce4ad6b17a5fa15970765bb01e7b691c7326fbb0


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
