Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85160339D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJRT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJRT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:57:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9E9FC7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yFK1sDCWMWP48Ez2zYuTyqlegBGlfpemKafjqH7EJlY=; b=oX8X3QGvqB4Tk5I37rI/YJNmus
        vQB+9IWFv5D7jGOT4uipCDeX1rcvI/zbsM7AWcql9+xCBRcObnmmsdcJYx4V//mYqsazwG7IfBen9
        rk8W799yte5J32xwCH4/Hxk+AhgIVKDz+0K6w6U1+uLWpa8cqBgn+w5TSFJfvS99cEp+y9b30dnnu
        ozTF+iTO5cuB/PXNz7pH3QskMPYsAsFzhMc+do9UYZ/620yG3BPsGConibq/JoR5aC8yR46Nh6Jdi
        YyuhZFMJWjJd9pA1qe9BbkCCVT0R5CLXdmz7SFrlKsvV2uKqnXVaaHqi9XFywk4MWUmkUl1L8F8di
        XeQ4QTyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okshg-00Ayu9-7S; Tue, 18 Oct 2022 19:56:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CBDF30012F;
        Tue, 18 Oct 2022 21:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCDF928574AD9; Tue, 18 Oct 2022 21:56:36 +0200 (CEST)
Date:   Tue, 18 Oct 2022 21:56:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210181020.79AF7F7@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> > +config FINEIBT
> > +	def_bool y
> > +	depends on X86_KERNEL_IBT && CFI_CLANG
> > +	select CALL_PADDING
> 
> To that end, can we please make this a prompted choice?

How about something like so instead?

---
Subject: x86/cfi: Boot time selection of CFI scheme
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 18 21:50:54 CEST 2022

Add the "cfi=" boot parameter to allow users to select a scheme at
boot time.

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
