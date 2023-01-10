Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94B6636B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAJBdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAJBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:33:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA939395E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E20614A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D62C433EF;
        Tue, 10 Jan 2023 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314413;
        bh=oNXL4UymTMf6PobHRHY8tHla4MS5GdmqeyeP4IlsvgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EJUf6o/bv1CJU1m0W8z9ewPchFhlwB5oII5mrJiNvk/4q9UKskcMRiwbvf3ba0QyX
         d9wMQD5r54OqUXAF0En7ye+tlEstpDN/lD1ohuKDkGtgMrS9ls+QHnOttktdJKcU1i
         0gNasug9jn8YH/tvidOmpHN00oY2CZBDiXgPo/39K5YRG1fm6QfcWvGBNpz7n3/gP9
         14TYtTC/GoOa/kcy0Z6Ky9KVJgRUE9hW1IPS5yw+irmaUWOq95JEs9S9GnpSaq2ITf
         xAb4zsZdvG03ZGOM81YhZooV83as5AJjx8U/8f0WrQO9YDVGVpW96/amf1a6wXLL5R
         l4Vi+AJ2p1BEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F3A95C0623; Mon,  9 Jan 2023 17:33:33 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:33:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with
 CONFIG_PREEMPT_RT
Message-ID: <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230104181701.43224-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104181701.43224-1-wander@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 03:17:01PM -0300, Wander Lairson Costa wrote:
> inactive_task_timer() executes in interrupt (atomic) context. It calls
> put_task_struct(), which indirectly acquires sleeping locks under
> PREEMPT_RT.
> 
> Below is an example of a splat that happened in a test environment:
> 
>  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
>  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
>  Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  mark_lock_irq.cold+0x33/0xba
>  ? stack_trace_save+0x4b/0x70
>  ? save_trace+0x55/0x150
>  mark_lock+0x1e7/0x400
>  mark_usage+0x11d/0x140
>  __lock_acquire+0x30d/0x930
>  lock_acquire.part.0+0x9c/0x210
>  ? refill_obj_stock+0x3d/0x3a0
>  ? rcu_read_lock_sched_held+0x3f/0x70
>  ? trace_lock_acquire+0x38/0x140
>  ? lock_acquire+0x30/0x80
>  ? refill_obj_stock+0x3d/0x3a0
>  rt_spin_lock+0x27/0xe0
>  ? refill_obj_stock+0x3d/0x3a0
>  refill_obj_stock+0x3d/0x3a0
>  ? inactive_task_timer+0x1ad/0x340
>  kmem_cache_free+0x357/0x560
>  inactive_task_timer+0x1ad/0x340
>  ? switched_from_dl+0x2d0/0x2d0
>  __run_hrtimer+0x8a/0x1a0
>  __hrtimer_run_queues+0x91/0x130
>  hrtimer_interrupt+0x10f/0x220
>  __sysvec_apic_timer_interrupt+0x7b/0xd0
>  sysvec_apic_timer_interrupt+0x4f/0xd0
>  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
>  RIP: 0033:0x7fff196bf6f5
> 
> Instead of calling put_task_struct() directly, we defer it using
> call_rcu(). A more natural approach would use a workqueue, but since
> in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> the code would become more complex because we would need to put the
> work_struct instance in the task_struct and initialize it when we
> allocate a new task_struct.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/build_policy.c |  1 +
>  kernel/sched/deadline.c     | 24 +++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> index d9dc9ab3773f..f159304ee792 100644
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -28,6 +28,7 @@
>  #include <linux/suspend.h>
>  #include <linux/tsacct_kern.h>
>  #include <linux/vtime.h>
> +#include <linux/rcupdate.h>
>  
>  #include <uapi/linux/sched/types.h>
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ae8f41e3372..ab9301d4cc24 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1405,6 +1405,13 @@ static void update_curr_dl(struct rq *rq)
>  	}
>  }
>  
> +static void delayed_put_task_struct(struct rcu_head *rhp)
> +{
> +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> +
> +	__put_task_struct(task);

Please note that BH is disabled here.  Don't you therefore
need to schedule a workqueue handler?  Perhaps directly from
inactive_task_timer(), or maybe from this point.  If the latter, one
way to skip the extra step is to use queue_rcu_work().

							Thanx, Paul

> +}
> +
>  static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  {
>  	struct sched_dl_entity *dl_se = container_of(timer,
> @@ -1442,7 +1449,22 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  	dl_se->dl_non_contending = 0;
>  unlock:
>  	task_rq_unlock(rq, p, &rf);
> -	put_task_struct(p);
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/*
> +		 * Decrement the refcount explicitly to avoid unnecessarily
> +		 * calling call_rcu.
> +		 */
> +		if (refcount_dec_and_test(&p->usage))
> +			/*
> +			 * under PREEMPT_RT, we can't call put_task_struct
> +			 * in atomic context because it will indirectly
> +			 * acquire sleeping locks.
> +			 */
> +			call_rcu(&p->rcu, delayed_put_task_struct);
> +	} else {
> +		put_task_struct(p);
> +	}
>  
>  	return HRTIMER_NORESTART;
>  }
> -- 
> 2.39.0
> 
