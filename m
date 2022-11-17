Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EA62DE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiKQOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiKQOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4179E34
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668695600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps9mGB4FWMNZUhRI7eqw38JkpYxzOMfFPzgwHnz9dQU=;
        b=KKoU00AlzaPWOQCHsMmuMBuvaIRJyoWPiTkQKnItjZhglBcboKvePoW2bpWFcbqE7cjIUG
        6IXhPq2E8Y30gLMtegb6neKVqXAliSEO0C98ZHGxsDpDrenh7cGTPwhVJG6vslJ+lTKpqM
        BCLk2Iva9JfW+eMymhbV1G+rF20ECkQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-Jy4x4LlPPDyb9i2N1ngPYQ-1; Thu, 17 Nov 2022 09:33:14 -0500
X-MC-Unique: Jy4x4LlPPDyb9i2N1ngPYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62DAC1C08978;
        Thu, 17 Nov 2022 14:33:13 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAF482166B29;
        Thu, 17 Nov 2022 14:33:09 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandipan Das <sandipan.das@amd.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jing Liu <jing2.liu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Babu Moger <babu.moger@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Santosh Shukla <santosh.shukla@amd.com>
Subject: [PATCH 07/13] KVM: SVM: Add VNMI support in get/set_nmi_mask
Date:   Thu, 17 Nov 2022 16:32:36 +0200
Message-Id: <20221117143242.102721-8-mlevitsk@redhat.com>
In-Reply-To: <20221117143242.102721-1-mlevitsk@redhat.com>
References: <20221117143242.102721-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Santosh Shukla <santosh.shukla@amd.com>

VMCB intr_ctrl bit12 (V_NMI_MASK) is set by the processor when handling
NMI in guest and is cleared after the NMI is handled. Treat V_NMI_MASK
as read-only in the hypervisor except for the SMM case where hypervisor
before entring and after leaving SMM mode requires to set and unset
V_NMI_MASK.

Adding API(get_vnmi_vmcb) in order to return the correct vmcb for L1 or
L2.

Maxim:
   - made set_vnmi_mask/clear_vnmi_mask/is_vnmi_mask warn if called
     without vNMI enabled
   - clear IRET intercept in svm_set_nmi_mask even with vNMI

Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 18 ++++++++++++++-
 arch/x86/kvm/svm/svm.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 08a7b2a0a29f3a..c16f68f6c4f7d7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3618,13 +3618,29 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 
 static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
 {
-	return !!(vcpu->arch.hflags & HF_NMI_MASK);
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (is_vnmi_enabled(svm))
+		return is_vnmi_mask_set(svm);
+	else
+		return !!(vcpu->arch.hflags & HF_NMI_MASK);
 }
 
 static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	if (is_vnmi_enabled(svm)) {
+		if (masked)
+			set_vnmi_mask(svm);
+		else {
+			clear_vnmi_mask(svm);
+			if (!sev_es_guest(vcpu->kvm))
+				svm_clr_intercept(svm, INTERCEPT_IRET);
+		}
+		return;
+	}
+
 	if (masked) {
 		vcpu->arch.hflags |= HF_NMI_MASK;
 		if (!sev_es_guest(vcpu->kvm))
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f5383104d00580..bf7f4851dee204 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -35,6 +35,7 @@ extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
 extern int vgif;
 extern bool intercept_smi;
+extern bool vnmi;
 
 enum avic_modes {
 	AVIC_MODE_NONE = 0,
@@ -531,6 +532,57 @@ static inline bool is_x2apic_msrpm_offset(u32 offset)
 	       (msr < (APIC_BASE_MSR + 0x100));
 }
 
+static inline struct vmcb *get_vnmi_vmcb(struct vcpu_svm *svm)
+{
+	if (!vnmi)
+		return NULL;
+
+	if (is_guest_mode(&svm->vcpu))
+		return svm->nested.vmcb02.ptr;
+	else
+		return svm->vmcb01.ptr;
+}
+
+static inline bool is_vnmi_enabled(struct vcpu_svm *svm)
+{
+	struct vmcb *vmcb = get_vnmi_vmcb(svm);
+
+	if (vmcb)
+		return !!(vmcb->control.int_ctl & V_NMI_ENABLE);
+	else
+		return false;
+}
+
+static inline bool is_vnmi_mask_set(struct vcpu_svm *svm)
+{
+	struct vmcb *vmcb = get_vnmi_vmcb(svm);
+
+	if (!WARN_ON_ONCE(!vmcb))
+		return false;
+
+	return !!(vmcb->control.int_ctl & V_NMI_MASK);
+}
+
+static inline void set_vnmi_mask(struct vcpu_svm *svm)
+{
+	struct vmcb *vmcb = get_vnmi_vmcb(svm);
+
+	if (!WARN_ON_ONCE(!vmcb))
+		return;
+
+	vmcb->control.int_ctl |= V_NMI_MASK;
+}
+
+static inline void clear_vnmi_mask(struct vcpu_svm *svm)
+{
+	struct vmcb *vmcb = get_vnmi_vmcb(svm);
+
+	if (!WARN_ON_ONCE(!vmcb))
+		return;
+
+	vmcb->control.int_ctl &= ~V_NMI_MASK;
+}
+
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-- 
2.34.3

