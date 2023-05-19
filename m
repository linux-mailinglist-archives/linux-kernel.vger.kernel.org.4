Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58C708FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjESGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:37:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E8E4E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:37:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56183784dd3so33540717b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684478261; x=1687070261;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POR3nD2hZh2mgrvjJBel/KBPGvBrYJdGRQz+avV/aPk=;
        b=jfy86rUx/iJHAPc8wLaNfjNWI7svQmVPT7Xjv8DRM3U1gG1A2UIFxcsCE7T4x0l2XB
         k+7FKpo9UxSFPnhqhIDZVKJdatqWKY978V7cj0QdXBjclZX9QQQHgHKOBj8cxet8GAz1
         bu6JKToCuaxtYQGWjU9INTEqGzOzBvr+AK0v3n+I4q51CQiEp/UnjGOQIKPd1zdCKyHz
         5StcjNITo0JGppTM24lVk0oIkvciIHIeEn8m7NPH0JrXuR25yNm4VgK1iSV1qC9ioWOD
         dXSviXwhAfz0f7Kg0zgTY4QfeRLlt8qfG5e6n4NbsD+X5I+dVgD3XhL1zBVqun1xGiu1
         hQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684478261; x=1687070261;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POR3nD2hZh2mgrvjJBel/KBPGvBrYJdGRQz+avV/aPk=;
        b=UghQ5UfBf8ygJ9WMX+VSfcsX1Qejr9XGFAC4gnzJWmBwxEBsUrgy9d0kabwx4zBHNF
         FYC1BNNNLvorBhc3ms2l+JHlGoLCcIsXrRFv+sD0jFPAEwwGwK3iRPXFU4r32UbygA5u
         RpsemRdW+ntwY3pztA0wd4RUKI4hujgyDLkbxLkEQR0e/TkyYxJ+MwJnZYT0dHiGSACw
         9ogPnhzFTl260z/bZlX2CynunIEV+UhLwYXKTZG5lU0T4UIamdJlwS9Ci/TR4chpD8MB
         HuANhAp99idJ0B+xOHGQAtkkcUtFYchN640/ZzNe9yOrHOm8DApqTJKdc09fO3ujvSKY
         UupA==
X-Gm-Message-State: AC+VfDxyKV1ahV3MbMIsV9CkztjchB6UQxFp+t2nrxPkQk9juym+/kds
        H1fVC9NpdajGYo7z2vbof+6e2ch9z17a
X-Google-Smtp-Source: ACHHUZ4bJOrxfPSPY5F/uvdEopv62sFPa0XQxManJyy2pxqQ8iDd1t32WsDDd13/MucFue6f0kHusE2GniYn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a7c2:2c4c:d716:50e2])
 (user=irogers job=sendgmr) by 2002:a81:4311:0:b0:561:8ff6:fb5b with SMTP id
 q17-20020a814311000000b005618ff6fb5bmr623232ywa.10.1684478261588; Thu, 18 May
 2023 23:37:41 -0700 (PDT)
Date:   Thu, 18 May 2023 23:37:18 -0700
Message-Id: <20230519063719.1029596-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 1/2] perf expr: Make the evaluation of & and | logical and lazy
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
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/expr.c | 40 +++++++++++++++++++
 tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
 2 files changed, 109 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 733ead151c63..3d01eb5e2512 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -185,6 +185,46 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
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
index 4ce931cccb63..f04963eb6be0 100644
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
2.40.1.698.g37aff9b760-goog

