Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBEC6544DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiLVQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:07:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3934160DC;
        Thu, 22 Dec 2022 08:07:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BFABAD7;
        Thu, 22 Dec 2022 08:08:06 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DDDE3FAFB;
        Thu, 22 Dec 2022 08:07:21 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
Date:   Thu, 22 Dec 2022 16:03:22 +0000
Message-Id: <20221222160328.3639989-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222160328.3639989-1-james.clark@arm.com>
References: <20221222160328.3639989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some code that duplicates existing methods. This requires that
some consts are removed because one of the existing helper methods takes
a struct perf_pmu instead of a name which has a non const name field.
But except for the tests, the strings were already non const.

No functional changes.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/evsel-roundtrip-name.c |  3 +-
 tools/perf/tests/parse-events.c         |  3 +-
 tools/perf/util/cputopo.c               |  9 +-----
 tools/perf/util/pmu-hybrid.c            | 27 +++-------------
 tools/perf/util/pmu-hybrid.h            |  2 +-
 tools/perf/util/pmu.c                   | 42 +++++++------------------
 tools/perf/util/pmu.h                   |  3 +-
 7 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index e94fed901992..9bccf177f481 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -103,8 +103,9 @@ static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe
 						 int subtest __maybe_unused)
 {
 	int err = 0, ret = 0;
+	char cpu_atom[] = "cpu_atom";
 
-	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
+	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted(cpu_atom))
 		return perf_evsel__name_array_test(evsel__hw_names, 2);
 
 	err = perf_evsel__name_array_test(evsel__hw_names, 1);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 71a5cb343311..5857125202bf 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1608,8 +1608,9 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 static int test__hybrid_raw1(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
+	char cpu_atom[] = "cpu_atom";
 
-	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
+	if (!perf_pmu__hybrid_mounted(cpu_atom)) {
 		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 		TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 1a3ff6449158..e08797c3cdbc 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -422,8 +422,6 @@ void numa_topology__delete(struct numa_topology *tp)
 static int load_hybrid_node(struct hybrid_topology_node *node,
 			    struct perf_pmu *pmu)
 {
-	const char *sysfs;
-	char path[PATH_MAX];
 	char *buf = NULL, *p;
 	FILE *fp;
 	size_t len = 0;
@@ -432,12 +430,7 @@ static int load_hybrid_node(struct hybrid_topology_node *node,
 	if (!node->pmu_name)
 		return -1;
 
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		goto err;
-
-	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, pmu->name);
-	fp = fopen(path, "r");
+	fp = perf_pmu__open_file(pmu, "cpus");
 	if (!fp)
 		goto err;
 
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index f51ccaac60ee..317c612cc41d 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -18,34 +18,15 @@
 
 LIST_HEAD(perf_pmu__hybrid_pmus);
 
-bool perf_pmu__hybrid_mounted(const char *name)
+bool perf_pmu__hybrid_mounted(char *name)
 {
-	char path[PATH_MAX];
-	const char *sysfs;
-	FILE *file;
-	int n, cpu;
+	int cpu;
+	struct perf_pmu pmu = {.name = name};
 
 	if (strncmp(name, "cpu_", 4))
 		return false;
 
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return false;
-
-	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
-	if (!file_available(path))
-		return false;
-
-	file = fopen(path, "r");
-	if (!file)
-		return false;
-
-	n = fscanf(file, "%u", &cpu);
-	fclose(file);
-	if (n <= 0)
-		return false;
-
-	return true;
+	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
 }
 
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 2b186c26a43e..11db6ef4a376 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -13,7 +13,7 @@ extern struct list_head perf_pmu__hybrid_pmus;
 #define perf_pmu__for_each_hybrid_pmu(pmu)	\
 	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
 
-bool perf_pmu__hybrid_mounted(const char *name);
+bool perf_pmu__hybrid_mounted(char *name);
 
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 827c1a6bb99a..faaeec1e15aa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -570,45 +570,29 @@ static void pmu_read_sysfs(void)
 	closedir(dir);
 }
 
-static struct perf_cpu_map *__pmu_cpumask(const char *path)
-{
-	FILE *file;
-	struct perf_cpu_map *cpus;
-
-	file = fopen(path, "r");
-	if (!file)
-		return NULL;
-
-	cpus = perf_cpu_map__read(file);
-	fclose(file);
-	return cpus;
-}
-
 /*
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
 #define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
-#define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
 
-static struct perf_cpu_map *pmu_cpumask(const char *name)
+static struct perf_cpu_map *pmu_cpumask(char *name)
 {
-	char path[PATH_MAX];
 	struct perf_cpu_map *cpus;
-	const char *sysfs = sysfs__mountpoint();
 	const char *templates[] = {
-		CPUS_TEMPLATE_UNCORE,
-		CPUS_TEMPLATE_CPU,
+		"cpumask",
+		"cpus",
 		NULL
 	};
 	const char **template;
-
-	if (!sysfs)
-		return NULL;
+	struct perf_pmu pmu = {.name = name};
+	FILE *file;
 
 	for (template = templates; *template; template++) {
-		snprintf(path, PATH_MAX, *template, sysfs, name);
-		cpus = __pmu_cpumask(path);
+		file = perf_pmu__open_file(&pmu, *template);
+		if (!file)
+			continue;
+		cpus = perf_cpu_map__read(file);
 		if (cpus)
 			return cpus;
 	}
@@ -616,16 +600,14 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 	return NULL;
 }
 
-static bool pmu_is_uncore(const char *name)
+static bool pmu_is_uncore(char *name)
 {
 	char path[PATH_MAX];
-	const char *sysfs;
 
 	if (perf_pmu__hybrid_mounted(name))
 		return false;
 
-	sysfs = sysfs__mountpoint();
-	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
+	perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "cpumask");
 	return file_available(path);
 }
 
@@ -1736,7 +1718,7 @@ bool pmu_have_event(const char *pname, const char *name)
 	return false;
 }
 
-static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
+FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2f2bb0286e2a..8f39e2d17fb1 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -2,6 +2,7 @@
 #ifndef __PMU_H
 #define __PMU_H
 
+#include <bits/types/FILE.h>
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
@@ -22,7 +23,6 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
-#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 #define MAX_PMU_NAME_LEN 128
 
 struct perf_event_attr;
@@ -261,5 +261,6 @@ char *pmu_find_alias_name(const char *name);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
+FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
 
 #endif /* __PMU_H */
-- 
2.25.1

