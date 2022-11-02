Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20048615F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiKBJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKBJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E36559;
        Wed,  2 Nov 2022 02:20:02 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:19:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0/Uwa8jfAwPDspc7I3TVeBWmRR4zAQ5KLrFDwfIWv0=;
        b=cJo3SRmeKTPfbvvZXBgWBd6CSAbmONHrz5oCPV4r4pMis8KdKmav07GMLlPy9UctLwsxXZ
        4to5UolzytFOuVHhRqruJXcXDfOlVbfD4BFVHfnKsfbt/tEI0eN4gsouo36UqBaEwgturE
        PUQFVGO2LyKrChruSCs6gGmA91SOba/XHC1+SEN0+h7qMRjmpUCYQRuvjbVCAXZWAyMGbl
        PFTrTTCbRlwhZ4wwEJK1thPGfYlGj/esEfy84Uf5/e+uaBQuIKpSAIR0fsVCUbZmifkRFe
        zmL2vxsO83oKnpyled9SZtQCxENNNfYRxywQA6+m9WlEB1PUSZzHErHgn4pHQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0/Uwa8jfAwPDspc7I3TVeBWmRR4zAQ5KLrFDwfIWv0=;
        b=yre+TCl2UDidyQb2FxFXimmhkZz68oFOIshimfDweK30gtZUgmO5aG40oH+MaQgdKk5teu
        9RVqr60uv5/VRWDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Boot time selection of CFI scheme
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221027092842.699804264@infradead.org>
References: <20221027092842.699804264@infradead.org>
MIME-Version: 1.0
Message-ID: <166738079939.7716.7013729504795673439.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     082c4c815252ea333b0f3a51e336df60c2314fe2
Gitweb:        https://git.kernel.org/tip/082c4c815252ea333b0f3a51e336df60c2314fe2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Oct 2022 11:28:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:11 +01:00

x86/cfi: Boot time selection of CFI scheme

Add the "cfi=" boot parameter to allow people to select a CFI scheme
at boot time. Mostly useful for development / debugging.

Requested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221027092842.699804264@infradead.org
---
 arch/x86/kernel/alternative.c |  99 +++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 91b0e63..9d3b587 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -702,6 +702,47 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
 #endif /* CONFIG_X86_KERNEL_IBT */
 
 #ifdef CONFIG_FINEIBT
+
+enum cfi_mode {
+	CFI_DEFAULT,
+	CFI_OFF,
+	CFI_KCFI,
+	CFI_FINEIBT,
+};
+
+static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
+
+static __init int cfi_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	while (str) {
+		char *next = strchr(str, ',');
+		if (next) {
+			*next = 0;
+			next++;
+		}
+
+		if (!strcmp(str, "auto")) {
+			cfi_mode = CFI_DEFAULT;
+		} else if (!strcmp(str, "off")) {
+			cfi_mode = CFI_OFF;
+		} else if (!strcmp(str, "kcfi")) {
+			cfi_mode = CFI_KCFI;
+		} else if (!strcmp(str, "fineibt")) {
+			cfi_mode = CFI_FINEIBT;
+		} else {
+			pr_err("Ignoring unknown cfi option (%s).", str);
+		}
+
+		str = next;
+	}
+
+	return 0;
+}
+early_param("cfi", cfi_parse_cmdline);
+
 /*
  * kCFI						FineIBT
  *
@@ -868,30 +909,52 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
 		return;
 
-	if (!HAS_KERNEL_IBT || !cpu_feature_enabled(X86_FEATURE_IBT))
+	if (cfi_mode == CFI_DEFAULT) {
+		cfi_mode = CFI_KCFI;
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+			cfi_mode = CFI_FINEIBT;
+	}
+
+	switch (cfi_mode) {
+	case CFI_OFF:
+		ret = cfi_disable_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
+
+		if (builtin)
+			pr_info("Disabling CFI\n");
 		return;
 
-	/*
-	 * Rewrite the callers to not use the __cfi_ stubs, such that we might
-	 * rewrite them. This disables all CFI. If this succeeds but any of the
-	 * later stages fails, we're without CFI.
-	 */
-	ret = cfi_disable_callers(start_retpoline, end_retpoline);
-	if (ret)
-		goto err;
+	case CFI_KCFI:
+		if (builtin)
+			pr_info("Using kCFI\n");
+		return;
 
-	ret = cfi_rewrite_preamble(start_cfi, end_cfi);
-	if (ret)
-		goto err;
+	case CFI_FINEIBT:
+		/*
+		 * Rewrite the callers to not use the __cfi_ stubs, such that we might
+		 * rewrite them. This disables all CFI. If this succeeds but any of the
+		 * later stages fails, we're without CFI.
+		 */
+		ret = cfi_disable_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
+
+		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
+		if (ret)
+			goto err;
 
-	ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
-	if (ret)
-		goto err;
+		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
 
-	if (builtin)
-		pr_info("Using FineIBT CFI\n");
+		if (builtin)
+			pr_info("Using FineIBT CFI\n");
+		return;
 
-	return;
+	default:
+		break;
+	}
 
 err:
 	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
