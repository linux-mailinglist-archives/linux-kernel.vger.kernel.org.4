Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E951B624226
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKJMVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKJMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D082AE03;
        Thu, 10 Nov 2022 04:21:49 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1OT911XdDs3yG/pnNaK+K8I2VvLnvr5ImbIi7GuHWM=;
        b=TwSSAyvPfLB0av9i5FzmubMOho7bvU7Bat/LInHwaTMZoFOzr/iyurpbsAnjn6hIBkv779
        axUSfrstzOo93h6Re6X++VSrdW83GdHgiVLm5qRhpH8/vhhLO6tGxcziFcm44uaHqBe8PI
        4LtBJ6RlkbEYxQsllvi7I7cDy5JF9gIEPV0Kbi5/fLUXNSSxXvFyY/Cgxrgjt2NAZqUZkN
        4ZKEv2S13b4dRkT/Wegxv+EQusQYDNPvn2e7yV++nDshfVu19x43eaAuvKFVAuOQzFXv8I
        VxNpLT++rLtttAyDjgNxEFMtjcwL57VfcFmOM4O5EVbMZFSe4/Vkm/5aFvDjgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1OT911XdDs3yG/pnNaK+K8I2VvLnvr5ImbIi7GuHWM=;
        b=kCYd9lTcM1AJDV4SLBAzLnPjsMsRXVFlFNLKIofw+ERSe33PCfhpV/dw7/nBTUe7ng839Q
        LljFAd3ULPh//RCg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Simplify mtrr_ops initialization
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-17-jgross@suse.com>
References: <20221102074713.21493-17-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808290573.4906.10004430702775497703.tip-bot2@tip-bot2>
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

Commit-ID:     f8bd9f25c9815161a39886fdd96d110b536a6074
Gitweb:        https://git.kernel.org/tip/f8bd9f25c9815161a39886fdd96d110b536a6074
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:45 +01:00

x86/mtrr: Simplify mtrr_ops initialization

The way mtrr_if is initialized with the correct mtrr_ops structure is
quite weird.

Simplify that by dropping the vendor specific init functions and the
mtrr_ops[] array. Replace those with direct assignments of the related
vendor specific ops array to mtrr_if.

Note that a direct assignment is okay even for 64-bit builds, where the
symbol isn't present, as the related code will be subject to "dead code
elimination" due to how cpu_feature_enabled() is implemented.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-17-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mtrr/amd.c     |  8 +-------
 arch/x86/kernel/cpu/mtrr/centaur.c |  8 +-------
 arch/x86/kernel/cpu/mtrr/cyrix.c   |  8 +-------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 30 ++---------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    | 10 ++++------
 5 files changed, 10 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/amd.c b/arch/x86/kernel/cpu/mtrr/amd.c
index a65a027..eff6ac6 100644
--- a/arch/x86/kernel/cpu/mtrr/amd.c
+++ b/arch/x86/kernel/cpu/mtrr/amd.c
@@ -109,7 +109,7 @@ amd_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
 	return 0;
 }
 
-static const struct mtrr_ops amd_mtrr_ops = {
+const struct mtrr_ops amd_mtrr_ops = {
 	.vendor            = X86_VENDOR_AMD,
 	.set               = amd_set_mtrr,
 	.get               = amd_get_mtrr,
@@ -117,9 +117,3 @@ static const struct mtrr_ops amd_mtrr_ops = {
 	.validate_add_page = amd_validate_add_page,
 	.have_wrcomb       = positive_have_wrcomb,
 };
-
-int __init amd_init_mtrr(void)
-{
-	set_mtrr_ops(&amd_mtrr_ops);
-	return 0;
-}
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index f271778..b8a74ed 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -111,7 +111,7 @@ centaur_validate_add_page(unsigned long base, unsigned long size, unsigned int t
 	return 0;
 }
 
-static const struct mtrr_ops centaur_mtrr_ops = {
+const struct mtrr_ops centaur_mtrr_ops = {
 	.vendor            = X86_VENDOR_CENTAUR,
 	.set               = centaur_set_mcr,
 	.get               = centaur_get_mcr,
@@ -119,9 +119,3 @@ static const struct mtrr_ops centaur_mtrr_ops = {
 	.validate_add_page = centaur_validate_add_page,
 	.have_wrcomb       = positive_have_wrcomb,
 };
-
-int __init centaur_init_mtrr(void)
-{
-	set_mtrr_ops(&centaur_mtrr_ops);
-	return 0;
-}
diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index c77d3b0..173b9e0 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -234,7 +234,7 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 	post_set();
 }
 
-static const struct mtrr_ops cyrix_mtrr_ops = {
+const struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
@@ -242,9 +242,3 @@ static const struct mtrr_ops cyrix_mtrr_ops = {
 	.validate_add_page = generic_validate_add_page,
 	.have_wrcomb       = positive_have_wrcomb,
 };
-
-int __init cyrix_init_mtrr(void)
-{
-	set_mtrr_ops(&cyrix_mtrr_ops);
-	return 0;
-}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 8403daf..6432abc 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -69,16 +69,8 @@ static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
 
-static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
-
 const struct mtrr_ops *mtrr_if;
 
-void __init set_mtrr_ops(const struct mtrr_ops *ops)
-{
-	if (ops->vendor && ops->vendor < X86_VENDOR_NUM)
-		mtrr_ops[ops->vendor] = ops;
-}
-
 /*  Returns non-zero if we have the write-combining memory type  */
 static int have_wrcomb(void)
 {
@@ -582,20 +574,6 @@ int arch_phys_wc_index(int handle)
 }
 EXPORT_SYMBOL_GPL(arch_phys_wc_index);
 
-/*
- * HACK ALERT!
- * These should be called implicitly, but we can't yet until all the initcall
- * stuff is done...
- */
-static void __init init_ifs(void)
-{
-#ifndef CONFIG_X86_64
-	amd_init_mtrr();
-	cyrix_init_mtrr();
-	centaur_init_mtrr();
-#endif
-}
-
 /* The suspend/resume methods are only for CPU without MTRR. CPU using generic
  * MTRR driver doesn't require this
  */
@@ -653,8 +631,6 @@ void __init mtrr_bp_init(void)
 {
 	u32 phys_addr;
 
-	init_ifs();
-
 	phys_addr = 32;
 
 	if (boot_cpu_has(X86_FEATURE_MTRR)) {
@@ -695,21 +671,21 @@ void __init mtrr_bp_init(void)
 		case X86_VENDOR_AMD:
 			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR)) {
 				/* Pre-Athlon (K6) AMD CPU MTRRs */
-				mtrr_if = mtrr_ops[X86_VENDOR_AMD];
+				mtrr_if = &amd_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CENTAUR:
 			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR)) {
-				mtrr_if = mtrr_ops[X86_VENDOR_CENTAUR];
+				mtrr_if = &centaur_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CYRIX:
 			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR)) {
-				mtrr_if = mtrr_ops[X86_VENDOR_CYRIX];
+				mtrr_if = &cyrix_mtrr_ops;
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index c98928c..02eb587 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -51,8 +51,6 @@ void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
 
-extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
-
 extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
@@ -66,10 +64,10 @@ void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
 
-/* CPU specific mtrr init functions */
-int amd_init_mtrr(void);
-int cyrix_init_mtrr(void);
-int centaur_init_mtrr(void);
+/* CPU specific mtrr_ops vectors. */
+extern const struct mtrr_ops amd_mtrr_ops;
+extern const struct mtrr_ops cyrix_mtrr_ops;
+extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(unsigned address_bits);
