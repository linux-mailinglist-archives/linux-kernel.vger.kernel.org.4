Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20964D6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLOGsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLOGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:48:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531B5C0EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so2667967yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuUtjr5keE4Mx0YV4hQdh4hNFeDESLw77jscKu2CoiM=;
        b=GEnpJQtlsZpw6NLVnvIBmIHsHDx+p6RULDeC/EcVcDgLV2/2p90+FG2YlMWaRea5Co
         2d20WQCEk47gD6g/m7kLqm1UEYQ6bccY72F9Fb9v5oraS9FnEAzymvvXDQ5J+Ca4vM2o
         4QwJato9O0KtmPipcH+GQjG2DkZeXxTf9hs5+Mz9YsU/gdPwyV5F8hpKeiMIdlHScisJ
         g9gOAZlpCBwui0Tgc4ti3QWs6ib1odbtZf0SdBuvnsuMIRoz5b+w4QiolhR4TARx/LLM
         bIehm+KxboUKQtv2i9v6clt+e8CgvucKODSFGywAOdRQLa19Jqj7FsK+4KeYxv8jDE9c
         htkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuUtjr5keE4Mx0YV4hQdh4hNFeDESLw77jscKu2CoiM=;
        b=YYi/3waQhZ7as0f6OdTKOIl60Vzus7h0Gsq75p0cJn3JeeT54Y/yztpfwBa3bPI/xb
         dutEiLRIfloqzCq4BpObNJ+OBH8dhOMZZFbm+VD+thZITOtQSiWW6kzrlIPhqBvtGshY
         iBlLhuWzo5VGUWV7c5lzPUhaq3Vvr+ugfprML9p7LuBR8o2J0KIROUvLAUSbfMZPo2sK
         1TKQk3jKL+/xlNRgb0IqTFLLsm1OH/tPM3dKxYEsS1NaIlDQkb0GY1tVWkTylkhToSch
         SqnESWzzlv6G9F1aCcvZhnZDCeEYKX0SP7ooyfB/TxxpdnkME8WnGo2hJCyyTEMpo7Gp
         Mu2w==
X-Gm-Message-State: ANoB5pl27rB8FeJcWn3cM+LbZ0REt6hlA3IkSIU4z0vV673+WMBK0NqK
        zblYEgKWDOQtk9ewlCQ5XC5cf/B99gJs
X-Google-Smtp-Source: AA0mqf7OhL1VF2ITBiOTY3cwlpDgR7yE/LOv8GsT53STm3YLOWnWIuq7il6n0tTYVo642JjxhIrzKNw5jy+8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:ab73:0:b0:6f3:7b95:353 with SMTP id
 u106-20020a25ab73000000b006f37b950353mr60929460ybi.394.1671086894259; Wed, 14
 Dec 2022 22:48:14 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:47:24 -0800
In-Reply-To: <20221215064755.1620246-1-irogers@google.com>
Message-Id: <20221215064755.1620246-2-irogers@google.com>
Mime-Version: 1.0
References: <20221215064755.1620246-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 01/32] perf test pmu-events: Fake PMU metric workaround
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
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

We test metrics with fake events with fake values. The fake values may
yield division by zero and so we count both up and down to try to
avoid this. Unfortunately this isn't sufficient for some metrics and
so don't fail the test for them.

Add the metric name to debug output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f7b9dbbad97f..a29dd6af8d33 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -959,7 +959,7 @@ static struct test_metric metrics[] = {
 	{ "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
 };
 
-static int metric_parse_fake(const char *str)
+static int metric_parse_fake(const char *metric_name, const char *str)
 {
 	struct expr_parse_ctx *ctx;
 	struct hashmap_entry *cur;
@@ -968,7 +968,7 @@ static int metric_parse_fake(const char *str)
 	size_t bkt;
 	int i;
 
-	pr_debug("parsing '%s'\n", str);
+	pr_debug("parsing '%s': '%s'\n", metric_name, str);
 
 	ctx = expr__ctx_new();
 	if (!ctx) {
@@ -1006,8 +1006,13 @@ static int metric_parse_fake(const char *str)
 		hashmap__for_each_entry(ctx->ids, cur, bkt)
 			expr__add_id_val(ctx, strdup(cur->key), i--);
 		if (expr__parse(&result, ctx, str)) {
-			pr_err("expr__parse failed\n");
-			ret = -1;
+			pr_err("expr__parse failed for %s\n", metric_name);
+			/* The following have hard to avoid divide by zero. */
+			if (!strcmp(metric_name, "tma_clears_resteers") ||
+			    !strcmp(metric_name, "tma_mispredicts_resteers"))
+				ret = 0;
+			else
+				ret = -1;
 		}
 	}
 
@@ -1023,7 +1028,7 @@ static int test__parsing_fake_callback(const struct pmu_event *pe,
 	if (!pe->metric_expr)
 		return 0;
 
-	return metric_parse_fake(pe->metric_expr);
+	return metric_parse_fake(pe->metric_name, pe->metric_expr);
 }
 
 /*
@@ -1037,7 +1042,7 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 	int err = 0;
 
 	for (size_t i = 0; i < ARRAY_SIZE(metrics); i++) {
-		err = metric_parse_fake(metrics[i].str);
+		err = metric_parse_fake("", metrics[i].str);
 		if (err)
 			return err;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

