Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B15EF38A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiI2KbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiI2KbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:31:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDC12AEF6;
        Thu, 29 Sep 2022 03:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D59ACE2165;
        Thu, 29 Sep 2022 10:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E296C433D6;
        Thu, 29 Sep 2022 10:31:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZGVo5oIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664447464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h81hop0B1+xC7B49mum+yJfc8MsW0yx1h63GCp9GbX0=;
        b=ZGVo5oIPwO8k0ZCAj61ZkruJKe3SGg+nTBUvLkVnBYuR5ud4KF937Q/pVvImUWXCcBZFCX
        Jk6kZrC7B4AW7WcGH06OkP7M0FXCHQB0FtXmVghCm+g8JFS8gJbT8Ua0PyfhwDpEpkfzzY
        lfHfE+7WBwtk+/mz+BeEJ8YVVy/zpHw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3102c19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Sep 2022 10:31:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marco Elver <elver@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] prandom: make use of smaller types in prandom_u32_max
Date:   Thu, 29 Sep 2022 12:30:59 +0200
Message-Id: <20220929103059.277230-1-Jason@zx2c4.com>
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

When possible at compile-time, make use of smaller types in
prandom_u32_max(), so that we can use smaller batches from random.c,
which in turn leads to a 2x or 4x performance boost. This makes a
difference, for example, in kfence, which needs a fast stream of small
numbers (booleans).

At the same time, we use the occasion to update the old documentation on
these functions. prandom_u32() and prandom_bytes() have direct
replacements now in random.h, while prandom_u32_max() remains useful as
a prandom.h function, since it's not cryptographically secure by virtue
of not being evenly distributed.

Cc: Marco Elver <elver@google.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/prandom.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index deace5fb4e62..78db003bc290 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -12,11 +12,13 @@
 #include <linux/percpu.h>
 #include <linux/random.h>
 
+/* Deprecated: use get_random_u32 instead. */
 static inline u32 prandom_u32(void)
 {
 	return get_random_u32();
 }
 
+/* Deprecated: use get_random_bytes instead. */
 static inline void prandom_bytes(void *buf, size_t nbytes)
 {
 	return get_random_bytes(buf, nbytes);
@@ -37,17 +39,20 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
  * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
  * @ep_ro: right open interval endpoint
  *
- * Returns a pseudo-random number that is in interval [0, ep_ro). Note
- * that the result depends on PRNG being well distributed in [0, ~0U]
- * u32 space. Here we use maximally equidistributed combined Tausworthe
- * generator, that is, prandom_u32(). This is useful when requesting a
- * random index of an array containing ep_ro elements, for example.
+ * Returns a pseudo-random number that is in interval [0, ep_ro). This is
+ * useful when requesting a random index of an array containing ep_ro elements,
+ * for example. The result is somewhat biased when ep_ro is not a power of 2,
+ * so do not use this for cryptographic purposes.
  *
  * Returns: pseudo-random number in interval [0, ep_ro)
  */
 static inline u32 prandom_u32_max(u32 ep_ro)
 {
-	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
+	if (__builtin_constant_p(ep_ro <= 1U << 8) && ep_ro <= 1U << 8)
+		return (get_random_u8() * ep_ro) >> 8;
+	if (__builtin_constant_p(ep_ro <= 1U << 16) && ep_ro <= 1U << 16)
+		return (get_random_u16() * ep_ro) >> 16;
+	return ((u64)get_random_u32() * ep_ro) >> 32;
 }
 
 /*
-- 
2.37.3

