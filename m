Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73737132FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjE0HYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjE0HYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1110CE
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56552a72cfbso35640437b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172228; x=1687764228;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW2lbdpPJdg/r6QP2GPnX5xgemELHxkJ0mClCQxJlXE=;
        b=uzUf12s9yhSlYHSWmPiamqaCVuzarvHr//Lm3DeLpVKdny3NM9/V4jdSVhPz97qJ2Z
         zXDz7kmXqMq6TuJ7kVtu6iRDSxuMPsaktdVicJl/2LUt7mvU3hkvlS0RZ/PUFMvHEdRb
         bmkiZnQCjYARbtk2klizoAF+iHSJecfkOgsol1lce+OFn6dTQYFH6UcHaoK+QEFhK66+
         VvzxQpV/7+xHnJXmQDDkJHX0wKljLw43fqnRKTSqkuah8ckch6ocmsbLAmcnIZ9tFRxt
         Brvk0DA3A5NajeZfU0Lefd1WNkiI/yZ3oJshq/nzIhM89W9QU3/+Tb9/ZE0leh1MG8iQ
         RETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172228; x=1687764228;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW2lbdpPJdg/r6QP2GPnX5xgemELHxkJ0mClCQxJlXE=;
        b=K3T4A5RB0qmpdr06Kr0UOjwZv8A9rYUbCEAzB4Cj/lXFRyrj8PoJme3YXUfIKutoCF
         4srDoozDDYUQ6KOMweY3Y0kbf/5+tjedQ9Gf6355kbm8qTrv4iUJLJjS360qMuGlZx+Q
         zzpRR/BlgAKaYVr1VTzFbcJ2dwFI2SrIo6EdyZQyg0qwResyYI2+5oVwj2UlHPHJ9sme
         3liDCOOKKPusy14u+tKSeFoq9bRfChTbpURUPYKPbvciHgg0xjOKezm3G2GcBWBbc4gU
         HcdfdXB08v6mtUZ8mt/3Mypuz9nZHTjtgCNMgItq9ZKj0adIVoRYbDmnQmyiMNCuMwct
         mtFQ==
X-Gm-Message-State: AC+VfDzOkX+3+vdzSjlg5VO9EWcK+SLaIRPKx/wUgFlgJOlnGGqrZv+w
        7dssJYGBYZEWYU1ILu3gKQ1nqd3xj9L4
X-Google-Smtp-Source: ACHHUZ41cQH6jnf4yOyAOqUAG71xGg12eViK6KDqDuQxV2LkUGIWW0ZK2l5nXD9R1+F00kcT4YFSjXiekF6n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:c90b:0:b0:565:9abf:e057 with SMTP id
 o11-20020a81c90b000000b005659abfe057mr2579814ywi.9.1685172228274; Sat, 27 May
 2023 00:23:48 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:08 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-33-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 32/34] perf pmus: Add function to return count of core PMUs
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_pmus__num_core_pmus that will count core PMUs holding the
result in a static. Reuse for perf_pmus__num_mem_pmus.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.41.0.rc0.172.g3f132b7071-goog

