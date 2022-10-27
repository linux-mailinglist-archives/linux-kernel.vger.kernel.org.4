Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC160F3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiJ0JaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiJ0J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:29:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD571B866
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vAQwSFuGwqx04mJjqCuHpC9VhBTtgDgSbSkN0/TPFU4=; b=XEGecbCNpEF5d5h1y/I1BeKWho
        4ZO1769+2IMfHIyXLdUZLhEvbFYxTVQ5rDM6brI+McCX+xabG5iQ0MPM5K9W7CTXwlZUXBTz7Mjek
        eFmnsPRBm5sdLukARARiYoiwOV2ZOSBWn1Tk38brlIH23u5Uq5yEri7ZonWzFObhkERMbauvt0Ywu
        c+y+Q2aCZqZqHq8V5MLD48qilK1t98oe+Ro6AD8ntwOp9GHxk90+1PgKHFcZYiF/CSwleHzKpA0TR
        Pr9oVyknfSfUD6QDGfg4GMCSmfIQtXQyjcw30V4k+ROmO2n0sfu51A3nUEAqxERT9f14O7+8QyZBI
        yOpQ2ITg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onzCi-0005SA-EL; Thu, 27 Oct 2022 09:29:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F61930041D;
        Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7724E2C450395; Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Message-ID: <20221027092842.699804264@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:28:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] x86/cfi: Boot time selection of CFI scheme
References: <20221027092812.185993858@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "cfi=" boot parameter to allow people to select a CFI scheme
at boot time. Mostly useful for development / debugging.

Requested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |  103 +++++++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 20 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -702,6 +702,47 @@ void __init_or_module noinline apply_ibt
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
@@ -868,30 +909,52 @@ static void __apply_fineibt(s32 *start_r
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
-
-	ret = cfi_rewrite_preamble(start_cfi, end_cfi);
-	if (ret)
-		goto err;
-
-	ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
-	if (ret)
-		goto err;
+	case CFI_KCFI:
+		if (builtin)
+			pr_info("Using kCFI\n");
+		return;
 
-	if (builtin)
-		pr_info("Using FineIBT CFI\n");
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
+
+		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
 
-	return;
+		if (builtin)
+			pr_info("Using FineIBT CFI\n");
+		return;
+
+	default:
+		break;
+	}
 
 err:
 	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");


