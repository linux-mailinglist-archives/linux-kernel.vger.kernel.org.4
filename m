Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9093D67D9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjAZXjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAZXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:39:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2691ABE7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so3590182ybr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSC7IGbFplNjrd7OktgTvuZJ+ddPP0r726YUt977o3g=;
        b=gZCa5OqiYz7NyA6wxR3fCZCky6kk8dd2ivPt2CaREtn9Z9XF7e58Rav+cA+K9bCEQN
         6o/MuJmb4H9idBb7vfMk6bOdgVuHCE0F1qZipjYthhqjcv0pQUDz7YLAwSnEwbtHbdUa
         Wgxo77095ctlPwQfJX+yHJM0Uan+lqnh/xUw7edMCiC9weIc2kyt+nqBL14pgSN2L2vb
         SR6CTArsAMMpLftaHCc2QfE0zG4i+0XSSZyQT1M9E5/QyPP+wKGZh3F8G7xJ3tmQPakA
         Bn6o3nUY8Q2zmRZGMjElSQ0vZRi9PIeDYDzIB/xxyyVnQhkZaUw/lcuFrgqIk2uBkGz2
         r/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSC7IGbFplNjrd7OktgTvuZJ+ddPP0r726YUt977o3g=;
        b=zYFllw16T+Js0lBKgOegu2ppbxs7gVF2uF1MzUp9/yTi6eXI7lo4UeJEi/FJcmTBC4
         JEx+sAqggNA4DQixrqOwUrJuf1eg7HeJ5SHqd2NMr0NHwvfg2Q04sQ25BHj3MKak7XpC
         PBIHfO0blRu9J1rRkDgp/kNgGIFAkt9Tpk4zTdW4lur7ch3aL9c16nKHXct99NCAQOF5
         YS7czf+ndiMgo28Fo7D95/Jrt9LXEfpncynPCDw0YMPU8ueQRU+PnWZhcZUCZj1mq5yk
         CA738rsL1c/CRUceB2o70GHuiil5+rgWO8QFslzGL+7KtW6SN4rNWra7EjwxuCy62tHW
         u1TA==
X-Gm-Message-State: AO0yUKUNWXDmc3YkfedgHtA0rj2paoCBZKx+wChOFRYBDQ5Kkl3MYmez
        sKAE9x0KNyXvvZck27/Wukh0MVOclzUB
X-Google-Smtp-Source: AK7set+OUpwXf8Bx1zrRtgOMDopCjgg4Qbg1GA9ZQB3lT9ReFsdmmO2a+c65JJvtRAYo78u7CvJ3tHwlJO8s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a81:b246:0:b0:506:55d9:3a78 with SMTP id
 q67-20020a81b246000000b0050655d93a78mr1019749ywh.339.1674776306506; Thu, 26
 Jan 2023 15:38:26 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:42 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-13-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 12/15] perf pmu-events: Fix testing with JEVENTS_ARCH=all
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

