Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE070B54F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjEVGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjEVGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:45:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6E1729
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f1c2af16so50827117b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737865; x=1687329865;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/zDhGYmSYwIY3XTw78CiadtIGytk9ZJaXCr9PdDxvQ=;
        b=gd9gxG/2Ielbr0Bwodts99ppTP+CDR3zPpb9RGt/KzqBG2lKBLfolD1sn45vE5jrNp
         MwrFtLKseZDFyMDVA4ZW2P/X84lWtjlSa46hxsXFZkm4eEAlW1j8NShOqOo/cwuDHDeh
         7fblnnw0KfEha/3BP5Rxt7X8w0zWowQUeS331nFjHtOuUDNYqHGSH1IndTAPkVoWzBwH
         p+PASCeH2QcZsJ57AM01Q+K0hlPYkcczQ3A4UjJd5szJsIkPbPVjkx+xRPw03yJq0nuE
         bCSbqPQsuKbmIhtmH2R1KgLhlBVtG4iM7XDWwc+rih6nuUZ7JOMCfNZjAjPL/Yj4Z1Kz
         OHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737865; x=1687329865;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/zDhGYmSYwIY3XTw78CiadtIGytk9ZJaXCr9PdDxvQ=;
        b=RelkmPGcTMED00OaBYOuDAqGW5XlksL4GT/LxDsz0NZtrVdiWwkaMosb0e1LlycA2B
         64m54no/QQ15NpJ6bAdPcF9D4b1Wu95rvGPGjGv8d2QrvgjYBAgCgB6vycnpsrYeihrV
         mLVNd2lhmA44bvek0wjnyGiRDo9s/Fi93r9bbA/t3IYJMjwPw7l6pt8aDb8VkTVkaive
         geURuf/zd71dSQIXwX61dBoLU+ofe7f0RNVMJb1OSSaTWMtOzxBvp6HETfBms1tl+MgV
         x6S19b17JJecfuzSyHSQLljDU7xA8UqrD3/rSVjMHaZnwV67T8aC5PrzK1RI9fa5IqoT
         hvVQ==
X-Gm-Message-State: AC+VfDyvzYJ69NzWSKk/kd9uVo2WkmQZH7YMMLvvtFInMxZPrxaCkqQa
        OMPNIAkq8fI39Wlc5gMNqYh3D/SfE6w1
X-Google-Smtp-Source: ACHHUZ7hQicGHtucbbu9xRxzegdWd3UkqaH+RXMHj8ZLml5x0U2mPqGcknC57brDNFmv+xEOQyWVDSpYZ/Kg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:fe01:0:b0:ba8:8ab3:3806 with SMTP id
 k1-20020a25fe01000000b00ba88ab33806mr5908499ybe.13.1684737865483; Sun, 21 May
 2023 23:44:25 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:28 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-22-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 21/23] perf pmus: Allow just core PMU scanning
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

Scanning all PMUs is expensive as all PMUs sysfs entries are loaded,
benchmarking shows more than 4x the cost:

```
$ perf bench internals pmu-scan -i 1000
Computing performance of sysfs PMU event scan for 1000 times
  Average core PMU scanning took: 989.231 usec (+- 1.535 usec)
  Average PMU scanning took: 4309.425 usec (+- 74.322 usec)
```

Add new perf_pmus__scan_core routine that scans just core
PMUs. Replace perf_pmus__scan calls with perf_pmus__scan_core when
non-core PMUs are being ignored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c     |  5 +--
 tools/perf/arch/x86/util/evlist.c    |  5 +--
 tools/perf/arch/x86/util/perf_regs.c |  8 ++---
 tools/perf/bench/pmu-scan.c          | 50 ++++++++++++++++------------
 tools/perf/tests/pmu-events.c        |  5 +--
 tools/perf/util/cputopo.c            | 10 ++----
 tools/perf/util/header.c             |  5 +--
 tools/perf/util/mem-events.c         | 14 ++------
 tools/perf/util/parse-events.c       | 13 +++-----
 tools/perf/util/pmu.c                | 10 ------
 tools/perf/util/pmu.h                |  2 --
 tools/perf/util/pmus.c               | 28 ++++++++++++----
 tools/perf/util/pmus.h               |  1 +
 tools/perf/util/print-events.c       | 11 +++---
 14 files changed, 73 insertions(+), 94 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 2504d43a39a7..561de0cb6b95 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -11,10 +11,7 @@ static struct perf_pmu *pmu__find_core_pmu(void)
 {
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!is_pmu_core(pmu->name))
-			continue;
-
+	while ((pmu = perf_pmus__scan_core(pmu))) {
 		/*
 		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
 		 * not support some events or have different event IDs.
diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 03240c640c7f..8a6a0b98b976 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -33,13 +33,10 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 			continue;
 		}
 
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			struct perf_cpu_map *cpus;
 			struct evsel *evsel;
 
-			if (!pmu->is_core)
-				continue;
-
 			evsel = evsel__new(attrs + i);
 			if (evsel == NULL)
 				goto out_delete_partial_list;
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index befa7f3659b9..116384f19baf 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -300,11 +300,9 @@ uint64_t arch__intr_reg_mask(void)
 		 * The same register set is supported among different hybrid PMUs.
 		 * Only check the first available one.
 		 */
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			if (pmu->is_core) {
-				type = pmu->type;
-				break;
-			}
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			type = pmu->type;
+			break;
 		}
 		attr.config |= type << PERF_PMU_TYPE_SHIFT;
 	}
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 51cae2d03353..c7d207f8e13c 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -22,6 +22,7 @@ struct pmu_scan_result {
 	int nr_aliases;
 	int nr_formats;
 	int nr_caps;
+	bool is_core;
 };
 
 static const struct option options[] = {
@@ -53,6 +54,7 @@ static int save_result(void)
 		r = results + nr_pmus;
 
 		r->name = strdup(pmu->name);
+		r->is_core = pmu->is_core;
 		r->nr_caps = pmu->nr_caps;
 
 		r->nr_aliases = 0;
@@ -72,7 +74,7 @@ static int save_result(void)
 	return 0;
 }
 
-static int check_result(void)
+static int check_result(bool core_only)
 {
 	struct pmu_scan_result *r;
 	struct perf_pmu *pmu;
@@ -81,6 +83,9 @@ static int check_result(void)
 
 	for (int i = 0; i < nr_pmus; i++) {
 		r = &results[i];
+		if (core_only && !r->is_core)
+			continue;
+
 		pmu = perf_pmus__find(r->name);
 		if (pmu == NULL) {
 			pr_err("Cannot find PMU %s\n", r->name);
@@ -130,7 +135,6 @@ static int run_pmu_scan(void)
 	struct timeval start, end, diff;
 	double time_average, time_stddev;
 	u64 runtime_us;
-	unsigned int i;
 	int ret;
 
 	init_stats(&stats);
@@ -142,26 +146,30 @@ static int run_pmu_scan(void)
 		return -1;
 	}
 
-	for (i = 0; i < iterations; i++) {
-		gettimeofday(&start, NULL);
-		perf_pmus__scan(NULL);
-		gettimeofday(&end, NULL);
-
-		timersub(&end, &start, &diff);
-		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
-		update_stats(&stats, runtime_us);
-
-		ret = check_result();
-		perf_pmus__destroy();
-		if (ret < 0)
-			break;
+	for (int j = 0; j < 2; j++) {
+		bool core_only = (j == 0);
+
+		for (unsigned int i = 0; i < iterations; i++) {
+			gettimeofday(&start, NULL);
+			if (core_only)
+				perf_pmus__scan_core(NULL);
+			else
+				perf_pmus__scan(NULL);
+			gettimeofday(&end, NULL);
+			timersub(&end, &start, &diff);
+			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+			update_stats(&stats, runtime_us);
+
+			ret = check_result(core_only);
+			perf_pmus__destroy();
+			if (ret < 0)
+				break;
+		}
+		time_average = avg_stats(&stats);
+		time_stddev = stddev_stats(&stats);
+		pr_info("  Average%s PMU scanning took: %.3f usec (+- %.3f usec)\n",
+			core_only ? " core" : "", time_average, time_stddev);
 	}
-
-	time_average = avg_stats(&stats);
-	time_stddev = stddev_stats(&stats);
-	pr_info("  Average PMU scanning took: %.3f usec (+- %.3f usec)\n",
-		time_average, time_stddev);
-
 	delete_result();
 	return 0;
 }
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 64ecb7845af4..64383fc34ef1 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -709,12 +709,9 @@ static int test__aliases(struct test_suite *test __maybe_unused,
 	struct perf_pmu *pmu = NULL;
 	unsigned long i;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		int count = 0;
 
-		if (!is_pmu_core(pmu->name))
-			continue;
-
 		if (list_empty(&pmu->format)) {
 			pr_debug2("skipping testing core PMU %s\n", pmu->name);
 			continue;
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 4578c26747e1..3723a1cec768 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -477,9 +477,8 @@ struct hybrid_topology *hybrid_topology__new(void)
 	if (!perf_pmus__has_hybrid())
 		return NULL;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (pmu->is_core)
-			nr++;
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		nr++;
 	}
 	if (nr == 0)
 		return NULL;
@@ -489,10 +488,7 @@ struct hybrid_topology *hybrid_topology__new(void)
 		return NULL;
 
 	tp->nr = nr;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (!pmu->is_core)
-			continue;
-
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		if (load_hybrid_node(&tp->nodes[i], pmu)) {
 			hybrid_topology__delete(tp);
 			return NULL;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fa3f7dbbd90e..c701cc474d79 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1591,10 +1591,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 */
 	if (perf_pmus__has_hybrid()) {
 		pmu = NULL;
-		while ((pmu = perf_pmus__scan(pmu))) {
-			if (!pmu->is_core)
-				continue;
-
+		while ((pmu = perf_pmus__scan_core(pmu))) {
 			ret = __write_pmu_caps(ff, pmu, true);
 			if (ret < 0)
 				return ret;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 08ac3ea2e366..c5596230a308 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -136,10 +136,7 @@ int perf_mem_events__init(void)
 		} else {
 			struct perf_pmu *pmu = NULL;
 
-			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-				if (!pmu->is_core)
-					continue;
-
+			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 				scnprintf(sysfs_name, sizeof(sysfs_name),
 					  e->sysfs_name, pmu->name);
 				e->supported |= perf_mem_event__supported(mnt, sysfs_name);
@@ -176,10 +173,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 	char sysfs_name[100];
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (!pmu->is_core)
-			continue;
-
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
 			  pmu->name);
 		if (!perf_mem_event__supported(mnt, sysfs_name)) {
@@ -217,9 +211,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				return -1;
 			}
 
-			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-				if (!pmu->is_core)
-					continue;
+			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 				rec_argv[i++] = "-e";
 				s = perf_mem_events__name(j, pmu->name);
 				if (s) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 984b230e14d4..47ee628a65bb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -452,15 +452,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	const char *config_name = get_config_name(head_config);
 	const char *metric_id = get_config_metric_id(head_config);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	/* Legacy cache events are only supported by core PMUs. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 		int ret;
 
-		/* Skip unsupported PMUs. */
-		if (!perf_pmu__supports_legacy_cache(pmu))
-			continue;
-
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
@@ -1480,12 +1477,10 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 		return __parse_events_add_numeric(parse_state, list, /*pmu=*/NULL,
 						  type, config, head_config);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	/* Wildcards on numeric values are only supported by core PMUs. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		int ret;
 
-		if (!perf_pmu__supports_wildcard_numeric(pmu))
-			continue;
-
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3217a859c65b..4844ed8049f1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1440,21 +1440,11 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 	return pmu->is_core;
 }
 
-bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
-{
-	return pmu->is_core;
-}
-
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
 	return !is_pmu_hybrid(pmu->name);
 }
 
-bool perf_pmu__is_mem_pmu(const struct perf_pmu *pmu)
-{
-	return pmu->is_core;
-}
-
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_alias *alias;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f1f3e8a2e00e..02fec0a7d4c8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -223,9 +223,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 bool is_pmu_core(const char *name);
 bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
-bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-bool perf_pmu__is_mem_pmu(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
 
 FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 10f5648073bb..5736e99facd1 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -87,7 +87,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 }
 
 /* Add all pmus in sysfs to pmu list: */
-static void pmu_read_sysfs(void)
+static void pmu_read_sysfs(bool core_only)
 {
 	int fd;
 	DIR *dir;
@@ -104,6 +104,8 @@ static void pmu_read_sysfs(void)
 	while ((dent = readdir(dir))) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
+		if (core_only && !is_pmu_core(dent->d_name))
+			continue;
 		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
 		perf_pmu__find2(fd, dent->d_name);
 	}
@@ -135,7 +137,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 	bool use_core_pmus = !pmu || pmu->is_core;
 
 	if (!pmu) {
-		pmu_read_sysfs();
+		pmu_read_sysfs(/*core_only=*/false);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
 	if (use_core_pmus) {
@@ -150,6 +152,18 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
+{
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/true);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &core_pmus, list)
+		return pmu;
+
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -176,9 +190,9 @@ int perf_pmus__num_mem_pmus(void)
 	struct perf_pmu *pmu = NULL;
 	int count = 0;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (perf_pmu__is_mem_pmu(pmu))
-			count++;
+	/* All core PMUs are for mem events. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		count++;
 	}
 	return count;
 }
@@ -422,8 +436,8 @@ bool perf_pmus__has_hybrid(void)
 	if (!hybrid_scanned) {
 		struct perf_pmu *pmu = NULL;
 
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (is_pmu_hybrid(pmu->name)) {
 				has_hybrid = true;
 				break;
 			}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 2a771d9f8da7..9de0222ed52b 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -11,6 +11,7 @@ struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
+struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 9cee7bb7a561..7a5f87392720 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -272,12 +272,11 @@ int print_hwcache_events(const struct print_callbacks *print_cb, void *print_sta
 	struct perf_pmu *pmu = NULL;
 	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		/*
-		 * Skip uncore PMUs for performance. PERF_TYPE_HW_CACHE type
-		 * attributes can accept software PMUs in the extended type, so
-		 * also skip.
-		 */
+	/*
+	 * Only print core PMUs, skipping uncore for performance and
+	 * PERF_TYPE_SOFTWARE that can succeed in opening legacy cache evenst.
+	 */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
 			continue;
 
-- 
2.40.1.698.g37aff9b760-goog

