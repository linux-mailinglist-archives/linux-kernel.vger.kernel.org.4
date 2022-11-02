Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995C615F73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKBJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiKBJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2E647F;
        Wed,  2 Nov 2022 02:20:01 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:19:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbDQoEBEQalCcwDd/vLZU9zQRL0nPpNFi0s6qMisUj8=;
        b=fkLJBbOiGINc6f9ul8djcHRy9BA4lVKem1UKYqMBlQ3ZMRPVgoxfk68h9BV2rbFw3uMz30
        58evs+3WmwE18Eu0LiM9L2UohCE9zeHfPEPo32vbCaHmi5rwcWBR4xr7DiYzT3mgR7CuVP
        DqBh5uGOSqMIEjRYsf4NOnQt40ry+EQUAyLfdLgx0Ja5hGBWMtjI83zIconaGTovA530z5
        72QJRY9HjmukgUJoLntgV9P2oPmRnpyGAsH6agz/upEjEBTGBGODwfzthdc6jKBTW4S9mg
        PT6HskhRfHD+HkNhEiSLsD/f/aH/WClCAkPZTCqIl7MZP7VVPMJVcK3hkpQiiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbDQoEBEQalCcwDd/vLZU9zQRL0nPpNFi0s6qMisUj8=;
        b=GmFA558kIoO3Zl1nJhEI9lcVkd8Eve38ajir3KA6jYPehCnCe3XHCg0eiBEPs1tUPQBUfX
        ytcjuB4STz1vaBBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Add boot time hash randomization
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221027092842.765195516@infradead.org>
References: <20221027092842.765195516@infradead.org>
MIME-Version: 1.0
Message-ID: <166738079813.7716.11159577231772690253.tip-bot2@tip-bot2>
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

Commit-ID:     0c3e806ec0f9771fa1f34c60499097d9260a8bb7
Gitweb:        https://git.kernel.org/tip/0c3e806ec0f9771fa1f34c60499097d9260a8bb7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Oct 2022 11:28:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:11 +01:00

x86/cfi: Add boot time hash randomization

In order to avoid known hashes (from knowing the boot image),
randomize the CFI hashes with a per-boot random seed.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221027092842.765195516@infradead.org
---
 arch/x86/kernel/alternative.c | 120 +++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9d3b587..aa7f791 100644
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
@@ -728,10 +746,13 @@ static __init int cfi_parse_cmdline(char *str)
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
@@ -856,7 +877,50 @@ static int cfi_disable_callers(s32 *start, s32 *end)
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
@@ -879,6 +943,25 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
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
@@ -915,31 +998,44 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
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
