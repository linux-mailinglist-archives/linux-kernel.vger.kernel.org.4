Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B616D71C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjDEA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjDEA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:59:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4940F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:59:20 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s9-20020a634509000000b004fc1c14c9daso10205009pga.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680656359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r4IsBet8bh71zKeuLVNnRTIwwOz9n8fWFHrPWC3x+hg=;
        b=rjE6SQGZNtVno2kBOTSyzAMxFD8t5tMtXgeyDq/bCr05McmcCCdvubfm/ZyLL01rNw
         Cn105nyBh0QHx63FPWAoQeVzyKsG1M0bJnrzSGMROxt2Zkm8a7h0dq/M8HwOWkhwzl2U
         oUHUZ36G0tJNhJ9xyVmGyoJB+iF9HH6SDEOlFX4aGLRjxv2QQd1hsaNMeoKSmhC8umRk
         yKrsJggmO2KdNmYNF7Ey4S8vnz08yk5m0MbqttWYtNVOHtj2SswKoxaGcdWGaxplJTbC
         4+kQHcq5gldPCAqC/U/FqWVku4aUPYh+kxAj+FFILFCUYqUX/5Qv8WHWVqswjLibHl+B
         2HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680656359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4IsBet8bh71zKeuLVNnRTIwwOz9n8fWFHrPWC3x+hg=;
        b=v8n3Dqhfo5GuaskxZEufF+7lc1kwT1SPAFsiSVeZ1vb/1iYtGpvcz0V9kiOnQ+v/Mg
         owOEqTz5BybcaYjJgAsLv71ntQPqB6IMaWq2+lROnnNPIamco3M/Z9Ayudd1cbyf5V7j
         Q+oo7/tOtw03t8l1zcgq/kzSdNTSjOCatbwSZ7zmgpWITVDoILa8PoCeJyzzmwC3TSEv
         kvSBBlzLFUUczrRQLx+B4loSO1OK2w5FbOHBp+EJncfNOXhbNSEZEwqK1SLKFbhRWQx0
         BJr/JeCVbfnMKi/o63wtvftKs5fkVSSrUYyXG70+2hFUYwztPZ+47tZpjEklDafG2lTi
         cX/Q==
X-Gm-Message-State: AAQBX9ebjOdh22Ph/uRYDwJvpnXZPDGRORbJTRozkuQy9kwgJwLq+d6S
        xxgoSoiqc+nYbFGmgRWT2z8WwUkKpuc=
X-Google-Smtp-Source: AKy350Z3mUpjHtVbUgywmtn6XATuErbupizISJzBNHfCmnQ3TOtQvLeLj+McI8IaF4lglCxiNkImXBlogUc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:fcd:b0:23b:353a:2e24 with SMTP id
 gd13-20020a17090b0fcd00b0023b353a2e24mr1628244pjb.5.1680656359566; Tue, 04
 Apr 2023 17:59:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 Apr 2023 17:59:11 -0700
In-Reply-To: <20230405005911.423699-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405005911.423699-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405005911.423699-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86: Open code supported XCR0 calculation in kvm_vcpu_after_set_cpuid()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop cpuid_get_supported_xcr0() now that its bastardized usage in
__kvm_update_cpuid_runtime() is gone, and open code the logic in its sole
caller, kvm_vcpu_after_set_cpuid().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d28c4fb14d43..220eda4ab337 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -234,21 +234,6 @@ void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
 		vcpu->arch.pv_cpuid.features = best->eax;
 }
 
-/*
- * Calculate guest's supported XCR0 taking into account guest CPUID data and
- * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
- */
-static u64 cpuid_get_supported_xcr0(struct kvm_cpuid_entry2 *entries, int nent)
-{
-	struct kvm_cpuid_entry2 *best;
-
-	best = cpuid_entry2_find(entries, nent, 0xd, 0);
-	if (!best)
-		return 0;
-
-	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
-}
-
 static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
 				       int nent)
 {
@@ -323,8 +308,16 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		kvm_apic_set_version(vcpu);
 	}
 
-	vcpu->arch.guest_supported_xcr0 =
-		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
+	/*
+	 * Calculate guest's supported XCR0 taking into account guest CPUID data and
+	 * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
+	 */
+	best = kvm_find_cpuid_entry_index(vcpu, 0xd, 0);
+	if (!best)
+		vcpu->arch.guest_supported_xcr0 = 0;
+	else
+		vcpu->arch.guest_supported_xcr0 = (best->eax | ((u64)best->edx << 32)) &
+						  kvm_caps.supported_xcr0;
 
 	/*
 	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if
-- 
2.40.0.348.gf938b09366-goog

