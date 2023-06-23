Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB373ADD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFWAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:33:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16598212F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfebb1beeccso102626276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480417; x=1690072417;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUGpNbs4oqebH8Ro3XL8mmCPuE8hcJ5FvmDzQ93SknU=;
        b=MiJjhafpRaXoNG1lTr9qKNlcROx5n+Aa7SBkGS+abh87FF+ig1Zy8iEuQjZC4u3itv
         EhS4MNn+B//KI4ccoeLl5bP3Rnf970hN72ROS2772UcfJk0eQQ4uRr4TVqN0TCTwvwH0
         uWqoLqSeqOWpkXY7sV4EHbAYch7wJv/76qdnLpO++/g//I/4HBeYMEL9Lp31umq+VDIR
         YKsGBFxAJ8yWbPUUIguooa6D1Cfo/TdNB3l7/Y0+3J5tlv11DeHrtGnnuA5N1LEj6JkF
         dCwVpWsArUvGLpyT7J8dKvCyrLYD/dnpoGFJQk3fbaDxiu5Fg08pBaBG5sMvhXime8KU
         beKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480417; x=1690072417;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUGpNbs4oqebH8Ro3XL8mmCPuE8hcJ5FvmDzQ93SknU=;
        b=STVOXsEoV4cc3koE3KvbLWNk2PfSD3PY2/1VVQ6bU5IN+sUFcUV7lnzbm/uGkpLkh6
         iIgYWs2pRbv0XifAzI/kPzKTIyeN8gBz3lR2JkNja0wusI62yeXLM5ZhiodEzYHTyit/
         ubzhVmPKbdmqaMkDcYDPZ8QUUCf9WASjCYbmvqJQehCnzQPsZbVAItmXR8QjKS1It3jY
         teSKJX9e7SVQoXSJ9bDG0TrjF7EXxajfp33TmvxS+P/tUdQG5aszUFx4QvUpZZfDw8bD
         58dm77/c/fgxOks0SOVc7zSEdyL0OPjqMxlhJeQyU8XS3hgEfP/lFPkq9tDiT/gxNy7X
         H3ww==
X-Gm-Message-State: AC+VfDzRy5pG0pPBZ6/+U/4n3J9B+C7qHGskkDaR0kQz73KYgUYsOIEc
        i5VG60ibDF9SruMLeqYYFsebbeSd89SB
X-Google-Smtp-Source: ACHHUZ5/hmJGQuTgD0k3G27q8x93nw6+gl5icVffXqqw2+KlCLOhdn3J/DdXrDiJBJothW2LcvQnlboeQObf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ec0e:0:b0:be6:6539:7fde with SMTP id
 j14-20020a25ec0e000000b00be665397fdemr2903947ybh.10.1687480417324; Thu, 22
 Jun 2023 17:33:37 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:01 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 01/12] perf expr: Add has_event function
From:   Ian Rogers <irogers@google.com>
To:     eter Zijlstra <peterz@infradead.org>,
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
 tools/perf/util/expr.c  | 19 +++++++++++++++++++
 tools/perf/util/expr.h  |  1 +
 tools/perf/util/expr.l  |  1 +
 tools/perf/util/expr.y  |  8 +++++++-
 5 files changed, 32 insertions(+), 1 deletion(-)

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
index f4e52919324e..47b881e566f0 100644
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
@@ -474,3 +475,21 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
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

