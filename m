Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4A670DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAQXfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAQXex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9C4A1E8;
        Tue, 17 Jan 2023 13:25:24 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwE2QF/ErBdwWuIXaXoJTpn5NXnQJfCY6SzciOOWEKU=;
        b=pyTLkl26Y9KU6LlKP2U7FJYbDLH68/x/W6o9fLt7VTgY9R31zesEn7I6CrJ6NFtG25ymzP
        2yPLmJ/jpuDPu1VE3TK+wGnRNjpAklq8gTHl+HoI7jImnMTzeRBXfyd/o/Wi6DKhpL51Ti
        KQOrvtuLMNUzzF6TEDAFPNb1e3jX2kZLecbaglkkhBGDJNDpn/xc3v1DKoOPdvUzN+dgMS
        uuX0lFU0dnX1LGKbLXl6F42qILxb0SxDWDWEwO0rUu0GEeB5FkgQSb4bSeB4Fj9OlHlHdJ
        m7M8JcWVUV1qCSgAchqzqMkIDtd3D//3WO3JuJyzbDqP7/6LEX2j5NIW5Oo61A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwE2QF/ErBdwWuIXaXoJTpn5NXnQJfCY6SzciOOWEKU=;
        b=KpbCP7FHyLJTVdu5z/bDm8grCCF6waHYsRbZdJ2vKBgPfcbkkO2p67x5ICZ7HiOg+EuO6I
        nGsiKns9yX5OtBDA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Propagate the AMD Automatic IBRS feature
 to the guest
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116230159.1511393-8-kim.phillips@amd.com>
References: <20230116230159.1511393-8-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072266.4906.4758989080281063501.tip-bot2@tip-bot2>
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

Commit-ID:     eea6c7957ae7fa2bf90e44c91ef013176db69483
Gitweb:        https://git.kernel.org/tip/eea6c7957ae7fa2bf90e44c91ef013176db69483
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 16 Jan 2023 17:01:59 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Propagate the AMD Automatic IBRS feature to the guest

Add the AMD Automatic IBRS feature bit to those being propagated to the guest,
and enable the guest EFER bit.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230116230159.1511393-8-kim.phillips@amd.com
---
 arch/x86/kvm/cpuid.c   | 2 +-
 arch/x86/kvm/svm/svm.c | 3 +++
 arch/x86/kvm/x86.c     | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 56f00d9..6ce0203 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -743,7 +743,7 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
-		F(NULL_SEL_CLR_BASE) | 0 /* PrefetchCtlMsr */
+		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
 	);
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
 		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
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
 
