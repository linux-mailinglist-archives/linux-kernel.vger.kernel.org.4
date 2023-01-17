Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A901670DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAQXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjAQXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA04A1F2;
        Tue, 17 Jan 2023 13:25:25 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3jgcTNf7s2UyBnGUo23RjRODd7U3FuCEWvWPotZJA8=;
        b=auSdhdEtdHiWxKNXyRIhJdUsfDNyxlYP2579L2J5ic0J9rplHWzQ8d0OkZh+OfO6t00CLc
        N673+xsQ3RT1urfVL7utqK1ruybi+LfRVVbKp9exgcjpPhhLRjTGOa6T93dgpDnpUGyvbm
        UgpPmn9H/GytiFCfrMGYLuqZakpKnn7SBKBsCDc0YxxUYIvfhZlEsh9WIdLJ9I7CTignHJ
        wPvtBK5Hur5l9jyvyPc0dZ3GwlMBtgMqmM57D/IEOTtQnn55TjOX128qrsBJPzQuPR7otY
        ASkKCjat26o4/Wkce8jtIkovXXXxNxZ/mnQ/jLwQcdybqu4rGt82H5LvZt2CTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3jgcTNf7s2UyBnGUo23RjRODd7U3FuCEWvWPotZJA8=;
        b=gPbp3TZpQa6u2mk2rpXLXkk8+wZFLtZYOcdqwCww429pu12Y5E729wTBmHf74mb9lurm3g
        tG05FdIWNMayfaDA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116230159.1511393-4-kim.phillips@amd.com>
References: <20230116230159.1511393-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072372.4906.6612577556062181355.tip-bot2@tip-bot2>
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

Commit-ID:     b594d2036c8440cda5488009d93966ae8a50c3e4
Gitweb:        https://git.kernel.org/tip/b594d2036c8440cda5488009d93966ae8a50c3e4
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 16 Jan 2023 17:01:55 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC

The LFENCE_RDTSC / LFENCE always serializing feature was a scattered bit
and open-coded for KVM in __do_cpuid_func().  Add it to its newly added
CPUID leaf 0x80000021 EAX proper, and propagate it in kvm_set_cpu_caps()
instead.  Drop the bit description comments now it's more self-describing.

Also, in amd_init(), don't bother setting DE_CFG[1] any more.

Whilst there, switch to using the more efficient cpu_feature_enabled()
instead of static_cpu_has().

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230116230159.1511393-4-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  3 ++-
 arch/x86/kernel/cpu/amd.c          |  2 +-
 arch/x86/kvm/cpuid.c               |  9 ++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 69e433e..88c9700 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -742,8 +742,10 @@ void kvm_set_cpu_caps(void)
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
-		F(NO_NESTED_DATA_BP)
+		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC)
 	);
+	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
 
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
@@ -1229,7 +1231,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		/*
 		 * Pass down these bits:
-		 *    EAX      2      LAS, LFENCE always serializing
 		 *    EAX      6      NSCB, Null selector clear base
 		 *
 		 * Other defined bits are for MSRs that KVM does not expose:
@@ -1239,10 +1240,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * KVM doesn't support SMM_CTL.
 		 *   EAX       9     SMM_CTL MSR is not supported
 		 */
-		entry->eax &= BIT(2) | BIT(6);
+		entry->eax &= BIT(6);
 		entry->eax |= BIT(9);
-		if (static_cpu_has(X86_FEATURE_LFENCE_RDTSC))
-			entry->eax |= BIT(2);
 		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 			entry->eax |= BIT(6);
 		break;
