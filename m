Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B506FC460
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjEIK6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjEIK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:58:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF84468B;
        Tue,  9 May 2023 03:58:20 -0700 (PDT)
Date:   Tue, 09 May 2023 10:58:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vth1xaQIr+Eg1Q6THTe0FvcGwHPKlzQCXGB9ec6bi4g=;
        b=Xyi18DXeLMe+E+BUjCF7L092Wt6RHN1vVTrgvGa3OYZLSQj9GGHgw09KQWX7GS5pYGMMMq
        xjm3DeSOemCzK8kFf0fqAeQpJNfd9Tu42KxxaC9cMcP8bd4Gse4DKnzrkrSnIPsfHxXGmA
        0BYYwQG7rBCrOY2IgUCcLgrktkJxlVJr4lyAm9dF1ooEKvm1s3DGBLtF8DYGAmWnIVcQB7
        xC7CT/hAITznJ/+LV2iT0YWz9Dj8SyR9+k6INr6dBNzhYB3CoN7zX5rEHGLDtyR0syCr7i
        xkoddZx32JV3V/yaM2DBugwqKz/4hE6PHd3UmrEFarOGdYEyMPDopNkb3sC8Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683629899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vth1xaQIr+Eg1Q6THTe0FvcGwHPKlzQCXGB9ec6bi4g=;
        b=kOpk2YYLbbayMnbCec8wPLCQR50/87DuZ3xIxI9QvMZFDpKnD10dxFcb1+A45FwkIR/dtp
        UJhzoZeRm45xnpDQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Get rid of special sev_es_enable_key
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328201712.25852-3-bp@alien8.de>
References: <20230328201712.25852-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168362989858.404.6772340018000398416.tip-bot2@tip-bot2>
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

Commit-ID:     f710ac5442f630a7b8dc25e30e25d30a4a38e796
Gitweb:        https://git.kernel.org/tip/f710ac5442f630a7b8dc25e30e25d30a4a38e796
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 28 Mar 2023 22:17:12 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 11:49:29 +02:00

x86/sev: Get rid of special sev_es_enable_key

A SEV-ES guest is active on AMD when CC_ATTR_GUEST_STATE_ENCRYPT is set.
I.e., MSR_AMD64_SEV, bit 1, SEV_ES_Enabled. So no need for a special
static key.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230328201712.25852-3-bp@alien8.de
---
 arch/x86/include/asm/sev.h | 11 +++++++----
 arch/x86/kernel/sev.c      |  5 -----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9..f14060c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -14,6 +14,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 #include <asm/bootparam.h>
+#include <asm/coco.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -136,24 +137,26 @@ struct snp_secrets_page_layout {
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
index b031244..0ec0d96 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -113,8 +113,6 @@ struct ghcb_state {
 };
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
-
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 struct sev_config {
@@ -1395,9 +1393,6 @@ void __init sev_es_init_vc_handling(void)
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 	}
 
-	/* Enable SEV-ES special handling */
-	static_branch_enable(&sev_es_enable_key);
-
 	/* Initialize per-cpu GHCB pages */
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
