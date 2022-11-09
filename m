Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E56231CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKIRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiKIRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:47:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712367676;
        Wed,  9 Nov 2022 09:46:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l6so17422611pjj.0;
        Wed, 09 Nov 2022 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf7pwJ+tSfBXBsT3Fnhwy44UrI7lbOL4kA5MHT45Zio=;
        b=Pdcq6EHiScmcD4rAn0pVStsuOUCS5frBTuOuSUYbRSYhCbYuA1wwygpj/cyCGCspBC
         4pIEJpigZQbZ+dQFaksHOqxhREZ/HUzc+qlvxFL6cyYPre53fk91cTcoDnCy4Uy/uy8e
         Hib0zvSKRklbBL5wfnHazsaAu/YUeR5vVehk3VvuQa+rcsFrR4lm54fLFi6YtuVcQB5q
         9yOVCYHqVaWbYst3NRLNA0D/l1rzQ9K4CiWdRucyGUS9ON0tlTELaSj7s2zJuRutBQfB
         7lW0uQLuwJOFH3+yEjRwZ93mvTDtMLLvOokiIm1esD7RwdT/S1AUJq8Ozo62lUoSdHZj
         Rz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qf7pwJ+tSfBXBsT3Fnhwy44UrI7lbOL4kA5MHT45Zio=;
        b=lq9RpoumCu9IcwMuT6RXy58Q5DF3O9duPG8JCxI60RHmurbi1NwvpZ/PcbERDdzeJ2
         /Kokiicb2kky/VkiT19CBvQ3Uoxoohd269Ffuyh4yoDVTT1t8SJCa4ID4uAvOcSPRbGV
         UgcPEEpyDzInmhwEoGkbtNoiGxGSWvo6qML/tPnsk+M7JQd9lfkJPaU/lybe06qs62o9
         KRIPsJDAwTTSrdcANScXGbOV/Brdbu9Mr/5VuqZjLEh/7V1SSZU8N83jYuX/WPTdq3UX
         WLBvpxAIhxk87Gr8nGZne+3G3Fp7vKBmDBbMmbjw69khnsmxND0wmCEjy7ZPoqt6v4MW
         6pFQ==
X-Gm-Message-State: ACrzQf3L2QcmATXd/n5Faqa/FCA0XXETz1+iyLeDXTvh9c+oPsicUezO
        37IMgUU/Xq+DgkO9o2D/DNo=
X-Google-Smtp-Source: AMsMyM5Q0pgxR/3dUuiJftmQ8Q2+O9QzRiEWhvcMDTBjcqDFZm9QZHUC92uzrxCdk4e1xo1SJAei4g==
X-Received: by 2002:a17:902:7894:b0:188:6300:640f with SMTP id q20-20020a170902789400b001886300640fmr1043883pll.124.1668016011817;
        Wed, 09 Nov 2022 09:46:51 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:51 -0800 (PST)
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
Subject: [PATCH 11/12] perf test: Add 'datasym' test workload
Date:   Wed,  9 Nov 2022 09:46:34 -0800
Message-Id: <20221109174635.859406-12-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

