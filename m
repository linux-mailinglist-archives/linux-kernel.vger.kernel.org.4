Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F215F591C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJER0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJER0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:26:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246557E03C;
        Wed,  5 Oct 2022 10:26:46 -0700 (PDT)
Date:   Wed, 5 Oct 2022 19:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664990803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fj95Dr0AciJvLIhuAttqQiDA1VupLLtSJgyv/b0xPHw=;
        b=DCFNYVWAtT9sIoXQMxW8P9eS/VBebCuxkSzT/fdWLhEBTWZBs2c46M7tpGarJdbEozdyrJ
        dNDRczS+uYoYRuXBksas7JugL2PmRLhKd/ePQis5Cyhx8H/6mqJclCfVnrpU9cQN/1eSmk
        OQe08fO2lMosXWggCw3+Bb3fS3jLXMvtLwK2Sh2lx4Oa9mDNmGUni/PPawDmKkuhgIkPkX
        3snvFe9ca06UqIYOagGxo8yZhi3BbgCVPoWh2i0jAcefU9QCoir24tcCK1YhFK8NxJl+Bg
        jGsYuTLbtSBZyScaFyvMZHizeN7YlhMW2/oISNk28MESriCQ7tTRMuz2DrLZOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664990803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fj95Dr0AciJvLIhuAttqQiDA1VupLLtSJgyv/b0xPHw=;
        b=Z+OVxzKA4WFx0GobQJezxTBgeL17dA7h9cooRp8lhHJnHWtDFXusbVzIYs6FJ9n6kXWkrl
        CVpWuSmCwVnm7BAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz2+UsgVGRSm+o7W@linutronix.de>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzgGmh6EQtWzO4HV@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-01 11:21:30 [+0200], Jason A. Donenfeld wrote:
> Sultan points out that timer_pending() returns false before the function
> has actually run, while add_timer_on() adds directly to the timer base,
> which means del_timer_sync() might fail to notice a pending timer, which
> means UaF. This seems like a somewhat hard problem to solve. So I think
> I'll just drop this patch 2/2 here until a better idea comes around.

I don't know what you exactly intend but this:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e5828..18d785f5969e5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1195,6 +1195,7 @@ static void __cold try_to_generate_entropy(void)
 	struct entropy_timer_state stack;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
+	unsigned int cpu = raw_smp_processor_id();
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
 		stack.entropy = random_get_entropy();
@@ -1207,10 +1208,17 @@ static void __cold try_to_generate_entropy(void)
 		return;
 
 	stack.samples = 0;
-	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
+	timer_setup_on_stack(&stack.timer, entropy_timer, TIMER_PINNED);
 	while (!crng_ready() && !signal_pending(current)) {
-		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies + 1);
+
+		if (!timer_pending(&stack.timer)) {
+			cpu = cpumask_next(cpu, cpu_online_mask);
+			if (cpu == nr_cpumask_bits)
+				cpu = cpumask_first(cpu_online_mask);
+
+			stack.timer.expires = jiffies;
+			add_timer_on(&stack.timer, cpu);
+		}
 		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 		schedule();
 		stack.entropy = random_get_entropy();

will enqueue a timer once none is pending. That is on first invocation
_or_ as soon as the callback is about to be invoked. So basically the
timer is about to be called and you enqueue it right away.
With "expires = jiffies" the timer will be invoked on every tick while
"jiffies + 1" will invoke it on every other tick.

You will start the timer on "this-CPU + 1" and iterate it in a round
robin fashion through all CPUs. It seems this is important. I don't
think that you need to ensure that the CPU running
try_to_generate_entropy() will not fire the timer since it won't happen
most of the time (due to the round-robin thingy). This is (of course)
different between a busy system and an idle one.

That del_timer_sync() at the end is what you want. If the timer is
pending (as in enqueued in the timer wheel) then it will be removed
before it is invoked. If the timer's callback is invoked then it will
spin until the callback is done.

I *think* you are aware that schedule() here is kind of pointless
because if there is not much going on (this is the only task in the
system), then you leave schedule() right away and continue. Assuming
random_get_entropy() is returning current clock (which is either the
rdtsc on x86 or random_get_entropy_fallback() somewhere else) then you
get little noise.

With some additional trace prints:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e5828..802e0d9254611 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1195,6 +1195,8 @@ static void __cold try_to_generate_entropy(void)
 	struct entropy_timer_state stack;
 	unsigned int i, num_different = 0;
 	unsigned long last = random_get_entropy();
+	unsigned int cpu = raw_smp_processor_id();
+	unsigned long v1, v2;
 
 	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
 		stack.entropy = random_get_entropy();
@@ -1207,15 +1209,26 @@ static void __cold try_to_generate_entropy(void)
 		return;
 
 	stack.samples = 0;
-	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
+	timer_setup_on_stack(&stack.timer, entropy_timer, TIMER_PINNED);
+	v1 = v2 = 0;
 	while (!crng_ready() && !signal_pending(current)) {
-		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies + 1);
+
+		if (!timer_pending(&stack.timer)) {
+			cpu = cpumask_next(cpu, cpu_online_mask);
+			if (cpu == nr_cpumask_bits)
+				cpu = cpumask_first(cpu_online_mask);
+
+			stack.timer.expires = jiffies;
+			add_timer_on(&stack.timer, cpu);
+		}
 		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 		schedule();
-		stack.entropy = random_get_entropy();
+		v1 = random_get_entropy();
+		stack.entropy = v1;
+		trace_printk("%lx | %lx\n", v1, v1 - v2);
+		v2 = v1;
 	}
-
+	tracing_off();
 	del_timer_sync(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
 	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));

I get:

|       swapper/0-1       [002] .....     2.570083: try_to_generate_entropy: 275e8a56d | 2e4
|       swapper/0-1       [002] .....     2.570084: try_to_generate_entropy: 275e8a82c | 2bf
|       swapper/0-1       [002] .....     2.570084: try_to_generate_entropy: 275e8ab10 | 2e4
|       swapper/0-1       [002] .....     2.570084: try_to_generate_entropy: 275e8adcf | 2bf
|       swapper/0-1       [002] .....     2.570084: try_to_generate_entropy: 275e8b0b3 | 2e4
|       swapper/0-1       [002] .....     2.570084: try_to_generate_entropy: 275e8b372 | 2bf
|       swapper/0-1       [002] .....     2.570085: try_to_generate_entropy: 275e8b85c | 4ea
|       swapper/0-1       [002] .....     2.570085: try_to_generate_entropy: 275e8bb1b | 2bf
|       swapper/0-1       [002] .....     2.570085: try_to_generate_entropy: 275e8be49 | 32e
|       swapper/0-1       [002] .....     2.570085: try_to_generate_entropy: 275e8c12d | 2e4
|       swapper/0-1       [002] .....     2.570087: try_to_generate_entropy: 275e8de15 | 1ce8
|       swapper/0-1       [002] .....     2.570088: try_to_generate_entropy: 275e8e168 | 353
|       swapper/0-1       [002] .....     2.570088: try_to_generate_entropy: 275e8e471 | 309
|       swapper/0-1       [002] .....     2.570088: try_to_generate_entropy: 275e8e833 | 3c2
|       swapper/0-1       [002] .....     2.570088: try_to_generate_entropy: 275e8edd6 | 5a3

So with sizeof(entropy) = 8 bytes you add 8 bytes only little changes in
lower bits.
That is maybe where you say that I don't need to worry because it is a
very good hash function and the timer accounts only one bit of entropy
every jiffy.

> Jason

Sebastian
