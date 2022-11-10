Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FC624938
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiKJSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiKJST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F22CC95;
        Thu, 10 Nov 2022 10:19:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u6so2113123plq.12;
        Thu, 10 Nov 2022 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eCEQ/gN18j+U28atVDeus3N47A3I4Dq4PXONaj/eF0=;
        b=U+bveVg5rcJYPgdAm17Yn6Ci8pYhuEmQnL1xPLDEDJYg5zmqo1CyCEyNJrXpWhPri1
         3q7PbUlPu4EreGCjYehZOplu2kEN+TMalV3/GLYAwLtRqqYbt9wMsrH2genVGzkcqVpm
         KlogBGdFVs/WsW2pS+cMyL8EHktL0/LAyxJ66uKaObT9mfXERRyi0wBVXkg8dp/NdS/3
         1LV934RmAnuzclQaA+V7mC5aWp+9uRhtQVHX3CU6sHlcUsefHQWy7ZyC6WIt/rleL8f1
         sF5V/p4mq9GxC1e/3hAe7uZ5cZrFc+4Al5tacCTv5TcAcYVIcuym60jW4tCruvXdmq6B
         hQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3eCEQ/gN18j+U28atVDeus3N47A3I4Dq4PXONaj/eF0=;
        b=ivL041gnqNZE2M1++jX+MQ54umg/WllHwhvoNHFEF6UiLRdthYQHWU05VXSRBVS/me
         JHG2RFsfH5EsYWhrM1UDvruKD9esA3py8sUn5YMEknEKCe9odTXjuSNR/yU/06ci/P4C
         tIjFA8Er2nwwmWJMpe6htNRkIkJ74t1TQf2hRMsX6bdJ+2n3SZFKOIP2e9sQ9cFoQRTr
         xGn60MyTasIDb6KZeorFiKpk7MG+hSdu73y245iVWAb7Mr/hYmB0LqYyc2bjNXgXkpq/
         To+QIyOTcH/biacL7QEmkE95kuFQQbpJtjqD7ZUaCul0G0fWKDhlZZEj7Z00Rvg4iokD
         jyKA==
X-Gm-Message-State: ACrzQf32vlbI4ZbGT7d/F4BwDufSXIr52tjLmacZatJ7rKV0TIBR+ppz
        dOcaz3HTpY0I+5Bk2YNUvek=
X-Google-Smtp-Source: AMsMyM7e4WZr71wN64utn8t5s9p/LAb7JMIl0qch9xoJQPTuIdJKAbdBbr7oSLxtU2PfFNa8C3onMg==
X-Received: by 2002:a17:902:e8d3:b0:187:3c31:fb3a with SMTP id v19-20020a170902e8d300b001873c31fb3amr1578266plg.38.1668104367126;
        Thu, 10 Nov 2022 10:19:27 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:26 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:11 -0800
Message-Id: <20221110181920.84900-4-namhyung@kernel.org>
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
2.38.1.493.g58b659f92b-goog

