Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8162E21D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiKQQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiKQQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:36:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02D6277
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58479B820FF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8BBC433D6;
        Thu, 17 Nov 2022 16:35:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CE0CB1dB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668702929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GC1gHLi/XytMcjtY6oXEKBPiGw9CciX1C/wh1pF5JzE=;
        b=CE0CB1dB8trKXUhsryGHNZrr3TVEMjKM85BgSjNCIvzxP7kJrbzpQUglv9G4lQYQya5jJb
        zWJ9Vn1/cz27UFQXHbacQwkg9E7NFGAqtagCbbgxJRgDwkT2BmkIoLYamBnR205pncG8EN
        Alcd0EZH5WI2MD74Jl9/So0cuVVyHto=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a9db1f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 16:35:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu, kees@kernel.org,
        linux@armlinux.org.uk, ydroneaud@opteya.com,
        gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: add helpers for random numbers with given floor or range
Date:   Thu, 17 Nov 2022 17:35:12 +0100
Message-Id: <20221117163511.2186302-1-Jason@zx2c4.com>
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

Now that we have get_random_u32_below(), it's nearly trivial to make
inline helpers to compute get_random_u32_above() and
get_random_u32_inclusive(), which will help clean up open coded loops
and manual computations throughout the tree.

One snag is that in order to make get_random_u32_inclusive() operate on
closed intervals, we have to do some (unlikely) special case handling if
get_random_u32_interval(0, U32_MAX) is called. The least expensive way
of doing this is actually to adjust the slowpath of
get_random_u32_below() to have its undefined 0 result just return the
output of get_random_u32().

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Rename get_random_u32_between() to get_random_u32_inclusive(), and
  make it a closed interval.

 drivers/char/random.c  | 17 ++++++++++++++++-
 include/linux/random.h | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6f323344d0b9..140dbd557dbc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -161,6 +161,8 @@ EXPORT_SYMBOL(wait_for_random_bytes);
  *	u16 get_random_u16()
  *	u32 get_random_u32()
  *	u32 get_random_u32_below(u32 ceil)
+ *	u32 get_random_u32_above(u32 floor)
+ *	u32 get_random_u32_inclusive(u32 ceil, u32 floor)
  *	u64 get_random_u64()
  *	unsigned long get_random_long()
  *
@@ -522,7 +524,20 @@ u32 __get_random_u32_below(u32 ceil)
 	 * of `-ceil % ceil` is analogous to `2^32 % ceil`, but is computable
 	 * in 32-bits.
 	 */
-	u64 mult = (u64)ceil * get_random_u32();
+	u64 mult;
+
+	/*
+	 * This function is technically undefined for ceil == 0, and in fact
+	 * for the non-underscored constant version in the header, we build bug
+	 * on that. But for the non-constant case, it's convenient to have that
+	 * evaluate to being a straight call to get_random_u32(), so that
+	 * get_random_u32_inclusive() can work over its whole range without
+	 * undefined behavior.
+	 */
+	if (unlikely(!ceil))
+		return get_random_u32();
+
+	mult = (u64)ceil * get_random_u32();
 	if (unlikely((u32)mult < ceil)) {
 		u32 bound = -ceil % ceil;
 		while (unlikely((u32)mult < bound))
diff --git a/include/linux/random.h b/include/linux/random.h
index 3a82c0a8bc46..bd954ecbef90 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -91,6 +91,31 @@ static inline u32 get_random_u32_below(u32 ceil)
 	}
 }
 
+/*
+ * Returns a random integer in the interval (floor, U32_MAX], with uniform
+ * distribution, suitable for all uses. Fastest when floor is a constant, but
+ * still fast for variable floor as well.
+ */
+static inline u32 get_random_u32_above(u32 floor)
+{
+	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && floor == U32_MAX,
+			 "get_random_u32_above() must take floor < U32_MAX");
+	return floor + 1 + get_random_u32_below(U32_MAX - floor);
+}
+
+/*
+ * Returns a random integer in the interval [floor, ceil], with uniform
+ * distribution, suitable for all uses. Fastest when floor and ceil are
+ * constant, but still fast for variable floor and ceil as well.
+ */
+static inline u32 get_random_u32_inclusive(u32 floor, u32 ceil)
+{
+	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && __builtin_constant_p(ceil) &&
+			 (floor > ceil || ceil - floor == U32_MAX),
+			 "get_random_u32_inclusive() must take floor <= ceil");
+	return floor + get_random_u32_below(ceil - floor + 1);
+}
+
 /*
  * On 64-bit architectures, protect against non-terminated C string overflows
  * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
-- 
2.38.1

