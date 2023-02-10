Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA469157A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBJAcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBJAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:32:16 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A26F4E52D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:00 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l22-20020a17090aaa9600b00230aa3c1350so1596225pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=00HAzMjPVYVZpNNjib7OPhFskVadeKfZTgeX842t58U=;
        b=aBtzaPE8mYEmKnAgTm5Kax34YIZeL7JG4RKNgQ8x0KfDYjrvnvQ33kpzNnCl3AZjFx
         q0YvA0dhIK66QCU2byQQpwLdRR2uvjOsa1tMsA0sdVAGPUxLfrLlfF5LDa3auEb01hKT
         lZJJqZrfdgikkQzecg4RtA2RbUg3AP2vbP6d5pSW1Oy0oFdX2ZSj7jPuGBOmpAaC72BA
         H3hPZkLs9AnDnvU7c9BO0Tg+B7NscWiAXdFyL800DZcdLES2IuiEUiScFXp0CEnwejaI
         nMb/yCangz2qqeh+CQdL6qbm8lQC0stog6QULX5eBG4GEdzcuUFMcJ1B44nbvA24hpHy
         MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00HAzMjPVYVZpNNjib7OPhFskVadeKfZTgeX842t58U=;
        b=wdpfv3fYHeENaTnvV76RFN1o6DghiitH1fHZlE1icNCGjcu8PSUj2Byp7MUrO8hc1c
         74fQHEH6qVpPyIxvWAhAF88qXGI2RTjBb5Ez3Gk7/WaHCpDvq35BoSbswdNJB0uVeJaD
         SrGVeYqxC+nTGjU0gXRDQqXXbB8u5AhnPo/QameUmrJxyKtpi7DvbXpwoFina26Pb389
         pqsvoU3bt8myqUxcWIULVh8cSqaATBKrgPgq3FnTpt9IL+d/7KgQ4t40BjAoS1vht28T
         HmIpcju3+SJUOoT+MyFsuIHpEFVMybxkaE5EJr7hy4UMUYSExjmjtbgXKupzvFKdGbMa
         /7bA==
X-Gm-Message-State: AO0yUKWk7f+vFNtf5Q58DLmrpIOpm/iYepDF3bMCS3Cw05Js+TqdcOnu
        cNpJYsFNQ0ytQVnVSRiHOqJ99DTCmO0=
X-Google-Smtp-Source: AK7set/fP6s6kqVz5JdiGeG9ShoDDqitcXHoPray/u3IDKfyLGtoerXLUi/MQHZZGCleoBxxpRC1HTzSXmQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:3181:0:b0:58d:8d29:399c with SMTP id
 x123-20020a623181000000b0058d8d29399cmr2696005pfx.44.1675989119771; Thu, 09
 Feb 2023 16:31:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:32 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-6-seanjc@google.com>
Subject: [PATCH v2 05/21] KVM: x86: Disallow writes to immutable feature MSRs
 after KVM_RUN
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disallow writes to feature MSRs after KVM_RUN to prevent userspace from
changing the vCPU model after running the vCPU.  Similar to guest CPUID,
KVM uses feature MSRs to configure intercepts, determine what operations
are/aren't allowed, etc.  Changing the capabilities while the vCPU is
active will at best yield unpredictable guest behavior, and at worst
could be dangerous to KVM.

Allow writing the current value, e.g. so that userspace can blindly set
all MSRs when emulating RESET, and unconditionally allow writes to
MSR_IA32_UCODE_REV so that userspace can emulate patch loads.

Special case the VMX MSRs to keep the generic list small, i.e. so that
KVM can do a linear walk of the generic list without incurring meaningful
overhead.

Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7b73a0b45041..186cb6a81643 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1554,6 +1554,25 @@ static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
 			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
 static unsigned int num_msr_based_features;
 
+/*
+ * All feature MSRs except uCode revID, which tracks the currently loaded uCode
+ * patch, are immutable once the vCPU model is defined.
+ */
+static bool kvm_is_immutable_feature_msr(u32 msr)
+{
+	int i;
+
+	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
+		if (msr == msr_based_features_all_except_vmx[i])
+			return msr != MSR_IA32_UCODE_REV;
+	}
+
+	return false;
+}
+
 /*
  * Some IA32_ARCH_CAPABILITIES bits have dependencies on MSRs that KVM
  * does not yet virtualize. These include:
@@ -2168,6 +2187,23 @@ static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 
 static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
+	u64 val;
+
+	/*
+	 * Disallow writes to immutable feature MSRs after KVM_RUN.  KVM does
+	 * not support modifying the guest vCPU model on the fly, e.g. changing
+	 * the nVMX capabilities while L2 is running is nonsensical.  Ignore
+	 * writes of the same value, e.g. to allow userspace to blindly stuff
+	 * all MSRs when emulating RESET.
+	 */
+	if (vcpu->arch.last_vmentry_cpu != -1 &&
+	    kvm_is_immutable_feature_msr(index)) {
+		if (do_get_msr(vcpu, index, &val) || *data != val)
+			return -EINVAL;
+
+		return 0;
+	}
+
 	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }
 
-- 
2.39.1.581.gbfd45094c4-goog

