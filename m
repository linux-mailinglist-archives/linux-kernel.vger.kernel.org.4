Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45F6231C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKIRrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiKIRqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A4658D;
        Wed,  9 Nov 2022 09:46:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y4so17785934plb.2;
        Wed, 09 Nov 2022 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBUNwJw8FX8rn3PRRIvOQe7nPqm7jQrsYrGMfNGV4Y=;
        b=N7hi0Ju56islhgWrcdkWJHhaovavX7G1GB77k8hhFvFgTeK2+kW8/lySo/LpamaWiz
         rujAMtlTGNFUxGRxTXhGFGm+6BO6wD6atL17wzrbndNR/TP8MyRHKJa1NbooE6k664nw
         aaX6PiwSnguFKqpHSrGK0PkeAnIup4ExEEvBMr7Tod2P480tWqRZMj9yXVAWmurKOtu9
         Gnm1p+PrYIlnaExBn8lWxVCmOegiuVClACay77JEX5GspRCytEeNH8wJ4hye3OEa8UB5
         oP6mF43j3K6e5zx66KqpYJDlhSujy8VLfxcrVl3HXjCyTkgxCYKvmfzvhURbLHKHg5Ak
         MWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiBUNwJw8FX8rn3PRRIvOQe7nPqm7jQrsYrGMfNGV4Y=;
        b=6PEDzGdeYBk8XzTnZajkWb/H8ByQy1I8E3UP455GGNKkAExFiJgNFuVzTlzZUwWYHZ
         akz/7eFD9U24/zW82lYu/WIUNPU6GMP8V/qqi0GDzsjKDovgGRuipk4c6KPeTmy2GkHh
         x6BN+8TYLyjsasYDtH98yDmPBBxQ4DceuzY8DYRakB/4iD/DRui3gAlFtpKkluV9xBC8
         IBXonDPX/lQQRTwQ4ggn2a8n7Q9SlDkIax6LFEp0FyTOXUxzPklSMJ+PuzgUKwDtooTI
         A9b1xVK93h0HVJyBJKVW4bE6GEZ2BMG+r43eWsdzn7XF1PNVZMEbjn4M6jk8seEG2ijK
         RY3w==
X-Gm-Message-State: ACrzQf1IMuYZZR0DK+rN3hQvyS331C4mkytCWXLwqHOcB8VGtk762fpz
        Q0ZYQFoV6gaJsSJ04I32HW4=
X-Google-Smtp-Source: AMsMyM6Ljbe0cmvEL9GjkRhVO9FkB14Sd81CEaL6x2lAQ/e0cwEPzujjxelmbNvEe0emkRGcrYvstg==
X-Received: by 2002:a17:90b:84:b0:213:de0c:1253 with SMTP id bb4-20020a17090b008400b00213de0c1253mr55573904pjb.74.1668016006644;
        Wed, 09 Nov 2022 09:46:46 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:46 -0800 (PST)
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
Subject: [PATCH 07/12] perf test: Add 'sqrtloop' test workload
Date:   Wed,  9 Nov 2022 09:46:30 -0800
Message-Id: <20221109174635.859406-8-namhyung@kernel.org>
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

The sqrtloop creates a child process to run an infinite loop calling
sqrt() with rand().  This is needed for ARM SPE fork test.

  $ perf test -w sqrtloop

It can take an optional argument to specify how long it will run in
seconds (default: 1).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  1 +
 tools/perf/tests/workloads/sqrtloop.c | 44 +++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 tools/perf/tests/workloads/sqrtloop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0ed5ac452f6e..9acb7a93eeb9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -122,6 +122,7 @@ static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
 	&workload__leafloop,
+	&workload__sqrtloop,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 86804dd6452b..18c40319e67c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -203,5 +203,6 @@ struct test_workload workload__##work = {	\
 DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
 DECLARE_WORKLOAD(leafloop);
+DECLARE_WORKLOAD(sqrtloop);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 631596bdb2b3..1ca95cb0fdb5 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -3,5 +3,6 @@
 perf-y += noploop.o
 perf-y += thloop.o
 perf-y += leafloop.o
+perf-y += sqrtloop.o
 
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
diff --git a/tools/perf/tests/workloads/sqrtloop.c b/tools/perf/tests/workloads/sqrtloop.c
new file mode 100644
index 000000000000..f7d1f8d4867b
--- /dev/null
+++ b/tools/perf/tests/workloads/sqrtloop.c
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <math.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include <sys/wait.h>
+#include "../tests.h"
+
+static volatile int done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int __sqrtloop(int sec)
+{
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		sqrt(rand());
+	return 0;
+}
+
+static int sqrtloop(int argc, const char **argv)
+{
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	switch (fork()) {
+	case 0:
+		return __sqrtloop(sec);
+	case -1:
+		return -1;
+	default:
+		wait(NULL);
+	}
+	return 0;
+}
+
+DEFINE_WORKLOAD(sqrtloop);
-- 
2.38.1.431.g37b22c650d-goog

