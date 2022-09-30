Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C985F0868
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiI3KTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiI3KS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:18:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7C15ED1B;
        Fri, 30 Sep 2022 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664533133; x=1696069133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yCKxYB3v7XKfg89qlIIEP7LxclyaPlWpeSsZcHXQB2E=;
  b=kpAPDaBD67pLm23zJtYfw7+eT/uckmjyyH3Lox4izjyj8QiBNgqbCA/f
   dg7e6be8rHe/ot5Eaqjh1lSvJx1JvrhBIfTrjsPjCHU0hRaG5aK4/eHQ+
   E8axyaPOc4HX7+VEmMMaEsE+4Z8Ei994GhzWklCWtejnkb7/W8VHN+tlC
   VRiaipWVF+O1zONoGFDrZ11WiqejT3vC/TwmpScfb1YyV6mzkRXjp5c/r
   u9PJiHnn5axZrPJOvHeY8XPcMCleoEUIYrNpiGEWwEehgFviE2/Oeto4Y
   qqJelYPSU21bare1W93HM9blypiUQaReIYsHk0ZqG4nIwcIjUcoFCJHoG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="366207469"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="366207469"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:18:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726807506"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726807506"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:18:51 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 001/105] KVM: VMX: Move out vmx_x86_ops to 'main.c' to wrap VMX and TDX
Date:   Fri, 30 Sep 2022 03:16:55 -0700
Message-Id: <5e767ece0348c4ee20015aea8b15c66e4ce7a70d.1664530907.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664530907.git.isaku.yamahata@intel.com>
References: <cover.1664530907.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

KVM accesses Virtual Machine Control Structure (VMCS) with VMX instructions
to operate on VM.  TDX doesn't allow VMM to operate VMCS directly.
Instead, TDX has its own data structures, and TDX SEAMCALL APIs for VMM to
indirectly operate those data structures.  This means we must have a TDX
version of kvm_x86_ops.

The existing global struct kvm_x86_ops already defines an interface which
fits with TDX.  But kvm_x86_ops is system-wide, not per-VM structure.  To
allow VMX to coexist with TDs, the kvm_x86_ops callbacks will have wrappers
"if (tdx) tdx_op() else vmx_op()" to switch VMX or TDX at run time.

To split the runtime switch, the VMX implementation, and the TDX
implementation, add main.c, and move out the vmx_x86_ops hooks in
preparation for adding TDX, which can coexist with VMX, i.e. KVM can run
both VMs and TDs.  Use 'vt' for the naming scheme as a nod to VT-x and as a
concatenation of VmxTdx.

The current code looks as follows.
In vmx.c
  static vmx_op() { ... }
  static struct kvm_x86_ops vmx_x86_ops = {
        .op = vmx_op,
  initialization code

The eventually converted code will look like
In vmx.c, keep the VMX operations.
  vmx_op() { ... }
  VMX initialization
In tdx.c, define the TDX operations.
  tdx_op() { ... }
  TDX initialization
In x86_ops.h, declare the VMX and TDX operations.
  vmx_op();
  tdx_op();
In main.c, define common wrappers for VMX and TDX.
  static vt_ops() { if (tdx) tdx_ops() else vmx_ops() }
  static struct kvm_x86_ops vt_x86_ops = {
        .op = vt_op,
  initialization to call VMX and TDX initialization

Opportunistically, fix the name inconsistency from vmx_create_vcpu() and
vmx_free_vcpu() to vmx_vcpu_create() and vxm_vcpu_free().

Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/Makefile      |   2 +-
 arch/x86/kvm/vmx/main.c    | 155 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 363 +++++++++++--------------------------
 arch/x86/kvm/vmx/x86_ops.h | 125 +++++++++++++
 4 files changed, 386 insertions(+), 259 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/main.c
 create mode 100644 arch/x86/kvm/vmx/x86_ops.h

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 30f244b64523..ee4d0999f20f 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -22,7 +22,7 @@ kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_XEN)	+= xen.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
-			   vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
+			   vmx/evmcs.o vmx/nested.o vmx/posted_intr.o vmx/main.o
 kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
 
 kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o svm/sev.o
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
new file mode 100644
index 000000000000..636768f5b985
--- /dev/null
+++ b/arch/x86/kvm/vmx/main.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/moduleparam.h>
+
+#include "x86_ops.h"
+#include "vmx.h"
+#include "nested.h"
+#include "pmu.h"
+
+struct kvm_x86_ops vt_x86_ops __initdata = {
+	.name = "kvm_intel",
+
+	.hardware_unsetup = vmx_hardware_unsetup,
+	.check_processor_compatibility = vmx_check_processor_compatibility,
+
+	.hardware_enable = vmx_hardware_enable,
+	.hardware_disable = vmx_hardware_disable,
+	.has_emulated_msr = vmx_has_emulated_msr,
+
+	.vm_size = sizeof(struct kvm_vmx),
+	.vm_init = vmx_vm_init,
+	.vm_destroy = vmx_vm_destroy,
+
+	.vcpu_precreate = vmx_vcpu_precreate,
+	.vcpu_create = vmx_vcpu_create,
+	.vcpu_free = vmx_vcpu_free,
+	.vcpu_reset = vmx_vcpu_reset,
+
+	.prepare_switch_to_guest = vmx_prepare_switch_to_guest,
+	.vcpu_load = vmx_vcpu_load,
+	.vcpu_put = vmx_vcpu_put,
+
+	.update_exception_bitmap = vmx_update_exception_bitmap,
+	.get_msr_feature = vmx_get_msr_feature,
+	.get_msr = vmx_get_msr,
+	.set_msr = vmx_set_msr,
+	.get_segment_base = vmx_get_segment_base,
+	.get_segment = vmx_get_segment,
+	.set_segment = vmx_set_segment,
+	.get_cpl = vmx_get_cpl,
+	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.set_cr0 = vmx_set_cr0,
+	.is_valid_cr4 = vmx_is_valid_cr4,
+	.set_cr4 = vmx_set_cr4,
+	.set_efer = vmx_set_efer,
+	.get_idt = vmx_get_idt,
+	.set_idt = vmx_set_idt,
+	.get_gdt = vmx_get_gdt,
+	.set_gdt = vmx_set_gdt,
+	.set_dr7 = vmx_set_dr7,
+	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
+	.cache_reg = vmx_cache_reg,
+	.get_rflags = vmx_get_rflags,
+	.set_rflags = vmx_set_rflags,
+	.get_if_flag = vmx_get_if_flag,
+
+	.flush_tlb_all = vmx_flush_tlb_all,
+	.flush_tlb_current = vmx_flush_tlb_current,
+	.flush_tlb_gva = vmx_flush_tlb_gva,
+	.flush_tlb_guest = vmx_flush_tlb_guest,
+
+	.vcpu_pre_run = vmx_vcpu_pre_run,
+	.vcpu_run = vmx_vcpu_run,
+	.handle_exit = vmx_handle_exit,
+	.skip_emulated_instruction = vmx_skip_emulated_instruction,
+	.update_emulated_instruction = vmx_update_emulated_instruction,
+	.set_interrupt_shadow = vmx_set_interrupt_shadow,
+	.get_interrupt_shadow = vmx_get_interrupt_shadow,
+	.patch_hypercall = vmx_patch_hypercall,
+	.inject_irq = vmx_inject_irq,
+	.inject_nmi = vmx_inject_nmi,
+	.queue_exception = vmx_queue_exception,
+	.cancel_injection = vmx_cancel_injection,
+	.interrupt_allowed = vmx_interrupt_allowed,
+	.nmi_allowed = vmx_nmi_allowed,
+	.get_nmi_mask = vmx_get_nmi_mask,
+	.set_nmi_mask = vmx_set_nmi_mask,
+	.enable_nmi_window = vmx_enable_nmi_window,
+	.enable_irq_window = vmx_enable_irq_window,
+	.update_cr8_intercept = vmx_update_cr8_intercept,
+	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
+	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
+	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
+	.load_eoi_exitmap = vmx_load_eoi_exitmap,
+	.apicv_post_state_restore = vmx_apicv_post_state_restore,
+	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
+	.hwapic_irr_update = vmx_hwapic_irr_update,
+	.hwapic_isr_update = vmx_hwapic_isr_update,
+	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
+	.sync_pir_to_irr = vmx_sync_pir_to_irr,
+	.deliver_interrupt = vmx_deliver_interrupt,
+	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
+
+	.set_tss_addr = vmx_set_tss_addr,
+	.set_identity_map_addr = vmx_set_identity_map_addr,
+	.get_mt_mask = vmx_get_mt_mask,
+
+	.get_exit_info = vmx_get_exit_info,
+
+	.vcpu_after_set_cpuid = vmx_vcpu_after_set_cpuid,
+
+	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
+
+	.get_l2_tsc_offset = vmx_get_l2_tsc_offset,
+	.get_l2_tsc_multiplier = vmx_get_l2_tsc_multiplier,
+	.write_tsc_offset = vmx_write_tsc_offset,
+	.write_tsc_multiplier = vmx_write_tsc_multiplier,
+
+	.load_mmu_pgd = vmx_load_mmu_pgd,
+
+	.check_intercept = vmx_check_intercept,
+	.handle_exit_irqoff = vmx_handle_exit_irqoff,
+
+	.request_immediate_exit = vmx_request_immediate_exit,
+
+	.sched_in = vmx_sched_in,
+
+	.cpu_dirty_log_size = PML_ENTITY_NUM,
+	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
+
+	.nested_ops = &vmx_nested_ops,
+
+	.pi_update_irte = vmx_pi_update_irte,
+	.pi_start_assignment = vmx_pi_start_assignment,
+
+#ifdef CONFIG_X86_64
+	.set_hv_timer = vmx_set_hv_timer,
+	.cancel_hv_timer = vmx_cancel_hv_timer,
+#endif
+
+	.setup_mce = vmx_setup_mce,
+
+	.smi_allowed = vmx_smi_allowed,
+	.enter_smm = vmx_enter_smm,
+	.leave_smm = vmx_leave_smm,
+	.enable_smi_window = vmx_enable_smi_window,
+
+	.can_emulate_instruction = vmx_can_emulate_instruction,
+	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
+	.migrate_timers = vmx_migrate_timers,
+
+	.msr_filter_changed = vmx_msr_filter_changed,
+	.complete_emulated_msr = kvm_complete_insn_gp,
+
+	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
+};
+
+struct kvm_x86_init_ops vt_init_ops __initdata = {
+	.cpu_has_kvm_support = vmx_cpu_has_kvm_support,
+	.disabled_by_bios = vmx_disabled_by_bios,
+	.hardware_setup = vmx_hardware_setup,
+	.handle_intel_pt_intr = NULL,
+
+	.runtime_ops = &vt_x86_ops,
+	.pmu_ops = &intel_pmu_ops,
+};
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 26f16e310869..6d5eb74fedfb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -66,6 +66,7 @@
 #include "vmcs12.h"
 #include "vmx.h"
 #include "x86.h"
+#include "x86_ops.h"
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
@@ -1386,7 +1387,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
  */
-static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -1397,7 +1398,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
-static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
+void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	vmx_vcpu_pi_put(vcpu);
 
@@ -1451,7 +1452,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 		vmx->emulation_required = vmx_emulation_required(vcpu);
 }
 
-static bool vmx_get_if_flag(struct kvm_vcpu *vcpu)
+bool vmx_get_if_flag(struct kvm_vcpu *vcpu)
 {
 	return vmx_get_rflags(vcpu) & X86_EFLAGS_IF;
 }
@@ -1557,8 +1558,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	return 0;
 }
 
-static bool vmx_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
-					void *insn, int insn_len)
+bool vmx_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
+				void *insn, int insn_len)
 {
 	/*
 	 * Emulation of instructions in SGX enclaves is impossible as RIP does
@@ -1642,7 +1643,7 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
  * Recognizes a pending MTF VM-exit and records the nested state for later
  * delivery.
  */
-static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
+void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -1665,7 +1666,7 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 		vmx->nested.mtf_pending = false;
 }
 
-static int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	vmx_update_emulated_instruction(vcpu);
 	return skip_emulated_instruction(vcpu);
@@ -1684,7 +1685,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
 
-static void vmx_queue_exception(struct kvm_vcpu *vcpu)
+void vmx_queue_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -1797,12 +1798,12 @@ u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu)
 	return kvm_caps.default_tsc_scaling_ratio;
 }
 
-static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
+void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	vmcs_write64(TSC_OFFSET, offset);
 }
 
-static void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier)
+void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier)
 {
 	vmcs_write64(TSC_MULTIPLIER, multiplier);
 }
@@ -1826,7 +1827,7 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 	return !(val & ~valid_bits);
 }
 
-static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
+int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
@@ -1846,7 +1847,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_uret_msr *msr;
@@ -2024,7 +2025,7 @@ static u64 vcpu_supported_debugctl(struct kvm_vcpu *vcpu)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_uret_msr *msr;
@@ -2358,7 +2359,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return ret;
 }
 
-static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 	unsigned long guest_owned_bits;
 
@@ -2401,12 +2402,12 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	}
 }
 
-static __init int cpu_has_kvm_support(void)
+__init int vmx_cpu_has_kvm_support(void)
 {
 	return cpu_has_vmx();
 }
 
-static __init int vmx_disabled_by_bios(void)
+__init int vmx_disabled_by_bios(void)
 {
 	return !boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
 	       !boot_cpu_has(X86_FEATURE_VMX);
@@ -2432,7 +2433,7 @@ static int kvm_cpu_vmxon(u64 vmxon_pointer)
 	return -EFAULT;
 }
 
-static int vmx_hardware_enable(void)
+int vmx_hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
@@ -2473,7 +2474,7 @@ static void vmclear_local_loaded_vmcss(void)
 		__loaded_vmcs_clear(v);
 }
 
-static void vmx_hardware_disable(void)
+void vmx_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 
@@ -3072,7 +3073,7 @@ static void exit_lmode(struct kvm_vcpu *vcpu)
 
 #endif
 
-static void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3102,7 +3103,7 @@ static inline int vmx_get_current_vpid(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->vpid;
 }
 
-static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 root_hpa = mmu->root.hpa;
@@ -3118,7 +3119,7 @@ static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
 
-static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	/*
 	 * vpid_sync_vcpu_addr() is a nop if vpid==0, see the comment in
@@ -3127,7 +3128,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 	vpid_sync_vcpu_addr(vmx_get_current_vpid(vcpu), addr);
 }
 
-static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * vpid_sync_context() is a nop if vpid==0, e.g. if enable_vpid==0 or a
@@ -3282,8 +3283,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
 	return eptp;
 }
 
-static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
-			     int root_level)
+void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
 {
 	struct kvm *kvm = vcpu->kvm;
 	bool update_guest_cr3 = true;
@@ -3311,8 +3311,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
-
-static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	/*
 	 * We operate under the default treatment of SMM, so VMX cannot be
@@ -3428,7 +3427,7 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 	var->g = (ar >> 15) & 1;
 }
 
-static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_segment s;
 
@@ -3508,14 +3507,14 @@ void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 	vmcs_write32(sf->ar_bytes, vmx_segment_access_rights(var));
 }
 
-static void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 {
 	__vmx_set_segment(vcpu, var, seg);
 
 	to_vmx(vcpu)->emulation_required = vmx_emulation_required(vcpu);
 }
 
-static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
 	u32 ar = vmx_read_guest_seg_ar(to_vmx(vcpu), VCPU_SREG_CS);
 
@@ -3523,25 +3522,25 @@ static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 	*l = (ar >> 13) & 1;
 }
 
-static void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	dt->size = vmcs_read32(GUEST_IDTR_LIMIT);
 	dt->address = vmcs_readl(GUEST_IDTR_BASE);
 }
 
-static void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	vmcs_write32(GUEST_IDTR_LIMIT, dt->size);
 	vmcs_writel(GUEST_IDTR_BASE, dt->address);
 }
 
-static void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	dt->size = vmcs_read32(GUEST_GDTR_LIMIT);
 	dt->address = vmcs_readl(GUEST_GDTR_BASE);
 }
 
-static void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 {
 	vmcs_write32(GUEST_GDTR_LIMIT, dt->size);
 	vmcs_writel(GUEST_GDTR_BASE, dt->address);
@@ -4039,7 +4038,7 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	void *vapic_page;
@@ -4059,7 +4058,7 @@ static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	return ((rvi & 0xf0) > (vppr & 0xf0));
 }
 
-static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
+void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 i;
@@ -4200,8 +4199,8 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	return 0;
 }
 
-static void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
-				  int trig_mode, int vector)
+void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
+			   int trig_mode, int vector)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
 
@@ -4344,7 +4343,7 @@ static u32 vmx_vmexit_ctrl(void)
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4584,7 +4583,7 @@ static int vmx_alloc_ipiv_pid_table(struct kvm *kvm)
 	return 0;
 }
 
-static int vmx_vcpu_precreate(struct kvm *kvm)
+int vmx_vcpu_precreate(struct kvm *kvm)
 {
 	return vmx_alloc_ipiv_pid_table(kvm);
 }
@@ -4736,7 +4735,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	vmx->pi_desc.sn = 1;
 }
 
-static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4795,12 +4794,12 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vmx_update_fb_clear_dis(vcpu, vmx);
 }
 
-static void vmx_enable_irq_window(struct kvm_vcpu *vcpu)
+void vmx_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_INTR_WINDOW_EXITING);
 }
 
-static void vmx_enable_nmi_window(struct kvm_vcpu *vcpu)
+void vmx_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 	if (!enable_vnmi ||
 	    vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
@@ -4811,7 +4810,7 @@ static void vmx_enable_nmi_window(struct kvm_vcpu *vcpu)
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_NMI_WINDOW_EXITING);
 }
 
-static void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
+void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	uint32_t intr;
@@ -4839,7 +4838,7 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	vmx_clear_hlt(vcpu);
 }
 
-static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
+void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4917,7 +4916,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 		 GUEST_INTR_STATE_NMI));
 }
 
-static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return -EBUSY;
@@ -4939,7 +4938,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
 
-static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return -EBUSY;
@@ -4954,7 +4953,7 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !vmx_interrupt_blocked(vcpu);
 }
 
-static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	void __user *ret;
 
@@ -4974,7 +4973,7 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 	return init_rmode_tss(kvm, ret);
 }
 
-static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 	to_kvm_vmx(kvm)->ept_identity_map_addr = ident_addr;
 	return 0;
@@ -5253,8 +5252,7 @@ static int handle_io(struct kvm_vcpu *vcpu)
 	return kvm_fast_pio(vcpu, size, port, in);
 }
 
-static void
-vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 {
 	/*
 	 * Patch in the VMCALL instruction:
@@ -5464,7 +5462,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	return kvm_complete_insn_gp(vcpu, err);
 }
 
-static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	get_debugreg(vcpu->arch.db[0], 0);
 	get_debugreg(vcpu->arch.db[1], 1);
@@ -5483,7 +5481,7 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
-static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
 }
@@ -5754,7 +5752,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
+int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	if (vmx_emulation_required_with_pending_exception(vcpu)) {
 		kvm_prepare_emulation_failure_exit(vcpu);
@@ -6018,9 +6016,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
-static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
-			      u64 *info1, u64 *info2,
-			      u32 *intr_info, u32 *error_code)
+void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
+		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6463,7 +6460,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	return 0;
 }
 
-static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
+int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 {
 	int ret = __vmx_handle_exit(vcpu, exit_fastpath);
 
@@ -6551,7 +6548,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		: "eax", "ebx", "ecx", "edx");
 }
 
-static void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
@@ -6621,7 +6618,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 	vmx_update_msr_bitmap_x2apic(vcpu);
 }
 
-static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
+void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 {
 	struct page *page;
 
@@ -6649,7 +6646,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(int max_isr)
+void vmx_hwapic_isr_update(int max_isr)
 {
 	u16 status;
 	u8 old;
@@ -6683,7 +6680,7 @@ static void vmx_set_rvi(int vector)
 	}
 }
 
-static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 	/*
 	 * When running L2, updating RVI is only relevant when
@@ -6697,7 +6694,7 @@ static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 		vmx_set_rvi(max_irr);
 }
 
-static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -6743,7 +6740,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	return max_irr;
 }
 
-static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
@@ -6754,7 +6751,7 @@ static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
+void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6827,7 +6824,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6844,7 +6841,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
  */
-static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
+bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 {
 	switch (index) {
 	case MSR_IA32_SMBASE:
@@ -6965,7 +6962,7 @@ static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 				  IDT_VECTORING_ERROR_CODE);
 }
 
-static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
+void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
@@ -7099,7 +7096,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
@@ -7265,7 +7262,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	return vmx_exit_handlers_fastpath(vcpu);
 }
 
-static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
+void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7276,7 +7273,7 @@ static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	free_loaded_vmcs(vmx->loaded_vmcs);
 }
 
-static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
+int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vmx_uret_msr *tsx_ctrl;
 	struct vcpu_vmx *vmx;
@@ -7385,7 +7382,7 @@ static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
-static int vmx_vm_init(struct kvm *kvm)
+int vmx_vm_init(struct kvm *kvm)
 {
 	if (!ple_gap)
 		kvm->arch.pause_in_guest = true;
@@ -7416,7 +7413,7 @@ static int vmx_vm_init(struct kvm *kvm)
 	return 0;
 }
 
-static int vmx_check_processor_compatibility(void)
+int vmx_check_processor_compatibility(void)
 {
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
@@ -7441,7 +7438,7 @@ static int vmx_check_processor_compatibility(void)
 	return 0;
 }
 
-static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	u8 cache;
 
@@ -7613,7 +7610,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
-static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7723,7 +7720,7 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
+void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->req_immediate_exit = true;
 }
@@ -7762,10 +7759,10 @@ static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
 	return intercept ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE;
 }
 
-static int vmx_check_intercept(struct kvm_vcpu *vcpu,
-			       struct x86_instruction_info *info,
-			       enum x86_intercept_stage stage,
-			       struct x86_exception *exception)
+int vmx_check_intercept(struct kvm_vcpu *vcpu,
+		       struct x86_instruction_info *info,
+		       enum x86_intercept_stage stage,
+		       struct x86_exception *exception)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
@@ -7830,8 +7827,8 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
-static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
-			    bool *expired)
+int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+		bool *expired)
 {
 	struct vcpu_vmx *vmx;
 	u64 tscl, guest_tscl, delta_tsc, lapic_timer_advance_cycles;
@@ -7870,13 +7867,13 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 	return 0;
 }
 
-static void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
+void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->hv_deadline_tsc = -1;
 }
 #endif
 
-static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
+void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	if (!kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
@@ -7902,7 +7899,7 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
 }
 
-static void vmx_setup_mce(struct kvm_vcpu *vcpu)
+void vmx_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
@@ -7912,7 +7909,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 			~FEAT_CTL_LMCE_ENABLED;
 }
 
-static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
 	if (to_vmx(vcpu)->nested.nested_run_pending)
@@ -7920,7 +7917,7 @@ static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !is_smm(vcpu);
 }
 
-static int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7941,7 +7938,7 @@ static int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	return 0;
 }
 
-static int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int ret;
@@ -7962,17 +7959,17 @@ static int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	return 0;
 }
 
-static void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
+void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	/* RSM will cause a vmexit anyway.  */
 }
 
-static bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
+bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 	return to_vmx(vcpu)->nested.vmxon && !is_guest_mode(vcpu);
 }
 
-static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
+void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu)) {
 		struct hrtimer *timer = &to_vmx(vcpu)->nested.preemption_timer;
@@ -7982,7 +7979,7 @@ static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void vmx_hardware_unsetup(void)
+void vmx_hardware_unsetup(void)
 {
 	kvm_set_posted_intr_wakeup_handler(NULL);
 
@@ -7992,7 +7989,7 @@ static void vmx_hardware_unsetup(void)
 	free_kvm_area();
 }
 
-static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
+bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 {
 	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
 			  BIT(APICV_INHIBIT_REASON_ABSENT) |
@@ -8004,151 +8001,13 @@ static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 	return supported & BIT(reason);
 }
 
-static void vmx_vm_destroy(struct kvm *kvm)
+void vmx_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
 
 	free_pages((unsigned long)kvm_vmx->pid_table, vmx_get_pid_table_order(kvm));
 }
 
-static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.name = "kvm_intel",
-
-	.hardware_unsetup = vmx_hardware_unsetup,
-
-	.check_processor_compatibility = vmx_check_processor_compatibility,
-	.hardware_enable = vmx_hardware_enable,
-	.hardware_disable = vmx_hardware_disable,
-	.has_emulated_msr = vmx_has_emulated_msr,
-
-	.vm_size = sizeof(struct kvm_vmx),
-	.vm_init = vmx_vm_init,
-	.vm_destroy = vmx_vm_destroy,
-
-	.vcpu_precreate = vmx_vcpu_precreate,
-	.vcpu_create = vmx_vcpu_create,
-	.vcpu_free = vmx_vcpu_free,
-	.vcpu_reset = vmx_vcpu_reset,
-
-	.prepare_switch_to_guest = vmx_prepare_switch_to_guest,
-	.vcpu_load = vmx_vcpu_load,
-	.vcpu_put = vmx_vcpu_put,
-
-	.update_exception_bitmap = vmx_update_exception_bitmap,
-	.get_msr_feature = vmx_get_msr_feature,
-	.get_msr = vmx_get_msr,
-	.set_msr = vmx_set_msr,
-	.get_segment_base = vmx_get_segment_base,
-	.get_segment = vmx_get_segment,
-	.set_segment = vmx_set_segment,
-	.get_cpl = vmx_get_cpl,
-	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
-	.set_cr0 = vmx_set_cr0,
-	.is_valid_cr4 = vmx_is_valid_cr4,
-	.set_cr4 = vmx_set_cr4,
-	.set_efer = vmx_set_efer,
-	.get_idt = vmx_get_idt,
-	.set_idt = vmx_set_idt,
-	.get_gdt = vmx_get_gdt,
-	.set_gdt = vmx_set_gdt,
-	.set_dr7 = vmx_set_dr7,
-	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
-	.cache_reg = vmx_cache_reg,
-	.get_rflags = vmx_get_rflags,
-	.set_rflags = vmx_set_rflags,
-	.get_if_flag = vmx_get_if_flag,
-
-	.flush_tlb_all = vmx_flush_tlb_all,
-	.flush_tlb_current = vmx_flush_tlb_current,
-	.flush_tlb_gva = vmx_flush_tlb_gva,
-	.flush_tlb_guest = vmx_flush_tlb_guest,
-
-	.vcpu_pre_run = vmx_vcpu_pre_run,
-	.vcpu_run = vmx_vcpu_run,
-	.handle_exit = vmx_handle_exit,
-	.skip_emulated_instruction = vmx_skip_emulated_instruction,
-	.update_emulated_instruction = vmx_update_emulated_instruction,
-	.set_interrupt_shadow = vmx_set_interrupt_shadow,
-	.get_interrupt_shadow = vmx_get_interrupt_shadow,
-	.patch_hypercall = vmx_patch_hypercall,
-	.inject_irq = vmx_inject_irq,
-	.inject_nmi = vmx_inject_nmi,
-	.queue_exception = vmx_queue_exception,
-	.cancel_injection = vmx_cancel_injection,
-	.interrupt_allowed = vmx_interrupt_allowed,
-	.nmi_allowed = vmx_nmi_allowed,
-	.get_nmi_mask = vmx_get_nmi_mask,
-	.set_nmi_mask = vmx_set_nmi_mask,
-	.enable_nmi_window = vmx_enable_nmi_window,
-	.enable_irq_window = vmx_enable_irq_window,
-	.update_cr8_intercept = vmx_update_cr8_intercept,
-	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
-	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
-	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
-	.load_eoi_exitmap = vmx_load_eoi_exitmap,
-	.apicv_post_state_restore = vmx_apicv_post_state_restore,
-	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
-	.hwapic_irr_update = vmx_hwapic_irr_update,
-	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
-	.sync_pir_to_irr = vmx_sync_pir_to_irr,
-	.deliver_interrupt = vmx_deliver_interrupt,
-	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
-
-	.set_tss_addr = vmx_set_tss_addr,
-	.set_identity_map_addr = vmx_set_identity_map_addr,
-	.get_mt_mask = vmx_get_mt_mask,
-
-	.get_exit_info = vmx_get_exit_info,
-
-	.vcpu_after_set_cpuid = vmx_vcpu_after_set_cpuid,
-
-	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
-
-	.get_l2_tsc_offset = vmx_get_l2_tsc_offset,
-	.get_l2_tsc_multiplier = vmx_get_l2_tsc_multiplier,
-	.write_tsc_offset = vmx_write_tsc_offset,
-	.write_tsc_multiplier = vmx_write_tsc_multiplier,
-
-	.load_mmu_pgd = vmx_load_mmu_pgd,
-
-	.check_intercept = vmx_check_intercept,
-	.handle_exit_irqoff = vmx_handle_exit_irqoff,
-
-	.request_immediate_exit = vmx_request_immediate_exit,
-
-	.sched_in = vmx_sched_in,
-
-	.cpu_dirty_log_size = PML_ENTITY_NUM,
-	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
-
-	.nested_ops = &vmx_nested_ops,
-
-	.pi_update_irte = vmx_pi_update_irte,
-	.pi_start_assignment = vmx_pi_start_assignment,
-
-#ifdef CONFIG_X86_64
-	.set_hv_timer = vmx_set_hv_timer,
-	.cancel_hv_timer = vmx_cancel_hv_timer,
-#endif
-
-	.setup_mce = vmx_setup_mce,
-
-	.smi_allowed = vmx_smi_allowed,
-	.enter_smm = vmx_enter_smm,
-	.leave_smm = vmx_leave_smm,
-	.enable_smi_window = vmx_enable_smi_window,
-
-	.can_emulate_instruction = vmx_can_emulate_instruction,
-	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
-	.migrate_timers = vmx_migrate_timers,
-
-	.msr_filter_changed = vmx_msr_filter_changed,
-	.complete_emulated_msr = kvm_complete_insn_gp,
-
-	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
-};
-
 static unsigned int vmx_handle_intel_pt_intr(void)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
@@ -8214,9 +8073,7 @@ static void __init vmx_setup_me_spte_mask(void)
 	kvm_mmu_set_me_spte_mask(0, me_mask);
 }
 
-static struct kvm_x86_init_ops vmx_init_ops __initdata;
-
-static __init int hardware_setup(void)
+__init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
 	struct desc_ptr dt;
@@ -8276,16 +8133,16 @@ static __init int hardware_setup(void)
 	 * using the APIC_ACCESS_ADDR VMCS field.
 	 */
 	if (!flexpriority_enabled)
-		vmx_x86_ops.set_apic_access_page_addr = NULL;
+		vt_x86_ops.set_apic_access_page_addr = NULL;
 
 	if (!cpu_has_vmx_tpr_shadow())
-		vmx_x86_ops.update_cr8_intercept = NULL;
+		vt_x86_ops.update_cr8_intercept = NULL;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
 	    && enable_ept) {
-		vmx_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
-		vmx_x86_ops.tlb_remote_flush_with_range =
+		vt_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
+		vt_x86_ops.tlb_remote_flush_with_range =
 				hv_remote_flush_tlb_with_range;
 	}
 #endif
@@ -8301,7 +8158,7 @@ static __init int hardware_setup(void)
 	if (!cpu_has_vmx_apicv())
 		enable_apicv = 0;
 	if (!enable_apicv)
-		vmx_x86_ops.sync_pir_to_irr = NULL;
+		vt_x86_ops.sync_pir_to_irr = NULL;
 
 	if (!enable_apicv || !cpu_has_vmx_ipiv())
 		enable_ipiv = false;
@@ -8337,7 +8194,7 @@ static __init int hardware_setup(void)
 		enable_pml = 0;
 
 	if (!enable_pml)
-		vmx_x86_ops.cpu_dirty_log_size = 0;
+		vt_x86_ops.cpu_dirty_log_size = 0;
 
 	if (!cpu_has_vmx_preemption_timer())
 		enable_preemption_timer = false;
@@ -8364,9 +8221,9 @@ static __init int hardware_setup(void)
 	}
 
 	if (!enable_preemption_timer) {
-		vmx_x86_ops.set_hv_timer = NULL;
-		vmx_x86_ops.cancel_hv_timer = NULL;
-		vmx_x86_ops.request_immediate_exit = __kvm_request_immediate_exit;
+		vt_x86_ops.set_hv_timer = NULL;
+		vt_x86_ops.cancel_hv_timer = NULL;
+		vt_x86_ops.request_immediate_exit = __kvm_request_immediate_exit;
 	}
 
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
@@ -8377,9 +8234,9 @@ static __init int hardware_setup(void)
 	if (!enable_ept || !enable_pmu || !cpu_has_vmx_intel_pt())
 		pt_mode = PT_MODE_SYSTEM;
 	if (pt_mode == PT_MODE_HOST_GUEST)
-		vmx_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
+		vt_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
 	else
-		vmx_init_ops.handle_intel_pt_intr = NULL;
+		vt_init_ops.handle_intel_pt_intr = NULL;
 
 	setup_default_sgx_lepubkeyhash();
 
@@ -8403,16 +8260,6 @@ static __init int hardware_setup(void)
 	return r;
 }
 
-static struct kvm_x86_init_ops vmx_init_ops __initdata = {
-	.cpu_has_kvm_support = cpu_has_kvm_support,
-	.disabled_by_bios = vmx_disabled_by_bios,
-	.hardware_setup = hardware_setup,
-	.handle_intel_pt_intr = NULL,
-
-	.runtime_ops = &vmx_x86_ops,
-	.pmu_ops = &intel_pmu_ops,
-};
-
 static void vmx_cleanup_l1d_flush(void)
 {
 	if (vmx_l1d_flush_pages) {
@@ -8490,7 +8337,7 @@ static int __init vmx_init(void)
 		}
 
 		if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH)
-			vmx_x86_ops.enable_direct_tlbflush
+			vt_x86_ops.enable_direct_tlbflush
 				= hv_enable_direct_tlbflush;
 
 	} else {
@@ -8498,8 +8345,8 @@ static int __init vmx_init(void)
 	}
 #endif
 
-	r = kvm_init(&vmx_init_ops, sizeof(struct vcpu_vmx),
-		     __alignof__(struct vcpu_vmx), THIS_MODULE);
+	r = kvm_init(&vt_init_ops, sizeof(struct vcpu_vmx),
+		__alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
 		return r;
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
new file mode 100644
index 000000000000..85da24ecb25f
--- /dev/null
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_VMX_X86_OPS_H
+#define __KVM_X86_VMX_X86_OPS_H
+
+#include <linux/kvm_host.h>
+
+#include <asm/virtext.h>
+
+#include "x86.h"
+
+__init int vmx_cpu_has_kvm_support(void);
+__init int vmx_disabled_by_bios(void);
+__init int vmx_hardware_setup(void);
+
+extern struct kvm_x86_ops vt_x86_ops __initdata;
+extern struct kvm_x86_init_ops vt_init_ops __initdata;
+
+void vmx_hardware_unsetup(void);
+int vmx_check_processor_compatibility(void);
+int vmx_hardware_enable(void);
+void vmx_hardware_disable(void);
+int vmx_vm_init(struct kvm *kvm);
+void vmx_vm_destroy(struct kvm *kvm);
+int vmx_vcpu_precreate(struct kvm *kvm);
+int vmx_vcpu_create(struct kvm_vcpu *vcpu);
+int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu);
+void vmx_vcpu_free(struct kvm_vcpu *vcpu);
+void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
+void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
+void vmx_vcpu_put(struct kvm_vcpu *vcpu);
+int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
+void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
+int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
+void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
+int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
+int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate);
+int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate);
+void vmx_enable_smi_window(struct kvm_vcpu *vcpu);
+bool vmx_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
+				void *insn, int insn_len);
+int vmx_check_intercept(struct kvm_vcpu *vcpu,
+			struct x86_instruction_info *info,
+			enum x86_intercept_stage stage,
+			struct x86_exception *exception);
+bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
+void vmx_migrate_timers(struct kvm_vcpu *vcpu);
+void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
+void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu);
+bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
+void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
+void vmx_hwapic_isr_update(int max_isr);
+bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu);
+int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
+void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
+			   int trig_mode, int vector);
+void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
+bool vmx_has_emulated_msr(struct kvm *kvm, u32 index);
+void vmx_msr_filter_changed(struct kvm_vcpu *vcpu);
+void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
+void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
+int vmx_get_msr_feature(struct kvm_msr_entry *msr);
+int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
+u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg);
+void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+int vmx_get_cpl(struct kvm_vcpu *vcpu);
+void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
+void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
+void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer);
+void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
+void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
+void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
+unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu);
+void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
+bool vmx_get_if_flag(struct kvm_vcpu *vcpu);
+void vmx_flush_tlb_all(struct kvm_vcpu *vcpu);
+void vmx_flush_tlb_current(struct kvm_vcpu *vcpu);
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr);
+void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu);
+void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
+u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
+void vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall);
+void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected);
+void vmx_inject_nmi(struct kvm_vcpu *vcpu);
+void vmx_queue_exception(struct kvm_vcpu *vcpu);
+void vmx_cancel_injection(struct kvm_vcpu *vcpu);
+int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
+void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
+void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
+void vmx_enable_irq_window(struct kvm_vcpu *vcpu);
+void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr);
+void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu);
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
+void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
+int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
+int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
+u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
+		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
+u64 vmx_get_l2_tsc_offset(struct kvm_vcpu *vcpu);
+u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
+void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset);
+void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier);
+void vmx_request_immediate_exit(struct kvm_vcpu *vcpu);
+void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu);
+void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
+#ifdef CONFIG_X86_64
+int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+		bool *expired);
+void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu);
+#endif
+void vmx_setup_mce(struct kvm_vcpu *vcpu);
+
+#endif /* __KVM_X86_VMX_X86_OPS_H */
-- 
2.25.1

