Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF09615D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKBHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiKBHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAF27141
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 692B121F6E;
        Wed,  2 Nov 2022 07:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVtAWSumNurkoytRaTQXv7/5HrCR6FvTBpLocTA2bAY=;
        b=OIXg+UvpJqtAzZAoGeQCK/oKEPT6ZCODpZRPETtMlMYdoMMFIyuf02xCiw/udVP0r+WVbX
        /tfH3wkn1vaubIbk9R1GNlReODSacP/7iWsX67dNNoyC+/kpIK1sSqBw/DvU5a7UrRphyp
        muhbfPXSTPd9oQ4XbvEHj8RxQYZAE0k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D3301376E;
        Wed,  2 Nov 2022 07:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SK2UCd4gYmNecwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 16/16] x86/mtrr: simplify mtrr_ops initialization
Date:   Wed,  2 Nov 2022 08:47:13 +0100
Message-Id: <20221102074713.21493-17-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way mtrr_if is initialized with the correct mtrr_ops structure is
quite weird.

Simplify that by dropping the vendor specific init functions and the
mtrr_ops[] array. Replace those with direct assignments of the related
vendor specific ops array to mtrr_if.

Note that a direct assignment is okay even for 64-bit builds, where the
symbol isn't present, as the related code will be subject to "dead code
elimination" due to how cpu_feature_enabled() is implemented.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch
V5:
- drop the vendor_mtrr_ops() macro (Borislav Petkov)
---
 arch/x86/kernel/cpu/mtrr/amd.c     |  8 +-------
 arch/x86/kernel/cpu/mtrr/centaur.c |  8 +-------
 arch/x86/kernel/cpu/mtrr/cyrix.c   |  8 +-------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 30 +++---------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    | 10 ++++------
 5 files changed, 10 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/amd.c b/arch/x86/kernel/cpu/mtrr/amd.c
index a65a0272096d..eff6ac62c0ff 100644
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
index f27177816569..b8a74eddde83 100644
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
index c77d3b0a5bf2..173b9e01e623 100644
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
index 8403daf34158..6432abccbf56 100644
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
index c98928ceee6a..02eb5871492d 100644
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
-- 
2.35.3

