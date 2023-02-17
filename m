Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3338769B649
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBQXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBQXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:11:05 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F566A057
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5365663d982so25237067b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xoyujDYNcmSn6sbEuz9ptxpGQrMCz4NdSnDyJI75LQw=;
        b=dpQqFvssXE0UA8WwasFAKBnP2Qr+hAS9iMB0u9edTg/bAjZj4XhrrT0weBm/X/66Sn
         ypVCWH0fcamcMwYZNEgACrCuZJDSNYJfRhyFQLb/NOILy9Q0miLSTkFhTFbq0TrMWfM/
         TBSppg3h4vxQWjOUaDfKkQx6IQ8SrOEwxeV9Z761h2EGa/iL/m2uPZdjE3dOUODAHph2
         ffxbJMs9RdgFl517e8dx/LN6AumlRS3X80c/mT/QLwtAgkM4xONk8O7zKU/QTMep2STF
         7/RxkTXmbAtp1FVs07RE/ej5J703siUuwOmmIwMxoXaENzvI3YUKWMPvemIkiMgNtHxj
         mbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoyujDYNcmSn6sbEuz9ptxpGQrMCz4NdSnDyJI75LQw=;
        b=mU6kJ/P4nn90lFBiCRncTQCazkO+V8+8f0PdJln+dlPMOZDLQArJigebLF6eY2qaZ/
         w8qGQgWYus3+9kbpkF4lPWCnLl00o20YA2vWDA5EXi38zK58pFKasLmNdDs7k0Vft06u
         FZUbbcvWUvh5JitgDDGK9JXPfwojkA8FsPyxUZiBtr1NV+vMpUnPC1Yk8YH9LlPKZcA9
         VZYLtGkIktzPj+9tLa9hvHisbrsZWRSXivci5g/HxGK94PLMsow+hwOFc/ECA8TBI3lR
         PgtDqqJUiJmSLXZ/1jn5POt3MZm4kOmCIfP5b5THJPJ+b+ev7uMBBL8ntz2wVNnbno2b
         HxzQ==
X-Gm-Message-State: AO0yUKWFJyk9N3tOMtn4imGVxv03DF99SLK2qAYMm+4gchY5PGchKKyL
        JGTeC14xxYfn/a07xgn8TncDpj5LSX4=
X-Google-Smtp-Source: AK7set8FD8KPiW5RbVdBMkTuzISxQM/fZM5/zT59mGNOY8Xn9cS1Tk+Uu1Efwpubrn/SOWsjg0210bXEBXM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9346:0:b0:909:4c2d:3092 with SMTP id
 g6-20020a259346000000b009094c2d3092mr1339095ybo.643.1676675440994; Fri, 17
 Feb 2023 15:10:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:18 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-9-seanjc@google.com>
Subject: [PATCH 08/12] KVM: nSVM: Use KVM-governed feature framework to track
 "vVM{SAVE,LOAD} enabled"
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

Track "virtual VMSAVE/VMLOAD exposed to L1" via a governed feature flag
instead of using a dedicated bit/flag in vcpu_svm.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h | 1 +
 arch/x86/kvm/svm/nested.c        | 2 +-
 arch/x86/kvm/svm/svm.c           | 5 ++---
 arch/x86/kvm/svm/svm.h           | 1 -
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index 0335576a80a8..b66b9d550f33 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -9,6 +9,7 @@ KVM_GOVERNED_X86_FEATURE(GBPAGES)
 KVM_GOVERNED_X86_FEATURE(XSAVES)
 KVM_GOVERNED_X86_FEATURE(NRIPS)
 KVM_GOVERNED_X86_FEATURE(TSCRATEMSR)
+KVM_GOVERNED_X86_FEATURE(V_VMSAVE_VMLOAD)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 30e00c4e07c7..6a96058c0e48 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -107,7 +107,7 @@ static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
 {
-	if (!svm->v_vmload_vmsave_enabled)
+	if (!guest_can_use(&svm->vcpu, X86_FEATURE_V_VMSAVE_VMLOAD))
 		return true;
 
 	if (!nested_npt_enabled(svm))
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dd4aead5462c..b3f0271c73b9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1162,8 +1162,6 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 0, 0);
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 0, 0);
-
-		svm->v_vmload_vmsave_enabled = false;
 	} else {
 		/*
 		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
@@ -4153,7 +4151,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
 
-	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+	if (vls && !guest_cpuid_is_intel(vcpu))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
 	svm->pause_filter_enabled = kvm_cpu_cap_has(X86_FEATURE_PAUSEFILTER) &&
 			guest_cpuid_has(vcpu, X86_FEATURE_PAUSEFILTER);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a523cfcdd12e..1e3e7462b1d7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -258,7 +258,6 @@ struct vcpu_svm {
 	bool soft_int_injected;
 
 	/* optional nested SVM features that are enabled for this guest  */
-	bool v_vmload_vmsave_enabled      : 1;
 	bool lbrv_enabled                 : 1;
 	bool pause_filter_enabled         : 1;
 	bool pause_threshold_enabled      : 1;
-- 
2.39.2.637.g21b0678d19-goog

