Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D207100D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjEXWWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbjEXWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:22:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A54E78
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:21:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5308f5d8ac9so493440a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966794; x=1687558794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/iZTM2aqbni2uB+Hg7SvwR++buyFhodRiSlbt2iVyU=;
        b=dLD9deZmA02GoycwjkRiVoNs/vnDMedu8HA7qp1GXV3CIClVgku58vrDCICs08/ckp
         SMqDYuEqxXRARF/PupH0uIzZ8FHajKJVVyKpX26+qtwuUpRWjjNfEaBwkkQ22HfYPtGJ
         sQaJXyZtNGE7Mig1m7xblEtlVG/meWQDhxdcajAXqYaVPCkK6iSSvI/lWkrn5wZk0a5a
         NouJjzmVv8GafduVjcLvGgdR6vE7bpmmE76AIi4Z4kXcnATkOE04I+YP0i5+YCDO6IGd
         2CvY6HReKB1Nfx56CHAYF5tJQ5oduOQX9YbLk73NlIujYs8EHhFWXtqyvrWImXU1l4Ak
         aeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966794; x=1687558794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/iZTM2aqbni2uB+Hg7SvwR++buyFhodRiSlbt2iVyU=;
        b=X9TME1ruGCUBOJ2aANOPoLR5ZWrl1tO6FAFS+AlkLHSpvhXzt0VM14MEy+2PnUM9Kv
         gJxkRK48Zt4T+tJlXdldoLBQhc1K6Q1EiwpJ1syv8jZo1/XJE0m5k/84Y14Axa4Bc7U1
         vjf6opNEQ0XkehNvSWZyxmT1eicKoe/iEM6U9uqXRPdZGAN8gJp69mkfDKf3ztvnPRkB
         tD5RHuW9z0bf2xCJzTwkWu+1nqxe6gpVJfLMxbWxhnFuBf47d6zJn/mShOCb4HcaxdjH
         H1lwekjaziZGn9RbahQ+hx2nKP6eLeFmQ0UlEr8Sw+AhrlfkYMjeHD2W04gNSfYRPw9a
         qQFw==
X-Gm-Message-State: AC+VfDy+DPY111PYyY5B8rFxYizdpAz7bJMs8Yl/PoLB4Pqo69+i7iWP
        9kmS4khiW0uMXdLmnqAClCLEbHsaL7/d
X-Google-Smtp-Source: ACHHUZ4SSq9UXIUiH8EplnISYn5LMtWSPpN2w9m8dM3mE9z4cvTM+eRhuwtF+5JhLaFSqJceJBbJ8FIWS/PG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a63:ba06:0:b0:51b:500e:55d3 with SMTP id
 k6-20020a63ba06000000b0051b500e55d3mr4500102pgf.6.1684966794346; Wed, 24 May
 2023 15:19:54 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:30 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-35-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 34/35] perf pmus: Remove perf_pmus__has_hybrid
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

perf_pmus__has_hybrid was used to detect when there was >1 core PMU,
this can be achieved with perf_pmus__num_core_pmus that doesn't depend
upon is_pmu_hybrid and PMU name comparisons. When modifying the
function calls take the opportunity to improve comments,
enable/simplify tests that were previously failing for hybrid but now
pass and to simplify generic code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c   |  2 +-
 tools/perf/arch/x86/util/evlist.c    |  2 +-
 tools/perf/arch/x86/util/perf_regs.c |  2 +-
 tools/perf/builtin-record.c          |  4 ++--
 tools/perf/tests/attr.c              |  9 ++++++++-
 tools/perf/tests/parse-metric.c      |  7 ++-----
 tools/perf/tests/switch-tracking.c   | 12 +-----------
 tools/perf/tests/topology.c          | 14 ++------------
 tools/perf/util/cputopo.c            | 10 ++--------
 tools/perf/util/evsel.c              |  2 +-
 tools/perf/util/header.c             |  2 +-
 tools/perf/util/mem-events.c         | 18 +++++-------------
 tools/perf/util/metricgroup.c        |  2 +-
 tools/perf/util/pmus.c               | 18 ------------------
 tools/perf/util/pmus.h               |  1 -
 tools/perf/util/stat-display.c       |  2 +-
 16 files changed, 29 insertions(+), 78 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index e466735d68d5..eb152770f148 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -281,7 +281,7 @@ static int test_events(const struct evlist_test *events, int cnt)
 
 int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (!perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() == 1)
 		return TEST_SKIP;
 
 	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 8a6a0b98b976..cbd582182932 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -18,7 +18,7 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 	for (i = 0; i < nr_attrs; i++)
 		event_attr_init(attrs + i);
 
-	if (!perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() == 1)
 		return evlist__add_attrs(evlist, attrs, nr_attrs);
 
 	for (i = 0; i < nr_attrs; i++) {
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 116384f19baf..8ad4112ad10c 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -292,7 +292,7 @@ uint64_t arch__intr_reg_mask(void)
 	 */
 	attr.sample_period = 1;
 
-	if (perf_pmus__has_hybrid()) {
+	if (perf_pmus__num_core_pmus() > 1) {
 		struct perf_pmu *pmu = NULL;
 		__u64 type = PERF_TYPE_RAW;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4b9212f75493..aec18db7ff23 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1294,7 +1294,7 @@ static int record__open(struct record *rec)
 	 * of waiting or event synthesis.
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmus__has_hybrid()) {
+	    perf_pmus__num_core_pmus() > 1) {
 		pos = evlist__get_tracking_event(evlist);
 		if (!evsel__is_dummy_event(pos)) {
 			/* Set up dummy event. */
@@ -2193,7 +2193,7 @@ static void record__uniquify_name(struct record *rec)
 	char *new_name;
 	int ret;
 
-	if (!perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() == 1)
 		return;
 
 	evlist__for_each_entry(evlist, pos) {
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 674876e6c8e6..61186d0d1cfa 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -185,8 +185,15 @@ static int test__attr(struct test_suite *test __maybe_unused, int subtest __mayb
 	char path_dir[PATH_MAX];
 	char *exec_path;
 
-	if (perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() > 1) {
+		/*
+		 * TODO: Attribute tests hard code the PMU type. If there are >1
+		 * core PMU then each PMU will have a different type whic
+		 * requires additional support.
+		 */
+		pr_debug("Skip test on hybrid systems");
 		return TEST_SKIP;
+	}
 
 	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 1d6493a5a956..2c28fb50dc24 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -302,11 +302,8 @@ static int test__parse_metric(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
 	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
 	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
-
-	if (!perf_pmus__has_hybrid()) {
-		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
-		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
-	}
+	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
+	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
 	return 0;
 }
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index cff6ab87b2f6..e52b031bedc5 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -375,17 +375,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
-	if (perf_pmus__has_hybrid()) {
-		cycles = "cpu_core/cycles/u";
-		err = parse_event(evlist, cycles);
-		if (err) {
-			cycles = "cpu_atom/cycles/u";
-			pr_debug("Trying %s\n", cycles);
-			err = parse_event(evlist, cycles);
-		}
-	} else {
-		err = parse_event(evlist, cycles);
-	}
+	err = parse_event(evlist, cycles);
 	if (err) {
 		pr_debug("Failed to parse event %s\n", cycles);
 		goto out_err;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 49e80d15420b..9dee63734e66 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -41,18 +41,8 @@ static int session_write_header(char *path)
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
-	if (!perf_pmus__has_hybrid()) {
-		session->evlist = evlist__new_default();
-		TEST_ASSERT_VAL("can't get evlist", session->evlist);
-	} else {
-		struct parse_events_error err;
-
-		session->evlist = evlist__new();
-		TEST_ASSERT_VAL("can't get evlist", session->evlist);
-		parse_events_error__init(&err);
-		parse_events(session->evlist, "cpu_core/cycles/", &err);
-		parse_events_error__exit(&err);
-	}
+	session->evlist = evlist__new_default();
+	TEST_ASSERT_VAL("can't get evlist", session->evlist);
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 729142ec9a9a..81cfc85f4668 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -472,15 +472,9 @@ struct hybrid_topology *hybrid_topology__new(void)
 {
 	struct perf_pmu *pmu = NULL;
 	struct hybrid_topology *tp = NULL;
-	u32 nr = 0, i = 0;
+	int nr = perf_pmus__num_core_pmus(), i = 0;
 
-	if (!perf_pmus__has_hybrid())
-		return NULL;
-
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-		nr++;
-
-	if (nr == 0)
+	if (nr <= 1)
 		return NULL;
 
 	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0]) * nr);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b4237fc713d5..ec2ce39d66d8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3140,7 +3140,7 @@ void evsel__zero_per_pkg(struct evsel *evsel)
  */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	if (!perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() == 1)
 		return false;
 
 	return evsel->core.is_pmu_core;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c701cc474d79..8682784cbec1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1589,7 +1589,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 * Write hybrid pmu caps first to maintain compatibility with
 	 * older perf tool.
 	 */
-	if (perf_pmus__has_hybrid()) {
+	if (perf_pmus__num_core_pmus() > 1) {
 		pmu = NULL;
 		while ((pmu = perf_pmus__scan_core(pmu))) {
 			ret = __write_pmu_caps(ff, pmu, true);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c5596230a308..be15aadb6b14 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -121,6 +121,7 @@ int perf_mem_events__init(void)
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 		char sysfs_name[100];
+		struct perf_pmu *pmu = NULL;
 
 		/*
 		 * If the event entry isn't valid, skip initialization
@@ -129,18 +130,9 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		if (!perf_pmus__has_hybrid()) {
-			scnprintf(sysfs_name, sizeof(sysfs_name),
-				  e->sysfs_name, "cpu");
-			e->supported = perf_mem_event__supported(mnt, sysfs_name);
-		} else {
-			struct perf_pmu *pmu = NULL;
-
-			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-				scnprintf(sysfs_name, sizeof(sysfs_name),
-					  e->sysfs_name, pmu->name);
-				e->supported |= perf_mem_event__supported(mnt, sysfs_name);
-			}
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
+			e->supported |= perf_mem_event__supported(mnt, sysfs_name);
 		}
 
 		if (e->supported)
@@ -196,7 +188,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 		if (!e->record)
 			continue;
 
-		if (!perf_pmus__has_hybrid()) {
+		if (perf_pmus__num_core_pmus() == 1) {
 			if (!e->supported) {
 				pr_err("failed: event '%s' not supported\n",
 				       perf_mem_events__name(j, NULL));
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 27310eff49ab..ab06133cd153 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -274,7 +274,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all") || !perf_pmus__has_hybrid() || !is_pmu_hybrid(pmu);
+	bool all_pmus = !strcmp(pmu, "all") || perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index bf927aed162e..53f11f6ce878 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -464,24 +464,6 @@ bool perf_pmus__have_event(const char *pname, const char *name)
 	return pmu && perf_pmu__have_event(pmu, name);
 }
 
-bool perf_pmus__has_hybrid(void)
-{
-	static bool hybrid_scanned, has_hybrid;
-
-	if (!hybrid_scanned) {
-		struct perf_pmu *pmu = NULL;
-
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-			if (is_pmu_hybrid(pmu->name)) {
-				has_hybrid = true;
-				break;
-			}
-		}
-		hybrid_scanned = true;
-	}
-	return has_hybrid;
-}
-
 int perf_pmus__num_core_pmus(void)
 {
 	static int count;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 27400a027d41..1e710720aec7 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -18,7 +18,6 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
-bool perf_pmus__has_hybrid(void);
 int perf_pmus__num_core_pmus(void);
 
 #endif /* __PMUS_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 9355ddf7bca9..c1765c878e03 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -681,7 +681,7 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
-	if (!perf_pmus__has_hybrid())
+	if (perf_pmus__num_core_pmus() == 1)
 		return false;
 
 	evlist__for_each_entry(evlist, evsel) {
-- 
2.40.1.698.g37aff9b760-goog

