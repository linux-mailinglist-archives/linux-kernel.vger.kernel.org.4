Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AE65F8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjAFBOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbjAFBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DF071FF5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:31 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a11-20020a17090acb8b00b00226d4edae5dso50691pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fS+csXJyxOMcx0c1E+e+VEzk2Ik+KMEsEvy9GYC3FuY=;
        b=qPmMRHzY2Unv460fRWZ9mu+FUamlJOMoLR2rG7Sh1B1e0bLjVE5XjdLjAE7R5krYn5
         uai9FKshpsbwsfFBKwmN53nHURaI8+80Xlya6y4I+saqoXWNe57ouoamKfL7j7vOjAcP
         ygUCVv1sMfYPva6qmO2QoP5JF2CelCT8zU0M0G8IiirAj0gvEDUCBvtkycFyJ6tswmog
         2ESRRfDQLO+1QLwHxMWGxQg6LvRijd+h/CsKKZvyaP21RZ/Yir8xzIhpghaLUVTWDBlR
         CPJsJInRhC5JF1v9li9IWMVKhXHPQHOem/6s4o9j7py+POR+NiyK0vMwYIyOGPM074J/
         zItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS+csXJyxOMcx0c1E+e+VEzk2Ik+KMEsEvy9GYC3FuY=;
        b=sh2eMY1nTJVKXum6/jfrdw4/mEGdDfLhfpjlILiwTaxD4mflygfxyalSmogcegZjJi
         YZIibUOAODv40PWXt1JbUNxyETtvuMCMCXi0zTOwIOd3jp3XcXpTu0Y8sHC7TOySWdIW
         G9Z/9YGZnpyF0r8hRlzBIKBOy8OTVTFY/qHMQw0K/QFU32guestaAv5eV/w90Kh/mzEb
         HQPKKsNNRirOa+5wL5CC7SUW4iM9luOpxipRqt9LmHuUK2r3uOi1ssSNi5s3iwZxtXKQ
         7iIfXkvvPSOACb81Ih08zM6FGmwp9j48yEOYEohJMu2Voti0TtCtts4HxkLcMfh8AEII
         Jrpw==
X-Gm-Message-State: AFqh2kp3sN+YFYIVkPw8qprzb0D8LqPUd/TfJAcsRPKv3AjZE+WmgOuQ
        N4Xk7Rshg2vzLBw5V0K3vfSXrnKrDhk=
X-Google-Smtp-Source: AMrXdXvDN56/1fbaQn51oOa/BNA3PQnJD5ufQrR6us1w8OXhQW6bqd17mqJZ1+sMC7WWtebxdT+51X18Dz0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efcb:b0:186:971b:b7e5 with SMTP id
 ja11-20020a170902efcb00b00186971bb7e5mr2648231plb.54.1672967611493; Thu, 05
 Jan 2023 17:13:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:43 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-11-seanjc@google.com>
Subject: [PATCH v5 10/33] KVM: x86: Inhibit APIC memslot if x2APIC and AVIC
 are enabled
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

Free the APIC access page memslot if any vCPU enables x2APIC and SVM's
AVIC is enabled to prevent accesses to the virtual APIC on vCPUs with
x2APIC enabled.  On AMD, if its "hybrid" mode is enabled (AVIC is enabled
when x2APIC is enabled even without x2AVIC support), keeping the APIC
access page memslot results in the guest being able to access the virtual
APIC page as x2APIC is fully emulated by KVM.  I.e. hardware isn't aware
that the guest is operating in x2APIC mode.

Exempt nested SVM's update of APICv state from the new logic as x2APIC
can't be toggled on VM-Exit.  In practice, invoking the x2APIC logic
should be harmless precisely because it should be a glorified nop, but
play it safe to avoid latent bugs, e.g. with dropping the vCPU's SRCU
lock.

Intel doesn't suffer from the same issue as APICv has fully independent
VMCS controls for xAPIC vs. x2APIC virtualization.  Technically, KVM
should provide bus error semantics and not memory semantics for the APIC
page when x2APIC is enabled, but KVM already provides memory semantics in
other scenarios, e.g. if APICv/AVIC is enabled and the APIC is hardware
disabled (via APIC_BASE MSR).

Note, checking apic_access_memslot_enabled without taking locks relies
it being set during vCPU creation (before kvm_vcpu_reset()).  vCPUs can
race to set the inhibit and delete the memslot, i.e. can get false
positives, but can't get false negatives as apic_access_memslot_enabled
can't be toggled "on" once any vCPU reaches KVM_RUN.

Opportunistically drop the "can" while updating avic_activate_vmcb()'s
comment, i.e. to state that KVM _does_ support the hybrid mode.  Move
the "Note:" down a line to conform to preferred kernel/KVM multi-line
comment style.

Opportunistically update the apicv_update_lock comment, as it isn't
actually used to protect apic_access_memslot_enabled (which is protected
by slots_lock).

Fixes: 0e311d33bfbe ("KVM: SVM: Introduce hybrid-AVIC mode")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 10 +++++----
 arch/x86/kvm/lapic.c            | 38 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/lapic.h            |  1 +
 arch/x86/kvm/svm/avic.c         | 12 +++++------
 arch/x86/kvm/svm/nested.c       |  2 +-
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/x86.c              | 27 +++++++++++++++++++++--
 7 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c70690b2c82d..1d92c148e799 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1249,10 +1249,11 @@ struct kvm_arch {
 	struct kvm_apic_map __rcu *apic_map;
 	atomic_t apic_map_dirty;
 
-	/* Protects apic_access_memslot_enabled and apicv_inhibit_reasons */
-	struct rw_semaphore apicv_update_lock;
-
 	bool apic_access_memslot_enabled;
+	bool apic_access_memslot_inhibited;
+
+	/* Protects apicv_inhibit_reasons */
+	struct rw_semaphore apicv_update_lock;
 	unsigned long apicv_inhibit_reasons;
 
 	gpa_t wall_clock;
@@ -1599,6 +1600,7 @@ struct kvm_x86_ops {
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
 	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
+	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(int isr);
@@ -1973,7 +1975,7 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 
 bool kvm_apicv_activated(struct kvm *kvm);
 bool kvm_vcpu_apicv_activated(struct kvm_vcpu *vcpu);
-void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
+void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
 void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 				      enum kvm_apicv_inhibit reason, bool set);
 void kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e73386c26d2c..355ea688df4a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2442,7 +2442,8 @@ int kvm_alloc_apic_access_page(struct kvm *kvm)
 	int ret = 0;
 
 	mutex_lock(&kvm->slots_lock);
-	if (kvm->arch.apic_access_memslot_enabled)
+	if (kvm->arch.apic_access_memslot_enabled ||
+	    kvm->arch.apic_access_memslot_inhibited)
 		goto out;
 
 	hva = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
@@ -2470,6 +2471,41 @@ int kvm_alloc_apic_access_page(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_alloc_apic_access_page);
 
+void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	if (!kvm->arch.apic_access_memslot_enabled)
+		return;
+
+	kvm_vcpu_srcu_read_unlock(vcpu);
+
+	mutex_lock(&kvm->slots_lock);
+
+	if (kvm->arch.apic_access_memslot_enabled) {
+		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
+		/*
+		 * Clear "enabled" after the memslot is deleted so that a
+		 * different vCPU doesn't get a false negative when checking
+		 * the flag out of slots_lock.  No additional memory barrier is
+		 * needed as modifying memslots requires waiting other vCPUs to
+		 * drop SRCU (see above), and false positives are ok as the
+		 * flag is rechecked after acquiring slots_lock.
+		 */
+		kvm->arch.apic_access_memslot_enabled = false;
+
+		/*
+		 * Mark the memslot as inhibited to prevent reallocating the
+		 * memslot during vCPU creation, e.g. if a vCPU is hotplugged.
+		 */
+		kvm->arch.apic_access_memslot_inhibited = true;
+	}
+
+	mutex_unlock(&kvm->slots_lock);
+
+	kvm_vcpu_srcu_read_lock(vcpu);
+}
+
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 8c6442751dab..df316ede7546 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -113,6 +113,7 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type);
 void kvm_apic_update_apicv(struct kvm_vcpu *vcpu);
 int kvm_alloc_apic_access_page(struct kvm *kvm);
+void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu);
 
 bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ec28ba4c5f1b..0a75993afed6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -72,12 +72,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 
 	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 
-	/* Note:
-	 * KVM can support hybrid-AVIC mode, where KVM emulates x2APIC
-	 * MSR accesses, while interrupt injection to a running vCPU
-	 * can be achieved using AVIC doorbell. The AVIC hardware still
-	 * accelerate MMIO accesses, but this does not cause any harm
-	 * as the guest is not supposed to access xAPIC mmio when uses x2APIC.
+	/*
+	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
+	 * accesses, while interrupt injection to a running vCPU can be
+	 * achieved using AVIC doorbell.  KVM disables the APIC access page
+	 * (deletes the memslot) if any vCPU has x2APIC enabled, thus enabling
+	 * AVIC in hybrid mode activates only the doorbell mechanism.
 	 */
 	if (apic_x2apic_mode(svm->vcpu.arch.apic) &&
 	    avic_mode == AVIC_MODE_X2) {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bc9cd7086fa9..34ac03969f28 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1106,7 +1106,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	 * to benefit from it right away.
 	 */
 	if (kvm_apicv_activated(vcpu->kvm))
-		kvm_vcpu_update_apicv(vcpu);
+		__kvm_vcpu_update_apicv(vcpu);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 26044e1d2422..7651d665723e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5028,6 +5028,8 @@ static __init int svm_hardware_setup(void)
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
+	} else if (avic_mode == AVIC_MODE_X1) {
+		svm_x86_ops.allow_apicv_in_x2apic_without_x2apic_virtualization = true;
 	}
 
 	if (vls) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 39b8dd37bc40..1abe3f1e821c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10045,7 +10045,7 @@ void kvm_make_scan_ioapic_request(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SCAN_IOAPIC);
 }
 
-void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
+void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	bool activate;
@@ -10080,7 +10080,30 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 	preempt_enable();
 	up_read(&vcpu->kvm->arch.apicv_update_lock);
 }
-EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
+EXPORT_SYMBOL_GPL(__kvm_vcpu_update_apicv);
+
+static void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
+{
+	if (!lapic_in_kernel(vcpu))
+		return;
+
+	/*
+	 * Due to sharing page tables across vCPUs, the xAPIC memslot must be
+	 * deleted if any vCPU has xAPIC virtualization and x2APIC enabled, but
+	 * and hardware doesn't support x2APIC virtualization.  E.g. some AMD
+	 * CPUs support AVIC but not x2APIC.  KVM still allows enabling AVIC in
+	 * this case so that KVM can the AVIC doorbell to inject interrupts to
+	 * running vCPUs, but KVM must not create SPTEs for the APIC base as
+	 * the vCPU would incorrectly be able to access the vAPIC page via MMIO
+	 * despite being in x2APIC mode.  For simplicity, inhibiting the APIC
+	 * access page is sticky.
+	 */
+	if (apic_x2apic_mode(vcpu->arch.apic) &&
+	    kvm_x86_ops.allow_apicv_in_x2apic_without_x2apic_virtualization)
+		kvm_inhibit_apic_access_page(vcpu);
+
+	__kvm_vcpu_update_apicv(vcpu);
+}
 
 void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
 				      enum kvm_apicv_inhibit reason, bool set)
-- 
2.39.0.314.g84b9a713c41-goog

