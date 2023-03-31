Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BB6D297A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjCaUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjCaUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8F24426;
        Fri, 31 Mar 2023 13:30:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so24637056pjz.1;
        Fri, 31 Mar 2023 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294604; x=1682886604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEdFQ1e9O/nmgtLY4q6GhreBjz/AYmss+2MTbnjFDcU=;
        b=aycFzHBdi0Sa6AEyDSKkTns8AJjhvaJozVBp/IYcun2wMMQmMwZ5oZV30btThiZEEl
         u7CKMhM0f0d+Ny+AChC4r87PKnCuWY0kOc2jFYfkT1k6KYP59BqYk9lJwOm0gnRgNE27
         nKTh7PBOKHJ9PBBgJ3Wq7pFlH8oZVNn3N7NocMoe0PCRC+J6xZJCQpGavGDwQ+4AoQwq
         L9BurlyC52Lv6ZVtH3IcAo61KjsuvugZ6dhyXLkGe96R+gD5RluGFSlCRpwHF8eDMuLD
         ak16qZI2zV3i5ZXndX1om6aBL2O2qs3ol/HCgISa6g8s62HTkfWPeEfFPcRyKDFNyPOt
         aYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294604; x=1682886604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEdFQ1e9O/nmgtLY4q6GhreBjz/AYmss+2MTbnjFDcU=;
        b=cKWgaty8hRLyQXdKl33J50BAhrEK2hadv92a7MsMhrAcV1k8ppO8A2fbz3YyflfJly
         ltcd/QI++U6DJn3VBSq/YUfw8EKnX0PQGefBjZTy/CAIAUyzcxhHAkT/juj8++qEeU8q
         6SSj54+NcPhKnTIHmDHi1yAC0Twq+zCIpyxyBc0n7rnsyrVDA7dIbrcI+myf58MgdLuK
         nLpxoIgY9Le/6GR33xNh/AqMSOsNmM9tgTaSXPKs3NWRak/BpEHvNZr2+mdGS/tiYw+1
         Ht1MgBVI8Mnx1UlANdeqlYU0uZEOcwbnAB4l0ALRgIfn06CHLY5t+YkE9yfppNWsSyWC
         PLnA==
X-Gm-Message-State: AAQBX9dm0i28nJG76nR95o3hmLCoaC7EYpHppIqQr0QOcC27JRfZDEFD
        skncOjuUZRF+h+/g4X96oas=
X-Google-Smtp-Source: AKy350aRn4Df8msY0H66XmKOonObnVNoorAxA7bGhq2EYBbPFfIS1zNn+vTN8KMLtqsCcHSefjPJ+A==
X-Received: by 2002:a17:902:e3c5:b0:19a:98c9:8cea with SMTP id r5-20020a170902e3c500b0019a98c98ceamr21379978ple.39.1680294603600;
        Fri, 31 Mar 2023 13:30:03 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:30:03 -0700 (PDT)
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
Subject: [PATCH 8/9] perf pmu: Add perf_pmu__{open,scan}_file_at()
Date:   Fri, 31 Mar 2023 13:29:48 -0700
Message-Id: <20230331202949.810326-9-namhyung@kernel.org>
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

These two helpers will also use openat() to reduce the overhead with
relative pathnames.  Convert other functions in pmu_lookup() to use
the new helpers.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 57 ++++++++++++++++++++++++++++++++++---------
 tools/perf/util/pmu.h |  6 ++++-
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0c1d87f10b23..78a407b42ad1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -567,7 +567,7 @@ static void pmu_read_sysfs(void)
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
-static struct perf_cpu_map *pmu_cpumask(const char *name)
+static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
 {
 	struct perf_cpu_map *cpus;
 	const char *templates[] = {
@@ -582,10 +582,11 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 
 	strlcpy(pmu_name, name, sizeof(pmu_name));
 	for (template = templates; *template; template++) {
-		file = perf_pmu__open_file(&pmu, *template);
+		file = perf_pmu__open_file_at(&pmu, dirfd, *template);
 		if (!file)
 			continue;
 		cpus = perf_cpu_map__read(file);
+		fclose(file);
 		if (cpus)
 			return cpus;
 	}
@@ -593,15 +594,19 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 	return NULL;
 }
 
-static bool pmu_is_uncore(const char *name)
+static bool pmu_is_uncore(int dirfd, const char *name)
 {
-	char path[PATH_MAX];
+	int fd;
 
 	if (perf_pmu__hybrid_mounted(name))
 		return false;
 
-	perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpumask");
-	return file_available(path);
+	fd = perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
 }
 
 static char *pmu_id(const char *name)
@@ -853,11 +858,11 @@ pmu_find_alias_name(const char *name __maybe_unused)
 	return NULL;
 }
 
-static int pmu_max_precise(struct perf_pmu *pmu)
+static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 {
 	int max_precise = -1;
 
-	perf_pmu__scan_file(pmu, "caps/max_precise", "%d", &max_precise);
+	perf_pmu__scan_file_at(pmu, dirfd, "caps/max_precise", "%d", &max_precise);
 	return max_precise;
 }
 
@@ -895,14 +900,14 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	if (!pmu)
 		return NULL;
 
-	pmu->cpus = pmu_cpumask(name);
+	pmu->cpus = pmu_cpumask(dirfd, name);
 	pmu->name = strdup(name);
 
 	if (!pmu->name)
 		goto err;
 
 	/* Read type, and ensure that type value is successfully assigned (return 1) */
-	if (perf_pmu__scan_file(pmu, "type", "%u", &type) != 1)
+	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
 		goto err;
 
 	alias_name = pmu_find_alias_name(name);
@@ -913,10 +918,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	}
 
 	pmu->type = type;
-	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-	pmu->max_precise = pmu_max_precise(pmu);
+	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
 
@@ -1730,6 +1735,17 @@ FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 	return fopen(path, "r");
 }
 
+FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
+{
+	int fd;
+
+	fd = perf_pmu__pathname_fd(dirfd, pmu->name, name, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+
+	return fdopen(fd, "r");
+}
+
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 			...)
 {
@@ -1747,6 +1763,23 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return ret;
 }
 
+int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+			   const char *fmt, ...)
+{
+	va_list args;
+	FILE *file;
+	int ret = EOF;
+
+	va_start(args, fmt);
+	file = perf_pmu__open_file_at(pmu, dirfd, name);
+	if (file) {
+		ret = vfscanf(file, fmt, args);
+		fclose(file);
+	}
+	va_end(args);
+	return ret;
+}
+
 bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 751c7016e7b6..32c3a75bca0e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -220,7 +220,12 @@ bool is_pmu_core(const char *name);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
+FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
+FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name);
+
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
+int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+			   const char *fmt, ...) __scanf(4, 5);
 
 bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
 
@@ -259,7 +264,6 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
 int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
 
 void perf_pmu__destroy(void);
 
-- 
2.40.0.348.gf938b09366-goog

