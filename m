Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C116BF9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCRL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCRL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:56:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F748E0A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:56:42 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 591961EC0754;
        Sat, 18 Mar 2023 12:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679140601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82g7Dmd0UABgWvJnfHsCsiNT2CdpiGkwWTIS0RC8fuU=;
        b=OTXegHxNDgtAmNZU/gkgcsDsQfTpnbSj0ZsNigwQ4aA97IN5i631IVEtsZS0VoX47veaot
        Zy2pOdVN6Ii7NwMGiINMYi1SIDs3ot8jA5CRAdXRZ45bRNWCW1FiQgJAwj4vmKgCXnkHKV
        p6SsLXTSCbOKEvZAU15yMz0Zu38RTz8=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/sev: Get rid of special sev_es_enable_key
Date:   Sat, 18 Mar 2023 12:56:34 +0100
Message-Id: <20230318115634.9392-3-bp@alien8.de>
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

A SEV-ES guest is active on AMD when CC_ATTR_GUEST_STATE_ENCRYPT is set.
I.e., MSR_AMD64_SEV, bit 1, SEV_ES_Enabled. So no need for a special
static key.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/core.c       |  2 +-
 arch/x86/include/asm/sev.h | 11 +++++++----
 arch/x86/kernel/sev.c      |  5 -----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 684f0a910475..17f2b690a485 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -81,7 +81,7 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
 }
 
-bool cc_platform_has(enum cc_attr attr)
+bool noinstr cc_platform_has(enum cc_attr attr)
 {
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..1335781e4976 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -12,6 +12,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 #include <asm/bootparam.h>
+#include <asm/coco.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -134,24 +135,26 @@ struct snp_secrets_page_layout {
 } __packed;
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
 static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
 {
-	if (static_branch_unlikely(&sev_es_enable_key))
+	if (cc_vendor == CC_VENDOR_AMD &&
+	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_ist_enter(regs);
 }
 static __always_inline void sev_es_ist_exit(void)
 {
-	if (static_branch_unlikely(&sev_es_enable_key))
+	if (cc_vendor == CC_VENDOR_AMD &&
+	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_ist_exit();
 }
 extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
 extern void __sev_es_nmi_complete(void);
 static __always_inline void sev_es_nmi_complete(void)
 {
-	if (static_branch_unlikely(&sev_es_enable_key))
+	if (cc_vendor == CC_VENDOR_AMD &&
+	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..4fdba49b6e38 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -111,8 +111,6 @@ struct ghcb_state {
 };
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
-
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 struct sev_config {
@@ -1393,9 +1391,6 @@ void __init sev_es_init_vc_handling(void)
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 	}
 
-	/* Enable SEV-ES special handling */
-	static_branch_enable(&sev_es_enable_key);
-
 	/* Initialize per-cpu GHCB pages */
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
-- 
2.35.1

