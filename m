Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE86544D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLVQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiLVQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:07:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82B242EFAB;
        Thu, 22 Dec 2022 08:07:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E912F4;
        Thu, 22 Dec 2022 08:08:10 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 591F33FAFB;
        Thu, 22 Dec 2022 08:07:26 -0800 (PST)
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
Subject: [PATCH v2 3/7] perf: Remove remaining duplication of bus/event_source/devices/...
Date:   Thu, 22 Dec 2022 16:03:23 +0000
Message-Id: <20221222160328.3639989-4-james.clark@arm.com>
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

Use the new perf_pmu__pathname_scnprintf() instead. No functional
changes.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/pmu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index faaeec1e15aa..15b852b3c401 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -574,8 +574,6 @@ static void pmu_read_sysfs(void)
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
-#define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
-
 static struct perf_cpu_map *pmu_cpumask(char *name)
 {
 	struct perf_cpu_map *cpus;
@@ -616,9 +614,9 @@ static char *pmu_id(const char *name)
 	char path[PATH_MAX], *str;
 	size_t len;
 
-	snprintf(path, PATH_MAX, SYS_TEMPLATE_ID, name);
+	perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "identifier");
 
-	if (sysfs__read_str(path, &str, &len) < 0)
+	if (filename__read_str(path, &str, &len) < 0)
 		return NULL;
 
 	str[len - 1] = 0; /* remove line feed */
@@ -864,16 +862,11 @@ pmu_find_alias_name(const char *name __maybe_unused)
 	return NULL;
 }
 
-static int pmu_max_precise(const char *name)
+static int pmu_max_precise(struct perf_pmu *pmu)
 {
-	char path[PATH_MAX];
 	int max_precise = -1;
 
-	scnprintf(path, PATH_MAX,
-		 "bus/event_source/devices/%s/caps/max_precise",
-		 name);
-
-	sysfs__read_int(path, &max_precise);
+	perf_pmu__scan_file(pmu, "caps/max_precise", "%d", &max_precise);
 	return max_precise;
 }
 
@@ -932,7 +925,7 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-	pmu->max_precise = pmu_max_precise(name);
+	pmu->max_precise = pmu_max_precise(pmu);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
 
-- 
2.25.1

