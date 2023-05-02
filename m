Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763F36F43F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjEBMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjEBMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:39:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039D59CF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:39:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683031138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIeAksWtRGr/RLj6eBCBbP3lsPOXxfRgl+RNnklW40U=;
        b=TFwQ9vw1hSbO/wcuhYRo6Wus6S1GoFPav9BbNdBFi7nYqCvpI3+LGonsVSyVqnOX0q/dR1
        PDl0oPjC1NqN1Xnd4CsO3QhskMtSTS+bO2kUZz43jnQFG0IvN/cnkSpLJmJbDQYxnhFqB/
        UQllPygdT6K/jLWgd6rkKB31NafqxH3DN2YCSVw7TvQ41yKqmzz/l1KJBv1InslaXLNvgP
        hniUp9WsCU0LhOhmzfo87hrOSHE7l+b+BAfJXmQfC2/tkLFbfgUwHSzNanbPoxwL5dxj/U
        KjiQqKt6z9O+Q3oOdYXrhaw17cFC3ykSKLuUlzwrl/djJ6330A7L9aKMRUSe0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683031138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIeAksWtRGr/RLj6eBCBbP3lsPOXxfRgl+RNnklW40U=;
        b=yp+s2Z9voylGfbhUDhhV9Hvmw+uJX/BF7v8pUD0DD86pAxudmzSIJ3Ya9W6+PhvmHwplr/
        9tf3Ivm1w6X4I3BQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <ZFDxph8YDPjwvbej@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx> <ZFDxph8YDPjwvbej@lothringen>
Date:   Tue, 02 May 2023 14:38:57 +0200
Message-ID: <87y1m652n2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02 2023 at 13:19, Frederic Weisbecker wrote:
> On Fri, Apr 21, 2023 at 11:32:15PM +0200, Thomas Gleixner wrote:
> Ok I get the check_clock game. But then, why do we need to reprogram
> again the broadcast device to fire in one jiffy if the caller is
> tick_nohz_switch_to_nohz() (that is the (bc->event_handler ==
> tick_handle_oneshot_broadcast) branch)? In that case the broadcast device
> should have been programmed already by the CPU that first switched the
> current broadcast device, right?

That clearly lacks a return in that path.

>> It seems I failed miserably to explain that coherently with the tons of
>> comments added. Hrmpf :(
>
> Don't pay too much attention, confusion is my vehicle to explore any code
> that I'm not used to. But yes I must confess the
> (bc->event_handler == tick_handle_oneshot_broadcast) may deserve a comment
> remaining where we come from (ie: low-res hrtimer softirq).

Updated patch below.

Thanks,

        tglx
---
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -35,14 +35,15 @@ static __cacheline_aligned_in_smp DEFINE
 #ifdef CONFIG_TICK_ONESHOT
 static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
 
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 # ifdef CONFIG_HOTPLUG_CPU
 static void tick_broadcast_oneshot_offline(unsigned int cpu);
 # endif
 #else
-static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
+static inline void
+tick_broadcast_setup_oneshot(struct clock_event_device *bc, bool from_periodic) { BUG(); }
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
 static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
 # ifdef CONFIG_HOTPLUG_CPU
@@ -264,7 +265,7 @@ int tick_device_uses_broadcast(struct cl
 		if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 			tick_broadcast_start_periodic(bc);
 		else
-			tick_broadcast_setup_oneshot(bc);
+			tick_broadcast_setup_oneshot(bc, false);
 		ret = 1;
 	} else {
 		/*
@@ -500,7 +501,7 @@ void tick_broadcast_control(enum tick_br
 			if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
 				tick_broadcast_start_periodic(bc);
 			else
-				tick_broadcast_setup_oneshot(bc);
+				tick_broadcast_setup_oneshot(bc, false);
 		}
 	}
 out:
@@ -1020,48 +1021,95 @@ static inline ktime_t tick_get_next_peri
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
-static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
+static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
+					 bool from_periodic)
 {
 	int cpu = smp_processor_id();
+	ktime_t nexttick = 0;
 
 	if (!bc)
 		return;
 
-	/* Set it up only once ! */
-	if (bc->event_handler != tick_handle_oneshot_broadcast) {
-		int was_periodic = clockevent_state_periodic(bc);
-
-		bc->event_handler = tick_handle_oneshot_broadcast;
-
+	/*
+	 * When the broadcast device was switched to oneshot by the first
+	 * CPU handling the NOHZ change, the other CPUs will reach this
+	 * code via hrtimer_run_queues() -> tick_check_oneshot_change()
+	 * too. Set up the broadcast device only once!
+	 */
+	if (bc->event_handler == tick_handle_oneshot_broadcast) {
 		/*
-		 * We must be careful here. There might be other CPUs
-		 * waiting for periodic broadcast. We need to set the
-		 * oneshot_mask bits for those and program the
-		 * broadcast device to fire.
+		 * The CPU which switched from periodic to oneshot mode
+		 * set the broadcast oneshot bit for all other CPUs which
+		 * are in the general (periodic) broadcast mask to ensure
+		 * that CPUs which wait for the periodic broadcast are
+		 * woken up.
+		 *
+		 * Clear the bit for the local CPU as the set bit would
+		 * prevent the first tick_broadcast_enter() after this CPU
+		 * switched to oneshot state to program the broadcast
+		 * device.
 		 */
+		tick_broadcast_clear_oneshot(cpu);
+		return;
+	}
+
+
+	bc->event_handler = tick_handle_oneshot_broadcast;
+	bc->next_event = KTIME_MAX;
+
+	/*
+	 * When the tick mode is switched from periodic to oneshot it must
+	 * be ensured that CPUs which are waiting for periodic broadcast
+	 * get their wake-up at the next tick.  This is achieved by ORing
+	 * tick_broadcast_mask into tick_broadcast_oneshot_mask.
+	 *
+	 * For other callers, e.g. broadcast device replacement,
+	 * tick_broadcast_oneshot_mask must not be touched as this would
+	 * set bits for CPUs which are already NOHZ, but not idle. Their
+	 * next tick_broadcast_enter() would observe the bit set and fail
+	 * to update the expiry time and the broadcast event device.
+	 */
+	if (from_periodic) {
 		cpumask_copy(tmpmask, tick_broadcast_mask);
+		/* Remove the local CPU as it is obviously not idle */
 		cpumask_clear_cpu(cpu, tmpmask);
-		cpumask_or(tick_broadcast_oneshot_mask,
-			   tick_broadcast_oneshot_mask, tmpmask);
+		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
 
-		if (was_periodic && !cpumask_empty(tmpmask)) {
-			ktime_t nextevt = tick_get_next_period();
+		/*
+		 * Ensure that the oneshot broadcast handler will wake the
+		 * CPUs which are still waiting for periodic broadcast.
+		 */
+		nexttick = tick_get_next_period();
+		tick_broadcast_init_next_event(tmpmask, nexttick);
 
-			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask, nextevt);
-			tick_broadcast_set_event(bc, cpu, nextevt);
-		} else
-			bc->next_event = KTIME_MAX;
-	} else {
 		/*
-		 * The first cpu which switches to oneshot mode sets
-		 * the bit for all other cpus which are in the general
-		 * (periodic) broadcast mask. So the bit is set and
-		 * would prevent the first broadcast enter after this
-		 * to program the bc device.
+		 * If the underlying broadcast clock event device is
+		 * already in oneshot state, then there is nothing to do.
+		 * The device was already armed for the next tick
+		 * in tick_handle_broadcast_periodic()
 		 */
-		tick_broadcast_clear_oneshot(cpu);
+		if (clockevent_state_oneshot(bc))
+			return;
 	}
+
+	/*
+	 * When switching from periodic to oneshot mode arm the broadcast
+	 * device for the next tick.
+	 *
+	 * If the broadcast device has been replaced in oneshot mode and
+	 * the oneshot broadcast mask is not empty, then arm it to expire
+	 * immediately in order to reevaluate the next expiring timer.
+	 * nexttick is 0 and therefore in the past which will cause the
+	 * clockevent code to force an event.
+	 *
+	 * For both cases the programming can be avoided when the oneshot
+	 * broadcast mask is empty.
+	 *
+	 * tick_broadcast_set_event() implicitly switches the broadcast
+	 * device to oneshot state.
+	 */
+	if (!cpumask_empty(tick_broadcast_oneshot_mask))
+		tick_broadcast_set_event(bc, cpu, nexttick);
 }
 
 /*
@@ -1070,14 +1118,16 @@ static void tick_broadcast_setup_oneshot
 void tick_broadcast_switch_to_oneshot(void)
 {
 	struct clock_event_device *bc;
+	enum tick_device_mode oldmode;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
+	oldmode = tick_broadcast_device.mode;
 	tick_broadcast_device.mode = TICKDEV_MODE_ONESHOT;
 	bc = tick_broadcast_device.evtdev;
 	if (bc)
-		tick_broadcast_setup_oneshot(bc);
+		tick_broadcast_setup_oneshot(bc, oldmode == TICKDEV_MODE_PERIODIC);
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
