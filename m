Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BEE67C81B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbjAZKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjAZKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354566009;
        Thu, 26 Jan 2023 02:12:32 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674727948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnmbFw9pmFjIRXsSIt30ejYlyKsvq42lF3vi36XLWME=;
        b=3x+b/2mkIIqXKZr6jx8DkXaCndZ/KSeUSJoOmkEmxCvE755dOV4GkdgvNE3U0mv1odLTDr
        4yNRLjgf59Ga0ZmgBOnAdj0Ygwa91HB6Rb06Gzi1JQGPuWLpr/VPurXsaUL63l+ImN91ih
        bQXHafMYVgJ/zb8nBkOZFSxa7MLq+MvNOOL/Lz4Q4unJmMYWIxC6aPa5fpszuSy2MD/wQy
        AEhKYv7HBDTgaB5c+xnHdHpWCMjbdq4ifgUpsy2dXbpsNrtXIQNI6CRWybMc4t46HZOVK4
        HACzfSlhT3vrosXBqag7GaRamKjsNhDCxcT0jCxXHnIkZmVto4+jrNhgIDbLww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674727948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnmbFw9pmFjIRXsSIt30ejYlyKsvq42lF3vi36XLWME=;
        b=EJvQvfY3kvgkNnpuK43Rskz3wN53xmNd33O02NDcTKnkzqhS3FWZN8o5GysBnQpmkLM38V
        Uqk65/u83yvTAJDQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX
 bit propagation code
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124163319.2277355-3-kim.phillips@amd.com>
References: <20230124163319.2277355-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167472794770.4906.742433074585875386.tip-bot2@tip-bot2>
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

Commit-ID:     c35ac8c4bf600ee23bacb20f863aa7830efb23fb
Gitweb:        https://git.kernel.org/tip/c35ac8c4bf600ee23bacb20f863aa7830efb23fb
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 24 Jan 2023 10:33:13 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 25 Jan 2023 12:33:13 +01:00

KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code

Move code from __do_cpuid_func() to kvm_set_cpu_caps() in preparation for adding
the features in their native leaf.

Also drop the bit description comments as it will be more self-describing once
the individual features are added.

Whilst there, switch to using the more efficient cpu_feature_enabled() instead
of static_cpu_has().

Note, LFENCE_RDTSC and "NULL selector clears base" are currently synthetic,
Linux-defined feature flags as Linux tracking of the features predates AMD's
definition.  Keep the manual propagation of the flags from their synthetic
counterparts until the kernel fully converts to AMD's definition, otherwise KVM
would stop synthesizing the flags as intended.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-3-kim.phillips@amd.com
---
 arch/x86/kvm/cpuid.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b14653b..f3edc35 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -741,6 +741,17 @@ void kvm_set_cpu_caps(void)
 		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
 		F(SME_COHERENT));
 
+	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
+		BIT(0) /* NO_NESTED_DATA_BP */ |
+		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
+		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
+	);
+	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(2) /* LFENCE Always serializing */;
+	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
+		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(6) /* NULL_SEL_CLR_BASE */;
+	kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(9) /* NO_SMM_CTL_MSR */;
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -1222,25 +1233,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0x80000021:
 		entry->ebx = entry->ecx = entry->edx = 0;
-		/*
-		 * Pass down these bits:
-		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
-		 *    EAX      2      LAS, LFENCE always serializing
-		 *    EAX      6      NSCB, Null selector clear base
-		 *
-		 * Other defined bits are for MSRs that KVM does not expose:
-		 *   EAX      3      SPCL, SMM page configuration lock
-		 *   EAX      13     PCMSR, Prefetch control MSR
-		 *
-		 * KVM doesn't support SMM_CTL.
-		 *   EAX       9     SMM_CTL MSR is not supported
-		 */
-		entry->eax &= BIT(0) | BIT(2) | BIT(6);
-		entry->eax |= BIT(9);
-		if (static_cpu_has(X86_FEATURE_LFENCE_RDTSC))
-			entry->eax |= BIT(2);
-		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-			entry->eax |= BIT(6);
+		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
