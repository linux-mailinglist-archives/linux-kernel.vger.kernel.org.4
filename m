Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224EC65F8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjAFBQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjAFBP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:15:57 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFEA3E84E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:07 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 84-20020a630257000000b00477f88d334eso206611pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cR/0ceEXEHjIeOFsd1KOHfCSQeyMtOUPjLT+49U/bNY=;
        b=KUx3F3fVD+glWOuqkHgxHp63h2M/R8XvEJtJC5/Er2iHJUSIKfZVgKor5axiG7oSmw
         M59DpMcb/+ssrKmnfGF5Jt6CxdEKCndq8qtx1NhNMNCMjzQKepuUMtTfaZBCg3OEronK
         lOY42an0Tv2CMbi8cYn8EFFoWA5vPA91dizfRYNVWltzCtKEXt26bOV+CMagEXGPaOzy
         J3fQgQDdPqNnHFtgTm4BwdgvlkV8QCSGzJB8sunc072rV+JDbBb5U3JE2f9LeH0rOmxo
         1GlM0OFV/jKGjOSTwr6jwgXbFAfAOxwFLb0x8934veHGjFRcsALCV/53gVuhAPRD9paf
         slew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cR/0ceEXEHjIeOFsd1KOHfCSQeyMtOUPjLT+49U/bNY=;
        b=E41XREJjjbJjQf8S7zFLbeALtYnJKrkE3UGC0Byw1MUy+ME9I046NMkV8CFn7RjXFH
         Jw+P4pVU2JvnaWbWXriSevXz/4yH+n5f+CmcsaBCr1tbi1sYW7C/j+lQJ5ExpZ44RnDI
         nZk9YztJuxkdoZ6u19mTKwin+6VyFNYm8Dxo5R6I0WaA0H4jzi8KNh9JkS2iPujH75CU
         pECYHgGHdWIPY9PesI238IyLN+jb4nkdy3sMkxaSSAfDCAjo9FCahGKg26U2Y5JJpvry
         XoIQO4LUCBiFqL7gIm5bHBDUWeOnY+8ibVJTIB64TdQ9t5FcCl7q/phQFk7qdIcVLDY8
         I9FQ==
X-Gm-Message-State: AFqh2kqLO7JKXaLAJ36YVwmUuA+O2hu6AdoWQXqIKe3Pl+TLEZV3oGBj
        tLXFNUxmDLFqQkUlpem3cwiu+kth8ic=
X-Google-Smtp-Source: AMrXdXsMeqYHFOOm4KjIKdYw33J4rXlNA7UURqx3sznCGLpwh8MvZvv3xaXUSCoMvXX7nx9SylHuuwEkNyM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9a5d:0:b0:580:984e:6e3f with SMTP id
 x29-20020aa79a5d000000b00580984e6e3fmr3666194pfj.66.1672967646823; Thu, 05
 Jan 2023 17:14:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:13:04 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-32-seanjc@google.com>
Subject: [PATCH v5 31/33] KVM: x86: Track required APICv inhibits with
 variable, not callback
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the per-vendor required APICv inhibits with a variable instead of
calling into vendor code every time KVM wants to query the set of
required inhibits.  The required inhibits are a property of the vendor's
virtualization architecture, i.e. are 100% static.

Using a variable allows the compiler to inline the check, e.g. generate
a single-uop TEST+Jcc, and thus eliminates any desire to avoid checking
inhibits for performance reasons.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/avic.c            | 19 -------------------
 arch/x86/kvm/svm/svm.c             |  2 +-
 arch/x86/kvm/svm/svm.h             | 16 +++++++++++++++-
 arch/x86/kvm/vmx/vmx.c             | 24 +++++++++++-------------
 arch/x86/kvm/x86.c                 |  2 +-
 7 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index abccd51dcfca..84f43caef9b7 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -76,7 +76,6 @@ KVM_X86_OP(set_nmi_mask)
 KVM_X86_OP(enable_nmi_window)
 KVM_X86_OP(enable_irq_window)
 KVM_X86_OP_OPTIONAL(update_cr8_intercept)
-KVM_X86_OP(check_apicv_inhibit_reasons)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b41a01b3a4af..7ca854714ccd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1623,6 +1623,7 @@ struct kvm_x86_ops {
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
 	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
+	const unsigned long required_apicv_inhibits;
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 80f346b79c62..14677bc31b83 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -963,25 +963,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 	return ret;
 }
 
-bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
-{
-	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
-			  BIT(APICV_INHIBIT_REASON_ABSENT) |
-			  BIT(APICV_INHIBIT_REASON_HYPERV) |
-			  BIT(APICV_INHIBIT_REASON_NESTED) |
-			  BIT(APICV_INHIBIT_REASON_IRQWIN) |
-			  BIT(APICV_INHIBIT_REASON_PIT_REINJ) |
-			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |
-			  BIT(APICV_INHIBIT_REASON_SEV)      |
-			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
-			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
-
-	return supported & BIT(reason);
-}
-
-
 static inline int
 avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9f172f2de195..f2453df77727 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4773,8 +4773,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.update_cr8_intercept = svm_update_cr8_intercept,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
 	.refresh_apicv_exec_ctrl = avic_refresh_apicv_exec_ctrl,
-	.check_apicv_inhibit_reasons = avic_check_apicv_inhibit_reasons,
 	.apicv_post_state_restore = avic_apicv_post_state_restore,
+	.required_apicv_inhibits = AVIC_REQUIRED_APICV_INHIBITS,
 
 	.get_exit_info = svm_get_exit_info,
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 546825c82490..41eabb098b13 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -621,6 +621,21 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 extern struct kvm_x86_nested_ops svm_nested_ops;
 
 /* avic.c */
+#define AVIC_REQUIRED_APICV_INHIBITS			\
+(							\
+	BIT(APICV_INHIBIT_REASON_DISABLE) |		\
+	BIT(APICV_INHIBIT_REASON_ABSENT) |		\
+	BIT(APICV_INHIBIT_REASON_HYPERV) |		\
+	BIT(APICV_INHIBIT_REASON_NESTED) |		\
+	BIT(APICV_INHIBIT_REASON_IRQWIN) |		\
+	BIT(APICV_INHIBIT_REASON_PIT_REINJ) |		\
+	BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |		\
+	BIT(APICV_INHIBIT_REASON_SEV)      |		\
+	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
+	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
+	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
+	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED)	\
+)
 
 bool avic_hardware_setup(struct kvm_x86_ops *ops);
 int avic_ga_log_notifier(u32 ga_tag);
@@ -634,7 +649,6 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
-bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
 int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 			uint32_t guest_irq, bool set);
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef84d11a0fe4..ad2ac66ef32e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8023,18 +8023,16 @@ static void vmx_hardware_unsetup(void)
 	free_kvm_area();
 }
 
-static bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
-{
-	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
-			  BIT(APICV_INHIBIT_REASON_ABSENT) |
-			  BIT(APICV_INHIBIT_REASON_HYPERV) |
-			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |
-			  BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |
-			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED);
-
-	return supported & BIT(reason);
-}
+#define VMX_REQUIRED_APICV_INHIBITS			\
+(							\
+	BIT(APICV_INHIBIT_REASON_DISABLE)|		\
+	BIT(APICV_INHIBIT_REASON_ABSENT) |		\
+	BIT(APICV_INHIBIT_REASON_HYPERV) |		\
+	BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |		\
+	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
+	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
+	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED)	\
+)
 
 static void vmx_vm_destroy(struct kvm *kvm)
 {
@@ -8118,7 +8116,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
 	.load_eoi_exitmap = vmx_load_eoi_exitmap,
 	.apicv_post_state_restore = vmx_apicv_post_state_restore,
-	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
+	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
 	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1abe3f1e821c..5becce5bd45a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10112,7 +10112,7 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 
 	lockdep_assert_held_write(&kvm->arch.apicv_update_lock);
 
-	if (!static_call(kvm_x86_check_apicv_inhibit_reasons)(reason))
+	if (!(kvm_x86_ops.required_apicv_inhibits & BIT(reason)))
 		return;
 
 	old = new = kvm->arch.apicv_inhibit_reasons;
-- 
2.39.0.314.g84b9a713c41-goog

