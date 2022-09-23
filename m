Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34785E723C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiIWC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiIWC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:58:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031ED11ADE2;
        Thu, 22 Sep 2022 19:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663901926; x=1695437926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VtUhs9WOc9UuQZ5x0+TIIRL73wKpFT5Qb1IRT/bkzgs=;
  b=SLksb6TLSk3wJuZEisp0e/Muh9LVGHZSTKTzu3oY2X5ggViKhLCEGbat
   nd93VF0b0IUw9Ua0dp3DZAkUN9MnxElNBliU6IdtI8XDyILVIE1Ww0V5J
   doyYeVx5mXir0AxHc7vOPkeSTJ+X+PhkM5+hOn5JKQO/kc4aWKOa1hE5Y
   NWLoV7G21OSVrTBc6ATQAhdxJFSMWQS67T5l4IwzXpo4nu5G8GtgG8LpR
   fC4NJm/p2i90aShEUdhrHZBpeeKe18SzKq3Ir7fU48betjP036SDOGLGs
   lXtPYoRmSWdAtgffl0Knxw425DO9s4oN+LxX4OUtwn5AhHCOfDuhhSoAs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298093730"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298093730"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615464338"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2022 19:58:40 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, Yi Ammy <ammy.yi@intel.com>
Subject: [PATCH v2 2/2] perf parse-events: Remove "not supported" hybrid cache events
Date:   Fri, 23 Sep 2022 11:00:13 +0800
Message-Id: <20220923030013.3726410-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923030013.3726410-1-zhengjun.xing@linux.intel.com>
References: <20220923030013.3726410-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

By default, we create two hybrid cache events, one is for cpu_core, and
another is for cpu_atom. But Some hybrid hardware cache events are only
available on one CPU PMU. For example, the 'L1-dcache-load-misses' is only
available on cpu_core, while the 'L1-icache-loads' is only available on
cpu_atom. We need to remove "not supported" hybrid cache events. By
extending is_event_supported() to global API and using it to check if the
hybrid cache events are supported before being created, we can remove the
"not supported" hybrid cache events.

Before:

 # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1

 Performance counter stats for 'system wide':

            52,570      cpu_core/L1-dcache-load-misses/
   <not supported>      cpu_atom/L1-dcache-load-misses/
   <not supported>      cpu_core/L1-icache-loads/
         1,471,817      cpu_atom/L1-icache-loads/

       1.004915229 seconds time elapsed

After:

 # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1

 Performance counter stats for 'system wide':

            54,510      cpu_core/L1-dcache-load-misses/
         1,441,286      cpu_atom/L1-icache-loads/

       1.005114281 seconds time elapsed

Fixes: 30def61f64ba ("perf parse-events: Create two hybrid cache events")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reported-by: Yi Ammy <ammy.yi@intel.com>
---
Change log:
  v2:
    * Adds a comment for removing "not supported" hybrid cache events.
    * Remove goto and add a strdup check
    * "is_event_supported" move to parse-events.c per Ian's suggestion.
    * Adds Reported-by from Yi Ammy <ammy.yi@intel.com>

 tools/perf/util/parse-events-hybrid.c | 21 ++++++++++++---
 tools/perf/util/parse-events.c        | 39 +++++++++++++++++++++++++++
 tools/perf/util/parse-events.h        |  1 +
 tools/perf/util/print-events.c        | 39 ---------------------------
 4 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 284f8eabd3b9..7c9f9150bad5 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -33,7 +33,8 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
 	 * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
 	 */
 	attr->type = type;
-	attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
+	attr->config = (attr->config & PERF_HW_EVENT_MASK) |
+			((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
 }
 
 static int create_event_hybrid(__u32 config_type, int *idx,
@@ -48,13 +49,25 @@ static int create_event_hybrid(__u32 config_type, int *idx,
 	__u64 config = attr->config;
 
 	config_hybrid_attr(attr, config_type, pmu->type);
+
+	/*
+	 * Some hybrid hardware cache events are only available on one CPU
+	 * PMU. For example, the 'L1-dcache-load-misses' is only available
+	 * on cpu_core, while the 'L1-icache-loads' is only available on
+	 * cpu_atom. We need to remove "not supported" hybrid cache events.
+	 */
+	if (attr->type == PERF_TYPE_HW_CACHE
+	    && !is_event_supported(attr->type, attr->config))
+		return 0;
+
 	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
 					       pmu, config_terms);
-	if (evsel)
+	if (evsel) {
 		evsel->pmu_name = strdup(pmu->name);
-	else
+		if (!evsel->pmu_name)
+			return -ENOMEM;
+	} else
 		return -ENOMEM;
-
 	attr->type = type;
 	attr->config = config;
 	return 0;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f05e15acd33f..f3b2c2a87456 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
 #include "tracepoint.h"
+#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -157,6 +158,44 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 #define PERF_EVENT_TYPE(config)		__PERF_EVENT_FIELD(config, TYPE)
 #define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
 
+bool is_event_supported(u8 type, u64 config)
+{
+	bool ret = true;
+	int open_return;
+	struct evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.disabled = 1,
+	};
+	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
+
+	if (tmap == NULL)
+		return false;
+
+	evsel = evsel__new(&attr);
+	if (evsel) {
+		open_return = evsel__open(evsel, NULL, tmap);
+		ret = open_return >= 0;
+
+		if (open_return == -EACCES) {
+			/*
+			 * This happens if the paranoid value
+			 * /proc/sys/kernel/perf_event_paranoid is set to 2
+			 * Re-run with exclude_kernel set; we don't do that
+			 * by default as some ARM machines do not support it.
+			 *
+			 */
+			evsel->core.attr.exclude_kernel = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+		evsel__delete(evsel);
+	}
+
+	perf_thread_map__put(tmap);
+	return ret;
+}
+
 const char *event_type(int type)
 {
 	switch (type) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7e6a601d9cd0..07df7bb7b042 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -19,6 +19,7 @@ struct option;
 struct perf_pmu;
 
 bool have_tracepoints(struct list_head *evlist);
+bool is_event_supported(u8 type, u64 config);
 
 const char *event_type(int type);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 04050d4f6db8..c4d5d87fae2f 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -22,7 +22,6 @@
 #include "probe-file.h"
 #include "string2.h"
 #include "strlist.h"
-#include "thread_map.h"
 #include "tracepoint.h"
 #include "pfm.h"
 #include "pmu-hybrid.h"
@@ -239,44 +238,6 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 	strlist__delete(sdtlist);
 }
 
-static bool is_event_supported(u8 type, u64 config)
-{
-	bool ret = true;
-	int open_return;
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = type,
-		.config = config,
-		.disabled = 1,
-	};
-	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
-
-	if (tmap == NULL)
-		return false;
-
-	evsel = evsel__new(&attr);
-	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
-
-		if (open_return == -EACCES) {
-			/*
-			 * This happens if the paranoid value
-			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
-			 */
-			evsel->core.attr.exclude_kernel = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-		evsel__delete(evsel);
-	}
-
-	perf_thread_map__put(tmap);
-	return ret;
-}
-
 int print_hwcache_events(const char *event_glob, bool name_only)
 {
 	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
-- 
2.25.1

