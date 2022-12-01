Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19D63F8A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiLAT5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLAT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE3BA602
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924637; x=1701460637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zyr6BKpBUBlQL+Bko4ULKP40A+CIBCdrhSKXQp4xYYk=;
  b=H2USqtpECECAQtwtye1H1uqzj8NXpqtSeMgykf9f6kIyTTTnNDGTl2+H
   xf/qzeQwdT0IywNeuG8/j8XTio8M5o/CpBkmSxtRSWQwVHM5mWdURNe44
   lz5RXivmJDhYM+uUa0fdwiLOsnhf3RZcYHMjxh+P5ahW0vHN8kStcL8Q6
   Mt87WPNtO2cgt7dsQlVF9RDiXG/l+u8z2CnlG/OM/h5fcj2kGk1m3sYBO
   I5riabR1mDjZ09QZkMCoWw2TAu5Cs6GbPfsA5Tgn+St5E9CGVe2n/RRuA
   OvgBjsVb5x9ARoe5FDdGPnUB8v2O0TUCitIb6fdVXus74QKhLQa/1dOZj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391857"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391857"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205042"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205042"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:15 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/9] perf/x86: Add Meteor Lake support
Date:   Thu,  1 Dec 2022 11:56:57 -0800
Message-Id: <20221201195704.2330866-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201195704.2330866-1-kan.liang@linux.intel.com>
References: <20221201195704.2330866-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, Meteor Lake is similar to Alder Lake. Both are
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

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c     | 141 ++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c       |  70 ++++++++++++---
 arch/x86/events/perf_event.h     |  21 +++--
 arch/x86/include/asm/msr-index.h |   3 +
 4 files changed, 203 insertions(+), 32 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1b92bf05fd65..50d42c848eba 100644
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
@@ -5466,6 +5533,12 @@ static struct attribute *adl_hybrid_mem_attrs[] = {
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
@@ -5493,20 +5566,40 @@ FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small);
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
@@ -5728,6 +5821,12 @@ static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
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
@@ -6384,6 +6483,8 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
@@ -6403,9 +6504,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_adl();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
 		static_call_update(intel_pmu_update_topdown_event,
@@ -6492,8 +6591,22 @@ __init int intel_pmu_init(void)
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
index 446d2833efa7..aba6ee03fe26 100644
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
index 332d2e6d8ae4..109453cc1a61 100644
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
@@ -1489,6 +1492,8 @@ int intel_pmu_drain_bts_buffer(void);
 
 u64 adl_latency_data_small(struct perf_event *event, u64 status);
 
+u64 mtl_latency_data_small(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1600,6 +1605,8 @@ void intel_pmu_pebs_data_source_adl(void);
 
 void intel_pmu_pebs_data_source_grt(void);
 
+void intel_pmu_pebs_data_source_mtl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..7c2f9b442f73 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -194,6 +194,9 @@
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
+#define MSR_SNOOP_RSP_0			0x00001328
+#define MSR_SNOOP_RSP_1			0x00001329
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 
-- 
2.35.1

