Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4456FC45F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjEIK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjEIK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:58:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F267A5CD;
        Tue,  9 May 2023 03:58:20 -0700 (PDT)
Date:   Tue, 09 May 2023 10:58:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKtyLkl5wfWVJ9mnQLv/tgAJtfNUubeqaAT2EQqmslQ=;
        b=0gOPOvOrFomVE3Zu3RfjgPz2OFRtwg18g64enWz8lqGj4NrLE+qxBptSLGP/cfjUWGdFBu
        97fit1+LYb8AqpVRkdNujyuK3NcnViaiwgNmlAvjpvJJjnsTvpkSFJ2Og1dx6q8YmM13x8
        x7NEfiTZs8+IcA2AwLA7AHf+EnbPHUXZu/q03kPz1Nmn8TT3oWe0OmvSJvJjtj99FzNedF
        i+EOAA8m1T3EWHhf2ZP7hFbgHC0glaG5G2VDlO8JsECHvmOUz4w4i5FOWEvLIVyx6u3qOe
        Gq8C0O63tNGxExb4JydQ1QRh1L/FPIAAiRmtGtn/mD2J4Jl+FUugU2eXmhhpjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKtyLkl5wfWVJ9mnQLv/tgAJtfNUubeqaAT2EQqmslQ=;
        b=9L15JitIH4tLlI6E0F4Dh1hz0UmWyRVCz4ZV5dnCeJgS8blB5swclKwejD6HH0cwbmlfc9
        I+yM9sdapDKcM3Dg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/coco: Get rid of accessor functions
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230508121957.32341-1-bp@alien8.de>
References: <20230508121957.32341-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168362989823.404.6000170263756196115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     da86eb9611840772a459693832e54c63cbcc040a
Gitweb:        https://git.kernel.org/tip/da86eb9611840772a459693832e54c63cbcc040a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 08 May 2023 12:44:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 May 2023 12:53:16 +02:00

x86/coco: Get rid of accessor functions

cc_vendor is __ro_after_init and thus can be used directly.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230508121957.32341-1-bp@alien8.de
---
 arch/x86/coco/core.c               |  2 +-
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/coco.h        | 19 +------------------
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index df10e75..eeec998 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-enum cc_vendor cc_vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 static u64 cc_mask __ro_after_init;
 
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b59..971c6cf 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -852,7 +852,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cc92388..868f5de 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -364,7 +364,7 @@ void __init hv_vtom_init(void)
 	 * Set it here to indicate a vTOM VM.
 	 */
 	sev_status = MSR_AMD64_SNP_VTOM;
-	cc_set_vendor(CC_VENDOR_AMD);
+	cc_vendor = CC_VENDOR_AMD;
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index eb08796..6ae2d16 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -10,30 +10,13 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 extern enum cc_vendor cc_vendor;
 
-static inline enum cc_vendor cc_get_vendor(void)
-{
-	return cc_vendor;
-}
-
-static inline void cc_set_vendor(enum cc_vendor vendor)
-{
-	cc_vendor = vendor;
-}
-
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
-static inline enum cc_vendor cc_get_vendor(void)
-{
-	return CC_VENDOR_NONE;
-}
-
-static inline void cc_set_vendor(enum cc_vendor vendor) { }
-
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
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
