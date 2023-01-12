Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E809667B51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjALQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjALQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:37:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE713F6F;
        Thu, 12 Jan 2023 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541227; x=1705077227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AEWJVu/Iwm1dO5dI8gqi0yblA5HEY3pxKvgr6/LM8Y=;
  b=l7PY2tb4yW1wfag7SUcqL9DupSLXZorynAXec5Ogg1EKyAbttkt8ez9T
   G1Y3J2YFqRwkRRLRUop0Y4+9P4XUEM28e1ZEkdpudl4N24vVWD/GDcamy
   SdmYbPrGME7YAlxQM40hvQaTKfOI1y0Ysf/zvZ4otsPM4HsVaf1SRLcTy
   VzXfpT3r3+EN/SabrCDXzlP8Q9JU82KBaQoP8Y4NlxquDYS1uv6qVp+Un
   ccSHzWZa5737tcDVNvtWPEuCDMsMP/OjEg/EWyO7Db/j+mmPJJq/SDhn1
   JfMDspvX1DXiR3Vzqp1nfKKS1s4tQVa23Sv4YOZQO+O090ewT9maXITC/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323811642"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="323811642"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:33:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="721151616"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="721151616"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:33:19 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v11 001/113] KVM: VMX: Move out vmx_x86_ops to 'main.c' to wrap VMX and TDX
Date:   Thu, 12 Jan 2023 08:31:09 -0800
Message-Id: <ac61fec8dc7e01cb9e4e468f4881deb782755f92.1673539699.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673539699.git.isaku.yamahata@intel.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/x86/kvm/vmx/main.c    | 156 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 361 +++++++++++--------------------------
 arch/x86/kvm/vmx/x86_ops.h | 125 +++++++++++++
 4 files changed, 384 insertions(+), 260 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/main.c
 create mode 100644 arch/x86/kvm/vmx/x86_ops.h

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 80e3fe184d17..0e894ae23cbc 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -23,7 +23,7 @@ kvm-$(CONFIG_KVM_XEN)	+= xen.o
 kvm-$(CONFIG_KVM_SMM)	+= smm.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
-			   vmx/hyperv.o vmx/nested.o vmx/posted_intr.o
+			   vmx/hyperv.o vmx/nested.o vmx/posted_intr.o vmx/main.o
 kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
 
 kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
new file mode 100644
index 000000000000..a39d9d68b1b3
--- /dev/null
+++ b/arch/x86/kvm/vmx/main.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/moduleparam.h>
+
+#include "x86_ops.h"
+#include "vmx.h"
+#include "nested.h"
+#include "pmu.h"
+
+struct kvm_x86_ops vt_x86_ops __initdata = {
+	.name = KBUILD_MODNAME,
+
+	.check_processor_compatibility = vmx_check_processor_compat,
+
+	.hardware_unsetup = vmx_hardware_unsetup,
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
+	.inject_exception = vmx_inject_exception,
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
+#ifdef CONFIG_KVM_SMM
+	.smi_allowed = vmx_smi_allowed,
+	.enter_smm = vmx_enter_smm,
+	.leave_smm = vmx_leave_smm,
+	.enable_smi_window = vmx_enable_smi_window,
+#endif
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
+	.hardware_setup = vmx_hardware_setup,
+	.handle_intel_pt_intr = NULL,
+
+	.runtime_ops = &vt_x86_ops,
+	.pmu_ops = &intel_pmu_ops,
+};
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f290781394e7..63155166de45 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -66,6 +66,7 @@
 #include "vmcs12.h"
 #include "vmx.h"
 #include "x86.h"
+#include "x86_ops.h"
 #include "smm.h"
 
 MODULE_AUTHOR("Qumranet");
@@ -524,8 +525,6 @@ static inline void vmx_segment_cache_clear(struct vcpu_vmx *vmx)
 static unsigned long host_idt_base;
 
 #if IS_ENABLED(CONFIG_HYPERV)
-static struct kvm_x86_ops vmx_x86_ops __initdata;
-
 static bool __read_mostly enlightened_vmcs = true;
 module_param(enlightened_vmcs, bool, 0444);
 
@@ -583,9 +582,8 @@ static __init void hv_init_evmcs(void)
 		}
 
 		if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH)
-			vmx_x86_ops.enable_l2_tlb_flush
+			vt_x86_ops.enable_l2_tlb_flush
 				= hv_enable_l2_tlb_flush;
-
 	} else {
 		enlightened_vmcs = false;
 	}
@@ -1456,7 +1454,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
  */
-static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -1467,7 +1465,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
-static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
+void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	vmx_vcpu_pi_put(vcpu);
 
@@ -1521,7 +1519,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 		vmx->emulation_required = vmx_emulation_required(vcpu);
 }
 
-static bool vmx_get_if_flag(struct kvm_vcpu *vcpu)
+bool vmx_get_if_flag(struct kvm_vcpu *vcpu)
 {
 	return vmx_get_rflags(vcpu) & X86_EFLAGS_IF;
 }
@@ -1627,8 +1625,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	return 0;
 }
 
-static bool vmx_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
-					void *insn, int insn_len)
+bool vmx_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
+				void *insn, int insn_len)
 {
 	/*
 	 * Emulation of instructions in SGX enclaves is impossible as RIP does
@@ -1712,7 +1710,7 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
  * Recognizes a pending MTF VM-exit and records the nested state for later
  * delivery.
  */
-static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
+void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -1743,7 +1741,7 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 	}
 }
 
-static int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	vmx_update_emulated_instruction(vcpu);
 	return skip_emulated_instruction(vcpu);
@@ -1762,7 +1760,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
 
-static void vmx_inject_exception(struct kvm_vcpu *vcpu)
+void vmx_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
@@ -1883,12 +1881,12 @@ u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu)
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
@@ -1942,7 +1940,7 @@ static inline bool is_vmx_feature_control_msr_valid(struct vcpu_vmx *vmx,
 	return !(msr->data & ~valid_bits);
 }
 
-static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
+int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
@@ -1959,7 +1957,7 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_uret_msr *msr;
@@ -2138,7 +2136,7 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_uret_msr *msr;
@@ -2473,7 +2471,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return ret;
 }
 
-static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 	unsigned long guest_owned_bits;
 
@@ -2758,7 +2756,7 @@ static bool kvm_is_vmx_supported(void)
 	return true;
 }
 
-static int vmx_check_processor_compat(void)
+int vmx_check_processor_compat(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct vmcs_config vmcs_conf;
@@ -2800,7 +2798,7 @@ static int kvm_cpu_vmxon(u64 vmxon_pointer)
 	return -EFAULT;
 }
 
-static int vmx_hardware_enable(void)
+int vmx_hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
@@ -2841,7 +2839,7 @@ static void vmclear_local_loaded_vmcss(void)
 		__loaded_vmcs_clear(v);
 }
 
-static void vmx_hardware_disable(void)
+void vmx_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 
@@ -3153,7 +3151,7 @@ static void exit_lmode(struct kvm_vcpu *vcpu)
 
 #endif
 
-static void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3183,7 +3181,7 @@ static inline int vmx_get_current_vpid(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->vpid;
 }
 
-static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 root_hpa = mmu->root.hpa;
@@ -3199,7 +3197,7 @@ static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
 
-static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	/*
 	 * vpid_sync_vcpu_addr() is a nop if vpid==0, see the comment in
@@ -3208,7 +3206,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 	vpid_sync_vcpu_addr(vmx_get_current_vpid(vcpu), addr);
 }
 
-static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * vpid_sync_context() is a nop if vpid==0, e.g. if enable_vpid==0 or a
@@ -3363,8 +3361,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
 	return eptp;
 }
 
-static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
-			     int root_level)
+void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
 {
 	struct kvm *kvm = vcpu->kvm;
 	bool update_guest_cr3 = true;
@@ -3392,8 +3389,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
-
-static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	/*
 	 * We operate under the default treatment of SMM, so VMX cannot be
@@ -3509,7 +3505,7 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 	var->g = (ar >> 15) & 1;
 }
 
-static u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	struct kvm_segment s;
 
@@ -3589,14 +3585,14 @@ void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
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
 
@@ -3604,25 +3600,25 @@ static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
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
@@ -4120,7 +4116,7 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
+bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	void *vapic_page;
@@ -4140,7 +4136,7 @@ static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	return ((rvi & 0xf0) > (vppr & 0xf0));
 }
 
-static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
+void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 i;
@@ -4281,8 +4277,8 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	return 0;
 }
 
-static void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
-				  int trig_mode, int vector)
+void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
+			   int trig_mode, int vector)
 {
 	struct kvm_vcpu *vcpu = apic->vcpu;
 
@@ -4444,7 +4440,7 @@ static u32 vmx_vmexit_ctrl(void)
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4709,7 +4705,7 @@ static int vmx_alloc_ipiv_pid_table(struct kvm *kvm)
 	return 0;
 }
 
-static int vmx_vcpu_precreate(struct kvm *kvm)
+int vmx_vcpu_precreate(struct kvm *kvm)
 {
 	return vmx_alloc_ipiv_pid_table(kvm);
 }
@@ -4861,7 +4857,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	vmx->pi_desc.sn = 1;
 }
 
-static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -4920,12 +4916,12 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
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
@@ -4936,7 +4932,7 @@ static void vmx_enable_nmi_window(struct kvm_vcpu *vcpu)
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_NMI_WINDOW_EXITING);
 }
 
-static void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
+void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	uint32_t intr;
@@ -4964,7 +4960,7 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	vmx_clear_hlt(vcpu);
 }
 
-static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
+void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -5042,7 +5038,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 		 GUEST_INTR_STATE_NMI));
 }
 
-static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return -EBUSY;
@@ -5064,7 +5060,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
 
-static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return -EBUSY;
@@ -5079,7 +5075,7 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !vmx_interrupt_blocked(vcpu);
 }
 
-static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
+int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	void __user *ret;
 
@@ -5099,7 +5095,7 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 	return init_rmode_tss(kvm, ret);
 }
 
-static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 {
 	to_kvm_vmx(kvm)->ept_identity_map_addr = ident_addr;
 	return 0;
@@ -5380,8 +5376,7 @@ static int handle_io(struct kvm_vcpu *vcpu)
 	return kvm_fast_pio(vcpu, size, port, in);
 }
 
-static void
-vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
+void vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 {
 	/*
 	 * Patch in the VMCALL instruction:
@@ -5591,7 +5586,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	return kvm_complete_insn_gp(vcpu, err);
 }
 
-static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	get_debugreg(vcpu->arch.db[0], 0);
 	get_debugreg(vcpu->arch.db[1], 1);
@@ -5610,7 +5605,7 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
-static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
 }
@@ -5881,7 +5876,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
+int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	if (vmx_emulation_required_with_pending_exception(vcpu)) {
 		kvm_prepare_emulation_failure_exit(vcpu);
@@ -6145,9 +6140,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
-static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
-			      u64 *info1, u64 *info2,
-			      u32 *intr_info, u32 *error_code)
+void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
+		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6590,7 +6584,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	return 0;
 }
 
-static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
+int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 {
 	int ret = __vmx_handle_exit(vcpu, exit_fastpath);
 
@@ -6678,7 +6672,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		: "eax", "ebx", "ecx", "edx");
 }
 
-static void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
@@ -6748,7 +6742,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
 	vmx_update_msr_bitmap_x2apic(vcpu);
 }
 
-static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
+void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 {
 	struct page *page;
 
@@ -6776,7 +6770,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(int max_isr)
+void vmx_hwapic_isr_update(int max_isr)
 {
 	u16 status;
 	u8 old;
@@ -6810,7 +6804,7 @@ static void vmx_set_rvi(int vector)
 	}
 }
 
-static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
+void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 {
 	/*
 	 * When running L2, updating RVI is only relevant when
@@ -6824,7 +6818,7 @@ static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 		vmx_set_rvi(max_irr);
 }
 
-static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
+int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -6870,7 +6864,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	return max_irr;
 }
 
-static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
@@ -6881,7 +6875,7 @@ static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
+void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6954,7 +6948,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6971,7 +6965,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
  */
-static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
+bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 {
 	switch (index) {
 	case MSR_IA32_SMBASE:
@@ -7094,7 +7088,7 @@ static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 				  IDT_VECTORING_ERROR_CODE);
 }
 
-static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
+void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
@@ -7228,7 +7222,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
@@ -7394,7 +7388,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	return vmx_exit_handlers_fastpath(vcpu);
 }
 
-static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
+void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7405,7 +7399,7 @@ static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	free_loaded_vmcs(vmx->loaded_vmcs);
 }
 
-static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
+int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vmx_uret_msr *tsx_ctrl;
 	struct vcpu_vmx *vmx;
@@ -7514,7 +7508,7 @@ static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
-static int vmx_vm_init(struct kvm *kvm)
+int vmx_vm_init(struct kvm *kvm)
 {
 	if (!ple_gap)
 		kvm->arch.pause_in_guest = true;
@@ -7545,7 +7539,7 @@ static int vmx_vm_init(struct kvm *kvm)
 	return 0;
 }
 
-static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
+u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	u8 cache;
 
@@ -7717,7 +7711,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
-static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7853,7 +7847,7 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
+void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->req_immediate_exit = true;
 }
@@ -7892,10 +7886,10 @@ static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
 	return intercept ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE;
 }
 
-static int vmx_check_intercept(struct kvm_vcpu *vcpu,
-			       struct x86_instruction_info *info,
-			       enum x86_intercept_stage stage,
-			       struct x86_exception *exception)
+int vmx_check_intercept(struct kvm_vcpu *vcpu,
+			struct x86_instruction_info *info,
+			enum x86_intercept_stage stage,
+			struct x86_exception *exception)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
@@ -7960,8 +7954,8 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
-static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
-			    bool *expired)
+int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+		     bool *expired)
 {
 	struct vcpu_vmx *vmx;
 	u64 tscl, guest_tscl, delta_tsc, lapic_timer_advance_cycles;
@@ -8000,13 +7994,13 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
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
@@ -8032,7 +8026,7 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
 }
 
-static void vmx_setup_mce(struct kvm_vcpu *vcpu)
+void vmx_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
@@ -8043,7 +8037,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_SMM
-static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
+int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
 	if (to_vmx(vcpu)->nested.nested_run_pending)
@@ -8051,7 +8045,7 @@ static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !is_smm(vcpu);
 }
 
-static int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
+int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -8072,7 +8066,7 @@ static int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	return 0;
 }
 
-static int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
+int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int ret;
@@ -8093,18 +8087,18 @@ static int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	return 0;
 }
 
-static void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
+void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	/* RSM will cause a vmexit anyway.  */
 }
 #endif
 
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
@@ -8114,7 +8108,7 @@ static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void vmx_hardware_unsetup(void)
+void vmx_hardware_unsetup(void)
 {
 	kvm_set_posted_intr_wakeup_handler(NULL);
 
@@ -8124,7 +8118,7 @@ static void vmx_hardware_unsetup(void)
 	free_kvm_area();
 }
 
-static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
+bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 {
 	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
 			  BIT(APICV_INHIBIT_REASON_ABSENT) |
@@ -8136,154 +8130,13 @@ static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 	return supported & BIT(reason);
 }
 
-static void vmx_vm_destroy(struct kvm *kvm)
+void vmx_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
 
 	free_pages((unsigned long)kvm_vmx->pid_table, vmx_get_pid_table_order(kvm));
 }
 
-static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.name = KBUILD_MODNAME,
-
-	.check_processor_compatibility = vmx_check_processor_compat,
-
-	.hardware_unsetup = vmx_hardware_unsetup,
-
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
-	.inject_exception = vmx_inject_exception,
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
-#ifdef CONFIG_KVM_SMM
-	.smi_allowed = vmx_smi_allowed,
-	.enter_smm = vmx_enter_smm,
-	.leave_smm = vmx_leave_smm,
-	.enable_smi_window = vmx_enable_smi_window,
-#endif
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
@@ -8349,9 +8202,7 @@ static void __init vmx_setup_me_spte_mask(void)
 	kvm_mmu_set_me_spte_mask(0, me_mask);
 }
 
-static struct kvm_x86_init_ops vmx_init_ops __initdata;
-
-static __init int hardware_setup(void)
+__init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
 	struct desc_ptr dt;
@@ -8420,16 +8271,16 @@ static __init int hardware_setup(void)
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
@@ -8445,7 +8296,7 @@ static __init int hardware_setup(void)
 	if (!cpu_has_vmx_apicv())
 		enable_apicv = 0;
 	if (!enable_apicv)
-		vmx_x86_ops.sync_pir_to_irr = NULL;
+		vt_x86_ops.sync_pir_to_irr = NULL;
 
 	if (!enable_apicv || !cpu_has_vmx_ipiv())
 		enable_ipiv = false;
@@ -8481,7 +8332,7 @@ static __init int hardware_setup(void)
 		enable_pml = 0;
 
 	if (!enable_pml)
-		vmx_x86_ops.cpu_dirty_log_size = 0;
+		vt_x86_ops.cpu_dirty_log_size = 0;
 
 	if (!cpu_has_vmx_preemption_timer())
 		enable_preemption_timer = false;
@@ -8506,9 +8357,9 @@ static __init int hardware_setup(void)
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
@@ -8519,9 +8370,9 @@ static __init int hardware_setup(void)
 	if (!enable_ept || !enable_pmu || !cpu_has_vmx_intel_pt())
 		pt_mode = PT_MODE_SYSTEM;
 	if (pt_mode == PT_MODE_HOST_GUEST)
-		vmx_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
+		vt_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
 	else
-		vmx_init_ops.handle_intel_pt_intr = NULL;
+		vt_init_ops.handle_intel_pt_intr = NULL;
 
 	setup_default_sgx_lepubkeyhash();
 
@@ -8544,14 +8395,6 @@ static __init int hardware_setup(void)
 	return r;
 }
 
-static struct kvm_x86_init_ops vmx_init_ops __initdata = {
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
@@ -8595,7 +8438,7 @@ static int __init vmx_init(void)
 	 */
 	hv_init_evmcs();
 
-	r = kvm_x86_vendor_init(&vmx_init_ops);
+	r = kvm_x86_vendor_init(&vt_init_ops);
 	if (r)
 		return r;
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
new file mode 100644
index 000000000000..e9ec4d259ff5
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
+__init int vmx_hardware_setup(void);
+
+extern struct kvm_x86_ops vt_x86_ops __initdata;
+extern struct kvm_x86_init_ops vt_init_ops __initdata;
+
+void vmx_hardware_unsetup(void);
+int vmx_check_processor_compat(void);
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
+#ifdef CONFIG_KVM_SMM
+int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
+int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram);
+int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram);
+void vmx_enable_smi_window(struct kvm_vcpu *vcpu);
+#endif
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
+void vmx_inject_exception(struct kvm_vcpu *vcpu);
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

