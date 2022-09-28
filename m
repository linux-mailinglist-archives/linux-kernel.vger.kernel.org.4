Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE55EDAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiI1KyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiI1Kxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:53:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF3EF2B24A;
        Wed, 28 Sep 2022 03:50:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435791595;
        Wed, 28 Sep 2022 03:50:47 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CC73F792;
        Wed, 28 Sep 2022 03:50:38 -0700 (PDT)
Message-ID: <288ee488-c50f-252d-b886-1bef89b5e883@arm.com>
Date:   Wed, 28 Sep 2022 11:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/6] perf stat: Rename saved_value->cpu_map_idx
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
 <20220926200757.1161448-4-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-4-namhyung@kernel.org>
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
> The cpu_map_idx fields is just to differentiate values from other
> entries.  It doesn't need to be strictly cpu map index.  Actually we can
> pass thread map index or aggr map index.  So rename the fields first.
> 
> No functional change intended.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-shadow.c | 308 +++++++++++++++++-----------------
>  1 file changed, 154 insertions(+), 154 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 9e1eddeff21b..99d05262055c 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -33,7 +33,7 @@ struct saved_value {
>  	struct evsel *evsel;
>  	enum stat_type type;
>  	int ctx;
> -	int cpu_map_idx;
> +	int map_idx;

Do the same variables in stat.c and stat.h also need to be updated? The
previous change to do this exact thing (5b1af93dbc7e) changed more than
just these ones.

>  	struct cgroup *cgrp;
>  	struct runtime_stat *stat;
>  	struct stats stats;
> @@ -48,8 +48,8 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
>  					     rb_node);
>  	const struct saved_value *b = entry;
>  
> -	if (a->cpu_map_idx != b->cpu_map_idx)
> -		return a->cpu_map_idx - b->cpu_map_idx;
> +	if (a->map_idx != b->map_idx)
> +		return a->map_idx - b->map_idx;
>  
>  	/*
>  	 * Previously the rbtree was used to link generic metrics.
> @@ -106,7 +106,7 @@ static void saved_value_delete(struct rblist *rblist __maybe_unused,
>  }
>  
>  static struct saved_value *saved_value_lookup(struct evsel *evsel,
> -					      int cpu_map_idx,
> +					      int map_idx,
>  					      bool create,
>  					      enum stat_type type,
>  					      int ctx,
> @@ -116,7 +116,7 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
>  	struct rblist *rblist;
>  	struct rb_node *nd;
>  	struct saved_value dm = {
> -		.cpu_map_idx = cpu_map_idx,
> +		.map_idx = map_idx,
>  		.evsel = evsel,
>  		.type = type,
>  		.ctx = ctx,
> @@ -215,10 +215,10 @@ struct runtime_stat_data {
>  
>  static void update_runtime_stat(struct runtime_stat *st,
>  				enum stat_type type,
> -				int cpu_map_idx, u64 count,
> +				int map_idx, u64 count,
>  				struct runtime_stat_data *rsd)
>  {
> -	struct saved_value *v = saved_value_lookup(NULL, cpu_map_idx, true, type,
> +	struct saved_value *v = saved_value_lookup(NULL, map_idx, true, type,
>  						   rsd->ctx, st, rsd->cgrp);
>  
>  	if (v)
> @@ -231,7 +231,7 @@ static void update_runtime_stat(struct runtime_stat *st,
>   * instruction rates, etc:
>   */
>  void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
> -				    int cpu_map_idx, struct runtime_stat *st)
> +				    int map_idx, struct runtime_stat *st)
>  {
>  	u64 count_ns = count;
>  	struct saved_value *v;
> @@ -243,88 +243,88 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
>  	count *= counter->scale;
>  
>  	if (evsel__is_clock(counter))
> -		update_runtime_stat(st, STAT_NSECS, cpu_map_idx, count_ns, &rsd);
> +		update_runtime_stat(st, STAT_NSECS, map_idx, count_ns, &rsd);
>  	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
> -		update_runtime_stat(st, STAT_CYCLES, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_CYCLES, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
> -		update_runtime_stat(st, STAT_CYCLES_IN_TX, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_CYCLES_IN_TX, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
> -		update_runtime_stat(st, STAT_TRANSACTION, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_TRANSACTION, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, ELISION_START))
> -		update_runtime_stat(st, STAT_ELISION, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_ELISION, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
>  		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
>  		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
>  		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
>  		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
>  		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
>  		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
>  		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
>  		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
>  		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_HEAVY_OPS))
>  		update_runtime_stat(st, STAT_TOPDOWN_HEAVY_OPS,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_BR_MISPREDICT))
>  		update_runtime_stat(st, STAT_TOPDOWN_BR_MISPREDICT,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_LAT))
>  		update_runtime_stat(st, STAT_TOPDOWN_FETCH_LAT,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, TOPDOWN_MEM_BOUND))
>  		update_runtime_stat(st, STAT_TOPDOWN_MEM_BOUND,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
>  		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
>  		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
> -				    cpu_map_idx, count, &rsd);
> +				    map_idx, count, &rsd);
>  	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
> -		update_runtime_stat(st, STAT_BRANCHES, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_BRANCHES, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
> -		update_runtime_stat(st, STAT_CACHEREFS, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_CACHEREFS, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
> -		update_runtime_stat(st, STAT_L1_DCACHE, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_L1_DCACHE, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
> -		update_runtime_stat(st, STAT_L1_ICACHE, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_L1_ICACHE, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
> -		update_runtime_stat(st, STAT_LL_CACHE, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_LL_CACHE, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
> -		update_runtime_stat(st, STAT_DTLB_CACHE, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_DTLB_CACHE, map_idx, count, &rsd);
>  	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
> -		update_runtime_stat(st, STAT_ITLB_CACHE, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_ITLB_CACHE, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, SMI_NUM))
> -		update_runtime_stat(st, STAT_SMI_NUM, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_SMI_NUM, map_idx, count, &rsd);
>  	else if (perf_stat_evsel__is(counter, APERF))
> -		update_runtime_stat(st, STAT_APERF, cpu_map_idx, count, &rsd);
> +		update_runtime_stat(st, STAT_APERF, map_idx, count, &rsd);
>  
>  	if (counter->collect_stat) {
> -		v = saved_value_lookup(counter, cpu_map_idx, true, STAT_NONE, 0, st,
> +		v = saved_value_lookup(counter, map_idx, true, STAT_NONE, 0, st,
>  				       rsd.cgrp);
>  		update_stats(&v->stats, count);
>  		if (counter->metric_leader)
>  			v->metric_total += count;
>  	} else if (counter->metric_leader) {
>  		v = saved_value_lookup(counter->metric_leader,
> -				       cpu_map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
> +				       map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
>  		v->metric_total += count;
>  		v->metric_other++;
>  	}
> @@ -466,12 +466,12 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>  }
>  
>  static double runtime_stat_avg(struct runtime_stat *st,
> -			       enum stat_type type, int cpu_map_idx,
> +			       enum stat_type type, int map_idx,
>  			       struct runtime_stat_data *rsd)
>  {
>  	struct saved_value *v;
>  
> -	v = saved_value_lookup(NULL, cpu_map_idx, false, type, rsd->ctx, st, rsd->cgrp);
> +	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, st, rsd->cgrp);
>  	if (!v)
>  		return 0.0;
>  
> @@ -479,12 +479,12 @@ static double runtime_stat_avg(struct runtime_stat *st,
>  }
>  
>  static double runtime_stat_n(struct runtime_stat *st,
> -			     enum stat_type type, int cpu_map_idx,
> +			     enum stat_type type, int map_idx,
>  			     struct runtime_stat_data *rsd)
>  {
>  	struct saved_value *v;
>  
> -	v = saved_value_lookup(NULL, cpu_map_idx, false, type, rsd->ctx, st, rsd->cgrp);
> +	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, st, rsd->cgrp);
>  	if (!v)
>  		return 0.0;
>  
> @@ -492,7 +492,7 @@ static double runtime_stat_n(struct runtime_stat *st,
>  }
>  
>  static void print_stalled_cycles_frontend(struct perf_stat_config *config,
> -					  int cpu_map_idx, double avg,
> +					  int map_idx, double avg,
>  					  struct perf_stat_output_ctx *out,
>  					  struct runtime_stat *st,
>  					  struct runtime_stat_data *rsd)
> @@ -500,7 +500,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -515,7 +515,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
>  }
>  
>  static void print_stalled_cycles_backend(struct perf_stat_config *config,
> -					 int cpu_map_idx, double avg,
> +					 int map_idx, double avg,
>  					 struct perf_stat_output_ctx *out,
>  					 struct runtime_stat *st,
>  					 struct runtime_stat_data *rsd)
> @@ -523,7 +523,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -534,7 +534,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
>  }
>  
>  static void print_branch_misses(struct perf_stat_config *config,
> -				int cpu_map_idx, double avg,
> +				int map_idx, double avg,
>  				struct perf_stat_output_ctx *out,
>  				struct runtime_stat *st,
>  				struct runtime_stat_data *rsd)
> @@ -542,7 +542,7 @@ static void print_branch_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_BRANCHES, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_BRANCHES, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -553,7 +553,7 @@ static void print_branch_misses(struct perf_stat_config *config,
>  }
>  
>  static void print_l1_dcache_misses(struct perf_stat_config *config,
> -				   int cpu_map_idx, double avg,
> +				   int map_idx, double avg,
>  				   struct perf_stat_output_ctx *out,
>  				   struct runtime_stat *st,
>  				   struct runtime_stat_data *rsd)
> @@ -561,7 +561,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_L1_DCACHE, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_L1_DCACHE, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -572,7 +572,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
>  }
>  
>  static void print_l1_icache_misses(struct perf_stat_config *config,
> -				   int cpu_map_idx, double avg,
> +				   int map_idx, double avg,
>  				   struct perf_stat_output_ctx *out,
>  				   struct runtime_stat *st,
>  				   struct runtime_stat_data *rsd)
> @@ -580,7 +580,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_L1_ICACHE, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_L1_ICACHE, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -590,7 +590,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  }
>  
>  static void print_dtlb_cache_misses(struct perf_stat_config *config,
> -				    int cpu_map_idx, double avg,
> +				    int map_idx, double avg,
>  				    struct perf_stat_output_ctx *out,
>  				    struct runtime_stat *st,
>  				    struct runtime_stat_data *rsd)
> @@ -598,7 +598,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_DTLB_CACHE, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_DTLB_CACHE, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -608,7 +608,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  }
>  
>  static void print_itlb_cache_misses(struct perf_stat_config *config,
> -				    int cpu_map_idx, double avg,
> +				    int map_idx, double avg,
>  				    struct perf_stat_output_ctx *out,
>  				    struct runtime_stat *st,
>  				    struct runtime_stat_data *rsd)
> @@ -616,7 +616,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_ITLB_CACHE, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_ITLB_CACHE, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -626,7 +626,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  }
>  
>  static void print_ll_cache_misses(struct perf_stat_config *config,
> -				  int cpu_map_idx, double avg,
> +				  int map_idx, double avg,
>  				  struct perf_stat_output_ctx *out,
>  				  struct runtime_stat *st,
>  				  struct runtime_stat_data *rsd)
> @@ -634,7 +634,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
>  	double total, ratio = 0.0;
>  	const char *color;
>  
> -	total = runtime_stat_avg(st, STAT_LL_CACHE, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_LL_CACHE, map_idx, rsd);
>  
>  	if (total)
>  		ratio = avg / total * 100.0;
> @@ -692,61 +692,61 @@ static double sanitize_val(double x)
>  	return x;
>  }
>  
> -static double td_total_slots(int cpu_map_idx, struct runtime_stat *st,
> +static double td_total_slots(int map_idx, struct runtime_stat *st,
>  			     struct runtime_stat_data *rsd)
>  {
> -	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, cpu_map_idx, rsd);
> +	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, map_idx, rsd);
>  }
>  
> -static double td_bad_spec(int cpu_map_idx, struct runtime_stat *st,
> +static double td_bad_spec(int map_idx, struct runtime_stat *st,
>  			  struct runtime_stat_data *rsd)
>  {
>  	double bad_spec = 0;
>  	double total_slots;
>  	double total;
>  
> -	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, cpu_map_idx, rsd) -
> -		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, cpu_map_idx, rsd) +
> -		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, cpu_map_idx, rsd);
> +	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, map_idx, rsd) -
> +		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, map_idx, rsd) +
> +		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, map_idx, rsd);
>  
> -	total_slots = td_total_slots(cpu_map_idx, st, rsd);
> +	total_slots = td_total_slots(map_idx, st, rsd);
>  	if (total_slots)
>  		bad_spec = total / total_slots;
>  	return sanitize_val(bad_spec);
>  }
>  
> -static double td_retiring(int cpu_map_idx, struct runtime_stat *st,
> +static double td_retiring(int map_idx, struct runtime_stat *st,
>  			  struct runtime_stat_data *rsd)
>  {
>  	double retiring = 0;
> -	double total_slots = td_total_slots(cpu_map_idx, st, rsd);
> +	double total_slots = td_total_slots(map_idx, st, rsd);
>  	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
> -					    cpu_map_idx, rsd);
> +					    map_idx, rsd);
>  
>  	if (total_slots)
>  		retiring = ret_slots / total_slots;
>  	return retiring;
>  }
>  
> -static double td_fe_bound(int cpu_map_idx, struct runtime_stat *st,
> +static double td_fe_bound(int map_idx, struct runtime_stat *st,
>  			  struct runtime_stat_data *rsd)
>  {
>  	double fe_bound = 0;
> -	double total_slots = td_total_slots(cpu_map_idx, st, rsd);
> +	double total_slots = td_total_slots(map_idx, st, rsd);
>  	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
> -					    cpu_map_idx, rsd);
> +					    map_idx, rsd);
>  
>  	if (total_slots)
>  		fe_bound = fetch_bub / total_slots;
>  	return fe_bound;
>  }
>  
> -static double td_be_bound(int cpu_map_idx, struct runtime_stat *st,
> +static double td_be_bound(int map_idx, struct runtime_stat *st,
>  			  struct runtime_stat_data *rsd)
>  {
> -	double sum = (td_fe_bound(cpu_map_idx, st, rsd) +
> -		      td_bad_spec(cpu_map_idx, st, rsd) +
> -		      td_retiring(cpu_map_idx, st, rsd));
> +	double sum = (td_fe_bound(map_idx, st, rsd) +
> +		      td_bad_spec(map_idx, st, rsd) +
> +		      td_retiring(map_idx, st, rsd));
>  	if (sum == 0)
>  		return 0;
>  	return sanitize_val(1.0 - sum);
> @@ -757,15 +757,15 @@ static double td_be_bound(int cpu_map_idx, struct runtime_stat *st,
>   * the ratios we need to recreate the sum.
>   */
>  
> -static double td_metric_ratio(int cpu_map_idx, enum stat_type type,
> +static double td_metric_ratio(int map_idx, enum stat_type type,
>  			      struct runtime_stat *stat,
>  			      struct runtime_stat_data *rsd)
>  {
> -	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu_map_idx, rsd) +
> -		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu_map_idx, rsd) +
> -		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu_map_idx, rsd) +
> -		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu_map_idx, rsd);
> -	double d = runtime_stat_avg(stat, type, cpu_map_idx, rsd);
> +	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, map_idx, rsd) +
> +		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, map_idx, rsd) +
> +		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, map_idx, rsd) +
> +		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, map_idx, rsd);
> +	double d = runtime_stat_avg(stat, type, map_idx, rsd);
>  
>  	if (sum)
>  		return d / sum;
> @@ -777,23 +777,23 @@ static double td_metric_ratio(int cpu_map_idx, enum stat_type type,
>   * We allow two missing.
>   */
>  
> -static bool full_td(int cpu_map_idx, struct runtime_stat *stat,
> +static bool full_td(int map_idx, struct runtime_stat *stat,
>  		    struct runtime_stat_data *rsd)
>  {
>  	int c = 0;
>  
> -	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu_map_idx, rsd) > 0)
> +	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, map_idx, rsd) > 0)
>  		c++;
> -	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu_map_idx, rsd) > 0)
> +	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, map_idx, rsd) > 0)
>  		c++;
> -	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu_map_idx, rsd) > 0)
> +	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, map_idx, rsd) > 0)
>  		c++;
> -	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu_map_idx, rsd) > 0)
> +	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, map_idx, rsd) > 0)
>  		c++;
>  	return c >= 2;
>  }
>  
> -static void print_smi_cost(struct perf_stat_config *config, int cpu_map_idx,
> +static void print_smi_cost(struct perf_stat_config *config, int map_idx,
>  			   struct perf_stat_output_ctx *out,
>  			   struct runtime_stat *st,
>  			   struct runtime_stat_data *rsd)
> @@ -801,9 +801,9 @@ static void print_smi_cost(struct perf_stat_config *config, int cpu_map_idx,
>  	double smi_num, aperf, cycles, cost = 0.0;
>  	const char *color = NULL;
>  
> -	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, cpu_map_idx, rsd);
> -	aperf = runtime_stat_avg(st, STAT_APERF, cpu_map_idx, rsd);
> -	cycles = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
> +	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, map_idx, rsd);
> +	aperf = runtime_stat_avg(st, STAT_APERF, map_idx, rsd);
> +	cycles = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
>  
>  	if ((cycles == 0) || (aperf == 0))
>  		return;
> @@ -820,7 +820,7 @@ static void print_smi_cost(struct perf_stat_config *config, int cpu_map_idx,
>  static int prepare_metric(struct evsel **metric_events,
>  			  struct metric_ref *metric_refs,
>  			  struct expr_parse_ctx *pctx,
> -			  int cpu_map_idx,
> +			  int map_idx,
>  			  struct runtime_stat *st)
>  {
>  	double scale;
> @@ -859,7 +859,7 @@ static int prepare_metric(struct evsel **metric_events,
>  				abort();
>  			}
>  		} else {
> -			v = saved_value_lookup(metric_events[i], cpu_map_idx, false,
> +			v = saved_value_lookup(metric_events[i], map_idx, false,
>  					       STAT_NONE, 0, st,
>  					       metric_events[i]->cgrp);
>  			if (!v)
> @@ -897,7 +897,7 @@ static void generic_metric(struct perf_stat_config *config,
>  			   const char *metric_name,
>  			   const char *metric_unit,
>  			   int runtime,
> -			   int cpu_map_idx,
> +			   int map_idx,
>  			   struct perf_stat_output_ctx *out,
>  			   struct runtime_stat *st)
>  {
> @@ -915,7 +915,7 @@ static void generic_metric(struct perf_stat_config *config,
>  		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
>  	pctx->sctx.runtime = runtime;
>  	pctx->sctx.system_wide = config->system_wide;
> -	i = prepare_metric(metric_events, metric_refs, pctx, cpu_map_idx, st);
> +	i = prepare_metric(metric_events, metric_refs, pctx, map_idx, st);
>  	if (i < 0) {
>  		expr__ctx_free(pctx);
>  		return;
> @@ -960,7 +960,7 @@ static void generic_metric(struct perf_stat_config *config,
>  	expr__ctx_free(pctx);
>  }
>  
> -double test_generic_metric(struct metric_expr *mexp, int cpu_map_idx, struct runtime_stat *st)
> +double test_generic_metric(struct metric_expr *mexp, int map_idx, struct runtime_stat *st)
>  {
>  	struct expr_parse_ctx *pctx;
>  	double ratio = 0.0;
> @@ -969,7 +969,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu_map_idx, struct run
>  	if (!pctx)
>  		return NAN;
>  
> -	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu_map_idx, st) < 0)
> +	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, map_idx, st) < 0)
>  		goto out;
>  
>  	if (expr__parse(&ratio, pctx, mexp->metric_expr))
> @@ -982,7 +982,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu_map_idx, struct run
>  
>  void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  				   struct evsel *evsel,
> -				   double avg, int cpu_map_idx,
> +				   double avg, int map_idx,
>  				   struct perf_stat_output_ctx *out,
>  				   struct rblist *metric_events,
>  				   struct runtime_stat *st)
> @@ -1001,7 +1001,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  	if (config->iostat_run) {
>  		iostat_print_metric(config, evsel, out);
>  	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
> -		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
>  
>  		if (total) {
>  			ratio = avg / total;
> @@ -1011,11 +1011,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
>  		}
>  
> -		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, map_idx, &rsd);
>  
>  		total = max(total, runtime_stat_avg(st,
>  						    STAT_STALLED_CYCLES_BACK,
> -						    cpu_map_idx, &rsd));
> +						    map_idx, &rsd));
>  
>  		if (total && avg) {
>  			out->new_line(config, ctxp);
> @@ -1025,8 +1025,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					ratio);
>  		}
>  	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
> -		if (runtime_stat_n(st, STAT_BRANCHES, cpu_map_idx, &rsd) != 0)
> -			print_branch_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_BRANCHES, map_idx, &rsd) != 0)
> +			print_branch_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
>  	} else if (
> @@ -1035,8 +1035,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> -		if (runtime_stat_n(st, STAT_L1_DCACHE, cpu_map_idx, &rsd) != 0)
> -			print_l1_dcache_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_L1_DCACHE, map_idx, &rsd) != 0)
> +			print_l1_dcache_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
>  	} else if (
> @@ -1045,8 +1045,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> -		if (runtime_stat_n(st, STAT_L1_ICACHE, cpu_map_idx, &rsd) != 0)
> -			print_l1_icache_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_L1_ICACHE, map_idx, &rsd) != 0)
> +			print_l1_icache_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
>  	} else if (
> @@ -1055,8 +1055,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> -		if (runtime_stat_n(st, STAT_DTLB_CACHE, cpu_map_idx, &rsd) != 0)
> -			print_dtlb_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_DTLB_CACHE, map_idx, &rsd) != 0)
> +			print_dtlb_cache_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
>  	} else if (
> @@ -1065,8 +1065,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> -		if (runtime_stat_n(st, STAT_ITLB_CACHE, cpu_map_idx, &rsd) != 0)
> -			print_itlb_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_ITLB_CACHE, map_idx, &rsd) != 0)
> +			print_itlb_cache_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
>  	} else if (
> @@ -1075,27 +1075,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>  					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
>  
> -		if (runtime_stat_n(st, STAT_LL_CACHE, cpu_map_idx, &rsd) != 0)
> -			print_ll_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
> +		if (runtime_stat_n(st, STAT_LL_CACHE, map_idx, &rsd) != 0)
> +			print_ll_cache_misses(config, map_idx, avg, out, st, &rsd);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
>  	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
> -		total = runtime_stat_avg(st, STAT_CACHEREFS, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CACHEREFS, map_idx, &rsd);
>  
>  		if (total)
>  			ratio = avg * 100 / total;
>  
> -		if (runtime_stat_n(st, STAT_CACHEREFS, cpu_map_idx, &rsd) != 0)
> +		if (runtime_stat_n(st, STAT_CACHEREFS, map_idx, &rsd) != 0)
>  			print_metric(config, ctxp, NULL, "%8.3f %%",
>  				     "of all cache refs", ratio);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
>  	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
> -		print_stalled_cycles_frontend(config, cpu_map_idx, avg, out, st, &rsd);
> +		print_stalled_cycles_frontend(config, map_idx, avg, out, st, &rsd);
>  	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
> -		print_stalled_cycles_backend(config, cpu_map_idx, avg, out, st, &rsd);
> +		print_stalled_cycles_backend(config, map_idx, avg, out, st, &rsd);
>  	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
> -		total = runtime_stat_avg(st, STAT_NSECS, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_NSECS, map_idx, &rsd);
>  
>  		if (total) {
>  			ratio = avg / total;
> @@ -1104,7 +1104,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
>  		}
>  	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
> -		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
>  
>  		if (total)
>  			print_metric(config, ctxp, NULL,
> @@ -1114,8 +1114,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
>  				     0);
>  	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
> -		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
> -		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
> +		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
>  
>  		if (total2 < avg)
>  			total2 = avg;
> @@ -1125,19 +1125,19 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
>  	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
> -		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
>  
>  		if (avg)
>  			ratio = total / avg;
>  
> -		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd) != 0)
> +		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, map_idx, &rsd) != 0)
>  			print_metric(config, ctxp, NULL, "%8.0f",
>  				     "cycles / transaction", ratio);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
>  				      0);
>  	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
> -		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
>  
>  		if (avg)
>  			ratio = total / avg;
> @@ -1150,28 +1150,28 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		else
>  			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
> -		double fe_bound = td_fe_bound(cpu_map_idx, st, &rsd);
> +		double fe_bound = td_fe_bound(map_idx, st, &rsd);
>  
>  		if (fe_bound > 0.2)
>  			color = PERF_COLOR_RED;
>  		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
>  				fe_bound * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
> -		double retiring = td_retiring(cpu_map_idx, st, &rsd);
> +		double retiring = td_retiring(map_idx, st, &rsd);
>  
>  		if (retiring > 0.7)
>  			color = PERF_COLOR_GREEN;
>  		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
>  				retiring * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
> -		double bad_spec = td_bad_spec(cpu_map_idx, st, &rsd);
> +		double bad_spec = td_bad_spec(map_idx, st, &rsd);
>  
>  		if (bad_spec > 0.1)
>  			color = PERF_COLOR_RED;
>  		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
>  				bad_spec * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
> -		double be_bound = td_be_bound(cpu_map_idx, st, &rsd);
> +		double be_bound = td_be_bound(map_idx, st, &rsd);
>  		const char *name = "backend bound";
>  		static int have_recovery_bubbles = -1;
>  
> @@ -1184,14 +1184,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  
>  		if (be_bound > 0.2)
>  			color = PERF_COLOR_RED;
> -		if (td_total_slots(cpu_map_idx, st, &rsd) > 0)
> +		if (td_total_slots(map_idx, st, &rsd) > 0)
>  			print_metric(config, ctxp, color, "%8.1f%%", name,
>  					be_bound * 100.);
>  		else
>  			print_metric(config, ctxp, NULL, NULL, name, 0);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
> -		   full_td(cpu_map_idx, st, &rsd)) {
> -		double retiring = td_metric_ratio(cpu_map_idx,
> +		   full_td(map_idx, st, &rsd)) {
> +		double retiring = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_RETIRING, st,
>  						  &rsd);
>  		if (retiring > 0.7)
> @@ -1199,8 +1199,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Retiring",
>  				retiring * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
> -		   full_td(cpu_map_idx, st, &rsd)) {
> -		double fe_bound = td_metric_ratio(cpu_map_idx,
> +		   full_td(map_idx, st, &rsd)) {
> +		double fe_bound = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_FE_BOUND, st,
>  						  &rsd);
>  		if (fe_bound > 0.2)
> @@ -1208,8 +1208,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Frontend Bound",
>  				fe_bound * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
> -		   full_td(cpu_map_idx, st, &rsd)) {
> -		double be_bound = td_metric_ratio(cpu_map_idx,
> +		   full_td(map_idx, st, &rsd)) {
> +		double be_bound = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_BE_BOUND, st,
>  						  &rsd);
>  		if (be_bound > 0.2)
> @@ -1217,8 +1217,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Backend Bound",
>  				be_bound * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
> -		   full_td(cpu_map_idx, st, &rsd)) {
> -		double bad_spec = td_metric_ratio(cpu_map_idx,
> +		   full_td(map_idx, st, &rsd)) {
> +		double bad_spec = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_BAD_SPEC, st,
>  						  &rsd);
>  		if (bad_spec > 0.1)
> @@ -1226,11 +1226,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Bad Speculation",
>  				bad_spec * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_HEAVY_OPS) &&
> -			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> -		double retiring = td_metric_ratio(cpu_map_idx,
> +			full_td(map_idx, st, &rsd) && (config->topdown_level > 1)) {
> +		double retiring = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_RETIRING, st,
>  						  &rsd);
> -		double heavy_ops = td_metric_ratio(cpu_map_idx,
> +		double heavy_ops = td_metric_ratio(map_idx,
>  						   STAT_TOPDOWN_HEAVY_OPS, st,
>  						   &rsd);
>  		double light_ops = retiring - heavy_ops;
> @@ -1246,11 +1246,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
>  				light_ops * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BR_MISPREDICT) &&
> -			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> -		double bad_spec = td_metric_ratio(cpu_map_idx,
> +			full_td(map_idx, st, &rsd) && (config->topdown_level > 1)) {
> +		double bad_spec = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_BAD_SPEC, st,
>  						  &rsd);
> -		double br_mis = td_metric_ratio(cpu_map_idx,
> +		double br_mis = td_metric_ratio(map_idx,
>  						STAT_TOPDOWN_BR_MISPREDICT, st,
>  						&rsd);
>  		double m_clears = bad_spec - br_mis;
> @@ -1266,11 +1266,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Machine Clears",
>  				m_clears * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_LAT) &&
> -			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> -		double fe_bound = td_metric_ratio(cpu_map_idx,
> +			full_td(map_idx, st, &rsd) && (config->topdown_level > 1)) {
> +		double fe_bound = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_FE_BOUND, st,
>  						  &rsd);
> -		double fetch_lat = td_metric_ratio(cpu_map_idx,
> +		double fetch_lat = td_metric_ratio(map_idx,
>  						   STAT_TOPDOWN_FETCH_LAT, st,
>  						   &rsd);
>  		double fetch_bw = fe_bound - fetch_lat;
> @@ -1286,11 +1286,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		print_metric(config, ctxp, color, "%8.1f%%", "Fetch Bandwidth",
>  				fetch_bw * 100.);
>  	} else if (perf_stat_evsel__is(evsel, TOPDOWN_MEM_BOUND) &&
> -			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
> -		double be_bound = td_metric_ratio(cpu_map_idx,
> +			full_td(map_idx, st, &rsd) && (config->topdown_level > 1)) {
> +		double be_bound = td_metric_ratio(map_idx,
>  						  STAT_TOPDOWN_BE_BOUND, st,
>  						  &rsd);
> -		double mem_bound = td_metric_ratio(cpu_map_idx,
> +		double mem_bound = td_metric_ratio(map_idx,
>  						   STAT_TOPDOWN_MEM_BOUND, st,
>  						   &rsd);
>  		double core_bound = be_bound - mem_bound;
> @@ -1308,12 +1308,12 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  	} else if (evsel->metric_expr) {
>  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>  			       evsel->name, evsel->metric_name, NULL, 1,
> -			       cpu_map_idx, out, st);
> -	} else if (runtime_stat_n(st, STAT_NSECS, cpu_map_idx, &rsd) != 0) {
> +			       map_idx, out, st);
> +	} else if (runtime_stat_n(st, STAT_NSECS, map_idx, &rsd) != 0) {
>  		char unit = ' ';
>  		char unit_buf[10] = "/sec";
>  
> -		total = runtime_stat_avg(st, STAT_NSECS, cpu_map_idx, &rsd);
> +		total = runtime_stat_avg(st, STAT_NSECS, map_idx, &rsd);
>  		if (total)
>  			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
>  
> @@ -1321,7 +1321,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
>  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
>  	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> -		print_smi_cost(config, cpu_map_idx, out, st, &rsd);
> +		print_smi_cost(config, map_idx, out, st, &rsd);
>  	} else {
>  		num = 0;
>  	}
> @@ -1335,7 +1335,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  			generic_metric(config, mexp->metric_expr, mexp->metric_events,
>  				       mexp->metric_refs, evsel->name, mexp->metric_name,
>  				       mexp->metric_unit, mexp->runtime,
> -				       cpu_map_idx, out, st);
> +				       map_idx, out, st);
>  		}
>  	}
>  	if (num == 0)
