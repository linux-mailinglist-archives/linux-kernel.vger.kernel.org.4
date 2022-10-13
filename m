Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EB5FDED1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJMRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:19:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0F1A3A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:19:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so5373933eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdi+PA13W9NAkZaDWNItKdIezq/ip1L8QpNyLU7aT6Q=;
        b=U3Pd5J0zrLIvYC1bTTQOcL7w+WbWVZwTL1Ux/0MNGAZh69mfkyOyCaBYuI+d/fR56y
         PpWOJXTPEMFQ3I2sdtjeiALxDhPu3G1rLQiX3IHjpaxM+W3EcbTaAnsYVul2fQStVcUU
         mG5obwQYC1pyTgKsVxBHJkPuCTc7SFLZBSkP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdi+PA13W9NAkZaDWNItKdIezq/ip1L8QpNyLU7aT6Q=;
        b=gbkjipd1N/yUzmzfGbBWqO7UEj2mTJyao50ByppxJQkAFVIpdMb2Z777VBcmt2ZNbF
         XMHMMvm/4Q1iKs7mrRYOOURbM7M5W1rF8+3qt1V6bJczs51AKoFVUYsOKJEfrz5hXZvk
         PLZsUNSXRTbAbRQMdvzFMNi4VSE8pi77BhQQ+POuEJBCgsYIz+CczCWy1++yIJfhR2yM
         3de8ulpCX3ECUqKhPqCetNyKCwQ9rtVCL0Lon5MdGrLYYunx5zKshWUnDJEATxz58Elk
         kmPoJ/W17vcSMOyb+v9mPNN4mhbCn1XlfT0V2fRim5gAm6/gHkQfRc6jfvETsdMwR0Wd
         vrmg==
X-Gm-Message-State: ACrzQf2uX/ZAzhhktN40aqVgiRb+D1IdVVaS0sZl3Tf9dPFM4OKHorH8
        leh2JdAEZ9jQzC4aIu3pVTlDwGaO3UxRODrbell+XQ==
X-Google-Smtp-Source: AMsMyM4GZyQ2s+gtaCU9/+iKpJCln8fUggieEOdTmZhGMF08XuyBbHjkghm5EggSTEJASpF4ZKiSHlLO8J865q+cqsU=
X-Received: by 2002:a17:906:fd8a:b0:75d:c79a:47c8 with SMTP id
 xa10-20020a170906fd8a00b0075dc79a47c8mr545242ejb.389.1665681589351; Thu, 13
 Oct 2022 10:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org> <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
 <CAKfTPtAh30v=XoJPvAeFxu274CDW0uf2UY4Z8ySJz123ko5xgw@mail.gmail.com>
 <CA+q576Po0bskXfBP3EXUGG9jFLAP66iH6EamXfPUg9LC6qQyCg@mail.gmail.com> <20221012152130.GA20993@vingu-book>
In-Reply-To: <20221012152130.GA20993@vingu-book>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Thu, 13 Oct 2022 12:19:38 -0500
Message-ID: <CA+q576N+NeKPTn7Ekw1rOcnA4+4PkGrw1mHD33SYTh=eAdHpsw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Add latency list
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:21 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Le mardi 11 oct. 2022 =C3=A0 18:54:27 (-0500), Youssef Esmat a =C3=A9crit=
 :
> > Hi Vincent,
> >
> > On Tue, Oct 11, 2022 at 12:10 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
>
> ...
>
> > > > >               latency 0    latency -20
> > > > > Min Latencies:    60           61
> > > > > Avg Latencies:  1077           86
> > > > > Max Latencies: 87311          444
> > > > > 50% latencies:    92           85
> > > > > 75% latencies:   554           90
> > > > > 85% latencies:  1019           93
> > > > > 90% latencies:  1346           96
> > > > > 95% latencies:  5400          100
> > > > > 99% latencies: 19044          110
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > >
> > > > The ability to boost the latency sensitivity of a task seems very
> > > > interesting. I have been playing around with these changes and have
> > > > some observations.
> > > >
> > > > I tried 2 bursty tasks affinitized to the same CPU. The tasks sleep
> > > > for 1ms and run for 10ms in a loop. I first tried it without adjust=
ing
> > > > the latency_nice value and took perf sched traces:
> > >
> > > The CPU is overloaded almost all the time as it can't run the 2 tasks
> > > (2*10ms every 11ms)
> > >
> > > >
> > > > latency_test:7040     |   2447.137 ms |        8 | avg:   6.546 ms =
|
> > > > max:  10.674 ms | max start:   353.809487 s | max end:   353.820161=
 s
> > > > latency_test:7028     |   2454.777 ms |        7 | avg:   4.494 ms =
|
> > > > max:  10.609 ms | max start:   354.804386 s | max end:   354.814995=
 s
> > > >
> > > > Everything looked as expected, for a 5s run they had similar runtim=
e
> > > > and latency.
> > > >
> > > > I then adjusted one task to have a latency_nice of -20 (pid 8614
> > > > below) and took another set of traces:
> > > >
> > > > latency_test:8618     |   1845.534 ms |      131 | avg:   9.764 ms =
|
> > > > max:  10.686 ms | max start:  1405.737905 s | max end:  1405.748592=
 s
> > > > latency_test:8614     |   3033.635 ms |       16 | avg:   3.559 ms =
|
> > > > max:  10.467 ms | max start:  1407.594751 s | max end:  1407.605218=
 s
> > > >
> > > > The task with -20 latency_nice had significantly more runtime. The
> > > > average latency was improved but the max roughly stayed the same. A=
s
> > > > expected the one with latency_nice value of 0 experienced more
> > > > switches, but so did the one with latency_nice of -20.
> > >
> > > Your results look unexpected because the vruntime of the tasks is not
> > > modified. So I can imagine that the thread with the low latency runs
> > > first up to the offset at the beg of the test but then they should
> > > switch regularly. I have tried a similar test with a modified rt-app
> > > and the result seems ok. I have a small difference but not the
> > > difference that you see.
> > >
> > > Could you share more details about your setup ? I'm going to try to
> > > reproduce your sequence
> >
> > I was using an intel core i7 with this frequency details:
> > CPU MHz:                         4200.000
> > CPU max MHz:                  4800.0000
> > CPU min MHz:                   400.0000
> >
> > This is a snippet of the test I was using:
> >
> > struct sched_attr attr;
> > memset(&attr, 0, sizeof(struct sched_attr));
> > attr.size =3D sizeof(struct sched_attr);
> > attr.sched_latency_nice =3D nice_latency;
> > attr.sched_flags =3D SCHED_FLAG_LATENCY_NICE;
> >
> > // set nice latency value
> > int res =3D syscall(__NR_sched_setattr, 0, &attr, 0);
> >
> > while(1){
> >   // wake up every ms
> >   usleep(1000);
> >   for(int i =3D 0; i < 40000000; i++){}
> > }
>
> Between v2 and v3, the sched_feat(GENTLE_FAIR_SLEEPERS) has diseappeared =
when
> I moved the computation of latency_offset at the setting of the latency p=
rio
> instead of runtime. As a result, the latency nice task can preempt up to
> (sysctl_sched_latency - sysctl_sched_wakeup_granularity) but other thread=
s are
> cap to half of sysctl_sched_latency at wakeup.
>
> Could you try the patch below ?

Thanks Vincent. That improved the runtime for the tests above.

Running two bursty tasks (1ms sleep and 10ms running loop) one of
which had a latency_nice of -20 (pid 9209) and the other 0:

latency_test:9205     |   2429.467 ms |       14 | avg:   6.293 ms |
max:  11.340 ms | max start:   209.543482 s | max end:   209.554821 s
latency_test:9209     |   2467.423 ms |       17 | avg:   3.346 ms |
max:  11.475 ms | max start:   208.374517 s | max end:   208.385992 s

The task with -20 latency_nice had an improved average latency, but
the max roughly stayed the same.

Running the same test with 3 bursty tasks, one of which had a
latency_nice of -20 and the other two with latency_nice =3D 0. The
results for this case roughly stayed the same after the changes:

latency_test:26088    |   1641.458 ms |      158 | avg:  19.613 ms |
max:  33.000 ms | max start:   871.707231 s | max end:   871.740231 s
latency_test:26295    |   1639.766 ms |      238 | avg:  10.259 ms |
max:  24.289 ms | max start:   873.917231 s | max end:   873.941519 s
latency_test:26401    |   1643.580 ms |      241 | avg:  10.200 ms |
max:  22.124 ms | max start:   876.289233 s | max end:   876.311357 s

The task with latency_nice -20 seemed to have the highest average and
max latencies.

I also tried an additional test where we had a task that was cpu bound
(while(1){}) and a task that ran for 1ms and slept for 1ms. The cpu
bound task had the latency_nice value of -20 and the bursty had
latency_nice of 0.

latency_test:17353    |   4557.699 ms |      356 | avg:   1.058 ms |
max:   1.181 ms | max start:  4324.806123 s | max end:  4324.807304 s
latency_test:17452    |    377.804 ms |        1 | avg:   0.000 ms |
max:   0.000 ms | max start:     0.000000 s | max end:     0.000000 s

The cpu bound task (pid 17353 above) had significantly more runtime.
If I reran the test with latency_nice =3D 0 for both:

latency_test:20748    |   2478.014 ms |     2367 | avg:   1.037 ms |
max:   1.182 ms | max start:  4460.769240 s | max end:  4460.770423 s
latency_test:20972    |   2455.888 ms |        3 | avg:   0.001 ms |
max:   0.002 ms | max start:  4460.628756 s | max end:  4460.628758 s

Would decreasing the latency_offset as the task runs and increasing it
as it sleeps help here?


>
> ---
>  kernel/sched/core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8b44685ae247..68f9a83d7089 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1287,11 +1287,15 @@ static void set_load_weight(struct task_struct *p=
, bool update_load)
>  static void set_latency_offset(struct task_struct *p)
>  {
>         long weight =3D sched_latency_to_weight[p->latency_prio];
> +       unsigned long period =3D sysctl_sched_latency;
>         s64 offset;
>
> -       offset =3D sysctl_sched_latency * weight;
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               period >>=3D 1;
> +       offset =3D period * weight;
>         offset =3D div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
>         p->se.latency_offset =3D (long)offset;
> +       trace_printk("set_latency_offset pid %d offset %ld", p->pid, offs=
et);
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> @@ -10894,12 +10898,17 @@ static int cpu_idle_write_s64(struct cgroup_sub=
sys_state *css,
>  static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
>                                     struct cftype *cft)
>  {
> +       unsigned long period =3D sysctl_sched_latency;
>         int last_delta =3D INT_MAX;
>         int prio, delta;
>         s64 weight;
>
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               period >>=3D 1;
> +
>         weight =3D css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> -       weight =3D div_s64(weight, sysctl_sched_latency);
> +       period =3D sysctl_sched_latency;
> +       weight =3D div_s64(weight, period);
>
>         /* Find the closest nice value to the current weight */
>         for (prio =3D 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio=
++) {
> @@ -10915,6 +10924,7 @@ static s64 cpu_latency_nice_read_s64(struct cgrou=
p_subsys_state *css,
>  static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
>                                      struct cftype *cft, s64 nice)
>  {
> +       unsigned long period;
>         s64 latency_offset;
>         long weight;
>         int idx;
> @@ -10926,7 +10936,10 @@ static int cpu_latency_nice_write_s64(struct cgr=
oup_subsys_state *css,
>         idx =3D array_index_nospec(idx, LATENCY_NICE_WIDTH);
>         weight =3D sched_latency_to_weight[idx];
>
> -       latency_offset =3D sysctl_sched_latency * weight;
> +       period =3D sysctl_sched_latency;
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               period >>=3D 1;
> +       latency_offset =3D period * weight;
>         latency_offset =3D div_s64(latency_offset, NICE_LATENCY_WEIGHT_MA=
X);
>
>         return sched_group_set_latency(css_tg(css), latency_offset);
> --
> 2.17.1
>
> >
> > >
> > > >
> > > > Also tried running the same test but instead of using latency nice =
I
> > > > adjusted the nice value as a comparison. In that case one task had =
a
> > > > nice of -5 and the other was 0.
> > > >
> > > > nice_test:25219       |   1216.839 ms |      242 | avg:  10.295 ms =
|
> > > > max:  11.927 ms | max start:  5877.881279 s | max end:  5877.893206=
 s
> > > > nice_test:25235       |   3711.788 ms |        6 | avg:   1.026 ms =
|
> > > > max:   6.143 ms | max start:  5875.603741 s | max end:  5875.609883=
 s
> > > >
> > > > As expected the one with a nice value of -5 had more runtime but al=
so
> > > > had better latency numbers than in the previous case of using
> > > > latency_nice.
> > > >
> > > > I also tried a similar test with 3 bursty tasks instead of two. In
> > > > this case all tasks had a latency_nice of 0:
> > > >
> > > > latency_test:11467    |   1641.131 ms |      161 | avg:  17.489 ms =
|
> > > > max:  21.011 ms | max start:  1542.656275 s | max end:  1542.677286=
 s
> > > > latency_test:11463    |   1644.809 ms |      161 | avg:  11.994 ms =
|
> > > > max:  25.012 ms | max start:  1545.657776 s | max end:  1545.682788=
 s
> > > > latency_test:11478    |   1643.211 ms |      160 | avg:  11.465 ms =
|
> > > > max:  21.012 ms | max start:  1546.159026 s | max end:  1546.180038=
 s
> > > >
> > > > Next I tried two tasks with a latency_nice of 0 and a third one had=
 a
> > > > latency_nice of -20 (pid 11763 below):
> > > >
> > > > latency_test:11763    |   1645.482 ms |      159 | avg:  19.634 ms =
|
> > > > max:  31.016 ms | max start:  1623.834862 s | max end:  1623.865877=
 s
> > > > latency_test:11750    |   1644.276 ms |      259 | avg:   9.985 ms =
|
> > > > max:  21.012 ms | max start:  1623.953921 s | max end:  1623.974933=
 s
> > > > latency_test:11747    |   1642.745 ms |      262 | avg:   9.079 ms =
|
> > > > max:  25.013 ms | max start:  1620.980435 s | max end:  1621.005447=
 s
> > > >
> > > > In this case it seemed like the runtime was not affected by the
> > > > latency_nice value, but strangely the task with the latency nice of
> > > > -20 had a worse average and max latency than the other two. The
> > > > context switch times are also increased from the previous case.
> > > >
> > > > Have we considered an approach where the task that is marked as
> > > > latency sensitive gets a boosted nice value when it sleeps and is
> > > > either scaled down exponentially as it runs, or immediately reset t=
o
> > > > its default when it runs for one tick?
> > > >
> > > > Thanks,
> > > > Youssef
> > > >
> > > >
> > > > >  include/linux/sched.h |  2 +
> > > > >  kernel/sched/fair.c   | 96 +++++++++++++++++++++++++++++++++++++=
++++--
> > > > >  kernel/sched/sched.h  |  1 +
> > > > >  3 files changed, 96 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > index a74cad08e91e..0b92674e3664 100644
> > > > > --- a/include/linux/sched.h
> > > > > +++ b/include/linux/sched.h
> > > > > @@ -547,6 +547,8 @@ struct sched_entity {
> > > > >         /* For load-balancing: */
> > > > >         struct load_weight              load;
> > > > >         struct rb_node                  run_node;
> > > > > +       struct rb_node                  latency_node;
> > > > > +       unsigned int                    on_latency;
> > > > >         struct list_head                group_node;
> > > > >         unsigned int                    on_rq;
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index e524e892d118..1a72f34136d8 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -664,7 +664,77 @@ struct sched_entity *__pick_last_entity(stru=
ct cfs_rq *cfs_rq)
> > > > >
> > > > >         return __node_2_se(last);
> > > > >  }
> > > > > +#endif
> > > > >
> > > > > +/**************************************************************
> > > > > + * Scheduling class tree data structure manipulation methods:
> > > > > + * for latency
> > > > > + */
> > > > > +
> > > > > +static inline bool latency_before(struct sched_entity *a,
> > > > > +                               struct sched_entity *b)
> > > > > +{
> > > > > +       return (s64)(a->vruntime + a->latency_offset - b->vruntim=
e - b->latency_offset) < 0;
> > > > > +}
> > > > > +
> > > > > +#define __latency_node_2_se(node) \
> > > > > +       rb_entry((node), struct sched_entity, latency_node)
> > > > > +
> > > > > +static inline bool __latency_less(struct rb_node *a, const struc=
t rb_node *b)
> > > > > +{
> > > > > +       return latency_before(__latency_node_2_se(a), __latency_n=
ode_2_se(b));
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Enqueue an entity into the latency rb-tree:
> > > > > + */
> > > > > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
> > > > > +{
> > > > > +
> > > > > +       /* Only latency sensitive entity can be added to the list=
 */
> > > > > +       if (se->latency_offset >=3D 0)
> > > > > +               return;
> > > > > +
> > > > > +       if (se->on_latency)
> > > > > +               return;
> > > > > +
> > > > > +       /*
> > > > > +        * An execution time less than sysctl_sched_min_granulari=
ty means that
> > > > > +        * the entity has been preempted by a higher sched class =
or an entity
> > > > > +        * with higher latency constraint.
> > > > > +        * Put it back in the list so it gets a chance to run 1st=
 during the
> > > > > +        * next slice.
> > > > > +        */
> > > > > +       if (!(flags & ENQUEUE_WAKEUP)) {
> > > > > +               u64 delta_exec =3D se->sum_exec_runtime - se->pre=
v_sum_exec_runtime;
> > > > > +
> > > > > +               if (delta_exec >=3D sysctl_sched_min_granularity)
> > > > > +                       return;
> > > > > +       }
> > > > > +
> > > > > +       rb_add_cached(&se->latency_node, &cfs_rq->latency_timelin=
e, __latency_less);
> > > > > +       se->on_latency =3D 1;
> > > > > +}
> > > > > +
> > > > > +static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sche=
d_entity *se)
> > > > > +{
> > > > > +       if (se->on_latency) {
> > > > > +               rb_erase_cached(&se->latency_node, &cfs_rq->laten=
cy_timeline);
> > > > > +               se->on_latency =3D 0;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static struct sched_entity *__pick_first_latency(struct cfs_rq *=
cfs_rq)
> > > > > +{
> > > > > +       struct rb_node *left =3D rb_first_cached(&cfs_rq->latency=
_timeline);
> > > > > +
> > > > > +       if (!left)
> > > > > +               return NULL;
> > > > > +
> > > > > +       return __latency_node_2_se(left);
> > > > > +}
> > > > > +
> > > > > +#ifdef CONFIG_SCHED_DEBUG
> > > > >  /**************************************************************
> > > > >   * Scheduling class statistics methods:
> > > > >   */
> > > > > @@ -4455,8 +4525,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se, int flags)
> > > > >         check_schedstat_required();
> > > > >         update_stats_enqueue_fair(cfs_rq, se, flags);
> > > > >         check_spread(cfs_rq, se);
> > > > > -       if (!curr)
> > > > > +       if (!curr) {
> > > > >                 __enqueue_entity(cfs_rq, se);
> > > > > +               __enqueue_latency(cfs_rq, se, flags);
> > > > > +       }
> > > > >         se->on_rq =3D 1;
> > > > >
> > > > >         if (cfs_rq->nr_running =3D=3D 1) {
> > > > > @@ -4542,8 +4614,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se, int flags)
> > > > >
> > > > >         clear_buddies(cfs_rq, se);
> > > > >
> > > > > -       if (se !=3D cfs_rq->curr)
> > > > > +       if (se !=3D cfs_rq->curr) {
> > > > >                 __dequeue_entity(cfs_rq, se);
> > > > > +               __dequeue_latency(cfs_rq, se);
> > > > > +       }
> > > > >         se->on_rq =3D 0;
> > > > >         account_entity_dequeue(cfs_rq, se);
> > > > >
> > > > > @@ -4631,6 +4705,7 @@ set_next_entity(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se)
> > > > >                  */
> > > > >                 update_stats_wait_end_fair(cfs_rq, se);
> > > > >                 __dequeue_entity(cfs_rq, se);
> > > > > +               __dequeue_latency(cfs_rq, se);
> > > > >                 update_load_avg(cfs_rq, se, UPDATE_TG);
> > > > >         }
> > > > >
> > > > > @@ -4669,7 +4744,7 @@ static struct sched_entity *
> > > > >  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *cur=
r)
> > > > >  {
> > > > >         struct sched_entity *left =3D __pick_first_entity(cfs_rq)=
;
> > > > > -       struct sched_entity *se;
> > > > > +       struct sched_entity *latency, *se;
> > > > >
> > > > >         /*
> > > > >          * If curr is set we have to see if its left of the leftm=
ost entity
> > > > > @@ -4711,6 +4786,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, st=
ruct sched_entity *curr)
> > > > >                 se =3D cfs_rq->last;
> > > > >         }
> > > > >
> > > > > +       /* Check for latency sensitive entity waiting for running=
 */
> > > > > +       latency =3D __pick_first_latency(cfs_rq);
> > > > > +       if (latency && (latency !=3D se) &&
> > > > > +           wakeup_preempt_entity(latency, se) < 1)
> > > > > +               se =3D latency;
> > > > > +
> > > > >         return se;
> > > > >  }
> > > > >
> > > > > @@ -4734,6 +4815,7 @@ static void put_prev_entity(struct cfs_rq *=
cfs_rq, struct sched_entity *prev)
> > > > >                 update_stats_wait_start_fair(cfs_rq, prev);
> > > > >                 /* Put 'current' back into the tree. */
> > > > >                 __enqueue_entity(cfs_rq, prev);
> > > > > +               __enqueue_latency(cfs_rq, prev, 0);
> > > > >                 /* in !on_rq case, update occurred at dequeue */
> > > > >                 update_load_avg(cfs_rq, prev, 0);
> > > > >         }
> > > > > @@ -11717,6 +11799,7 @@ static void set_next_task_fair(struct rq =
*rq, struct task_struct *p, bool first)
> > > > >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> > > > >  {
> > > > >         cfs_rq->tasks_timeline =3D RB_ROOT_CACHED;
> > > > > +       cfs_rq->latency_timeline =3D RB_ROOT_CACHED;
> > > > >         u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> > > > >  #ifdef CONFIG_SMP
> > > > >         raw_spin_lock_init(&cfs_rq->removed.lock);
> > > > > @@ -12025,8 +12108,15 @@ int sched_group_set_latency(struct task_=
group *tg, s64 latency)
> > > > >
> > > > >         for_each_possible_cpu(i) {
> > > > >                 struct sched_entity *se =3D tg->se[i];
> > > > > +               struct rq *rq =3D cpu_rq(i);
> > > > > +               struct rq_flags rf;
> > > > > +
> > > > > +               rq_lock_irqsave(rq, &rf);
> > > > >
> > > > > +               __dequeue_latency(se->cfs_rq, se);
> > > > >                 WRITE_ONCE(se->latency_offset, latency);
> > > > > +
> > > > > +               rq_unlock_irqrestore(rq, &rf);
> > > > >         }
> > > > >
> > > > >         mutex_unlock(&shares_mutex);
> > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > index a15fb955092c..76bca172585c 100644
> > > > > --- a/kernel/sched/sched.h
> > > > > +++ b/kernel/sched/sched.h
> > > > > @@ -599,6 +599,7 @@ struct cfs_rq {
> > > > >  #endif
> > > > >
> > > > >         struct rb_root_cached   tasks_timeline;
> > > > > +       struct rb_root_cached   latency_timeline;
> > > > >
> > > > >         /*
> > > > >          * 'curr' points to currently running entity on this cfs_=
rq.
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > >
> > > > >
