Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D485EDA21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiI1KeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiI1KeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:34:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498277B2B1;
        Wed, 28 Sep 2022 03:34:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B516D20E3;
        Wed, 28 Sep 2022 03:34:06 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4268C3F792;
        Wed, 28 Sep 2022 03:33:58 -0700 (PDT)
Message-ID: <55e74adc-0001-f08e-de10-913f36469da8@arm.com>
Date:   Wed, 28 Sep 2022 11:33:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] perf stat: Convert perf_stat_evsel.res_stats array
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
 <20220926200757.1161448-2-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 21:07, Namhyung Kim wrote:
> It uses only one member, no need to have it as an array.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c |  2 +-
>  tools/perf/util/stat.c         | 10 +++-------
>  tools/perf/util/stat.h         |  2 +-
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b82844cb0ce7..234491f43c36 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -67,7 +67,7 @@ static void print_noise(struct perf_stat_config *config,
>  		return;
>  
>  	ps = evsel->stats;
> -	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
> +	print_noise_pct(config, stddev_stats(&ps->res_stats), avg);
>  }
>  
>  static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ce5e9e372fc4..6bcd3dc32a71 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -132,12 +132,9 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
>  
>  static void evsel__reset_stat_priv(struct evsel *evsel)
>  {
> -	int i;
>  	struct perf_stat_evsel *ps = evsel->stats;
>  
> -	for (i = 0; i < 3; i++)
> -		init_stats(&ps->res_stats[i]);
> -
> +	init_stats(&ps->res_stats);
>  	perf_stat_evsel_id_init(evsel);
>  }
>  
> @@ -440,7 +437,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>  	struct perf_counts_values *aggr = &counter->counts->aggr;
>  	struct perf_stat_evsel *ps = counter->stats;
>  	u64 *count = counter->counts->aggr.values;
> -	int i, ret;
> +	int ret;
>  
>  	aggr->val = aggr->ena = aggr->run = 0;
>  
> @@ -458,8 +455,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>  		evsel__compute_deltas(counter, -1, -1, aggr);
>  	perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
>  
> -	for (i = 0; i < 3; i++)
> -		update_stats(&ps->res_stats[i], count[i]);
> +	update_stats(&ps->res_stats, *count);
>  
>  	if (verbose > 0) {
>  		fprintf(config->output, "%s: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 72713b344b79..3eba38a1a149 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -43,7 +43,7 @@ enum perf_stat_evsel_id {
>  };
>  
>  struct perf_stat_evsel {
> -	struct stats		 res_stats[3];
> +	struct stats		 res_stats;
>  	enum perf_stat_evsel_id	 id;
>  	u64			*group_data;
>  };
