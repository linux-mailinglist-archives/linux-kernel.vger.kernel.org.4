Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8863E117
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiK3UDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3UDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:03:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2A23BFA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:03:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84398CE1B0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C5AC433C1;
        Wed, 30 Nov 2022 20:03:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ddpmDtlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669838580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vH/NcoP2zEaCp8SEXsclpeZY780y8IHRUsr5heJWX8=;
        b=ddpmDtlYq+odsPu2QUDUygcoSXrMGP7Ot8jHYu9zRWQ7eoYjl7RNrwfXvlQvn1x73rQ7MG
        752Dg0fz3wnQqDVH7C7Oum214dOKVkJxUdPm/zWbCmGduUSzYDzXm8BzbIcHoLcH9k5caG
        FQWwjAwpue1bClbkErdNk0hj3Xmls0Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dd68b3be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 20:03:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] random: align entropy_timer_state to cache line
Date:   Wed, 30 Nov 2022 21:02:53 +0100
Message-Id: <20221130200253.511606-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rFNXpCrmoQ7Uk1T3ykVj2-ap_TCerDMSjLMyADh3XJAA@mail.gmail.com>
References: <CAHmME9rFNXpCrmoQ7Uk1T3ykVj2-ap_TCerDMSjLMyADh3XJAA@mail.gmail.com>
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

The theory behind the jitter dance is that multiple things are poking at
the same cache line. This only works, however, if what's being poked at
is actually all in the same cache line. Ensure this is the case by
aligning the struct on the stack to the cache line size.

We can't use ____cacheline_aligned on a stack variable, because gcc
assumes 16 byte alignment when only 8 byte alignment is provided by the
kernel, which means gcc could technically do something pathological
like `(rsp & ~48) - 64`. It doesn't, but rather than risk it, just do
the stack alignment manually with PTR_ALIGN and an oversized buffer.

Fixes: 50ee7529ec45 ("random: try to actively add entropy rather than passively wait for it")
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index acb9548a870e..46bb81c2da6e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1265,29 +1265,30 @@ static void __cold entropy_timer(struct timer_list *timer)
 static void __cold try_to_generate_entropy(void)
 {
 	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
-	struct entropy_timer_state stack;
+	u8 stack_bytes[sizeof(struct entropy_timer_state) + SMP_CACHE_BYTES - 1];
+	struct entropy_timer_state *stack = PTR_ALIGN((void *)stack_bytes, SMP_CACHE_BYTES);
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
 	int cpu = -1;
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
-		stack.entropy = random_get_entropy();
-		if (stack.entropy != last)
+		stack->entropy = random_get_entropy();
+		if (stack->entropy != last)
 			++num_different;
-		last = stack.entropy;
+		last = stack->entropy;
 	}
-	stack.samples_per_bit = DIV_ROUND_UP(NUM_TRIAL_SAMPLES, num_different + 1);
-	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
+	stack->samples_per_bit = DIV_ROUND_UP(NUM_TRIAL_SAMPLES, num_different + 1);
+	if (stack->samples_per_bit > MAX_SAMPLES_PER_BIT)
 		return;
 
-	atomic_set(&stack.samples, 0);
-	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
+	atomic_set(&stack->samples, 0);
+	timer_setup_on_stack(&stack->timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
 		/*
 		 * Check !timer_pending() and then ensure that any previous callback has finished
 		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
 		 */
-		if (!timer_pending(&stack.timer) && try_to_del_timer_sync(&stack.timer) >= 0) {
+		if (!timer_pending(&stack->timer) && try_to_del_timer_sync(&stack->timer) >= 0) {
 			struct cpumask timer_cpus;
 			unsigned int num_cpus;
 
@@ -1312,20 +1313,20 @@ static void __cold try_to_generate_entropy(void)
 			} while (cpu == smp_processor_id() && num_cpus > 1);
 
 			/* Expiring the timer at `jiffies` means it's the next tick. */
-			stack.timer.expires = jiffies;
+			stack->timer.expires = jiffies;
 
-			add_timer_on(&stack.timer, cpu);
+			add_timer_on(&stack->timer, cpu);
 
 			preempt_enable();
 		}
-		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
+		mix_pool_bytes(&stack->entropy, sizeof(stack->entropy));
 		schedule();
-		stack.entropy = random_get_entropy();
+		stack->entropy = random_get_entropy();
 	}
-	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
+	mix_pool_bytes(&stack->entropy, sizeof(stack->entropy));
 
-	del_timer_sync(&stack.timer);
-	destroy_timer_on_stack(&stack.timer);
+	del_timer_sync(&stack->timer);
+	destroy_timer_on_stack(&stack->timer);
 }
 
 
-- 
2.38.1

