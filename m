Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698415E8DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiIXPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIXPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891B1A3A4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664033085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bph3AMipjhSnF4iEVnBvZMNWDbHORj0Zn37njSUExec=;
        b=AHnEyQjDJZ95pD1aiUBrQGS/DcNHxy/W0hoAJoF+ZzBUgtsacqQMgaGtrJK8UE1ARdJTFZ
        XiRGYG/9knwWQvNCDMW6m8H1H6kqPvDDwXQKgloLr+Ut817hbCUkcvFxJTBTBd84f+7+CN
        GAQtjdNdyWza+dkKhexJkLqEvsKDB60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-uKl66JGsMTW6tnvyC0AX6Q-1; Sat, 24 Sep 2022 11:24:44 -0400
X-MC-Unique: uKl66JGsMTW6tnvyC0AX6Q-1
Received: by mail-wm1-f69.google.com with SMTP id c129-20020a1c3587000000b003b5152ebf93so2170867wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Bph3AMipjhSnF4iEVnBvZMNWDbHORj0Zn37njSUExec=;
        b=g+ji1DuF62JxPmetanCRLzgivB22tKcrWMSVSS0R32ER0kRKiqH312WkPWZg1QqUV+
         ZZ3+dZLuCPSP51JYqczXFt1iKH6PZfBDUdXvkraxNZOE0j42V9A+/vhPZC5GQri3PQaF
         60pjR2s3wxvVg8pXEe1lFXDyFKWqEmxvny6KhiJe1jnoHyAYufKZ58H59DKACYIMU9qc
         mcWA/k3zwvHGT2uK3HN+HsmnfCUvdXNKO6uPcPkNzPOWLKa4IkOEmNkbadrFBfaeXOpm
         6iRzqNz5/gR5T5Opc7m/L105zf2CWiDnLGBFSNXMP90HuSRFVf7/YMEUmNswL2qLa2kw
         AvMA==
X-Gm-Message-State: ACrzQf3HzfF+/5+dhYhsi3czo/eNXDZId6jPVmKQlYPskhoK4Vdu/9KR
        2ueO4XwBHx5TG3TEi3CyBE2DKjWtLtrQzsX81XjzXwpXT0QmAPekbi4s/l+82+F1wwSOU61r02i
        Xt3I7RiPW0rf+VJ+uDQ0gtQA=
X-Received: by 2002:a5d:5846:0:b0:22a:f7d2:9045 with SMTP id i6-20020a5d5846000000b0022af7d29045mr8818997wrf.250.1664033083086;
        Sat, 24 Sep 2022 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70EhfgjAjHBzizhVeJg3h6UFmOlUDSwdahLb7n7DZk1+e242Hq1wNDo3XO+Xfaa3AFFa0HHg==
X-Received: by 2002:a5d:5846:0:b0:22a:f7d2:9045 with SMTP id i6-20020a5d5846000000b0022af7d29045mr8818987wrf.250.1664033082825;
        Sat, 24 Sep 2022 08:24:42 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003b491f99a25sm6157684wmq.22.2022.09.24.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:24:41 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 5/5] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Sat, 24 Sep 2022 16:24:41 +0100
Message-Id: <20220924152441.822460-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924152227.819815-1-atomlin@redhat.com>
References: <20220924152227.819815-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 kernel/time/tick-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 634cd0fac267..88a3e9fc3824 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -926,13 +926,14 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
 	ts->next_tick = tick;
 
 	/*
-- 
2.37.1

