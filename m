Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC76F6057
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjECU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:57:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF183DD;
        Wed,  3 May 2023 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683147435; x=1714683435;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GaehTfve45CbIaWWz2WMlJ4UzjVlJnRrSQYu3WWTTN0=;
  b=ATjFgW415d/wDOD5SPqt87tUFGskjlFrIo34EVqZqwe/Ihkz1C67mIp8
   sRzOvRSxtHDpUp/ILlhLYzZkeNqOSxLTkgvjqjEw5ENOKycoVblqticwD
   GSN9SSnpQhAO/lP3EP9uTuQUw50CWKpOU1UjDa1J1jgQGEnsNU6qhQBYW
   0XbT7I4vNGqojGFZRHfQ8wTEwnWPNWzPxQmFPv6ZiWn790+HDrInHlKYO
   Q8F71nugXX83vKnkN5T3FwNq2lEs7ZO+AQdVWbaVvX6MdDJGcBufC+lIn
   K4zge09yX62MqjkQXzwB5qa4VtvXnLQsxBQ32bp8mmEvZJeae0gPlMBm8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337906388"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="337906388"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="820904656"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="820904656"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 13:57:09 -0700
Received: from [10.209.46.175] (kliang2-mobl1.ccr.corp.intel.com [10.209.46.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D883C580569;
        Wed,  3 May 2023 13:57:05 -0700 (PDT)
Message-ID: <30c9f835-d269-1ee9-d715-d3efbd651dc2@linux.intel.com>
Date:   Wed, 3 May 2023 16:57:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 01/44] perf metric: Change divide by zero and !support
 events behavior
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
References: <20230502223851.2234828-1-irogers@google.com>
 <20230502223851.2234828-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230502223851.2234828-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> Division by zero causes expression parsing to fail and no metric to be
> generated. This can mean for short running benchmarks metrics are not
> shown. Change the behavior to make the value nan, which gets shown like:
> 
> '''
> $ perf stat -M TopdownL2 true
> 
>  Performance counter stats for 'true':
> 
>          1,031,492      INST_RETIRED.ANY                 #      nan %  tma_fetch_bandwidth
>                                                   #      nan %  tma_heavy_operations
>                                                   #      nan %  tma_light_operations
>             29,304      CPU_CLK_UNHALTED.REF_XCLK        #      nan %  tma_fetch_latency
>                                                   #      nan %  tma_branch_mispredicts
>                                                   #      nan %  tma_machine_clears
>                                                   #      nan %  tma_core_bound
>                                                   #      nan %  tma_memory_bound
>          2,658,319      IDQ_UOPS_NOT_DELIVERED.CORE
>             11,167      EXE_ACTIVITY.BOUND_ON_STORES
>            262,058      EXE_ACTIVITY.1_PORTS_UTIL
>      <not counted>      BR_MISP_RETIRED.ALL_BRANCHES                                            (0.00%)
>      <not counted>      INT_MISC.RECOVERY_CYCLES_ANY                                            (0.00%)
>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE                                        (0.00%)
>      <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
>      <not counted>      UOPS_RETIRED.RETIRE_SLOTS                                               (0.00%)
>      <not counted>      CYCLE_ACTIVITY.STALLS_MEM_ANY                                           (0.00%)
>      <not counted>      UOPS_RETIRED.MACRO_FUSED                                                (0.00%)
>      <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
>      <not counted>      EXE_ACTIVITY.2_PORTS_UTIL                                               (0.00%)
>      <not counted>      CYCLE_ACTIVITY.STALLS_TOTAL                                             (0.00%)
>      <not counted>      MACHINE_CLEARS.COUNT                                                    (0.00%)
>      <not counted>      UOPS_ISSUED.ANY                                                         (0.00%)
> 
>        0.002864879 seconds time elapsed
> 
>        0.003012000 seconds user
>        0.000000000 seconds sys
> '''
> 
> When events aren't supported a count of 0 can be confusing and make
> metrics look meaningful. Change these to be nan also which, with the
> next change, gets shown like:
> 
> '''
> $ perf stat true
>  Performance counter stats for 'true':
> 
>               1.25 msec task-clock:u                     #    0.387 CPUs utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 46      page-faults:u                    #   36.702 K/sec
>            255,942      cycles:u                         #    0.204 GHz                         (88.66%)
>            123,046      instructions:u                   #    0.48  insn per cycle
>             28,301      branches:u                       #   22.580 M/sec
>              2,489      branch-misses:u                  #    8.79% of all branches
>              4,719      CPU_CLK_UNHALTED.REF_XCLK:u      #    3.765 M/sec
>                                                   #      nan %  tma_frontend_bound
>                                                   #      nan %  tma_retiring
>                                                   #      nan %  tma_backend_bound
>                                                   #      nan %  tma_bad_speculation
>            344,855      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  275.147 M/sec
>    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
>      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u                                        (0.00%)
>      <not counted>      CPU_CLK_UNHALTED.THREAD:u                                               (0.00%)
>      <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u                                             (0.00%)
>      <not counted>      UOPS_ISSUED.ANY:u                                                       (0.00%)
> 
>        0.003238142 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.003434000 seconds sys
> '''
> 
> Ensure that nan metric values are quoted as nan isn't a valid number
> in json.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/tests/expr.c         |  3 ++-
>  tools/perf/tests/parse-metric.c |  1 +
>  tools/perf/util/expr.y          |  6 +++++-
>  tools/perf/util/stat-display.c  |  2 +-
>  tools/perf/util/stat-shadow.c   | 25 +++++++++++++++++++------
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index cbf0e0c74906..733ead151c63 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -120,7 +120,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  
>  	p = "FOO/0";
>  	ret = expr__parse(&val, ctx, p);
> -	TEST_ASSERT_VAL("division by zero", ret == -1);
> +	TEST_ASSERT_VAL("division by zero", ret == 0);
> +	TEST_ASSERT_VAL("division by zero", isnan(val));
>  
>  	p = "BAR/";
>  	ret = expr__parse(&val, ctx, p);
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 1185b79e6274..c05148ea400c 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -38,6 +38,7 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
>  	evlist__alloc_aggr_stats(evlist, 1);
>  	evlist__for_each_entry(evlist, evsel) {
>  		count = find_value(evsel->name, vals);
> +		evsel->supported = true;
>  		evsel->stats->aggr->counts.val = count;
>  		if (evsel__name_is(evsel, "duration_time"))
>  			update_stats(&walltime_nsecs_stats, count);
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 250e444bf032..4ce931cccb63 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -225,7 +225,11 @@ expr: NUMBER
>  {
>  	if (fpclassify($3.val) == FP_ZERO) {
>  		pr_debug("division by zero\n");
> -		YYABORT;
> +		assert($3.ids == NULL);
> +		if (compute_ids)
> +			ids__free($1.ids);
> +		$$.val = NAN;
> +		$$.ids = NULL;
>  	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
>  		assert($1.ids == NULL);
>  		assert($3.ids == NULL);
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 73b2ff2ddf29..bf5a6c14dfcd 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -431,7 +431,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>  	struct outstate *os = ctx;
>  	FILE *out = os->fh;
>  
> -	fprintf(out, "\"metric-value\" : %f, ", val);
> +	fprintf(out, "\"metric-value\" : \"%f\", ", val);
>  	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
>  	if (!config->metric_only)
>  		fprintf(out, "}");
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index eeccab6751d7..1566a206ba42 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -403,12 +403,25 @@ static int prepare_metric(struct evsel **metric_events,
>  			if (!aggr)
>  				break;
>  
> -			/*
> -			 * If an event was scaled during stat gathering, reverse
> -			 * the scale before computing the metric.
> -			 */
> -			val = aggr->counts.val * (1.0 / metric_events[i]->scale);
> -			source_count = evsel__source_count(metric_events[i]);
> +                        if (!metric_events[i]->supported) {
> +				/*
> +				 * Not supported events will have a count of 0,
> +				 * which can be confusing in a
> +				 * metric. Explicitly set the value to NAN. Not
> +				 * counted events (enable time of 0) are read as
> +				 * 0.
> +				 */
> +				val = NAN;
> +				source_count = 0;
> +			} else {
> +				/*
> +				 * If an event was scaled during stat gathering,
> +				 * reverse the scale before computing the
> +				 * metric.
> +				 */
> +				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
> +				source_count = evsel__source_count(metric_events[i]);
> +			}
>  		}
>  		n = strdup(evsel__metric_id(metric_events[i]));
>  		if (!n)
