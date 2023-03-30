Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592CA6D00B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjC3KKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC3KKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:10:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DA7D93;
        Thu, 30 Mar 2023 03:09:41 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680170979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzwYpHAlGFh2jcUeq4SdySXMk9iHC9iZ6y9++anDNoE=;
        b=KM222hMi3A2IIcnhPjYwrQpr8XiHlwxM/zurbhYUwW3asTzbulzgIHuHPDtj2VLhsnus3k
        tLmNJSxRCvVHTIpi1vWgvclkgS7X98iCa3YBKYeIPcwBu7w/W8UxwC7+iiH5cmlp3WMwH6
        /xAnuieEaidnmu/VepjY+wKB3u5b9Oi07ePEJxY2nBjZ6JTEB4PKuGc50DRd2M9DFGFxDN
        ljtPn2GGM29/nXGVKnBY2XL+JUVYzoB8FZqW2tKeUNKGqPrZTHK+Kkpe0FmmHhkatF8OXf
        zjHdaY9xmVkG+lcbKFsorwFSV3d42qozjzg5IFZFfz9fjVRLpXY8oUlTeweDGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680170979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzwYpHAlGFh2jcUeq4SdySXMk9iHC9iZ6y9++anDNoE=;
        b=+bZu9CFZt+G66lzntjHFTd0Mcgmf5VI71aMmmY/JKMq00J0FLiaHi1LdhwmfToTEjgcLkV
        btofhqMghNsItUCg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/coco: Export cc_vendor
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230318115634.9392-2-bp@alien8.de>
References: <20230318115634.9392-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168017097924.404.15209284037516830804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     52e490dcb9e47e8dcf9d915214c6b9d79580d03e
Gitweb:        https://git.kernel.org/tip/52e490dcb9e47e8dcf9d915214c6b9d79580d03e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 18 Mar 2023 12:56:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 30 Mar 2023 11:59:58 +02:00

x86/coco: Export cc_vendor

It will be used in different checks in future changes. Export it
directly and drop the setter as it is a __ro_after_init variable anyway.

No functional changes.

[ tglx: Add accessor function ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de

---
 arch/x86/coco/core.c               | 13 ++++---------
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/include/asm/coco.h        | 16 +++++++++++++---
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f8..684f0a9 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -83,7 +83,7 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
@@ -105,7 +105,7 @@ u64 cc_mkenc(u64 val)
 	 * - for AMD, bit *set* means the page is encrypted
 	 * - for Intel *clear* means encrypted.
 	 */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
 	case CC_VENDOR_INTEL:
@@ -118,7 +118,7 @@ u64 cc_mkenc(u64 val)
 u64 cc_mkdec(u64 val)
 {
 	/* See comment in cc_mkenc() */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
 	case CC_VENDOR_INTEL:
@@ -129,11 +129,6 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
 
-__init void cc_set_vendor(enum cc_vendor v)
-{
-	vendor = v;
-}
-
 __init void cc_set_mask(u64 mask)
 {
 	cc_mask = mask;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 055300e..bab29cb 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -852,7 +852,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a..35d7aa9 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,13 +11,23 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_set_vendor(enum cc_vendor v);
-void cc_set_mask(u64 mask);
-
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern enum cc_vendor cc_vendor;
+
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return cc_vendor;
+}
+
+void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return CC_VENDOR_NONE;
+}
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f36dc2f..9f3fad3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -412,7 +412,7 @@ static void __init ms_hyperv_init_platform(void)
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
-				cc_set_vendor(CC_VENDOR_HYPERV);
+				cc_vendor = CC_VENDOR_HYPERV;
 		}
 	}
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index c6efcf5..bfe22fd 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -612,7 +612,7 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-		cc_set_vendor(CC_VENDOR_AMD);
+		cc_vendor = CC_VENDOR_AMD;
 		cc_set_mask(sme_me_mask);
 	}
 }
