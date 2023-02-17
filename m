Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8893369B644
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBQXLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBQXKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F105B2D8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id qa16-20020a17090b4fd000b00233c6b388ddso914555pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=POxuYt4fAOA6ZFnHfsbFWDtIU9nPZFu5zx86sbOziVE=;
        b=QdavNrkdWkG2gZ3NsrzLR/fOs76DCKkMTVMxakZG6LoyMRh9Cf0XobBJFuUDa5G8r4
         XF3yBtTZC2TMaUgjSZcjLQLbOnwIZpk0cM7vq4aeQcCccbCup+W/Fgll7QICn6WEauEO
         VCObIXioMDVz/EIaqO1tvqg8S2hLBr2pmkJWqMz6Ss2Gt+9n2OkXMQMdAVj+JDI8hcKO
         kdOmvMUAGpAXU7n+IcWsoXn1l5Q3RTHtu7kNi5bCj8WwNJ7RMYrBYJtfNTDmNNcEr8MO
         VDbssRqj35CSLlJWpbu4egzKdtsJYM3Kdw54fzQJ7ApuG2owQDYBmX0UCSHEVUGGtzmK
         RPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POxuYt4fAOA6ZFnHfsbFWDtIU9nPZFu5zx86sbOziVE=;
        b=VtxHXDPROm3W567ITsLxWOiKLQYKkyUKCSId8ao+1bYbLyGH0MHIpWB/AwtBygyd/Q
         wIzyLjEmhos9AU5mbHbGcRsPYyJ6W1ZCK6myArwAON+namKQm0hrRsEOkZsHaTAoQkRS
         mOV1tXuz5qwzH10fAtlovbuUx6rfBz7eMf0CsCvhzbce+nYAqgISA6r8rin75R/TyUVR
         tASGQNLRbgm3+v79NGaLRoQdWZeRkKNAZ5u2mt3IjfOjUxpk4yGDngkQ+3fTnNIPDt0y
         kOjBfBggffg8rnedjyHiWOWOxUbmRCTmWEcpQlAtwE8aED449Ohz/kzTFC4ASz67+xc4
         fhIA==
X-Gm-Message-State: AO0yUKVkajDT4+JI3suSrU4vQLVq3Ah04BbGS/Yl68XWMH3v5aSykn21
        BIWOkFlllaOdZXeqtHaUYJloZyY776s=
X-Google-Smtp-Source: AK7set8SeUweXtk7HR0IBiw1qUttq5cL7IcOJcsq9Unmzju7hZFedUrzEbRQvuLif2OV75KqyJKp6SIO61w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef85:b0:19a:fdca:e3f1 with SMTP id
 iz5-20020a170902ef8500b0019afdcae3f1mr441371plb.3.1676675439193; Fri, 17 Feb
 2023 15:10:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:17 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-8-seanjc@google.com>
Subject: [PATCH 07/12] KVM: nSVM: Use KVM-governed feature framework to track
 "TSC scaling enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Track "TSC scaling exposed to L1" via a governed feature flag instead of
using a dedicated bit/flag in vcpu_svm.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/svm/nested.c        |  4 ++--
 arch/x86/kvm/svm/svm.c           | 12 ++++++++----
 arch/x86/kvm/svm/svm.h           |  1 -
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index 359914112615..0335576a80a8 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -8,6 +8,7 @@ BUILD_BUG()
 KVM_GOVERNED_X86_FEATURE(GBPAGES)
 KVM_GOVERNED_X86_FEATURE(XSAVES)
 KVM_GOVERNED_X86_FEATURE(NRIPS)
+KVM_GOVERNED_X86_FEATURE(TSCRATEMSR)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0641cb943450..30e00c4e07c7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -673,7 +673,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.tsc_offset = vcpu->arch.tsc_offset;
 
 	if (svm->tsc_ratio_msr != kvm_caps.default_tsc_scaling_ratio) {
-		WARN_ON(!svm->tsc_scaling_enabled);
+		WARN_ON(!guest_can_use(vcpu, X86_FEATURE_TSCRATEMSR));
 		nested_svm_update_tsc_ratio_msr(vcpu);
 	}
 
@@ -1043,7 +1043,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	}
 
 	if (svm->tsc_ratio_msr != kvm_caps.default_tsc_scaling_ratio) {
-		WARN_ON(!svm->tsc_scaling_enabled);
+		WARN_ON(!guest_can_use(vcpu, X86_FEATURE_TSCRATEMSR));
 		vcpu->arch.tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 		__svm_write_tsc_multiplier(vcpu->arch.tsc_scaling_ratio);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cdffc6db8bc5..dd4aead5462c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2737,7 +2737,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr_info->index) {
 	case MSR_AMD64_TSC_RATIO:
-		if (!msr_info->host_initiated && !svm->tsc_scaling_enabled)
+		if (!msr_info->host_initiated &&
+		    !guest_can_use(vcpu, X86_FEATURE_TSCRATEMSR))
 			return 1;
 		msr_info->data = svm->tsc_ratio_msr;
 		break;
@@ -2879,7 +2880,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	switch (ecx) {
 	case MSR_AMD64_TSC_RATIO:
 
-		if (!svm->tsc_scaling_enabled) {
+		if (!guest_can_use(vcpu, X86_FEATURE_TSCRATEMSR)) {
 
 			if (!msr->host_initiated)
 				return 1;
@@ -2901,7 +2902,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 		svm->tsc_ratio_msr = data;
 
-		if (svm->tsc_scaling_enabled && is_guest_mode(vcpu))
+		if (guest_can_use(vcpu, X86_FEATURE_TSCRATEMSR) &&
+		    is_guest_mode(vcpu))
 			nested_svm_update_tsc_ratio_msr(vcpu);
 
 		break;
@@ -4146,7 +4148,9 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (kvm_cpu_cap_has(X86_FEATURE_NRIPS))
 		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_NRIPS);
 
-	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
+	if (tsc_scaling)
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_TSCRATEMSR);
+
 	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
 
 	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index bd6ee6945bdd..a523cfcdd12e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -258,7 +258,6 @@ struct vcpu_svm {
 	bool soft_int_injected;
 
 	/* optional nested SVM features that are enabled for this guest  */
-	bool tsc_scaling_enabled          : 1;
 	bool v_vmload_vmsave_enabled      : 1;
 	bool lbrv_enabled                 : 1;
 	bool pause_filter_enabled         : 1;
-- 
2.39.2.637.g21b0678d19-goog

