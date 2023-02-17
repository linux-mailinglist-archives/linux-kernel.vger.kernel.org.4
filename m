Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0969B64C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBQXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBQXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:11:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0066F69290
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a251885000000b0092aabd4fa90so1931358yby.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=y+vRasImpgsONkuFWEwkUJDlQ5PlpYyW5BuRWOgPo+I=;
        b=duZP1OUSZ8GA7t5Oa5HX6hRRseF3k5EiTGYt+R3pS76fquatD1J2o/MeZx61e/YmEh
         CawMVRWWt0V1OGElmhOpu7JQeTb9c8c8ArnCdaPGyYtsEztkDJFZMSqJW49jcfZnWuOI
         r6zEtJTbWpCHlEi4nqmAUmyUUYVLgzsxzfB5rpRpdncAM8upT8wdTy4kY4ItoCkvmUD/
         SNkmdMzpy9OHA8yBwwKdb4C9CnpNujIVT1dagQgfMC0QCmS9gDZUNaC5eCBX1edGb46X
         +8fmBURigrx+J18D+rONdcH1qQDIHZgCXK4mFz9FbdVyli0FBzWBF0MVID7xgLINh+/Y
         3FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+vRasImpgsONkuFWEwkUJDlQ5PlpYyW5BuRWOgPo+I=;
        b=lKhYEOrjL+C6IRTcJaxgR3Jr6iIE5GG7CFwcKqJcO5PPAhU4ogDsQWgGgHYLD6Hugb
         hWKR4p98sddeOPvqcip19k2ntJbuNAAJRUOdUJqqIlvpUqyvhHYzMYqZ3OU1j/WRuDyK
         13rRMNVUmTe8hsYKV6tHmhfyoDrwEw+B2kOTiqEefE3n2YFOwOO4xgsJmNXaULnZXFnL
         t+juh2LgUe3mKQKs96BtcnSl8RMeE3b4abpNBBuTlz2GB1imMNffqdLGUWWA/XRA+Ntp
         McohcM1rLv9mAmvV8unNpJOEJ/KAb3bklo+C2FSJ5iDB8E0OSdyNyulZaPimqtVseIsp
         +L6A==
X-Gm-Message-State: AO0yUKU0f2TjW/32gWJoZeqtBDBBSdUcSrx5xeSnPcIIaF00hkPg2I4u
        J+wi4/VSF8BT5ZVmqpQf0TrGNsvRHIw=
X-Google-Smtp-Source: AK7set+5RGeqQvHi2R+C6jJ1xgQJBifGa7LHdXlbRH9VtB2Jep8Ou1oYljFWFff7NqgcdMZqEY+jYtKw3x8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:eb8f:0:b0:52f:f71:31c9 with SMTP id
 u137-20020a0deb8f000000b0052f0f7131c9mr1159924ywe.250.1676675444598; Fri, 17
 Feb 2023 15:10:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:20 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-11-seanjc@google.com>
Subject: [PATCH 10/12] KVM: nSVM: Use KVM-governed feature framework to track
 "Pause Filter enabled"
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

Track "Pause Filtering is exposed to L1" via governed feature flags
instead of using dedicated bits/flags in vcpu_svm.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h |  2 ++
 arch/x86/kvm/svm/nested.c        | 10 ++++++++--
 arch/x86/kvm/svm/svm.c           |  8 ++++----
 arch/x86/kvm/svm/svm.h           |  2 --
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index 16c58d61bdf6..93c7d840e546 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -11,6 +11,8 @@ KVM_GOVERNED_X86_FEATURE(NRIPS)
 KVM_GOVERNED_X86_FEATURE(TSCRATEMSR)
 KVM_GOVERNED_X86_FEATURE(V_VMSAVE_VMLOAD)
 KVM_GOVERNED_X86_FEATURE(LBRV)
+KVM_GOVERNED_X86_FEATURE(PAUSEFILTER)
+KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9e210b03e635..c38f17ba818e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -721,8 +721,14 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		vmcb02->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 
-	pause_count12 = svm->pause_filter_enabled ? svm->nested.ctl.pause_filter_count : 0;
-	pause_thresh12 = svm->pause_threshold_enabled ? svm->nested.ctl.pause_filter_thresh : 0;
+	if (guest_can_use(vcpu, X86_FEATURE_PAUSEFILTER))
+		pause_count12 = svm->nested.ctl.pause_filter_count;
+	else
+		pause_count12 = 0;
+	if (guest_can_use(vcpu, X86_FEATURE_PFTHRESHOLD))
+		pause_thresh12 = svm->nested.ctl.pause_filter_thresh;
+	else
+		pause_thresh12 = 0;
 	if (kvm_pause_in_guest(svm->vcpu.kvm)) {
 		/* use guest values since host doesn't intercept PAUSE */
 		vmcb02->control.pause_filter_count = pause_count12;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 42591c77f98a..b18bd0b33942 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4157,11 +4157,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (vls && !guest_cpuid_is_intel(vcpu))
 		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
-	svm->pause_filter_enabled = kvm_cpu_cap_has(X86_FEATURE_PAUSEFILTER) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_PAUSEFILTER);
+	if (kvm_cpu_cap_has(X86_FEATURE_PAUSEFILTER))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PAUSEFILTER);
 
-	svm->pause_threshold_enabled = kvm_cpu_cap_has(X86_FEATURE_PFTHRESHOLD) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_PFTHRESHOLD);
+	if (kvm_cpu_cap_has(X86_FEATURE_PFTHRESHOLD))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
 
 	svm->vgif_enabled = vgif && guest_cpuid_has(vcpu, X86_FEATURE_VGIF);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 60817ff346b0..c05eea319d28 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -258,8 +258,6 @@ struct vcpu_svm {
 	bool soft_int_injected;
 
 	/* optional nested SVM features that are enabled for this guest  */
-	bool pause_filter_enabled         : 1;
-	bool pause_threshold_enabled      : 1;
 	bool vgif_enabled                 : 1;
 
 	u32 ldr_reg;
-- 
2.39.2.637.g21b0678d19-goog

