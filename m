Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD06C3CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCUVkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCUVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:40:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785720573
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:40:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x198so9245423ybe.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679434848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxkz61bPvh2EFDUg7bPe3mvjdDKF3Wi+qAZ8+SeylR8=;
        b=stbZd1UNNLhSlR3RSXeKrbJJ2hiBthcWSjPlZg4f8cYHIDWj5Wuuo0D7/VzuToDjKQ
         lhrIMNCW4IfyqBP7BWvCWTcKa6inXPR6JCC/iUT8gE1sQ2Z5n5RIhjbO0bKiBIJLZRsn
         CtNXOrleHJU21fbLfoGPlIwbpuaHOCS7nO6Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxkz61bPvh2EFDUg7bPe3mvjdDKF3Wi+qAZ8+SeylR8=;
        b=ITRNJQPgpv6zCHJPM4hvT14N8f6vYclIp2/Va3M8jxMwZnEf5WAXbEVOxzcW8aIhcM
         gpCdbRvyJVw9SCPROyIi0f7vnMyQNMDh9R+uA35EZLKQ17yYEwRpnpIZWXDqnbE0av1W
         Gkuyx+JvbHFogNdjTOfrciGDk73pOgYv1z28XNcbY74+bLpwLmyUiZYayBW5Z0c2KQOh
         bI1EHBYC0Bn7BtCgbS2HpRSLKOSGBJHO5bgxf8uHBUywbNrrYwY9r9W4y/qPgFZjE0ma
         OudaJJVX9M7UPYxg4n2NnL7JrsPQGU3oxvWpOwe7OtZVIqE687fIvYHIhgtcC+sPQ0rq
         4Ywg==
X-Gm-Message-State: AAQBX9fbenUORJEpidsm13nnWIBDIQagFVi4pH5MwCzX74qBwb4drLmO
        euzIIONY6GiFdzIF1MJBIichuAkr6xWRAHYYRtSOkg==
X-Google-Smtp-Source: AKy350YKyHM4s2mfuusWO5UKApvNFam8miGRchJAFuuT6+i1RigOA7ebmlyowAz2VG29ARbyWG1VHWn/qsnxIcIph74=
X-Received: by 2002:a5b:a48:0:b0:b3a:e877:3290 with SMTP id
 z8-20020a5b0a48000000b00b3ae8773290mr2587501ybq.2.1679434848324; Tue, 21 Mar
 2023 14:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230308100414.37114-1-jiahao.os@bytedance.com> <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
In-Reply-To: <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 21 Mar 2023 17:40:37 -0400
Message-ID: <CAEXW_YRG0Bw4U1+zOPpjRPQEeKNDMrs7x-ZE-W00aifn7heG4g@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Minor optimize pick_next_task() when
 core-sched enable
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Vineeth Pillai <vineethrp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 4:55=E2=80=AFAM Hao Jia <jiahao.os@bytedance.com> w=
rote:
>
> kindly ping...
>
> On 2023/3/8 Hao Jia wrote:
> > If core-sched is enabled, sometimes we will traverse each CPU on the co=
re
> > to find the highest priority task 'max' on the entire core, and then tr=
y
> > and find a runnable task that matches @max.
> > But in the following case, we choose the runnable task is not the best.
> >
> > core max: task2 (cookie 0)
> >
> >       rq0                             rq1
> > task0(cookie non-zero)                task2(cookie 0)
> > task1(cookie 0)
> > task3(cookie 0)
> > ...
> >
> > pick-task: idle                       pick-task: task2
> >
> > CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
> > highest priority tasks on rq0 and rq1 respectively, task2 is @max
> > on the entire core.
> >
> > In the case that 'max' has a zero cookie, instead of continuing to
> > search for a runnable task on rq0 that matches @max's cookie, we
> > choose idle for rq0 directly.
> > At this time, it is obviously better to choose task1 to run for rq0,
> > which will increase the CPU utilization.
> > Therefore, we queue tasks with zero cookies in core_tree, and record
> > the number of non-zero cookie tasks of each rq to detect the status
> > of the sched-core.

I do remember this as a known issue (more of a known but unimplemented
optimization) which happens when you have a high priority non-cookie
task which is in front of several low priority ones on the same
thread/rq. Adding +Vineeth Pillai to see if he remembers the issue.

I can try to take a look at it this week to make sense of your patch.
The code in upstream has changed quite a bit since we did this work on
the older kernels, so allow some time to page it all in.

Meanwhile, could you please provide some more details of your
usecase/workload and how this patch improves it? Also out of
curiosity, is bytedance using core scheduling for security or
something else?

Thanks,

 - Joel


> >
> > Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> > ---
> >   kernel/sched/core.c       | 29 +++++++++++++++--------------
> >   kernel/sched/core_sched.c |  9 ++++-----
> >   kernel/sched/sched.h      |  1 +
> >   3 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index af017e038b48..765cd14c52e1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -236,8 +236,8 @@ void sched_core_enqueue(struct rq *rq, struct task_=
struct *p)
> >   {
> >       rq->core->core_task_seq++;
> >
> > -     if (!p->core_cookie)
> > -             return;
> > +     if (p->core_cookie)
> > +             rq->cookied_count++;
> >
> >       rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
> >   }
> > @@ -246,11 +246,16 @@ void sched_core_dequeue(struct rq *rq, struct tas=
k_struct *p, int flags)
> >   {
> >       rq->core->core_task_seq++;
> >
> > +     if (p->core_cookie)
> > +             rq->cookied_count--;
> > +
> >       if (sched_core_enqueued(p)) {
> >               rb_erase(&p->core_node, &rq->core_tree);
> >               RB_CLEAR_NODE(&p->core_node);
> >       }
> >
> > +     if (!sched_core_enabled(rq))
> > +             return;
> >       /*
> >        * Migrating the last task off the cpu, with the cpu in forced id=
le
> >        * state. Reschedule to create an accounting edge for forced idle=
,
> > @@ -370,7 +375,7 @@ static void sched_core_assert_empty(void)
> >       int cpu;
> >
> >       for_each_possible_cpu(cpu)
> > -             WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
> > +             WARN_ON_ONCE(cpu_rq(cpu)->cookied_count);
> >   }
> >
> >   static void __sched_core_enable(void)
> > @@ -2061,14 +2066,12 @@ static inline void enqueue_task(struct rq *rq, =
struct task_struct *p, int flags)
> >       uclamp_rq_inc(rq, p);
> >       p->sched_class->enqueue_task(rq, p, flags);
> >
> > -     if (sched_core_enabled(rq))
> > -             sched_core_enqueue(rq, p);
> > +     sched_core_enqueue(rq, p);
> >   }
> >
> >   static inline void dequeue_task(struct rq *rq, struct task_struct *p,=
 int flags)
> >   {
> > -     if (sched_core_enabled(rq))
> > -             sched_core_dequeue(rq, p, flags);
> > +     sched_core_dequeue(rq, p, flags);
> >
> >       if (!(flags & DEQUEUE_NOCLOCK))
> >               update_rq_clock(rq);
> > @@ -6126,13 +6129,8 @@ pick_next_task(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf)
> >               rq_i =3D cpu_rq(i);
> >               p =3D rq_i->core_pick;
> >
> > -             if (!cookie_equals(p, cookie)) {
> > -                     p =3D NULL;
> > -                     if (cookie)
> > -                             p =3D sched_core_find(rq_i, cookie);
> > -                     if (!p)
> > -                             p =3D idle_sched_class.pick_task(rq_i);
> > -             }
> > +             if (!cookie_equals(p, cookie))
> > +                     p =3D sched_core_find(rq_i, cookie);
> >
> >               rq_i->core_pick =3D p;
> >
> > @@ -6333,6 +6331,7 @@ static void sched_core_cpu_starting(unsigned int =
cpu)
> >       sched_core_lock(cpu, &flags);
> >
> >       WARN_ON_ONCE(rq->core !=3D rq);
> > +     WARN_ON_ONCE(rq->cookied_count);
> >
> >       /* if we're the first, we'll be our own leader */
> >       if (cpumask_weight(smt_mask) =3D=3D 1)
> > @@ -6425,6 +6424,7 @@ static inline void sched_core_cpu_dying(unsigned =
int cpu)
> >   {
> >       struct rq *rq =3D cpu_rq(cpu);
> >
> > +     WARN_ON_ONCE(rq->cookied_count);
> >       if (rq->core !=3D rq)
> >               rq->core =3D rq;
> >   }
> > @@ -9917,6 +9917,7 @@ void __init sched_init(void)
> >               rq->core =3D rq;
> >               rq->core_pick =3D NULL;
> >               rq->core_enabled =3D 0;
> > +             rq->cookied_count =3D 0;
> >               rq->core_tree =3D RB_ROOT;
> >               rq->core_forceidle_count =3D 0;
> >               rq->core_forceidle_occupation =3D 0;
> > diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> > index a57fd8f27498..70f424abcc2b 100644
> > --- a/kernel/sched/core_sched.c
> > +++ b/kernel/sched/core_sched.c
> > @@ -56,6 +56,7 @@ static unsigned long sched_core_update_cookie(struct =
task_struct *p,
> >       unsigned long old_cookie;
> >       struct rq_flags rf;
> >       struct rq *rq;
> > +     bool enqueued;
> >
> >       rq =3D task_rq_lock(p, &rf);
> >
> > @@ -67,16 +68,14 @@ static unsigned long sched_core_update_cookie(struc=
t task_struct *p,
> >        */
> >       SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(r=
q));
> >
> > -     if (sched_core_enqueued(p))
> > +     enqueued =3D task_on_rq_queued(p);
> > +     if (enqueued)
> >               sched_core_dequeue(rq, p, DEQUEUE_SAVE);
> >
> >       old_cookie =3D p->core_cookie;
> >       p->core_cookie =3D cookie;
> >
> > -     /*
> > -      * Consider the cases: !prev_cookie and !cookie.
> > -      */
> > -     if (cookie && task_on_rq_queued(p))
> > +     if (enqueued)
> >               sched_core_enqueue(rq, p);
> >
> >       /*
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 3e8df6d31c1e..f5a0ee7fccae 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1148,6 +1148,7 @@ struct rq {
> >       unsigned int            core_task_seq;
> >       unsigned int            core_pick_seq;
> >       unsigned long           core_cookie;
> > +     unsigned int            cookied_count;
> >       unsigned int            core_forceidle_count;
> >       unsigned int            core_forceidle_seq;
> >       unsigned int            core_forceidle_occupation;
