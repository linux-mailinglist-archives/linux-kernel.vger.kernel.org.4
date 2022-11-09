Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8A6231C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiKIRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiKIRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9B656A;
        Wed,  9 Nov 2022 09:46:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2535333pjc.3;
        Wed, 09 Nov 2022 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekBIIhWuS/McjnSrAfG5owEyQPc2NQJYCb6tIV2JExs=;
        b=qajXQrHHC/YSACOZC+77puLxlEZ+ohDov+N7tJCH2gZ3y9Za4tDul+D9HftTfkXgVS
         ZkADKrCg3t9ZelEiFcPQhAMnNGUAtfUA9sdiVOvaemwZ4em3dfOPrn0a8Hk8Vvib7GwI
         fxAR/TT7JllxYQ/nqbqkFvsCOEnUzVZpOyHeZYl6rb4jXNQBjQtLTN3IYQzBhX/TEpVG
         lReBse2V8JHcaT1M2Uxkpl/dur6oEGwPfbHPU4gX977RFaPaMWdfjnGBSFNeuZiq4O/I
         UhCrUgc5L2HOJOnWaVxkTR/TaMqZBijVsngJa0q68oBfJ83gI4uLwaIYlWxISOoMeSO9
         zEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekBIIhWuS/McjnSrAfG5owEyQPc2NQJYCb6tIV2JExs=;
        b=o6n8JxfBmtCRJXqV6ZIBgbTWLxI+kkVxUecCeY24nokU2KPxz7Jz9gVRRBK5tlmIHE
         Jr8ibdT05mFTXtWIGRwAMI1mZDKsGqQcmq/iHuEuzpBIfwVPCA7B8/wzYwd3M01SlPgc
         V4kABr9OH80579G96JTEju/37OxVh2l8IoCU8253o/tY1S157Olyna+CqX7NS3loT3a5
         3SPbpHbNhrkaXJrPsRZj54vfPr5SJLBgTokSzw6k+ffFzQ8lnD5PhVvIwgyWOHTGARTE
         BfxwLMzYoxPdRbJSIctawIUSU4Clm8+al9NXOE5bVFDuAsfiYeq+RhNmejC2spEc32Dw
         iWMA==
X-Gm-Message-State: ACrzQf1Ze7QRVsxCD8x032/BnTfAAIm9CSGgst9NAQaf5ytRgUnM/qzd
        q6Pu08GSgI6byOb+0eCMJ/w=
X-Google-Smtp-Source: AMsMyM4L0pXYAkYvRkwDlndKpOtM5JFNENBKSObbMv9B8Ghf/sbHxGqCFNkh2fZ3NGB5pyuFwEI5vQ==
X-Received: by 2002:a17:902:7590:b0:187:29fe:bdb1 with SMTP id j16-20020a170902759000b0018729febdb1mr50187346pll.134.1668016004011;
        Wed, 09 Nov 2022 09:46:44 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:43 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 05/12] perf test: Add 'leafloop' test workload
Date:   Wed,  9 Nov 2022 09:46:28 -0800
Message-Id: <20221109174635.859406-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109174635.859406-1-namhyung@kernel.org>
References: <20221109174635.859406-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leafloop workload is to run an infinite loop in the test_leaf
function.  This is needed for the ARM fp callgraph test to verify if it
gets the correct callchains.

  $ perf test -w leafloop

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  3 +++
 tools/perf/tests/workloads/leafloop.c | 34 +++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/perf/tests/workloads/leafloop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 161f38476e77..0ed5ac452f6e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -121,6 +121,7 @@ static struct test_suite **tests[] = {
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
+	&workload__leafloop,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index e6edfeeadaeb..86804dd6452b 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -202,5 +202,6 @@ struct test_workload workload__##work = {	\
 /* The list of test workloads */
 DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
+DECLARE_WORKLOAD(leafloop);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index b8964b1099c0..631596bdb2b3 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -2,3 +2,6 @@
 
 perf-y += noploop.o
 perf-y += thloop.o
+perf-y += leafloop.o
+
+CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
new file mode 100644
index 000000000000..1bf5cc97649b
--- /dev/null
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+/* We want to check these symbols in perf script */
+noinline void leaf(volatile int b);
+noinline void parent(volatile int b);
+
+static volatile int a;
+
+noinline void leaf(volatile int b)
+{
+	for (;;)
+		a += b;
+}
+
+noinline void parent(volatile int b)
+{
+	leaf(b);
+}
+
+static int leafloop(int argc, const char **argv)
+{
+	int c = 1;
+
+	if (argc > 0)
+		c = atoi(argv[0]);
+
+	parent(c);
+	return 0;
+}
+
+DEFINE_WORKLOAD(leafloop);
-- 
2.38.1.431.g37b22c650d-goog

