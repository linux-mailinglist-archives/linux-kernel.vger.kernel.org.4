Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41FE62493A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiKJSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD03FB9E;
        Thu, 10 Nov 2022 10:19:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so2134173pll.6;
        Thu, 10 Nov 2022 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHtWNAtYktOIgs6nS4lgKw2kHSGAY/bbpUgRU4xzJN4=;
        b=Gevv+KwMkjgHS2suEvRfwl6RP6NVEJKhevUXMwlZFMjF36LmwEb9/uz/XbrZgFTnEF
         Tz66g6Hk499lJj5AnGz7kf+ThUsM/vJuF8K6Vt7d5dWKlVb+dRs+dxlpgqyVciJFoEsY
         XHOonL/LjQOJDxQP4TikKootOuwsLnkWQUMvbfdnsUSCn+vuOdXt8P0He7QzqsMpWqAx
         UV8kpmMVgXtBe1VRjkuxW7CUDWk6BM+RhrOkOvVmKA6Kmz+04zZsPkePUr/xJqf/yRwO
         UEiVBp51lN+8BIHTknuiiB+rqfaO9UaF9qc8Ah7QMpf139uAKZ8fOL7OfPnZi0OJTIAZ
         +jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHtWNAtYktOIgs6nS4lgKw2kHSGAY/bbpUgRU4xzJN4=;
        b=4iECDwwJjWXoDNudzRwjl6OMBkuNeww4TC9tofHmJDmvlvi7h6NVt2AJGFq8AmozHx
         /9sT48pnOkWwxUq9oQL4XomFlg56uYaB3vd2Arc8FO2aXrQvkUl/2MP3BDoagJoaZC4S
         uZIUJPKsBuZJzUODU7WRniHdcjgXjFH2/DHZEi8t0uNpdt0EqRlceUk6GlBDZJMQ61zs
         gDdTBr2uW8ihIpbXps4BWlU/3Rx/WYCegmZHFUmASCTjOF/CAQTjMkPkuSBxSDYDol8G
         cOrnw+3Rjs9azoHVX3RlJR8b8q+sBibZ4XxFYFAR5mEHbo/N015l3c9tuxDdohnaTLXX
         kcPw==
X-Gm-Message-State: ACrzQf0TCZ1zWgTWXg7Biyk0gd88mG1+1wUrFRUisy1+VTAutFt48Z+5
        GmlfRxhWw2Wyl9gxzQNlZvo=
X-Google-Smtp-Source: AMsMyM67QKfvvRH4OR2DBkVnY/hgIfm3phtLvJ17+NM9/hTCb9JCMfZb1DAlc+XLdLdqsIUDlSKvgA==
X-Received: by 2002:a17:90b:1095:b0:213:ee6a:f268 with SMTP id gj21-20020a17090b109500b00213ee6af268mr54565898pjb.213.1668104369654;
        Thu, 10 Nov 2022 10:19:29 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:29 -0800 (PST)
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
Subject: [PATCH 05/12] perf test: Add 'leafloop' test workload
Date:   Thu, 10 Nov 2022 10:19:13 -0800
Message-Id: <20221110181920.84900-6-namhyung@kernel.org>
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

The leafloop workload is to run an infinite loop in the test_leaf
function.  This is needed for the ARM fp callgraph test to verify if it
gets the correct callchains.

  $ perf test -w leafloop

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  3 +++
 tools/perf/tests/workloads/leafloop.c | 34 +++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/perf/tests/workloads/leafloop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 161f38476e77..0ed5ac452f6e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -121,6 +121,7 @@ static struct test_suite **tests[] = {
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
+	&workload__leafloop,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index e6edfeeadaeb..86804dd6452b 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -202,5 +202,6 @@ struct test_workload workload__##work = {	\
 /* The list of test workloads */
 DECLARE_WORKLOAD(noploop);
 DECLARE_WORKLOAD(thloop);
+DECLARE_WORKLOAD(leafloop);
 
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index b8964b1099c0..631596bdb2b3 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -2,3 +2,6 @@
 
 perf-y += noploop.o
 perf-y += thloop.o
+perf-y += leafloop.o
+
+CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
new file mode 100644
index 000000000000..1bf5cc97649b
--- /dev/null
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+/* We want to check these symbols in perf script */
+noinline void leaf(volatile int b);
+noinline void parent(volatile int b);
+
+static volatile int a;
+
+noinline void leaf(volatile int b)
+{
+	for (;;)
+		a += b;
+}
+
+noinline void parent(volatile int b)
+{
+	leaf(b);
+}
+
+static int leafloop(int argc, const char **argv)
+{
+	int c = 1;
+
+	if (argc > 0)
+		c = atoi(argv[0]);
+
+	parent(c);
+	return 0;
+}
+
+DEFINE_WORKLOAD(leafloop);
-- 
2.38.1.493.g58b659f92b-goog

