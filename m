Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89B670DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjAQXgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjAQXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E84ABFB;
        Tue, 17 Jan 2023 13:25:28 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qemyooB/R5fkfvoXHg6fr0JWKSxbyvNUaaVFTJolBQE=;
        b=DeJRLCkQ7agYKvTwDJZqXYhXjaiPkKp0j5f2tBbo4sIP9xMi5+oNNJyuXuStQHFX7/nDZs
        bJHwE2+ORPkEeNCjJiM55izUBIAvD6XpA3dM7xjcs7rk49CBMnwKfZKAO4uHXPVV4fX0re
        9j4piZqLnW6iIJLt394SwppZ3T++eLJDqOrv3ysMNydraHwvra6+GZgwYrzybP3WM2s7cF
        BL/XFJqKvekbP2/8CSJ9GwHjeMxxgRSS5kbSyARtJKtP6aGFjhN1MPQsAK8xVY+mRH16MH
        WPSJsz8HU2IXal1O/J6HblC5QdOBlzQAyoTGH7PatT4HlVEEUu1aHX7jAVd6TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qemyooB/R5fkfvoXHg6fr0JWKSxbyvNUaaVFTJolBQE=;
        b=ekwjsFXJLYUGVEJqQZUFJ6Ip6/Hx4s5tVIaev2D+XHv3LQOJ03+PcD+LT91Fd9mRdS54Se
        TNRgvKLhC1VkVuDw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230110224643.452273-4-kim.phillips@amd.com>
References: <20230110224643.452273-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072399.4906.743551278544320617.tip-bot2@tip-bot2>
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

Commit-ID:     dcf67f724b8ada6aa73b77733243024519c35a71
Gitweb:        https://git.kernel.org/tip/dcf67f724b8ada6aa73b77733243024519c35a71
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 10 Jan 2023 16:46:38 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature

The "Processor ignores nested data breakpoints" feature was being
open-coded for KVM in __do_cpuid_func().  Add it to its newly added CPUID leaf
0x80000021 EAX proper, and propagate it in kvm_set_cpu_caps() instead.

Also drop the bit description comments now it's more self-describing.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230110224643.452273-4-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kvm/cpuid.c               | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b890058..1b2d40a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -427,6 +427,9 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
+#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b14653b..69e433e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -741,6 +741,10 @@ void kvm_set_cpu_caps(void)
 		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
 		F(SME_COHERENT));
 
+	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
+		F(NO_NESTED_DATA_BP)
+	);
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -1222,9 +1226,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0x80000021:
 		entry->ebx = entry->ecx = entry->edx = 0;
+		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		/*
 		 * Pass down these bits:
-		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
 		 *    EAX      2      LAS, LFENCE always serializing
 		 *    EAX      6      NSCB, Null selector clear base
 		 *
@@ -1235,7 +1239,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * KVM doesn't support SMM_CTL.
 		 *   EAX       9     SMM_CTL MSR is not supported
 		 */
-		entry->eax &= BIT(0) | BIT(2) | BIT(6);
+		entry->eax &= BIT(2) | BIT(6);
 		entry->eax |= BIT(9);
 		if (static_cpu_has(X86_FEATURE_LFENCE_RDTSC))
 			entry->eax |= BIT(2);
