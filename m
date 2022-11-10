Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47128623C02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiKJGjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiKJGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:39:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D929C91;
        Wed,  9 Nov 2022 22:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668062365; x=1699598365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btiN7wu6yHcG/APG6+UAvWqTkcuTq8Wkw/RVvQEA/KE=;
  b=mvX29KLy9FNUMZR0QAAovu0ewzLmk7icUNe6s+BnBxgsQv3C17sjLuyk
   GCHFipgl8S2tfxDt6wSW1BBd2ZY+zBAK7qs9yLN0cklsUPweDVuhZuOnL
   WJm2J+KbsIFkkGFQMmQ1TLIkNHvsMF4MoEBo7MuhPbcRWmPD8nRpselqx
   Tq42fJNnNCKEnuJ92PUX8khKikxscx3UNk2BUAwvlFlQL/60o9n7+fpzt
   hj4wWflQu8fUKnZigFJQ3/xwg177bOJq10kwR0ChC3GnM0WCvS3J+P8aT
   LFF7q9pVncN2R8C1w3mvrTWmFP6G3vo+rdaU0KLmPN2ilEr9Ai9E46GKt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="375474019"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="375474019"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 22:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="588057245"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="588057245"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2022 22:39:22 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, kevin.tian@intel.com
Subject: [RESEND PATCH 5/6] KVM: x86/VMX: add kvm_vmx_reinject_nmi_irq() for NMI/IRQ reinjection
Date:   Wed,  9 Nov 2022 22:15:44 -0800
Message-Id: <20221110061545.1531-6-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110061545.1531-1-xin3.li@intel.com>
References: <20221110061545.1531-1-xin3.li@intel.com>
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

To eliminate dispatching NMI/IRQ through the IDT, add
kvm_vmx_reinject_nmi_irq(), which calls external_interrupt()
for IRQ reinjection.

Lastly replace calling a NMI/IRQ handler in an IDT descriptor
with calling kvm_vmx_reinject_nmi_irq().

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/traps.h |  2 ++
 arch/x86/kernel/traps.c      | 23 +++++++++++++++++++++++
 arch/x86/kvm/vmx/vmenter.S   | 33 ---------------------------------
 arch/x86/kvm/vmx/vmx.c       | 19 +++++++------------
 4 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 89c4233e19db..4c56a8d31762 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -57,4 +57,6 @@ void __noreturn handle_stack_overflow(struct pt_regs *regs,
 		unsigned long vector __maybe_unused)
 typedef DECLARE_SYSTEM_INTERRUPT_HANDLER((*system_interrupt_handler));
 
+void kvm_vmx_reinject_nmi_irq(u32 vector);
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c1eb3bd335ce..9abf91534b13 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1528,6 +1528,29 @@ __visible noinstr void external_interrupt(struct pt_regs *regs,
 	common_interrupt(regs, vector);
 }
 
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+/*
+ * KVM VMX reinjects NMI/IRQ on its current stack, it's a sync
+ * call thus the values in the pt_regs structure are not used in
+ * executing NMI/IRQ handlers, except cs.RPL and flags.IF, which
+ * are both always 0 in the VMX NMI/IRQ reinjection context. Thus
+ * we simply allocate a zeroed pt_regs structure on current stack
+ * to call external_interrupt().
+ */
+void kvm_vmx_reinject_nmi_irq(u32 vector)
+{
+	struct pt_regs irq_regs;
+
+	memset(&irq_regs, 0, sizeof(irq_regs));
+
+	if (vector == NMI_VECTOR)
+		return exc_nmi(&irq_regs);
+
+	external_interrupt(&irq_regs, vector);
+}
+EXPORT_SYMBOL_GPL(kvm_vmx_reinject_nmi_irq);
+#endif
+
 void __init trap_init(void)
 {
 	/* Init cpu_entry_area before IST entries are set up */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 8477d8bdd69c..0c1608b329cd 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -317,36 +317,3 @@ SYM_FUNC_START(vmread_error_trampoline)
 
 	RET
 SYM_FUNC_END(vmread_error_trampoline)
-
-SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
-	/*
-	 * Unconditionally create a stack frame, getting the correct RSP on the
-	 * stack (for x86-64) would take two instructions anyways, and RBP can
-	 * be used to restore RSP to make objtool happy (see below).
-	 */
-	push %_ASM_BP
-	mov %_ASM_SP, %_ASM_BP
-
-#ifdef CONFIG_X86_64
-	/*
-	 * Align RSP to a 16-byte boundary (to emulate CPU behavior) before
-	 * creating the synthetic interrupt stack frame for the IRQ/NMI.
-	 */
-	and  $-16, %rsp
-	push $__KERNEL_DS
-	push %rbp
-#endif
-	pushf
-	push $__KERNEL_CS
-	CALL_NOSPEC _ASM_ARG1
-
-	/*
-	 * "Restore" RSP from RBP, even though IRET has already unwound RSP to
-	 * the correct value.  objtool doesn't know the callee will IRET and,
-	 * without the explicit restore, thinks the stack is getting walloped.
-	 * Using an unwind hint is problematic due to x86-64's dynamic alignment.
-	 */
-	mov %_ASM_BP, %_ASM_SP
-	pop %_ASM_BP
-	RET
-SYM_FUNC_END(vmx_do_interrupt_nmi_irqoff)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 63247c57c72c..b457e4888468 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -46,6 +46,7 @@
 #include <asm/mshyperv.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/traps.h>
 #include <asm/virtext.h>
 #include <asm/vmx.h>
 
@@ -6758,15 +6759,11 @@ static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 	memset(vmx->pi_desc.pir, 0, sizeof(vmx->pi_desc.pir));
 }
 
-void vmx_do_interrupt_nmi_irqoff(unsigned long entry);
-
-static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu,
-					unsigned long entry)
+static void handle_interrupt_nmi_irqoff(struct kvm_vcpu *vcpu, u32 vector)
 {
-	bool is_nmi = entry == (unsigned long)asm_exc_nmi_noist;
-
-	kvm_before_interrupt(vcpu, is_nmi ? KVM_HANDLING_NMI : KVM_HANDLING_IRQ);
-	vmx_do_interrupt_nmi_irqoff(entry);
+	kvm_before_interrupt(vcpu, vector == NMI_VECTOR ?
+				   KVM_HANDLING_NMI : KVM_HANDLING_IRQ);
+	kvm_vmx_reinject_nmi_irq(vector);
 	kvm_after_interrupt(vcpu);
 }
 
@@ -6792,7 +6789,6 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 
 static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 {
-	const unsigned long nmi_entry = (unsigned long)asm_exc_nmi_noist;
 	u32 intr_info = vmx_get_intr_info(&vmx->vcpu);
 
 	/* if exit due to PF check for async PF */
@@ -6806,20 +6802,19 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 		kvm_machine_check();
 	/* We need to handle NMIs before interrupts are enabled */
 	else if (is_nmi(intr_info))
-		handle_interrupt_nmi_irqoff(&vmx->vcpu, nmi_entry);
+		handle_interrupt_nmi_irqoff(&vmx->vcpu, NMI_VECTOR);
 }
 
 static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 {
 	u32 intr_info = vmx_get_intr_info(vcpu);
 	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
-	gate_desc *desc = (gate_desc *)host_idt_base + vector;
 
 	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
 	    "KVM: unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
 
-	handle_interrupt_nmi_irqoff(vcpu, gate_offset(desc));
+	handle_interrupt_nmi_irqoff(vcpu, vector);
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-- 
2.34.1

