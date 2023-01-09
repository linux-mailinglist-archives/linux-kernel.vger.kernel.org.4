Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C42662C14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjAIRDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjAIRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01AE4103B;
        Mon,  9 Jan 2023 09:02:12 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYS9xB76Okq6DaeBefdJIndkBWOwRG43HSJauEWghcM=;
        b=CJ+smQCZi7tI6ZbRqWVrnwfKmwDcAiMGOeWGtYOQyW1W4+dH77XcUz9yrY8NiVChJUaH+F
        wTWWMqEk7dtHiU7W0hTbZAeQhTJ4Hfe78foy2rhLwKR4Z718btvF+CVzTwSh/ubMRMKSjQ
        yi6PqM6wPKlJPXq/wGqvHSUtS6mHEtZZzwb2ACv0ytCkinpyYMAQzFeFKwpfrtyZCJbc2a
        MdfxtTt/aLrIeCJP7YBo4VQcslxOfeYt23Ljd2vB3OY7w5b/WjpqZjZ88TRztRjZjlOPZU
        x/h3MEDXAeLoFw3iVfxwMnIGg9ObLbIKCTkdgTpbf3NsxlEdoedM8+3RYFxx5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYS9xB76Okq6DaeBefdJIndkBWOwRG43HSJauEWghcM=;
        b=1z1hLOQi29SUa3qviIqYPmcwAIqd1Xe4r104oS3wCDfcCeGB1cn/XmqqcbDMcOkDaGj0mP
        7EL3/Vkbna2VKeCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add Meteor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-2-kan.liang@linux.intel.com>
References: <20230104201349.1451191-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372935.4906.15805539259597238995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     38aaf921e92dc5cf87e4a6c5a4b24dd99155cace
Gitweb:        https://git.kernel.org/tip/38aaf921e92dc5cf87e4a6c5a4b24dd99155cace
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:42 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:07 +01:00

perf/x86: Add Meteor Lake support

>From PMU's perspective, Meteor Lake is similar to Alder Lake. Both are
hybrid platforms, with e-core and p-core.

The key differences include:
- The e-core supports 2 PDIST GP counters (GP0 & GP1)
- New MSRs for the Module Snoop Response Events on the e-core.
- New Data Source fields are introduced for the e-core.
- There are 8 GP counters for the e-core.
- The load latency AUX event is not required for the p-core anymore.
- Retire Latency (Support in a separate patch) for both cores.

Since most of the code in the intel_pmu_init() should be the same as
Alder Lake, to avoid code duplication, share the path with Alder Lake.

Add new specific functions of extra_regs, and get_event_constraints
to support the OCR events, Module Snoop Response Events and 2 PDIST
GP counters on e-core.

Add new MTL specific mem_attrs which drops the load latency AUX event.

The Data Source field is extended to 4:0, which can contains max 32
sources.

The Retire Latency is implemented with a separate patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c     | 141 +++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c       |  70 ++++++++++++---
 arch/x86/events/perf_event.h     |  21 ++--
 arch/x86/include/asm/msr-index.h |   3 +-
 4 files changed, 203 insertions(+), 32 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dfd2c12..d2030be 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2119,6 +2119,16 @@ static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
+	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff3ffffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0xff3ffffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
+	INTEL_UEVENT_EXTRA_REG(0x0127, MSR_SNOOP_RSP_0, 0xffffffffffffffffull, SNOOP_0),
+	INTEL_UEVENT_EXTRA_REG(0x0227, MSR_SNOOP_RSP_1, 0xffffffffffffffffull, SNOOP_1),
+	EVENT_EXTRA_END
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -4182,6 +4192,12 @@ static int hsw_hw_config(struct perf_event *event)
 static struct event_constraint counter0_constraint =
 			INTEL_ALL_EVENT_CONSTRAINT(0, 0x1);
 
+static struct event_constraint counter1_constraint =
+			INTEL_ALL_EVENT_CONSTRAINT(0, 0x2);
+
+static struct event_constraint counter0_1_constraint =
+			INTEL_ALL_EVENT_CONSTRAINT(0, 0x3);
+
 static struct event_constraint counter2_constraint =
 			EVENT_CONSTRAINT(0, 0x4, 0);
 
@@ -4191,6 +4207,9 @@ static struct event_constraint fixed0_constraint =
 static struct event_constraint fixed0_counter0_constraint =
 			INTEL_ALL_EVENT_CONSTRAINT(0, 0x100000001ULL);
 
+static struct event_constraint fixed0_counter0_1_constraint =
+			INTEL_ALL_EVENT_CONSTRAINT(0, 0x100000003ULL);
+
 static struct event_constraint *
 hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -4322,6 +4341,54 @@ adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return &emptyconstraint;
 }
 
+static struct event_constraint *
+cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	c = intel_get_event_constraints(cpuc, idx, event);
+
+	/*
+	 * The :ppp indicates the Precise Distribution (PDist) facility, which
+	 * is only supported on the GP counter 0 & 1 and Fixed counter 0.
+	 * If a :ppp event which is not available on the above eligible counters,
+	 * error out.
+	 */
+	if (event->attr.precise_ip == 3) {
+		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
+		if (constraint_match(&fixed0_constraint, event->hw.config))
+			return &fixed0_counter0_1_constraint;
+
+		switch (c->idxmsk64 & 0x3ull) {
+		case 0x1:
+			return &counter0_constraint;
+		case 0x2:
+			return &counter1_constraint;
+		case 0x3:
+			return &counter0_1_constraint;
+		}
+		return &emptyconstraint;
+	}
+
+	return c;
+}
+
+static struct event_constraint *
+mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type == hybrid_big)
+		return spr_get_event_constraints(cpuc, idx, event);
+	if (pmu->cpu_type == hybrid_small)
+		return cmt_get_event_constraints(cpuc, idx, event);
+
+	WARN_ON(1);
+	return &emptyconstraint;
+}
+
 static int adl_hw_config(struct perf_event *event)
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
@@ -5463,6 +5530,12 @@ static struct attribute *adl_hybrid_mem_attrs[] = {
 	NULL,
 };
 
+static struct attribute *mtl_hybrid_mem_attrs[] = {
+	EVENT_PTR(mem_ld_adl),
+	EVENT_PTR(mem_st_adl),
+	NULL
+};
+
 EVENT_ATTR_STR_HYBRID(tx-start,          tx_start_adl,          "event=0xc9,umask=0x1",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-commit,         tx_commit_adl,         "event=0xc9,umask=0x2",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-abort,          tx_abort_adl,          "event=0xc9,umask=0x4",          hybrid_big);
@@ -5490,20 +5563,40 @@ FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small);
 FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small);
 FORMAT_ATTR_HYBRID(frontend,    hybrid_big);
 
+#define ADL_HYBRID_RTM_FORMAT_ATTR	\
+	FORMAT_HYBRID_PTR(in_tx),	\
+	FORMAT_HYBRID_PTR(in_tx_cp)
+
+#define ADL_HYBRID_FORMAT_ATTR		\
+	FORMAT_HYBRID_PTR(offcore_rsp),	\
+	FORMAT_HYBRID_PTR(ldlat),	\
+	FORMAT_HYBRID_PTR(frontend)
+
 static struct attribute *adl_hybrid_extra_attr_rtm[] = {
-	FORMAT_HYBRID_PTR(in_tx),
-	FORMAT_HYBRID_PTR(in_tx_cp),
-	FORMAT_HYBRID_PTR(offcore_rsp),
-	FORMAT_HYBRID_PTR(ldlat),
-	FORMAT_HYBRID_PTR(frontend),
-	NULL,
+	ADL_HYBRID_RTM_FORMAT_ATTR,
+	ADL_HYBRID_FORMAT_ATTR,
+	NULL
 };
 
 static struct attribute *adl_hybrid_extra_attr[] = {
-	FORMAT_HYBRID_PTR(offcore_rsp),
-	FORMAT_HYBRID_PTR(ldlat),
-	FORMAT_HYBRID_PTR(frontend),
-	NULL,
+	ADL_HYBRID_FORMAT_ATTR,
+	NULL
+};
+
+PMU_FORMAT_ATTR_SHOW(snoop_rsp, "config1:0-63");
+FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small);
+
+static struct attribute *mtl_hybrid_extra_attr_rtm[] = {
+	ADL_HYBRID_RTM_FORMAT_ATTR,
+	ADL_HYBRID_FORMAT_ATTR,
+	FORMAT_HYBRID_PTR(snoop_rsp),
+	NULL
+};
+
+static struct attribute *mtl_hybrid_extra_attr[] = {
+	ADL_HYBRID_FORMAT_ATTR,
+	FORMAT_HYBRID_PTR(snoop_rsp),
+	NULL
 };
 
 static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
@@ -5725,6 +5818,12 @@ static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
 	}
 }
 
+static __always_inline bool is_mtl(u8 x86_model)
+{
+	return (x86_model == INTEL_FAM6_METEORLAKE) ||
+	       (x86_model == INTEL_FAM6_METEORLAKE_L);
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6381,6 +6480,8 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
@@ -6400,9 +6501,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_adl();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
 		static_call_update(intel_pmu_update_topdown_event,
@@ -6489,8 +6588,22 @@ __init int intel_pmu_init(void)
 		pmu->event_constraints = intel_slm_event_constraints;
 		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
 		pmu->extra_regs = intel_grt_extra_regs;
-		pr_cont("Alderlake Hybrid events, ");
-		name = "alderlake_hybrid";
+		if (is_mtl(boot_cpu_data.x86_model)) {
+			x86_pmu.pebs_latency_data = mtl_latency_data_small;
+			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+			mem_attr = mtl_hybrid_mem_attrs;
+			intel_pmu_pebs_data_source_mtl();
+			x86_pmu.get_event_constraints = mtl_get_event_constraints;
+			pmu->extra_regs = intel_cmt_extra_regs;
+			pr_cont("Meteorlake Hybrid events, ");
+			name = "meteorlake_hybrid";
+		} else {
+			x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+			intel_pmu_pebs_data_source_adl();
+			pr_cont("Alderlake Hybrid events, ");
+			name = "alderlake_hybrid";
+		}
 		break;
 
 	default:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 88e58b6..e991c54 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -53,6 +53,13 @@ union intel_x86_pebs_dse {
 		unsigned int st_lat_locked:1;
 		unsigned int ld_reserved3:26;
 	};
+	struct {
+		unsigned int mtl_dse:5;
+		unsigned int mtl_locked:1;
+		unsigned int mtl_stlb_miss:1;
+		unsigned int mtl_fwd_blk:1;
+		unsigned int ld_reserved4:24;
+	};
 };
 
 
@@ -135,6 +142,29 @@ void __init intel_pmu_pebs_data_source_adl(void)
 	__intel_pmu_pebs_data_source_grt(data_source);
 }
 
+static void __init intel_pmu_pebs_data_source_cmt(u64 *data_source)
+{
+	data_source[0x07] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
+	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+	data_source[0x0a] = OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE);
+	data_source[0x0b] = OP_LH | LEVEL(RAM) | REM | P(SNOOP, NONE);
+	data_source[0x0c] = OP_LH | LEVEL(RAM) | REM | P(SNOOPX, FWD);
+	data_source[0x0d] = OP_LH | LEVEL(RAM) | REM | P(SNOOP, HITM);
+}
+
+void __init intel_pmu_pebs_data_source_mtl(void)
+{
+	u64 *data_source;
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_skl(false, data_source);
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	intel_pmu_pebs_data_source_cmt(data_source);
+}
+
 static u64 precise_store_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -219,24 +249,19 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 }
 
 /* Retrieve the latency data for e-core of ADL */
-u64 adl_latency_data_small(struct perf_event *event, u64 status)
+static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
+				     u8 dse, bool tlb, bool lock, bool blk)
 {
-	union intel_x86_pebs_dse dse;
 	u64 val;
 
 	WARN_ON_ONCE(hybrid_pmu(event->pmu)->cpu_type == hybrid_big);
 
-	dse.val = status;
-
-	val = hybrid_var(event->pmu, pebs_data_source)[dse.ld_dse];
+	dse &= PERF_PEBS_DATA_SOURCE_MASK;
+	val = hybrid_var(event->pmu, pebs_data_source)[dse];
 
-	/*
-	 * For the atom core on ADL,
-	 * bit 4: lock, bit 5: TLB access.
-	 */
-	pebs_set_tlb_lock(&val, dse.ld_locked, dse.ld_stlb_miss);
+	pebs_set_tlb_lock(&val, tlb, lock);
 
-	if (dse.ld_data_blk)
+	if (blk)
 		val |= P(BLK, DATA);
 	else
 		val |= P(BLK, NA);
@@ -244,6 +269,29 @@ u64 adl_latency_data_small(struct perf_event *event, u64 status)
 	return val;
 }
 
+u64 adl_latency_data_small(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+
+	dse.val = status;
+
+	return __adl_latency_data_small(event, status, dse.ld_dse,
+					dse.ld_locked, dse.ld_stlb_miss,
+					dse.ld_data_blk);
+}
+
+/* Retrieve the latency data for e-core of MTL */
+u64 mtl_latency_data_small(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+
+	dse.val = status;
+
+	return __adl_latency_data_small(event, status, dse.mtl_dse,
+					dse.mtl_stlb_miss, dse.mtl_locked,
+					dse.mtl_fwd_blk);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0e849f2..1ac9d9e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -35,15 +35,17 @@
  * per-core reg tables.
  */
 enum extra_reg_type {
-	EXTRA_REG_NONE  = -1,	/* not used */
+	EXTRA_REG_NONE		= -1, /* not used */
 
-	EXTRA_REG_RSP_0 = 0,	/* offcore_response_0 */
-	EXTRA_REG_RSP_1 = 1,	/* offcore_response_1 */
-	EXTRA_REG_LBR   = 2,	/* lbr_select */
-	EXTRA_REG_LDLAT = 3,	/* ld_lat_threshold */
-	EXTRA_REG_FE    = 4,    /* fe_* */
+	EXTRA_REG_RSP_0		= 0,  /* offcore_response_0 */
+	EXTRA_REG_RSP_1		= 1,  /* offcore_response_1 */
+	EXTRA_REG_LBR		= 2,  /* lbr_select */
+	EXTRA_REG_LDLAT		= 3,  /* ld_lat_threshold */
+	EXTRA_REG_FE		= 4,  /* fe_* */
+	EXTRA_REG_SNOOP_0	= 5,  /* snoop response 0 */
+	EXTRA_REG_SNOOP_1	= 6,  /* snoop response 1 */
 
-	EXTRA_REG_MAX		/* number of entries needed */
+	EXTRA_REG_MAX		      /* number of entries needed */
 };
 
 struct event_constraint {
@@ -647,6 +649,7 @@ enum {
 };
 
 #define PERF_PEBS_DATA_SOURCE_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_MASK	(PERF_PEBS_DATA_SOURCE_MAX - 1)
 
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
@@ -1486,6 +1489,8 @@ int intel_pmu_drain_bts_buffer(void);
 
 u64 adl_latency_data_small(struct perf_event *event, u64 status);
 
+u64 mtl_latency_data_small(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1597,6 +1602,8 @@ void intel_pmu_pebs_data_source_adl(void);
 
 void intel_pmu_pebs_data_source_grt(void);
 
+void intel_pmu_pebs_data_source_mtl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff475..d55cc1d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -189,6 +189,9 @@
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
+#define MSR_SNOOP_RSP_0			0x00001328
+#define MSR_SNOOP_RSP_1			0x00001329
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 
