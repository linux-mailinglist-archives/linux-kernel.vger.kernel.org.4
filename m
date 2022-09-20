Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9915BE7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiITN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiITN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA9C5A;
        Tue, 20 Sep 2022 06:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C34C62A12;
        Tue, 20 Sep 2022 13:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13583C433C1;
        Tue, 20 Sep 2022 13:56:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P4ADW90z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663682161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lg6bMazNsMGmwBmvyDVUmdouveDcQiF3/T6/HfWGCq4=;
        b=P4ADW90zfPBvIJ/4JO7gj/gO3ko/G55AmKPTkD074x8FlRQVArvsxfi0x/ZNHl2jpdUPl4
        I48K+6bN3dpZO58y5AslSAnLPt5jyLiDf+G9zQkhhVTaeeQZgYVoWJBZbPVjs4Sy7LyPYT
        yoPLC0DETnvT9hE1+oAP2qv133hJJqE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29868528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Sep 2022 13:56:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] random: use hwgenerator randomness more frequently at early boot
Date:   Tue, 20 Sep 2022 15:54:58 +0200
Message-Id: <20220920135456.2766285-1-Jason@zx2c4.com>
In-Reply-To: <20220904101753.3050-1-linux@dominikbrodowski.net>
References: 
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

From: Dominik Brodowski <linux@dominikbrodowski.net>

Mix in randomness from hw-rng sources more frequently during early
boot, approximately once for every rng reseed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Dominik - I incorporated the refactoring mentioned on the mailing list.
Hopefully this is okay with you. Holler if I got something wrong! -Jason

 drivers/char/random.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c8cc23515568..16e0c5f6cf2f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -260,25 +260,23 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 }
 
 /*
- * Return whether the crng seed is considered to be sufficiently old
- * that a reseeding is needed. This happens if the last reseeding
- * was CRNG_RESEED_INTERVAL ago, or during early boot, at an interval
+ * Return the interval until the next reseeding, which is normally
+ * CRNG_RESEED_INTERVAL, but during early boot, it is at an interval
  * proportional to the uptime.
  */
-static bool crng_has_old_seed(void)
+static unsigned int crng_reseed_interval(void)
 {
 	static bool early_boot = true;
-	unsigned long interval = CRNG_RESEED_INTERVAL;
 
 	if (unlikely(READ_ONCE(early_boot))) {
 		time64_t uptime = ktime_get_seconds();
 		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
 			WRITE_ONCE(early_boot, false);
 		else
-			interval = max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
-					 (unsigned int)uptime / 2 * HZ);
+			return max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
+				     (unsigned int)uptime / 2 * HZ);
 	}
-	return time_is_before_jiffies(READ_ONCE(base_crng.birth) + interval);
+	return CRNG_RESEED_INTERVAL;
 }
 
 /*
@@ -320,7 +318,7 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	 * If the base_crng is old enough, we reseed, which in turn bumps the
 	 * generation counter that we check below.
 	 */
-	if (unlikely(crng_has_old_seed()))
+	if (unlikely(time_is_before_jiffies(READ_ONCE(base_crng.birth) + crng_reseed_interval())))
 		crng_reseed();
 
 	local_lock_irqsave(&crngs.lock, flags);
@@ -866,11 +864,11 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 	credit_init_bits(entropy);
 
 	/*
-	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
-	 * we're not yet initialized.
+	 * Throttle writing to once every reseed interval, unless we're not yet
+	 * initialized.
 	 */
 	if (!kthread_should_stop() && crng_ready())
-		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
+		schedule_timeout_interruptible(crng_reseed_interval());
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
-- 
2.37.3

