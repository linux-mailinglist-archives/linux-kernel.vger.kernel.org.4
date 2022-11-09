Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC46231C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiKIRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiKIRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C36564;
        Wed,  9 Nov 2022 09:46:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d20so16706910plr.10;
        Wed, 09 Nov 2022 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltW1NL6crc5wy8bAufvr0Jgln5Zric5U8i/XdEa5r40=;
        b=gdfIDNhB+L6bLNfS3tYGVrMP040UPxU3xcv07PvbQpwl3aI1kp1ypWz4uXd+lgmsNU
         xO1IhwXON78OaxPX0kwjBvB1XSV4vOAXOJYbogttT97vRDCl6ZGsQRS5iW0AAjv4g8gM
         rMiRKwAbHL+lI/do+kPVHt9+qXIxaNiULWROn7T2ECLY8w6Lmt9++vXqXCfnOY2QlHjx
         dzdArNc/jKrAyvVXqOi/zvrxm2wnGh1gufkim7rrcZyspeFIkH+Go2DDlWipDZap5m+n
         /3c3goyPvQjUlGKpf8Mj1Cw8b106rjy9VxgMOTiLm7Cda0lTbukcP3ORubOEcNmHf7zC
         z9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltW1NL6crc5wy8bAufvr0Jgln5Zric5U8i/XdEa5r40=;
        b=5aliL/+hHm5hPzOQCuIAmyGP3J3I+o4JW544Nh4IWUWNw92luh6INrNSkJKiLFitiw
         RGFq/BGkbuAVzJBFgJnFHJB653n0+JBNHAc2zc1nhC8pLMxE9ne8b9czUqzOFjcWLzIv
         z6Ed3ieg3v4+a/xU+zksD6u05DOXeOOwLkLeiCIx7vRlaEy5A4Tb49tJEBO4jG+6uSUs
         LkLxK4OLIzHGUEUrSwSq8Hj0eJ7CF9AKGMKDeJjPWbFW+NUwf6rC03VDhkvWPfP/9PQ+
         /Xuyi+kgVGArUf3cTemneQ/zoS1AGQ+cvzg1nPkYM3iW90UaJ1BbE3iyxShW/SGg6LWc
         pXYw==
X-Gm-Message-State: ANoB5plI3cYRcPFOmbb/9CCL1I1MY8mpBsWgvHR9TAKfuvk4lnMlZUbW
        yt1hon9XQmiV8yx1QGQhP3c=
X-Google-Smtp-Source: AA0mqf7YMKxoizS0Ti/lXZI6QSguQLf8k5nx9HETGPk6+0RWKBA4O+l4pTYh2A4XHCO17REFK/GDtA==
X-Received: by 2002:a17:902:9042:b0:188:6fc9:1da with SMTP id w2-20020a170902904200b001886fc901damr25549304plz.162.1668016001395;
        Wed, 09 Nov 2022 09:46:41 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:41 -0800 (PST)
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
Subject: [PATCH 03/12] perf test: Add 'thloop' test workload
Date:   Wed,  9 Nov 2022 09:46:26 -0800
Message-Id: <20221109174635.859406-4-namhyung@kernel.org>
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
index 000000000000..7fd3ac79e732
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
+static volatile int done;
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
2.38.1.431.g37b22c650d-goog

