Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB965C3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbjACQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjACQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:21:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563F612D2E;
        Tue,  3 Jan 2023 08:21:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB0C152B;
        Tue,  3 Jan 2023 08:22:05 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B5E73F71A;
        Tue,  3 Jan 2023 08:21:21 -0800 (PST)
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
Subject: [PATCH v3 1/7] perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
Date:   Tue,  3 Jan 2023 16:20:35 +0000
Message-Id: <20230103162042.423694-2-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103162042.423694-1-james.clark@arm.com>
References: <20230103162042.423694-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern for accessing EVENT_SOURCE_DEVICE_PATH is duplicated in a
few places, so add two utility functions to cover it. Also just use
perf_pmu__scan_file() instead of pmu_type() which already does the same
thing.

No functional changes.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c |   5 +-
 tools/perf/arch/x86/util/pmu.c      |  12 +--
 tools/perf/util/pmu.c               | 110 +++++++++++-----------------
 tools/perf/util/pmu.h               |   5 +-
 4 files changed, 49 insertions(+), 83 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index deeb163999ce..adec6c9ee11d 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -55,17 +55,16 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 
 static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
 {
-	const char *sysfs = sysfs__mountpoint();
 	struct perf_pmu **hisi_ptt_pmus = NULL;
 	struct dirent *dent;
 	char path[PATH_MAX];
 	DIR *dir = NULL;
 	int idx = 0;
 
-	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+	perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	dir = opendir(path);
 	if (!dir) {
-		pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
+		pr_err("can't read directory '%s'\n", path);
 		*err = -EINVAL;
 		return NULL;
 	}
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 74d69db1ea99..358340b34243 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -15,8 +15,6 @@
 #include "../../../util/pmu.h"
 #include "../../../util/fncache.h"
 
-#define TEMPLATE_ALIAS	"%s/bus/event_source/devices/%s/alias"
-
 struct pmu_alias {
 	char *name;
 	char *alias;
@@ -72,18 +70,14 @@ static int setup_pmu_alias_list(void)
 	char path[PATH_MAX];
 	DIR *dir;
 	struct dirent *dent;
-	const char *sysfs = sysfs__mountpoint();
 	struct pmu_alias *pmu_alias;
 	char buf[MAX_PMU_NAME_LEN];
 	FILE *file;
 	int ret = -ENOMEM;
 
-	if (!sysfs)
+	if (!perf_pmu__event_source_devices_scnprintf(path, sizeof(path)))
 		return -1;
 
-	snprintf(path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
-
 	dir = opendir(path);
 	if (!dir)
 		return -errno;
@@ -93,9 +87,7 @@ static int setup_pmu_alias_list(void)
 		    !strcmp(dent->d_name, ".."))
 			continue;
 
-		snprintf(path, PATH_MAX,
-			 TEMPLATE_ALIAS, sysfs, dent->d_name);
-
+		perf_pmu__pathname_scnprintf(path, sizeof(path), dent->d_name, "alias");
 		if (!file_available(path))
 			continue;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2bdeb89352e7..0d9619dde3a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -107,14 +107,10 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
 static int pmu_format(const char *name, struct list_head *format)
 {
 	char path[PATH_MAX];
-	const char *sysfs = sysfs__mountpoint();
 
-	if (!sysfs)
+	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "format"))
 		return -1;
 
-	snprintf(path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/format", sysfs, name);
-
 	if (!file_available(path))
 		return 0;
 
@@ -513,14 +509,10 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
 static int pmu_aliases(const char *name, struct list_head *head)
 {
 	char path[PATH_MAX];
-	const char *sysfs = sysfs__mountpoint();
 
-	if (!sysfs)
+	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "events"))
 		return -1;
 
-	snprintf(path, PATH_MAX,
-		 "%s/bus/event_source/devices/%s/events", sysfs, name);
-
 	if (!file_available(path))
 		return 0;
 
@@ -554,52 +546,16 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-/*
- * Reading/parsing the default pmu type value, which should be
- * located at:
- * /sys/bus/event_source/devices/<dev>/type as sysfs attribute.
- */
-static int pmu_type(const char *name, __u32 *type)
-{
-	char path[PATH_MAX];
-	FILE *file;
-	int ret = 0;
-	const char *sysfs = sysfs__mountpoint();
-
-	if (!sysfs)
-		return -1;
-
-	snprintf(path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
-
-	if (access(path, R_OK) < 0)
-		return -1;
-
-	file = fopen(path, "r");
-	if (!file)
-		return -EINVAL;
-
-	if (1 != fscanf(file, "%u", type))
-		ret = -1;
-
-	fclose(file);
-	return ret;
-}
-
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(void)
 {
 	char path[PATH_MAX];
 	DIR *dir;
 	struct dirent *dent;
-	const char *sysfs = sysfs__mountpoint();
 
-	if (!sysfs)
+	if (!perf_pmu__event_source_devices_scnprintf(path, sizeof(path)))
 		return;
 
-	snprintf(path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
-
 	dir = opendir(path);
 	if (!dir)
 		return;
@@ -696,14 +652,9 @@ static char *pmu_id(const char *name)
 static int is_arm_pmu_core(const char *name)
 {
 	char path[PATH_MAX];
-	const char *sysfs = sysfs__mountpoint();
 
-	if (!sysfs)
+	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpus"))
 		return 0;
-
-	/* Look for cpu sysfs (specific to arm) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
-				sysfs, name);
 	return file_available(path);
 }
 
@@ -969,11 +920,8 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 		return NULL;
 
 	/*
-	 * Check the type first to avoid unnecessary work.
+	 * Check the aliases first to avoid unnecessary work.
 	 */
-	if (pmu_type(name, &type))
-		return NULL;
-
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
@@ -983,9 +931,14 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 
 	pmu->cpus = pmu_cpumask(name);
 	pmu->name = strdup(name);
+
 	if (!pmu->name)
 		goto err;
 
+	/* Read type, and ensure that type value is successfully assigned (return 1) */
+	if (perf_pmu__scan_file(pmu, "type", "%u", &type) != 1)
+		goto err;
+
 	alias_name = pmu_find_alias_name(name);
 	if (alias_name) {
 		pmu->alias_name = strdup(alias_name);
@@ -1786,16 +1739,11 @@ bool pmu_have_event(const char *pname, const char *name)
 static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
-	const char *sysfs;
 
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
+	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), pmu->name, name) ||
+	    !file_available(path))
 		return NULL;
 
-	snprintf(path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
-	if (!file_available(path))
-		return NULL;
 	return fopen(path, "r");
 }
 
@@ -1849,7 +1797,6 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 {
 	struct stat st;
 	char caps_path[PATH_MAX];
-	const char *sysfs = sysfs__mountpoint();
 	DIR *caps_dir;
 	struct dirent *evt_ent;
 
@@ -1858,12 +1805,9 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	pmu->nr_caps = 0;
 
-	if (!sysfs)
+	if (!perf_pmu__pathname_scnprintf(caps_path, sizeof(caps_path), pmu->name, "caps"))
 		return -1;
 
-	snprintf(caps_path, PATH_MAX,
-		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
-
 	if (stat(caps_path, &st) < 0) {
 		pmu->caps_initialized = true;
 		return 0;	/* no error if caps does not exist */
@@ -1993,3 +1937,31 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
 }
+
+int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size)
+{
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs)
+		return 0;
+	return scnprintf(pathname, size, "%s/bus/event_source/devices/", sysfs);
+}
+
+/*
+ * Fill 'buf' with the path to a file or folder in 'pmu_name' in
+ * sysfs. For example if pmu_name = "cs_etm" and 'filename' = "format"
+ * then pathname will be filled with
+ * "/sys/bus/event_source/devices/cs_etm/format"
+ *
+ * Return 0 if the sysfs mountpoint couldn't be found or if no
+ * characters were written.
+ */
+int perf_pmu__pathname_scnprintf(char *buf, size_t size,
+				 const char *pmu_name, const char *filename)
+{
+	char base_path[PATH_MAX];
+
+	if (!perf_pmu__event_source_devices_scnprintf(base_path, sizeof(base_path)))
+		return 0;
+	return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filename);
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 69ca0004f94f..2f2bb0286e2a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -22,7 +22,6 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 #define MAX_PMU_NAME_LEN 128
 
@@ -259,4 +258,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 
 char *pmu_find_real_name(const char *name);
 char *pmu_find_alias_name(const char *name);
+int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
+int perf_pmu__pathname_scnprintf(char *buf, size_t size,
+				 const char *pmu_name, const char *filename);
+
 #endif /* __PMU_H */
-- 
2.25.1

