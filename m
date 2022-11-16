Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6862CEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiKPXj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiKPXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5BA6A763;
        Wed, 16 Nov 2022 15:39:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3865252pji.1;
        Wed, 16 Nov 2022 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJqneQ9QTXZ2Nr4v/IOHJnQH13z85d8cJMd1dVW/GqE=;
        b=WxKKwD9AP6JGdF8rPdym+94KFDGwSvA94zdVTpP+ka2zrbKN9gWpbo85Qu5kRRj2NK
         8n+XifsJRDR+qhtLj4mtLEvSBldPeVCWTA6YBVpy3Xl6kp2U5E6NDEoCG5miB4sfHVL/
         rAUBWLha9hBy1yw3qD2QIy5nArSHWW1BcRwniGjebCpvnDVc56vFjmTFBF5Tm8NIxxHi
         SJUM28Y15G8CsbP0DdfxJ6FJ9L0piqHPDz2Q29+Zib9m1B/VZxqKRborhxpJWV0a8xUz
         i+enn1tFDgSXcO9whAVyT9Yal9vQWakSCVATDf9zwyLaiFQUxeWf6dBNadPAMxMZwMci
         TJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gJqneQ9QTXZ2Nr4v/IOHJnQH13z85d8cJMd1dVW/GqE=;
        b=ej5OJrspps2UddjZ4dzb1ZZHpwrYKB6NWR26Zdk5wEBSPV6sL3bkGjEzApoqe2ndQZ
         Kr/Os2uT5Fg132gF9nf+5X5HK3lQdbZ2Yxnh8+bo1UiISY7RynhQVE5uMlL19RgKXx15
         zI1wTdk6vhqy3RdLL0/i866NrSqPnmpiNVsV41Q2hlYq3MZXLkoJsOgUS6Am4SqOOxDE
         e5str05iddQqLugYlARlaABsqK5ABrMBBYyTdjnpVG9flj2e6v5XYWnP40r0OhrG3Emx
         ZcnkZwATLdEwXsdrBHQHWQ7EW1+pEjOAvoSMyt/mLDAVqLpiV5XS4cMXQmax9nNuuUDC
         o76A==
X-Gm-Message-State: ANoB5pn1QdTdOHLn5VUNrCm4059TdfOwVWl059JVBFz2p0u46I38ZLJL
        fZcWT4fVbnSJSml0dgdbLfo=
X-Google-Smtp-Source: AA0mqf4SOX/goEZRzrZVVjtvlc+p3IGeu2AWbbXN2mfT/ULBYKhWFp4sMWjWN5pZw48RMrJxlgRIBA==
X-Received: by 2002:a17:902:820b:b0:186:b3cb:3b85 with SMTP id x11-20020a170902820b00b00186b3cb3b85mr105421pln.96.1668641952542;
        Wed, 16 Nov 2022 15:39:12 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:12 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:38:53 -0800
Message-Id: <20221116233854.1596378-12-namhyung@kernel.org>
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
2.38.1.584.g0f3c55d4c2-goog

