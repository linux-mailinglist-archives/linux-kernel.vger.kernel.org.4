Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718E646AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiLHIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLHIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:45:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E73966C8E;
        Thu,  8 Dec 2022 00:45:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F58523A;
        Thu,  8 Dec 2022 00:45:07 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.40.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623803F73D;
        Thu,  8 Dec 2022 00:44:55 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V6 6/7] arm64/perf: Enable branch stack events via FEAT_BRBE
Date:   Thu,  8 Dec 2022 14:14:01 +0530
Message-Id: <20221208084402.863310-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208084402.863310-1-anshuman.khandual@arm.com>
References: <20221208084402.863310-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables branch stack sampling events in ARMV8 PMU, via an architecture
feature FEAT_BRBE aka branch record buffer extension. This defines required
branch helper functions pmuv8pmu_branch_XXXXX() and the implementation here
is wrapped with a new config option CONFIG_ARM64_BRBE.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig                  |  11 +
 arch/arm64/include/asm/perf_event.h |   9 +
 arch/arm64/kernel/Makefile          |   1 +
 arch/arm64/kernel/brbe.c            | 454 ++++++++++++++++++++++++++++
 arch/arm64/kernel/brbe.h            | 266 ++++++++++++++++
 5 files changed, 741 insertions(+)
 create mode 100644 arch/arm64/kernel/brbe.c
 create mode 100644 arch/arm64/kernel/brbe.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 505c8a1ccbe0..6869fa5ef3e8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1355,6 +1355,17 @@ config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
 
+config ARM64_BRBE
+	bool "Enable support for Branch Record Buffer Extension (BRBE)"
+	depends on PERF_EVENTS && ARM64 && ARM_PMU
+	default y
+	help
+	  Enable perf support for Branch Record Buffer Extension (BRBE) which
+	  records all branches taken in an execution path. This supports some
+	  branch types and privilege based filtering. It captured additional
+	  relevant information such as cycle count, misprediction and branch
+	  type, branch privilege level etc.
+
 # Supported by clang >= 7.0 or GCC >= 12.0.0
 config CC_HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 3be9b7a987e9..a87ab55cb253 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -277,6 +277,14 @@ struct pmu_hw_events;
 struct arm_pmu;
 struct perf_event;
 
+#ifdef CONFIG_ARM64_BRBE
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event);
+bool armv8pmu_branch_valid(struct perf_event *event);
+void armv8pmu_branch_enable(struct perf_event *event);
+void armv8pmu_branch_disable(struct perf_event *event);
+void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
+void armv8pmu_branch_reset(void);
+#else
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
 static inline bool armv8pmu_branch_valid(struct perf_event *event) {return false; }
 static inline void armv8pmu_branch_enable(struct perf_event *event) { }
@@ -284,3 +292,4 @@ static inline void armv8pmu_branch_disable(struct perf_event *event) { }
 static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
 #endif
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2f361a883d8c..561151a78082 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_ARM64_BRBE)		+= brbe.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm64/kernel/brbe.c b/arch/arm64/kernel/brbe.c
new file mode 100644
index 000000000000..b8e4f9263630
--- /dev/null
+++ b/arch/arm64/kernel/brbe.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "brbe.h"
+
+#define BRBFCR_BRANCH_ALL	(BRBFCR_EL1_DIRECT | BRBFCR_EL1_INDIRECT | \
+				 BRBFCR_EL1_RTN | BRBFCR_EL1_INDCALL | \
+				 BRBFCR_EL1_DIRCALL | BRBFCR_EL1_CONDDIR)
+
+#define BRBE_FCR_MASK (BRBFCR_BRANCH_ALL)
+#define BRBE_CR_MASK  (BRBCR_EL1_EXCEPTION | BRBCR_EL1_ERTN | BRBCR_EL1_CC | \
+		       BRBCR_EL1_MPRED | BRBCR_EL1_E1BRE | BRBCR_EL1_E0BRE)
+
+bool armv8pmu_branch_valid(struct perf_event *event)
+{
+	/*
+	 * If the event does not have at least one of the privilege
+	 * branch filters as in PERF_SAMPLE_BRANCH_PLM_ALL, the core
+	 * perf will adjust its value based on perf event's existing
+	 * privilege level via attr.exclude_[user|kernel|hv].
+	 *
+	 * As event->attr.branch_sample_type might have been changed
+	 * when the event reaches here, it is not possible to figure
+	 * out whether the event originally had HV privilege request
+	 * or got added via the core perf. Just report this situation
+	 * once and continue ignoring if there are other instances.
+	 */
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HV)
+		pr_warn_once("branch filter not supported - hypervisor privilege\n");
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_ABORT_TX) {
+		pr_warn_once("branch filter not supported - aborted transaction\n");
+		return false;
+	}
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_TX) {
+		pr_warn_once("branch filter not supported - no transaction\n");
+		return false;
+	}
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_IN_TX) {
+		pr_warn_once("branch filter not supported - in transaction\n");
+		return false;
+	}
+	return true;
+}
+
+static void branch_records_alloc(struct arm_pmu *armpmu)
+{
+	struct pmu_hw_events *events;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		events = per_cpu_ptr(armpmu->hw_events, cpu);
+
+		events->branches = kmalloc(sizeof(struct branch_records), GFP_KERNEL);
+		WARN_ON(!events->branches);
+	}
+}
+
+void armv8pmu_branch_probe(struct arm_pmu *armpmu)
+{
+	struct brbe_hw_attr *brbe_attr;
+	u64 aa64dfr0, brbidr;
+	unsigned int brbe;
+
+	brbe_attr = kmalloc(sizeof(struct brbe_hw_attr), GFP_KERNEL);
+	armpmu->hw_attr = brbe_attr;
+	WARN_ON(!brbe_attr);
+
+	aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
+	if (!brbe)
+		return;
+
+	if (brbe == ID_AA64DFR0_EL1_BRBE_IMP)
+		brbe_attr->brbe_v1p1 = false;
+
+	if (brbe == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1)
+		brbe_attr->brbe_v1p1 = true;
+
+	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
+	brbe_attr->brbe_format = brbe_fetch_format(brbidr);
+	if (brbe_attr->brbe_format != BRBIDR0_EL1_FORMAT_0)
+		return;
+
+	brbe_attr->brbe_cc = brbe_fetch_cc_bits(brbidr);
+	if (brbe_attr->brbe_cc != BRBIDR0_EL1_CC_20_BIT)
+		return;
+
+	brbe_attr->brbe_nr = brbe_fetch_numrec(brbidr);
+	if (!valid_brbe_nr(brbe_attr->brbe_nr))
+		return;
+
+	branch_records_alloc(armpmu);
+	armpmu->features |= ARM_PMU_BRANCH_STACK;
+}
+
+static u64 branch_type_to_brbfcr(int branch_type)
+{
+	u64 brbfcr = 0;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		brbfcr |= BRBFCR_BRANCH_ALL;
+		return brbfcr;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		brbfcr |= (BRBFCR_EL1_INDCALL | BRBFCR_EL1_DIRCALL);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		brbfcr |= BRBFCR_EL1_RTN;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		brbfcr |= BRBFCR_EL1_INDCALL;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_COND)
+		brbfcr |= BRBFCR_EL1_CONDDIR;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+		brbfcr |= BRBFCR_EL1_INDIRECT;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL)
+		brbfcr |= BRBFCR_EL1_DIRCALL;
+
+	return brbfcr;
+}
+
+static u64 branch_type_to_brbcr(int branch_type)
+{
+	u64 brbcr = (BRBCR_EL1_CC | BRBCR_EL1_MPRED);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_USER)
+		brbcr |= BRBCR_EL1_E0BRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
+		brbcr |= BRBCR_EL1_E1BRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES)
+		brbcr &= ~BRBCR_EL1_CC;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS)
+		brbcr &= ~BRBCR_EL1_MPRED;
+
+	/*
+	 * The exception and exception return branches could be
+	 * captured, irrespective of the perf event's privilege.
+	 * If the perf event does not have enough privilege for
+	 * a given exception level, then addresses which falls
+	 * under that exception level will be reported as zero
+	 * for the captured branch record, creating source only
+	 * or target only records.
+	 */
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		brbcr |= BRBCR_EL1_EXCEPTION;
+		brbcr |= BRBCR_EL1_ERTN;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		brbcr |= BRBCR_EL1_EXCEPTION;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		brbcr |= BRBCR_EL1_ERTN;
+
+	return brbcr;
+}
+
+void armv8pmu_branch_enable(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+	u64 brbfcr, brbcr;
+
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_BANK_MASK;
+	brbfcr &= ~(BRBFCR_EL1_EnI | BRBFCR_EL1_PAUSED | BRBE_FCR_MASK);
+	brbfcr |= (branch_type_to_brbfcr(branch_type) & BRBE_FCR_MASK);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~BRBE_CR_MASK;
+	brbcr |= BRBCR_EL1_FZP;
+	brbcr |= (BRBCR_EL1_TS_PHYSICAL << BRBCR_EL1_TS_SHIFT);
+	brbcr |= (branch_type_to_brbcr(branch_type) & BRBE_CR_MASK);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+	armv8pmu_branch_reset();
+}
+
+void armv8pmu_branch_disable(struct perf_event *event)
+{
+	u64 brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+
+	brbcr &= ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+}
+
+static int brbe_fetch_perf_type(u64 brbinf, bool *new_branch_type)
+{
+	int brbe_type = brbe_fetch_type(brbinf);
+	*new_branch_type = false;
+
+	switch (brbe_type) {
+	case BRBINF_EL1_TYPE_UNCOND_DIR:
+		return PERF_BR_UNCOND;
+	case BRBINF_EL1_TYPE_INDIR:
+		return PERF_BR_IND;
+	case BRBINF_EL1_TYPE_DIR_LINK:
+		return PERF_BR_CALL;
+	case BRBINF_EL1_TYPE_INDIR_LINK:
+		return PERF_BR_IND_CALL;
+	case BRBINF_EL1_TYPE_RET_SUB:
+		return PERF_BR_RET;
+	case BRBINF_EL1_TYPE_COND_DIR:
+		return PERF_BR_COND;
+	case BRBINF_EL1_TYPE_CALL:
+		return PERF_BR_CALL;
+	case BRBINF_EL1_TYPE_TRAP:
+		return PERF_BR_SYSCALL;
+	case BRBINF_EL1_TYPE_RET_EXCPT:
+		return PERF_BR_ERET;
+	case BRBINF_EL1_TYPE_IRQ:
+		return PERF_BR_IRQ;
+	case BRBINF_EL1_TYPE_DEBUG_HALT:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_HALT;
+	case BRBINF_EL1_TYPE_SERROR:
+		return PERF_BR_SERROR;
+	case BRBINF_EL1_TYPE_INST_DEBUG:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_INST;
+	case BRBINF_EL1_TYPE_DATA_DEBUG:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_DATA;
+	case BRBINF_EL1_TYPE_ALGN_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_ALGN;
+	case BRBINF_EL1_TYPE_INST_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_INST;
+	case BRBINF_EL1_TYPE_DATA_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_DATA;
+	case BRBINF_EL1_TYPE_FIQ:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_FIQ;
+	case BRBINF_EL1_TYPE_DEBUG_EXIT:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_EXIT;
+	default:
+		pr_warn("unknown branch type captured\n");
+		return PERF_BR_UNKNOWN;
+	}
+}
+
+static int brbe_fetch_perf_priv(u64 brbinf)
+{
+	int brbe_el = brbe_fetch_el(brbinf);
+
+	switch (brbe_el) {
+	case BRBINF_EL1_EL_EL0:
+		return PERF_BR_PRIV_USER;
+	case BRBINF_EL1_EL_EL1:
+		return PERF_BR_PRIV_KERNEL;
+	case BRBINF_EL1_EL_EL2:
+		if (is_kernel_in_hyp_mode())
+			return PERF_BR_PRIV_KERNEL;
+		return PERF_BR_PRIV_HV;
+	default:
+		pr_warn("unknown branch privilege captured\n");
+		return PERF_BR_PRIV_UNKNOWN;
+	}
+}
+
+static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
+			       u64 brbinf, int idx)
+{
+	int branch_type, type = brbe_record_valid(brbinf);
+	bool new_branch_type;
+
+	if (!branch_sample_no_cycles(event))
+		cpuc->branches->branch_entries[idx].cycles = brbe_fetch_cycles(brbinf);
+
+	if (branch_sample_type(event)) {
+		branch_type = brbe_fetch_perf_type(brbinf, &new_branch_type);
+		if (new_branch_type) {
+			cpuc->branches->branch_entries[idx].type = PERF_BR_EXTEND_ABI;
+			cpuc->branches->branch_entries[idx].new_type = branch_type;
+		} else {
+			cpuc->branches->branch_entries[idx].type = branch_type;
+		}
+	}
+
+	if (!branch_sample_no_flags(event)) {
+		/*
+		 * BRBINF_LASTFAILED does not indicate that the last transaction
+		 * got failed or aborted during the current branch record itself.
+		 * Rather, this indicates that all the branch records which were
+		 * in transaction until the curret branch record have failed. So
+		 * the entire BRBE buffer needs to be processed later on to find
+		 * all branch records which might have failed.
+		 */
+		cpuc->branches->branch_entries[idx].abort = brbinf & BRBINF_EL1_LASTFAILED;
+
+		/*
+		 * All these information (i.e transaction state and mispredicts)
+		 * are not available for target only branch records.
+		 */
+		if (type != BRBINF_EL1_VALID_TARGET) {
+			cpuc->branches->branch_entries[idx].mispred = brbinf & BRBINF_EL1_MPRED;
+			cpuc->branches->branch_entries[idx].predicted = !(brbinf & BRBINF_EL1_MPRED);
+			cpuc->branches->branch_entries[idx].in_tx = brbinf & BRBINF_EL1_T;
+		}
+	}
+
+	if (branch_sample_priv(event)) {
+		/*
+		 * All these information (i.e branch privilege level) are not
+		 * available for source only branch records.
+		 */
+		if (type != BRBINF_EL1_VALID_SOURCE)
+			cpuc->branches->branch_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
+	}
+}
+
+/*
+ * A branch record with BRBINF_EL1.LASTFAILED set, implies that all
+ * preceding consecutive branch records, that were in a transaction
+ * (i.e their BRBINF_EL1.TX set) have been aborted.
+ *
+ * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
+ * consecutive branch records upto the last record, which were in a
+ * transaction (i.e their BRBINF_EL1.TX set) have been aborted.
+ *
+ * --------------------------------- -------------------
+ * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
+ * --------------------------------- -------------------
+ * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ *
+ * BRBFCR_EL1.LASTFAILED == 1
+ *
+ * Here BRBFCR_EL1.LASTFAILED failes all those consecutive and also
+ * in transaction branches near the end of the BRBE buffer.
+ */
+static void process_branch_aborts(struct pmu_hw_events *cpuc)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *) cpuc->percpu_pmu->hw_attr;
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	bool lastfailed = !!(brbfcr & BRBFCR_EL1_LASTFAILED);
+	int idx = brbe_attr->brbe_nr - 1;
+
+	do {
+		if (cpuc->branches->branch_entries[idx].in_tx) {
+			cpuc->branches->branch_entries[idx].abort = lastfailed;
+		} else {
+			lastfailed = cpuc->branches->branch_entries[idx].abort;
+			cpuc->branches->branch_entries[idx].abort = false;
+		}
+	} while (idx--, idx >= 0);
+}
+
+void armv8pmu_branch_reset(void)
+{
+	asm volatile(BRB_IALL);
+	isb();
+}
+
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *) cpuc->percpu_pmu->hw_attr;
+	u64 brbinf, brbfcr, brbcr, saved_priv;
+	int idx;
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	/* Ensure pause on PMU interrupt is enabled */
+	WARN_ON_ONCE(~brbcr & BRBCR_EL1_FZP);
+
+	/* Save and clear the privilege */
+	saved_priv =  brbcr & (BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE);
+	brbcr &= ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE);
+
+	/* Pause the buffer */
+	brbfcr |= BRBFCR_EL1_PAUSED;
+
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	for (idx = 0; idx < brbe_attr->brbe_nr; idx++) {
+		select_brbe_bank_index(idx);
+		brbinf = get_brbinf_reg(idx);
+		/*
+		 * There are no valid entries anymore on the buffer.
+		 * Abort the branch record processing to save some
+		 * cycles and also reduce the capture/process load
+		 * for the user space as well.
+		 */
+		if (brbe_invalid(brbinf))
+			break;
+
+		perf_clear_branch_entry_bitfields(&cpuc->branches->branch_entries[idx]);
+		if (brbe_valid(brbinf)) {
+			cpuc->branches->branch_entries[idx].from =  get_brbsrc_reg(idx);
+			cpuc->branches->branch_entries[idx].to =  get_brbtgt_reg(idx);
+		} else if (brbe_source(brbinf)) {
+			cpuc->branches->branch_entries[idx].from =  get_brbsrc_reg(idx);
+			cpuc->branches->branch_entries[idx].to = 0;
+		} else if (brbe_target(brbinf)) {
+			cpuc->branches->branch_entries[idx].from = 0;
+			cpuc->branches->branch_entries[idx].to =  get_brbtgt_reg(idx);
+		}
+		capture_brbe_flags(cpuc, event, brbinf, idx);
+	}
+	cpuc->branches->branch_stack.nr = idx;
+	cpuc->branches->branch_stack.hw_idx = -1ULL;
+	process_branch_aborts(cpuc);
+
+	/* Restore privilege, enable pause on PMU interrupt */
+	brbcr |= saved_priv;
+	brbcr |= BRBCR_EL1_FZP;
+
+	/* Unpause the buffer */
+	brbfcr &= ~BRBFCR_EL1_PAUSED;
+
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+	armv8pmu_branch_reset();
+}
diff --git a/arch/arm64/kernel/brbe.h b/arch/arm64/kernel/brbe.h
new file mode 100644
index 000000000000..b265e6bf3d23
--- /dev/null
+++ b/arch/arm64/kernel/brbe.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Branch Record Buffer Extension Helpers.
+ *
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define pr_fmt(fmt) "brbe: " fmt
+
+#include <linux/perf/arm_pmu.h>
+
+struct brbe_hw_attr {
+	bool	brbe_v1p1;
+	int	brbe_cc;
+	int	brbe_nr;
+	int	brbe_format;
+};
+
+/*
+ * BRBE Instructions
+ *
+ * BRB_IALL : Invalidate the entire buffer
+ * BRB_INJ  : Inject latest branch record derived from [BRBSRCINJ, BRBTGTINJ, BRBINFINJ]
+ */
+#define BRB_IALL __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 4) | (0x1f))
+#define BRB_INJ  __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 5) | (0x1f))
+
+/*
+ * BRBE Buffer Organization
+ *
+ * BRBE buffer is arranged as multiple banks of 32 branch record
+ * entries each. An indivdial branch record in a given bank could
+ * be accessedi, after selecting the bank in BRBFCR_EL1.BANK and
+ * accessing the registers i.e [BRBSRC, BRBTGT, BRBINF] set with
+ * indices [0..31].
+ *
+ * Bank 0
+ *
+ *	---------------------------------	------
+ *	| 00 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 01 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 31 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ *
+ * Bank 1
+ *
+ *	---------------------------------	------
+ *	| 32 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 33 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 63 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ */
+#define BRBE_BANK0_IDX_MIN 0
+#define BRBE_BANK0_IDX_MAX 31
+#define BRBE_BANK1_IDX_MIN 32
+#define BRBE_BANK1_IDX_MAX 63
+
+#define RETURN_READ_BRBSRCN(n) \
+	read_sysreg_s(SYS_BRBSRC##n##_EL1)
+
+#define RETURN_READ_BRBTGTN(n) \
+	read_sysreg_s(SYS_BRBTGT##n##_EL1)
+
+#define RETURN_READ_BRBINFN(n) \
+	read_sysreg_s(SYS_BRBINF##n##_EL1)
+
+#define BRBE_REGN_CASE(n, case_macro) \
+	case n: return case_macro(n); break
+
+#define BRBE_REGN_SWITCH(x, case_macro)				\
+	do {							\
+		switch (x) {					\
+		BRBE_REGN_CASE(0, case_macro);			\
+		BRBE_REGN_CASE(1, case_macro);			\
+		BRBE_REGN_CASE(2, case_macro);			\
+		BRBE_REGN_CASE(3, case_macro);			\
+		BRBE_REGN_CASE(4, case_macro);			\
+		BRBE_REGN_CASE(5, case_macro);			\
+		BRBE_REGN_CASE(6, case_macro);			\
+		BRBE_REGN_CASE(7, case_macro);			\
+		BRBE_REGN_CASE(8, case_macro);			\
+		BRBE_REGN_CASE(9, case_macro);			\
+		BRBE_REGN_CASE(10, case_macro);			\
+		BRBE_REGN_CASE(11, case_macro);			\
+		BRBE_REGN_CASE(12, case_macro);			\
+		BRBE_REGN_CASE(13, case_macro);			\
+		BRBE_REGN_CASE(14, case_macro);			\
+		BRBE_REGN_CASE(15, case_macro);			\
+		BRBE_REGN_CASE(16, case_macro);			\
+		BRBE_REGN_CASE(17, case_macro);			\
+		BRBE_REGN_CASE(18, case_macro);			\
+		BRBE_REGN_CASE(19, case_macro);			\
+		BRBE_REGN_CASE(20, case_macro);			\
+		BRBE_REGN_CASE(21, case_macro);			\
+		BRBE_REGN_CASE(22, case_macro);			\
+		BRBE_REGN_CASE(23, case_macro);			\
+		BRBE_REGN_CASE(24, case_macro);			\
+		BRBE_REGN_CASE(25, case_macro);			\
+		BRBE_REGN_CASE(26, case_macro);			\
+		BRBE_REGN_CASE(27, case_macro);			\
+		BRBE_REGN_CASE(28, case_macro);			\
+		BRBE_REGN_CASE(29, case_macro);			\
+		BRBE_REGN_CASE(30, case_macro);			\
+		BRBE_REGN_CASE(31, case_macro);			\
+		default:					\
+			pr_warn("unknown register index\n");	\
+			return -1;				\
+		}						\
+	} while (0)
+
+static inline int buffer_to_brbe_idx(int buffer_idx)
+{
+	return buffer_idx % 32;
+}
+
+static inline u64 get_brbsrc_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBSRCN);
+}
+
+static inline u64 get_brbtgt_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBTGTN);
+}
+
+static inline u64 get_brbinf_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBINFN);
+}
+
+static inline u64 brbe_record_valid(u64 brbinf)
+{
+	return (brbinf & BRBINF_EL1_VALID_MASK) >> BRBINF_EL1_VALID_SHIFT;
+}
+
+static inline bool brbe_invalid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_NONE;
+}
+
+static inline bool brbe_valid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_FULL;
+}
+
+static inline bool brbe_source(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_SOURCE;
+}
+
+static inline bool brbe_target(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_TARGET;
+}
+
+static inline int brbe_fetch_cycles(u64 brbinf)
+{
+	/*
+	 * Captured cycle count is unknown and hence
+	 * should not be passed on the user space.
+	 */
+	if (brbinf & BRBINF_EL1_CCU)
+		return 0;
+
+	return (brbinf & BRBINF_EL1_CC_MASK) >> BRBINF_EL1_CC_SHIFT;
+}
+
+static inline int brbe_fetch_type(u64 brbinf)
+{
+	return (brbinf & BRBINF_EL1_TYPE_MASK) >> BRBINF_EL1_TYPE_SHIFT;
+}
+
+static inline int brbe_fetch_el(u64 brbinf)
+{
+	return (brbinf & BRBINF_EL1_EL_MASK) >> BRBINF_EL1_EL_SHIFT;
+}
+
+static inline int brbe_fetch_numrec(u64 brbidr)
+{
+	return (brbidr & BRBIDR0_EL1_NUMREC_MASK) >> BRBIDR0_EL1_NUMREC_SHIFT;
+}
+
+static inline int brbe_fetch_format(u64 brbidr)
+{
+	return (brbidr & BRBIDR0_EL1_FORMAT_MASK) >> BRBIDR0_EL1_FORMAT_SHIFT;
+}
+
+static inline int brbe_fetch_cc_bits(u64 brbidr)
+{
+	return (brbidr & BRBIDR0_EL1_CC_MASK) >> BRBIDR0_EL1_CC_SHIFT;
+}
+
+static inline void select_brbe_bank(int bank)
+{
+	static int brbe_current_bank = -1;
+	u64 brbfcr;
+
+	if (brbe_current_bank == bank)
+		return;
+
+	WARN_ON(bank > 1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_BANK_MASK;
+	brbfcr |= ((bank << BRBFCR_EL1_BANK_SHIFT) & BRBFCR_EL1_BANK_MASK);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+	brbe_current_bank = bank;
+}
+
+static inline void select_brbe_bank_index(int buffer_idx)
+{
+	switch (buffer_idx) {
+	case BRBE_BANK0_IDX_MIN ... BRBE_BANK0_IDX_MAX:
+		select_brbe_bank(0);
+		break;
+	case BRBE_BANK1_IDX_MIN ... BRBE_BANK1_IDX_MAX:
+		select_brbe_bank(1);
+		break;
+	default:
+		pr_warn("unsupported BRBE index\n");
+	}
+}
+
+static inline bool valid_brbe_nr(int brbe_nr)
+{
+	switch (brbe_nr) {
+	case BRBIDR0_EL1_NUMREC_8:
+	case BRBIDR0_EL1_NUMREC_16:
+	case BRBIDR0_EL1_NUMREC_32:
+	case BRBIDR0_EL1_NUMREC_64:
+		return true;
+	default:
+		pr_warn("unsupported BRBE entries\n");
+		return false;
+	}
+}
+
+static inline bool brbe_paused(void)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	return brbfcr & BRBFCR_EL1_PAUSED;
+}
+
+static inline void set_brbe_paused(void)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+}
-- 
2.25.1

