Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D067577C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjATOj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:39:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54BB072C36;
        Fri, 20 Jan 2023 06:39:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA7D1516;
        Fri, 20 Jan 2023 06:38:42 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74A7A3F67D;
        Fri, 20 Jan 2023 06:37:58 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: [PATCH v5 2/8] perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
Date:   Fri, 20 Jan 2023 14:36:55 +0000
Message-Id: <20230120143702.4035046-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120143702.4035046-1-james.clark@arm.com>
References: <20230120143702.4035046-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some code that duplicates existing methods. Copy strings where
const strings are required.

No functional changes.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cputopo.c    |  9 +-------
 tools/perf/util/pmu-hybrid.c | 27 +++++-------------------
 tools/perf/util/pmu.c        | 40 +++++++++++-------------------------
 tools/perf/util/pmu.h        |  3 ++-
 4 files changed, 20 insertions(+), 59 deletions(-)

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
index f51ccaac60ee..38628805a952 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -20,32 +20,15 @@ LIST_HEAD(perf_pmu__hybrid_pmus);
 
 bool perf_pmu__hybrid_mounted(const char *name)
 {
-	char path[PATH_MAX];
-	const char *sysfs;
-	FILE *file;
-	int n, cpu;
+	int cpu;
+	char pmu_name[PATH_MAX];
+	struct perf_pmu pmu = {.name = pmu_name};
 
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
+	strlcpy(pmu_name, name, sizeof(pmu_name));
+	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
 }
 
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1edbb714ff32..a771a5972fc5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -571,45 +571,31 @@ static void pmu_read_sysfs(void)
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
 
 static struct perf_cpu_map *pmu_cpumask(const char *name)
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
+	char pmu_name[PATH_MAX];
+	struct perf_pmu pmu = {.name = pmu_name};
+	FILE *file;
 
-	if (!sysfs)
-		return NULL;
-
+	strlcpy(pmu_name, name, sizeof(pmu_name));
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
@@ -620,13 +606,11 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 static bool pmu_is_uncore(const char *name)
 {
 	char path[PATH_MAX];
-	const char *sysfs;
 
 	if (perf_pmu__hybrid_mounted(name))
 		return false;
 
-	sysfs = sysfs__mountpoint();
-	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
+	perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpumask");
 	return file_available(path);
 }
 
@@ -1737,7 +1721,7 @@ bool pmu_have_event(const char *pname, const char *name)
 	return false;
 }
 
-static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
+FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 96d030c8b3b3..742d4db319a0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -7,6 +7,7 @@
 #include <linux/perf_event.h>
 #include <linux/list.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
 
@@ -22,7 +23,6 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
-#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 #define MAX_PMU_NAME_LEN 128
 
 struct perf_event_attr;
@@ -262,5 +262,6 @@ double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
+FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
 
 #endif /* __PMU_H */
-- 
2.25.1

