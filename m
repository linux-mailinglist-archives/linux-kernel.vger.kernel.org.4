Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1039E6F932D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEFQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:41:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812918911
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:40:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683391258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QN0Aw+aiOuGQSNX5EzM0c6ES1H8/ODaLXYG4IEuAtgc=;
        b=nbB+gZL5QAlDpbBTxWECKIY9cxJa0QVaaPxIGsgIa0ckLx5UzGbfwjigx2VCn1JWLZg6t8
        Z3I8KClSvkFecne03csi6BSilW6gg+//Y2fnWI+f/5DQ9OjaotznppPNaP6ziwhOEIUy/k
        nZScklsOobNpqtll0wb0XnZZxHcE8zz+qhQqE/js1cV4A+wanlZ5t10ltp4aTrQ+1lfBm+
        VxwSOeIS/BEL4dW3rAnaqmmbsZ/svEn0hjKdiqrY6VxE5POJqOw5iIfuu+NMddWiaTXOkI
        13Q7z7WVgqFUymMuuPn1KcYjbUE6ckuXomcTTwx1O8GbGP3iAJbDOFQ+MI0rdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683391258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QN0Aw+aiOuGQSNX5EzM0c6ES1H8/ODaLXYG4IEuAtgc=;
        b=y/kDqhAME94jkfP17LWLP6wQ5QJ47TmPGSnh+1ZHw489NI0hetkMtU+O+EIcctc39CHVaB
        MkmYQ2PL8XjOF0DQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tick/broadcast: Make broadcast device replacement work
 correctly
In-Reply-To: <ZFNj183r1APx/Wem@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx> <ZFDxph8YDPjwvbej@lothringen> <87y1m652n2.ffs@tglx>
 <ZFLftU4sEgeEaRJe@lothringen> <87pm7h3u2n.ffs@tglx>
 <ZFNj183r1APx/Wem@lothringen>
Date:   Sat, 06 May 2023 18:40:57 +0200
Message-ID: <87pm7d2z1i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a tick broadcast clockevent device is initialized for one shot mode
then tick_broadcast_setup_oneshot() OR's the periodic broadcast mode
cpumask into the oneshot broadcast cpumask.

This is required when switching from periodic broadcast mode to oneshot
broadcast mode to ensure that CPUs which are waiting for periodic
broadcast are woken up on the next tick.

But it is subtly broken, when an active broadcast device is replaced and
the system is already in oneshot (NOHZ/HIGHRES) mode. Victor observed
this and debugged the issue.

Then the OR of the periodic broadcast CPU mask is wrong as the periodic
cpumask bits are sticky after tick_broadcast_enable() set it for a CPU
unless explicitly cleared via tick_broadcast_disable().

That means that this sets all other CPUs which have tick broadcasting
enabled at that point unconditionally in the oneshot broadcast mask.

If the affected CPUs were already idle and had their bits set in the
oneshot broadcast mask then this does no harm. But for non idle CPUs
which were not set this corrupts their state.

On their next invocation of tick_broadcast_enable() they observe the bit
set, which indicates that the broadcast for the CPU is already set up.
As a consequence they fail to update the broadcast event even if their
earliest expiring timer is before the actually programmed broadcast
event.

If the programmed broadcast event is far in the future, then this can
cause stalls or trigger the hung task detector.

Avoid this by telling tick_broadcast_setup_oneshot() explicitly whether
this is the initial switch over from periodic to oneshot broadcast which
must take the periodic broadcast mask into account. In the case of
initialization of a replacement device this prevents that the broadcast
oneshot mask is modified.

There is a second problem with broadcast device replacement in this
function. The broadcast device is only armed when the previous state of
the device was periodic.

That is correct for the switch from periodic broadcast mode to oneshot
broadcast mode as the underlying broadcast device could operate in
oneshot state already due to lack of periodic state in hardware. In that
case it is already armed to expire at the next tick.

For the replacement case this is wrong as the device is in shutdown
state. That means that any already pending broadcast event will not be
armed.

This went unnoticed because any CPU which goes idle will observe that
the broadcast device has an expiry time of KTIME_MAX and therefore any
CPUs next timer event will be earlier and cause a reprogramming of the
broadcast device. But that does not guarantee that the events of the
CPUs which were already in idle are delivered on time.

Fix this by arming the newly installed device for an immediate event
which will reevaluate the per CPU expiry times and reprogram the
broadcast device accordingly. This is simpler than caching the last
expiry time in yet another place or saving it before the device exchange
and handing it down to the setup function. Replacement of broadcast
devices is not a frequent operation and usually happens once somewhere
late in the boot process.

Fixes: 9c336c9935cf ("tick/broadcast: Allow late registered device to enter oneshot mode")
Reported-by: Victor Hassan <victor@allwinnertech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-broadcast.c |  114 ++++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 32 deletions(-)

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
