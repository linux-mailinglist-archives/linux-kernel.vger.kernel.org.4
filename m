Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C57644A39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiLFRU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiLFRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3432B94
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670347190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qI/FNfFK2hCaPQR7h5sQMFzBE9Rk/EKDVSD9F/Ae6dY=;
        b=EGL1A5uqDIaW63bW6nmQn90vPcNRsOBLFL4vWuf1CAgXhLBt0H9RxvEsyT65sX96RHEooH
        UwX/NecwQloNh46iwD3DNgMNhGTE1nZDYFpOh64CGOksiiK8zxgTqWaia3A2mp/05cdkGo
        J/7IZGXssHbQIcoL6z0lURKVibMerWY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-7R3jg4Q4MDqJi9lPXjtZFA-1; Tue, 06 Dec 2022 12:19:45 -0500
X-MC-Unique: 7R3jg4Q4MDqJi9lPXjtZFA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F2BB3C0CD5A;
        Tue,  6 Dec 2022 17:19:45 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B4D3492B05;
        Tue,  6 Dec 2022 17:19:44 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id D9F80409005E4; Tue,  6 Dec 2022 13:31:40 -0300 (-03)
Message-ID: <20221206162416.545596407@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 13:18:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v9 5/5] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
References: <20221206161826.698593151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@redhat.com>

In the context of the idle task and an adaptive-tick mode/or a nohz_full
CPU, quiet_vmstat() can be called: before stopping the idle tick,
entering an idle state and on exit. In particular, for the latter case,
when the idle task is required to reschedule, the idle tick can remain
stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
counters should be processed to ensure the respective values have been
reset and folded into the zone specific 'vm_stat[]'. That being said, it
can only occur when: the idle tick was previously stopped, and
reprogramming of the timer is not required.

A customer provided some evidence which indicates that the idle tick was
stopped; albeit, CPU-specific vmstat counters still remained populated.
Thus one can only assume quiet_vmstat() was not invoked on return to the
idle loop.

If I understand correctly, I suspect this divergence might erroneously
prevent a reclaim attempt by kswapd. If the number of zone specific free
pages are below their per-cpu drift value then
zone_page_state_snapshot() is used to compute a more accurate view of
the aforementioned statistic.  Thus any task blocked on the NUMA node
specific pfmemalloc_wait queue will be unable to make significant
progress via direct reclaim unless it is killed after being woken up by
kswapd (see throttle_direct_reclaim()).

Consider the following theoretical scenario:

 - Note: CPU X is part of 'tick_nohz_full_mask'

    1.      CPU Y migrated running task A to CPU X that
	    was in an idle state i.e. waiting for an IRQ;
	    marked the current task on CPU X to need/or
	    require a reschedule i.e., set TIF_NEED_RESCHED
	    and invoked a reschedule IPI to CPU X
	    (see sched_move_task())

    2.      CPU X acknowledged the reschedule IPI. Generic
	    idle loop code noticed the TIF_NEED_RESCHED flag
	    against the idle task and attempts to exit of the
	    loop and calls the main scheduler function i.e.
	    __schedule().

	    Since the idle tick was previously stopped no
	    scheduling-clock tick would occur.
	    So, no deferred timers would be handled

    3.      Post transition to kernel execution Task A
	    running on CPU X, indirectly released a few pages
	    (e.g. see __free_one_page()); CPU X's
	    'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
	    specific 'vm_stat[]' update was deferred as per the
	    CPU-specific stat threshold

    4.      Task A does invoke exit(2) and the kernel does
	    remove the task from the run-queue; the idle task
	    was selected to execute next since there are no
	    other runnable tasks assigned to the given CPU
	    (see pick_next_task() and pick_next_task_idle())

    5.      On return to the idle loop since the idle tick
	    was already stopped and can remain so (see [1]
	    below) e.g. no pending soft IRQs, no attempt is
	    made to zero and fold CPU X's vmstat counters
	    since reprogramming of the scheduling-clock tick
	    is not required/or needed (see [2])

		  ...
		    do_idle
		    {

		      __current_set_polling()
		      tick_nohz_idle_enter()

		      while (!need_resched()) {

			local_irq_disable()

			...

			/* No polling or broadcast event */
			cpuidle_idle_call()
			{

			  if (cpuidle_not_available(drv, dev)) {
			    tick_nohz_idle_stop_tick()
			      __tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched))
			      {
				int cpu = smp_processor_id()

				if (ts->timer_expires_base)
				  expires = ts->timer_expires
				else if (can_stop_idle_tick(cpu, ts))
	      (1) ------->        expires = tick_nohz_next_event(ts, cpu)
				else
				  return

				ts->idle_calls++

				if (expires > 0LL) {

				  tick_nohz_stop_tick(ts, cpu)
				  {

				    if (ts->tick_stopped && (expires == ts->next_tick)) {
	      (2) ------->            if (tick == KTIME_MAX || ts->next_tick ==
					hrtimer_get_expires(&ts->sched_timer))
					return
				    }
				    ...
				  }

So, the idea of this patch is to ensure refresh_cpu_vm_stats(false) is
called, when it is appropriate, on return to the idle loop if the idle
tick was previously stopped too.

A trivial test program was used to determine the impact of the proposed
changes and under vanilla. The nanosleep(2) system call was used several
times to suspend execution for a period of time to approximately compute
the number of CPU-cycles in the idle code path. The following is an average
count of CPU-cycles:

				  Vanilla                 Modified

  Cycles per idle loop            151858                  153258  (+1.0%)

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/time/tick-sched.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -926,13 +926,14 @@ static void tick_nohz_stop_tick(struct t
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat(false);
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat(false);
 	ts->next_tick = tick;
 
 	/*


