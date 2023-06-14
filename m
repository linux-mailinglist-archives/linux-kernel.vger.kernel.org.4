Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0C7174C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEaEGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjEaEFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:05:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67DC188;
        Tue, 30 May 2023 21:05:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B62A9165C;
        Tue, 30 May 2023 21:06:17 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.73.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF1763F6C4;
        Tue, 30 May 2023 21:05:26 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V11 06/10] arm64/perf: Enable branch stack events via FEAT_BRBE
Date:   Wed, 31 May 2023 09:34:24 +0530
Message-Id: <20230531040428.501523-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531040428.501523-1-anshuman.khandual@arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/perf_event.h |  11 +
 drivers/perf/Kconfig                |  11 +
 drivers/perf/Makefile               |   1 +
 drivers/perf/arm_brbe.c             | 571 ++++++++++++++++++++++++++++
 drivers/perf/arm_brbe.h             | 257 +++++++++++++
 drivers/perf/arm_pmuv3.c            |  21 +-
 6 files changed, 869 insertions(+), 3 deletions(-)
 create mode 100644 drivers/perf/arm_brbe.c
 create mode 100644 drivers/perf/arm_brbe.h

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 7548813783ba..f071d629c0cf 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -31,6 +31,16 @@ struct perf_event;
 #ifdef CONFIG_PERF_EVENTS
 static inline bool has_branch_stack(struct perf_event *event);
 
+#ifdef CONFIG_ARM64_BRBE
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event);
+bool armv8pmu_branch_valid(struct perf_event *event);
+void armv8pmu_branch_enable(struct perf_event *event);
+void armv8pmu_branch_disable(struct perf_event *event);
+void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
+void armv8pmu_branch_reset(void);
+int armv8pmu_private_alloc(struct arm_pmu *arm_pmu);
+void armv8pmu_private_free(struct arm_pmu *arm_pmu);
+#else
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
 	WARN_ON_ONCE(!has_branch_stack(event));
@@ -58,3 +68,4 @@ static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
 #endif
 #endif
+#endif
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 711f82400086..7d07aa79e5b0 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -172,6 +172,17 @@ config ARM_SPE_PMU
 	  Extension, which provides periodic sampling of operations in
 	  the CPU pipeline and reports this via the perf AUX interface.
 
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
 config ARM_DMC620_PMU
 	tristate "Enable PMU support for the ARM DMC-620 memory controller"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index dabc859540ce..29d256f2deaa 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
+obj-$(CONFIG_ARM64_BRBE) += arm_brbe.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
new file mode 100644
index 000000000000..34547ad750ad
--- /dev/null
+++ b/drivers/perf/arm_brbe.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2022 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "arm_brbe.h"
+
+static bool valid_brbe_nr(int brbe_nr)
+{
+	return brbe_nr == BRBIDR0_EL1_NUMREC_8 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_16 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_32 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_64;
+}
+
+static bool valid_brbe_cc(int brbe_cc)
+{
+	return brbe_cc == BRBIDR0_EL1_CC_20_BIT;
+}
+
+static bool valid_brbe_format(int brbe_format)
+{
+	return brbe_format == BRBIDR0_EL1_FORMAT_0;
+}
+
+static bool valid_brbe_version(int brbe_version)
+{
+	return brbe_version == ID_AA64DFR0_EL1_BRBE_IMP ||
+	       brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
+}
+
+static void select_brbe_bank(int bank)
+{
+	u64 brbfcr;
+
+	WARN_ON(bank > BRBE_BANK_IDX_1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_BANK_MASK;
+	brbfcr |= SYS_FIELD_PREP(BRBFCR_EL1, BANK, bank);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+}
+
+/*
+ * Generic perf branch filters supported on BRBE
+ *
+ * New branch filters need to be evaluated whether they could be supported on
+ * BRBE. This ensures that such branch filters would not just be accepted, to
+ * fail silently. PERF_SAMPLE_BRANCH_HV is a special case that is selectively
+ * supported only on platforms where kernel is in hyp mode.
+ */
+#define BRBE_EXCLUDE_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_ABORT_TX	| \
+				     PERF_SAMPLE_BRANCH_IN_TX		| \
+				     PERF_SAMPLE_BRANCH_NO_TX		| \
+				     PERF_SAMPLE_BRANCH_CALL_STACK)
+
+#define BRBE_ALLOWED_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_USER		| \
+				     PERF_SAMPLE_BRANCH_KERNEL		| \
+				     PERF_SAMPLE_BRANCH_HV		| \
+				     PERF_SAMPLE_BRANCH_ANY		| \
+				     PERF_SAMPLE_BRANCH_ANY_CALL	| \
+				     PERF_SAMPLE_BRANCH_ANY_RETURN	| \
+				     PERF_SAMPLE_BRANCH_IND_CALL	| \
+				     PERF_SAMPLE_BRANCH_COND		| \
+				     PERF_SAMPLE_BRANCH_IND_JUMP	| \
+				     PERF_SAMPLE_BRANCH_CALL		| \
+				     PERF_SAMPLE_BRANCH_NO_FLAGS	| \
+				     PERF_SAMPLE_BRANCH_NO_CYCLES	| \
+				     PERF_SAMPLE_BRANCH_TYPE_SAVE	| \
+				     PERF_SAMPLE_BRANCH_HW_INDEX	| \
+				     PERF_SAMPLE_BRANCH_PRIV_SAVE)
+
+#define BRBE_PERF_BRANCH_FILTERS    (BRBE_ALLOWED_BRANCH_FILTERS	| \
+				     BRBE_EXCLUDE_BRANCH_FILTERS)
+
+bool armv8pmu_branch_valid(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+
+	/*
+	 * Ensure both perf branch filter allowed and exclude
+	 * masks are always in sync with the generic perf ABI.
+	 */
+	BUILD_BUG_ON(BRBE_PERF_BRANCH_FILTERS != (PERF_SAMPLE_BRANCH_MAX - 1));
+
+	if (branch_type & ~BRBE_ALLOWED_BRANCH_FILTERS) {
+		pr_debug_once("requested branch filter not supported 0x%llx\n", branch_type);
+		return false;
+	}
+
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
+	if ((branch_type & PERF_SAMPLE_BRANCH_HV) && !is_kernel_in_hyp_mode())
+		pr_debug_once("hypervisor privilege filter not supported 0x%llx\n", branch_type);
+
+	return true;
+}
+
+int armv8pmu_private_alloc(struct arm_pmu *arm_pmu)
+{
+	struct brbe_hw_attr *brbe_attr = kzalloc(sizeof(struct brbe_hw_attr), GFP_KERNEL);
+
+	if (!brbe_attr)
+		return -ENOMEM;
+
+	arm_pmu->private = brbe_attr;
+	return 0;
+}
+
+void armv8pmu_private_free(struct arm_pmu *arm_pmu)
+{
+	kfree(arm_pmu->private);
+}
+
+static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)armpmu->private;
+	u64 brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
+
+	brbe_attr->brbe_version = brbe;
+	brbe_attr->brbe_format = brbe_get_format(brbidr);
+	brbe_attr->brbe_cc = brbe_get_cc_bits(brbidr);
+	brbe_attr->brbe_nr = brbe_get_numrec(brbidr);
+
+	if (!valid_brbe_version(brbe_attr->brbe_version) ||
+	   !valid_brbe_format(brbe_attr->brbe_format) ||
+	   !valid_brbe_cc(brbe_attr->brbe_cc) ||
+	   !valid_brbe_nr(brbe_attr->brbe_nr))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+void armv8pmu_branch_probe(struct arm_pmu *armpmu)
+{
+	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	u32 brbe;
+
+	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
+	if (!brbe)
+		return;
+
+	if (brbe_attributes_probe(armpmu, brbe))
+		return;
+
+	armpmu->has_branch_stack = 1;
+}
+
+static u64 branch_type_to_brbfcr(int branch_type)
+{
+	u64 brbfcr = 0;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		brbfcr |= BRBFCR_EL1_BRANCH_FILTERS;
+		return brbfcr;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		brbfcr |= BRBFCR_EL1_INDCALL;
+		brbfcr |= BRBFCR_EL1_DIRCALL;
+	}
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
+	u64 brbcr = BRBCR_EL1_DEFAULT_TS;
+
+	/*
+	 * BRBE need not be paused on PMU interrupt while tracing only
+	 * the user space, bcause it will automatically be inside the
+	 * prohibited region. But even after PMU overflow occurs, the
+	 * interrupt could still take much more cycles, before it can
+	 * be taken and by that time BRBE will have been overwritten.
+	 * Let's enable pause on PMU interrupt mechanism even for user
+	 * only traces.
+	 */
+	brbcr |= BRBCR_EL1_FZP;
+
+	/*
+	 * When running in the hyp mode, writing into BRBCR_EL1
+	 * actually writes into BRBCR_EL2 instead. Field E2BRE
+	 * is also at the same position as E1BRE.
+	 */
+	if (branch_type & PERF_SAMPLE_BRANCH_USER)
+		brbcr |= BRBCR_EL1_E0BRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
+		brbcr |= BRBCR_EL1_E1BRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_HV) {
+		if (is_kernel_in_hyp_mode())
+			brbcr |= BRBCR_EL1_E1BRE;
+	}
+
+	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES))
+		brbcr |= BRBCR_EL1_CC;
+
+	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS))
+		brbcr |= BRBCR_EL1_MPRED;
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
+	return brbcr & BRBCR_EL1_DEFAULT_CONFIG;
+}
+
+void armv8pmu_branch_enable(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+	u64 brbfcr, brbcr;
+
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_DEFAULT_CONFIG;
+	brbfcr |= branch_type_to_brbfcr(branch_type);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~BRBCR_EL1_DEFAULT_CONFIG;
+	brbcr |= branch_type_to_brbcr(branch_type);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+	armv8pmu_branch_reset();
+}
+
+void armv8pmu_branch_disable(struct perf_event *event)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	u64 brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+
+	brbcr &= ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE);
+	brbfcr |= BRBFCR_EL1_PAUSED;
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+}
+
+static void brbe_set_perf_entry_type(struct perf_branch_entry *entry, u64 brbinf)
+{
+	int brbe_type = brbe_get_type(brbinf);
+
+	switch (brbe_type) {
+	case BRBINFx_EL1_TYPE_UNCOND_DIR:
+		entry->type = PERF_BR_UNCOND;
+		break;
+	case BRBINFx_EL1_TYPE_INDIR:
+		entry->type = PERF_BR_IND;
+		break;
+	case BRBINFx_EL1_TYPE_DIR_LINK:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_INDIR_LINK:
+		entry->type = PERF_BR_IND_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_RET_SUB:
+		entry->type = PERF_BR_RET;
+		break;
+	case BRBINFx_EL1_TYPE_COND_DIR:
+		entry->type = PERF_BR_COND;
+		break;
+	case BRBINFx_EL1_TYPE_CALL:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_TRAP:
+		entry->type = PERF_BR_SYSCALL;
+		break;
+	case BRBINFx_EL1_TYPE_RET_EXCPT:
+		entry->type = PERF_BR_ERET;
+		break;
+	case BRBINFx_EL1_TYPE_IRQ:
+		entry->type = PERF_BR_IRQ;
+		break;
+	case BRBINFx_EL1_TYPE_DEBUG_HALT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_HALT;
+		break;
+	case BRBINFx_EL1_TYPE_SERROR:
+		entry->type = PERF_BR_SERROR;
+		break;
+	case BRBINFx_EL1_TYPE_INST_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_INST;
+		break;
+	case BRBINFx_EL1_TYPE_DATA_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_DATA;
+		break;
+	case BRBINFx_EL1_TYPE_ALGN_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_ALGN;
+		break;
+	case BRBINFx_EL1_TYPE_INST_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_INST;
+		break;
+	case BRBINFx_EL1_TYPE_DATA_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_DATA;
+		break;
+	case BRBINFx_EL1_TYPE_FIQ:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_FIQ;
+		break;
+	case BRBINFx_EL1_TYPE_DEBUG_EXIT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_EXIT;
+		break;
+	default:
+		pr_warn_once("%d - unknown branch type captured\n", brbe_type);
+		entry->type = PERF_BR_UNKNOWN;
+		break;
+	}
+}
+
+static int brbe_get_perf_priv(u64 brbinf)
+{
+	int brbe_el = brbe_get_el(brbinf);
+
+	switch (brbe_el) {
+	case BRBINFx_EL1_EL_EL0:
+		return PERF_BR_PRIV_USER;
+	case BRBINFx_EL1_EL_EL1:
+		return PERF_BR_PRIV_KERNEL;
+	case BRBINFx_EL1_EL_EL2:
+		if (is_kernel_in_hyp_mode())
+			return PERF_BR_PRIV_KERNEL;
+		return PERF_BR_PRIV_HV;
+	default:
+		pr_warn_once("%d - unknown branch privilege captured\n", brbe_el);
+		return PERF_BR_PRIV_UNKNOWN;
+	}
+}
+
+static void capture_brbe_flags(struct perf_branch_entry *entry, struct perf_event *event,
+			       u64 brbinf)
+{
+	if (branch_sample_type(event))
+		brbe_set_perf_entry_type(entry, brbinf);
+
+	if (!branch_sample_no_cycles(event))
+		entry->cycles = brbe_get_cycles(brbinf);
+
+	if (!branch_sample_no_flags(event)) {
+		/*
+		 * BRBINFx_EL1.LASTFAILED indicates that a TME transaction failed (or
+		 * was cancelled) prior to this record, and some number of records
+		 * prior to this one, may have been generated during an attempt to
+		 * execute the transaction.
+		 *
+		 * We will remove such entries later in process_branch_aborts().
+		 */
+		entry->abort = brbe_get_lastfailed(brbinf);
+
+		/*
+		 * All these information (i.e transaction state and mispredicts)
+		 * are available for source only and complete branch records.
+		 */
+		if (brbe_record_is_complete(brbinf) ||
+		    brbe_record_is_source_only(brbinf)) {
+			entry->mispred = brbe_get_mispredict(brbinf);
+			entry->predicted = !entry->mispred;
+			entry->in_tx = brbe_get_in_tx(brbinf);
+		}
+	}
+
+	if (branch_sample_priv(event)) {
+		/*
+		 * All these information (i.e branch privilege level) are
+		 * available for target only and complete branch records.
+		 */
+		if (brbe_record_is_complete(brbinf) ||
+		    brbe_record_is_target_only(brbinf))
+			entry->priv = brbe_get_perf_priv(brbinf);
+	}
+}
+
+/*
+ * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
+ * preceding consecutive branch records, that were in a transaction
+ * (i.e their BRBINFx_EL1.TX set) have been aborted.
+ *
+ * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
+ * consecutive branch records up to the last record, which were in a
+ * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
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
+ * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
+ * branches records near the end of the BRBE buffer.
+ *
+ * Architecture does not guarantee a non transaction (TX = 0) branch
+ * record between two different transactions. So it is possible that
+ * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
+ * mark more than required transactions as aborted.
+ */
+static void process_branch_aborts(struct pmu_hw_events *cpuc)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	bool lastfailed = !!(brbfcr & BRBFCR_EL1_LASTFAILED);
+	int idx = brbe_attr->brbe_nr - 1;
+	struct perf_branch_entry *entry;
+
+	do {
+		entry = &cpuc->branches->branch_entries[idx];
+		if (entry->in_tx) {
+			entry->abort = lastfailed;
+		} else {
+			lastfailed = entry->abort;
+			entry->abort = false;
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
+static bool capture_branch_entry(struct pmu_hw_events *cpuc,
+				 struct perf_event *event, int idx)
+{
+	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
+	u64 brbinf = get_brbinf_reg(idx);
+
+	/*
+	 * There are no valid entries anymore on the buffer.
+	 * Abort the branch record processing to save some
+	 * cycles and also reduce the capture/process load
+	 * for the user space as well.
+	 */
+	if (brbe_invalid(brbinf))
+		return false;
+
+	perf_clear_branch_entry_bitfields(entry);
+	if (brbe_record_is_complete(brbinf)) {
+		entry->from = get_brbsrc_reg(idx);
+		entry->to = get_brbtgt_reg(idx);
+	} else if (brbe_record_is_source_only(brbinf)) {
+		entry->from = get_brbsrc_reg(idx);
+		entry->to = 0;
+	} else if (brbe_record_is_target_only(brbinf)) {
+		entry->from = 0;
+		entry->to = get_brbtgt_reg(idx);
+	}
+	capture_brbe_flags(entry, event, brbinf);
+	return true;
+}
+
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
+	u64 brbfcr, brbcr;
+	int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	/* Ensure pause on PMU interrupt is enabled */
+	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
+
+	/* Pause the buffer */
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	/* Determine the indices for each loop */
+	loop1_idx1 = BRBE_BANK0_IDX_MIN;
+	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
+		loop1_idx2 = brbe_attr->brbe_nr - 1;
+		loop2_idx1 = BRBE_BANK1_IDX_MIN;
+		loop2_idx2 = BRBE_BANK0_IDX_MAX;
+	} else {
+		loop1_idx2 = BRBE_BANK0_IDX_MAX;
+		loop2_idx1 = BRBE_BANK1_IDX_MIN;
+		loop2_idx2 = brbe_attr->brbe_nr - 1;
+	}
+
+	/* Loop through bank 0 */
+	select_brbe_bank(BRBE_BANK_IDX_0);
+	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
+		if (!capture_branch_entry(cpuc, event, idx))
+			goto skip_bank_1;
+	}
+
+	/* Loop through bank 1 */
+	select_brbe_bank(BRBE_BANK_IDX_1);
+	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
+		if (!capture_branch_entry(cpuc, event, idx))
+			break;
+	}
+
+skip_bank_1:
+	cpuc->branches->branch_stack.nr = idx;
+	cpuc->branches->branch_stack.hw_idx = -1ULL;
+	process_branch_aborts(cpuc);
+
+	/* Unpause the buffer */
+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+	armv8pmu_branch_reset();
+}
diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
new file mode 100644
index 000000000000..a47480eec070
--- /dev/null
+++ b/drivers/perf/arm_brbe.h
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Branch Record Buffer Extension Helpers.
+ *
+ * Copyright (C) 2022 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define pr_fmt(fmt) "brbe: " fmt
+
+#include <linux/perf/arm_pmu.h>
+
+#define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
+				   BRBFCR_EL1_INDIRECT | \
+				   BRBFCR_EL1_RTN      | \
+				   BRBFCR_EL1_INDCALL  | \
+				   BRBFCR_EL1_DIRCALL  | \
+				   BRBFCR_EL1_CONDDIR)
+
+#define BRBFCR_EL1_DEFAULT_CONFIG (BRBFCR_EL1_BANK_MASK | \
+				   BRBFCR_EL1_PAUSED    | \
+				   BRBFCR_EL1_EnI       | \
+				   BRBFCR_EL1_BRANCH_FILTERS)
+
+/*
+ * BRBTS_EL1 is currently not used for branch stack implementation
+ * purpose but BRBCR_EL1.TS needs to have a valid value from all
+ * available options. BRBCR_EL1_TS_VIRTUAL is selected for this.
+ */
+#define BRBCR_EL1_DEFAULT_TS      FIELD_PREP(BRBCR_EL1_TS_MASK, BRBCR_EL1_TS_VIRTUAL)
+
+#define BRBCR_EL1_DEFAULT_CONFIG  (BRBCR_EL1_EXCEPTION | \
+				   BRBCR_EL1_ERTN      | \
+				   BRBCR_EL1_CC        | \
+				   BRBCR_EL1_MPRED     | \
+				   BRBCR_EL1_E1BRE     | \
+				   BRBCR_EL1_E0BRE     | \
+				   BRBCR_EL1_FZP       | \
+				   BRBCR_EL1_DEFAULT_TS)
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
+ * entries each. An individual branch record in a given bank could
+ * be accessed, after selecting the bank in BRBFCR_EL1.BANK and
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
+#define BRBE_BANK_MAX_ENTRIES 32
+
+#define BRBE_BANK0_IDX_MIN 0
+#define BRBE_BANK0_IDX_MAX 31
+#define BRBE_BANK1_IDX_MIN 32
+#define BRBE_BANK1_IDX_MAX 63
+
+struct brbe_hw_attr {
+	int	brbe_version;
+	int	brbe_cc;
+	int	brbe_nr;
+	int	brbe_format;
+};
+
+enum brbe_bank_idx {
+	BRBE_BANK_IDX_INVALID = -1,
+	BRBE_BANK_IDX_0,
+	BRBE_BANK_IDX_1,
+	BRBE_BANK_IDX_MAX
+};
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
+	return buffer_idx % BRBE_BANK_MAX_ENTRIES;
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
+	return FIELD_GET(BRBINFx_EL1_VALID_MASK, brbinf);
+}
+
+static inline bool brbe_invalid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_NONE;
+}
+
+static inline bool brbe_record_is_complete(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_FULL;
+}
+
+static inline bool brbe_record_is_source_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_SOURCE;
+}
+
+static inline bool brbe_record_is_target_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_TARGET;
+}
+
+static inline int brbe_get_in_tx(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_T_MASK, brbinf);
+}
+
+static inline int brbe_get_mispredict(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_MPRED_MASK, brbinf);
+}
+
+static inline int brbe_get_lastfailed(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_LASTFAILED_MASK, brbinf);
+}
+
+static inline int brbe_get_cycles(u64 brbinf)
+{
+	/*
+	 * Captured cycle count is unknown and hence
+	 * should not be passed on to the user space.
+	 */
+	if (brbinf & BRBINFx_EL1_CCU)
+		return 0;
+
+	return FIELD_GET(BRBINFx_EL1_CC_MASK, brbinf);
+}
+
+static inline int brbe_get_type(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_TYPE_MASK, brbinf);
+}
+
+static inline int brbe_get_el(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_EL_MASK, brbinf);
+}
+
+static inline int brbe_get_numrec(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
+}
+
+static inline int brbe_get_format(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_FORMAT_MASK, brbidr);
+}
+
+static inline int brbe_get_cc_bits(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_CC_MASK, brbidr);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 86d803ff1ae3..fef1bc6067cc 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -797,6 +797,10 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		/*
+		 * PMU IRQ should remain asserted until all branch records
+		 * are captured and processed into struct perf_sample_data.
+		 */
 		if (has_branch_stack(event) && !WARN_ON(!cpuc->branches)) {
 			armv8pmu_branch_read(cpuc, event);
 			perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
@@ -1142,14 +1146,25 @@ static void __armv8pmu_probe_pmu(void *info)
 
 static int branch_records_alloc(struct arm_pmu *armpmu)
 {
+	struct branch_records __percpu *tmp_alloc_ptr;
+	struct branch_records *records;
 	struct pmu_hw_events *events;
 	int cpu;
 
+	tmp_alloc_ptr = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
+	if (!tmp_alloc_ptr)
+		return -ENOMEM;
+
+	/*
+	 * FIXME: Memory allocated via tmp_alloc_ptr gets completely
+	 * consumed here, never required to be freed up later. Hence
+	 * losing access to on stack 'tmp_alloc_ptr' is acceptible.
+	 * Otherwise this alloc handle has to be saved some where.
+	 */
 	for_each_possible_cpu(cpu) {
 		events = per_cpu_ptr(armpmu->hw_events, cpu);
-		events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
-		if (!events->branches)
-			return -ENOMEM;
+		records = per_cpu_ptr(tmp_alloc_ptr, cpu);
+		events->branches = records;
 	}
 	return 0;
 }
-- 
2.25.1

