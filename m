Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C356677C18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjAWNBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjAWNBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:01:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CB9825297;
        Mon, 23 Jan 2023 05:00:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F884143D;
        Mon, 23 Jan 2023 05:01:27 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.50.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11F163F64C;
        Mon, 23 Jan 2023 05:00:39 -0800 (PST)
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
Subject: [PATCH V8 6/6] arm64/perf: Enable branch stack events via FEAT_BRBE
Date:   Mon, 23 Jan 2023 18:29:56 +0530
Message-Id: <20230123125956.1350336-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123125956.1350336-1-anshuman.khandual@arm.com>
References: <20230123125956.1350336-1-anshuman.khandual@arm.com>
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
 arch/arm64/include/asm/perf_event.h |  11 +
 arch/arm64/kernel/Makefile          |   1 +
 arch/arm64/kernel/brbe.c            | 538 ++++++++++++++++++++++++++++
 arch/arm64/kernel/brbe.h            | 257 +++++++++++++
 5 files changed, 818 insertions(+)
 create mode 100644 arch/arm64/kernel/brbe.c
 create mode 100644 arch/arm64/kernel/brbe.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5ccca26a408..ff5fab0ae771 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1377,6 +1377,17 @@ config HW_PERF_EVENTS
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
index 83951fdeccf3..97db96326e13 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -279,6 +279,16 @@ struct perf_event;
 
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
@@ -305,3 +315,4 @@ static inline void armv8pmu_branch_reset(void) { }
 static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
 #endif
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..6ee7ccb61621 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_ARM64_BRBE)		+= brbe.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm64/kernel/brbe.c b/arch/arm64/kernel/brbe.c
new file mode 100644
index 000000000000..81ea6563e153
--- /dev/null
+++ b/arch/arm64/kernel/brbe.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2022 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "brbe.h"
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
+static const char branch_filter_error_msg[] = "branch filter not supported";
+
+bool armv8pmu_branch_valid(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
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
+		pr_debug_once("%s - hypervisor privilege\n", branch_filter_error_msg);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ABORT_TX) {
+		pr_debug_once("%s - aborted transaction\n", branch_filter_error_msg);
+		return false;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_NO_TX) {
+		pr_debug_once("%s - no transaction\n", branch_filter_error_msg);
+		return false;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IN_TX) {
+		pr_debug_once("%s - in transaction\n", branch_filter_error_msg);
+		return false;
+	}
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
+	u64 brbcr = (BRBCR_EL1_FZP | BRBCR_EL1_DEFAULT_TS);
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
+	case BRBINF_EL1_TYPE_UNCOND_DIR:
+		entry->type = PERF_BR_UNCOND;
+		break;
+	case BRBINF_EL1_TYPE_INDIR:
+		entry->type = PERF_BR_IND;
+		break;
+	case BRBINF_EL1_TYPE_DIR_LINK:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINF_EL1_TYPE_INDIR_LINK:
+		entry->type = PERF_BR_IND_CALL;
+		break;
+	case BRBINF_EL1_TYPE_RET_SUB:
+		entry->type = PERF_BR_RET;
+		break;
+	case BRBINF_EL1_TYPE_COND_DIR:
+		entry->type = PERF_BR_COND;
+		break;
+	case BRBINF_EL1_TYPE_CALL:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINF_EL1_TYPE_TRAP:
+		entry->type = PERF_BR_SYSCALL;
+		break;
+	case BRBINF_EL1_TYPE_RET_EXCPT:
+		entry->type = PERF_BR_ERET;
+		break;
+	case BRBINF_EL1_TYPE_IRQ:
+		entry->type = PERF_BR_IRQ;
+		break;
+	case BRBINF_EL1_TYPE_DEBUG_HALT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_HALT;
+		break;
+	case BRBINF_EL1_TYPE_SERROR:
+		entry->type = PERF_BR_SERROR;
+		break;
+	case BRBINF_EL1_TYPE_INST_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_INST;
+		break;
+	case BRBINF_EL1_TYPE_DATA_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_DATA;
+		break;
+	case BRBINF_EL1_TYPE_ALGN_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_ALGN;
+		break;
+	case BRBINF_EL1_TYPE_INST_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_INST;
+		break;
+	case BRBINF_EL1_TYPE_DATA_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_DATA;
+		break;
+	case BRBINF_EL1_TYPE_FIQ:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_FIQ;
+		break;
+	case BRBINF_EL1_TYPE_DEBUG_EXIT:
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
+	case BRBINF_EL1_EL_EL0:
+		return PERF_BR_PRIV_USER;
+	case BRBINF_EL1_EL_EL1:
+		return PERF_BR_PRIV_KERNEL;
+	case BRBINF_EL1_EL_EL2:
+		if (is_kernel_in_hyp_mode())
+			return PERF_BR_PRIV_KERNEL;
+		return PERF_BR_PRIV_HV;
+	default:
+		pr_warn_once("%d - unknown branch privilege captured\n", brbe_el);
+		return PERF_BR_PRIV_UNKNOWN;
+	}
+}
+
+static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
+			       u64 brbinf, u64 brbcr, int idx)
+{
+	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
+
+	if (branch_sample_type(event))
+		brbe_set_perf_entry_type(entry, brbinf);
+
+	if (!branch_sample_no_cycles(event)) {
+		WARN_ON_ONCE(!(brbcr & BRBCR_EL1_CC));
+		entry->cycles = brbe_get_cycles(brbinf);
+	}
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
+			WARN_ON_ONCE(!(brbcr & BRBCR_EL1_MPRED));
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
+				 struct perf_event *event,
+				 u64 brbcr, int idx)
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
+	capture_brbe_flags(cpuc, event, brbinf, brbcr, idx);
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
+	/* Save and clear the privilege */
+	write_sysreg_s(brbcr & ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE), SYS_BRBCR_EL1);
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
+		if (!capture_branch_entry(cpuc, event, brbcr, idx))
+			break;
+	}
+
+	/* Loop through bank 1 */
+	select_brbe_bank(BRBE_BANK_IDX_1);
+	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
+		if (!capture_branch_entry(cpuc, event, brbcr, idx))
+			break;
+	}
+	cpuc->branches->branch_stack.nr = idx;
+	cpuc->branches->branch_stack.hw_idx = -1ULL;
+	process_branch_aborts(cpuc);
+
+	/* Restore privilege, enable pause on PMU interrupt */
+	write_sysreg_s(brbcr | BRBCR_EL1_FZP, SYS_BRBCR_EL1);
+
+	/* Unpause the buffer */
+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+	armv8pmu_branch_reset();
+}
diff --git a/arch/arm64/kernel/brbe.h b/arch/arm64/kernel/brbe.h
new file mode 100644
index 000000000000..3a5a6f5f03bf
--- /dev/null
+++ b/arch/arm64/kernel/brbe.h
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
+	return FIELD_GET(BRBINF_EL1_VALID_MASK, brbinf);
+}
+
+static inline bool brbe_invalid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_NONE;
+}
+
+static inline bool brbe_record_is_complete(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_FULL;
+}
+
+static inline bool brbe_record_is_source_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_SOURCE;
+}
+
+static inline bool brbe_record_is_target_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_EL1_VALID_TARGET;
+}
+
+static inline int brbe_get_in_tx(u64 brbinf)
+{
+	return FIELD_GET(BRBINF_EL1_T_MASK, brbinf);
+}
+
+static inline int brbe_get_mispredict(u64 brbinf)
+{
+	return FIELD_GET(BRBINF_EL1_MPRED_MASK, brbinf);
+}
+
+static inline int brbe_get_lastfailed(u64 brbinf)
+{
+	return FIELD_GET(BRBINF_EL1_LASTFAILED_MASK, brbinf);
+}
+
+static inline int brbe_get_cycles(u64 brbinf)
+{
+	/*
+	 * Captured cycle count is unknown and hence
+	 * should not be passed on to the user space.
+	 */
+	if (brbinf & BRBINF_EL1_CCU)
+		return 0;
+
+	return FIELD_GET(BRBINF_EL1_CC_MASK, brbinf);
+}
+
+static inline int brbe_get_type(u64 brbinf)
+{
+	return FIELD_GET(BRBINF_EL1_TYPE_MASK, brbinf);
+}
+
+static inline int brbe_get_el(u64 brbinf)
+{
+	return FIELD_GET(BRBINF_EL1_EL_MASK, brbinf);
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
-- 
2.25.1

