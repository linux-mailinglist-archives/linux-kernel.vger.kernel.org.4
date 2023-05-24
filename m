Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783CE7100CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjEXWWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjEXWWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:22:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D29DE6F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:21:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-255dfed764dso765811a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966792; x=1687558792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtfIK0Ng/M2Pg4C34SglSHaqm2V1d201IwuIsvGzJ2Y=;
        b=jZqOUs4khalhefWZA9ZH5Cd3Ak1pZuDgONShr5OBFfs90o9+6fZ+v/uPtshEsqbn5D
         cSeOiEQMwnIcIpdU4Q9uR4gXcwb67sUxfNNC6qgG8f+UFz+3ChzROoXCnoGdMTgpHS5j
         fKudJ7McBlaqp4uNamm9fScATnN3d//SXLTOCFVT2WAAIzGn+4ffUzdWYkIw+VZB5O55
         aAq3mAUfDSxUhzH00Y5i8001CewqddXbVpPRVEXJrQaq9Ij2DKPsdrDvX992n2uziLlo
         qW/TBZCbnVYFlkw+ZvwdbbEFnTlA+wBYepun9M9kdevhU8ALCHQ19BTnnoJBQ4rWdozH
         CXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966792; x=1687558792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtfIK0Ng/M2Pg4C34SglSHaqm2V1d201IwuIsvGzJ2Y=;
        b=YCAFO3eSEj9RfW9Uhgx87rt9u/1/qlbIiuxRG2WHIoSUyPDpt+W91m9MkKm9dxjqDd
         zw4TCwFdEJZznp9OuiWfK1LmTvuiyskbYsdPmGry6cMroFDPzeOkbpOJhRlRaEiaU4rQ
         86tGL8HGp0r2FdQ9RN+6g7VPbmdoyg3GSQrxBiO4R042n9ZkIjfpxFxyN1bGnuT5Wwjx
         ylzGGHyAqCyj9yAZUCQtXnsNM9Ig7v5HVoWQrHDSVBwUeDr+csp+vyKvam7WftidD12C
         rIwpY2Hh64P9FuzoJDw84UaoHrpbDu8ps67p/S5SKXfeWmTdPlbTw3jJZZx05YRhejIl
         Fgvg==
X-Gm-Message-State: AC+VfDx/K+4cUMppeJx1BaLkjmqmmpBbziwp+9ne7m7/md7nsO3Vv4Vj
        39Gj1cIvvnbs/TUSas0E3VvQManG6N93
X-Google-Smtp-Source: ACHHUZ4Gz3sOCvjHJxUs0XNMvaqhY/GCtlI3yryh2ai00McLuG0za9EWtTnr4ygxbEv+fbo273yNoWXm8EPG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a17:90a:2e12:b0:253:2388:9d44 with SMTP id
 q18-20020a17090a2e1200b0025323889d44mr4425400pjd.9.1684966791898; Wed, 24 May
 2023 15:19:51 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:29 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-34-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 33/35] perf pmus: Add function to return count of core PMUs
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_pmus__num_core_pmus that will count core PMUs holding the
result in a static. Reuse for perf_pmus__num_mem_pmus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 21 ++++++++++++++-------
 tools/perf/util/pmus.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 6ecccb5ad03e..bf927aed162e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -229,14 +229,8 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 
 int perf_pmus__num_mem_pmus(void)
 {
-	struct perf_pmu *pmu = NULL;
-	int count = 0;
-
 	/* All core PMUs are for mem events. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-		count++;
-
-	return count;
+	return perf_pmus__num_core_pmus();
 }
 
 /** Struct for ordering events as output in perf list. */
@@ -488,6 +482,19 @@ bool perf_pmus__has_hybrid(void)
 	return has_hybrid;
 }
 
+int perf_pmus__num_core_pmus(void)
+{
+	static int count;
+
+	if (!count) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
+			count++;
+	}
+	return count;
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9de0222ed52b..27400a027d41 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 bool perf_pmus__has_hybrid(void);
+int perf_pmus__num_core_pmus(void);
 
 #endif /* __PMUS_H */
-- 
2.40.1.698.g37aff9b760-goog

