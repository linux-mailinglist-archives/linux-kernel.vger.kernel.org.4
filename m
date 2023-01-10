Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE099664DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAJUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAJUxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612D217E15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673383937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqMwhJlGk4kKo2gKA12xyXafz+gSW3t4lNwWJYs2av4=;
        b=CDWQvyAfP9hnduWn2rShy3gbs1Xi5ND4uYIdzBWilUzRATM5A4RN3T9v7hQtekmaKNIbtI
        +Db6H9qRBVE8cd4vUeVjcX58l88MX78u9PuJGKYr0AJPrZVwG1y1V5dBLwU0QlnyvVKnOn
        Dwfyr9SY6DoCNV+H2S+gq5gqZgSwvrY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-388-qMKFnuspOZ6k0io3RTTy8Q-1; Tue, 10 Jan 2023 15:52:16 -0500
X-MC-Unique: qMKFnuspOZ6k0io3RTTy8Q-1
Received: by mail-pg1-f197.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so5695539pgc.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqMwhJlGk4kKo2gKA12xyXafz+gSW3t4lNwWJYs2av4=;
        b=Vt9uNaPyAEcIjAuTvD3jf+jisCtK1r5Y7IG/na/SZyz89EceVlyY5hUwRyotR8SWzm
         jCQnvpytBd3bm5HaciorREpRmhFRZWPbi/PRt96OyYBd/PiO/iILk1hKFVtGgTAVP7Jq
         +AOtjLFCK50qdshvPtlw1nOcnzJdXD3WAMg98A/6XXDII6G9OZGJPSgzGhiAJ3A00PWd
         sErIRgW4iOPU8A0zuU3laKxLzu5Od9PBjztKUT6dBrECBPYc8YzWKRMES6K5DgP2lWa1
         MpAQZsonOZxng0tREt/dFcOrTLIajgz4JG3a8tK4Jx7/pFwY58IcuRg1jMOb21v6CEdd
         AEFA==
X-Gm-Message-State: AFqh2kr86ZvvWnm2KPlbgT/Ds+Ib4Jp3oeisf9aH4CAHIanOuDGbGBL5
        hfg/nSvbyXzYqu1us7c9h6YHTPoBFnTbl7osWbLQTk+PlYLabzqmF2jYhm28oGJCkOWhBJKnReJ
        L9x24m8AWn8YNEXhNrh8RcAiVHI98ION/yZF0ckzR
X-Received: by 2002:a17:902:8688:b0:193:1300:832f with SMTP id g8-20020a170902868800b001931300832fmr1056332plo.86.1673383934971;
        Tue, 10 Jan 2023 12:52:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvF9w+1sm+xsL30fAd4rrKUNFWLrQBYeuLA756KCpcv5gYOliLv2ckJQdbkgRdkAOgmTA4B46OqlaQ0QNhbHJM=
X-Received: by 2002:a17:902:8688:b0:193:1300:832f with SMTP id
 g8-20020a170902868800b001931300832fmr1056328plo.86.1673383934683; Tue, 10 Jan
 2023 12:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20230104181701.43224-1-wander@redhat.com> <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Tue, 10 Jan 2023 17:52:03 -0300
Message-ID: <CAAq0SUm+VkoM38ULJE6zuajA3Tc7KYbiH51uc9oKjGE+RhDmXg@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with CONFIG_PREEMPT_RT
To:     paulmck@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 10:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 03:17:01PM -0300, Wander Lairson Costa wrote:
> > inactive_task_timer() executes in interrupt (atomic) context. It calls
> > put_task_struct(), which indirectly acquires sleeping locks under
> > PREEMPT_RT.
> >
> > Below is an example of a splat that happened in a test environment:
> >
> >  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
> >  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
> >  Call Trace:
> >  dump_stack_lvl+0x57/0x7d
> >  mark_lock_irq.cold+0x33/0xba
> >  ? stack_trace_save+0x4b/0x70
> >  ? save_trace+0x55/0x150
> >  mark_lock+0x1e7/0x400
> >  mark_usage+0x11d/0x140
> >  __lock_acquire+0x30d/0x930
> >  lock_acquire.part.0+0x9c/0x210
> >  ? refill_obj_stock+0x3d/0x3a0
> >  ? rcu_read_lock_sched_held+0x3f/0x70
> >  ? trace_lock_acquire+0x38/0x140
> >  ? lock_acquire+0x30/0x80
> >  ? refill_obj_stock+0x3d/0x3a0
> >  rt_spin_lock+0x27/0xe0
> >  ? refill_obj_stock+0x3d/0x3a0
> >  refill_obj_stock+0x3d/0x3a0
> >  ? inactive_task_timer+0x1ad/0x340
> >  kmem_cache_free+0x357/0x560
> >  inactive_task_timer+0x1ad/0x340
> >  ? switched_from_dl+0x2d0/0x2d0
> >  __run_hrtimer+0x8a/0x1a0
> >  __hrtimer_run_queues+0x91/0x130
> >  hrtimer_interrupt+0x10f/0x220
> >  __sysvec_apic_timer_interrupt+0x7b/0xd0
> >  sysvec_apic_timer_interrupt+0x4f/0xd0
> >  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> >  asm_sysvec_apic_timer_interrupt+0x12/0x20
> >  RIP: 0033:0x7fff196bf6f5
> >
> > Instead of calling put_task_struct() directly, we defer it using
> > call_rcu(). A more natural approach would use a workqueue, but since
> > in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> > the code would become more complex because we would need to put the
> > work_struct instance in the task_struct and initialize it when we
> > allocate a new task_struct.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/sched/build_policy.c |  1 +
> >  kernel/sched/deadline.c     | 24 +++++++++++++++++++++++-
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> > index d9dc9ab3773f..f159304ee792 100644
> > --- a/kernel/sched/build_policy.c
> > +++ b/kernel/sched/build_policy.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/tsacct_kern.h>
> >  #include <linux/vtime.h>
> > +#include <linux/rcupdate.h>
> >
> >  #include <uapi/linux/sched/types.h>
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 9ae8f41e3372..ab9301d4cc24 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1405,6 +1405,13 @@ static void update_curr_dl(struct rq *rq)
> >       }
> >  }
> >
> > +static void delayed_put_task_struct(struct rcu_head *rhp)
> > +{
> > +     struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > +
> > +     __put_task_struct(task);
>
> Please note that BH is disabled here.  Don't you therefore
> need to schedule a workqueue handler?  Perhaps directly from
> inactive_task_timer(), or maybe from this point.  If the latter, one
> way to skip the extra step is to use queue_rcu_work().
>

My initial work was using a workqueue [1,2]. However, I realized I
could reach a much simpler code with call_rcu().
I am afraid my ignorance doesn't allow me to get your point. Does
disabling softirq imply atomic context?


[1] https://gitlab.com/walac/kernel-ark/-/commit/ec8addbe38d5c318f1789b4c0fa480a9d2afdb65
[2] https://gitlab.com/walac/kernel-ark/-/commit/0bde233235ffed233a7466a36a4866bc48064f54


>                                                         Thanx, Paul
>
> > +}
> > +
> >  static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
> >  {
> >       struct sched_dl_entity *dl_se = container_of(timer,
> > @@ -1442,7 +1449,22 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
> >       dl_se->dl_non_contending = 0;
> >  unlock:
> >       task_rq_unlock(rq, p, &rf);
> > -     put_task_struct(p);
> > +
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +             /*
> > +              * Decrement the refcount explicitly to avoid unnecessarily
> > +              * calling call_rcu.
> > +              */
> > +             if (refcount_dec_and_test(&p->usage))
> > +                     /*
> > +                      * under PREEMPT_RT, we can't call put_task_struct
> > +                      * in atomic context because it will indirectly
> > +                      * acquire sleeping locks.
> > +                      */
> > +                     call_rcu(&p->rcu, delayed_put_task_struct);
> > +     } else {
> > +             put_task_struct(p);
> > +     }
> >
> >       return HRTIMER_NORESTART;
> >  }
> > --
> > 2.39.0
> >
>

