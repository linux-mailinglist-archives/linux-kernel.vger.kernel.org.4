Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB76F2312
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjD2Ffk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjD2Ffi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:35:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ACB3A93
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559ea6b1065so2044367b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746534; x=1685338534;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkkrPyzVS2Om/QKsjXGchMiqAs6KBM0rgwQ9R0UbvAs=;
        b=prLi5KdBVcqCnX6pBvulx4BQswVOIkJ7Fkyj13BQ33zosgROrGuqGq4vXbKgf6x5wH
         oqGL01XiIrl7SGpHIlgjhbUUEU5JtliNRuHPiLz/DRKtBIiyJvS4bGQy9qMWxxJvjW0b
         J6aefO2QGb+K76NqbGt+ELrBtj3vvfTHzuVcLoaqvoZQoC/dMwkQOwP6hMnGLV6WGNVy
         v6ADTz3bUChNH02g16juiujC5+2b4VCfEQNOdANFME9oP/HEoZ2OJrZiHIPIBB4MwEnG
         1ecPPyoqVYXP1uYcz2v1WRpoVBiLRLHR6ffOtwLmTrsxi4Nf2jaSIitJnaAA+TQjdYvz
         mF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746534; x=1685338534;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkkrPyzVS2Om/QKsjXGchMiqAs6KBM0rgwQ9R0UbvAs=;
        b=R0gLZZboNY6PQLgS3jwHAYIFkqFT+ObV/+5BCxno31UCkhS1nemnH0iW26ztbQMQkQ
         +cuidV/AUBMnplXGRhjNhMDbif++0PMzHEYoUPRvDaunjX9cEjNHLA/tDYzpxfPKUvYj
         DFTGrqj/D8kCRHDeOzLo7gHgDC3aUWORYEkCuQxn6Cz9unLXtuinCf3eNtQBPsgViyjn
         UVwgGo1wxIOte1jJT4OfpSTfk0YXhYAFbcLVQ/smPFhnC0DjpEzhNp1I1RJm3soHA00g
         dSo+40vs6jvB09VhVCzSm9VM8aWQM9Omv2ebHmOm84QqdjZbr80wavs3yyKXwN9EKPiS
         j8Ug==
X-Gm-Message-State: AC+VfDy5cpYFkPUHX8O+J61qroBnXZUVVJDq8vx//LcepPLnR4MdG2Jh
        hs1x+aPq/OHdqrUU0AdjLqy6lsDOs5HP
X-Google-Smtp-Source: ACHHUZ7C8vgpZNTNGVjs5B1JwzZ5byzk+JxgTq2MIHyEfTFg2Od4rNYr/iNkjX56bPpXu8wzVk+sA/bvbUxo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:4511:0:b0:54f:8f2e:a03 with SMTP id
 s17-20020a814511000000b0054f8f2e0a03mr4515240ywa.1.1682746534182; Fri, 28 Apr
 2023 22:35:34 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:22 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-3-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 02/46] perf metric: Change divide by zero and !support
 events behavior
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Division by zero causes expression parsing to fail and no metric to be
generated. This can mean for short running benchmarks metrics are not
shown. Change the behavior to make the value nan, which gets shown like:

'''
$ perf stat -M TopdownL2 true

 Performance counter stats for 'true':

         1,031,492      INST_RETIRED.ANY                 #      nan %  tma_fetch_bandwidth
                                                  #      nan %  tma_heavy_operations
                                                  #      nan %  tma_light_operations
            29,304      CPU_CLK_UNHALTED.REF_XCLK        #      nan %  tma_fetch_latency
                                                  #      nan %  tma_branch_mispredicts
                                                  #      nan %  tma_machine_clears
                                                  #      nan %  tma_core_bound
                                                  #      nan %  tma_memory_bound
         2,658,319      IDQ_UOPS_NOT_DELIVERED.CORE
            11,167      EXE_ACTIVITY.BOUND_ON_STORES
           262,058      EXE_ACTIVITY.1_PORTS_UTIL
     <not counted>      BR_MISP_RETIRED.ALL_BRANCHES                                            (0.00%)
     <not counted>      INT_MISC.RECOVERY_CYCLES_ANY                                            (0.00%)
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS                                               (0.00%)
     <not counted>      CYCLE_ACTIVITY.STALLS_MEM_ANY                                           (0.00%)
     <not counted>      UOPS_RETIRED.MACRO_FUSED                                                (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
     <not counted>      EXE_ACTIVITY.2_PORTS_UTIL                                               (0.00%)
     <not counted>      CYCLE_ACTIVITY.STALLS_TOTAL                                             (0.00%)
     <not counted>      MACHINE_CLEARS.COUNT                                                    (0.00%)
     <not counted>      UOPS_ISSUED.ANY                                                         (0.00%)

       0.002864879 seconds time elapsed

       0.003012000 seconds user
       0.000000000 seconds sys
'''

When events aren't supported a count of 0 can be confusing and make
metrics look meaningful. Change these to be nan also which, with the
next change, gets shown like:

'''
$ perf stat true
 Performance counter stats for 'true':

              1.25 msec task-clock:u                     #    0.387 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                46      page-faults:u                    #   36.702 K/sec
           255,942      cycles:u                         #    0.204 GHz                         (88.66%)
           123,046      instructions:u                   #    0.48  insn per cycle
            28,301      branches:u                       #   22.580 M/sec
             2,489      branch-misses:u                  #    8.79% of all branches
             4,719      CPU_CLK_UNHALTED.REF_XCLK:u      #    3.765 M/sec
                                                  #      nan %  tma_frontend_bound
                                                  #      nan %  tma_retiring
                                                  #      nan %  tma_backend_bound
                                                  #      nan %  tma_bad_speculation
           344,855      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  275.147 M/sec
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD:u                                               (0.00%)
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u                                             (0.00%)
     <not counted>      UOPS_ISSUED.ANY:u                                                       (0.00%)

       0.003238142 seconds time elapsed

       0.000000000 seconds user
       0.003434000 seconds sys
'''

Ensure that nan metric values are quoted as nan isn't a valid number
in json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c         |  3 ++-
 tools/perf/tests/parse-metric.c |  1 +
 tools/perf/util/expr.y          |  6 +++++-
 tools/perf/util/stat-display.c  |  2 +-
 tools/perf/util/stat-shadow.c   | 25 +++++++++++++++++++------
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index cbf0e0c74906..733ead151c63 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -120,7 +120,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 
 	p = "FOO/0";
 	ret = expr__parse(&val, ctx, p);
-	TEST_ASSERT_VAL("division by zero", ret == -1);
+	TEST_ASSERT_VAL("division by zero", ret == 0);
+	TEST_ASSERT_VAL("division by zero", isnan(val));
 
 	p = "BAR/";
 	ret = expr__parse(&val, ctx, p);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 1185b79e6274..c05148ea400c 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -38,6 +38,7 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
+		evsel->supported = true;
 		evsel->stats->aggr->counts.val = count;
 		if (evsel__name_is(evsel, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 250e444bf032..4ce931cccb63 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -225,7 +225,11 @@ expr: NUMBER
 {
 	if (fpclassify($3.val) == FP_ZERO) {
 		pr_debug("division by zero\n");
-		YYABORT;
+		assert($3.ids == NULL);
+		if (compute_ids)
+			ids__free($1.ids);
+		$$.val = NAN;
+		$$.ids = NULL;
 	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
 		assert($1.ids == NULL);
 		assert($3.ids == NULL);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e6035ecbeee8..d87fb5328543 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -431,7 +431,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : %f, ", val);
+	fprintf(out, "\"metric-value\" : \"%f\", ", val);
 	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index eeccab6751d7..1566a206ba42 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -403,12 +403,25 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!aggr)
 				break;
 
-			/*
-			 * If an event was scaled during stat gathering, reverse
-			 * the scale before computing the metric.
-			 */
-			val = aggr->counts.val * (1.0 / metric_events[i]->scale);
-			source_count = evsel__source_count(metric_events[i]);
+                        if (!metric_events[i]->supported) {
+				/*
+				 * Not supported events will have a count of 0,
+				 * which can be confusing in a
+				 * metric. Explicitly set the value to NAN. Not
+				 * counted events (enable time of 0) are read as
+				 * 0.
+				 */
+				val = NAN;
+				source_count = 0;
+			} else {
+				/*
+				 * If an event was scaled during stat gathering,
+				 * reverse the scale before computing the
+				 * metric.
+				 */
+				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
+				source_count = evsel__source_count(metric_events[i]);
+			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.40.1.495.gc816e09b53d-goog

