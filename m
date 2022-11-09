Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D935D6231CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKIRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKIRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:50 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADC659C;
        Wed,  9 Nov 2022 09:46:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b29so17354695pfp.13;
        Wed, 09 Nov 2022 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ybVelHPiskCNH6fllR2RvI9SCAjZ5b8Tt7/oz7w9lQ=;
        b=geMmBOuPjKLU7pZSlNSnodyozLusn2++H+Pw70vxMxbmq15wKDGv6FL5Z/ll7loMfO
         mykYxcAlwZu+6RuzIUfhDrT4FqpyCcE6ArZQs+zEorfLZKbKzLQxNfzje7SNyx0BiM+k
         r1s9Jo9YixWegrENQn2JhWwexzwFrbZqqxt7vgD3ciVF775rFb+LZVa0RXSFnDE1ejWR
         p2LspXjdsXc1Rr1SeQKdKUk19DcSc5gxX0esRx7M4RA5Xb/rRZaokVDKpU2wkNnYR5j6
         l0BEFwS64dW3GjiMKfidGR/FsI31Hq3ARg9vRtkKbn/oOefG1QFsoDnU4/zme6KSRCfk
         kk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ybVelHPiskCNH6fllR2RvI9SCAjZ5b8Tt7/oz7w9lQ=;
        b=uh+eq9DYtTmyBE2o2SoMUGQBj2CIX/fE69/Geul6vfPVJ7/AfW/bqzqjQwDWA4gP9P
         uEXXGIw4EvS0XwpHIegyK9IsXxH0hWj+p4K0dlJq6pjX5CcVcgSKHRNT9G96bSu1LKZG
         cMFM8xAtG5L+Mf9sFpKm16FVHRkbU+kbIxr8Zvtdd/Jr4iFzNG6SkdyI0lbpfQS+ZwTz
         6GCX8luIkJe9FzcViGXkTvYHs2OHNEGpVrJy31D7siGjC7Y3VhcaqLGiYRxojM/I7/96
         A0hjjaH2uSOU71+3l0z5IvhgwImP7/2KlA9e704ORsKbp1UQ02tk7d3ERYuKZSWTYRdo
         98Pg==
X-Gm-Message-State: ACrzQf2gmbp4xy+5D96KozoCiKx8SKKxvsVzh7LeDleHbt9Qa71d7n0q
        HzmLqoPAqpHSxQpSmMWH1PDYJICamuk=
X-Google-Smtp-Source: AMsMyM68dIkYNdoIe11g5ikpXyS4mnncrLtkdb4tGofE+urFF1T/3A897D65pznzj70ZuL+6pm3CaQ==
X-Received: by 2002:a63:1206:0:b0:470:18c:1489 with SMTP id h6-20020a631206000000b00470018c1489mr36187235pgl.357.1668016009081;
        Wed, 09 Nov 2022 09:46:49 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:48 -0800 (PST)
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
Subject: [PATCH 09/12] perf test: Add 'brstack' test workload
Date:   Wed,  9 Nov 2022 09:46:32 -0800
Message-Id: <20221109174635.859406-10-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

