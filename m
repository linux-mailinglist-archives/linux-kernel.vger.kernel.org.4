Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AA62CED9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiKPXjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2ABE2B;
        Wed, 16 Nov 2022 15:39:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso291845pjt.0;
        Wed, 16 Nov 2022 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV9u5PxVvqmV+BpGh3+8lIJe2BvSUrc7KFHFFdwiD9k=;
        b=EVKtp/j2eht2QovsgJ3wqzLdIVzxwPf117oXwcO7GIUJ/wtopHywSHAnzOfQblWHN6
         BEf5plioroWg37zahPDrFKtc/LNRP00oiuvXIvtid1oQhMfQNxcRMncKJqOa+vVNXgnX
         GH8UhH6mLTz6o9facoKElJxdlnahcWuuXolG0MMqVUimnsgXfszfvX0MW63x2Ehbw6+r
         3Ed4Pjx2Xc6EWtKFnxWdg38XyYjxSI66Xy/0jygfpGuMla3WzhIXEW2qzYM1y5eJBzmM
         tm9uNu3yghimo91s2N1j83lWijAQUyZXwnhX3Ham5tg9FYQYJATBfu8+US5hkTaE4dEd
         ckxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hV9u5PxVvqmV+BpGh3+8lIJe2BvSUrc7KFHFFdwiD9k=;
        b=IBqfZBKwbk80EoXXhiezYIRG81FaFRCow6vbbVDox9K3Cxzsbg9WbYqgGvdl+1AfXo
         QpRgMiYklL3PQwBqNyDwMRvNXEtCqpr+uzWEUZDcaUWEMp3Me5cXRo3JIciLmbQbqF5F
         iDHPCRyNj+ihd1rvPrwue3xG5Hf0R3wgTxGngLOwtUGHbAAoxiRgfB11XDomua5uytIH
         /vw2biqj2nio/02tboSY1Pc6tddVgYjm46AcWJn8172D4sFXT/bfUbJi+Y7yTA2ByqGh
         jkLnBm+QjMzsEnANrmHxxRHnpUIX3JtGKWEQufnNbqSHxLc+HRMzYN5PqPfsElys6xbl
         hN7A==
X-Gm-Message-State: ANoB5pn/vIbXhN1D0sbB9QaktagIIMoUiWspOz0dnzv7eOMK9L0DPl+3
        7LPfBufAW0GMNjTsu4Y3ytw=
X-Google-Smtp-Source: AA0mqf767LTaMdwMaWH+aRivTtdCQayAYW29msLhpm4aLuGABU/qGDuj1sv/xVt2hfe8pIQrvZXqEw==
X-Received: by 2002:a17:90b:1892:b0:218:8f2:5af9 with SMTP id mn18-20020a17090b189200b0021808f25af9mr5982135pjb.65.1668641942168;
        Wed, 16 Nov 2022 15:39:02 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:01 -0800 (PST)
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
Subject: [PATCH 03/12] perf test: Add 'thloop' test workload
Date:   Wed, 16 Nov 2022 15:38:45 -0800
Message-Id: <20221116233854.1596378-4-namhyung@kernel.org>
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

The thloop is similar to noploop but runs in two threads.  This is
needed to verify perf record --per-thread to handle multi-threaded
programs properly.

  $ perf test -w thloop

It also takes an optional argument to specify runtime in seconds
(default: 1).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/tests.h            |  1 +
 tools/perf/tests/workloads/Build    |  1 +
 tools/perf/tests/workloads/thloop.c | 53 +++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 tools/perf/tests/workloads/thloop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ce641ccfcf81..161f38476e77 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -120,6 +120,7 @@ static struct test_suite **tests[] = {
 
 static struct test_workload *workloads[] = {
 	&workload__noploop,
+	&workload__thloop,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index d315d0d6fc97..e6edfeeadaeb 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -201,5 +201,6 @@ struct test_workload workload__##work = {	\
 
 /* The list of test workloads */
 DECLARE_WORKLOAD(noploop);
+DECLARE_WORKLOAD(thloop);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index f98e968d4633..b8964b1099c0 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 perf-y += noploop.o
+perf-y += thloop.o
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
new file mode 100644
index 000000000000..29193b75717e
--- /dev/null
+++ b/tools/perf/tests/workloads/thloop.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <pthread.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
+static volatile unsigned count;
+
+/* We want to check this symbol in perf report */
+noinline void test_loop(void);
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+noinline void test_loop(void)
+{
+	while (!done)
+		count++;
+}
+
+static void *thfunc(void *arg)
+{
+	void (*loop_fn)(void) = arg;
+
+	loop_fn();
+	return NULL;
+}
+
+static int thloop(int argc, const char **argv)
+{
+	int sec = 1;
+	pthread_t th;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	pthread_create(&th, NULL, thfunc, test_loop);
+	test_loop();
+	pthread_join(th, NULL);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(thloop);
-- 
2.38.1.584.g0f3c55d4c2-goog

