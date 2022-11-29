Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939863C72F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiK2S26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiK2S2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:28:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7527FE6;
        Tue, 29 Nov 2022 10:28:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD73BCE13D7;
        Tue, 29 Nov 2022 18:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DBEC433D6;
        Tue, 29 Nov 2022 18:28:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PvzCMQo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669746523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40jd/O/f0+35LfGoNsCPN2/bS9KqtfSE7wnr2o/Obt8=;
        b=PvzCMQo9yw03vDCVlLFBsktpgaTCQ8ltSTevEB/+27lVll5gYQwrfeJphskaTHaRMSYziz
        UD+erupyHceNtbN0kjdvJE0849JAToBjtVZGC/IF2NzM40AUdmUONOe313MHR/QFuQzSO+
        fLqZjbsZrhduNt3x8m7GUAaYXH2vV8Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2aea5919 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Nov 2022 18:28:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] random: spread out jitter callback to different CPUs
Date:   Tue, 29 Nov 2022 19:27:52 +0100
Message-Id: <20221129182751.610558-1-Jason@zx2c4.com>
In-Reply-To: <20221129160811.563011-1-Jason@zx2c4.com>
References: <20221129160811.563011-1-Jason@zx2c4.com>
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

Rather than merely hoping that the callback gets called on another CPU,
arrange for that to actually happen, by round robining which CPU the
timer fires on. This way, on multiprocessor machines, we exacerbate
jitter by touching the same memory from multiple different cores.

It's necessary to call [try_to_]del_timer_sync() before calling
add_timer_on(), so that the final call to del_timer_sync() at the end of
the function actually succeeds at making sure no handlers are running.

Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v2->v3:
- Thomas convinced me try_to_del_timer_sync() was fine.

 drivers/char/random.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7b71cea6a6ab..4cb1d606a492 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1232,7 +1232,8 @@ void __cold rand_initialize_disk(struct gendisk *disk)
 struct entropy_timer_state {
 	unsigned long entropy;
 	struct timer_list timer;
-	unsigned int samples, samples_per_bit;
+	atomic_t samples;
+	unsigned int samples_per_bit;
 };
 
 /*
@@ -1250,10 +1251,8 @@ static void __cold entropy_timer(struct timer_list *timer)
 {
 	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
 
-	if (++state->samples == state->samples_per_bit) {
+	if (atomic_inc_return(&state->samples) % state->samples_per_bit == 0)
 		credit_init_bits(1);
-		state->samples = 0;
-	}
 }
 
 /*
@@ -1263,9 +1262,10 @@ static void __cold entropy_timer(struct timer_list *timer)
 static void __cold try_to_generate_entropy(void)
 {
 	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
-	struct entropy_timer_state stack;
+	struct entropy_timer_state stack = { 0 };
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
+	int cpu = -1;
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
 		stack.entropy = random_get_entropy();
@@ -1277,19 +1277,37 @@ static void __cold try_to_generate_entropy(void)
 	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
 		return;
 
-	stack.samples = 0;
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
-		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies);
+		/*
+		 * Check !timer_pending() and then ensure that any previous callback has finished
+		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
+		 */
+		if (!timer_pending(&stack.timer) && try_to_del_timer_sync(&stack.timer) >= 0) {
+			preempt_disable();
+
+			/* Basic CPU round-robin, which avoids the current CPU. */
+			do {
+				cpu = cpumask_next(cpu, cpu_online_mask);
+				if (cpu == nr_cpumask_bits)
+					cpu = cpumask_first(cpu_online_mask);
+			} while (cpu == smp_processor_id() && cpumask_weight(cpu_online_mask) > 1);
+
+			/* Expiring the timer at `jiffies` means it's the next tick. */
+			stack.timer.expires = jiffies;
+
+			add_timer_on(&stack.timer, cpu);
+
+			preempt_enable();
+		}
 		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 		schedule();
 		stack.entropy = random_get_entropy();
 	}
+	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 
 	del_timer_sync(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
-	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 }
 
 
-- 
2.38.1

