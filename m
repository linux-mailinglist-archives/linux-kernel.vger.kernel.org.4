Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1C6B56FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCKAqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCKAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E913B95F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:28 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id p36-20020a056a000a2400b005f72df7d97bso3628745pfh.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=037pUqXeQr7lbfms7Jj3Q4cOJvKKygZOU+H5t+p+MOc=;
        b=Owkx/G9kjCUuXtpKm84c1IzthMXdx92l6GjzKwTOY0Jh/hetT0yNl2D5JAKzaNCoQj
         m/0E2Rah7jDMcc3WGS1FqAGQpOBQJmma+gZC6JDfJO1ubESN7hU77dx8hajnvGoPts1+
         4j1ke8oKdBUh7RGTnqKuAaLX4x78Z9eYYvrTiEcHB/Y2DZBuQ9RT9RzfM8dm0gCG5Zpd
         RwKJvCo7hg0KKhHb3mKyFsf/Ete3PNUbm0WAZhWE+hhHLBo0EfMi+JAIAjUG7QW3xUFA
         83D2qsMO89xv/dw3qlpQF+m1c75e2oWk08FKeqrSvxYkW/Vfe2vHiRK0kyRKDai9SOCH
         C6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=037pUqXeQr7lbfms7Jj3Q4cOJvKKygZOU+H5t+p+MOc=;
        b=lZw+dQTdH+Fy1m0C+NPrF9W27WjMJn69s2qIKWjPTVViUVp9t1uzXXQl91Y8shwO/R
         0SocMHQIEbj/NgEniQmlwEqTNEX3YlixZ+2UZkzfsPnAww7akVfH91PBkZAW8EIhyj7t
         87fQXHbCCq3+vWp/7YWf/C0zyx4pKMdlHd5Iu4QAu6ZIOqTQXTvY5WxUEQPAXYyD8ThY
         dsFqb+ETI9P5yDq6YR1NJZf7/5jc3Z3V6vlWPesVDaL7dJpAZ6R+0V7atp8MwohAOagD
         ZRQKtFkj7bGzgzQjEqAv8BSjeglGxQ3G6B8jLDTDj6V58aqcphrb7tjp22J6UwMhgYVj
         H1kw==
X-Gm-Message-State: AO0yUKVcoOS+wustcls1+uLUvx1WJb0YMfr8nTPHnbW2r6XsLO2mLifp
        6LuGn88UUmQPRm1xHmj8fVYQ19nRgsI=
X-Google-Smtp-Source: AK7set/91VC9PMmHF4FV8Qbg8XLWgHyiljZ2d2gMBIvhfCThKgxYTJlcjU7RdiRpNZzXr0V4H3DqW3QTw6A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:79c4:0:b0:622:65eb:f6bd with SMTP id
 u187-20020a6279c4000000b0062265ebf6bdmr17868pfc.2.1678495587846; Fri, 10 Mar
 2023 16:46:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:00 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-4-seanjc@google.com>
Subject: [PATCH v3 03/21] KVM: x86: Add macros to track first...last VMX
 feature MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Add macros to track the range of VMX feature MSRs that are emulated by
KVM to reduce the maintenance cost of extending the set of emulated MSRs.

Note, KVM doesn't necessarily emulate all known/consumed VMX MSRs, e.g.
PROCBASED_CTLS3 is consumed by KVM to enable IPI virtualization, but is
not emulated as KVM doesn't emulate/virtualize IPI virtualization for
nested guests.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 arch/x86/kvm/x86.h     | 8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b43775490074..a5b9ebd6f2c5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4107,7 +4107,7 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 {
 	switch (index) {
 	case MSR_IA32_MCG_EXT_CTL:
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		return false;
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bcac3efcde41..56607996f8f4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1945,7 +1945,7 @@ static inline bool is_vmx_feature_control_msr_valid(struct vcpu_vmx *vmx,
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
@@ -2030,7 +2030,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = to_vmx(vcpu)->msr_ia32_sgxlepubkeyhash
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
 		if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
@@ -2366,7 +2366,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vmx->msr_ia32_sgxlepubkeyhash
 			[msr_index - MSR_IA32_SGXLEPUBKEYHASH0] = data;
 		break;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!msr_info->host_initiated)
 			return 1; /* they are read-only */
 		if (!nested_vmx_allowed(vcpu))
@@ -6957,7 +6957,7 @@ static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 		 * real mode.
 		 */
 		return enable_unrestricted_guest || emulate_invalid_guest_state;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		return nested;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 	case MSR_AMD64_TSC_RATIO:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 754190af1791..4bc483d082ee 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -40,6 +40,14 @@ void kvm_spurious_fault(void);
 	failed;								\
 })
 
+/*
+ * The first...last VMX feature MSRs that are emulated by KVM.  This may or may
+ * not cover all known VMX MSRs, as KVM doesn't emulate an MSR until there's an
+ * associated feature that KVM supports for nested virtualization.
+ */
+#define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
+#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
+
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW	2
-- 
2.40.0.rc1.284.g88254d51c5-goog

