Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535776D2977
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjCaUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjCaUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDFF23B41;
        Fri, 31 Mar 2023 13:29:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so21666820pjq.3;
        Fri, 31 Mar 2023 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294599; x=1682886599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GApJR9zLFQnP8aqhRF4/4bSrT+6uWVcNNs+zyY06OJY=;
        b=REZtFi+/crDI7AZhkYx5PzqWXMi9F2zeF8dZVXgzkQESNlUa/oXlk6pf5z8+Pkzn1J
         zVNfP17Y01enw8tF+Y0J+JVo1sHrUlDHnlc/OrGkalVZ0BuSe+MkFcq18InEO5ehk59n
         MFxIH7pvX4q7AR/dsN6wEA7OtxMWALRMBR6/19SHdUjfWtTp66lTCLa1EN2YhASxknHL
         LuH9GiSL6hgzAwISkxtQjhN2u3fMv1F0V2232RsGE6chBZJo7+SlHiQw6FLwuGO27ms4
         t1iFc6qSnC2fhF3rPbey1piYQhRgLfY3I/QWi2kUFlRRuM5qabCuaZCe1jlDz3z9Qf91
         VaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294599; x=1682886599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GApJR9zLFQnP8aqhRF4/4bSrT+6uWVcNNs+zyY06OJY=;
        b=XJB8ph198avLxiH869U2LHh95QpeG/+CF806zH/G+Nl1gbtjrUaU23T0cLam1OtYvo
         tCrgBbUW5CkZezXGSPanqWMfCQAq2hjFZyfOMd6Fo4jel7sYRNwgD+45IVUS4k28YnlY
         4KDeml4eVPeqdUcomP+tKhDxurUc84alR0aZNEzoftsj/gu9BVwku/USkQJT+w+09xuY
         Fk2PAAZ0R0yLzUOhgGt5IwhjHw5TyQUa/kgBR4oW8FFCk85P8MYL01Xp+Av8LNrQ1Z12
         DT3tjaXF7LZPRFDC4UgcdqkKWgjVW13pHbguFB+6kRK4ds2Ppi2VEpVISaUa3++huz7k
         tzLA==
X-Gm-Message-State: AAQBX9dxyeTsFy/annVP07Ud2BWk6khG5JEiD/7HhTv0F79fqSdDuBsG
        /dPRBDNIu28PFIyYEOYBbTY=
X-Google-Smtp-Source: AKy350aQY9xgpQDqFvbkT5fwT0Iaur6OeYOM3xlx9WKPEoyZ2sGPR0Ok9dySjrtAZkoK4DDb+AY79Q==
X-Received: by 2002:a17:902:ccd2:b0:1a2:7d:17f2 with SMTP id z18-20020a170902ccd200b001a2007d17f2mr31934863ple.69.1680294599136;
        Fri, 31 Mar 2023 13:29:59 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 5/9] perf pmu: Use relative path for sysfs scan
Date:   Fri, 31 Mar 2023 13:29:45 -0700
Message-Id: <20230331202949.810326-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU information is in the kernel sysfs so it needs to scan the
directory to get the whole information like event aliases, formats
and so on.  During the traversal, it opens a lot of files and
directories like below:

  dir = opendir("/sys/bus/event_source/devices");
  while (dentry = readdir(dir)) {
    char buf[PATH_MAX];

    snprintf(buf, sizeof(buf), "%s/%s",
             "/sys/bus/event_source/devices", dentry->d_name);
    fd = open(buf, O_RDONLY);
    ...
  }

But this is not good since it needs to copy the string to build the
absolute pathname, and it makes redundant pathname walk (from the /sys)
unnecessarily.  We can use openat(2) to open the file in the given
directory.  While it's not a problem ususally, it can be a problem
when the kernel has contentions on the sysfs.

Add a couple of new helper to return the file descriptor of PMU
directory so that it can use it with relative paths.

 * perf_pmu__event_source_devices_fd()
   - returns a fd for the PMU root ("/sys/bus/event_source/devices")

 * perf_pmu__pathname_fd()
   - returns a fd for "<pmu>/<file>" under the PMU root

Now the above code can be converted something like below:

  dirfd = perf_pmu__event_source_devices_fd();
  dir = fdopendir(dirfd);
  while (dentry = readdir(dir)) {
    fd = openat(dirfd, dentry->d_name, O_RDONLY);
    ...
  }

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pmu.c |   9 ++-
 tools/perf/util/pmu.c  | 161 +++++++++++++++++++++++++----------------
 tools/perf/util/pmu.h  |   4 +-
 3 files changed, 111 insertions(+), 63 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 8507bd615e97..3cf25f883df7 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -3,6 +3,7 @@
 #include "pmu.h"
 #include "tests.h"
 #include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
@@ -149,10 +150,16 @@ static int test__pmu(struct test_suite *test __maybe_unused, int subtest __maybe
 
 	do {
 		struct perf_event_attr attr;
+		int fd;
 
 		memset(&attr, 0, sizeof(attr));
 
-		ret = perf_pmu__format_parse(format, &formats);
+		fd = open(format, O_DIRECTORY);
+		if (fd < 0) {
+			ret = fd;
+			break;
+		}
+		ret = perf_pmu__format_parse(fd, &formats);
 		if (ret)
 			break;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b112606f36ec..9fc6b8b5732b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -62,38 +62,38 @@ extern FILE *perf_pmu_in;
 
 static bool hybrid_scanned;
 
+static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
+
 /*
  * Parse & process all the sysfs attributes located under
  * the directory specified in 'dir' parameter.
  */
-int perf_pmu__format_parse(char *dir, struct list_head *head)
+int perf_pmu__format_parse(int dirfd, struct list_head *head)
 {
 	struct dirent *evt_ent;
 	DIR *format_dir;
 	int ret = 0;
 
-	format_dir = opendir(dir);
+	format_dir = fdopendir(dirfd);
 	if (!format_dir)
 		return -EINVAL;
 
 	while (!ret && (evt_ent = readdir(format_dir))) {
-		char path[PATH_MAX];
 		char *name = evt_ent->d_name;
-		FILE *file;
+		int fd;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
 
-		snprintf(path, PATH_MAX, "%s/%s", dir, name);
 
 		ret = -EINVAL;
-		file = fopen(path, "r");
-		if (!file)
+		fd = openat(dirfd, name, O_RDONLY);
+		if (fd < 0)
 			break;
 
-		perf_pmu_in = file;
+		perf_pmu_in = fdopen(fd, "r");
 		ret = perf_pmu_parse(head, name);
-		fclose(file);
+		fclose(perf_pmu_in);
 	}
 
 	closedir(format_dir);
@@ -105,17 +105,16 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
  * located at:
  * /sys/bus/event_source/devices/<dev>/format as sysfs group attributes.
  */
-static int pmu_format(const char *name, struct list_head *format)
+static int pmu_format(int dirfd, const char *name, struct list_head *format)
 {
-	char path[PATH_MAX];
-
-	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "format"))
-		return -1;
+	int fd;
 
-	if (!file_available(path))
+	fd = perf_pmu__pathname_fd(dirfd, name, "format", O_DIRECTORY);
+	if (fd < 0)
 		return 0;
 
-	if (perf_pmu__format_parse(path, format))
+	/* it'll close the fd */
+	if (perf_pmu__format_parse(fd, format))
 		return -1;
 
 	return 0;
@@ -158,7 +157,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 	return ret;
 }
 
-static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *name)
+static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, char *name)
 {
 	struct stat st;
 	ssize_t sret;
@@ -166,9 +165,9 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	int fd, ret = -1;
 	char path[PATH_MAX];
 
-	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s.scale", name);
 
-	fd = open(path, O_RDONLY);
+	fd = openat(dirfd, path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -190,15 +189,15 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	return ret;
 }
 
-static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, char *dir, char *name)
+static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, char *name)
 {
 	char path[PATH_MAX];
 	ssize_t sret;
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s.unit", name);
 
-	fd = open(path, O_RDONLY);
+	fd = openat(dirfd, path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -221,14 +220,14 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, char *dir, char *n
 }
 
 static int
-perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, char *dir, char *name)
+perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, char *name)
 {
 	char path[PATH_MAX];
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
+	scnprintf(path, PATH_MAX, "%s.per-pkg", name);
 
-	fd = open(path, O_RDONLY);
+	fd = openat(dirfd, path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -239,14 +238,14 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, char *dir, char *name)
 }
 
 static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
-				    char *dir, char *name)
+				    int dirfd, char *name)
 {
 	char path[PATH_MAX];
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
+	scnprintf(path, PATH_MAX, "%s.snapshot", name);
 
-	fd = open(path, O_RDONLY);
+	fd = openat(dirfd, path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -332,7 +331,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 	return false;
 }
 
-static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
+static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 				 char *desc, char *val, const struct pmu_event *pe)
 {
 	struct parse_events_term *term;
@@ -391,14 +390,14 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 
 	alias->name = strdup(name);
-	if (dir) {
+	if (dirfd >= 0) {
 		/*
 		 * load unit name and scale if available
 		 */
-		perf_pmu__parse_unit(alias, dir, name);
-		perf_pmu__parse_scale(alias, dir, name);
-		perf_pmu__parse_per_pkg(alias, dir, name);
-		perf_pmu__parse_snapshot(alias, dir, name);
+		perf_pmu__parse_unit(alias, dirfd, name);
+		perf_pmu__parse_scale(alias, dirfd, name);
+		perf_pmu__parse_per_pkg(alias, dirfd, name);
+		perf_pmu__parse_snapshot(alias, dirfd, name);
 	}
 
 	alias->desc = desc ? strdup(desc) : NULL;
@@ -419,7 +418,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	return 0;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
+static int perf_pmu__new_alias(struct list_head *list, int dirfd, char *name, FILE *file)
 {
 	char buf[256];
 	int ret;
@@ -433,7 +432,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	/* Remove trailing newline from sysfs file */
 	strim(buf);
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
+	return __perf_pmu__new_alias(list, dirfd, name, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -457,17 +456,17 @@ static inline bool pmu_alias_info_file(char *name)
  * Process all the sysfs attributes located under the directory
  * specified in 'dir' parameter.
  */
-static int pmu_aliases_parse(char *dir, struct list_head *head)
+static int pmu_aliases_parse(int dirfd, struct list_head *head)
 {
 	struct dirent *evt_ent;
 	DIR *event_dir;
+	int fd;
 
-	event_dir = opendir(dir);
+	event_dir = fdopendir(dirfd);
 	if (!event_dir)
 		return -EINVAL;
 
 	while ((evt_ent = readdir(event_dir))) {
-		char path[PATH_MAX];
 		char *name = evt_ent->d_name;
 		FILE *file;
 
@@ -480,15 +479,14 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		scnprintf(path, PATH_MAX, "%s/%s", dir, name);
-
-		file = fopen(path, "r");
+		fd = openat(dirfd, name, O_RDONLY);
+		file = fdopen(fd, "r");
 		if (!file) {
-			pr_debug("Cannot open %s\n", path);
+			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
 
-		if (perf_pmu__new_alias(head, dir, name, file) < 0)
+		if (perf_pmu__new_alias(head, dirfd, name, file) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
 	}
@@ -501,17 +499,16 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int pmu_aliases(const char *name, struct list_head *head)
+static int pmu_aliases(int dirfd, const char *name, struct list_head *head)
 {
-	char path[PATH_MAX];
-
-	if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "events"))
-		return -1;
+	int fd;
 
-	if (!file_available(path))
+	fd = perf_pmu__pathname_fd(dirfd, name, "events", O_DIRECTORY);
+	if (fd < 0)
 		return 0;
 
-	if (pmu_aliases_parse(path, head))
+	/* it'll close the fd */
+	if (pmu_aliases_parse(fd, head))
 		return -1;
 
 	return 0;
@@ -544,14 +541,15 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(void)
 {
-	char path[PATH_MAX];
+	int fd;
 	DIR *dir;
 	struct dirent *dent;
 
-	if (!perf_pmu__event_source_devices_scnprintf(path, sizeof(path)))
+	fd = perf_pmu__event_source_devices_fd();
+	if (fd < 0)
 		return;
 
-	dir = opendir(path);
+	dir = fdopendir(fd);
 	if (!dir)
 		return;
 
@@ -559,7 +557,7 @@ static void pmu_read_sysfs(void)
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
 		/* add to static LIST_HEAD(pmus): */
-		perf_pmu__find(dent->d_name);
+		perf_pmu__find2(fd, dent->d_name);
 	}
 
 	closedir(dir);
@@ -763,7 +761,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 
 new_alias:
 	/* need type casts to override 'const' */
-	__perf_pmu__new_alias(data->head, NULL, (char *)pe->name, (char *)pe->desc,
+	__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
 			      (char *)pe->event, pe);
 	return 0;
 }
@@ -814,7 +812,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 
 	if (!strcmp(pmu->id, pe->compat) &&
 	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
-		__perf_pmu__new_alias(idata->head, NULL,
+		__perf_pmu__new_alias(idata->head, -1,
 				      (char *)pe->name,
 				      (char *)pe->desc,
 				      (char *)pe->event,
@@ -863,7 +861,7 @@ static int pmu_max_precise(struct perf_pmu *pmu)
 	return max_precise;
 }
 
-static struct perf_pmu *pmu_lookup(const char *lookup_name)
+static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 {
 	struct perf_pmu *pmu;
 	LIST_HEAD(format);
@@ -884,13 +882,13 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(name, &format))
+	if (pmu_format(dirfd, name, &format))
 		return NULL;
 
 	/*
 	 * Check the aliases first to avoid unnecessary work.
 	 */
-	if (pmu_aliases(name, &aliases))
+	if (pmu_aliases(dirfd, name, &aliases))
 		return NULL;
 
 	pmu = zalloc(sizeof(*pmu));
@@ -1024,6 +1022,27 @@ bool evsel__is_aux_event(const struct evsel *evsel)
 }
 
 struct perf_pmu *perf_pmu__find(const char *name)
+{
+	struct perf_pmu *pmu;
+	int dirfd;
+
+	/*
+	 * Once PMU is loaded it stays in the list,
+	 * so we keep us from multiple reading/parsing
+	 * the pmu format definitions.
+	 */
+	pmu = pmu_find(name);
+	if (pmu)
+		return pmu;
+
+	dirfd = perf_pmu__event_source_devices_fd();
+	pmu = pmu_lookup(dirfd, name);
+	close(dirfd);
+
+	return pmu;
+}
+
+static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
 
@@ -1036,7 +1055,7 @@ struct perf_pmu *perf_pmu__find(const char *name)
 	if (pmu)
 		return pmu;
 
-	return pmu_lookup(name);
+	return pmu_lookup(dirfd, name);
 }
 
 static struct perf_pmu_format *
@@ -1938,6 +1957,18 @@ int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size)
 	return scnprintf(pathname, size, "%s/bus/event_source/devices/", sysfs);
 }
 
+int perf_pmu__event_source_devices_fd(void)
+{
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs)
+		return -1;
+
+	scnprintf(path, sizeof(path), "%s/bus/event_source/devices/", sysfs);
+	return open(path, O_DIRECTORY);
+}
+
 /*
  * Fill 'buf' with the path to a file or folder in 'pmu_name' in
  * sysfs. For example if pmu_name = "cs_etm" and 'filename' = "format"
@@ -1957,6 +1988,14 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 	return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filename);
 }
 
+int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags)
+{
+	char path[PATH_MAX];
+
+	scnprintf(path, sizeof(path), "%s/%s", pmu_name, filename);
+	return openat(dirfd, path, flags);
+}
+
 static void perf_pmu__delete(struct perf_pmu *pmu)
 {
 	perf_pmu__del_formats(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 72fd5de334c0..751c7016e7b6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -211,7 +211,7 @@ void perf_pmu_error(struct list_head *list, char *name, char const *msg);
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
 void perf_pmu__set_format(unsigned long *bits, long from, long to);
-int perf_pmu__format_parse(char *dir, struct list_head *head);
+int perf_pmu__format_parse(int dirfd, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
@@ -257,6 +257,8 @@ double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
+int perf_pmu__event_source_devices_fd(void);
+int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
 
 void perf_pmu__destroy(void);
-- 
2.40.0.348.gf938b09366-goog

