Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA55F1A23
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJAGGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJAGGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2D12B4A2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349f88710b2so61757417b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=fnDIvUZczAr7Z1Y6TG2yiOr31o50H89ISpQgh/uEsxlmVS5wnUwCgm6Vn0/ExOjuED
         7e/f7AYZJbCg7G6Cb2hfyMe33lqqa3cCGiKDG+IOaukFEuW2RFIgY3Xo//JIgstYagu2
         SNDTzU1alwWRMJd/rBU6z0CKF3lCadMpm/RqRqu4Qif2iSMTycx8JKaFAYFmsLgcNPGT
         g/IQpgyz4DxY7APOtY7p9SQhXDNuB48NzfNQ8CcZKBBEBZ/UYN5KpCcGbdqpRAxGUUzT
         ejU2Gt3B9d7Hq9wglQG5ET35WlC7PzCaSQZANaI6EisukqTb8Gfz4Y/7fStzus6qc5tl
         X/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=vhIW6go0XNyGsBJalmMWZcCid20E/NIcjWMbJN7cLOdLcnJwAkDywikK68dEYj6D0m
         /6aauOaEk3pM2D4IGde1GRCTevZD60L4cVLkBWxt4iSqfbLzsBE82erJXLLju7akQdXG
         CZm/J1HCpQxDttxif0+K8vx2AQKCBQ1xJf7xxYmSrlLsXPVz2uYjgkixvd6aQvcK+Trz
         PZEQyZsnquBS0Mqsrhjf+eMF4gozGHIe/ALkyR/UUnDfuZyvwD5uyurteGegmTe0gxv1
         km8ujJkdRDmvew8vrnUZTmNpjglafiVvPthImkZm7668DqqA+/j+N2OQ4KtX29cgwERv
         5WZQ==
X-Gm-Message-State: ACrzQf3ZYrolBtElCHmcKaCAxab3eWRkQltYWSATh0YTs41/Sv7/uwoy
        41g64LWzLd3NrXBxkeH3NqlWKZ9kDb3d
X-Google-Smtp-Source: AMsMyM7b0i9jRQi1uSKXZQNpVu8mtF3OIb9XV6eL68bps4RFs7fn3CU67eA1uCxMoJoDaTRWAXfxp/MvxIjo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:4654:0:b0:353:980:67ad with SMTP id
 t81-20020a814654000000b00353098067admr11207235ywa.204.1664604405297; Fri, 30
 Sep 2022 23:06:45 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:15 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-2-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 01/22] perf expr: Allow a double if expression
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
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

Some TMA metrics have double if expressions like:
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) if #core_wide < 1 else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD
This currently fails to parse as the left hand side if expression needs
to be in parentheses. By allowing the if expression to have a right hand
side that is an if expression we can parse the expression above, with
left to right evaluation order that matches languages like Python.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 4 ++++
 tools/perf/util/expr.y  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 8bd719766814..6512f5e22045 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -95,6 +95,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	ret |= test(ctx, "min(1,2) + 1", 2);
 	ret |= test(ctx, "max(1,2) + 1", 3);
 	ret |= test(ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(ctx, "100 if 1 else 200 if 1 else 300", 100);
+	ret |= test(ctx, "100 if 0 else 200 if 1 else 300", 200);
+	ret |= test(ctx, "100 if 1 else 200 if 0 else 300", 100);
+	ret |= test(ctx, "100 if 0 else 200 if 0 else 300", 300);
 	ret |= test(ctx, "1.1 + 2.1", 3.2);
 	ret |= test(ctx, ".1 + 2.", 2.1);
 	ret |= test(ctx, "d_ratio(1, 2)", 0.5);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index a30b825adb7b..635e562350c5 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -156,7 +156,7 @@ start: if_expr
 }
 ;
 
-if_expr: expr IF expr ELSE expr
+if_expr: expr IF expr ELSE if_expr
 {
 	if (fpclassify($3.val) == FP_ZERO) {
 		/*
-- 
2.38.0.rc1.362.ged0d419d3c-goog

