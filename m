Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F485F3DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJDIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJDIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:12:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC853101EE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA4B1F8E6;
        Tue,  4 Oct 2022 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjjZMZb/A25GCQ+scz6LJmjfKGXZEm1tcVtvdvPahA8=;
        b=QQf9f+Wpo7w3nbV14ErV3b0nJfDxn8vnr6mO93NEsQ+kDVOki/NZ5Et//N9gxbXaDvMiv0
        2a0ScoJj+R+AH5V+ln2QEO7BOgy7ixz6G5hx+973MP0VPwBVaHL6Vi0IsO966g/tnwIAO8
        MEDVVVP5uC0KS2srj0tXfAwiWOTHHsc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F006139EF;
        Tue,  4 Oct 2022 08:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9koDEs3qO2PPSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
Date:   Tue,  4 Oct 2022 10:10:23 +0200
Message-Id: <20221004081023.32402-17-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
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

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch
---
 arch/x86/kernel/cpu/mtrr/amd.c     |  8 +-------
 arch/x86/kernel/cpu/mtrr/centaur.c |  8 +-------
 arch/x86/kernel/cpu/mtrr/cyrix.c   |  8 +-------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 30 +++---------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    | 15 +++++++++------
 5 files changed, 15 insertions(+), 54 deletions(-)

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
index 1b652fa768a6..7ba68356c0ff 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -65,16 +65,8 @@ static DEFINE_MUTEX(mtrr_mutex);
 
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
@@ -578,20 +570,6 @@ int arch_phys_wc_index(int handle)
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
@@ -649,8 +627,6 @@ void __init mtrr_bp_init(void)
 {
 	u32 phys_addr;
 
-	init_ifs();
-
 	phys_addr = 32;
 
 	if (boot_cpu_has(X86_FEATURE_MTRR)) {
@@ -691,21 +667,21 @@ void __init mtrr_bp_init(void)
 		case X86_VENDOR_AMD:
 			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR)) {
 				/* Pre-Athlon (K6) AMD CPU MTRRs */
-				mtrr_if = mtrr_ops[X86_VENDOR_AMD];
+				mtrr_if = vendor_mtrr_ops(amd_mtrr_ops);
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CENTAUR:
 			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR)) {
-				mtrr_if = mtrr_ops[X86_VENDOR_CENTAUR];
+				mtrr_if = vendor_mtrr_ops(centaur_mtrr_ops);
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
 			break;
 		case X86_VENDOR_CYRIX:
 			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR)) {
-				mtrr_if = mtrr_ops[X86_VENDOR_CYRIX];
+				mtrr_if = vendor_mtrr_ops(cyrix_mtrr_ops);
 				size_or_mask = SIZE_OR_MASK_BITS(32);
 				size_and_mask = 0;
 			}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index c98928ceee6a..7a7387356192 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -51,8 +51,6 @@ void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
 
-extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
-
 extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
@@ -66,10 +64,15 @@ void mtrr_state_warn(void);
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
+#ifdef CONFIG_X86_64
+#define vendor_mtrr_ops(x) NULL
+#else
+#define vendor_mtrr_ops(x) &(x)
+#endif
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(unsigned address_bits);
-- 
2.35.3

