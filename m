Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5596E33B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDOVB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 17:01:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B26F2D68
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 14:01:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681592512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yqq8g4voyORuOKz0xYtM3M8l/RW0mlZ5XeVdC8I36Cg=;
        b=ORNYi8wMrJIDqYE+MfN6yFMvFjeb8aIUbaeBWSCndcOJdmU1hN0gcq96aRcBphLPBS6mW0
        Ubay1txBg08TFc7xTvd0TGNjJWkWEymQFxrky8wJpte27BstLq4CikoKlnz6cwR0PLsE2V
        d2VSeF55LqK/t/KmFS13yaxWqQnuszQBZfij+2N2ScVJGuitifZ6ZTeOzxTjQNYrEG3U86
        tmwUlIy0YlbYkwuIzFtEZDdrv72pk7kT1b7OpNU8jh95ZLVmmMz1F4oyMVzeuOByZpLugN
        wHIQPOAfR6NOPW5XKmalzlywZa15MfXTJqqnOWB+1WD07eMrPYrAw4lNDjzh5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681592512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yqq8g4voyORuOKz0xYtM3M8l/RW0mlZ5XeVdC8I36Cg=;
        b=dkBKDk9AEK+vOYWU/oYnALNUyoT7SInoSbXjs0Qw/imMc/c2HZJ5pxexYDRPFH3vPcT0FC
        TKGcpQRYNxRRPvDA==
To:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <20230412003425.11323-1-victor@allwinnertech.com>
References: <20230412003425.11323-1-victor@allwinnertech.com>
Date:   Sat, 15 Apr 2023 23:01:51 +0200
Message-ID: <87sfd0yi4g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Victor!

On Wed, Apr 12 2023 at 08:34, Victor Hassan wrote:

Thanks for tracking this problem down!

> If a broadcast timer is registered after the system switched to oneshot
> mode, a hang_task err could occur like that:
>
> INFO: task kworker/u15:0:7 blocked for more than 120 seconds.
>       Tainted: G            E     5.15.41-android13-8-00002-xxx #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u16:0   state:D stack: 9808 pid:  7 ppid: 2 flags:0x00000008
> Workqueue: events_unbound deferred_probe_work_func.cfi_jt
> Call trace:
>  __switch_to+0y240/0x490
>  __schedule+0x620/0xafc
>  schedule+0x110/0x204
>  schedule_hrtimeout_range_clock+0x9c/0x118
>  usleep_range_state+0x150/0x1ac
>  _regulator_do_enable+0x528/0x878
>  set_machine_constraints+0x6a0/0xf2c
>  regulator_register+0x3ac/0x7ac
>  devm_regulator_register+0xbc/0x120
>  pmu_ext_regulator_probe+0xb0/0x1b4 [pmu_ext_regulator]
>  platform_probe+0x70/0x194
>  really_probe+0x320/0x68c
>  __driver_probe_device+0x204/0x260
>  driver_probe_device+0x48/0x1e0

That backtrace is not really helpful to explain the problem. That's just the
consequence, i.e. the symptom.

Backtraces can help to document the call chain leading to a problem. As
this is _not_ leading to the problem, the backtrace is just a
distraction. See:

 https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> When the new broadcast timer was registered after the system switched
> to oneshot mode, the broadcast timer was not used as periodic. If the
> oneshot mask was set incorrectly, all cores which did not enter cpu_idle
> state can't enter cpu_idle normally, causing the hrtimer mechanism to
> break.

This is not really a proper problem description. It's obvious that
things break when a mask is set incorrectly. But that lacks a
description of the context and the why the mask is incorrect.

> Like:
>
> * CPU 1 stop its tick, next event is in one hour. It calls
>   tick_broadcast_enter() and goes to sleep.

So there is already a broadcast device installed, right?

> * CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
>   (note it's not yet actually programmed in the tick device)
> * CPU 1 call tick_broadcast_exit().
> * CPU 0 registers new broadcast device and sets CPU 1 in tick_broadcast_oneshot_mask

This lacks an explanation why CPU0 sets CPU1 in that mask. It does not
_set_ it explicitely, only implicitely by ORing the periodic broadcast
cpumask over.

Now the question is why is CPU1 set in the periodic broadcast mask when
the CPU already switched over to NOHZ mode?

That needs to be explained too.

> * CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
>   is in one hour (because the recently enqueued timer for CPU 1 hasn't been programmed
>   yet), so it programs the broadcast to that 1 hour deadline.
> * CPU 1 runs tick_nohz_idle_stop_tick() which eventually writes and program
>   dev->next_event to next jiffy
> * CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
>   the CPU is already in tick_broadcast_oneshot_mask, so the dev->next_event
>   change isn't propagated to broadcast.
> * CPU 1 goes to sleep for 1 hour.

Also please use tabular style to explain the parallel events as
explained in the documentation.

> This patch fixes the issue by moving the update action about oneshot

git grep 'This patch' Documentation/process/

> Fixes: 9c336c9935cf ("tick/broadcast: Allow late registered device to enter oneshot mode")

Pointless new line.

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Ditto. And please use the tag ordering from the tip documentation.

> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---
>  kernel/time/tick-broadcast.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 93bf2b4e47e5..fdbbba487978 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -1041,12 +1041,13 @@ static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
>  		 */
>  		cpumask_copy(tmpmask, tick_broadcast_mask);
>  		cpumask_clear_cpu(cpu, tmpmask);
> -		cpumask_or(tick_broadcast_oneshot_mask,
> -			   tick_broadcast_oneshot_mask, tmpmask);

This breaks the case when the broadcast device was already in use before
switching to oneshot broadcast mode and the underlying clock event
device does not support periodic state, i.e. it operates internally in
one shot state.

The condition avoids reprogramming in that case because the device is
already armed for the next tick when the periodic broadcast mask is not
empty, so no further action required.

But with moving the OR operation into the condition the CPUs in the
periodic broadcast mask are then not woken up.

There is a distinction between the tick/broadcast mode and the
clockevent device state.

tick/broadcast			clockevent

TICK_MODE_PERIODIC              CLOCK_EVENT_STATE_PERIODIC (if supported) or _ONESHOT
TICK_MODE_ONESHOT  (NOHZ)       CLOCK_EVENT_STATE_ONESHOT

The tick/broadcast mode is a software state. The clockevent state is a
hardware state.

After more analysis of that code it turns out that this is even more
broken because of this:

CPU0                       CPU1

                           idle()
                             tick_broadcast_enter()
                                 test_and_set_cpu(cpu, oneshot_mask);
                                 shutdown_cpu_local_device();
                                 tick_broadcast_set_event();
                             sleep_deep();

                           // All good. Broadcast will wake the CPU up

install_new_broadcast_device(newdev)
  tick_broadcast_setup_oneshot(newdev)
    if (was_periodic)  <- Path not taken because device is in shutdown state
       ...
    else
      newdev->next_event = KTIME_MAX;

So what switches the new device into oneshot state and what wakes CPU1
on time?

The switch to oneshot mode happens when the next CPU goes idle and
invokes tick_broadcast_set_event() because that sets up one shot state
implicitly.

The wake-up on time for CPU1 happens only when the next CPU goes idle
before the expiry time and queues a broadcast event which is the same or
earlier than CPU1s event, but that's far from correct.

It will eventually be delivered, but that might be way too late and even
cause stalls or hung task events in the worst case.

Duh. What was that Gleixner dude thinking...

Just for the record. I hated that broadcast code from day one.

The irony is that the only architecture which required it back in the
days (x86) and caused me to write this horror in order to make NOHZ
possible has by now functional timers which just work even in deeper
idle states. Therefore x86 does not use that code anymore on any
halfways contemporary system.

Though all other architectures had to make the same mistake again...

Completely untested patch below.

Thanks,

        tglx
---
From: Thomas Gleixner <tglx@linutronix.de>
Subject: tick/broadcast: Make broadcast device replacement work correctly
Date: Wed, 12 Apr 2023 08:34:25 +0800

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
Not-Yet-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-broadcast.c |  106 ++++++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 31 deletions(-)

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
@@ -1020,48 +1021,89 @@ static inline ktime_t tick_get_next_peri
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
 
 	/* Set it up only once ! */
-	if (bc->event_handler != tick_handle_oneshot_broadcast) {
-		int was_periodic = clockevent_state_periodic(bc);
-
-		bc->event_handler = tick_handle_oneshot_broadcast;
-
+	if (bc->event_handler == tick_handle_oneshot_broadcast) {
 		/*
-		 * We must be careful here. There might be other CPUs
-		 * waiting for periodic broadcast. We need to set the
-		 * oneshot_mask bits for those and program the
-		 * broadcast device to fire.
+		 * The CPU which switches from periodic to oneshot mode
+		 * sets the broadcast oneshot bit for all other CPUs which
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
@@ -1070,14 +1112,16 @@ static void tick_broadcast_setup_oneshot
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
