Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4D6F76E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEDUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEDUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:21:12 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31A281B6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:07:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6439cf8d6faso98591b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683230757; x=1685822757;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/r9KGpkW5PSBM9D941BUL0+gJYwAE5n4IR7E5or+wxM=;
        b=A+F+1nGkKZNvXnCdhaSW0gZ2uEJuFYqqUUdbC3zWxTYzxgX6KVINf2otMJ8dqWRt99
         NKXrSOy62iASlHDMPWp19rygyNrbD6ndINRinFfJxJH1mqwtIk6wuiPvRwSjxpHcxl+H
         enjOC846aQGQXd3grzYaU7lM3JkgU3GWh10DyisJ9nxEexeZ4vTQNYImFY8V0KK4m7eN
         9ygmebTC9TU7jt80un3GIL0BtT56peh96lplLuDtYgdpzh4MrAB4v6jebrM93a5rhx2o
         1jwCB1lKAzqETCC5st9b0TuTeukiuyLOwVKZUXk8slTGaQhH/kDORhKh7qoKGF0KBnNf
         05cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230757; x=1685822757;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r9KGpkW5PSBM9D941BUL0+gJYwAE5n4IR7E5or+wxM=;
        b=LKw0OOahsAf1+vtVLyJXSMocz9sDnV5eHDcJCyoe8OJ00I+9WsPztUDdr7mB0Ltr7k
         pI/sieV99fQJNeKxrH9OO8tBZ/POnkUspY0PSE7bD2W8PunkrCDiGh3WAVbrEbwEdC+n
         RYucdkkLrOhTAFsg6IXnJrzqlQV3y1qOINuhn9ZCFMDt9lFL4gBHJEVEzRG+kRAV70Xk
         KpDj6fn0D0Hs47e1MwMNgJ4Niz+3sgws2hu93vU2SpxGAJWY6dvgaYtSCD5pc5PKyVR9
         sYyooG+LLRWBWO029+zr4CWjNE3ANGalCfF8HsZEo4/gCsN4iKuDGKiMpd1KUXvJKKiO
         ES1w==
X-Gm-Message-State: AC+VfDxyEJZ1YPafNFl3JC3UEWXefcEuQilXFbkViLXv0QNBa6WChEPk
        qRStt+9Z2Oz9l9nkYPmRVN3ese0a7uc8
X-Google-Smtp-Source: ACHHUZ72tuOd4ycu57tLPZJN/WIH3wq4S5qp9AaiBLzc58+OfgrMXhnv3k26K2Uh8T+qFJeqz4q2QD8tP0yt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3367:2fed:395f:6f64])
 (user=irogers job=sendgmr) by 2002:a05:6902:1804:b0:b9d:c27c:3442 with SMTP
 id cf4-20020a056902180400b00b9dc27c3442mr452307ybb.9.1683230294858; Thu, 04
 May 2023 12:58:14 -0700 (PDT)
Date:   Thu,  4 May 2023 12:58:02 -0700
Message-Id: <20230504195803.3331775-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical and lazy
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

Currently the & and | operators are only used in metric thresholds
like (from the tma_retiring metric):
tma_retiring > 0.7 | tma_heavy_operations > 0.1

Thresholds are always computed when present, but a lack events may
mean the threshold can't be computed. This happens with the option
--metric-no-threshold for say the metric tma_retiring on Tigerlake
model CPUs. To fully compute the threshold tma_heavy_operations is
needed and it needs the extra events of IDQ.MS_UOPS,
UOPS_DECODED.DEC0, cpu/UOPS_DECODED.DEC0,cmask=1/ and
IDQ.MITE_UOPS. So --metric-no-threshold is a useful option to reduce
the number of events needed and potentially multiplexing of events.

Rather than just fail threshold computations like this, we may know a
result from just the left or right-hand side. So, for tma_retiring if
its value is "> 0.7" we know it is over the threshold. This allows the
metric to have the threshold coloring, when possible, without all the
counters being programmed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 40 +++++++++++++++++++
 tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
 2 files changed, 109 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index cbf0e0c74906..45c7fedb797a 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -184,6 +184,46 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 
+	/* The expression is a constant 0.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("0 & EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1 & EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+
+	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1 | EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("0 | EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+
 	/* Test toplogy constants appear well ordered. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 250e444bf032..6b110f9f95c9 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -123,20 +123,6 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
  * constant value using OP. Its invariant that there are no ids.  If computing
  * ids for non-constants union the set of IDs that must be computed.
  */
-#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
-		assert(LHS.ids == NULL);				\
-		assert(RHS.ids == NULL);				\
-		if (isnan(LHS.val) || isnan(RHS.val)) {			\
-			RESULT.val = NAN;				\
-		} else {						\
-			RESULT.val = (long)LHS.val OP (long)RHS.val;	\
-		}							\
-		RESULT.ids = NULL;					\
-	} else {							\
-	        RESULT = union_expr(LHS, RHS);				\
-	}
-
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
 	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
 		assert(LHS.ids == NULL);				\
@@ -213,9 +199,75 @@ expr: NUMBER
 }
 | ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
 | SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
-| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
-| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
-| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+| expr '|' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.ids = NULL;
+		$$.val = (fpclassify($1.val) == FP_ZERO && fpclassify($3.val) == FP_ZERO) ? 0 : 1;
+	} else if (is_const($1.val)) {
+		assert($1.ids == NULL);
+		if (fpclassify($1.val) == FP_ZERO) {
+			$$ = $3;
+		} else {
+			$$.val = 1;
+			$$.ids = NULL;
+			ids__free($3.ids);
+		}
+	} else if (is_const($3.val)) {
+		assert($3.ids == NULL);
+		if (fpclassify($3.val) == FP_ZERO) {
+			$$ = $1;
+		} else {
+			$$.val = 1;
+			$$.ids = NULL;
+			ids__free($1.ids);
+		}
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
+| expr '&' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (fpclassify($1.val) != FP_ZERO && fpclassify($3.val) != FP_ZERO) ? 1 : 0;
+		$$.ids = NULL;
+	} else if (is_const($1.val)) {
+		assert($1.ids == NULL);
+		if (fpclassify($1.val) != FP_ZERO) {
+			$$ = $3;
+		} else {
+			$$.val = 0;
+			$$.ids = NULL;
+			ids__free($3.ids);
+		}
+	} else if (is_const($3.val)) {
+		assert($3.ids == NULL);
+		if (fpclassify($3.val) != FP_ZERO) {
+			$$ = $1;
+		} else {
+			$$.val = 0;
+			$$.ids = NULL;
+			ids__free($1.ids);
+		}
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
+| expr '^' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (fpclassify($1.val) == FP_ZERO) != (fpclassify($3.val) == FP_ZERO) ? 1 : 0;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
 | expr '<' expr { BINARY_OP($$, <, $1, $3); }
 | expr '>' expr { BINARY_OP($$, >, $1, $3); }
 | expr '+' expr { BINARY_OP($$, +, $1, $3); }
-- 
2.40.1.521.gf1e218fcd8-goog

