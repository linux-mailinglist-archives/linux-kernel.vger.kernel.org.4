Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD75062CEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKPXjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiKPXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039169DE4;
        Wed, 16 Nov 2022 15:39:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so351264pjk.1;
        Wed, 16 Nov 2022 15:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrmrlQ/AAcwA49LE/YDY46PPOq6RVCXtH2b5XWXmDxM=;
        b=kZxKAA/bYyDmZeiqQWpjQlx5Kuapaak/srJrdnnSr34iHO7OOG4s2scDN/NggUyplA
         WnW0G9RfXpKUdZvaBl2at/8BHTuNprGrX3GMHM41HL6kTJLgV0gz8/yQzcPVIWDHoO6j
         o7BdNm4EQ0WSoKttavUuVT+ooYcZR22QWckd2FnvBU0PfQA5uw4OJuh2BtgUBQNMPLlb
         b9ECm+UifdukICwjg9xx4/5NKnjivUO2/VdlQgsQ0SDEDaInfmAokAtkynsPLa335h+I
         ONiO3suG2LF60BkuT2HADwVTcPkui5dNLk9BSxesH57tW3M8HS3nS35G9dIk+dIDn0u0
         Kk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrmrlQ/AAcwA49LE/YDY46PPOq6RVCXtH2b5XWXmDxM=;
        b=U9nefKhMrqHTTgBgvW3q6dHMdQcPjI5MQOsu+lPQRr+b9WWCgxZmWQlSyToOLug339
         /uxH7zTB/mP1MTuayH/s+OubvyYmNiN8pqkQvB3AebiM/SqW4DCqwT3bnCATM0SnA1eA
         nkUX5dG1qb82VWCwhFUeJi0atRH9/HBgRneTeuSCgNLP2kgCSkvAe/d9exqu6Vrmfczq
         TeGVWII02HWZ/0yJjpF0oRlDt4RGY5SPDQI1uJa9cs/UNMMinqIte5uDwGlxiHD2aOwx
         W/WMb6r7cDoZ2SAKy2GJAED0KpChQJMJp9uPMngO0Jx3tuygexfgk98+LcOkla0U7YhG
         t1Pg==
X-Gm-Message-State: ANoB5pnjypEg348gOzyOeu6Kdzh8C1AKjj5jjBfP3xAf5hjZ6Wg0xboY
        abDkf2Djnb7zI9az02hSqCg=
X-Google-Smtp-Source: AA0mqf7cjG++Khnb+FEVk8Zv13uaFJtKWpTthQ0JJmVTbmkTYJBcLdohAh3J2FwiVIgts9nSZ+orXw==
X-Received: by 2002:a17:902:8306:b0:187:31da:a27e with SMTP id bd6-20020a170902830600b0018731daa27emr72012plb.111.1668641950027;
        Wed, 16 Nov 2022 15:39:10 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:09 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:38:51 -0800
Message-Id: <20221116233854.1596378-10-namhyung@kernel.org>
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
 tools/perf/tests/workloads/brstack.c | 41 ++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)
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
index 000000000000..cd0386d58f97
--- /dev/null
+++ b/tools/perf/tests/workloads/brstack.c
@@ -0,0 +1,41 @@
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
+	int num_loops = BENCH_RUNS;
+
+	if (argc > 0)
+		num_loops = atoi(argv[0]);
+
+	while (1) {
+		if ((cnt++) > num_loops)
+			break;
+		brstack_bench();/* call */
+	}			/* branch (uncond) */
+	return 0;
+}
+
+DEFINE_WORKLOAD(brstack);
-- 
2.38.1.584.g0f3c55d4c2-goog

