Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771ED71433B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjE2Ed0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjE2E24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:28:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38461981;
        Sun, 28 May 2023 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685334312; x=1716870312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqBgC9NM6Z//C76xo4DRIyJb57ivFogonpbFVlM/l9k=;
  b=I+28HrP0l5T97CWSMNX5DFXFdfJqr+8BjiwuXh2e54mG03ED1JCUVmGa
   eM/9E4UCACZjpTsAvftGtDnjmY54+1e3byZjWWviN2axgAZfvBBeD5Bsq
   PJIDDKK0LQKPzfC1IR5FpXw8aS/CtWJwDGcOxA0s8HPR0XZeNluOY03s0
   lnT/3JBo9Ni43xaXx12wNMOnRNeB5V4JIpHm9DhexhBQ4i50RmA4Q7Kzw
   Ihuc3Ddqrb1cdwwKIO0rgVVrhKJmbnqrYVwYCgO/ntxO4GqE3BwmkZyly
   EQPd/7pRN3YECHkG7FbU6dCG9AtPRhmWpt08zOKYN280m7omotRvhOb0I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="356993503"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="356993503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 21:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="830223530"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="830223530"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 21:21:47 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v14 101/113] KVM: TDX: Add methods to ignore accesses to CPU state
Date:   Sun, 28 May 2023 21:20:23 -0700
Message-Id: <ccadf987de38c0839b255d94aa9151d54b7f3be8.1685333728.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685333727.git.isaku.yamahata@intel.com>
References: <cover.1685333727.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

TDX protects TDX guest state from VMM.  Implement access methods for TDX
guest state to ignore them or return zero.  Because those methods can be
called by kvm ioctls to set/get cpu registers, they don't have KVM_BUG_ON
except one method.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c    | 269 +++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/tdx.c     |  49 ++++++-
 arch/x86/kvm/vmx/x86_ops.h |  13 ++
 3 files changed, 304 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index c8ee8c89c02b..3af0830999cb 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -386,6 +386,184 @@ static void vt_vcpu_deliver_init(struct kvm_vcpu *vcpu)
 	kvm_vcpu_deliver_init(vcpu);
 }
 
+static void vt_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_vcpu_after_set_cpuid(vcpu);
+}
+
+static void vt_update_exception_bitmap(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_update_exception_bitmap(vcpu);
+}
+
+static u64 vt_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	if (is_td_vcpu(vcpu))
+		return tdx_get_segment_base(vcpu, seg);
+
+	return vmx_get_segment_base(vcpu, seg);
+}
+
+static void vt_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			      int seg)
+{
+	if (is_td_vcpu(vcpu)) {
+		tdx_get_segment(vcpu, var, seg);
+		return;
+	}
+
+	vmx_get_segment(vcpu, var, seg);
+}
+
+static void vt_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+			      int seg)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_segment(vcpu, var, seg);
+}
+
+static int vt_get_cpl(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return tdx_get_cpl(vcpu);
+
+	return vmx_get_cpl(vcpu);
+}
+
+static void vt_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
+{
+	if (is_td_vcpu(vcpu)) {
+		*db = 0;
+		*l = 0;
+		return;
+	}
+
+	vmx_get_cs_db_l_bits(vcpu, db, l);
+}
+
+static void vt_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_cr0(vcpu, cr0);
+}
+
+static void vt_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_cr4(vcpu, cr4);
+}
+
+static int vt_set_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	if (is_td_vcpu(vcpu))
+		return 0;
+
+	return vmx_set_efer(vcpu, efer);
+}
+
+static void vt_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+{
+	if (is_td_vcpu(vcpu)) {
+		memset(dt, 0, sizeof(*dt));
+		return;
+	}
+
+	vmx_get_idt(vcpu, dt);
+}
+
+static void vt_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_idt(vcpu, dt);
+}
+
+static void vt_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+{
+	if (is_td_vcpu(vcpu)) {
+		memset(dt, 0, sizeof(*dt));
+		return;
+	}
+
+	vmx_get_gdt(vcpu, dt);
+}
+
+static void vt_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_gdt(vcpu, dt);
+}
+
+static void vt_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_dr7(vcpu, val);
+}
+
+static void vt_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * MOV-DR exiting is always cleared for TD guest, even in debug mode.
+	 * Thus KVM_DEBUGREG_WONT_EXIT can never be set and it should never
+	 * reach here for TD vcpu.
+	 */
+	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
+		return;
+
+	vmx_sync_dirty_debug_regs(vcpu);
+}
+
+static void vt_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+{
+	if (is_td_vcpu(vcpu)) {
+		tdx_cache_reg(vcpu, reg);
+		return;
+	}
+
+	vmx_cache_reg(vcpu, reg);
+}
+
+static unsigned long vt_get_rflags(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return tdx_get_rflags(vcpu);
+
+	return vmx_get_rflags(vcpu);
+}
+
+static void vt_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_set_rflags(vcpu, rflags);
+}
+
+static bool vt_get_if_flag(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return false;
+
+	return vmx_get_if_flag(vcpu);
+}
+
 static void vt_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu)) {
@@ -530,6 +708,14 @@ static void vt_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	vmx_inject_irq(vcpu, reinjected);
 }
 
+static void vt_inject_exception(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_inject_exception(vcpu);
+}
+
 static void vt_cancel_injection(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu))
@@ -576,6 +762,39 @@ static void vt_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	vmx_get_exit_info(vcpu, reason, info1, info2, intr_info, error_code);
 }
 
+
+static void vt_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_update_cr8_intercept(vcpu, tpr, irr);
+}
+
+static void vt_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_load_eoi_exitmap(vcpu, eoi_exit_bitmap);
+}
+
+static int vt_set_tss_addr(struct kvm *kvm, unsigned int addr)
+{
+	if (is_td(kvm))
+		return 0;
+
+	return vmx_set_tss_addr(kvm, addr);
+}
+
+static int vt_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
+{
+	if (is_td(kvm))
+		return 0;
+
+	return vmx_set_identity_map_addr(kvm, ident_addr);
+}
+
 static u8 vt_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	if (is_td_vcpu(vcpu))
@@ -641,29 +860,29 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.vcpu_load = vt_vcpu_load,
 	.vcpu_put = vt_vcpu_put,
 
-	.update_exception_bitmap = vmx_update_exception_bitmap,
+	.update_exception_bitmap = vt_update_exception_bitmap,
 	.get_msr_feature = vmx_get_msr_feature,
 	.get_msr = vt_get_msr,
 	.set_msr = vt_set_msr,
-	.get_segment_base = vmx_get_segment_base,
-	.get_segment = vmx_get_segment,
-	.set_segment = vmx_set_segment,
-	.get_cpl = vmx_get_cpl,
-	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
-	.set_cr0 = vmx_set_cr0,
+	.get_segment_base = vt_get_segment_base,
+	.get_segment = vt_get_segment,
+	.set_segment = vt_set_segment,
+	.get_cpl = vt_get_cpl,
+	.get_cs_db_l_bits = vt_get_cs_db_l_bits,
+	.set_cr0 = vt_set_cr0,
 	.is_valid_cr4 = vmx_is_valid_cr4,
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
+	.set_cr4 = vt_set_cr4,
+	.set_efer = vt_set_efer,
+	.get_idt = vt_get_idt,
+	.set_idt = vt_set_idt,
+	.get_gdt = vt_get_gdt,
+	.set_gdt = vt_set_gdt,
+	.set_dr7 = vt_set_dr7,
+	.sync_dirty_debug_regs = vt_sync_dirty_debug_regs,
+	.cache_reg = vt_cache_reg,
+	.get_rflags = vt_get_rflags,
+	.set_rflags = vt_set_rflags,
+	.get_if_flag = vt_get_if_flag,
 
 	.flush_tlb_all = vt_flush_tlb_all,
 	.flush_tlb_current = vt_flush_tlb_current,
@@ -680,7 +899,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.patch_hypercall = vmx_patch_hypercall,
 	.inject_irq = vt_inject_irq,
 	.inject_nmi = vt_inject_nmi,
-	.inject_exception = vmx_inject_exception,
+	.inject_exception = vt_inject_exception,
 	.cancel_injection = vt_cancel_injection,
 	.interrupt_allowed = vt_interrupt_allowed,
 	.nmi_allowed = vt_nmi_allowed,
@@ -688,11 +907,11 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_nmi_mask = vt_set_nmi_mask,
 	.enable_nmi_window = vt_enable_nmi_window,
 	.enable_irq_window = vt_enable_irq_window,
-	.update_cr8_intercept = vmx_update_cr8_intercept,
+	.update_cr8_intercept = vt_update_cr8_intercept,
 	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
 	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
-	.load_eoi_exitmap = vmx_load_eoi_exitmap,
+	.load_eoi_exitmap = vt_load_eoi_exitmap,
 	.apicv_post_state_restore = vt_apicv_post_state_restore,
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
@@ -703,13 +922,13 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
 	.protected_apic_has_interrupt = vt_protected_apic_has_interrupt,
 
-	.set_tss_addr = vmx_set_tss_addr,
-	.set_identity_map_addr = vmx_set_identity_map_addr,
+	.set_tss_addr = vt_set_tss_addr,
+	.set_identity_map_addr = vt_set_identity_map_addr,
 	.get_mt_mask = vt_get_mt_mask,
 
 	.get_exit_info = vt_get_exit_info,
 
-	.vcpu_after_set_cpuid = vmx_vcpu_after_set_cpuid,
+	.vcpu_after_set_cpuid = vt_vcpu_after_set_cpuid,
 
 	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3b9e4a9bbb69..a3cca903154f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3,6 +3,7 @@
 #include <linux/mmu_context.h>
 
 #include <asm/fpu/xcr.h>
+#include <asm/virtext.h>
 #include <asm/tdx.h>
 
 #include "capabilities.h"
@@ -588,8 +589,15 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.tsc_offset = to_kvm_tdx(vcpu->kvm)->tsc_offset;
 	vcpu->arch.l1_tsc_offset = vcpu->arch.tsc_offset;
-	vcpu->arch.guest_state_protected =
-		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_TD_ATTRIBUTE_DEBUG);
+	/*
+	 * TODO: support off-TD debug.  If TD DEBUG is enabled, guest state
+	 * can be accessed. guest_state_protected = false. and kvm ioctl to
+	 * access CPU states should be usable for user space VMM (e.g. qemu).
+	 *
+	 * vcpu->arch.guest_state_protected =
+	 *	!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_TD_ATTRIBUTE_DEBUG);
+	 */
+	vcpu->arch.guest_state_protected = true;
 
 	tdx->pi_desc.nv = POSTED_INTR_VECTOR;
 	tdx->pi_desc.sn = 1;
@@ -1885,6 +1893,43 @@ void tdx_enable_smi_window(struct kvm_vcpu *vcpu)
 }
 #endif
 
+int tdx_get_cpl(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+void tdx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+{
+	kvm_register_mark_available(vcpu, reg);
+	switch (reg) {
+	case VCPU_REGS_RSP:
+	case VCPU_REGS_RIP:
+	case VCPU_EXREG_PDPTR:
+	case VCPU_EXREG_CR0:
+	case VCPU_EXREG_CR3:
+	case VCPU_EXREG_CR4:
+		break;
+	default:
+		KVM_BUG_ON(1, vcpu->kvm);
+		break;
+	}
+}
+
+unsigned long tdx_get_rflags(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+u64 tdx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	return 0;
+}
+
+void tdx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+{
+	memset(var, 0, sizeof(*var));
+}
+
 static int tdx_get_capabilities(struct kvm_tdx_cmd *cmd)
 {
 	struct kvm_tdx_capabilities __user *user_caps;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 38a7a0075450..0c39fc4484a1 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -170,6 +170,12 @@ bool tdx_has_emulated_msr(u32 index, bool write);
 int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
+int tdx_get_cpl(struct kvm_vcpu *vcpu);
+void tdx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
+unsigned long tdx_get_rflags(struct kvm_vcpu *vcpu);
+u64 tdx_get_segment_base(struct kvm_vcpu *vcpu, int seg);
+void tdx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+
 int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
 
 void tdx_flush_tlb(struct kvm_vcpu *vcpu);
@@ -211,6 +217,13 @@ static inline bool tdx_has_emulated_msr(u32 index, bool write) { return false; }
 static inline int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
 static inline int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
 
+static inline int tdx_get_cpl(struct kvm_vcpu *vcpu) { return 0; }
+static inline void tdx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg) {}
+static inline unsigned long tdx_get_rflags(struct kvm_vcpu *vcpu) { return 0; }
+static inline u64 tdx_get_segment_base(struct kvm_vcpu *vcpu, int seg) { return 0; }
+static inline void tdx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
+				   int seg) {}
+
 static inline int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -EOPNOTSUPP; }
 
 static inline void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
-- 
2.25.1

