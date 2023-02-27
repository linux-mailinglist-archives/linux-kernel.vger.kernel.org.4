Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377F26A3D42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjB0IcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjB0IaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:30:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9420D17;
        Mon, 27 Feb 2023 00:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677486406; x=1709022406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k3XPggnyg2n9vKHJ0JnG/eTGBBymuu01VfK1Uypk4M=;
  b=fEDngeiE9o+r2omx/ImmtaP5RBSVZX2AtKNL6zamdmJxBVcF/qjVmoaV
   FcXnIsqAo3B7cQJJHnQOlgfXnU3N9tnuXV31XwZPP1sEA+rgrJaOu3XT/
   LiiExFbiBOQV0QpD9HCDqBMpO7vQvvUY0Wn2W+ijVaW5OcdWED6RDMVXy
   /kCUc3lG8iuw7wDPN7/8gFnDgfw0MKtWO0UOjbcPwFw1o9ukwvlBabn3G
   kYvo9kZCcPam+kGIhk8jZ/wG9sLo8jj2+NNb2vJAU9IBDRsoE2qhTTlnn
   C+oniyD7m0u2amj/+chQKPiRkLDfHt1pZiO4H05WTK50GVeGD91X86lZ0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="317609086"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="317609086"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 00:24:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="783242429"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="783242429"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 00:24:20 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v12 095/106] KVM: TDX: Add methods to ignore accesses to CPU state
Date:   Mon, 27 Feb 2023 00:23:34 -0800
Message-Id: <647bd3aa177eeef5c3c9a59d2547c4af29af561a.1677484918.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677484918.git.isaku.yamahata@intel.com>
References: <cover.1677484918.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 507a4b433ad0..4296e1e729b7 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -365,6 +365,184 @@ static void vt_vcpu_deliver_init(struct kvm_vcpu *vcpu)
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
@@ -509,6 +687,14 @@ static void vt_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
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
@@ -555,6 +741,39 @@ static void vt_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
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
@@ -620,29 +839,29 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
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
@@ -659,7 +878,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.patch_hypercall = vmx_patch_hypercall,
 	.inject_irq = vt_inject_irq,
 	.inject_nmi = vt_inject_nmi,
-	.inject_exception = vmx_inject_exception,
+	.inject_exception = vt_inject_exception,
 	.cancel_injection = vt_cancel_injection,
 	.interrupt_allowed = vt_interrupt_allowed,
 	.nmi_allowed = vt_nmi_allowed,
@@ -667,11 +886,11 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
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
@@ -682,13 +901,13 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
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
index 6df79f3659b3..6784cbf08cc4 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3,6 +3,7 @@
 #include <linux/mmu_context.h>
 
 #include <asm/fpu/xcr.h>
+#include <asm/virtext.h>
 #include <asm/tdx.h>
 
 #include "capabilities.h"
@@ -593,8 +594,15 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 
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
@@ -1891,6 +1899,43 @@ void tdx_enable_smi_window(struct kvm_vcpu *vcpu)
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
 int tdx_dev_ioctl(void __user *argp)
 {
 	struct kvm_tdx_capabilities __user *user_caps;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 242fcd043d0a..553f2b3880b6 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -175,6 +175,12 @@ bool tdx_has_emulated_msr(u32 index, bool write);
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
@@ -219,6 +225,13 @@ static inline bool tdx_has_emulated_msr(u32 index, bool write) { return false; }
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

