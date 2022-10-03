Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F615F33EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJCQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJCQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:55:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9F3201B9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:55:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t16so12488623ljh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vTHmD1LXhUB0weUCrorx8ipYM6B6XXo2ei/uQ8ViPPA=;
        b=ZzSYm8iBs2xvHFxBniW3HCHU2xl/lJixQVTQMeruQnC0H0OKFfJ/ENwTLftROmLGBe
         3+NA2TXDcHjrtaQ2HxTj3wncMBMC7bOZmezSMRow6eoM5cLO6azqS5cT8BtN/WtqoZBi
         fjTQcjR+H7kHIMmfHSV7W048X3dpyCg57Wscw0tnvXFNVUmTslRG95GBec5bZe0iLTxO
         hnOs8FLg1q80o4uzdp0TmeHuDef33sw0fy74muYaGdpx2vwqCMV4w/CA2OGB4KNSoz8B
         PYXK4nVR3hXkaCn7V0CeHlGMGN3lMIjrw2VNBTBPlzrpSaHmoWZmh+59MIZxM+2qrhpp
         3png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vTHmD1LXhUB0weUCrorx8ipYM6B6XXo2ei/uQ8ViPPA=;
        b=huQ8sJPOVHKYNa7eaBmmWz1xteaLXkWluQQKfJIqfOSWNRKmV5bWFutgWda/rUriEH
         mQyrUzfXCZkw7+sLcVX/B0QrBLGxT6L+FOJf+O/HpZITR8Dmc+BFNfr8VaEivGOvj9F4
         KGKtOF/9+vzFqsj6YiCv1n1CNzTsOAEGcIDZAyRDyAsSvOBEfohKmJk3xBVN9VXRh2gs
         9lJYXP/7NpO+yC8yn0cXVelDXMZa3erae3rfNN6XA71zXix7gkgP7FbHU8oxDVkrpGWL
         tjfPGHLMrSydW+1Giq6P0JenmzzyXpUvlWePfxWxvQRmFd7O1CdVyd3+Z+6GsqcaLZGs
         Xmxw==
X-Gm-Message-State: ACrzQf3c6r0U7WLJiEUjaesslHVkRvr9aOSOp+V7/A3ZYZ7KU/0Tj7Wt
        0w/y4bF4vhYx1UBIcYTHdcmRTX7IhN7eFn37uwIA
X-Google-Smtp-Source: AMsMyM4ck9ZDn4SxzOoKosgL/53q+A++dGMwJEM6YVc6BWJjM97unmezuBIuIAJwu1pyeGOwtyfzuTa6ahr+/nMoXG4=
X-Received: by 2002:a05:651c:227:b0:26a:b322:b243 with SMTP id
 z7-20020a05651c022700b0026ab322b243mr6299105ljn.13.1664816112710; Mon, 03 Oct
 2022 09:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220921012550.3288570-1-jstultz@google.com> <20220921012550.3288570-3-jstultz@google.com>
 <20220928125517.ei64pxfucaem55cr@wubuntu>
In-Reply-To: <20220928125517.ei64pxfucaem55cr@wubuntu>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 3 Oct 2022 09:55:01 -0700
Message-ID: <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
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

On Wed, Sep 28, 2022 at 5:55 AM Qais Yousef <qais.yousef@arm.com> wrote:
> On 09/21/22 01:25, John Stultz wrote:
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index a749a8663841..1d126b8495bc 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -582,6 +582,12 @@ enum
> >   * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
> >   */
> >  #define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
> > +/* Softirq's where the handling might be long: */
> > +#define LONG_SOFTIRQ_MASK ((1 << NET_TX_SOFTIRQ)       | \
> > +                        (1 << NET_RX_SOFTIRQ)       | \
> > +                        (1 << BLOCK_SOFTIRQ)        | \
> > +                        (1 << IRQ_POLL_SOFTIRQ) | \
> > +                        (1 << TASKLET_SOFTIRQ))
>
> I'm not sure about the TASKLET. I can understand NET and BLOCK require high
> throughput, hence could end up in softirq for a long time. But TASKLET seems
> allowing sloppiness. I don't feel strongly about it, but worth debating if we
> really need to include it.

That's fair. Digging through the patch history in the Android trees,
the first pass was for all softirqs but then restricted to remove
known short-running ones.
From the bug history and what I can directly reproduce, the net and
block softirqs have definitely caused trouble, but I don't see a
specific example from TASKLET,  so I'm ok dropping that for now, and
should we get specific evidence we can argue for it in a future patch.

So I'll drop TASKLET from the list here. Thanks for the suggestion!

> > @@ -1284,6 +1284,16 @@ config SCHED_AUTOGROUP
> >         desktop applications.  Task group autogeneration is currently based
> >         upon task session.
> >
> > +config RT_SOFTIRQ_OPTIMIZATION
> > +     bool "Improve RT scheduling during long softirq execution"
> > +     depends on SMP
>
> Not sure if we need to depend on !PREEMPT_RT. This optimization might not be
> desired for those systems. I'll defer to PREEMPT_RT folks to decide on that.

Probably a safer default to turn it off w/ PREEMPT_RT. Thanks for the
suggestion!


> > +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> > +/*
> > + * Return whether the task on the given cpu is currently non-preemptible
> > + * while handling a potentially long softirq, or if the task is likely
> > + * to block preemptions soon because it is a ksoftirq thread that is
> > + * handling slow softirq.
> > + */
> > +static bool task_may_preempt(struct task_struct *task, int cpu)
> > +{
> > +     u32 softirqs = per_cpu(active_softirqs, cpu) |
> > +                    __cpu_softirq_pending(cpu);
> > +     struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> > +     struct task_struct *curr;
> > +     struct rq *rq = cpu_rq(cpu);
> > +     int ret;
> > +
> > +     rcu_read_lock();
> > +     curr = READ_ONCE(rq->curr); /* unlocked access */
> > +     ret = !((softirqs & LONG_SOFTIRQ_MASK) &&
> > +              (curr == cpu_ksoftirqd ||
> > +               preempt_count() & SOFTIRQ_MASK));
> > +     rcu_read_unlock();
> > +     return ret;
> > +}
> > +#else
> > +static bool task_may_preempt(struct task_struct *task, int cpu)
> > +{
> > +     return true;
> > +}
> > +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> > +
> > +static bool rt_task_fits_capacity_and_may_preempt(struct task_struct *p, int cpu)
> > +{
> > +     return task_may_preempt(p, cpu) && rt_task_fits_capacity(p, cpu);
> > +}
>
> Maybe better to rename to rt_task_fits_cpu() and make it generic?
>
> See below for more on that.
>
> > @@ -1641,9 +1683,10 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
> >        * requirement of the task - which is only important on heterogeneous
> >        * systems like big.LITTLE.
> >        */
> > -     test = curr &&
> > -            unlikely(rt_task(curr)) &&
> > -            (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
> > +     may_not_preempt = !task_may_preempt(curr, cpu);
> > +     test = (curr && (may_not_preempt ||
> > +                      (unlikely(rt_task(curr)) &&
> > +                       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio))));
>
> I think this is unnecesary if you create new rt_task_fits_cpu() and ...
>
> >
> >       if (test || !rt_task_fits_capacity(p, cpu)) {
>
> ... replace the call to rt_task_fits_capacity() with the new
> rt_task_fits_cpu()?


But is that really the same logic?  Above we're doing:
if ((!task_may_preempt(curr, cpu)|| <other stuff >) ||
!rt_task_fits_capacity(p, cpu))

And you're suggestion switching it to
if (<other stuff> || !rt_task_fits_cpu(p, cpu))
which would expand to:
if( <other stuff > || !(task_may_preempt(p, cpu) &&
rt_task_fits_capacity(p, cpu)))

I worry we would be skipping the part where we compare against curr.


> >               int target = find_lowest_rq(p);
> > @@ -1656,11 +1699,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
> >                       goto out_unlock;
> >
> >               /*
> > -              * Don't bother moving it if the destination CPU is
> > +              * If cpu is non-preemptible, prefer remote cpu
> > +              * even if it's running a higher-prio task.
> > +              * Otherwise: Don't bother moving it if the destination CPU is
> >                * not running a lower priority task.
> >                */
> >               if (target != -1 &&
> > -                 p->prio < cpu_rq(target)->rt.highest_prio.curr)
> > +                 (may_not_preempt ||
> > +                  p->prio < cpu_rq(target)->rt.highest_prio.curr))
> >                       cpu = target;
>
> I'm not sure this makes sense. You assume a higher priority task will cause
> less delay than softirqs. Which I think is an optimistic assumption?
>
> I think we should just mimic the same fallback behavior when we fail to find
> a CPU that fits the capacity requirement. Keeps things more consistent IMO.

This sounds reasonable.  I do fret that long-running rt tasks are less
common then the long running softirqs, so this may have an impact to
the effectiveness of the patch, but I also suspect it's even more rare
to have all the other cpus busy with rt tasks, so its probably very
unlikely.



> >       }
> >
> > @@ -1901,11 +1947,11 @@ static int find_lowest_rq(struct task_struct *task)
> >
> >               ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
> >                                         task, lowest_mask,
> > -                                       rt_task_fits_capacity);
> > +                                       rt_task_fits_capacity_and_may_preempt);
> >       } else {
> >
> > -             ret = cpupri_find(&task_rq(task)->rd->cpupri,
> > -                               task, lowest_mask);
> > +             ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
> > +                                       task, lowest_mask, task_may_preempt);
>
> I think we can simplify the code here to call cpupri_find_fitness()
> unconditionally passing the new rt_task_fits_cpu(). rt_task_fits_capacity()
> will always return true if the static key is disabled or uclamp is not
> configured. So rt_task_fits_cpu() will effectively depend on/boil down to
> task_may_preempt() in these cases.
>
> Note that I had this called unconditionally in the past, but Steve suggested
> doing it this way, IIRC, to avoid the cost of calling the fitness function when
> we don't need to. I'm not sure it matters to be honest, but if you follow my
> suggestion you might be asked to avoid the costs for the users who don't care
> about the fitness criteria.

I'll take another pass at it and see what I can do.

Thanks so much for the feedback!
-john
