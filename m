Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8328066D6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjAQHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjAQH37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:29:59 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85D22DC1;
        Mon, 16 Jan 2023 23:29:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZm6e2H_1673940589;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZm6e2H_1673940589)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 15:29:49 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v8 1/9] perf pmu: Add #slots literal support for arm64
Date:   Tue, 17 Jan 2023 15:29:25 +0800
Message-Id: <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slots in each architecture may be different, so add #slots literal
to obtain the slots of different architectures, and the #slots can be
applied in the metric. Currently, The #slots just support for arm64,
and other architectures will return NAN.

On arm64, the value of slots is from the register PMMIR_EL1.SLOT, which
I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/arch/arm64/util/pmu.c | 35 +++++++++++++++++++++++++++++++++--
 tools/perf/util/expr.c           |  5 +++++
 tools/perf/util/pmu.c            |  6 ++++++
 tools/perf/util/pmu.h            |  1 +
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 477e513..9e674ca 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -3,8 +3,10 @@
 #include <internal/cpumap.h>
 #include "../../../util/cpumap.h"
 #include "../../../util/pmu.h"
+#include <api/fs/fs.h>
+#include <math.h>
 
-const struct pmu_events_table *pmu_events_table__find(void)
+static struct perf_pmu *pmu__find_core_pmu(void)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -19,8 +21,37 @@ const struct pmu_events_table *pmu_events_table__find(void)
 		if (pmu->cpus->nr != cpu__max_cpu().cpu)
 			return NULL;
 
-		return perf_pmu__find_table(pmu);
+		return pmu;
 	}
 
 	return NULL;
 }
+
+const struct pmu_events_table *pmu_events_table__find(void)
+{
+	struct perf_pmu *pmu = pmu__find_core_pmu();
+
+	if (pmu)
+		return perf_pmu__find_table(pmu);
+
+	return NULL;
+}
+
+double perf_pmu__cpu_slots_per_cycle(void)
+{
+	char path[PATH_MAX];
+	unsigned long long slots = 0;
+	struct perf_pmu *pmu = pmu__find_core_pmu();
+
+	if (pmu) {
+		scnprintf(path, PATH_MAX,
+			EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu->name);
+		/*
+		 * The value of slots is not greater than 32 bits, but sysfs__read_int
+		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
+		 */
+		sysfs__read_ull(path, &slots);
+	}
+
+	return slots ? (double)slots : NAN;
+}
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 00dcde3..c1da20b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -19,6 +19,7 @@
 #include <linux/zalloc.h>
 #include <ctype.h>
 #include <math.h>
+#include "pmu.h"
 
 #ifdef PARSER_DEBUG
 extern int expr_debug;
@@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = topology->core_cpus_lists;
 		goto out;
 	}
+	if (!strcmp("#slots", literal)) {
+		result = perf_pmu__cpu_slots_per_cycle();
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
 out:
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2bdeb89..cbb4fbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -19,6 +19,7 @@
 #include <regex.h>
 #include <perf/cpumap.h>
 #include <fnmatch.h>
+#include <math.h>
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
@@ -1993,3 +1994,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
 }
+
+double __weak perf_pmu__cpu_slots_per_cycle(void)
+{
+	return NAN;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 69ca000..fd414ba 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 
 char *pmu_find_real_name(const char *name);
 char *pmu_find_alias_name(const char *name);
+double perf_pmu__cpu_slots_per_cycle(void);
 #endif /* __PMU_H */
-- 
1.8.3.1

