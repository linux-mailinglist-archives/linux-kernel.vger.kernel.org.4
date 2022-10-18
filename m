Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F36033AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJRT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJRT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:59:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA68C475
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ezxzfJZgTZ/GgkQMN113woujD9F8wfeJyX3f7NbCTps=; b=SYNYN4etrUp3/NFWJCx09mzGdy
        QKV0hDDd98KefCWC/PF0Bn2bpEOjKdF/8YghMgIiLovUwlXE2JNNIYyHUcvfLEj7TqVGc2wg8mLDe
        LzMPU/39tRpRQRcX8r/BttTnw4eDuSyi0LMR8gQTpDbXUEkDxo4llZoJNF5CjxGpVJlEnKVvugHo1
        Z8M6VYIl6bZnSTsTzqTBB/5+LpDCT5Q7f/BFcasTRRBBIR/lBZ68SdeNzBdB01DhfzSYBcd2mCXw5
        9d/fhP5HT35YSmUsCTXXy4xHWkkpTWCC/H2b+NaDGwFC9kvLC+n6Ox6cnGiz/gjgQzJWMsS10hy4F
        qVMuGcgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oksk0-00Ayxw-06; Tue, 18 Oct 2022 19:59:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F292300202;
        Tue, 18 Oct 2022 21:59:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC83B28574AD9; Tue, 18 Oct 2022 21:59:02 +0200 (CEST)
Date:   Tue, 18 Oct 2022 21:59:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
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

> An improvement for kCFI would be to mutate all the hashes both at build
> time (perhaps using the same seed infrastructure that randstruct depends
> on for sharing a seed across compilation units), and at boot time, so
> an actual .text content exposure is needed to find the target hash value.

What's the purpose of the build time randomization? Find here the boot
time randomization (on top of my other patch).

---
Subject: x86/cfi: Add boot time hash randomization
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 18 21:50:58 CEST 2022

In order to avoid known hashes (from knowing the boot image),
randomize the CFI hashes with a per-boot random seed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |  104 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -711,6 +711,8 @@ enum cfi_mode {
 };
 
 static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
+static bool cfi_rand __ro_after_init = true;
+static u32  cfi_seed __ro_after_init;
 
 static __init int cfi_parse_cmdline(char *str)
 {
@@ -732,6 +734,8 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_KCFI;
 		} else if (!strcmp(str, "fineibt")) {
 			cfi_mode = CFI_FINEIBT;
+		} else if (!strcmp(str, "norand")) {
+			cfi_rand = false;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -856,7 +860,50 @@ static int cfi_disable_callers(s32 *star
 	return 0;
 }
 
+static int cfi_enable_callers(s32 *start, s32 *end)
+{
+	/*
+	 * Re-enable kCFI, undo what cfi_disable_callers() did.
+	 */
+	const u8 mov[] = { 0x41, 0xba };
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		addr -= fineibt_caller_size;
+		hash = decode_caller_hash(addr);
+		if (!hash) /* nocfi callers */
+			continue;
+
+		text_poke_early(addr, mov, 2);
+	}
+
+	return 0;
+}
+
 /* .cfi_sites */
+static int cfi_rand_preamble(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		hash = decode_preamble_hash(addr);
+		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
+			 addr, addr, 5, addr))
+			return -EINVAL;
+
+		hash ^= cfi_seed;
+		text_poke_early(addr + 1, &hash, 4);
+	}
+
+	return 0;
+}
+
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
@@ -879,6 +926,26 @@ static int cfi_rewrite_preamble(s32 *sta
 }
 
 /* .retpoline_sites */
+static int cfi_rand_callers(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 hash;
+
+		addr -= fineibt_caller_size;
+		hash = decode_caller_hash(addr);
+		if (hash) {
+			hash ^= cfi_seed;
+			hash = -hash;
+			text_poke_early(addr + 2, &hash, 4);
+		}
+	}
+
+	return 0;
+}
+
 static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
@@ -915,31 +982,44 @@ static void __apply_fineibt(s32 *start_r
 			cfi_mode = CFI_FINEIBT;
 	}
 
-	switch (cfi_mode) {
-	case CFI_OFF:
-		ret = cfi_disable_callers(start_retpoline, end_retpoline);
+	/*
+	 * Rewrite the callers to not use the __cfi_ stubs, such that we might
+	 * rewrite them. This disables all CFI. If this succeeds but any of the
+	 * later stages fails, we're without CFI.
+	 */
+	ret = cfi_disable_callers(start_retpoline, end_retpoline);
+	if (ret)
+		goto err;
+
+	if (cfi_rand) {
+		if (builtin)
+			cfi_seed = get_random_u32();
+
+		ret = cfi_rand_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
+		ret = cfi_rand_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
+	}
+
+	switch (cfi_mode) {
+	case CFI_OFF:
 		if (builtin)
 			pr_info("Disabling CFI\n");
 		return;
 
 	case CFI_KCFI:
+		ret = cfi_enable_callers(start_retpoline, end_retpoline);
+		if (ret)
+			goto err;
+
 		if (builtin)
 			pr_info("Using kCFI\n");
 		return;
 
 	case CFI_FINEIBT:
-		/*
-		 * Rewrite the callers to not use the __cfi_ stubs, such that we might
-		 * rewrite them. This disables all CFI. If this succeeds but any of the
-		 * later stages fails, we're without CFI.
-		 */
-		ret = cfi_disable_callers(start_retpoline, end_retpoline);
-		if (ret)
-			goto err;
-
 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
