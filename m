Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673FB6DCC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDJUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:44:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B910FC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159448; x=1712695448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87GBi8GMt5ychBTq0IrHqGH2wrdPeElh2L2XB8MuP14=;
  b=XOHrXwvkEaoX2Kcf1gJtd/AX+eT0BT14smU4QZkDo98KZ3zy+ydh3X6I
   n2MIPpHe0VPNqpfhyJIelcSoJpK9YpG74c3y+dTR8IpPpEyg+6HcJ8TQ/
   wAR5pXzrtKmIu9bYh/CiWULufVacJELwcNCDMOSbAi0ZxwwO3hb+g55Yk
   8GbB3uE/kTl1n7/J3RJSEkWMst+rivao1Biqp7vrwOH4tzTvlKqO52frt
   Lrhek9Z6sEnp0dtWxEGLeTdM8iZT0F1aBjuMBlm3QrSm0WVo6apHz7dWw
   S0j0CqfGuFWs9GxYvaduiF4t3tLSYBaj0x3yqAgnKpxzYf1rd3RVyQ/nv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408588934"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408588934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638569720"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638569720"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 13:44:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/6] perf/x86/intel: Support LBR event logging
Date:   Mon, 10 Apr 2023 13:43:49 -0700
Message-Id: <20230410204352.1098067-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230410204352.1098067-1-kan.liang@linux.intel.com>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR event logging introduces a per-counter indication of precise
event occurrences in LBRs. It can provide a means to attribute exposed
retirement latency to combinations of events across a block of
instructions. It also provides a means of attributing Timed LBR
latencies to events.

The feature and supported counters can be enumerated in the ARCH LBR
leaf. Add an x86_pmu flag to indicate the availability of the feature.

The feature is only supported on the first 4 GP counters on SRF/GRR.
Force the event constraint to the first 4 GP counters.

The LBR event is logged by the counter order, which is not available for
the perf tool. Records the event IDs if the PERF_SAMPLE_BRANCH_EVENT_IDS
sample type is set. The cpuc->events has global information. Filter the
system-wide events IDs for a per-thread event.

When rescheduling a counter, which was assigned to an event enabled the
LBR event logging feature, the existing LBR entries may contain the
counter information. If the counter is assigned to another event later,
the information will be wrongly interpreted. Flush the LBR for the case.

Add sanity check in intel_pmu_hw_config(). Disable the feature if other
counter filters (inv, cmask, edge, in_tx) are set or LBR call stack mode
is enabled. (For the LBR call stack mode, we cannot simply flush the
LBR, since it will break the call stack. Also, there is no obvious usage
with the call stack mode for now.)

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 28 ++++++++--
 arch/x86/events/intel/ds.c        |  1 +
 arch/x86/events/intel/lbr.c       | 86 +++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h      |  8 +++
 arch/x86/include/asm/msr-index.h  |  2 +
 arch/x86/include/asm/perf_event.h |  4 ++
 6 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0bc325b7e028..6c9ecb8f3a4b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2788,6 +2788,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
 static void intel_pmu_enable_event(struct perf_event *event)
 {
+	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -2795,9 +2796,13 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		intel_pmu_pebs_enable(event);
 
 	switch (idx) {
-	case 0 ... INTEL_PMC_IDX_FIXED - 1:
+	case 0 ... PERF_MAX_BRANCH_EVENTS - 1:
+		if (branch_sample_event(event))
+			enable_mask |= ARCH_PERFMON_EVENTSEL_LBR_LOG;
+		fallthrough;
+	case PERF_MAX_BRANCH_EVENTS ... INTEL_PMC_IDX_FIXED - 1:
 		intel_set_masks(event, idx);
-		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
@@ -3047,8 +3052,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			intel_pmu_lbr_save_event_ids(&data, event, cpuc);
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
@@ -3613,6 +3620,13 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
+	/* The LBR event logging is only available for some counters. */
+	if (branch_sample_event(event)) {
+		c2 = dyn_constraint(cpuc, c2, idx);
+		c2->idxmsk64 &= x86_pmu.lbr_events;
+		c2->weight = hweight64(c2->idxmsk64);
+	}
+
 	return c2;
 }
 
@@ -3898,6 +3912,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
+	if (branch_sample_event(event) &&
+	    (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
+	     (event->attr.config & ~INTEL_ARCH_EVENT_MASK) ||
+	     (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK)))
+		return -EINVAL;
+
 	if (needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
@@ -4549,7 +4569,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_LBR_EVENT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1630a084dfe8..413690191a89 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1920,6 +1920,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+			intel_pmu_lbr_save_event_ids(data, event, cpuc);
 		}
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c3b0d15a9841..7418753cc458 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -676,6 +676,48 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->pmu);
+
+	/*
+	 * When rescheduling a counter, which was assigned to an event
+	 * enabled the LBR event logging feature, the existing LBR
+	 * entries may contain the counter information. If the counter
+	 * is assigned to another event later, the information will be
+	 * wrongly interpreted. It's too expensive to modify the counter
+	 * information for each existing LBR entry compared with flushing
+	 * the LBR.
+	 */
+	if (branch_sample_event(event)) {
+		int i, flexible = 0;
+
+		for (i = 0; i < PERF_MAX_BRANCH_EVENTS; i++) {
+			struct perf_event *e = cpuc->events[i];
+
+			if (e && !e->attr.pinned)
+				flexible++;
+		}
+
+		/*
+		 * There should be two common cases for rescheduling,
+		 * multiplexing and context switch.
+		 * - For the multiplexing, only the flexible events are
+		 *   rescheduled. The LBR entries will only be flushed
+		 *   for the last flexible event with the LBR event
+		 *   logging feature.
+		 * - For the context switch, the LBR will be unconditionally
+		 *   flushed when the new task is scheduled in. Ideally,
+		 *   the flush is not required. But it's hard to tell
+		 *   whether it's a context switch here.
+		 *   There could be a case that an extra flush is introduced.
+		 *   But the extra flush doesn't impact the functionality.
+		 *   For example, both the new task and the old task are
+		 *   monitored by some flexible events with LBR event logging
+		 *   enabled. There will be an extra flush when the last
+		 *   flexible event of the old task is scheduled out. But the
+		 *   case should not be a common case.
+		 */
+		if (!flexible && !event->attr.pinned)
+			intel_pmu_arch_lbr_reset();
+	}
 }
 
 static inline bool vlbr_exclude_host(void)
@@ -866,6 +908,16 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 	return cycles;
 }
 
+static u8 get_lbr_events(struct cpu_hw_events *cpuc, u64 info)
+{
+	u8 lbr_events = 0;
+
+	if (x86_pmu.flags & PMU_FL_LBR_EVENT)
+		lbr_events = (info & LBR_INFO_EVENTS) >> LBR_INFO_EVENTS_OFFSET;
+
+	return lbr_events;
+}
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -898,6 +950,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
+		e->events	= get_lbr_events(cpuc, info);
 	}
 
 	cpuc->lbr_stack.nr = i;
@@ -1198,6 +1251,35 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	intel_pmu_lbr_filter(cpuc);
 }
 
+void intel_pmu_lbr_save_event_ids(struct perf_sample_data *data,
+				  struct perf_event *event,
+				  struct cpu_hw_events *cpuc)
+{
+	bool filter;
+	int i;
+
+	if (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
+	    !(event->attr.sample_type & PERF_SAMPLE_BRANCH_EVENT_IDS))
+		return;
+
+	/* Filter the system-wide events ID for per-thread event */
+	filter = !!(event->attach_state & PERF_ATTACH_TASK);
+
+	for (i = 0; i < PERF_MAX_BRANCH_EVENTS; i++) {
+		struct perf_event *e = cpuc->events[i];
+
+		if (e && branch_sample_event(e) &&
+		    (!filter || (e->attach_state & PERF_ATTACH_TASK))) {
+			cpuc->lbr_ids[i] = cpuc->events[i]->id;
+			continue;
+		}
+		cpuc->lbr_ids[i] = -1ULL;
+	}
+
+	cpuc->lbr_event_ids.nr = PERF_MAX_BRANCH_EVENTS;
+	perf_sample_save_event_ids(data, &cpuc->lbr_event_ids);
+}
+
 /*
  * Map interface branch filters onto LBR filters
  */
@@ -1525,8 +1607,12 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_mispred = ecx.split.lbr_mispred;
 	x86_pmu.lbr_timed_lbr = ecx.split.lbr_timed_lbr;
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
+	x86_pmu.lbr_events = ecx.split.lbr_events;
 	x86_pmu.lbr_nr = lbr_nr;
 
+	if (!!x86_pmu.lbr_events)
+		x86_pmu.flags |= PMU_FL_LBR_EVENT;
+
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
 	if (x86_pmu.lbr_timed_lbr)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c8ba2be7585d..feeef9d41cac 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -283,6 +283,8 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+	struct perf_branch_event_ids	lbr_event_ids;
+	u64				lbr_ids[PERF_MAX_BRANCH_EVENTS];
 	union {
 		struct er_account		*lbr_sel;
 		struct er_account		*lbr_ctl;
@@ -881,6 +883,7 @@ struct x86_pmu {
 	unsigned int	lbr_mispred:1;
 	unsigned int	lbr_timed_lbr:1;
 	unsigned int	lbr_br_type:1;
+	unsigned int	lbr_events:4;
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
@@ -1005,6 +1008,7 @@ do {									\
 #define PMU_FL_INSTR_LATENCY	0x80 /* Support Instruction Latency in PEBS Memory Info Record */
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
+#define PMU_FL_LBR_EVENT	0x400 /* Support LBR event logging */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
@@ -1545,6 +1549,10 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_save_event_ids(struct perf_sample_data *data,
+				  struct perf_event *event,
+				  struct cpu_hw_events *cpuc);
+
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ad35355ee43e..b845eeb527ef 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -222,6 +222,8 @@
 #define LBR_INFO_CYCLES			0xffff
 #define LBR_INFO_BR_TYPE_OFFSET		56
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+#define LBR_INFO_EVENTS_OFFSET		32
+#define LBR_INFO_EVENTS			(0xffull << LBR_INFO_EVENTS_OFFSET)
 
 #define MSR_ARCH_LBR_CTL		0x000014ce
 #define ARCH_LBR_CTL_LBREN		BIT(0)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..2ae60c378e3a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -31,6 +31,7 @@
 #define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
+#define ARCH_PERFMON_EVENTSEL_LBR_LOG			(1ULL << 35)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -203,6 +204,9 @@ union cpuid28_ecx {
 		unsigned int    lbr_timed_lbr:1;
 		/* Branch Type Field Supported */
 		unsigned int    lbr_br_type:1;
+		unsigned int	reserved:13;
+		/* Event Logging Supported */
+		unsigned int	lbr_events:4;
 	} split;
 	unsigned int            full;
 };
-- 
2.35.1

