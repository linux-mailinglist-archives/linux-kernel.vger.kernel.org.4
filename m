Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483C0695064
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBMTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBMTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D6113FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315286; x=1707851286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fxFiGFPky9M3poyi0730g1j+bTkHg+8oo/QfUKfpmfE=;
  b=W61ZLQ1LWzYrf4I3Ba/hdnO/+e9BkSaup7utoAXJIJU52KCsx9gCAB9H
   dM3ZN01qyZlYBnphcOM4KVRtaYHxINvdbig+XAYZ1U4SfRx2CUfENSWGv
   22b1oirDuuqVze+bOapS2lEWZ0vpFBcIcASP3pElXzIkMkC1ksbWmxa28
   TxabMpRJ6qhkQyooyeGjESIMauXyHfcyMQsKjxWrWr7SMFDyULL62vEEz
   lGfKOnlfoV31/Hd3qFNJ8K4PVbuPOTswYtAgqaOw+42rKDpW2aBPrlsS7
   Afn8uBZYi7XQBICX/ao/aRdXQpacfuiADIDlcF0YrW5oa5Zsllon723lK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108738"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901943"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901943"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:05 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC PATCH V2 4/9] perf/x86: Enable post-processing monotonic raw conversion
Date:   Mon, 13 Feb 2023 11:07:49 -0800
Message-Id: <20230213190754.1836051-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213190754.1836051-1-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
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

The raw HW time is from TSC on X86. Preload the HW time for each sample,
once the hw_time is set with the monotonic raw clock by the new perf
tool. Also, dump the conversion information into mmap_page.

For the legacy perf tool which doesn't know the hw_time, nothing is
changed.

Move the x86_pmu_sample_preload() before setup_pebs_time() to utilize
the TSC from a PEBS record.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/core.c       | 10 ++++++++++
 arch/x86/events/intel/ds.c   | 14 +++++++++++---
 arch/x86/events/perf_event.h | 12 ++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b19ac54ebeea..7c1dfb8c763d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2740,6 +2740,16 @@ void arch_perf_update_userpage(struct perf_event *event,
 	if (!event->attr.use_clockid) {
 		userpg->cap_user_time_zero = 1;
 		userpg->time_zero = offset;
+	} else if (perf_event_hw_time(event)) {
+		struct ktime_conv mono;
+
+		userpg->cap_user_time_mono_raw = 1;
+		ktime_get_fast_mono_raw_conv(&mono);
+		userpg->time_mono_last = mono.cycle_last;
+		userpg->time_mono_mult = mono.mult;
+		userpg->time_mono_shift = mono.shift;
+		userpg->time_mono_nsec = mono.xtime_nsec;
+		userpg->time_mono_base = mono.base;
 	}
 
 	cyc2ns_read_end();
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2f59573ed463..10d4b63c891f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1574,6 +1574,12 @@ static void setup_pebs_time(struct perf_event *event,
 			    struct perf_sample_data *data,
 			    u64 tsc)
 {
+	u64 time = tsc;
+
+	/* Perf tool does the conversion. No conversion here. */
+	if (perf_event_hw_time(event))
+		goto done;
+
 	/* Converting to a user-defined clock is not supported yet. */
 	if (event->attr.use_clockid != 0)
 		return;
@@ -1588,7 +1594,9 @@ static void setup_pebs_time(struct perf_event *event,
 	if (!using_native_sched_clock() || !sched_clock_stable())
 		return;
 
-	data->time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
+	time = native_sched_clock_from_tsc(tsc) + __sched_clock_offset;
+done:
+	data->time = time;
 	data->sample_flags |= PERF_SAMPLE_TIME;
 }
 
@@ -1733,6 +1741,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		}
 	}
 
+	x86_pmu_sample_preload(data, event, cpuc);
+
 	/*
 	 * v3 supplies an accurate time stamp, so we use that
 	 * for the time stamp.
@@ -1741,8 +1751,6 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 */
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
-
-	x86_pmu_sample_preload(data, event, cpuc);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ae6ec58fde14..0486ee6a7605 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1185,12 +1185,24 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
+static inline bool perf_event_hw_time(struct perf_event *event)
+{
+	return (event->attr.hw_time &&
+		event->attr.use_clockid &&
+		(event->attr.clockid == CLOCK_MONOTONIC_RAW));
+}
+
 static inline void x86_pmu_sample_preload(struct perf_sample_data *data,
 					  struct perf_event *event,
 					  struct cpu_hw_events *cpuc)
 {
 	if (has_branch_stack(event))
 		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+
+	if (perf_event_hw_time(event)) {
+		data->time = rdtsc();
+		data->sample_flags |= PERF_SAMPLE_TIME;
+	}
 }
 
 extern struct event_constraint emptyconstraint;
-- 
2.35.1

