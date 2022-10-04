Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A475F3B33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJDCQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJDCQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206253679D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a25bac7000000b006bca90f4fa0so11972987ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=k8FQFpA0T/c+Xbz7fhAjiHBmqWsWmKprB3SST9f71Qp4kT1xbri9ZgcVsHwaNeZRtr
         bejspAHwPfJIsJJp2kJz50YdKfHk16keQ6IK28HtPYDEsq8zE7+MoEpuDpu1JQfsmtji
         wITSBI3piimRDYjsx+XG7bXA9h4JKuoy3Mnct+jyOelWdyO3TmYECEh0SANxkytOKfWC
         q4Rm3/dQg7PvrVMPVrWI42G4LW42XQzLFaVCc649VFAcMGpU6A4mfAArFic0KZSW5vGk
         6kSmwIzmNEs3GWVZ7cWySpEpaIrWys9zcwx1dzqzKYtLvIFvIpytImU2pujPnOkVsxPb
         K76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=pxrnrwTci3JoNn/eOfc1QZPoUdTnE9OQIhYAjNJ5f0+km8I3037jipEJNjcNz6HbfC
         jjMXUwxkCSNEyxQ316ZP6Bxb1iCh6a4NW8dDix0Tq3KexQWJNzIwM7o6p+vGDKhf14hH
         C/8vzZNyC0a/B9AcrKoMQyW2llvl42fygx4NxjNnKtT/NeqLkXjrWMb0kZjlkjtOxxkB
         YWkLSVbZZJ1/+A5Lw7isqIOy7ZrD7ilTw9TcEwCZ8IQSApYs74cAfJv6m4yQdUJvbRbw
         TPU6OiKR8hnkG2lVyh/tzAsRBGlC0esHkNqaT/qqpnjN5QxhsyL//mbOY29M62dUILV8
         9oSw==
X-Gm-Message-State: ACrzQf077cbj0ifGk+EwGQVjHduIq8fw6o8BxxCn/BDMXtBo0o21+Xbq
        cuBFqfoINaOD7Fuhu1E7r6UVtrxL/kSU
X-Google-Smtp-Source: AMsMyM7ClnThLImwoCQMaofihdnnXNK230B9JV5y2phDzH/ySXL/f3RMaagMBg511G9rTQKBQY1PNdZb6xzp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a05:6902:84:b0:6bd:1816:ad0c with SMTP id
 h4-20020a056902008400b006bd1816ad0cmr14898502ybs.441.1664849779388; Mon, 03
 Oct 2022 19:16:19 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:50 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-2-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 01/23] perf expr: Allow a double if expression
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

