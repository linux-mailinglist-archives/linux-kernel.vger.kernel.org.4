Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355162CED7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKPXjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiKPXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47321FC3;
        Wed, 16 Nov 2022 15:39:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so5351pll.6;
        Wed, 16 Nov 2022 15:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH9ILVQPbpPL5nSTMa8Bnv/nrDrzsZ52M2SrwHw2PME=;
        b=m4xEihDdJqYogfuBZBlfb0sBJb6BVfmFoJ0L4OO2IG7JBsAgYc93fODmV0/AxhfgZh
         hQj+9tZt+V1ZtSBTycFanMzUEdnRcjh/HaHESTLM94kztVf3I9gC+vKqm7828ptyM2s1
         RYTJzTxbgNNUjNdVrC0Gt9t/G+9U4AddQBgCD+aCtOE+2CDQ0WHvWd09ArMzuQGXBqws
         kRgzNpbjEzRRypSGxmGWwJEcuLuDkTYGzDfbDi+vDDtM61/WcrPwfo0NiuHQIHk3STK2
         hGkNJN0e+u3YZ/74WS52L3zIvbip+4WUCQtbYA5HSJ5RNeSG/ef844hR9vrsOUdxlFRG
         XT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tH9ILVQPbpPL5nSTMa8Bnv/nrDrzsZ52M2SrwHw2PME=;
        b=CdEZLhwaSPLlVxYIcf5uY5+1V6CVcBP0+hx53aEknUoV6wRIzIfOTWuCUuibW7Yjvk
         a7n0uQF9WZIRJYsIwZO3I90XqsGERhJ6W/hyUKwrqxhzqfJNIEQHiQ+rK07IjSI1kfHS
         4dmBYPthD45mIlrYOw6bpnbWRBiU/ND4UL1REnDzCOaOFIkvMD7j/m82KMe6/oSt1tpH
         /j9OzcX+EyxOJQqIMFkBmOsAJSPIvtoNhZOrtf93Tkpq2MN/J2IJjh/JJEpCmh1RdfVO
         iqb2n5VORq4Z+gORiQrjo9cM6hhLqdAB3uyKyGkkM6xPU5jO/ApUwGg/Hqkh/btKYOWh
         Ke8Q==
X-Gm-Message-State: ANoB5pmIr+AE2mScaQfz1xUa4sMPSdAEGdrU64Ukk3nrDGlmt/bg2V7m
        KuVNO0K520qtfBo5ik4zKyA=
X-Google-Smtp-Source: AA0mqf7wakGRAbzzF8EobA6Z52wqDVm6+ZbXPslerm7wazfWAn0TCPv8fAU+wN0BoSXxsxf9adwtxQ==
X-Received: by 2002:a17:90b:368d:b0:212:6a0b:7d55 with SMTP id mj13-20020a17090b368d00b002126a0b7d55mr138810pjb.16.1668641939546;
        Wed, 16 Nov 2022 15:38:59 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:38:59 -0800 (PST)
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
Subject: [PATCH 01/12] perf test: Add -w/--workload option
Date:   Wed, 16 Nov 2022 15:38:43 -0800
Message-Id: <20221116233854.1596378-2-namhyung@kernel.org>
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

The -w/--workload option is to run a simple workload used by testing.
This adds a basic framework to run the workloads and 'noploop' workload
as an example.

  $ perf test -w noploop

The noploop does a loop doing nothing (NOP) for a second by default.
It can have an optional argument to specify the time in seconds.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build               |  2 ++
 tools/perf/tests/builtin-test.c      | 24 +++++++++++++++++++++
 tools/perf/tests/tests.h             | 22 +++++++++++++++++++
 tools/perf/tests/workloads/Build     |  3 +++
 tools/perf/tests/workloads/noploop.c | 32 ++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 tools/perf/tests/workloads/Build
 create mode 100644 tools/perf/tests/workloads/noploop.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2064a640facb..11b69023011b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -103,3 +103,5 @@ endif
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
+
+perf-y += workloads/
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7122eae1d98d..ce641ccfcf81 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -118,6 +118,10 @@ static struct test_suite **tests[] = {
 	arch_tests,
 };
 
+static struct test_workload *workloads[] = {
+	&workload__noploop,
+};
+
 static int num_subtests(const struct test_suite *t)
 {
 	int num;
@@ -475,6 +479,21 @@ static int perf_test__list(int argc, const char **argv)
 	return 0;
 }
 
+static int run_workload(const char *work, int argc, const char **argv)
+{
+	unsigned int i = 0;
+	struct test_workload *twl;
+
+	for (i = 0; i < ARRAY_SIZE(workloads); i++) {
+		twl = workloads[i];
+		if (!strcmp(twl->name, work))
+			return twl->func(argc, argv);
+	}
+
+	pr_info("No workload found: %s\n", work);
+	return -1;
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -482,12 +501,14 @@ int cmd_test(int argc, const char **argv)
 	NULL,
 	};
 	const char *skip = NULL;
+	const char *workload = NULL;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
+	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
@@ -504,6 +525,9 @@ int cmd_test(int argc, const char **argv)
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
 
+	if (workload)
+		return run_workload(workload, argc, argv);
+
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.sort_by_name = true;
 	symbol_conf.try_vmlinux_path = true;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5bbb8f6a48fc..d315d0d6fc97 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -180,4 +180,26 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 DECLARE_SUITE(vectors_page);
 #endif
 
+/*
+ * Define test workloads to be used in test suites.
+ */
+typedef int (*workload_fnptr)(int argc, const char **argv);
+
+struct test_workload {
+	const char	*name;
+	workload_fnptr	func;
+};
+
+#define DECLARE_WORKLOAD(work) \
+	extern struct test_workload workload__##work
+
+#define DEFINE_WORKLOAD(work) \
+struct test_workload workload__##work = {	\
+	.name = #work,				\
+	.func = work,				\
+}
+
+/* The list of test workloads */
+DECLARE_WORKLOAD(noploop);
+
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
new file mode 100644
index 000000000000..f98e968d4633
--- /dev/null
+++ b/tools/perf/tests/workloads/Build
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+perf-y += noploop.o
diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
new file mode 100644
index 000000000000..940ea5910a84
--- /dev/null
+++ b/tools/perf/tests/workloads/noploop.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int noploop(int argc, const char **argv)
+{
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		continue;
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(noploop);
-- 
2.38.1.584.g0f3c55d4c2-goog

