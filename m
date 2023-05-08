Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860B56FAFC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjEHMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEHMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:20:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F213C1D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:20:07 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C5601EC031B;
        Mon,  8 May 2023 14:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683548405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=WHztAeCSsG6Shhf6Urh+iBPqC7PbxdcvM0DnA3cL864=;
        b=Pm34Hu4gbZdZq00BONh4jv+biBTujOkN38ZiBWpTiZl9yPH8ZqrtDkf48Wzxs3CWWPuSpc
        K1sSI7GeoKCeACd2XrbyABtcIYwWbyOOxDCSVbHXzwSCLDhzHxwt+4psEQTB41qvFco93t
        lQClhHkDf94tRS8LTJGTKmijR7TdmzQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/coco: Get rid of accessor functions
Date:   Mon,  8 May 2023 14:19:57 +0200
Message-Id: <20230508121957.32341-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

cc_vendor is __ro_after_init and thus can be used directly.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/core.c               |  2 +-
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/coco.h        | 19 +------------------
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index df10e75be085..eeec9986570e 100644
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
index e146b599260f..971c6cfb15dd 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -852,7 +852,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cc92388b7a99..868f5dea2e10 100644
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
index eb08796002f3..6ae2d16a7613 100644
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
index c6efcf559d88..bfe22fd5a1d7 100644
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
-- 
2.35.1

