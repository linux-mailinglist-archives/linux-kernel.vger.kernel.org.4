Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CFC670DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAQXgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjAQXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AF4A1F1;
        Tue, 17 Jan 2023 13:25:25 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL73PGKxStZ9fCgcTgYJXXkZ8/OuGHCrN4AUGABWof0=;
        b=qgQpzMddFMLd75rQQqljVgltj7CxOnG1q0/MJHb7cxTx1Gxbk+J6/87TB5JhjMJkuzFHBc
        nLV9oV8AO3AAwDLOZd3V4YF5yfLMOOb8Rx6Pf73k02WoYi7IuN44IUmmL+V3LjwXD/4yAq
        TgRHf1XfiGS3L/H5zAIjvEZhw/c9nRiajV8JfwQgeRQlridcMYuIRSdfaIGlb0xkz8q/18
        N9zjo0lrMpNIUpT3qdVVREUzTGSUGSdyOSmn1vhqKEwwNnykQkAqX7zvA9os57CMRPUHcx
        bziS5F70SPFpz8y5N03NJdZWUpG4KnPSDWGlMgu8Hlbmhf6U8QTa4bSiqNy3mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL73PGKxStZ9fCgcTgYJXXkZ8/OuGHCrN4AUGABWof0=;
        b=TUpb+7t4RNfGe6lTmWmH8S8CakL46MXa/PxfRhjJo8XXZXWe4GIxG8sh/hEomIEV4rqIA0
        IA4O41SnI8vhskDg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add the Null Selector Clears Base feature
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116230159.1511393-5-kim.phillips@amd.com>
References: <20230116230159.1511393-5-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072346.4906.15780876678821426051.tip-bot2@tip-bot2>
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

Commit-ID:     b1366f515fd65fb83518fded6520894efa4e228f
Gitweb:        https://git.kernel.org/tip/b1366f515fd65fb83518fded6520894efa4e228f
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 16 Jan 2023 17:01:56 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Add the Null Selector Clears Base feature

The Null Selector Clears Base feature was being open-coded for KVM in
__do_cpuid_func().  Add it to its newly added CPUID leaf 0x80000021 EAX
proper, and propagate it in kvm_set_cpu_caps() instead.

Also drop the bit description comments now it's more self-describing.

  [ bp: Convert test in check_null_seg_clears_base() too. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230116230159.1511393-5-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/common.c       |  4 +---
 arch/x86/kvm/cpuid.c               | 10 +++-------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 901128e..6bed80c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -430,6 +430,7 @@
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e6f3234..e6bf9b1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1685,9 +1685,7 @@ void check_null_seg_clears_base(struct cpuinfo_x86 *c)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	/* Zen3 CPUs advertise Null Selector Clears Base in CPUID. */
-	if (c->extended_cpuid_level >= 0x80000021 &&
-	    cpuid_eax(0x80000021) & BIT(6))
+	if (cpu_has(c, X86_FEATURE_NULL_SEL_CLR_BASE))
 		return;
 
 	/*
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 88c9700..04f2f48 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -742,10 +742,12 @@ void kvm_set_cpu_caps(void)
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
-		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC)
+		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | F(NULL_SEL_CLR_BASE)
 	);
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
 		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
+	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
+		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
@@ -1230,9 +1232,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->ebx = entry->ecx = entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		/*
-		 * Pass down these bits:
-		 *    EAX      6      NSCB, Null selector clear base
-		 *
 		 * Other defined bits are for MSRs that KVM does not expose:
 		 *   EAX      3      SPCL, SMM page configuration lock
 		 *   EAX      13     PCMSR, Prefetch control MSR
@@ -1240,10 +1239,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * KVM doesn't support SMM_CTL.
 		 *   EAX       9     SMM_CTL MSR is not supported
 		 */
-		entry->eax &= BIT(6);
 		entry->eax |= BIT(9);
-		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-			entry->eax |= BIT(6);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
