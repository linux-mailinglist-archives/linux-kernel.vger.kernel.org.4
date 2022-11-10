Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3096624936
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiKJST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68E2DA98;
        Thu, 10 Nov 2022 10:19:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j12so2137420plj.5;
        Thu, 10 Nov 2022 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLcUTxbLtqLuMUkFI/k4r25Yr8S67Z4Vfuw/WeAxT6Y=;
        b=bJjHtuxzKMmrpA6C4f74Xj45etv76YATl7sotLoqR+RIWOmDkl5S67hur0dTpBHA96
         05B+BjwCOgN9OnP3snuwa0rpmlY+0dJzWqnJpqOISDK2mhq+Ii5brX3JMQ6mCgFm0hmB
         yaYqesgOxrDLOuVSr6R2ZCusZU+N/iIJ17nXP55nL6GpXHYsl9z2kvYtL26hbsQ0/SaZ
         48a9GUVBgV9ryjY04kdBgMU9rC45KoQ4vVivWtMGoVczl6UuzstkQPSI6NNdEShIZ4Gl
         qPzYQdrcphbGA9C3Dh/LLE75LS47OYCoc6nSkURhJBfryXdZjbpNiorcoPCEEoYtQYhP
         XDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLcUTxbLtqLuMUkFI/k4r25Yr8S67Z4Vfuw/WeAxT6Y=;
        b=muN1uRgaD4y9GqRtp7JURk9YxxkZr5IWd3wkcrvu5r9LVx721M0HlxP7gre2XA3Sdq
         tDqNiCKGI0ZkmCw90EqENRwDOBZE1sERlKliZy1HTrGg4zROFmSIhQrFqQxEL9dKptN8
         ZtaIoevBgZ4ANHNrjTFHcYHuZS5J5eJvP7ij/lOUj28VDkv06M2+H+qKGLD3sJdlfNER
         y3q/bZ31oWY44DYtHQTXQ6YN+alAzT5udis0xW786DOJns+Y5epvGeDxzJSt4NGV6IJT
         3/080Ai8HbH029tYUX9/LeDZ6iHG4pHfa8E7eAOVROikyfea0WhFomc3nRqr4Vz9fJT1
         0YIw==
X-Gm-Message-State: ACrzQf1sneOZzJW64B7+mHFS1yKA/gdoJ4pvbXSPoFvqfuheM1PHr7Yp
        QwjMjcaikzG3dwmEcSimOd4=
X-Google-Smtp-Source: AMsMyM75BTqu06GcTyt4Q9H+YzvlcGLBg8s6yqtWnfBYVE8/G7iIrljOANOXVdWCZzqnReFkCNCJ4Q==
X-Received: by 2002:a17:902:c946:b0:186:9890:97cd with SMTP id i6-20020a170902c94600b00186989097cdmr1702287pla.104.1668104364596;
        Thu, 10 Nov 2022 10:19:24 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:24 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:09 -0800
Message-Id: <20221110181920.84900-2-namhyung@kernel.org>
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
2.38.1.493.g58b659f92b-goog

