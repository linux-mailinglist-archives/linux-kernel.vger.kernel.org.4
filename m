Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4269067C815
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjAZKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjAZKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CE365F2D;
        Thu, 26 Jan 2023 02:12:28 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674727945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey1fbEfmnHOwFJ4flCOipEsbH7zbtW8pQ6LSfcPHqwM=;
        b=EFE0QB+d26qkHg6fPPv4IVZjrpfOjEd7ZnPWD06SR8rG1U9ZMmhVEM0s1QxTGca+7DRjxb
        mPyLJN7eEkvr9JmZVkqtoglIyzei0//WiW7KAV/HIqPZbEFgxCmNvN4ip0iKRzXnGurOFX
        3TeCW0/YR+7pfUXZu9sene9wgC70iTqEB/hMXPYTg1N+CmqNNynG2xoC0qtzjnFu5fLugZ
        /Xq0j8giGJGj6v2i56+Dqr8TEEiP7doAgaFd8bKV9+d/YT5L8u71WN8uvMgahQMLqElxQi
        rz5CtQfCKDqMJwXnfV2klrNiMeoVwYaLp2WyB0DLE8xVnkvSKgj11Mp0fJiMaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674727945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey1fbEfmnHOwFJ4flCOipEsbH7zbtW8pQ6LSfcPHqwM=;
        b=QOAqLQdnidJRGlsJ3776qszeDID6C5eLuN0k10i1PeSuo8YlnMneXdFtBymSygh1TCW1Sy
        ausmr5dspjTkelBg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: x86: Propagate the AMD Automatic IBRS feature to
 the guest
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124163319.2277355-9-kim.phillips@amd.com>
References: <20230124163319.2277355-9-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167472794482.4906.5654390408231835761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8c19b6f257fa71ed3a7a9df6ce466c6be31ca04c
Gitweb:        https://git.kernel.org/tip/8c19b6f257fa71ed3a7a9df6ce466c6be31ca04c
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 24 Jan 2023 10:33:19 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 25 Jan 2023 17:21:40 +01:00

KVM: x86: Propagate the AMD Automatic IBRS feature to the guest

Add the AMD Automatic IBRS feature bit to those being propagated to the guest,
and enable the guest EFER bit.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-9-kim.phillips@amd.com
---
 arch/x86/kvm/cpuid.c   | 2 +-
 arch/x86/kvm/svm/svm.c | 3 +++
 arch/x86/kvm/x86.c     | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 28071e9..f1f4fe8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -743,7 +743,7 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
-		F(NULL_SEL_CLR_BASE) | 0 /* PrefetchCtlMsr */
+		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
 	);
 
 	/*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9a194aa..60c7c88 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4969,6 +4969,9 @@ static __init int svm_hardware_setup(void)
 
 	tsc_aux_uret_slot = kvm_add_user_return_msr(MSR_TSC_AUX);
 
+	if (boot_cpu_has(X86_FEATURE_AUTOIBRS))
+		kvm_enable_efer_bits(EFER_AUTOIBRS);
+
 	/* Check for pause filtering support */
 	if (!boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
 		pause_filter_count = 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index da4bbd0..8dd0cb2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1685,6 +1685,9 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 
 static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
+	if (efer & EFER_AUTOIBRS && !guest_cpuid_has(vcpu, X86_FEATURE_AUTOIBRS))
+		return false;
+
 	if (efer & EFER_FFXSR && !guest_cpuid_has(vcpu, X86_FEATURE_FXSR_OPT))
 		return false;
 
