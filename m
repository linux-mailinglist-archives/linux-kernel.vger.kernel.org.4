Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7ED67C818
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjAZKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjAZKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0865B1;
        Thu, 26 Jan 2023 02:12:28 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqmhaSY+iJHSNRIh95JPWQFejosPcxyvX9veF4WEUEM=;
        b=PaGkCzYnQ9pnK0x0Hz+XIj4YVkj1AnFxXVn1dGHI1XPBbewu6jfuRwGJPfUesQjMv0/63L
        UJh7U1ffFdMkhMiivxCta1m+in4uxk/cr6coT0fLM+IPTzvKgMEMRVwPdAP1d4CN8y+l7Z
        yD+oKPPHHDYN7lqv5vw4qOJpzV+BX5EIcAVg6p+n60XH5/YOOtbbdJwY38/U5twvgw1YT3
        15c69LEFoE423Hi4yC9YRYxwO71nV7dwSUQxBjW9Q2Jyvc6RgcbRtT6YVBhKc9x1K5tXOe
        55HqhKZ3wMNkDhwb48q9/MJubIgJ0NFEWarpp296Z+Uhpre2M06NWr/CyhWKHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqmhaSY+iJHSNRIh95JPWQFejosPcxyvX9veF4WEUEM=;
        b=QVZ4pfgZi374o1r4a3gR1uHwbdbwYy1sWI2pjdOV2O9d7ksgH0jrAofz3KME1a/bHyTuBf
        TXQUflVXw6KoIADg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC to its native leaf
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124163319.2277355-5-kim.phillips@amd.com>
References: <20230124163319.2277355-5-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167472794699.4906.12879995558166444038.tip-bot2@tip-bot2>
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

Commit-ID:     84168ae786f8a15a7eb0f79d34f20b8d261ce2f5
Gitweb:        https://git.kernel.org/tip/84168ae786f8a15a7eb0f79d34f20b8d261ce2f5
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 24 Jan 2023 10:33:15 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 25 Jan 2023 13:06:13 +01:00

x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC to its native leaf

The LFENCE always serializing feature bit was defined as scattered
LFENCE_RDTSC and its native leaf bit position open-coded for KVM.  Add
it to its newly added CPUID leaf 0x80000021 EAX proper.  With
LFENCE_RDTSC in its proper place, the kernel's set_cpu_cap() will
effectively synthesize the feature for KVM going forward.

Also, DE_CFG[1] doesn't need to be set on such CPUs anymore.

  [ bp: Massage and merge diff from Sean. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-5-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  3 ++-
 arch/x86/kernel/cpu/amd.c          |  2 +-
 arch/x86/kvm/cpuid.c               | 16 +++++++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1b2d40a..901128e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-#define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
+/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
@@ -429,6 +429,7 @@
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f769d6d..208c2ce 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -956,7 +956,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
-	if (cpu_has(c, X86_FEATURE_XMM2)) {
+	if (!cpu_has(c, X86_FEATURE_LFENCE_RDTSC) && cpu_has(c, X86_FEATURE_XMM2)) {
 		/*
 		 * Use LFENCE for execution serialization.  On families which
 		 * don't have that MSR, LFENCE is already serializing.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index aa3a6dc..12455dc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -742,12 +742,22 @@ void kvm_set_cpu_caps(void)
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
-		F(NO_NESTED_DATA_BP) |
-		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
+		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
 		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
 	);
+
+	/*
+	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
+	 * KVM's supported CPUID if the feature is reported as supported by the
+	 * kernel.  LFENCE_RDTSC was a Linux-defined synthetic feature long
+	 * before AMD joined the bandwagon, e.g. LFENCE is serializing on most
+	 * CPUs that support SSE2.  On CPUs that don't support AMD's leaf,
+	 * kvm_cpu_cap_mask() will unfortunately drop the flag due to ANDing
+	 * the mask with the raw host CPUID, and reporting support in AMD's
+	 * leaf can make it easier for userspace to detect the feature.
+	 */
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
-		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(2) /* LFENCE Always serializing */;
+		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(6) /* NULL_SEL_CLR_BASE */;
 	kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(9) /* NO_SMM_CTL_MSR */;
