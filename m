Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC0162493C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiKJSTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKJSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26394D5D7;
        Thu, 10 Nov 2022 10:19:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2356494pjc.5;
        Thu, 10 Nov 2022 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+pmvI1xzgAYs9HEK5XMlqqAdnFzxXTz0mFIAnH5WiA=;
        b=SXm8mv6NhXkEOya2FyhrKvEY7h4ot/P2kILLaBZ0B0zd2kgRzil3ENBZ3nxemj+gd2
         3+7DG8IkQC8GdijkxvT9uJ9AnAFBGY003LnJSSY/RZ9qih0QPESFalwtrwyct5Z2kOZP
         oeOCk2vKNcAv3mAU0wjlCtOfh90nsxfHKcvyrb1jYR0yFMBfvNrXUzvdmunO/pN4PS9q
         PfFD9S0RDoH3PCtU7RoJuNeJpw6hboE2MuwDTyaYD8CN+hPTRloqjHKTHAnaxqx6/LWZ
         USa+SwanrSyOlpOdSuxyHJ/9e7NXrYUSIVVmFqxqLHG7C2davi6R595U39abpjp9x6p6
         N10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+pmvI1xzgAYs9HEK5XMlqqAdnFzxXTz0mFIAnH5WiA=;
        b=o0IwPXBxK/prIErlHR58LsnDq9xxAQtydgmjnF0fMJ24b/o03FtYnzjHOGfhQU6gES
         wj56GYZTVRwA5fUylj0Pg12U6sSmIRsPDBsoIpeRt1HMg5LNuQxwjMwBln1kXdf5mhHl
         rVQ5WkezY3YSWy8R7GaKg6ePmn7p586xScbSV974sGeNq6JAp6JChyt/ZXxNe5fC/8/u
         Qldj/+PTDaDPjkX730qS1TGhLM7/clVpydERtxIrYDfmO3yNeoHRTh1XxezJR1bf4mrl
         kIrkYb8sTzunRkH5cCGZn4bSeIETtvt7+IKaS7OXW18lhhu8DxZyQhqTw5NqTUD+ZxCq
         Vleg==
X-Gm-Message-State: ACrzQf0d+kChtwru2oQSRRUR+x4SERw22HEGxXOE3lJdcQ0dRo9VqP6z
        jZv+qi63a6nXFzPTL9TWUd0=
X-Google-Smtp-Source: AMsMyM6LLC0QmhwUSYLJ1aItNWdYbc07z1zOtI900fqR1z0U7nSnkGayfchsn32F+1ah8cSkp/Xcmw==
X-Received: by 2002:a17:903:3293:b0:186:867b:e24 with SMTP id jh19-20020a170903329300b00186867b0e24mr64818447plb.127.1668104372255;
        Thu, 10 Nov 2022 10:19:32 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:31 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:15 -0800
Message-Id: <20221110181920.84900-8-namhyung@kernel.org>
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
2.38.1.493.g58b659f92b-goog

