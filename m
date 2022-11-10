Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16062493E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiKJSUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKJSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:48 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC684E41D;
        Thu, 10 Nov 2022 10:19:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e129so2478809pgc.9;
        Thu, 10 Nov 2022 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad6CYrOOdzs5XimR11K4fWv4D01X6+lyVjHOyaLup4A=;
        b=AZHPUnF1x4GURYsUY6xefpVfUR7702OIutkbc4opdUOJCqeqTkFO99CQu417+Gcp/m
         +Ius47BJMJxks6g4UyQaX2+H0Lc3bEVFhK4xv5h+9pqlVi/5n9JgA1rlANhg+rx7r7oh
         yJW9yjVg4ZeTSRA1OCMry1ihGhzAtGhgPHJaHzyAftBBHeNDlN5Tsw9fzDkInWVoe8h8
         +041TWlJWDneqzBwWZzRQfVBueNXRJOPLqUlPsKYSRtEZztwHS3xSUxuPKPS4Epw3hKY
         a32V5c2C3HXm3+STKIYPplKJSBrx31MhrGTLH3x/VzNV9dNqqDxq/0AqRdaV66hBqBlP
         xGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ad6CYrOOdzs5XimR11K4fWv4D01X6+lyVjHOyaLup4A=;
        b=JuAe4rgkurvbF7s44OtRcF/dyJN+QDwYjssnBEKSIbfRyi1Fa0A3Ru5GeWlfb3lAxo
         BlWKyvqcSAq5HGs6bV+wH6KLk3gsHcYC69SCXBjceORjn5hbTOAlUJN4bN7Ci2zzS+Z3
         BzeCS2SuiVpTR4DpRwf3F8pF6/xgf4sj9268gUn3GyXz48bOAYv9pLfJ7i0P8bowVJ5R
         1Mn1o+PiiCUp9sFjKrV7bMl2VDlDsv5Px0AuYzeGWp8WNaRmqHxPwoVcOMC3ses7qZ89
         P0dJ+mxPTx+Q5Eso6aG4ht1mDIS9R3Mec0e48hQD0CNvMpSbV+PmYlh6jwpUDIZnFWYV
         SIaQ==
X-Gm-Message-State: ACrzQf3xluZ7tqJ7/nlLUeumNZfVMZH/7dajCsnfgoOqY4pH4AgRRtdf
        5r63NBUOm4Fo3j1IbLo+p7o=
X-Google-Smtp-Source: AMsMyM7raWsdKBaEOb1DmXLCfVJ5SfWxgeRHWYrQzhC6DDorcsBuXKc6d+u2v0PQWic3FfctB0sGeA==
X-Received: by 2002:a63:3d4:0:b0:464:527a:5796 with SMTP id 203-20020a6303d4000000b00464527a5796mr3019420pgd.38.1668104374830;
        Thu, 10 Nov 2022 10:19:34 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:34 -0800 (PST)
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
Subject: [PATCH 09/12] perf test: Add 'brstack' test workload
Date:   Thu, 10 Nov 2022 10:19:17 -0800
Message-Id: <20221110181920.84900-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221110181920.84900-1-namhyung@kernel.org>
References: <20221110181920.84900-1-namhyung@kernel.org>
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

The brstack is to run different kinds of branches repeatedly.  This is
necessary for brstack test case to verify if it has correct branch info.

  $ perf test -w brstack

I renamed the internal functions to have brstack_ prefix as it's too
generic name.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c      |  1 +
 tools/perf/tests/tests.h             |  1 +
 tools/perf/tests/workloads/Build     |  2 ++
 tools/perf/tests/workloads/brstack.c | 39 ++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 tools/perf/tests/workloads/brstack.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9acb7a93eeb9..69fa56939309 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -123,6 +123,7 @@ static struct test_workload *workloads[] = {
 	&workload__thloop,
 	&workload__leafloop,
 	&workload__sqrtloop,
+	&workload__brstack,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 18c40319e67c..dc96f59cac2e 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -204,5 +204,6 @@ DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
 DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
+DECLARE_WORKLOAD(brstack);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 1ca95cb0fdb5..c933cdcf91d1 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -4,5 +4,7 @@ perf-y += noploop.o
 perf-y += thloop.o
 perf-y += leafloop.o
 perf-y += sqrtloop.o
+perf-y += brstack.o
 
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
+CFLAGS_brstack.o          = -g -O0 -fno-inline
diff --git a/tools/perf/tests/workloads/brstack.c b/tools/perf/tests/workloads/brstack.c
new file mode 100644
index 000000000000..61c9a9f24b43
--- /dev/null
+++ b/tools/perf/tests/workloads/brstack.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include "../tests.h"
+
+
+#define BENCH_RUNS 999999
+
+static volatile int cnt;
+
+static void brstack_bar(void) {
+}				/* return */
+
+static void brstack_foo(void) {
+	brstack_bar();		/* call */
+}				/* return */
+
+static void brstack_bench(void) {
+	void (*brstack_foo_ind)(void) = brstack_foo;
+
+	if ((cnt++) % 3)	/* branch (cond) */
+		brstack_foo();	/* call */
+	brstack_bar();		/* call */
+	brstack_foo_ind();	/* call (ind) */
+}
+
+static int brstack(int argc, const char **argv)
+{
+	if (argc > 0)
+		cnt = atoi(argv[0]);
+
+	while (1) {
+		if ((cnt++) > BENCH_RUNS)
+			break;
+		brstack_bench();/* call */
+	}			/* branch (uncond) */
+	return 0;
+}
+
+DEFINE_WORKLOAD(brstack);
-- 
2.38.1.493.g58b659f92b-goog

