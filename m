Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315ED7265DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFGQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFGQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823471702;
        Wed,  7 Jun 2023 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155242; x=1717691242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PC2lmdyM/DcEWmb3eHpqN26YItN5+UuqPehPfmepDRw=;
  b=dEcxRc5eB1qjuN8jEq/Xud/bmb6QwFEGF13h8ykKE/OFX24QupyB54Dj
   k8QkzmrfMJbpd9lSWJIIRWHziwzvDysry+NHsx0+pR3Axrd4DWz+GMDvs
   HU7pBnsRJXcCgsgQOnEq/+Cp5jo3E7C49TFdGdPMOwIf1lY2ZBHUbgdd6
   ifrsN1GJH1kxIEspWCzdoPi+ObJg8/io72v363SFB6XQavmiNizwWcodP
   SF5kGw0bKpAWqqtQhTjiOet2D+wJ3WFkCS18EaGhFLRnCEKZFYWlQlBlT
   Hfq2mI27n0xDo0jSBTq5IMQNJFzo68J67uXISgWrLYUmVzekGTjinFuA2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892624"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892624"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697657"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697657"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:19 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/8] perf evsel: Fix the annotation for hardware events on hybrid
Date:   Wed,  7 Jun 2023 09:26:54 -0700
Message-Id: <20230607162700.3234712-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230607162700.3234712-1-kan.liang@linux.intel.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The annotation for hardware events is wrong on hybrid. For example,

 # ./perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,148.85 msec cpu-clock                        #   32.000 CPUs utilized
               374      context-switches                 #   11.633 /sec
                33      cpu-migrations                   #    1.026 /sec
               295      page-faults                      #    9.176 /sec
        18,979,960      cpu_core/cycles/                 #  590.378 K/sec
       261,230,783      cpu_atom/cycles/                 #    8.126 M/sec                       (54.21%)
        17,019,732      cpu_core/instructions/           #  529.404 K/sec
        38,020,470      cpu_atom/instructions/           #    1.183 M/sec                       (63.36%)
         3,296,743      cpu_core/branches/               #  102.546 K/sec
         6,692,338      cpu_atom/branches/               #  208.167 K/sec                       (63.40%)
            96,421      cpu_core/branch-misses/          #    2.999 K/sec
         1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec                       (63.38%)

The hardware events have extended type on hybrid, but the evsel__match()
doesn't take it into account.

Add a mask to filter the extended type on hybrid when checking the config.

With the patch,

 # ./perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,139.90 msec cpu-clock                        #   32.003 CPUs utilized
               343      context-switches                 #   10.672 /sec
                32      cpu-migrations                   #    0.996 /sec
                73      page-faults                      #    2.271 /sec
        13,712,841      cpu_core/cycles/                 #    0.000 GHz
       258,301,691      cpu_atom/cycles/                 #    0.008 GHz                         (54.20%)
        12,428,163      cpu_core/instructions/           #    0.91  insn per cycle
        37,786,557      cpu_atom/instructions/           #    2.76  insn per cycle              (63.35%)
         2,418,826      cpu_core/branches/               #   75.259 K/sec
         6,965,962      cpu_atom/branches/               #  216.739 K/sec                       (63.38%)
            72,150      cpu_core/branch-misses/          #    2.98% of all branches
         1,032,746      cpu_atom/branch-misses/          #   42.70% of all branches             (63.35%)

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.h       | 12 ++++++-----
 tools/perf/util/stat-shadow.c | 39 +++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b365b449c6ea..36a32e4ca168 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -350,9 +350,11 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 
-#define evsel__match(evsel, t, c)		\
+#define EVSEL_EVENT_MASK			(~0ULL)
+
+#define evsel__match(evsel, t, c, m)			\
 	(evsel->core.attr.type == PERF_TYPE_##t &&	\
-	 evsel->core.attr.config == PERF_COUNT_##c)
+	 (evsel->core.attr.config & m) == PERF_COUNT_##c)
 
 static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 {
@@ -438,13 +440,13 @@ bool evsel__is_function_event(struct evsel *evsel);
 
 static inline bool evsel__is_bpf_output(struct evsel *evsel)
 {
-	return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
+	return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT, EVSEL_EVENT_MASK);
 }
 
 static inline bool evsel__is_clock(const struct evsel *evsel)
 {
-	return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
-	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
+	return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK, EVSEL_EVENT_MASK) ||
+	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK, EVSEL_EVENT_MASK);
 }
 
 bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1566a206ba42..074f38b57e2d 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -6,6 +6,7 @@
 #include "color.h"
 #include "debug.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "rblist.h"
 #include "evlist.h"
 #include "expr.h"
@@ -78,6 +79,8 @@ void perf_stat__reset_shadow_stats(void)
 
 static enum stat_type evsel__stat_type(const struct evsel *evsel)
 {
+	u64 mask = perf_pmus__supports_extended_type() ? PERF_HW_EVENT_MASK : EVSEL_EVENT_MASK;
+
 	/* Fake perf_hw_cache_op_id values for use with evsel__match. */
 	u64 PERF_COUNT_hw_cache_l1d_miss = PERF_COUNT_HW_CACHE_L1D |
 		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
@@ -97,41 +100,41 @@ static enum stat_type evsel__stat_type(const struct evsel *evsel)
 
 	if (evsel__is_clock(evsel))
 		return STAT_NSECS;
-	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES, mask))
 		return STAT_CYCLES;
-	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
+	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS, mask))
 		return STAT_INSTRUCTIONS;
-	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
+	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND, mask))
 		return STAT_STALLED_CYCLES_FRONT;
-	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND))
+	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND, mask))
 		return STAT_STALLED_CYCLES_BACK;
-	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS))
+	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS, mask))
 		return STAT_BRANCHES;
-	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES))
+	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES, mask))
 		return STAT_BRANCH_MISS;
-	else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES))
+	else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES, mask))
 		return STAT_CACHE_REFS;
-	else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES))
+	else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES, mask))
 		return STAT_CACHE_MISSES;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D))
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D, mask))
 		return STAT_L1_DCACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I))
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I, mask))
 		return STAT_L1_ICACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL))
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL, mask))
 		return STAT_LL_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB))
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB, mask))
 		return STAT_DTLB_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB))
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB, mask))
 		return STAT_ITLB_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss))
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss, mask))
 		return STAT_L1D_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss))
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss, mask))
 		return STAT_L1I_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss))
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss, mask))
 		return STAT_LL_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss))
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss, mask))
 		return STAT_DTLB_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss))
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss, mask))
 		return STAT_ITLB_MISS;
 	return STAT_NONE;
 }
-- 
2.35.1

