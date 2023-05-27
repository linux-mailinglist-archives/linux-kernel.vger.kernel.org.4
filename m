Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2E713306
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjE0HZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjE0HYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B0E6F
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:24:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso3765126276.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172212; x=1687764212;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/X9gvmqqlTr2f+usNH0lBMlck3ST4ivZvyTzKecxnA=;
        b=UTkcJQ9GTUFWqOw4t65r0kAx/Mx6gHHo8eOf727kRPDSLg3gf1V12c0nQl4Rw6RcE7
         qwxGnstbPTmoD5SkfmoLO30OxMYksdku4Tjxc7CgcChh8mg2KZv+SJ0n8ynHs/6D5qDR
         sUphbhIbwTECY+2Is/YL9cp6N16DUIWuu1H5r3y4IaD2Vc09i+ijmH/HR4Uwy0Chvc3x
         1Uj0LgzxnynlXuXTjoPoGKOW2clftwwB3s5QpS4c4iVreAVB2x6pb6zBge1vUM6Pk6oV
         yszE0oPFETlXYzAmV6uho2aIhX8UmJzcslvOc+8+HHo4XOgNzYFbEquOsQgYBFbrLnnX
         IeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172212; x=1687764212;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/X9gvmqqlTr2f+usNH0lBMlck3ST4ivZvyTzKecxnA=;
        b=MA2AalReyLKlam/V9sqsRR/ACizYQ9KzNewtALj8KV5vMJPMBI1rAAcyZTT7lW2DBQ
         anNIG6O+0r4sSGtR21NiyvQ5bKGrOEDgNnjObMFL69LP28lacm5JEnHSjPetk1RpV7Ai
         dgUNWMRKN6JCL5gU23jD7PuxoyHOAd6LmDJnjCaI2m52YbkxSDfa2NvT4ElIpJ0Pl60d
         sKVyANSlm8+ncoFFvX7j/pPvLpmeFHlCQf7iPdenxErU8/Dl1QaaxEeTEVT3znqYRmZy
         1F0IpVKjBTNSbbFOYMlFdw4U6z82Fusz2XhaWgiUouPrOBMSjUaVoYwnHT5IYhOWPLee
         4Dkw==
X-Gm-Message-State: AC+VfDy1jy2ZMi/ZqP66KUonFayK4co4H5pGMUBKhAo9/Xb6AwFgpCft
        R9YFFH5stvXPE8pOga+l4GSqOgt1V8qH
X-Google-Smtp-Source: ACHHUZ7UFBeHBnGcRXmqzitpI1HYPUDBsZrd+2dMBDXrKlieLbDHs54akvgYU2i/GFPg8zIqQQSHaGZmAbNr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:cb94:0:b0:ba8:1646:c15d with SMTP id
 b142-20020a25cb94000000b00ba81646c15dmr861617ybg.1.1685172212148; Sat, 27 May
 2023 00:23:32 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:01 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-26-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 25/34] perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
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

perf_pmus__for_each_pmu doesn't lazily initialize pmus making its use
error prone. Just use perf_pmu__scan as this only impacts
non-performance critical tests.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.41.0.rc0.172.g3f132b7071-goog

