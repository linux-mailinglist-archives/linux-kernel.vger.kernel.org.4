Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC662CEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKPXj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiKPXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DA45EFA;
        Wed, 16 Nov 2022 15:39:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so3852823pjk.2;
        Wed, 16 Nov 2022 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA+6dbtIStadvAuHvkrtYwI6bvKg5btHy1tHp0RwTqg=;
        b=HlsotV8aYsxQD2uYpIDy78RWOA0mzRu/W+zWyjxi3barQ6sK+PrklVvZwCCq//9Sqf
         2QRwLW9mKrg7cPawjIgx+WjS8CBpEYZrnfkD3N6IkDmd3kmxeX63m25lEl1c+RlF354d
         tj/4oHywEqQtiGOj3Xmd9NQypUbG3JLFq0fxQ6918Z/FPslJN1JLMPk7x8NpYss9p4p9
         pvzuO+6g8ms2JUU7fHeEKCQUOq5FuLfPr6lTYcJk1lnTZ62Kki+pTdiyC/cQZ+/Yee9G
         HnxgYcqxFQWzWKnUu2j0gfrwa8KL19IZ2Ihex65+MgRNDkzXMOZxmcOQnnDGNZqizgta
         P6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TA+6dbtIStadvAuHvkrtYwI6bvKg5btHy1tHp0RwTqg=;
        b=x+q/tY5tWY1lfL5RxKyFamCXdiuJXzPXvNPbvYwy2BG2g8qBJPtG9b6cy/BsOwqR1d
         Xs0PqlOt5iXeJXZoXIJlySeGt3dV+Z/wKlaCil/roUud+0Cikr9oPJO7dpQMszUCuHet
         +DrKpz89bxOw6CQ4ia7BXyOJGC0R2ZCq+oanuTi6fKtRv0OgWd1zxSrDvYoHrVMY/nzp
         UwDfwkDkU0HnJSSv9B5wmbMC2s6TAVYs6NhJK+frSl4zYH3JORFBKg2m9pJTxRSa+rww
         NjROxbyFSqo5VWu+FnZiQaeNGIVayJdTpXAZAw0cleluwcsfR0FoywNrsyd/ebWHWhM6
         gBsw==
X-Gm-Message-State: ANoB5pmx0iUl4c8QC3uJ0N9MhL+VmrjPcyPPTI24vulzaXPBH1h3m539
        gqdvWblSbtOWCqAGZvOsnd4=
X-Google-Smtp-Source: AA0mqf7Vn6lesHlX0cQkbSy3rKJXFx8OOkBflWz2AiejVIHJ0I0kNsZ0M8uLlR4oAh8HllPyEBpVhQ==
X-Received: by 2002:a17:90b:3c45:b0:20a:db08:8a8a with SMTP id pm5-20020a17090b3c4500b0020adb088a8amr5991480pjb.141.1668641947510;
        Wed, 16 Nov 2022 15:39:07 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:07 -0800 (PST)
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
Subject: [PATCH 07/12] perf test: Add 'sqrtloop' test workload
Date:   Wed, 16 Nov 2022 15:38:49 -0800
Message-Id: <20221116233854.1596378-8-namhyung@kernel.org>
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
 tools/perf/tests/workloads/sqrtloop.c | 45 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)
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
index 000000000000..1e44d541d737
--- /dev/null
+++ b/tools/perf/tests/workloads/sqrtloop.c
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <math.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include <sys/wait.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
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
2.38.1.584.g0f3c55d4c2-goog

