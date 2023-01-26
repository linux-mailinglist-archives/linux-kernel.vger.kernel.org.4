Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B067C811
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjAZKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjAZKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599686C575;
        Thu, 26 Jan 2023 02:12:28 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBspy/9u/nODFUtF2xe2bBtb9zVk8MUKnTJvgzkbWRU=;
        b=AlRslMEQiSDBzZCN9O1m+xdHNLy8zwDD34c74BCWoCjAqKJIUhHvwE322s+LlA+BjBEIUD
        Wg6/SSyvVTOKBUPpy8IiHp0u7SprpmbBHxPNcvjRyJRnvC4UAMHA8WMjEW/mtrDlOSGLn+
        euVHFiuJJXHnwUkHk8FVfDIijhsTNhSS7VkK4pEVdAnN0WvBigR+UM1uK1ZpcSVIzi3DSP
        QsqrTi0oQc0jztz44WQhoPD/KLEPUq7hobvtvLQNiFc/ped2ID5tTUdsbszi55D5yD8PlD
        Q20WJmxDX+gWEX3ssehU9Nxi99c5vZjQxLpPKN3pkK15WitJQxfqFWyVYbZOdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBspy/9u/nODFUtF2xe2bBtb9zVk8MUKnTJvgzkbWRU=;
        b=X3qYsXlumnjOf8WMGRylrdD0PdDlQ2j2HQftaq3K8YX+AYpvgH3juICVb2H4T+491Ao48L
        pAygLgqI5Gsnd2Aw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add the Null Selector Clears Base feature
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124163319.2277355-6-kim.phillips@amd.com>
References: <20230124163319.2277355-6-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167472794641.4906.9955765022898441469.tip-bot2@tip-bot2>
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

Commit-ID:     5b909d4ae59aedc711b7a432da021be0e82c95a0
Gitweb:        https://git.kernel.org/tip/5b909d4ae59aedc711b7a432da021be0e82c95a0
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 24 Jan 2023 10:33:16 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 25 Jan 2023 16:25:46 +01:00

x86/cpu, kvm: Add the Null Selector Clears Base feature

The Null Selector Clears Base feature was being open-coded for KVM.
Add it to its newly added native CPUID leaf 0x80000021 EAX proper.

Also drop the bit description comments now it's more self-describing.

  [ bp: Convert test in check_null_seg_clears_base() too. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-6-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/common.c       | 4 +---
 arch/x86/kvm/cpuid.c               | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

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
index 12455dc..dde8d6b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -743,7 +743,7 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
-		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
+		F(NULL_SEL_CLR_BASE) | 0 /* PrefetchCtlMsr */
 	);
 
 	/*
@@ -759,7 +759,7 @@ void kvm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
 		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(6) /* NULL_SEL_CLR_BASE */;
+		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 	kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(9) /* NO_SMM_CTL_MSR */;
 
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
