Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CF5EDF39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiI1OwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiI1Ovm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:51:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90223B2CE7;
        Wed, 28 Sep 2022 07:51:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3129D23A;
        Wed, 28 Sep 2022 07:51:35 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0AD3F73D;
        Wed, 28 Sep 2022 07:51:26 -0700 (PDT)
Message-ID: <8c857c8e-7378-5a3d-66a9-7372902ed0a5@arm.com>
Date:   Wed, 28 Sep 2022 15:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/6] perf stat: Kill unused per-thread runtime stats
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
 <20220926200757.1161448-6-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-6-namhyung@kernel.org>
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
> Now it's using the global rt_stat, no need to use per-thread stats.  Let
> get rid of them.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 54 ---------------------------------------
>  tools/perf/util/stat.h    |  2 --
>  2 files changed, 56 deletions(-)

Reviewed-by: James Clark <james.clark@arm.com>
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e05fe72c1d87..b86ebb25a799 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -292,13 +292,8 @@ static inline void diff_timespec(struct timespec *r, struct timespec *a,
>  
>  static void perf_stat__reset_stats(void)
>  {
> -	int i;
> -
>  	evlist__reset_stats(evsel_list);
>  	perf_stat__reset_shadow_stats();
> -
> -	for (i = 0; i < stat_config.stats_num; i++)
> -		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
>  }
>  
>  static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
> @@ -489,46 +484,6 @@ static void read_counters(struct timespec *rs)
>  	}
>  }
>  
> -static int runtime_stat_new(struct perf_stat_config *config, int nthreads)
> -{
> -	int i;
> -
> -	config->stats = calloc(nthreads, sizeof(struct runtime_stat));
> -	if (!config->stats)
> -		return -1;
> -
> -	config->stats_num = nthreads;
> -
> -	for (i = 0; i < nthreads; i++)
> -		runtime_stat__init(&config->stats[i]);
> -
> -	return 0;
> -}
> -
> -static void runtime_stat_delete(struct perf_stat_config *config)
> -{
> -	int i;
> -
> -	if (!config->stats)
> -		return;
> -
> -	for (i = 0; i < config->stats_num; i++)
> -		runtime_stat__exit(&config->stats[i]);
> -
> -	zfree(&config->stats);
> -}
> -
> -static void runtime_stat_reset(struct perf_stat_config *config)
> -{
> -	int i;
> -
> -	if (!config->stats)
> -		return;
> -
> -	for (i = 0; i < config->stats_num; i++)
> -		perf_stat__reset_shadow_per_stat(&config->stats[i]);
> -}
> -
>  static void process_interval(void)
>  {
>  	struct timespec ts, rs;
> @@ -537,7 +492,6 @@ static void process_interval(void)
>  	diff_timespec(&rs, &ts, &ref_time);
>  
>  	perf_stat__reset_shadow_per_stat(&rt_stat);
> -	runtime_stat_reset(&stat_config);
>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {
> @@ -1018,7 +972,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  		evlist__copy_prev_raw_counts(evsel_list);
>  		evlist__reset_prev_raw_counts(evsel_list);
> -		runtime_stat_reset(&stat_config);
>  		perf_stat__reset_shadow_per_stat(&rt_stat);
>  	} else {
>  		update_stats(&walltime_nsecs_stats, t1 - t0);
> @@ -2514,12 +2467,6 @@ int cmd_stat(int argc, const char **argv)
>  	 */
>  	if (stat_config.aggr_mode == AGGR_THREAD) {
>  		thread_map__read_comms(evsel_list->core.threads);
> -		if (target.system_wide) {
> -			if (runtime_stat_new(&stat_config,
> -				perf_thread_map__nr(evsel_list->core.threads))) {
> -				goto out;
> -			}
> -		}
>  	}
>  
>  	if (stat_config.aggr_mode == AGGR_NODE)
> @@ -2660,7 +2607,6 @@ int cmd_stat(int argc, const char **argv)
>  	evlist__delete(evsel_list);
>  
>  	metricgroup__rblist_exit(&stat_config.metric_events);
> -	runtime_stat_delete(&stat_config);
>  	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
>  
>  	return status;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 3eba38a1a149..43cb3f13d4d6 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -153,8 +153,6 @@ struct perf_stat_config {
>  	int			 run_count;
>  	int			 print_free_counters_hint;
>  	int			 print_mixed_hw_group_error;
> -	struct runtime_stat	*stats;
> -	int			 stats_num;
>  	const char		*csv_sep;
>  	struct stats		*walltime_nsecs_stats;
>  	struct rusage		 ru_data;
