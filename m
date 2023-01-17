Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76424670DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjAQXgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjAQXex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F694A1F0;
        Tue, 17 Jan 2023 13:25:25 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3d4/mw4/hl5F2osNMsKbz5Kf5C7LrsmOauvGACysVo=;
        b=Sy6bzriSYRFwCy9YK/JC6ZHEA0An2srqcJKqxG2B7NvqVeSrDCh/ZRYIB0GtApJvy2uo1b
        +zt96SwmnB4LxtDvCL9cB1LgCE+BjUfhbzg5YYu/vxZhA8YW4PYvvxKo3E3yqST7z9KqiE
        COoDBvi2kLOgulGQdv9EU3wpTqexHUWCPebjlrQtFGCYSzeKjSOfJ3RLjdfz5dS6W4NdHp
        h5rINzVRgRIWD+B56pnENr6XXOtYYgWDTLUIchHmMSfKMCMaeY6SYw5stIzv+VtjcD0hap
        sCBYNZtZNWE/yEGMhQF6RIOt5HT5NZNvME3qeftA3igKBmY3OWESZjnPDirtNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3d4/mw4/hl5F2osNMsKbz5Kf5C7LrsmOauvGACysVo=;
        b=Ks3Ri6OBVU2nUefClXqC7YzdSXGSs4s3NfZXkC2ppSCJAt5PkB4n7fVsC9TQUPoIzmfk3z
        lCotcenyagBsn9Ag==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add the SMM_CTL MSR not present feature
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116230159.1511393-6-kim.phillips@amd.com>
References: <20230116230159.1511393-6-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072322.4906.11768615436512605695.tip-bot2@tip-bot2>
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

Commit-ID:     b7059f21b1c1c4ca5966d16bd3d9fa45cee89a87
Gitweb:        https://git.kernel.org/tip/b7059f21b1c1c4ca5966d16bd3d9fa45cee89a87
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 16 Jan 2023 17:01:57 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Add the SMM_CTL MSR not present feature

The SMM_CTL MSR not present feature was being open-coded for KVM in
__do_cpuid_func().  Add it to its newly added CPUID leaf 0x80000021 EAX
proper, and propagate it in kvm_set_cpu_caps() instead.

Also drop the bit description comments now the code is more
self-describing, and retain the SmmPgCfgLock and PrefetchCtlMsr feature
bit comments at the kvm_cpu_cap_mask() callsite.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230116230159.1511393-6-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kvm/cpuid.c               | 13 +++----------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6bed80c..86e98bd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -431,6 +431,7 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
+#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* "" SMM_CTL MSR is not present */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 04f2f48..56f00d9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -742,12 +742,14 @@ void kvm_set_cpu_caps(void)
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
-		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | F(NULL_SEL_CLR_BASE)
+		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
+		F(NULL_SEL_CLR_BASE) | 0 /* PrefetchCtlMsr */
 	);
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
 		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
+	kvm_cpu_cap_set(X86_FEATURE_NO_SMM_CTL_MSR);
 
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
@@ -1231,15 +1233,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 0x80000021:
 		entry->ebx = entry->ecx = entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
-		/*
-		 * Other defined bits are for MSRs that KVM does not expose:
-		 *   EAX      3      SPCL, SMM page configuration lock
-		 *   EAX      13     PCMSR, Prefetch control MSR
-		 *
-		 * KVM doesn't support SMM_CTL.
-		 *   EAX       9     SMM_CTL MSR is not supported
-		 */
-		entry->eax |= BIT(9);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
