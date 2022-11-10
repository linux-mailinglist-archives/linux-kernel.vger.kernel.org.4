Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADA624940
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiKJSUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKJST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366150F23;
        Thu, 10 Nov 2022 10:19:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so2123030plc.9;
        Thu, 10 Nov 2022 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HtB7zBK4yjfHRJqPzKBOzWxy2usXPdRZk3LDGweMME=;
        b=YvN+8vlKYLlTN09A35Q9vSR20tjer/GsyGD+A/sxIO3o3J7xtlR9usgukuAb/oh7gU
         ROvtX4OSh2AhmONRGDjFo8Z3/IHSUHRSaYSwsc9XjQobbWROTDTF9xJvCSK02gn6rBnM
         6BcYwSzQoyFAEWlqWlxCIeq9H+nkzC7YhRvqIKn6JGC4zOEfLPkRyMufb5R5tTdDT/a/
         +wCiyhqsaFiHBgfREkzHpFZNNeqDMIsXGxoWU6mQu8vy+IKk1wBZku9DBjdG5zs0IS8Y
         3c22cwyiFEbYxV5B0rpAQyM2Y6KHapUvKd3jGMU1ItnO1bGbU0ewEVHZ3H8SJirlekGk
         CrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HtB7zBK4yjfHRJqPzKBOzWxy2usXPdRZk3LDGweMME=;
        b=XsOivvjWciKJxBcClo7SQEA3r/4KlZ/rEGfFqjSo8Xxc4KcJW8DguGCHWlZgkGNtuP
         FT57X5iwH6WfcImXoeQoJGhLeHhslukIMLybqgE2tR1KoJIg6ZgLoiD1bfjLC4L4bXtd
         rmGiWGqEs+9SNFta1/qns6S/akkwQNm/C4KdVHI9o4BZj2EhtLAeAeNA9u31xwcd0CRp
         W9eJr0/IlMbaOf+48sAuRzO+e85fXxd977O8AzJfyWKblAJNTprSqmr3VzjeSduvfvK3
         YzGl03IIRyaketfc7FjzD4KaAA//vvGwOZCBp6nQh+CyoV6bgXCnMwHtB57jKSLdC8GB
         rnFQ==
X-Gm-Message-State: ANoB5plPImx2HfWNMMVvUpYVxZtUPvS3KxVmVBpyoXeZ2FySeXGKvMbg
        n4fZOBRmwaJDO4nz74cnuQ8=
X-Google-Smtp-Source: AA0mqf7wN6PcK5EzUJ5sYgH7J4NSf+XE8zxA0IEpKUHhpnGCsdJmCVXB9rVNCWP9o0ysAhLGL2A1RQ==
X-Received: by 2002:a17:902:f804:b0:188:a1f4:a18a with SMTP id ix4-20020a170902f80400b00188a1f4a18amr1335025plb.128.1668104377358;
        Thu, 10 Nov 2022 10:19:37 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:37 -0800 (PST)
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
Subject: [PATCH 11/12] perf test: Add 'datasym' test workload
Date:   Thu, 10 Nov 2022 10:19:19 -0800
Message-Id: <20221110181920.84900-12-namhyung@kernel.org>
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

The datasym workload is to check if perf mem command gets the data
addresses precisely.  This is needed for data symbol test.

  $ perf test -w datasym

I had to keep the buf1 in the data section, otherwise it could end
up in the BSS and was mmaped as a separate //anon region, then it
was not symbolized at all.  It needs to be fixed separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c      |  1 +
 tools/perf/tests/tests.h             |  1 +
 tools/perf/tests/workloads/Build     |  2 ++
 tools/perf/tests/workloads/datasym.c | 24 ++++++++++++++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 tools/perf/tests/workloads/datasym.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 69fa56939309..4c6ae59a4dfd 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,6 +124,7 @@ static struct test_workload *workloads[] = {
 	&workload__leafloop,
 	&workload__sqrtloop,
 	&workload__brstack,
+	&workload__datasym,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index dc96f59cac2e..e15f24cfc909 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,5 +205,6 @@ DECLARE_WORKLOAD(thloop);
 DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
+DECLARE_WORKLOAD(datasym);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index c933cdcf91d1..ec3cb10c52ae 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -5,6 +5,8 @@ perf-y += thloop.o
 perf-y += leafloop.o
 perf-y += sqrtloop.o
 perf-y += brstack.o
+perf-y += datasym.o
 
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
 CFLAGS_brstack.o          = -g -O0 -fno-inline
+CFLAGS_datasym.o          = -g -O0 -fno-inline
diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
new file mode 100644
index 000000000000..ddd40bc63448
--- /dev/null
+++ b/tools/perf/tests/workloads/datasym.c
@@ -0,0 +1,24 @@
+#include <linux/compiler.h>
+#include "../tests.h"
+
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1 = {
+	/* to have this in the data section */
+	.reserved[0] = 1,
+};
+
+static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	for (;;) {
+		buf1.data1++;
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+
+DEFINE_WORKLOAD(datasym);
-- 
2.38.1.493.g58b659f92b-goog

