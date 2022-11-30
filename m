Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60363DF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiK3Ss7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiK3Ssr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:48:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350EA9B781;
        Wed, 30 Nov 2022 10:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983A561D59;
        Wed, 30 Nov 2022 18:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336ACC433D6;
        Wed, 30 Nov 2022 18:48:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NkPVooiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669834118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaoY6luIySKyMZ+07kSX17qY+vrnq35zHuxkGzar2U4=;
        b=NkPVooiRWPecisxgbMKrF4Sma62OyNyCHO+srlV+IQXF4JtAXyyLwcP5udrEx0wU9QfD4C
        oOrkewZmBWjUAktBknvhj67wvDqHHy9wHzBuBavPRfXQmvNopbrW/ozZhyl/UGd6cSmU7m
        K3yORUtaHDoQT7mA8yKU8E7yL6QUs1c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 418b61a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 18:48:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4] random: spread out jitter callback to different CPUs
Date:   Wed, 30 Nov 2022 19:48:29 +0100
Message-Id: <20221130184829.484803-1-Jason@zx2c4.com>
In-Reply-To: <20221129182751.610558-1-Jason@zx2c4.com>
References: <20221129182751.610558-1-Jason@zx2c4.com>
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

There's a little bit of tricky bookkeeping involved here, because using
timer_setup_on_stack() + add_timer_on() + del_timer_sync() will result
in a use after free. See this sample code: <https://xn--4db.cc/xBdEiIKO/c>.

Instead, it's necessary to call [try_to_]del_timer_sync() before calling
add_timer_on(), so that the final call to del_timer_sync() at the end of
the function actually succeeds at making sure no handlers are running.

Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v3->v4:
- Limit used CPUs to HK_TYPE_TIMER ones.

 drivers/char/random.c | 50 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7b71cea6a6ab..232bf487851d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
 #include <linux/siphash.h>
+#include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -1232,7 +1233,8 @@ void __cold rand_initialize_disk(struct gendisk *disk)
 struct entropy_timer_state {
 	unsigned long entropy;
 	struct timer_list timer;
-	unsigned int samples, samples_per_bit;
+	atomic_t samples;
+	unsigned int samples_per_bit;
 };
 
 /*
@@ -1250,10 +1252,8 @@ static void __cold entropy_timer(struct timer_list *timer)
 {
 	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
 
-	if (++state->samples == state->samples_per_bit) {
+	if (atomic_inc_return(&state->samples) % state->samples_per_bit == 0)
 		credit_init_bits(1);
-		state->samples = 0;
-	}
 }
 
 /*
@@ -1266,6 +1266,7 @@ static void __cold try_to_generate_entropy(void)
 	struct entropy_timer_state stack;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
+	int cpu = -1;
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
 		stack.entropy = random_get_entropy();
@@ -1277,19 +1278,52 @@ static void __cold try_to_generate_entropy(void)
 	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
 		return;
 
-	stack.samples = 0;
+	atomic_set(&stack.samples, 0);
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {
-		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies);
+		/*
+		 * Check !timer_pending() and then ensure that any previous callback has finished
+		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
+		 */
+		if (!timer_pending(&stack.timer) && try_to_del_timer_sync(&stack.timer) >= 0) {
+			struct cpumask timer_cpus;
+			unsigned int num_cpus;
+
+			/*
+			 * Preemption must be disabled here, both to read the current CPU number
+			 * and to avoid scheduling a timer on a dead CPU.
+			 */
+			preempt_disable();
+
+			/* Only schedule callbacks on timer CPUs that are online. */
+			cpumask_and(&timer_cpus, housekeeping_cpumask(HK_TYPE_TIMER), cpu_online_mask);
+			num_cpus = cpumask_weight(&timer_cpus);
+			/* In very bizarre case of misconfiguration, fallback to all online. */
+			if (unlikely(num_cpus == 0))
+				timer_cpus = *cpu_online_mask;
+
+			/* Basic CPU round-robin, which avoids the current CPU. */
+			do {
+				cpu = cpumask_next(cpu, &timer_cpus);
+				if (cpu == nr_cpumask_bits)
+					cpu = cpumask_first(&timer_cpus);
+			} while (cpu == smp_processor_id() && num_cpus > 1);
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

