Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA162A437
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiKOVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiKOVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:36:46 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA925C7B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:36:44 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so7286075vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pDlpcIILa5fx8cswH9nfAAlvEyZn3HJEFSlkJ/GqnNE=;
        b=oI0kzE1oJhnTbJiVua2J025SblkeNyYvyDsyU5rMvyfMFTqGFHmCWLQaA4hx30Yf88
         NjwXCohNxFXK+dQICaCDLy/ZCwUZuwh3eSJwN1APP7gfTkoiY6zHYK/bm7w4jySpqmjG
         rz0VjO8LcFP6HeWZxCi5iqaS/4qCeB0Uu6f3LMay65jdDlskkn3vn9BOl3qzxhGS+92X
         Qicilg5LEkR/we6/31sfZxoj4MepqoYK6foSBdoL8BsS2qvo27UefibV81CjODRylJtz
         vw7BotxVlC/eAqZctzIUOKdAsXVBls6MLCAm45xt+PXmPqBiQUOv9JwUxIbDiLRoJ2tY
         Qtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDlpcIILa5fx8cswH9nfAAlvEyZn3HJEFSlkJ/GqnNE=;
        b=ADONA47ujAl2Dq5Qj7fI6NWyWCNeQVSFDx9ZiaFNbtdeFWmzMZ1UCLa6GDXm+NrbxO
         VoXsa0aiI4U6ShMCzFXjGcNG3rvIhjZUQiv7BzcgJWoTvZCkR5jgaBAHMbuA6uHBpgVV
         kVGP14Z+62RmAZs27uaumB8r/WbA37hGCjQQya9OTMM569wvk7DjiKEa8jagbmOyncGo
         jdBi018DI1rVYte+4Wp5SHuadlQHKvDJ9YHeCeHOOolb1ZGS/4Bwa2sBb63ab4o0k7I5
         l882ebv1IpabVVLQ2MyLYWlT5Xqc5IG9XswLlLWyWzm7ZfQ8OBlZJ3yv/sEsCbiuw28G
         Yhaw==
X-Gm-Message-State: ANoB5pl4zhcr+TIobNpw+yal7EGGO0Z4jYWplTfJTn4I9fXULMSLynPP
        SBUv2YX29Td+6TSi4iKeFK0GBsoD5jLVP3ID/KxK
X-Google-Smtp-Source: AA0mqf5bnOeWShl2aOSmrqSKSGiS1Lmk8PrBTlPI03gplX8cbkkzTJrABgcAuaR+Dig1PWMjS7scRHrvgAPiXNt+jN8=
X-Received: by 2002:a05:6122:852:b0:3b8:68cc:1d1d with SMTP id
 18-20020a056122085200b003b868cc1d1dmr10598452vkk.14.1668548203468; Tue, 15
 Nov 2022 13:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y1Q2YqUFSxADWWtS@google.com>
In-Reply-To: <Y1Q2YqUFSxADWWtS@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 15 Nov 2022 13:36:31 -0800
Message-ID: <CANDhNCr5z+seg0Y=BVkJE0+xQLnjWfJuyFdv4i7yNdf57-yeSg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 11:28 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Oct 03, 2022 at 11:20:32PM +0000, John Stultz wrote:
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index a749a8663841..e3a4add67e8c 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -582,6 +582,11 @@ enum
> >   * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
> >   */
> >  #define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
> > +/* Softirq's where the handling might be long: */
> > +#define LONG_SOFTIRQ_MASK (BIT(NET_TX_SOFTIRQ)    | \
> > +                        BIT(NET_RX_SOFTIRQ)    | \
> > +                        BIT(BLOCK_SOFTIRQ)     | \
> > +                        BIT(IRQ_POLL_SOFTIRQ))
>
> Instead of a mask, I wonder if a better approach is to have a heuristic based
> on measurement of softirq load. There is already code to measure irq load
> (see update_irq_load_avg). Perhaps, Vincent would be willing to add the
> softirq load in it as well if asked nicely ;)
>
> That's much better because:
> 1. Any new softirqs added will also trigger this optimization.
> 2. Systems where these softirqs are quiet will not unnecessarily trigger it.
> 3. You can also include irq load so that things like IRQ storms also don't
> cause RT issues (when there are better "uncompromised" idle CPU candidates).
> 4. may not be need CONFIG option at all if the optimization makes
> sense for everything. Think all the systems not running Android.

Hey Joel,
  Thanks again for the feedback, and sorry to take awhile to get back to you.

I'll have to think about this some more, but I'm hesitant about
switching to a load based hursitic approach. Mostly as responding to
"load" feels a bit fuzzy to me.
If we suddenly get a burst of softirqs preempting scheduling, we don't
want to have to wait for the load tracking to recognize this, as the
effect of the blocked audio processing will be immediate.

That's why this optimization just avoids scheduling rt tasks on cpus
that are running potentially long-running softirqs, as we can't be
sure in that instance we'll be able to run soon.


> >  /* map softirq index to softirq name. update 'softirq_to_name' in
> >   * kernel/softirq.c when adding a new softirq.
> > @@ -617,6 +622,7 @@ extern void raise_softirq_irqoff(unsigned int nr);
> >  extern void raise_softirq(unsigned int nr);
> >
> >  DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
> > +DECLARE_PER_CPU(u32, active_softirqs);
> >
> >  static inline struct task_struct *this_cpu_ksoftirqd(void)
> >  {
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 532362fcfe31..3d1de6edcfa1 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1284,6 +1284,16 @@ config SCHED_AUTOGROUP
> >         desktop applications.  Task group autogeneration is currently based
> >         upon task session.
> >
> > +config RT_SOFTIRQ_OPTIMIZATION
>
> I much dislike this config option name because it does not self-explain what
> the option is and it is too long. More so, any future such optimizations,
> even if rare, will have to come up with another name causing more confusion.
> Instead, CONFIG_RT_AVOID_SOFTIRQS seems cleaner, but I'll defer to scheduler
> maintainers since they have to take the patch ultimately. Though I'll give my
> tag for a rename / better name. More below:

That's a fair point.  RT_SOFTIRQ_AWARE_SCHED maybe?


> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 55f39c8f4203..3c628db807c8 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1599,6 +1599,44 @@ static void yield_task_rt(struct rq *rq)
> >  #ifdef CONFIG_SMP
> >  static int find_lowest_rq(struct task_struct *task);
> >
> > +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> > +#define __use_softirq_opt 1
>
> Why not just use IS_ENABLED(CONFIG_RT_SOFTIRQ_OPT..) instead of defining new
> macros?

Mostly for readability. The lines where its added are already fairly long, ie:
  if (static_branch_unlikely(&sched_asym_cpucapacity)) {

So it seemed nicer to have the shorter macro.  But I'm not strongly
opinionated on this.

> > + * Return whether the given cpu is currently non-preemptible
> > + * while handling a potentially long softirq, or if the current
> > + * task is likely to block preemptions soon because it is a
> > + * ksoftirq thread that is handling slow softirq.
> > + */
> > +static bool cpu_busy_with_softirqs(int cpu)
> > +{
> > +     u32 softirqs = per_cpu(active_softirqs, cpu) |
> > +                    __cpu_softirq_pending(cpu);
> > +     struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> > +     struct task_struct *curr;
> > +     struct rq *rq = cpu_rq(cpu);
> > +     int ret;
> > +
> > +     rcu_read_lock();
>
> Could you clarify what is the RCU read-side critical section protecting?
>
> > +     curr = READ_ONCE(rq->curr); /* unlocked access */
> > +     ret = (softirqs & LONG_SOFTIRQ_MASK) &&
> > +              (curr == cpu_ksoftirqd ||
> > +               preempt_count() & SOFTIRQ_MASK);
>
> If the goal is to avoid ksoftirqd when it is running an actual softirq,
> doesn't ksoftirqd already run softirqs under local_bh_disable()? If so, then
> SOFTIRQ_MASK should already be set. If ksoftirqd is in between softirqs (and
> bh is enabled there), then scheduling the RT task on the CPU may preempt
> ksoftirqd and give the RT task a chance to run anyway, right?.

Yeah. I'm refactoring/simplifying this for v5, so hopefully it will be
more straightforward.

Thanks again for the feedback!
-john
