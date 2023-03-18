Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C66BF9B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCRL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:56:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDA48E07
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:56:42 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD3401EC0752;
        Sat, 18 Mar 2023 12:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679140600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1yiM+ZywEJs0y5jqWHyyn+4SPJ+MJX1vROyNi47MfE=;
        b=c+BdjKJ+8Cylyi91kR2v+v2UnI2QaAd4q6fkyyOduXowDXnRVy6cGy6yHJ27AFreRlmJMf
        rQQvjl4Of/ZiqeoBMBxkkgdeXEnfsd0vTKAXUpPtVqXX/MvUyt89DzbSnhI1fS8TrhNeKn
        AdKmLjGkW9BVJXjW4vDrg/N4ogdodG0=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/coco: Export cc_vendor
Date:   Sat, 18 Mar 2023 12:56:33 +0100
Message-Id: <20230318115634.9392-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318115634.9392-1-bp@alien8.de>
References: <20230318115634.9392-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It will be used in different checks in future changes. Export it
directly and drop the setter as it is a __ro_after_init variable.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/core.c               | 13 ++++---------
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/include/asm/coco.h        |  2 +-
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..684f0a910475 100644
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
index 055300e08fb3..bab29cbc6680 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -852,7 +852,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..84fbf419989f 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,7 +11,7 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_set_vendor(enum cc_vendor v);
+extern enum cc_vendor cc_vendor;
 void cc_set_mask(u64 mask);
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f36dc2f796c5..9f3fad3e69d5 100644
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
index 88cccd65029d..f54497b8be4b 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -611,7 +611,7 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-		cc_set_vendor(CC_VENDOR_AMD);
+		cc_vendor = CC_VENDOR_AMD;
 		cc_set_mask(sme_me_mask);
 	}
 }
-- 
2.35.1

