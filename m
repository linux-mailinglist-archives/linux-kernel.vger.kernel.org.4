Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264BF70BBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEVLbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjEVLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:31:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E74185
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755069; x=1716291069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Szl580wLFev4I9BvDvgwxbomxBHTQubRyY5TKKlei1g=;
  b=K289Q/NbktdweSVE+EYjNHlsZdWfpbfUi+aRXzhZNQSl0LDKjosDHh+f
   wPPKKu4dCrhFRSKJAed9hzwsNBPIwWqun09st+hPAbE1PqG1iKrEw+5/f
   Ml6YPqA44qq/UBTnLL5hY8wFuZqrF/rQWc3RKJYjkap5Fwm9TxeXxjvaX
   RC6HFBxRBX2JzbcL8BeUZljMe1qJGqZUOm6p3cBKD8XtiAeZ+F0zp8C89
   09ss9N4XXFzZ0oOqYv881c7MUpqMX782uk5Zqj6pZTjhfffGBUwOj79+A
   mMJcXiVrSike0DkkAF0i+adO5fEc0Rqdo29s21J0AqZU44VbvUaL4GCZT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416356764"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416356764"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703468264"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703468264"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:31:00 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/6] perf/x86/intel: Support LBR event logging
Date:   Mon, 22 May 2023 04:30:38 -0700
Message-Id: <20230522113040.2329924-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

The feature is first introduced on SRF/GRR. It is an enhancement of the
ARCH LBR. It adds new fields in the LBR_INFO MSRs to log the occurrences
of events on the GP counters. The information is displayed by the order
of counters.

The design proposed in this patch requires that the events which are
logged must be in a group with the event that has LBR. If there are
more than one LBR group, the event logging information only from the
current group (overflowed) are stored for the perf tool, otherwise the
perf tool cannot know which and when other groups are scheduled
especially when multiplexing is triggered. The user can ensure it uses
the maximum number of counters that support LBR info (4 by now) by
making the group large enough.

The HW only logs events by the order of counters. The order may be
different from the order of enabling which the perf tool can understand.
When parsing the information of each branch entry, convert the counter
order to the enabled order, and store the enabled order in the extension
space.

Unconditionally reset LBRs for an LBR event group when it's deleted. The
logged events' occurrences information is only valid for the current LBR
group. If another LBR group is scheduled later, the information from the
stale LBRs would be otherwise wrongly interpreted.

Add a sanity check in intel_pmu_hw_config(). Disable the feature if other
counter filters (inv, cmask, edge, in_tx) are set or LBR call stack mode
is enabled. (For the LBR call stack mode, we cannot simply flush the
LBR, since it will break the call stack. Also, there is no obvious usage
with the call stack mode for now.)

Adding a new event kernel flag, PERF_X86_EVENT_LBR_EVENT, to indicate
the event whose occurrences information is recorded in the branch
information in kernel. The event was marked by the
PERF_SAMPLE_BRANCH_EVT_CNTRS bit in the attr struct. Any perf sample
branch type will triggers branch stack setup. But the event itself
doesn't require a branch stack setup. When initializing the event, clear
the PERF_SAMPLE_BRANCH_EVT_CNTRS bit to avoid a branch stack setup.

Add a SW bit LBR_EVENT_LOG_BIT to indicate a LBR event logging group.
Users may not want to record the event occurrences of the event which
collect LBR, e.g., -e "{cpu/E1,branch_type=any/,cpu/E2,branch_type=event/}".
The PERF_X86_EVENT_LBR_EVENT may not be set for the LBR event. When
saving the LBRs, a LBR flag is required to tell whether storing the
event occurrences information into the extension space.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Using the enabling order. The kernel will change the order of counters
  to the order of enabling.
- Remove the PERF_MAX_BRANCH_EVENTS. The max value should read from the
  CPUID enumeration.
- The enabled order may be undetermined (multiple LBR groups). Only keep
  the event logging information for the current group.
- Add a new event kernel flag, PERF_X86_EVENT_LBR_EVENT, to indicate
  the event whose occurrences information is recorded in the branch
  information in kernel.
- Add a new LBR flag, LBR_EVENT_LOG_BIT, to indicate a LBR event logging
  group.

 arch/x86/events/core.c             |   2 +-
 arch/x86/events/intel/core.c       |  41 +++++++-
 arch/x86/events/intel/ds.c         |   2 +-
 arch/x86/events/intel/lbr.c        | 162 ++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h       |  17 +++
 arch/x86/events/perf_event_flags.h |   1 +
 arch/x86/include/asm/msr-index.h   |   2 +
 arch/x86/include/asm/perf_event.h  |   4 +
 include/linux/perf_event.h         |   5 +
 9 files changed, 228 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..2f1b161cb2bc 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -603,7 +603,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK)
+	if (branch_sample_call_stack(event))
 		event->attach_state |= PERF_ATTACH_TASK_DATA;
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 21566f66bfd8..ec3939fe9098 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2788,6 +2788,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
 static void intel_pmu_enable_event(struct perf_event *event)
 {
+	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -2796,8 +2797,10 @@ static void intel_pmu_enable_event(struct perf_event *event)
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
+		if (log_event_in_branch(event))
+			enable_mask |= ARCH_PERFMON_EVENTSEL_LBR_LOG;
 		intel_set_masks(event, idx);
-		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
@@ -3048,7 +3051,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
@@ -3613,6 +3616,13 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
+	/* The LBR event logging is only available for some counters. */
+	if (log_event_in_branch(event)) {
+		c2 = dyn_constraint(cpuc, c2, idx);
+		c2->idxmsk64 &= x86_pmu.lbr_events;
+		c2->weight = hweight64(c2->idxmsk64);
+	}
+
 	return c2;
 }
 
@@ -3871,6 +3881,17 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static bool intel_pmu_needs_branch_stack(struct perf_event *event)
+{
+	/* NO LBR setup for a counting event */
+	if (!is_sampling_event(event)) {
+		event->attr.branch_sample_type = 0;
+		return false;
+	}
+
+	return needs_branch_stack(event);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3898,7 +3919,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event)) {
+	if (branch_sample_evt_cntrs(event)) {
+		if (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
+		    (event->attr.config & ~INTEL_ARCH_EVENT_MASK))
+			return -EINVAL;
+
+		ret = intel_pmu_setup_lbr_event(event);
+		if (ret)
+			return ret;
+
+		event->hw.flags  |= PERF_X86_EVENT_LBR_EVENT;
+	}
+
+	if (intel_pmu_needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
 			return ret;
@@ -4549,7 +4582,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_LBR_EVENT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3f16e95e99dd..47c0ecbc301d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1904,7 +1904,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c3b0d15a9841..6ee9d9e88586 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -29,7 +29,13 @@
  * the actual MSR. But it helps the constraint perf code to understand
  * that this is a separate configuration.
  */
-#define LBR_NO_INFO_BIT	       63 /* don't read LBR_INFO. */
+#define LBR_NO_INFO_BIT		63 /* don't read LBR_INFO. */
+/*
+ * Indicate a LBR event logging group.
+ * The event logging feature is only available for the ARCH LBR,
+ * while the NO INFO is only applied for the legacy LBR. Reuse the bit.
+ */
+#define LBR_EVENT_LOG_BIT	63
 
 #define LBR_KERNEL	(1 << LBR_KERNEL_BIT)
 #define LBR_USER	(1 << LBR_USER_BIT)
@@ -42,6 +48,7 @@
 #define LBR_FAR		(1 << LBR_FAR_BIT)
 #define LBR_CALL_STACK	(1 << LBR_CALL_STACK_BIT)
 #define LBR_NO_INFO	(1ULL << LBR_NO_INFO_BIT)
+#define LBR_EVENT_LOG	(1ULL << LBR_EVENT_LOG_BIT)
 
 #define LBR_PLM (LBR_KERNEL | LBR_USER)
 
@@ -676,6 +683,21 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->pmu);
+
+	/*
+	 * The logged occurrences information is only valid for the
+	 * current LBR group. If another LBR group is scheduled in
+	 * later, the information from the stale LBRs will be wrongly
+	 * interpreted. Reset the LBRs here.
+	 * For the context switch, the LBR will be unconditionally
+	 * flushed when a new task is scheduled in. If both the new task
+	 * and the old task are monitored by a LBR event group. The
+	 * reset here is redundant. But the extra reset doesn't impact
+	 * the functionality. It's hard to distinguish the above case.
+	 * Keep the unconditionally reset for a LBR event group for now.
+	 */
+	if (intel_pmu_lbr_has_event_log(cpuc))
+		intel_pmu_lbr_reset();
 }
 
 static inline bool vlbr_exclude_host(void)
@@ -866,6 +888,18 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 	return cycles;
 }
 
+static __always_inline void get_lbr_events(struct cpu_hw_events *cpuc,
+					   int i, u64 info)
+{
+	/*
+	 * The later code will decide what content can be disclosed
+	 * to the perf tool. It's no harmful to unconditionally update
+	 * the cpuc->lbr_events.
+	 * Pleae see intel_pmu_lbr_event_reorder()
+	 */
+	cpuc->lbr_events[i] = info & LBR_INFO_EVENTS;
+}
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -898,11 +932,73 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
+
+		get_lbr_events(cpuc, i, info);
 	}
 
 	cpuc->lbr_stack.nr = i;
 }
 
+#define ARCH_LBR_EVENT_LOG_WIDTH	2
+#define ARCH_LBR_EVENT_LOG_MASK		0x3
+
+static __always_inline void intel_pmu_update_lbr_event(u64 *lbr_events, int idx, int pos)
+{
+	u64 logs = *lbr_events >> (LBR_INFO_EVENTS_OFFSET +
+				   idx * ARCH_LBR_EVENT_LOG_WIDTH);
+
+	logs &= ARCH_LBR_EVENT_LOG_MASK;
+	*lbr_events |= logs << (pos * ARCH_LBR_EVENT_LOG_WIDTH);
+}
+
+/*
+ * The enabled order may be different from the counter order.
+ * Update the lbr_events with the enabled order.
+ */
+static void intel_pmu_lbr_event_reorder(struct cpu_hw_events *cpuc,
+					struct perf_event *event)
+{
+	int i, j, pos = 0, enabled[X86_PMC_IDX_MAX];
+	struct perf_event *leader, *sibling;
+
+	leader = event->group_leader;
+	if (log_event_in_branch(event))
+		enabled[pos++] = leader->hw.idx;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!log_event_in_branch(sibling))
+			continue;
+		enabled[pos++] = sibling->hw.idx;
+	}
+
+	if (!pos) {
+		cpuc->lbr_stack_ext.nr = 0;
+		return;
+	}
+
+	cpuc->lbr_stack_ext.nr = cpuc->lbr_stack.nr;
+	for (i = 0; i < cpuc->lbr_stack_ext.nr; i++) {
+		cpuc->lbr_entries[i].ext = true;
+
+		for (j = 0; j < pos; j++)
+			intel_pmu_update_lbr_event(&cpuc->lbr_events[i], enabled[j], j);
+
+		/* Clear the original counter order */
+		cpuc->lbr_events[i] &= ~LBR_INFO_EVENTS;
+	}
+}
+
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (!intel_pmu_lbr_has_event_log(cpuc))
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+
+	intel_pmu_lbr_event_reorder(cpuc, event);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, &cpuc->lbr_stack_ext);
+}
+
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 {
 	intel_pmu_store_lbr(cpuc, NULL);
@@ -1045,6 +1141,10 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 		 * Enable the branch type by default for the Arch LBR.
 		 */
 		reg->reg |= X86_BR_TYPE_SAVE;
+
+		if (log_event_in_branch(event))
+			reg->config |= LBR_EVENT_LOG;
+
 		return 0;
 	}
 
@@ -1091,6 +1191,54 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event)
 	return ret;
 }
 
+bool intel_pmu_lbr_has_event_log(struct cpu_hw_events *cpuc)
+{
+	return cpuc->lbr_sel && (cpuc->lbr_sel->config & LBR_EVENT_LOG);
+}
+
+int intel_pmu_setup_lbr_event(struct perf_event *event)
+{
+	struct perf_event *leader, *sibling;
+
+	/*
+	 * The event logging is not supported in the call stack mode
+	 * yet, since we cannot simply flush the LBR during e.g.,
+	 * multiplexing. Also, there is no obvious usage with the call
+	 * stack mode. Simply forbids it for now.
+	 *
+	 * If any events in the group which enable the LBR event logging
+	 * feature, mark it as a LBR event logging group.
+	 */
+	leader = event->group_leader;
+	if (branch_sample_call_stack(leader))
+		return -EINVAL;
+	if (leader->hw.branch_reg.idx == EXTRA_REG_LBR)
+		leader->hw.branch_reg.config |= LBR_EVENT_LOG;
+
+	for_each_sibling_event(sibling, leader) {
+		if (branch_sample_call_stack(sibling))
+			return -EINVAL;
+		if (sibling->hw.branch_reg.idx == EXTRA_REG_LBR)
+			sibling->hw.branch_reg.config |= LBR_EVENT_LOG;
+	}
+
+	/*
+	 *  The PERF_SAMPLE_BRANCH_EVT_CNTRS is used to mark an event
+	 *  whose occurrences information should be recorded in the
+	 *  branch information.
+	 *  Only applying the PERF_SAMPLE_BRANCH_EVT_CNTRS doesn't
+	 *  require any branch stack setup. Clear the bit to avoid
+	 *  any branch stack setup.
+	 */
+	if (event->attr.branch_sample_type &
+	    ~(PERF_SAMPLE_BRANCH_EVT_CNTRS | PERF_SAMPLE_BRANCH_PLM_ALL))
+		event->attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EVT_CNTRS;
+	else
+		event->attr.branch_sample_type = 0;
+
+	return 0;
+}
+
 enum {
 	ARCH_LBR_BR_TYPE_JCC			= 0,
 	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
@@ -1173,14 +1321,20 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	for (i = 0; i < cpuc->lbr_stack.nr; ) {
 		if (!cpuc->lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
+			while (++j < cpuc->lbr_stack.nr) {
 				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
+				if (cpuc->lbr_stack_ext.nr)
+					cpuc->lbr_events[j-1] = cpuc->lbr_events[j];
+			}
 			cpuc->lbr_stack.nr--;
 			if (!cpuc->lbr_entries[i].from)
 				continue;
 		}
 		i++;
 	}
+
+	if (cpuc->lbr_stack_ext.nr)
+		cpuc->lbr_stack_ext.nr = cpuc->lbr_stack.nr;
 }
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
@@ -1525,8 +1679,12 @@ void __init intel_pmu_arch_lbr_init(void)
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
index c8ba2be7585d..70207ac8e193 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -283,6 +283,8 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+	struct perf_branch_stack_ext	lbr_stack_ext;
+	u64				lbr_events[MAX_LBR_ENTRIES];
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
@@ -1457,6 +1461,11 @@ static __always_inline void __intel_pmu_lbr_disable(void)
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
+static __always_inline bool log_event_in_branch(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_LBR_EVENT;
+}
+
 int intel_pmu_save_and_restart(struct perf_event *event);
 
 struct event_constraint *
@@ -1545,6 +1554,14 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
+bool intel_pmu_lbr_has_event_log(struct cpu_hw_events *cpuc);
+
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event);
+
+int intel_pmu_setup_lbr_event(struct perf_event *event);
+
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 1dc19b9b4426..03e27af123af 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -20,3 +20,4 @@ PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
 PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
 PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
 PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
+PERF_ARCH(LBR_EVENT,		0x40000) /* log the event in LBR */
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
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 823c6779a96d..618c0d8ce88f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1142,6 +1142,11 @@ static inline bool branch_sample_evt_cntrs(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
 }
 
+static inline bool branch_sample_call_stack(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
+}
+
 struct perf_sample_data {
 	/*
 	 * Fields set by perf_sample_data_init() unconditionally,
-- 
2.35.1

