Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D591600543
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJQCix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJQCif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216E45F7D;
        Sun, 16 Oct 2022 19:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D5E60EF9;
        Mon, 17 Oct 2022 02:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151CCC433D6;
        Mon, 17 Oct 2022 02:38:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gAZKKPsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665974310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C1RnhU+qbeTJmOrdgcchoL0xQ2lXdIPp6f7lIBb3DcA=;
        b=gAZKKPsVj6ktScocD/1GUBmWDCpN5AJbysa4c/XHY2DEB0k9ta+6YwzFR6LIFF2nEzqpdL
        PD8A7oTOti6UeGlhBVfeHtCnsn+xa9yWVivy7Efc+KCi5NlAuUKYXbPS3h+MuMXjMZX/MD
        6DOnHE6vx1HUoWveuHtowoOHTtvgfEg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fab98d04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Oct 2022 02:38:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     sneves@dei.uc.pt, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: use rejection sampling for uniform bounded random integers
Date:   Sun, 16 Oct 2022 20:37:53 -0600
Message-Id: <20221017023752.3907-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until the very recent commits, many bounded random integers were
calculated using `get_random_u32() % max_plus_one`, which not only
incurs the price of a division -- indicating performance mostly was not
a real issue -- but also does not result in a uniformly distributed
output if max_plus_one is not a power of two. Recent commits moved to
using `prandom_u32_max(max_plus_one)`, which replaces the division with
a faster multiplication, but still does not solve the issue with
non-uniform output.

For some users, maybe this isn't a problem, and for others, maybe it is,
but for the majority of users, probably the question has never been
posed and analyzed, and nobody thought much about it, probably assuming
random is random is random. In other words, the unthinking expectation
of most users is likely that the resultant numbers are uniform.

So we implement here an efficient way of generating uniform bounded
random integers. Through use of compile-time evaluation, and avoiding
divisions as much as possible, this commit introduces no measurable
overhead. At least for hot-path uses tested, any potential difference
was lost in the noise. On both clang and gcc, code generation is pretty
small.

The new function, get_random_u32_below(), lives in random.h, rather than
prandom.h, and has a "get_random_xxx" function name, because it is
suitable for all uses, including cryptography.

In order to be efficient, we implement a kernel-specific variant of
Daniel Lemire's algorithm from "Fast Random Integer Generation in an
Interval", linked below. The kernel's variant takes advantage of
constant folding to avoid divisions entirely in the vast majority of
cases, works on both 32-bit and 64-bit architectures, and requests a
minimal amount of bytes from the RNG.

Link: https://arxiv.org/pdf/1805.10941.pdf
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c   | 13 +++++++++++++
 include/linux/prandom.h | 18 ++----------------
 include/linux/random.h  | 27 +++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2fe28eeb2f38..02b2b3bc1b7f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -160,6 +160,7 @@ EXPORT_SYMBOL(wait_for_random_bytes);
  *	u8 get_random_u8()
  *	u16 get_random_u16()
  *	u32 get_random_u32()
+ *	u32 get_random_u32_below(u32 ceil)
  *	u64 get_random_u64()
  *	unsigned long get_random_long()
  *
@@ -510,6 +511,18 @@ DEFINE_BATCHED_ENTROPY(u16)
 DEFINE_BATCHED_ENTROPY(u32)
 DEFINE_BATCHED_ENTROPY(u64)
 
+u32 __get_random_u32_below(u32 ceil)
+{
+	u64 mult = (u64)ceil * get_random_u32();
+	if (unlikely((u32)mult < ceil)) {
+		u32 bound = -ceil % ceil;
+		while (unlikely((u32)mult < bound))
+			mult = (u64)ceil * get_random_u32();
+	}
+	return mult >> 32;
+}
+EXPORT_SYMBOL(__get_random_u32_below);
+
 #ifdef CONFIG_SMP
 /*
  * This function is called when the CPU is coming up, with entry
diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index e0a0759dd09c..1f4a0de7b019 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -23,24 +23,10 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
 #define prandom_init_once(pcpu_state)			\
 	DO_ONCE(prandom_seed_full_state, (pcpu_state))
 
-/**
- * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
- * @ep_ro: right open interval endpoint
- *
- * Returns a pseudo-random number that is in interval [0, ep_ro). This is
- * useful when requesting a random index of an array containing ep_ro elements,
- * for example. The result is somewhat biased when ep_ro is not a power of 2,
- * so do not use this for cryptographic purposes.
- *
- * Returns: pseudo-random number in interval [0, ep_ro)
- */
+/* Deprecated: use get_random_u32_below() instead. */
 static inline u32 prandom_u32_max(u32 ep_ro)
 {
-	if (__builtin_constant_p(ep_ro <= 1U << 8) && ep_ro <= 1U << 8)
-		return (get_random_u8() * ep_ro) >> 8;
-	if (__builtin_constant_p(ep_ro <= 1U << 16) && ep_ro <= 1U << 16)
-		return (get_random_u16() * ep_ro) >> 16;
-	return ((u64)get_random_u32() * ep_ro) >> 32;
+	return get_random_u32_below(ep_ro);
 }
 
 /*
diff --git a/include/linux/random.h b/include/linux/random.h
index 147a5e0d0b8e..54b0fa687c32 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -51,6 +51,33 @@ static inline unsigned long get_random_long(void)
 #endif
 }
 
+u32 __get_random_u32_below(u32 ceil);
+/* Returns a random integer in the interval [0, ceil), with uniform distribution. */
+static inline u32 get_random_u32_below(u32 ceil)
+{
+	if (!__builtin_constant_p(ceil))
+		return __get_random_u32_below(ceil);
+
+	BUILD_BUG_ON_MSG(!ceil, "get_random_u32_below() must take ceil > 0");
+	if (ceil <= 1)
+		return 0;
+	for (;;) {
+		if (ceil <= 1U << 8) {
+			u32 mult = ceil * get_random_u8();
+			if (likely(is_power_of_2(ceil) || (u8)mult >= (1U << 8) % ceil))
+				return mult >> 8;
+		} else if (ceil <= 1U << 16) {
+			u32 mult = ceil * get_random_u16();
+			if (likely(is_power_of_2(ceil) || (u16)mult >= (1U << 16) % ceil))
+				return mult >> 16;
+		} else {
+			u64 mult = (u64)ceil * get_random_u32();
+			if (likely(is_power_of_2(ceil) || (u32)mult >= -ceil % ceil))
+				return mult >> 32;
+		}
+	}
+}
+
 /*
  * On 64-bit architectures, protect against non-terminated C string overflows
  * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
-- 
2.37.3

