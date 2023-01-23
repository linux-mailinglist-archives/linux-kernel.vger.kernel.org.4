Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B26782F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjAWRVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjAWRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:21:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D271227AA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494463; x=1706030463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A+xur5H+AgRf+akOzYTX4Ok2VEJjg9b5BLOeza7JHbk=;
  b=GzanMttGIcHX6YYst65g3e0poNsDVb8da/Hp//hQovwULrmg2y+LCcfj
   XQcWiKLLDV0iA/fCOLZPmY0UvDUI6wEln07LW2XpHroAkqxZb5sNWEPx2
   FHs/azqx1s/tmI4bzSDKoh/x1dfzyAQl2Ylzi6Wqm9YZVg4Zhz861rzR3
   f5J9gcvNjbGWd/u6VvhPALOLjbWeLu724NaazhXWUMTa/DSv9/4PIqEAC
   6dUrol4eYFJS8ppTNn4AP2yyeDu8KAIeaFa1fO0cHb5ROuT8eyK2mCGrs
   PyO6+7hI1SWH4ScRfJfE2JaH+jWQ983hq2imsoHk1ZLkxtsQNzEj+R7By
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324776367"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="324776367"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="769968980"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="769968980"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jan 2023 09:20:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/ds: Fix the conversion from TSC to perf time
Date:   Mon, 23 Jan 2023 09:20:27 -0800
Message-Id: <20230123172027.125385-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The time order is incorrect when the TSC in a PEBS record is used.

 $perf record -e cycles:upp dd if=/dev/zero of=/dev/null
  count=10000
 $ perf script --show-task-events
       perf-exec     0     0.000000: PERF_RECORD_COMM: perf-exec:915/915
              dd   915   106.479872: PERF_RECORD_COMM exec: dd:915/915
              dd   915   106.483270: PERF_RECORD_EXIT(915:915):(914:914)
              dd   915   106.512429:          1 cycles:upp:
 ffffffff96c011b7 [unknown] ([unknown])
 ... ...

The perf time is from sched_clock_cpu(). The current PEBS code
unconditionally convert the TSC to native_sched_clock(). There is a
shift between the two clocks. If the TSC is stable, the shift is
consistent, __sched_clock_offset. If the TSC is unstable, the shift has
to be calculated at runtime.

The TSC unstable case seems to be some corner cases (e.g., due to broken
BIOS). This patch doesn't support the conversion when the TSC is
unstable. The TSC in a PEBS record will be dropped and fallback to the
software perf time provided by the generic code.

Fixes: 47a3aeb39e8d ("perf/x86/intel/pebs: Fix PEBS timestamps overwritten")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/all/CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 183efa914b99..7980e92dec64 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2,12 +2,14 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/sched/clock.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
 #include <asm/io.h>
+#include <asm/timer.h>
 
 #include "../perf_event.h"
 
@@ -1568,6 +1570,28 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+static void setup_pebs_time(struct perf_event *event,
+			    struct perf_sample_data *data,
+			    u64 tsc)
+{
+	/* Converting to a user-defined clock is not supported yet. */
+	if (event->attr.use_clockid != 0)
+		return;
+
+	/*
+	 * Converting the TSC to perf time is only supported,
+	 * when the TSC is stable.
+	 * The TSC unstable case seems to be some corner cases
+	 * (e.g., due to broken BIOS). Drop the PEBS TSC and
+	 * fall back to the SW time, see perf_event_clock().
+	 */
+	if (!using_native_sched_clock() || !sched_clock_stable())
+		return;
+
+	data->time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
+	data->sample_flags |= PERF_SAMPLE_TIME;
+}
+
 #define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
 				 PERF_SAMPLE_PHYS_ADDR |	\
 				 PERF_SAMPLE_DATA_PAGE_SIZE)
@@ -1715,11 +1739,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 *
 	 * We can only do this for the default trace clock.
 	 */
-	if (x86_pmu.intel_cap.pebs_format >= 3 &&
-		event->attr.use_clockid == 0) {
-		data->time = native_sched_clock_from_tsc(pebs->tsc);
-		data->sample_flags |= PERF_SAMPLE_TIME;
-	}
+	if (x86_pmu.intel_cap.pebs_format >= 3)
+		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
 		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
@@ -1781,10 +1802,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
-	if (event->attr.use_clockid == 0) {
-		data->time = native_sched_clock_from_tsc(basic->tsc);
-		data->sample_flags |= PERF_SAMPLE_TIME;
-	}
+	setup_pebs_time(event, data, basic->tsc);
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
-- 
2.35.1

