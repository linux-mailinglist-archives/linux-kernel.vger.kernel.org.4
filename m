Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93BC73BB32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjFWPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjFWPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4482697
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a64so10511377b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533037; x=1690125037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esSkQJg/VtdJhfubiyHaspvmh3pr2CsZdqhGyqi+VGI=;
        b=BbtAh9ac5DF4dqJL+tKfDgcikhys23/kTQxU8GAGBRYk4uDZu/SGEaUFqKvpKn5Ax4
         6rIZvIiK1/a9bj+C/5spEM4Bn7Y685KQMzQzFjtpNfeBGApxVPHDoAXPKLCR1C0wKbMp
         AKiKAiAdJPyqVsmU9vrQOKsqD7lAknecyC18SUDi2LvHzDdh+QFtPQGwReRaY0kbBuQA
         +fVii9PMuzaWMY8Fyl+df7m7uzWGkEqQBANSExhDcDwK8VgvFC5NKAnUvnWUm5S/r7A6
         8rncO5aD2Tk9nMNKxAUKB5Smbiu2JYD6ZzptVfdATqSwQ7W26wwYR+u2w0C9/q2GoEZ4
         +meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533037; x=1690125037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esSkQJg/VtdJhfubiyHaspvmh3pr2CsZdqhGyqi+VGI=;
        b=CmJ6WYubxTxJoTy0t7CtES4ZiA9RbP8us6PZEQWH8puEXZju7HGLbHBo3Z97sKJlfZ
         ZCtXMtbAJSg6NpqhNNIML73CRCkGY49MthqrVj2OFoCRVwT2KpCLUfiVB/uK8soEf/cj
         gywWoVTFmPNw1LGyymSlciocFPBQP2M/jVIO8HRBmV8L3VBEmL1hh6fPmH3Yj0UxDBLL
         7q+47aSF564LIkmoTGB/O+J0spVk0DaesbeZkStv9uzTE0mgyNiE6FwER+l6Kr3L1AJb
         0KJJD36ykmbggQ6Ll7cf1yZ95LSd8KquTRtPNA7z/oILSJPLfgg0R8CVTKOf7yRhuvRD
         dSjQ==
X-Gm-Message-State: AC+VfDws36nsGIJx1G69eedBIIwc5uwGUa1WMjeRITUmbWvmPoUzuN87
        Rt8EAC9cJgjFUm3H9gihi3SERTOAyA4B
X-Google-Smtp-Source: ACHHUZ75MDw7mn4sXn5Uq8VKlTWFWHet5eyvj4ZZaU8jC/oEc/FXMcrQPiz3MQFCesfkpsISK/dijwhlaQqH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:4507:0:b0:568:c4ea:ce66 with SMTP id
 s7-20020a814507000000b00568c4eace66mr9956723ywa.5.1687533036750; Fri, 23 Jun
 2023 08:10:36 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:05 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 01/12] perf expr: Add has_event function
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

Some events are dependent on firmware/kernel enablement. Allow such
events to be detected when the metric is parsed so that the metric's
event parsing doesn't fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c |  4 ++++
 tools/perf/util/expr.c  | 21 +++++++++++++++++++++
 tools/perf/util/expr.h  |  1 +
 tools/perf/util/expr.l  |  1 +
 tools/perf/util/expr.y  |  8 +++++++-
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 3d01eb5e2512..c1c3fcbc2753 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -254,6 +254,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
 	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 
+	/* has_event returns 1 when an event exists. */
+	expr__add_id_val(ctx, strdup("cycles"), 2);
+	ret = test(ctx, "has_event(cycles)", 1);
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index f4e52919324e..4814262e3805 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -8,6 +8,7 @@
 #include "cpumap.h"
 #include "cputopo.h"
 #include "debug.h"
+#include "evlist.h"
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
@@ -474,3 +475,23 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	pr_debug2("literal: %s = %f\n", literal, result);
 	return result;
 }
+
+/* Does the event 'id' parse? Determine via ctx->ids if possible. */
+double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id)
+{
+	struct evlist *tmp;
+	double ret;
+
+	if (hashmap__find(ctx->ids, id, /*value=*/NULL))
+		return 1.0;
+
+	if (!compute_ids)
+		return 0.0;
+
+	tmp = evlist__new();
+	if (!tmp)
+		return NAN;
+	ret = parse_event(tmp, id) ? 0 : 1;
+	evlist__delete(tmp);
+	return ret;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index eaa44b24c555..3c1e49b3e35d 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -54,5 +54,6 @@ int expr__find_ids(const char *expr, const char *one,
 double expr_id_data__value(const struct expr_id_data *data);
 double expr_id_data__source_count(const struct expr_id_data *data);
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx);
+double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
 
 #endif
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 4fbf353e78e7..dbb117414710 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -113,6 +113,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 source_count	{ return SOURCE_COUNT; }
+has_event	{ return HAS_EVENT; }
 {literal}	{ return literal(yyscanner, sctx); }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f04963eb6be0..dd504afd8f36 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -37,7 +37,7 @@
 	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT EXPR_ERROR
+%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -199,6 +199,12 @@ expr: NUMBER
 }
 | ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
 | SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
+| HAS_EVENT '(' ID ')'
+{
+	$$.val = expr__has_event(ctx, compute_ids, $3);
+	$$.ids = NULL;
+	free($3);
+}
 | expr '|' expr
 {
 	if (is_const($1.val) && is_const($3.val)) {
-- 
2.41.0.162.gfafddb0af9-goog

