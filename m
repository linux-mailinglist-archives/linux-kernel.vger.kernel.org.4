Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80996A14E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBXCZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:25:17 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD55E870
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:25:15 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ne1so12784464qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PDBgr54Vfa3PfNd3VzchAN71msIlCdFUIX7w+B3VJc=;
        b=V1QPpUJiO7RqrJbebYe1aBJX7toyPR/IzxvftZ7lJWdEpjUCmvFWCMNycL8q2G9Ilu
         v+S0aMEBFYbMB2Sp/Ads5Vq86NxXbsZaxzhB0M8zjifbjYx+aXm2tFEJA0u0FSyhuYF5
         dCcTuWsAoQJmVozUKRP0Hjj5cxsLVBFkKP0S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PDBgr54Vfa3PfNd3VzchAN71msIlCdFUIX7w+B3VJc=;
        b=BHQVz3aa8Ilf4bwXzb7zUJnD4f/V/pgc/50RXAifaSDqeBBxWuyGIKl5g9VadPOMIZ
         UQz7BDivobLkN57Hng45hm2SUt6Ivm4NECxdtuizcNdUhIqbq38FIQc3ep12jbsD0UQK
         +hg5wjlCYrlPzf7HO7oOTjgXj6HTMzJdq/t5R3bOJk6Ibm3WMXdHoRd5m4hYo4TLV05o
         q5TIg2701M1uInYxN739I1IByUo3Jpk00j+TAq5UY3Azj+N98kgged0+PORDedRcOCbl
         xaRLtSHNNQfZSS/qsrP6jt/19jOi719gZdAS8AFRNevY2JXHcsMyfW23OWO3d3um9vDy
         dmCQ==
X-Gm-Message-State: AO0yUKWzjYn3oaGwjN+bo2QGPuD7Y4BGz9ZLtp/9LRkn62vR+RM5B3VG
        Q0lFHSSb+o9mDR/MOe2pcjIKyQ==
X-Google-Smtp-Source: AK7set9+9fNEM/gDyn3rd4nAf0oji67wNWdiWAZZTs8JnczTMZYqPnkX2+BXycd+N5APjM5OSByv6g==
X-Received: by 2002:a05:6214:e8a:b0:56e:ff37:6b6e with SMTP id hf10-20020a0562140e8a00b0056eff376b6emr28650649qvb.10.1677205514622;
        Thu, 23 Feb 2023 18:25:14 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 9-20020a370409000000b00741a984943fsm6221829qke.40.2023.02.23.18.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 18:25:13 -0800 (PST)
Date:   Fri, 24 Feb 2023 02:25:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Message-ID: <Y/ggCdoMEhMO8vs+@google.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com>
 <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:36:05AM +0000, Zhang, Qiang1 wrote:
> On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> > > From: Zqiang <qiang1.zhang@intel.com>
> > > Sent: Thursday, February 23, 2023 2:30 PM
> > > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > > joel@joelfernandes.org
> > > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > > call_rcu_tasks_generic()
> > > 
> > > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > > call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeup
> > > using irq_work_queue() is because if the caller of
> > > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built with
> > > CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will be hold in
> > > wake_up(), so the lockdep splats will happen. but now using
> > > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> > > rcuwait_wake_up() no spinlock will be acquired, so this commit remove using
> > >
> > >There are still spinlock-acquisition and spinlock-release invocations within the call path from rcuwait_wake_up().
> > >
> > >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> > >
> > >    raw_spin_lock_irqsave()
> > >    ...
> > >    raw_spin_unlock_irqrestore
> > 
> > Yes, but this is raw_spinlock acquisition and release(note: spinlock will convert to
> > sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
> > 
> > acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
> >
> >Is this really safe in the long run though? I seem to remember there are
> >weird locking dependencies if RCU is used from within the scheduler [1].
> >
> 
> 
> I have  been running rcutorture with rcutorture.type = tasks-tracing,
> so far no problems have been found.
> 
> 
> >I prefer to keep it as irq_work_queue() unless you are seeing some benefit.
> >Generally, there has to be a 'win' or other justification for adding more
> >risk.
> >
> >thanks,
> >
> >- Joel
> >[1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-schedlocks.html
> 
> 
> The problem in this link,  in an earlier RCU version, rcu_read_unlock_special()
> Invoke wakeup and enter scheduler can lead to deadlock, but my modification is for
> call_rcu_tasks_generic(), even if there is a lock dependency problem, we should pay
> more attention to rcu_read_unlock_trace_special()

Consider ABBA deadlocks as well, not just self-deadlocks (which IIRC is what
the straight-RCU rcu_read_unlock() issues were about).

What prevents the following scenario?

In the scheduler you have code like this:
                rq = task_rq_lock(p, &rf);
                trace_sched_wait_task(p);

Someone can hook up a BPF program to that tracepoint that then calls
rcu_read_unlock_trace() -> rcu_read_unlock_trace_special(). All of
this while holding the rq and pi scheduler locks.

That's A (rq lock) -> B (rtpcp lock).

In another path, your change adds the following dependency due to doing
wakeup under the rtpcp lock.

That's call_rcu_tasks_generic() -> B (rtpcp lock) -> A (rq lock).

Maybe there is some other state that prevents this case, but it still makes
me queasy specially since there is perhaps no benefit more than deleting a
few lines of code.

Either way, nice observation!

Btw, the way irq_work works is quite interesting, so I guess what it does is
it does a self-IPI and then runs the callback in hard IRQ context, without
holding any locks. Another interesting fact is, there is also a "lazy"
version of the IRQ work API (IRQ_WORK_INIT_LAZY) which seems currently to be
used by printk. This executes the work from the scheduler tick instead of an
IPI handler unless the tick is stopped.

thanks,

 - Joel


> 
> Thanks
> Zqiang
> 
> >
> > > irq_work_queue(), invoke rcuwait_wake_up() directly in
> > > call_rcu_tasks_generic().
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tasks.h | 16 +---------------
> > >  1 file changed, 1 insertion(+), 15 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> > > baf7ec178155..757b8c6da1ad 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
> > >  	unsigned long rtp_jiffies;
> > >  	unsigned long rtp_n_lock_retries;
> > >  	struct work_struct rtp_work;
> > > -	struct irq_work rtp_irq_work;
> > >  	struct rcu_head barrier_q_head;
> > >  	struct list_head rtp_blkd_tasks;
> > >  	int cpu;
> > > @@ -112,12 +111,9 @@ struct rcu_tasks {
> > >  	char *kname;
> > >  };
> > > 
> > > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> > > -
> > >  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> > > 			\
> > >  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {
> > > 			\
> > >  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> > > __percpu.cbs_pcpu_lock),		\
> > > -	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> > > 			\
> > >  };
> > > 		\
> > >  static struct rcu_tasks rt_name =
> > > 		\
> > >  {
> > > 		\
> > > @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
> > >  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> > > data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> > > >percpu_enqueue_lim));
> > >  }
> > > 
> > > -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
> > > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> > > -	struct rcu_tasks *rtp;
> > > -	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct
> > > rcu_tasks_percpu, rtp_irq_work);
> > > -
> > > -	rtp = rtpcp->rtpp;
> > > -	rcuwait_wake_up(&rtp->cbs_wait);
> > > -}
> > > -
> > >  // Enqueue a callback for the specified flavor of Tasks RCU.
> > >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >  				   struct rcu_tasks *rtp)
> > > @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> > > *rhp, rcu_callback_t func,
> > >  	rcu_read_unlock();
> > >  	/* We can't create the thread unless interrupts are enabled. */
> > >  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> > > -		irq_work_queue(&rtpcp->rtp_irq_work);
> > > +		rcuwait_wake_up(&rtp->cbs_wait);
> > >  }
> > > 
> > >  // RCU callback function for rcu_barrier_tasks_generic().
> > > --
> > > 2.25.1
> > 
