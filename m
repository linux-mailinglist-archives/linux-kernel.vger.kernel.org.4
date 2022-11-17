Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508562E526
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiKQTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbiKQTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:16:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44AA7EC9D;
        Thu, 17 Nov 2022 11:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBAE62227;
        Thu, 17 Nov 2022 19:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE291C433C1;
        Thu, 17 Nov 2022 19:16:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j3kl+t6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668712609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I0gafmthYzLnOBvnICA6dCBwdNQe0eJ+3AfKufxJT4Q=;
        b=j3kl+t6QwEvEzaLFM4ONtkYPyKuftFV+inU7lGfAWvNi7syvRs1LL7XESlt0MCRLO92aAA
        kApGl1lIYo/Cc4XTOwqaVpC8QkvWAGqSTzUwPR/AM/1UWh+lsa0vdXVnLpUue/i1qUpsM6
        3pfgyHAQ1Vo/siCdrl7o52b6a4YDTxI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dbfb5ef9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 19:16:48 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] random: reseed in delayed work rather than on-demand
Date:   Thu, 17 Nov 2022 20:16:43 +0100
Message-Id: <20221117191643.2303366-1-Jason@zx2c4.com>
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

Currently, we reseed when random bytes are requested, if the current
seed is too old. Since random bytes can be requested from all contexts,
including hard IRQ, this means sometimes we wind up adding a bit of
latency to hard IRQ. This was so much of a problem on s390x that now
s390x just doesn't provide its architectural RNG from hard IRQ context,
so we miss out in that case.

Instead, let's just schedule a persistent delayed work, so that the
reseeding and potentially expensive operations will always happen from
process context, reducing unexpected latencies from hard IRQ.

This also has the nice effect of accumulating a transcript of random
inputs over time, since it means that we amass more input values. And it
should make future vDSO integration a bit easier.

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Juergen Christ <jchrist@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c901d99c3246..a8127530f88d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -182,7 +182,6 @@ enum {
 
 static struct {
 	u8 key[CHACHA_KEY_SIZE] __aligned(__alignof__(long));
-	unsigned long birth;
 	unsigned long generation;
 	spinlock_t lock;
 } base_crng = {
@@ -200,16 +199,41 @@ static DEFINE_PER_CPU(struct crng, crngs) = {
 	.lock = INIT_LOCAL_LOCK(crngs.lock),
 };
 
+/*
+ * Return the interval until the next reseeding, which is normally
+ * CRNG_RESEED_INTERVAL, but during early boot, it is at an interval
+ * proportional to the uptime.
+ */
+static unsigned int crng_reseed_interval(void)
+{
+	static bool early_boot = true;
+
+	if (unlikely(READ_ONCE(early_boot))) {
+		time64_t uptime = ktime_get_seconds();
+		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
+			WRITE_ONCE(early_boot, false);
+		else
+			return max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
+				     (unsigned int)uptime / 2 * HZ);
+	}
+	return CRNG_RESEED_INTERVAL;
+}
+
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
 static void extract_entropy(void *buf, size_t len);
 
 /* This extracts a new crng key from the input pool. */
-static void crng_reseed(void)
+static void crng_reseed(struct work_struct *work)
 {
+	static DECLARE_DELAYED_WORK(next_reseed, crng_reseed);
 	unsigned long flags;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
 
+	/* Immediately schedule the next reseeding, so that it fires sooner rather than later. */
+	if (likely(system_unbound_wq))
+		queue_delayed_work(system_unbound_wq, &next_reseed, crng_reseed_interval());
+
 	extract_entropy(key, sizeof(key));
 
 	/*
@@ -224,7 +248,6 @@ static void crng_reseed(void)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
-	WRITE_ONCE(base_crng.birth, jiffies);
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -263,26 +286,6 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	memzero_explicit(first_block, sizeof(first_block));
 }
 
-/*
- * Return the interval until the next reseeding, which is normally
- * CRNG_RESEED_INTERVAL, but during early boot, it is at an interval
- * proportional to the uptime.
- */
-static unsigned int crng_reseed_interval(void)
-{
-	static bool early_boot = true;
-
-	if (unlikely(READ_ONCE(early_boot))) {
-		time64_t uptime = ktime_get_seconds();
-		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
-			WRITE_ONCE(early_boot, false);
-		else
-			return max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
-				     (unsigned int)uptime / 2 * HZ);
-	}
-	return CRNG_RESEED_INTERVAL;
-}
-
 /*
  * This function returns a ChaCha state that you may use for generating
  * random data. It also returns up to 32 bytes on its own of random data
@@ -318,13 +321,6 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 			return;
 	}
 
-	/*
-	 * If the base_crng is old enough, we reseed, which in turn bumps the
-	 * generation counter that we check below.
-	 */
-	if (unlikely(time_is_before_jiffies(READ_ONCE(base_crng.birth) + crng_reseed_interval())))
-		crng_reseed();
-
 	local_lock_irqsave(&crngs.lock, flags);
 	crng = raw_cpu_ptr(&crngs);
 
@@ -697,7 +693,7 @@ static void __cold _credit_init_bits(size_t bits)
 	} while (!try_cmpxchg(&input_pool.init_bits, &orig, new));
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
-		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
+		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
 		wake_up_interruptible(&crng_init_wait);
@@ -805,7 +801,7 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
 	if (crng_ready() && (action == PM_RESTORE_PREPARE ||
 	    (action == PM_POST_SUSPEND && !IS_ENABLED(CONFIG_PM_AUTOSLEEP) &&
 	     !IS_ENABLED(CONFIG_PM_USERSPACE_AUTOSLEEP)))) {
-		crng_reseed();
+		crng_reseed(NULL);
 		pr_notice("crng reseeded on system resumption\n");
 	}
 	return 0;
@@ -849,7 +845,7 @@ void __init random_init_early(const char *command_line)
 
 	/* Reseed if already seeded by earlier phases. */
 	if (crng_ready())
-		crng_reseed();
+		crng_reseed(NULL);
 	else if (trust_cpu)
 		_credit_init_bits(arch_bits);
 }
@@ -877,7 +873,7 @@ void __init random_init(void)
 
 	/* Reseed if already seeded by earlier phases. */
 	if (crng_ready())
-		crng_reseed();
+		crng_reseed(NULL);
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
@@ -1469,7 +1465,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		if (!crng_ready())
 			return -ENODATA;
-		crng_reseed();
+		crng_reseed(NULL);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.38.1

