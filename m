Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429E62CEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiKPXjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiKPXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFC68299;
        Wed, 16 Nov 2022 15:39:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o7so124904pjj.1;
        Wed, 16 Nov 2022 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97FeOGLA96wHsbLefL56s9RPadISI4phF1+HGdaCPc=;
        b=RwHw2BwEHSGoTMuF7srFdB0iTSrzA5Co9VTFtPfLOesT5GtJEK+x1MBkPa+CtMTuvJ
         OwP4Js8lrEhxWpT3SZD8xoGEHrwrDyTB8ST+vgtBEqKzHk9qGGsOQm7LedjCysHf46dn
         BXhHddbyamCHzJoLz4TV28pufnBQGWda7k+jKuIP5Uk4VfHg9iHzONJSHg6N7bCOWAAZ
         h8euoDw7pWXt7hL2j8HlGCjS/u6zFlU2ipGfe37X7Cn6wcvYthXASQ3LFOaUJQfbJxTU
         CSZIRER9R8jqrCIWrSPPSialTSA64JgvczLcBYfh+C5AGr0ACEh1wYsgSSwNh9XKPr1O
         4aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P97FeOGLA96wHsbLefL56s9RPadISI4phF1+HGdaCPc=;
        b=dA9EXCOF/ypPqEMt1Baj3bVwx0HTHWB44uorK+0d8bvXvq3rDc49czIffWwmEqDoWP
         6VxFeAnwiFyaETG4SyOqU3m4s1BysySluE6Vd8zHXPBdnFdExEM4JsLA4sSZ1VvHTPpb
         GW6WQWlVnd1VETgjZla0ktIHXblyAr6vxYRvKJFVISERfb+4moNzybEYYIxiWKQTLUQg
         JFn5GRsYDHmrPsRtNqFXRX2zmCVDA/MXfgAiMx90AxaVfS9BMCO5UERlrm/r2LDdO/hm
         km58UutlAJXj/tq68mvfxFwiK17H8EZdtNBeAkkJEDoZ2gcCxAOcFd2rdWKf0VTXquCK
         7TTw==
X-Gm-Message-State: ANoB5pkhqwWaNiMULtCwRmg4LKwqcLBUdc5skjvHu77W141Jh/+jXynI
        nJDrTFk3wtR8VDqDSOmrtPpp9rsn3GU=
X-Google-Smtp-Source: AA0mqf6JFIuDbsU0yf3mLlggr6bRiu0ln6zUBgJrjvrseY5Bt5vFt0lDGhKmzve3EXl1M6lBKbHawg==
X-Received: by 2002:a17:903:25d1:b0:176:71be:cc64 with SMTP id jc17-20020a17090325d100b0017671becc64mr53625plb.141.1668641944771;
        Wed, 16 Nov 2022 15:39:04 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:04 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 05/12] perf test: Add 'leafloop' test workload
Date:   Wed, 16 Nov 2022 15:38:47 -0800
Message-Id: <20221116233854.1596378-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221116233854.1596378-1-namhyung@kernel.org>
References: <20221116233854.1596378-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
2.38.1.584.g0f3c55d4c2-goog

