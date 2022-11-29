Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699F63C651
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiK2RVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiK2RVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:21:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9475E9C8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:21:11 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z3so10525652iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emgQiNWvNS8IY/EGAdau57CLTHPankSN/iU/Z474kZo=;
        b=kQN980yeQ2O+nKlP5N7HJbH7L2W5DZ6eWYrYdx6itMD/E5Z9YLDOq9hxqlLn7iPT7r
         yTzZ0oseh2L+N2k1C3tg9BC0DtKqQNX7v1yFRQM3mKkJZDdzytN4n4FZ2zDEU/TPQfe0
         5vFD+fC7xi0/LTAy1C0F3jbSSCowvvi6fOu/P3hWjgj5Y2PAOuKybALt0flmKmqTy8oE
         bTbGWKWdKcI5ItCnZX594oYT0g+KSg74GvU1LJB6L5fX8aJSYN9uKuFL8FPcjkK+r6gb
         NCFoeUDRQ0RexZF/O0nzVVempceYRwvhMTXtZwkpAUIHWJwQnE+4/lw/I6FHb/AmC9lo
         fD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emgQiNWvNS8IY/EGAdau57CLTHPankSN/iU/Z474kZo=;
        b=hNXy7xUuHBQVJSimK200XCEFgdXiqNJNdlsBAiwlUSLWty0K2xWpvuB3WE88z6As4m
         RpQL5yb6AwyyTQ5Nhh28Pz7vTOGX6MsYc+kPwvPQKUMLJg1otCgxFZCxcNn2ctoiZNgG
         lcyMxxSaBmfJW3+I6JKI9hrLjbqbnMTM7OdpK18azJjRpRwi9dYmusJZh6sWgOB55BgO
         rZIQxayVpIwF5ubFzvKZaVLGta1UVkS0b9Q8XWBUvfY4CHcbUANJzfkDqozBcoKikNpW
         D1rjViMgjap3fA2HzZTcabHtCVtnOVTh466sda+OTlhFXM7GGcCDCCV1sg5X6WuHO8j5
         ogbQ==
X-Gm-Message-State: ANoB5pknesFIov4Ykz14xXM0xXn6HrZs1LuFciUxvcaxGKl7LXB1A2DB
        bFO73u5kLRjvMvmc8qkNZBZk4daxAMavyPQdFQaHjg==
X-Google-Smtp-Source: AA0mqf68Bwg1GOUOsLxxD2d9G+00EOoVv5eSbeuAMK3I6vK4JtXAurA/km2I8LidVx7OlgKRZCAoVVMYfbDR69DcHM4=
X-Received: by 2002:a6b:c411:0:b0:6dd:dac4:7d4d with SMTP id
 y17-20020a6bc411000000b006dddac47d4dmr19033092ioa.208.1669742470519; Tue, 29
 Nov 2022 09:21:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtCZ5CttibZ9o18woLiQgzFeKCBMDAGrhMd3kbgX2qs29Q@mail.gmail.com>
 <E5C05A33-06E4-4627-8108-145752D72A24@joelfernandes.org>
In-Reply-To: <E5C05A33-06E4-4627-8108-145752D72A24@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Nov 2022 18:20:58 +0100
Message-ID: <CAKfTPtBZ8xfoP4=W1K5vaBBm5b05Ak9ojAdJeb2hvs5W=W3gmw@mail.gmail.com>
Subject: Re: [PATCH 5/9] sched/fair: Take into account latency priority at wakeup
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 at 16:45, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>
> Hi Vincent,
> Thank you so much for your quick reply.
>
> > On Nov 29, 2022, at 3:58 AM, Vincent Guittot <vincent.guittot@linaro.or=
g> wrote:
> >
> > =EF=BB=BFOn Tue, 29 Nov 2022 at 05:25, Joel Fernandes <joel@joelfernand=
es.org> wrote:
> >>
> >>> On Tue, Nov 15, 2022 at 12:19 PM Vincent Guittot
> >>> <vincent.guittot@linaro.org> wrote:
> >>>
> >>> Take into account the latency priority of a thread when deciding to
> >>> preempt the current running thread. We don't want to provide more CPU
> >>> bandwidth to a thread but reorder the scheduling to run latency sensi=
tive
> >>> task first whenever possible.
> >>>
> >>> As long as a thread didn't use its bandwidth, it will be able to pree=
mpt
> >>> the current thread.
> >>>
> >>> At the opposite, a thread with a low latency priority will preempt cu=
rrent
> >>> thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise i=
t will
> >>> wait for the tick to get its sched slice.
> >>>
> >>>                                   curr vruntime
> >>>                                       |
> >>>                      sysctl_sched_wakeup_granularity
> >>>                                   <-->
> >>> ----------------------------------|----|-----------------------|-----=
----------
> >>>                                  |    |<--------------------->
> >>>                                  |    .  sysctl_sched_latency
> >>>                                  |    .
> >>> default/current latency entity    |    .
> >>>                                  |    .
> >>> 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-=
1-1-1-1-1-
> >>> se preempts curr at wakeup ------>|<- se doesn't preempt curr -------=
----------
> >>>                                  |    .
> >>>                                  |    .
> >>>                                  |    .
> >>> low latency entity                |    .
> >>>                                   ---------------------->|
> >>>                               % of sysctl_sched_latency  |
> >>> 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-=
1-1-1-1-1-
> >>> preempt ------------------------------------------------->|<- do not =
preempt --
> >>>                                  |    .
> >>>                                  |    .
> >>>                                  |    .
> >>> high latency entity               |    .
> >>>         |<-----------------------|----.
> >>>         | % of sysctl_sched_latency   .
> >>> 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1=
-1-1-1-1-1
> >>> preempt->|<- se doesn't preempt curr --------------------------------=
----------
> >>> Tests results of nice latency impact on heavy load like hackbench:
> >>>
> >>> hackbench -l (2560 / group) -g group
> >>> group        latency 0             latency 19
> >>> 1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
> >>> 4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
> >>> 8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
> >>> 16           1.347(+/-  1%)      1.317(+/- 1%) + 2%
> >>>
> >>> hackbench -p -l (2560 / group) -g group
> >>> group
> >>> 1            1.836(+/- 17%)      1.148(+/- 5%) +37%
> >>> 4            1.586(+/-  6%)      1.109(+/- 8%) +30%
> >>> 8            1.209(+/-  4%)      0.780(+/- 4%) +35%
> >>> 16           0.805(+/-  5%)      0.728(+/- 4%) +10%
> >>>
> >>> By deacreasing the latency prio, we reduce the number of preemption a=
t
> >>> wakeup and help hackbench making progress.
> >>>
> >>> Test results of nice latency impact on short live load like cyclictes=
t
> >>> while competing with heavy load like hackbench:
> >>>
> >>> hackbench -l 10000 -g $group &
> >>> cyclictest --policy other -D 5 -q -n
> >>>        latency 0           latency -20
> >>> group   min  avg    max     min  avg    max
> >>> 0       16    19     29      17   18     29
> >>> 1       43   299   7359      63   84   3422
> >>> 4       56   449  14806      45   83    284
> >>> 8       63   820  51123      63   83    283
> >>> 16      64  1326  70684      41  157  26852
> >>>
> >>> group =3D 0 means that hackbench is not running.
> >>>
> >>> The avg is significantly improved with nice latency -20 especially wi=
th
> >>> large number of groups but min and max remain quite similar. If we ad=
d the
> >>> histogram parameter to get details of latency, we have :
> >>>
> >>> hackbench -l 10000 -g 16 &
> >>> cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
> >>>              latency 0    latency -20
> >>> Min Latencies:    64           62
> >>> Avg Latencies:  1170          107
> >>> Max Latencies: 88069        10417
> >>> 50% latencies:   122           86
> >>> 75% latencies:   614           91
> >>> 85% latencies:   961           94
> >>> 90% latencies:  1225           97
> >>> 95% latencies:  6120          102
> >>> 99% latencies: 18328          159
> >>>
> >>> With percentile details, we see the benefit of nice latency -20 as
> >>> only 1% of the latencies are above 159us whereas the default latency
> >>> has got 15% around ~1ms or above and 5% over the 6ms.
> >>>
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>> include/linux/sched.h      |  4 ++-
> >>> include/linux/sched/prio.h |  9 ++++++
> >>> init/init_task.c           |  2 +-
> >>> kernel/sched/core.c        | 38 +++++++++++++++++++---
> >>> kernel/sched/debug.c       |  2 +-
> >>> kernel/sched/fair.c        | 66 ++++++++++++++++++++++++++++++++++---=
-
> >>> kernel/sched/sched.h       |  6 ++++
> >>> 7 files changed, 112 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>> index 856240573300..2f33326adb8d 100644
> >>> --- a/include/linux/sched.h
> >>> +++ b/include/linux/sched.h
> >>> @@ -568,6 +568,8 @@ struct sched_entity {
> >>>        /* cached value of my_q->h_nr_running */
> >>>        unsigned long                   runnable_weight;
> >>> #endif
> >>> +       /* preemption offset in ns */
> >>> +       long                            latency_offset;
> >>>
> >>> #ifdef CONFIG_SMP
> >>>        /*
> >>> @@ -784,7 +786,7 @@ struct task_struct {
> >>>        int                             static_prio;
> >>>        int                             normal_prio;
> >>>        unsigned int                    rt_priority;
> >>> -       int                             latency_nice;
> >>> +       int                             latency_prio;
> >>>
> >>>        struct sched_entity             se;
> >>>        struct sched_rt_entity          rt;
> >>> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> >>> index bfcd7f1d1e11..be79503d86af 100644
> >>> --- a/include/linux/sched/prio.h
> >>> +++ b/include/linux/sched/prio.h
> >>> @@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long prio)
> >>>  * Default tasks should be treated as a task with latency_nice =3D 0.
> >>>  */
> >>> #define DEFAULT_LATENCY_NICE   0
> >>> +#define DEFAULT_LATENCY_PRIO   (DEFAULT_LATENCY_NICE + LATENCY_NICE_=
WIDTH/2)
> >>> +
> >>> +/*
> >>> + * Convert user-nice values [ -20 ... 0 ... 19 ]
> >>> + * to static latency [ 0..39 ],
> >>> + * and back.
> >>> + */
> >>> +#define NICE_TO_LATENCY(nice)  ((nice) + DEFAULT_LATENCY_PRIO)
> >>> +#define LATENCY_TO_NICE(prio)  ((prio) - DEFAULT_LATENCY_PRIO)
> >>>
> >>> #endif /* _LINUX_SCHED_PRIO_H */
> >>> diff --git a/init/init_task.c b/init/init_task.c
> >>> index 7dd71dd2d261..071deff8dbd1 100644
> >>> --- a/init/init_task.c
> >>> +++ b/init/init_task.c
> >>> @@ -78,7 +78,7 @@ struct task_struct init_task
> >>>        .prio           =3D MAX_PRIO - 20,
> >>>        .static_prio    =3D MAX_PRIO - 20,
> >>>        .normal_prio    =3D MAX_PRIO - 20,
> >>> -       .latency_nice   =3D DEFAULT_LATENCY_NICE,
> >>> +       .latency_prio   =3D DEFAULT_LATENCY_PRIO,
> >>>        .policy         =3D SCHED_NORMAL,
> >>>        .cpus_ptr       =3D &init_task.cpus_mask,
> >>>        .user_cpus_ptr  =3D NULL,
> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index 18c31a68eb18..b2b8cb6c08cd 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -1283,6 +1283,16 @@ static void set_load_weight(struct task_struct=
 *p, bool update_load)
> >>>        }
> >>> }
> >>>
> >>> +static void set_latency_offset(struct task_struct *p)
> >>> +{
> >>> +       long weight =3D sched_latency_to_weight[p->latency_prio];
> >>> +       s64 offset;
> >>> +
> >>> +       offset =3D weight * get_sleep_latency(false);
> >>> +       offset =3D div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
> >>> +       p->se.latency_offset =3D (long)offset;
> >>> +}
> >>> +
> >>> #ifdef CONFIG_UCLAMP_TASK
> >>> /*
> >>>  * Serializes updates of utilization clamp values
> >>> @@ -4592,7 +4602,9 @@ int sched_fork(unsigned long clone_flags, struc=
t task_struct *p)
> >>>                p->prio =3D p->normal_prio =3D p->static_prio;
> >>>                set_load_weight(p, false);
> >>>
> >>> -               p->latency_nice =3D DEFAULT_LATENCY_NICE;
> >>> +               p->latency_prio =3D NICE_TO_LATENCY(0);
> >>> +               set_latency_offset(p);
> >>> +
> >>>                /*
> >>>                 * We don't need the reset flag anymore after the fork=
. It has
> >>>                 * fulfilled its duty:
> >>> @@ -7358,8 +7370,10 @@ static void __setscheduler_params(struct task_=
struct *p,
> >>> static void __setscheduler_latency(struct task_struct *p,
> >>>                const struct sched_attr *attr)
> >>> {
> >>> -       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> >>> -               p->latency_nice =3D attr->sched_latency_nice;
> >>> +       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> >>> +               p->latency_prio =3D NICE_TO_LATENCY(attr->sched_laten=
cy_nice);
> >>> +               set_latency_offset(p);
> >>> +       }
> >>> }
> >>>
> >>> /*
> >>> @@ -7544,7 +7558,7 @@ static int __sched_setscheduler(struct task_str=
uct *p,
> >>>                if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> >>>                        goto change;
> >>>                if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> >>> -                   attr->sched_latency_nice !=3D p->latency_nice)
> >>> +                   attr->sched_latency_nice !=3D LATENCY_TO_NICE(p->=
latency_prio))
> >>>                        goto change;
> >>>
> >>>                p->sched_reset_on_fork =3D reset_on_fork;
> >>> @@ -8085,7 +8099,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, stru=
ct sched_attr __user *, uattr,
> >>>        get_params(p, &kattr);
> >>>        kattr.sched_flags &=3D SCHED_FLAG_ALL;
> >>>
> >>> -       kattr.sched_latency_nice =3D p->latency_nice;
> >>> +       kattr.sched_latency_nice =3D LATENCY_TO_NICE(p->latency_prio)=
;
> >>>
> >>> #ifdef CONFIG_UCLAMP_TASK
> >>>        /*
> >>> @@ -11294,6 +11308,20 @@ const u32 sched_prio_to_wmult[40] =3D {
> >>>  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> >>> };
> >>>
> >>> +/*
> >>> + * latency weight for wakeup preemption
> >>> + */
> >>> +const int sched_latency_to_weight[40] =3D {
> >>> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> >>> + /* -15 */      -768,     -717,     -666,      -614,      -563,
> >>> + /* -10 */      -512,     -461,     -410,      -358,      -307,
> >>> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> >>> + /*   0 */         0,       51,      102,       154,       205,
> >>> + /*   5 */       256,      307,      358,       410,       461,
> >>> + /*  10 */       512,      563,      614,       666,       717,
> >>> + /*  15 */       768,      819,      870,       922,       973,
> >>> +};
> >>> +
> >>
> >> The table is linear. You could approximate this as: weight =3D nice * =
51
> >> since it is a linear scale and do the conversion in place.
> >>
> >> Or, since the only place you are using the latency_to_weight is in
> >> set_latency_offset(), can we drop the sched_latency_to_weight array
> >> and simplify as follows?
> >
> > It's also used in cgroup patch and keeps a coherency between
> > nice/weight an latency_nice/offset so I prefer
>
> I dont think it=E2=80=99s a valid comparison as nice/weight conversion ar=
e non linear and over there a table makes sense: weight =3D 1024 / 1.25 ^ n=
ice
>
> > keeping current
> > implementation
>
> I could be missing something, but, since its a linear scale, why does cgr=
oup need weight at all? Just store nice directly. Why would that not work?
>
> In the end the TG and SE has the latency offset in the struct, that is al=
l you care about. All the conversion back and forth is unnecessary, as it i=
s a linear scale and just increases LOC and takes more memory to store line=
ar arrays.
>
> Again I could be missing something and I will try to play with your serie=
s and see if I can show you what I mean (or convince myself it=E2=80=99s ne=
eded).

I get what you mean but I think that having an array gives latitude to
adjust this internal offset mapping at a minimum cost of a const array

>
> >> static void set_latency_offset(struct task_struct *p)
> >> {
> >>  s64 offset =3D p->latency_prio * get_sleep_latency(false);
> >>  p->latency_prio =3D (long)div_s64(offset, 40);
> >> }
> >>
> >>> void call_trace_sched_update_nr_running(struct rq *rq, int count)
> >>> {
> >>>         trace_sched_update_nr_running_tp(rq, count);
> >>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> >>> index 68be7a3e42a3..b3922184af91 100644
> >>> --- a/kernel/sched/debug.c
> >>> +++ b/kernel/sched/debug.c
> >>> @@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p=
, struct pid_namespace *ns,
> >>> #endif
> >>>        P(policy);
> >>>        P(prio);
> >>> -       P(latency_nice);
> >>> +       P(latency_prio);
> >>>        if (task_has_dl_policy(p)) {
> >>>                P(dl.runtime);
> >>>                P(dl.deadline);
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index c8a697f8db88..0e80e65113bd 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4858,6 +4858,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int flags)
> >>>                update_idle_cfs_rq_clock_pelt(cfs_rq);
> >>> }
> >>>
> >>> +static long wakeup_latency_gran(struct sched_entity *curr, struct sc=
hed_entity *se);
> >>> +
> >>> /*
> >>>  * Preempt the current task with a newly woken task if needed:
> >>>  */
> >>> @@ -4866,7 +4868,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struc=
t sched_entity *curr)
> >>> {
> >>>        unsigned long ideal_runtime, delta_exec;
> >>>        struct sched_entity *se;
> >>> -       s64 delta;
> >>> +       s64 delta, offset;
> >>>
> >>>        ideal_runtime =3D sched_slice(cfs_rq, curr);
> >>>        delta_exec =3D curr->sum_exec_runtime - curr->prev_sum_exec_ru=
ntime;
> >>> @@ -4891,10 +4893,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, str=
uct sched_entity *curr)
> >>>        se =3D __pick_first_entity(cfs_rq);
> >>>        delta =3D curr->vruntime - se->vruntime;
> >>>
> >>> -       if (delta < 0)
> >>> +       offset =3D wakeup_latency_gran(curr, se);
> >>> +       if (delta < offset)
> >>>                return;
> >>
> >> Agreed.
> >>
> >>> -       if (delta > ideal_runtime)
> >>> +       if ((delta > ideal_runtime) ||
> >>> +           (delta > get_latency_max()))
> >>>                resched_curr(rq_of(cfs_rq));
> >>> }
> >>>
> >>> @@ -6019,6 +6023,35 @@ static int sched_idle_cpu(int cpu)
> >>> }
> >>> #endif
> >>>
> >>> +static void set_next_buddy(struct sched_entity *se);
> >>> +
> >>> +static void check_preempt_from_others(struct cfs_rq *cfs, struct sch=
ed_entity *se)
> >>> +{
> >>> +       struct sched_entity *next;
> >>> +
> >>> +       if (se->latency_offset >=3D 0)
> >>> +               return;
> >>> +
> >>> +       if (cfs->nr_running <=3D 1)
> >>> +               return;
> >>> +       /*
> >>> +        * When waking from another class, we don't need to check to =
preempt at
> >>> +        * wakeup and don't set next buddy as a candidate for being p=
icked in
> >>> +        * priority.
> >>> +        * In case of simultaneous wakeup when current is another cla=
ss, the
> >>> +        * latency sensitive tasks lost opportunity to preempt non se=
nsitive
> >>> +        * tasks which woke up simultaneously.
> >>> +        */
> >>> +
> >>> +       if (cfs->next)
> >>> +               next =3D cfs->next;
> >>> +       else
> >>> +               next =3D __pick_first_entity(cfs);
> >>> +
> >>> +       if (next && wakeup_preempt_entity(next, se) =3D=3D 1)
> >>> +               set_next_buddy(se);
> >>> +}
> >>> +
> >>> /*
> >>>  * The enqueue_task method is called before nr_running is
> >>>  * increased. Here we update the fair scheduling stats and
> >>> @@ -6105,14 +6138,15 @@ enqueue_task_fair(struct rq *rq, struct task_=
struct *p, int flags)
> >>>        if (!task_new)
> >>>                update_overutilized_status(rq);
> >>>
> >>> +       if (rq->curr->sched_class !=3D &fair_sched_class)
> >>> +               check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
> >>> +
> >>> enqueue_throttle:
> >>>        assert_list_leaf_cfs_rq(rq);
> >>>
> >>>        hrtick_update(rq);
> >>> }
> >>>
> >>> -static void set_next_buddy(struct sched_entity *se);
> >>> -
> >>> /*
> >>>  * The dequeue_task method is called before nr_running is
> >>>  * decreased. We remove the task from the rbtree and
> >>> @@ -7461,6 +7495,23 @@ balance_fair(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf)
> >>> }
> >>> #endif /* CONFIG_SMP */
> >>>
> >>> +static long wakeup_latency_gran(struct sched_entity *curr, struct sc=
hed_entity *se)
> >>> +{
> >>> +       long latency_offset =3D se->latency_offset;
> >>> +
> >>> +       /*
> >>> +        * A negative latency offset means that the sched_entity has =
latency
> >>> +        * requirement that needs to be evaluated versus other entity=
.
> >>> +        * Otherwise, use the latency weight to evaluate how much sch=
eduling
> >>> +        * delay is acceptable by se.
> >>> +        */
> >>> +       if ((latency_offset < 0) || (curr->latency_offset < 0))
> >>> +               latency_offset -=3D curr->latency_offset;
> >>> +       latency_offset =3D min_t(long, latency_offset, get_latency_ma=
x());
> >>
> >> Over here can we make positive latency offsets also be evaluated
> >> "versus other entity"?
> >>
> >> It feels strange to have different rules for positive latency_offset
> >> when comparing curr and se. IMO we should also factor in latency
> >> requirements by comparing 2 positive nice values. It should be
> >> relative even for positive values, just like regular nice IMO and not
> >> have hidden meaning. If there is hidden meaning, it confuses the user
> >> and requires documentation that most users will not read. Especially
> >> because latency_nice shares the word "nice" with regular nice values.
> >
> > This has already been discussed in the previous revisions.
>
> Sorry to be late to the party.
>
> > This is not
> > a hidden behavior but the normal behavior.
> >
> > A negative latency nice, means that the task are not tolerant to
> > scheduling delay and it want to preempt current and run now. Or, if
> > the task is current, it doesn't want to be preempted and finish its
> > slice. In this case, we compare current and wake up task in case there
> > is 2 latency sensitive tasks that are fighting to run 1st.
> >
> > Whereas a positive latency nice means that the task is tolerant to
> > scheduling delay and you don't care preempting current as long as it's
> > in an acceptable vruntime range. Why would the latency nice of the
> > current task make the wakeup task less tolerant to the scheduling
> > delay ? As an example, If current is latency_nice 19 and the wakeup
> > task is latency nice 19 too, both are tolerant to scheduling delay and
> > the waking up task should preempt current only if there is an
> > unfairness problem. By comparing their positive latency nice values,
> > you are back to the normal behavior which defeats the purpose of the
> > feature.
>
> I see it as, if 2 tasks are latency tolerant, then they will have higher =
latency with respect to a third tasks that is latency in tolerant. But I am=
 ok with your definition as well=E2=80=A6
>
> Thanks!
>
>  - Joel
>
> >
> > Thanks
> > Vincent
> >
> >>
> >> Thanks,
> >>
> >> - Joel
> >> .
> >>
> >>> +
> >>> +       return latency_offset;
> >>> +}
> >>> +
> >>> static unsigned long wakeup_gran(struct sched_entity *se)
> >>> {
> >>>        unsigned long gran =3D sysctl_sched_wakeup_granularity;
> >>> @@ -7499,11 +7550,12 @@ static int
> >>> wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity =
*se)
> >>> {
> >>>        s64 gran, vdiff =3D curr->vruntime - se->vruntime;
> >>> +       s64 offset =3D wakeup_latency_gran(curr, se);
> >>>
> >>> -       if (vdiff <=3D 0)
> >>> +       if (vdiff < offset)
> >>>                return -1;
> >>>
> >>> -       gran =3D wakeup_gran(se);
> >>> +       gran =3D offset + wakeup_gran(se);
> >>>
> >>>        /*
> >>>         * At wake up, the vruntime of a task is capped to not be olde=
r than
> >>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >>> index 842ce0094d9c..7292652731d0 100644
> >>> --- a/kernel/sched/sched.h
> >>> +++ b/kernel/sched/sched.h
> >>> @@ -125,6 +125,11 @@ extern int sched_rr_timeslice;
> >>>  */
> >>> #define NS_TO_JIFFIES(TIME)    ((unsigned long)(TIME) / (NSEC_PER_SEC=
 / HZ))
> >>>
> >>> +/* Maximum nice latency weight used to scale the latency_offset */
> >>> +
> >>> +#define NICE_LATENCY_SHIFT     (SCHED_FIXEDPOINT_SHIFT)
> >>> +#define NICE_LATENCY_WEIGHT_MAX        (1L << NICE_LATENCY_SHIFT)
> >>> +
> >>> /*
> >>>  * Increase resolution of nice-level calculations for 64-bit architec=
tures.
> >>>  * The extra resolution improves shares distribution and load balanci=
ng of
> >>> @@ -2115,6 +2120,7 @@ static_assert(WF_TTWU =3D=3D SD_BALANCE_WAKE);
> >>>
> >>> extern const int               sched_prio_to_weight[40];
> >>> extern const u32               sched_prio_to_wmult[40];
> >>> +extern const int               sched_latency_to_weight[40];
> >>>
> >>> /*
> >>>  * {de,en}queue flags:
> >>> --
> >>> 2.17.1
> >>>
