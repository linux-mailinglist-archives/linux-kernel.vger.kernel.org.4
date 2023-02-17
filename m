Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659269B646
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBQXK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBQXKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10768AC9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a2503c5000000b008e1de4c1e7dso2131606ybd.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2TnnXLHs2EigAQxoZxOgm8ELOh1fY6tAR5v57woQrQM=;
        b=evWLFJz9F/oKh/+eqv6kDQcb25TLjrSKGiZ+885GucdcbYldsNDzdH5NDukODm5mES
         Xax2e9thCVVomFzY5yxPyLPBjJkAtXUsgxyTUk3DlpsaylUfFdp6qu59Md5UtCpFeWHT
         riYbvV5qIXDbPm0yBIP//Xxf/o/cfrnOxu+wv8G5R4Z4ibzLL1o1LLzJ+FveFN19oNVT
         vTCEusG7Vs/2GMEH2O0V6eV+mmI3qKAezzH4K5cFM922iXnY1DSBwSdRnNp57rGpFtdp
         MM5BMjHWDkRSFwYXcQVxjyFPFKgTon0rJNdIbPuXnBizF+upt3SEQVw+Om1aDVl9JwKr
         l6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TnnXLHs2EigAQxoZxOgm8ELOh1fY6tAR5v57woQrQM=;
        b=0jPE/ypOU80lcUsuhxtqjMrknJTkcwdu02PCVlYrZEJglG6PDpAyyM+ODIeGXLnaCy
         z2X6MEVMPIf0BB6rbOqnkbKUqizgdTcl7YKIqHPUkc1+VkHFu7pWD3NLl5yGQGC4u5D1
         R6HSaGuWzEiFPRQKaiLbyN6gwJkvXmi60LHUeq1sx03rEPEbVAG3yOKKjQzsGJqFtruN
         Rqy9HSSfU3Yv7rLZfCnuKd2jae3ILi7gxDgtMu2a8SfK6B9stuY7fPiprlJ2n1GXDlxb
         imvWOeLPHTj6qxmc2LHl81OI6vv5DsLumk/b2hmfxxwLOjHRGwwTsueD42gFmA3d9tIu
         l5WQ==
X-Gm-Message-State: AO0yUKXRo8o5+E9VyEd+UdLT+ns9LI76ucjr2Bz/52YaJN2ODGb9Qqlr
        NWzNtPrYySLEqH3wB1Vp+iygRLRMs58=
X-Google-Smtp-Source: AK7set8XekvWEQvFbi786Gs+IJcaBhEwI/d27S46Y/W3uuSOuMmnY1FW2Ag2e+5k0Xo/SyoYY03FVGaOuT8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d543:0:b0:52e:ebb7:98f9 with SMTP id
 x64-20020a0dd543000000b0052eebb798f9mr1162884ywd.201.1676675435569; Fri, 17
 Feb 2023 15:10:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:15 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-6-seanjc@google.com>
Subject: [PATCH 05/12] KVM: x86: Use KVM-governed feature framework to track
 "XSAVES enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Use the governed feature framework to track if XSAVES is "enabled", i.e.
if XSAVES can be used by the guest.  Add a comment in the SVM code to
explain the very unintuitive logic of deliberately NOT checking if XSAVES
is enumerated in the guest CPUID model.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/svm/svm.c           | 17 ++++++++++++---
 arch/x86/kvm/vmx/vmx.c           | 36 ++++++++++++++++----------------
 arch/x86/kvm/x86.c               |  4 ++--
 4 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index b29c15d5e038..b896a64e4ac3 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -6,6 +6,7 @@ BUILD_BUG()
 #define KVM_GOVERNED_X86_FEATURE(x) KVM_GOVERNED_FEATURE(X86_FEATURE_##x)
 
 KVM_GOVERNED_X86_FEATURE(GBPAGES)
+KVM_GOVERNED_X86_FEATURE(XSAVES)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b43775490074..d89e516449ad 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4128,9 +4128,20 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_cpuid_entry2 *best;
 
-	vcpu->arch.xsaves_enabled = guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-				    boot_cpu_has(X86_FEATURE_XSAVE) &&
-				    boot_cpu_has(X86_FEATURE_XSAVES);
+	/*
+	 * SVM doesn't provide a way to disable just XSAVES in the guest, KVM
+	 * can only disable all variants of by disallowing CR4.OSXSAVE from
+	 * being set.  As a result, if the host has XSAVE and XSAVES, and the
+	 * guest has XSAVE enabled, the guest can execute XSAVES without
+	 * faulting.  Treat XSAVES as enabled in this case regardless of
+	 * whether it's advertised to the guest so that KVM context switches
+	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
+	 * the guest read/write access to the host's XSS.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
+	    boot_cpu_has(X86_FEATURE_XSAVES) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
+		kvm_governed_feature_set(vcpu, X86_FEATURE_XSAVES);
 
 	/* Update nrips enabled cache */
 	svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 14ce195eee5a..c64a12756016 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4551,16 +4551,19 @@ vmx_adjust_secondary_exec_control(struct vcpu_vmx *vmx, u32 *exec_control,
  * based on a single guest CPUID bit, with a dedicated feature bit.  This also
  * verifies that the control is actually supported by KVM and hardware.
  */
-#define vmx_adjust_sec_exec_control(vmx, exec_control, name, feat_name, ctrl_name, exiting) \
-({									 \
-	bool __enabled;							 \
-									 \
-	if (cpu_has_vmx_##name()) {					 \
-		__enabled = guest_cpuid_has(&(vmx)->vcpu,		 \
-					    X86_FEATURE_##feat_name);	 \
-		vmx_adjust_secondary_exec_control(vmx, exec_control,	 \
-			SECONDARY_EXEC_##ctrl_name, __enabled, exiting); \
-	}								 \
+#define vmx_adjust_sec_exec_control(vmx, exec_control, name, feat_name, ctrl_name, exiting)	\
+({												\
+	struct kvm_vcpu *__vcpu = &(vmx)->vcpu;							\
+	bool __enabled;										\
+												\
+	if (cpu_has_vmx_##name()) {								\
+		if (kvm_is_governed_feature(X86_FEATURE_##feat_name))				\
+			__enabled = guest_can_use(__vcpu, X86_FEATURE_##feat_name);		\
+		else										\
+			__enabled = guest_cpuid_has(__vcpu, X86_FEATURE_##feat_name);		\
+		vmx_adjust_secondary_exec_control(vmx, exec_control, SECONDARY_EXEC_##ctrl_name,\
+						  __enabled, exiting);				\
+	}											\
 })
 
 /* More macro magic for ENABLE_/opt-in versus _EXITING/opt-out controls. */
@@ -4620,10 +4623,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml || !atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
-	if (cpu_has_vmx_xsaves())
-		vmx_adjust_secondary_exec_control(vmx, &exec_control,
-						  SECONDARY_EXEC_ENABLE_XSAVES,
-						  vcpu->arch.xsaves_enabled, false);
+	vmx_adjust_sec_exec_feature(vmx, &exec_control, xsaves, XSAVES);
 
 	/*
 	 * RDPID is also gated by ENABLE_RDTSCP, turn on the control if either
@@ -4642,6 +4642,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 						  SECONDARY_EXEC_ENABLE_RDTSCP,
 						  rdpid_or_rdtscp_enabled, false);
 	}
+
 	vmx_adjust_sec_exec_feature(vmx, &exec_control, invpcid, INVPCID);
 
 	vmx_adjust_sec_exec_exiting(vmx, &exec_control, rdrand, RDRAND);
@@ -7705,10 +7706,9 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	vcpu->arch.xsaves_enabled = cpu_has_vmx_xsaves() &&
-				    boot_cpu_has(X86_FEATURE_XSAVE) &&
-				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
+	if (cpu_has_vmx_xsaves() && boot_cpu_has(X86_FEATURE_XSAVE) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
 
 	vmx_setup_uret_msrs(vmx);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..541982de5762 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -988,7 +988,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.xcr0 != host_xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
 
-		if (vcpu->arch.xsaves_enabled &&
+		if (guest_can_use(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != host_xss)
 			wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
 	}
@@ -1023,7 +1023,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.xcr0 != host_xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, host_xcr0);
 
-		if (vcpu->arch.xsaves_enabled &&
+		if (guest_can_use(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != host_xss)
 			wrmsrl(MSR_IA32_XSS, host_xss);
 	}
-- 
2.39.2.637.g21b0678d19-goog

