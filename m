Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768D706BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjEQPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjEQO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F69A257
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae438721e2so6207915ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335555; x=1686927555;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lI6N+gAi4DZYSVnV114efDFeKpz0k1rpLH9njpuRINE=;
        b=VdO5yX2Mtt3uOQ2AaB3Q5XB3czFjGwA2fovuTpWU7v+Gys7pziSDULWXNnQnlh/ldX
         UsKgUfZMpG91Xnv9oI5e6wggea5KzAsJPtPxE8sZLF+lQzDMwAXieu242N1cDu5tDpVs
         ybGHBKCWMbZv4qCIoIGwZaS9SreYC50E/lUnTL/BV9dwCxbeU19Cj/vXXYJby3ymcVp+
         GDwq2Y82oKaD5BzJjUw/5ROkCjU6mMtDcgXzkPjeU4Qb+w6eRlVNvQPa720O9CaXo4Un
         TbnNL0SBw2RnLKa4hoWLJNhL6ftP84siAsYyzFR9c1s7Q2LdSa6DcZnNYI9pu/RSBgMm
         hSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335555; x=1686927555;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI6N+gAi4DZYSVnV114efDFeKpz0k1rpLH9njpuRINE=;
        b=fBWNL4scUE3/QsLYp4ylzENOn6MltrwpIEoYqmSquYw0e7qVtw5gRDJ/d3JxiHRrWG
         foROZjZMwIrxr7z9gHH7Zx3EdfVdO2QU3HUZn9GmTD+0nEfTSg43sJkw9ZD78cusQ1tv
         vZwVWPpo/F1H8MiOJyrJJxS7mZHQSp5TcAvpdFpErr381tq0pdjT7lPpDklFDZqwf0Te
         zOh9Tk7Ck2znYg/9zrPRP33t71yqHr2BmEyZp1OYixSjqmZsXx9sOghkVHEQ/E7mWx8h
         kb17XBN0cPegQRiDmLS96tdQ1MAK6Me4f2/LxD4kMPATKHj5hjR7i1EA0wxy1oUbs3am
         2efQ==
X-Gm-Message-State: AC+VfDz1J279kQWPVaXD/q/oBatM0hgc9+295Lvu2B57ISAwSDyZgRKZ
        AR6tMmxqjRklOomdZiZFExwuTexg+u/i
X-Google-Smtp-Source: ACHHUZ6tg9xCmYqqW9Dcj2t83D3ZIEdg28KNdMklhDpiZRaz2/Kct1tJYmDNWbltkBzSuqq/mfchZfLPgg1h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a17:902:8f98:b0:1ad:c1ca:55ae with SMTP id
 z24-20020a1709028f9800b001adc1ca55aemr6879014plo.13.1684335554831; Wed, 17
 May 2023 07:59:14 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:57 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-18-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 17/23] perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
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
        Raul Silvera <rsilvera@google.com>,
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

perf_pmus__for_each_pmu doesn't lazily initialize pmus making its use
error prone. Just use perf_pmu__scan as this only impacts
non-performance critical tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/pmu-scan.c     |  6 ++----
 tools/perf/tests/event_groups.c |  7 ++-----
 tools/perf/tests/parse-events.c | 11 ++++-------
 tools/perf/util/pmus.h          |  2 --
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index f0f007843bb8..f4a6c37cbe27 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -40,13 +40,11 @@ static struct pmu_scan_result *results;
 
 static int save_result(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	struct list_head *list;
 	struct pmu_scan_result *r;
 
-	perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		r = realloc(results, (nr_pmus + 1) * sizeof(*r));
 		if (r == NULL)
 			return -ENOMEM;
diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
index 029442b4e9c6..3d9a2b524bba 100644
--- a/tools/perf/tests/event_groups.c
+++ b/tools/perf/tests/event_groups.c
@@ -50,13 +50,10 @@ static int event_open(int type, unsigned long config, int group_fd)
 
 static int setup_uncore_event(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	int i, fd;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		for (i = 0; i < NR_UNCORE_PMUS; i++) {
 			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
 				pr_debug("Using %s for uncore pmu event\n", pmu->name);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 72a10bed84fd..277607ede060 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -108,11 +108,11 @@ static int test__checkevent_raw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
 	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		struct perf_pmu *pmu;
+		struct perf_pmu *pmu = NULL;
 		bool type_matched = false;
 
 		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
-		perf_pmus__for_each_pmu(pmu) {
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 			if (pmu->type == evsel->attr.type) {
 				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
 				type_matched = true;
@@ -2243,13 +2243,10 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	int ret = TEST_OK;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct stat st;
 		char path[PATH_MAX];
 		struct dirent *ent;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index d475e2960c10..257de10788e8 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,8 +5,6 @@
 extern struct list_head pmus;
 struct perf_pmu;
 
-#define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
-
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
 #endif /* __PMUS_H */
-- 
2.40.1.606.ga4b1b128d6-goog

