Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1F660F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiJ0JaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiJ0J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:29:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D8B48A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PZvHoRnYLkmlxJjyek8hLDrtaYqtEqTyI6XZhXt7/Jk=; b=NRT8TsHhHmJXeBEeGB/xo3YHig
        aiHGaiZnT1HEwqIalZqrgZTFO+iFDJhwS42V7jGAXUUeViKhGEmcUQJLJkb7ND8qGa9OqKOjqb9Gl
        GDyJwpULNDuLYIar7LqL0046DKDnWsaVvGFpHBGT5w/EfbTPo1PP7RXtRPwsy7jrh389saYNc2STx
        jyVSG3Y2M1if+AskXZ+NRvUHNxIU/M4SFRDn9d+/cgCZa3if70TRLGYe+0xDzjaPCMj++6jf5GPrV
        l9vuKE9uff9hyR5B2CHDuzweXYD4M56albzMFTW4LuvC8XDNoqY4BKbUlq0Y/mtcDebsR7RbpHcD3
        AOAqe+cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onzCd-006p4L-2m; Thu, 27 Oct 2022 09:29:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 910FB300454;
        Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7C0652C450476; Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Message-ID: <20221027092842.765195516@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:28:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] x86/cfi: Add boot time hash randomization
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

In order to avoid known hashes (from knowing the boot image),
randomize the CFI hashes with a per-boot random seed.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |  120 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -711,6 +711,24 @@ enum cfi_mode {
 };
 
 static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
+static bool cfi_rand __ro_after_init = true;
+static u32  cfi_seed __ro_after_init;
+
+/*
+ * Re-hash the CFI hash with a boot-time seed while making sure the result is
+ * not a valid ENDBR instruction.
+ */
+static u32 cfi_rehash(u32 hash)
+{
+	hash ^= cfi_seed;
+	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+		bool lsb = hash & 1;
+		hash >>= 1;
+		if (lsb)
+			hash ^= 0x80200003;
+	}
+	return hash;
+}
 
 static __init int cfi_parse_cmdline(char *str)
 {
@@ -728,10 +746,13 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_DEFAULT;
 		} else if (!strcmp(str, "off")) {
 			cfi_mode = CFI_OFF;
+			cfi_rand = false;
 		} else if (!strcmp(str, "kcfi")) {
 			cfi_mode = CFI_KCFI;
 		} else if (!strcmp(str, "fineibt")) {
 			cfi_mode = CFI_FINEIBT;
+		} else if (!strcmp(str, "norand")) {
+			cfi_rand = false;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -856,7 +877,50 @@ static int cfi_disable_callers(s32 *star
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
+		hash = cfi_rehash(hash);
+		text_poke_early(addr + 1, &hash, 4);
+	}
+
+	return 0;
+}
+
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
@@ -879,6 +943,25 @@ static int cfi_rewrite_preamble(s32 *sta
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
+			hash = -cfi_rehash(hash);
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
@@ -915,31 +998,44 @@ static void __apply_fineibt(s32 *start_r
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


