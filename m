Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E269B63F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBQXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBQXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864168AD1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id be26-20020a056a001f1a00b0059085684b50so1364356pfb.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2tf53EPfhatPCq2VnYmKd0iZ7HVFsZitkXwBonW9dJw=;
        b=GJHSCDcjNVTZEVMG0mYD9ul4hN1+85Aunqv+jYXWQzMde9aoMzeSYZ4I1pC/+SHt3R
         /cyuE7zkSQkNLdFBx7HFJwR+2iAs21M21LyvgD51QkoX2EuiEh0rKweO1iFWNdjJU/Pg
         sgHDHKNYahaQ0ONGkeD57lK1suAGWoqaN35Pq1ckpJAs4PQZG4AuP+844LGzaAUocaz8
         MBCFU4GWjw3IXSqouObLLnefpVjp8F6viiv5vqJaK7xwy4E6o0mUXtiCgiMc1Xq1E2I1
         XPtmI9DLJX8EFQjlTP6cBR3csvVTSzK72LrqM/fPpJ9/J/tOO/GQn2saRsDVpnba48is
         zRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tf53EPfhatPCq2VnYmKd0iZ7HVFsZitkXwBonW9dJw=;
        b=VCyOV2OwfSlkUR42DmrxQ0HMgnhJ53HEWe878Gov8BA9e2Lmhb8E6Ev2sx9R2P3PwJ
         FXjVRrA/uQ5dcB2DGYRHcOfEsNpe1gPKRqO/E1XivUZ0QZ2BtqouEP178cRrnYRpVjyB
         t3pUyOJ5/46PE2vJ+e7iBW0jEITNJ8yS9q8IYR3I3B3aXNb4QmIh5NQqlDeb1MUSUB9W
         OySblvcGpi+XE/tRNHVW7QDONsg5tHazObk4yRcbofCWycul6VwlrJtazURxqFsu0XtR
         pRr6xhr2d2idAXlCDQfn5IP/SwnaDVE2CJmTBDH7muf7oSoG4aJ83SmFV7o6a7N4xip2
         8Lyg==
X-Gm-Message-State: AO0yUKWBdhTcdaG+cNSEU3nPWs8XqDdRGl/L8EGf7tbgAfT7jJ5Iwiyw
        S6pt/j68FEDnDp89H4Mf60oLc2DpwIs=
X-Google-Smtp-Source: AK7set8U5H8TL6hd99x0K44Eq2yADGGXi5R4l78giHQJeDDRlRcTs78X88HWzHmF+bKnHg+VUiSw1X0+WWE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7a54:0:b0:4fc:d6df:85a3 with SMTP id
 j20-20020a637a54000000b004fcd6df85a3mr507170pgn.1.1676675437475; Fri, 17 Feb
 2023 15:10:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:16 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-7-seanjc@google.com>
Subject: [PATCH 06/12] KVM: nSVM: Use KVM-governed feature framework to track
 "NRIPS enabled"
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

Track "NRIPS exposed to L1" via a governed feature flag instead of using
a dedicated bit/flag in vcpu_svm.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h | 1 +
 arch/x86/kvm/svm/nested.c        | 6 +++---
 arch/x86/kvm/svm/svm.c           | 5 ++---
 arch/x86/kvm/svm/svm.h           | 1 -
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index b896a64e4ac3..359914112615 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -7,6 +7,7 @@ BUILD_BUG()
 
 KVM_GOVERNED_X86_FEATURE(GBPAGES)
 KVM_GOVERNED_X86_FEATURE(XSAVES)
+KVM_GOVERNED_X86_FEATURE(NRIPS)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 05d38944a6c0..0641cb943450 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -694,7 +694,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	 * what a nrips=0 CPU would do (L1 is responsible for advancing RIP
 	 * prior to injecting the event).
 	 */
-	if (svm->nrips_enabled)
+	if (guest_can_use(vcpu, X86_FEATURE_NRIPS))
 		vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
 	else if (boot_cpu_has(X86_FEATURE_NRIPS))
 		vmcb02->control.next_rip    = vmcb12_rip;
@@ -704,7 +704,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		svm->soft_int_injected = true;
 		svm->soft_int_csbase = vmcb12_csbase;
 		svm->soft_int_old_rip = vmcb12_rip;
-		if (svm->nrips_enabled)
+		if (guest_can_use(vcpu, X86_FEATURE_NRIPS))
 			svm->soft_int_next_rip = svm->nested.ctl.next_rip;
 		else
 			svm->soft_int_next_rip = vmcb12_rip;
@@ -1004,7 +1004,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (vmcb12->control.exit_code != SVM_EXIT_ERR)
 		nested_save_pending_event_to_vmcb12(svm, vmcb12);
 
-	if (svm->nrips_enabled)
+	if (guest_can_use(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
 	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d89e516449ad..cdffc6db8bc5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4143,9 +4143,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
 		kvm_governed_feature_set(vcpu, X86_FEATURE_XSAVES);
 
-	/* Update nrips enabled cache */
-	svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
-			     guest_cpuid_has(vcpu, X86_FEATURE_NRIPS);
+	if (kvm_cpu_cap_has(X86_FEATURE_NRIPS))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_NRIPS);
 
 	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
 	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 839809972da1..bd6ee6945bdd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -258,7 +258,6 @@ struct vcpu_svm {
 	bool soft_int_injected;
 
 	/* optional nested SVM features that are enabled for this guest  */
-	bool nrips_enabled                : 1;
 	bool tsc_scaling_enabled          : 1;
 	bool v_vmload_vmsave_enabled      : 1;
 	bool lbrv_enabled                 : 1;
-- 
2.39.2.637.g21b0678d19-goog

