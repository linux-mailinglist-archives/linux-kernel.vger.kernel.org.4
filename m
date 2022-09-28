Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046915ED5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiI1HWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiI1HWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D46D4AA8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11-20020a5b038b000000b006bbf786c30aso5431058ybp.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=81iZD/KjBhpoeGQ+S/uNTxM+rkrd0csqvOOXWQp9mO4=;
        b=K3aj25mQeCEr67uzUal1vZWSNL6qtA3SQhrPK8U5dF7hwoHRLqnvYRv6mkJz7sptW9
         wYP53BLVqDd5BDYrkADheENe4FDfqyL6Em4XbZ6Jn47U2LekEALv8y73woLiDkf2S5Cn
         H/3TrP4uYNREs6b70Y4XRVrt0O8ld3nOK7QbSI7p3w90Q/vOVEwAUBa7/sPtMXqrfypj
         fcT1vRKaMJunHNFEaClbrljCxMKvZE9qhV4pELO6sazMfNTKkdTdzX3uZ8UQ6yglfcLk
         hBoM2nM5t9gezq8RLq2OkuZK9vXZ3CeCuEDUHunkmL+j1nm+mjZIA+KN5m7hKFAM7Jwj
         hiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=81iZD/KjBhpoeGQ+S/uNTxM+rkrd0csqvOOXWQp9mO4=;
        b=05Ies3GGCnt9WL5B1RwZjQx1U2iuLL19YDlQLcMkzPWuhv5IRmV+9fROZYlI307O7R
         yhbgnPHA1k5KOYXNSntJDdSUPzz8j3pkbn4J6o1dww48VYh26sVKzhKaSixSdTYt72ox
         u/LztSrK8T7w3wd9jbN5nMy+E0EMVEy3M+7b5klGj3FOI4gx2fjvw5UfuEKiX7TGlS6S
         9U9Q227yWH3Yr3XpSRH/xResKkicDIBpiHCReoO4gjJWo+OBOoWjg5z0KJ4T55+lviYy
         dDFvuzYN1PFncT6TUBrhvLVQK03Y9ZD7Sp6r1yOIyu2btFw340ZNVQ1wfPp0hxs93WlX
         pshg==
X-Gm-Message-State: ACrzQf1ORxcsX99/9J3cc618G70Efxq9p++f2zye4sr2gBkYc//0rD/H
        WAB/9pCR04/b7pGKL/1itkEl6yntwERj
X-Google-Smtp-Source: AMsMyM4pWVB4K24YlTjfeGCB3I8vBwx5hoxpcRGrFbJzi+ituvNUwmpKc0ywXnoo/vg6CS0JLNeJ9vPHFilX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:8606:0:b0:349:17ad:6998 with SMTP id
 w6-20020a818606000000b0034917ad6998mr29184875ywf.409.1664349731475; Wed, 28
 Sep 2022 00:22:11 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:43 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-2-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 01/22] perf expr: Allow a double if expression
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.37.3.998.g577e59143f-goog

