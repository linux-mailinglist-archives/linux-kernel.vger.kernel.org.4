Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E0712F53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbjEZV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjEZV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:56:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157910A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso2654863276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138112; x=1687730112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/X9gvmqqlTr2f+usNH0lBMlck3ST4ivZvyTzKecxnA=;
        b=65p+PGvBBSTJXTUKvDEvTX52HLsGXIN0McqSA3HwufIBaYpAFamqKbdTBekOVORjpa
         XIMfWf13BpPomeVwm7X6wOpkxIzD6mo8f7RMl9P4el5HI2pfv2TQTpZnC71TqLue0dcw
         64PabADsTap6OYPsTjKY/P2VrnxsMgTm0pAo8vTnP2FrD4gJ02LufnzRDYAzeqMOgprA
         6i1tNW9chg3NqfKbX8111epyJTQrR4TmfUkWg8USza2ed4z1SJmJZBX265DJ/n2Y1e/t
         2uTSQutHDnb/DzVvRQkorC7zHfcQLLNKQ6kRPr7fW8CJCjS5m/YRSJ7VxLOWBG/6XZ0X
         pWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138112; x=1687730112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/X9gvmqqlTr2f+usNH0lBMlck3ST4ivZvyTzKecxnA=;
        b=UAzKWK/GhEgdQACUP3ZGf2Xr5k69V+JQMYwhfNoYCmZPbmk5ok9XFssOPlj4S2Bcne
         l3qCfQ1OmMZu6LZQPW6qCdRERYCXdS7cyzaBPoOYRxBvtvvzingCDM08orBa4zZAxbiq
         Lkv4NpByp//CbeQxZUDQs+Mfc7BSTfbptvyo+WzcNFn3GesJnm/V03viFreohygVczdN
         iUx41HPv8uqdiZmY/VzFFwm7EvOpj5nU0XixepHOqvFgPbT+C3/BwioKI88wqIMzDkQF
         F761Of5bV2odd/+jsqmIbevivU3dsqvEWm5aEQuA3diC+WMeP6zb3dRXYuS3hh7VGgGj
         zGAg==
X-Gm-Message-State: AC+VfDyVVr7vovTuGUjZIUxeL22xNHL/1Sdkom8Ak1jyUopLAzihlLp7
        xwZpOLBMdXbMcNAPT8YKMUSwqIwCqai1
X-Google-Smtp-Source: ACHHUZ6gxH9Jydh1jcuLGZQPtV/wofR+I6ueG/3SpSJ2Pp7mGx6yUANCLB0wC8G9bjzuKqk+P4ubuDM6L3oe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ab13:0:b0:ba8:757c:2523 with SMTP id
 u19-20020a25ab13000000b00ba8757c2523mr1699724ybi.9.1685138112380; Fri, 26 May
 2023 14:55:12 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:01 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-27-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 26/35] perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
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

