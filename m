Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5069B647
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBQXKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBQXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:39 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AF56A042
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365780ce32so22556407b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kJiU495PRP5A5yKfuE+SWyHAevKRlJJJV0/9mgyLCwE=;
        b=gGRP8xLIV88x5+pesHlVSzH3eaURYkYcw9vwHWwO8otNJ8uT8UFPqg/GOY5panNWVn
         kEGeFIyz5hBE74qRNMuhJA2YZcEyKw5HhR40IEfFVJ4HTvJl44BCvkzPRoPslCZ5v9FP
         i97P7A81huZghUvo0ONVhCtFQbCKNfVmmM5gxglAxn67NPCcV8uQ/2eXhMgJ1gRGRmNw
         XpuDim0RFlBUosrevfxb+JUDXdtgrk8gobMn7ujgLNpTw9we+jT9m+OikOKQOpl9Auix
         op9EYj7vbSG3oMCuvGHNuRM7gbVKBqp7bTGgvZwEqv8quf47MYGRFfprbJalGiMKUTBL
         1yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJiU495PRP5A5yKfuE+SWyHAevKRlJJJV0/9mgyLCwE=;
        b=BV3RIwXDQVOrxXuivK7K87aYxkWQ07br9qqx30btU+CkN2FuDv2E7G0DMD7I/o90yy
         VFrXkbMv383cGNIPhrbgpZM8ZEf9VXTXFxtQ8xP9HExqJmMLw2FWsVLfd3VjS7ndVVbv
         ngJyiJ6//goKUg/k+XaI7oczHSbSbhJpnYNAW3BKqpJKwsWTPjh2F2YFr+r2ch981kdN
         lfPLg0GE7P+NoQpO1M+ekBHSUPdBe8M700TV2JmUPgjV8hpDIPfPPVSlxiMm7L3R8oa/
         +/xDAjWzBcIa/8VpHGPIbuyHvPMzZ235UPyzBwyErLCT+RjfcsDOV55qCQAcgWFAlyQP
         f54Q==
X-Gm-Message-State: AO0yUKWBfLY1yxPWRG0MVGVJ5DVZgEYMOXNCaq7bBTWPB7YyV2lZgkgM
        qpFWDGdvUs42SlEogOQeMgB2gmBVf/I=
X-Google-Smtp-Source: AK7set/6P/RBz9ydyNWe0LYN3vZl7Y1NK7LeQ8O5kyHRcxXD9i9uSGZ7Dxx1aMgRFxSd6+WP7y4o0y5F4y4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:7b02:0:b0:52e:d589:c893 with SMTP id
 w2-20020a817b02000000b0052ed589c893mr1365013ywc.457.1676675431997; Fri, 17
 Feb 2023 15:10:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:13 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-4-seanjc@google.com>
Subject: [PATCH 03/12] KVM: VMX: Recompute "XSAVES enabled" only after CPUID update
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

Recompute whether or not XSAVES is enabled for the guest only if the
guest's CPUID model changes instead of redoing the computation every time
KVM generates vmcs01's secondary execution controls.  The boot_cpu_has()
and cpu_has_vmx_xsaves() checks should never change after KVM is loaded,
and if they do the kernel/KVM is hosed.

Opportunistically add a comment explaining _why_ XSAVES is effectively
exposed to the guest if and only if XSAVE is also exposed to the guest.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 47abd9101e68..b6fdb311a7d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4620,19 +4620,10 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml || !atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
-	if (cpu_has_vmx_xsaves()) {
-		/* Exposing XSAVES only when XSAVE is exposed */
-		bool xsaves_enabled =
-			boot_cpu_has(X86_FEATURE_XSAVE) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-			guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
-
-		vcpu->arch.xsaves_enabled = xsaves_enabled;
-
+	if (cpu_has_vmx_xsaves())
 		vmx_adjust_secondary_exec_control(vmx, &exec_control,
 						  SECONDARY_EXEC_XSAVES,
-						  xsaves_enabled, false);
-	}
+						  vcpu->arch.xsaves_enabled, false);
 
 	/*
 	 * RDPID is also gated by ENABLE_RDTSCP, turn on the control if either
@@ -7709,8 +7700,15 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	/* xsaves_enabled is recomputed in vmx_compute_secondary_exec_control(). */
-	vcpu->arch.xsaves_enabled = false;
+	/*
+	 * XSAVES is effectively enabled if and only if XSAVE is also exposed
+	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
+	 * set if and only if XSAVE is supported.
+	 */
+	vcpu->arch.xsaves_enabled = cpu_has_vmx_xsaves() &&
+				    boot_cpu_has(X86_FEATURE_XSAVE) &&
+				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
 
 	vmx_setup_uret_msrs(vmx);
 
-- 
2.39.2.637.g21b0678d19-goog

