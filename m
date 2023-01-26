Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974F67C249
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjAZBV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjAZBVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:21:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5B61D58
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:20:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso321332ybx.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjltbgFvPXxNxLiYStYE3VCcVG+pja2QaxGJnpw1y/o=;
        b=VxQifR4eTm/oiq+AtgXObEPg6PbS+FCbU66oTdjhqZ7NOq5U2vhhVAuJG7CJAmTAx4
         Lt50WFOtTpTs1TQKLM0aOwhl4/O9QSqsZ7GYnbdd8r+IghyCyr7DL5d6c/hl6Au4KTsM
         ErRsXqJd/YTXEyZLP90smJmcXZ2wm1RhUX1E2uhwba8PGvyRkWiCtQofEvi/IEOSjYLn
         WrQqm5BZ6+RZ99ZwhgD8m92fCZeLverYJd/5gsKFa6jFKD1Qm01QpjyXwVbdK1wdSPb8
         QXHTuTatMmpI9W2nK87lMLio5oAZirIt7fZGwV+avak9PsioHMSqNPVCTS6ndtiPIQqP
         D5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjltbgFvPXxNxLiYStYE3VCcVG+pja2QaxGJnpw1y/o=;
        b=eptuxiCuuK6VLr1YPc2zf7jHWnuL2oU+bgT+dY7W2sCFiVQNTVQVxrlbg4kC9RhFa8
         4u4qjBkM3MTKHTv61cr0mO9U+vXqxH4h9CewAzQ/dKFCiqYhko1/Jp98SMVbAK6qGN63
         DV6Un4jp10LaDRfjUnfPWeabgH8bTQf/Wqs9sMzM+LDPSPl7N3zO5TNQqejA3NCoZUzl
         FxQzewYIJFnmJBfaH0RuASV0Rj44wR+vvPAFjXFI/IPkChs8LMKo9uj+kaKsuI3PwwUf
         0d1XKjvbB1M7uxSfeKyIqcoakotkihNytgLZPoH97d1EQgY3bp7BpZ86+w6pcDCmXxWc
         RFAA==
X-Gm-Message-State: AFqh2kq4h7j/Zc0vBUPUZL/d8D4AJc9I4yP9Bu1/9/UkqbJT0NWR15pS
        H9Eeev/bjQ1AUftvg1mqsxbaKYfiVScR
X-Google-Smtp-Source: AMrXdXsACLfASuysaOm2/S/UHYpvgci8aYMjvrQ5T1As6a7u+QStn1ktC49JQqivsGHwIDxUs3nwQIls/UA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a81:ec05:0:b0:4fd:413d:204c with SMTP id
 j5-20020a81ec05000000b004fd413d204cmr2646561ywm.419.1674696041384; Wed, 25
 Jan 2023 17:20:41 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:54 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-13-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 12/12] perf pmu-events: Fix testing with JEVENTS_ARCH=all
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #slots literal will return NAN when not on ARM64 which causes a
perf test failure when not on an ARM64 for a JEVENTS_ARCH=all build:
..
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
..
Add an is_test boolean so that the failure can be avoided when running
as a test.

Fixes: acef233b7ca7 ("perf pmu: Add #slots literal support for arm64")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 1 +
 tools/perf/util/expr.h        | 1 +
 tools/perf/util/expr.l        | 8 +++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 962c3c0d53ba..accf44b3d968 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -950,6 +950,7 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 		pr_debug("expr__ctx_new failed");
 		return TEST_FAIL;
 	}
+	ctx->sctx.is_test = true;
 	if (expr__find_ids(str, NULL, ctx) < 0) {
 		pr_err("expr__find_ids failed\n");
 		return -1;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 029271540fb0..eaa44b24c555 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -9,6 +9,7 @@ struct expr_scanner_ctx {
 	char *user_requested_cpu_list;
 	int runtime;
 	bool system_wide;
+	bool is_test;
 };
 
 struct expr_parse_ctx {
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0168a9637330..72ff4f3d6d4b 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -84,9 +84,11 @@ static int literal(yyscan_t scanner, const struct expr_scanner_ctx *sctx)
 	YYSTYPE *yylval = expr_get_lval(scanner);
 
 	yylval->num = expr__get_literal(expr_get_text(scanner), sctx);
-	if (isnan(yylval->num))
-		return EXPR_ERROR;
-
+	if (isnan(yylval->num)) {
+		if (!sctx->is_test)
+			return EXPR_ERROR;
+		yylval->num = 1;
+	}
 	return LITERAL;
 }
 %}
-- 
2.39.1.456.gfc5497dd1b-goog

