Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C163C406
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiK2Pp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiK2Ppz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:45:55 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53F6315A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:45:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a27so9141057qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xX4PwqLKyPSiIUwZD3EZzx8YWE2t9nQRiyWXe2KoPXQ=;
        b=jLovJsUI6L+kC5UaywmBh1H0mksIWoxloPClL3CTyYT3iwI2c5Rl+m8dB/OwVseHZV
         oHKJ0xfHeTQPlYptCcp78WTCRNsH/vq/AWUK9WU/35k0V09XRvR7/6gotnijPhE1ZOxv
         obNFw3x/sQl5ZMbIJiHgAnZf0UarU7nVfdU2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX4PwqLKyPSiIUwZD3EZzx8YWE2t9nQRiyWXe2KoPXQ=;
        b=aELQxgM339kOf+5qqmhXfmfeEOAR5hNFnZBcuHer73+zGIYlH235TMTCDdz/A9Xn0R
         0Ye2f+eGcYkuwClBGpCD+2vFiEPfBRuZ6CNClFE+qIL09c5AjAwqUrMgsQJ/jcDVQKnP
         3PAZKbifv2BHfTm+p+/zxIwFpf8e+A3765DLzCgWhwhIqWb5n2YC43cwYMklqbU/jW0l
         CsqJ3g+XPP5/mHa1c7tAajQmrCS8H+Cae+W6NWhW1sNKta2z2hOI/nzwe6O4n4Spb4ho
         2DUmUB1BJG9P97zMBX0zyytbhoKUybEv0qVYdiTXAtJqTc26q3Qiv/AMJHjnO0aTtXci
         6bxg==
X-Gm-Message-State: ANoB5pnKYCsZpIwtPYkVFRXOxaR3r5uVfCefHws7Le6AdWeDyJaxSa5o
        Zu71uecgRBR7+ChjalZNCpS65Q==
X-Google-Smtp-Source: AA0mqf58+RQm/IzeH+keYWusfcDhf/ot0eKU8SgaUdlZeMSiiG2so5TcSp8meuy0WbzRTMJXBcHdOQ==
X-Received: by 2002:ac8:6a0a:0:b0:3a5:24d3:151a with SMTP id t10-20020ac86a0a000000b003a524d3151amr52900465qtr.150.1669736752277;
        Tue, 29 Nov 2022 07:45:52 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b10f:9e5b:184c:2f74:27ec:e005])
        by smtp.gmail.com with ESMTPSA id bv14-20020a05622a0a0e00b0039c37a7914csm8890080qtb.23.2022.11.29.07.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:45:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/9] sched/fair: Take into account latency priority at wakeup
Date:   Tue, 29 Nov 2022 10:45:50 -0500
Message-Id: <E5C05A33-06E4-4627-8108-145752D72A24@joelfernandes.org>
References: <CAKfTPtCZ5CttibZ9o18woLiQgzFeKCBMDAGrhMd3kbgX2qs29Q@mail.gmail.com>
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
In-Reply-To: <CAKfTPtCZ5CttibZ9o18woLiQgzFeKCBMDAGrhMd3kbgX2qs29Q@mail.gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
Thank you so much for your quick reply.

> On Nov 29, 2022, at 3:58 AM, Vincent Guittot <vincent.guittot@linaro.org> w=
rote:
>=20
> =EF=BB=BFOn Tue, 29 Nov 2022 at 05:25, Joel Fernandes <joel@joelfernandes.=
org> wrote:
>>=20
>>> On Tue, Nov 15, 2022 at 12:19 PM Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>=20
>>> Take into account the latency priority of a thread when deciding to
>>> preempt the current running thread. We don't want to provide more CPU
>>> bandwidth to a thread but reorder the scheduling to run latency sensitiv=
e
>>> task first whenever possible.
>>>=20
>>> As long as a thread didn't use its bandwidth, it will be able to preempt=

>>> the current thread.
>>>=20
>>> At the opposite, a thread with a low latency priority will preempt curre=
nt
>>> thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it w=
ill
>>> wait for the tick to get its sched slice.
>>>=20
>>>                                   curr vruntime
>>>                                       |
>>>                      sysctl_sched_wakeup_granularity
>>>                                   <-->
>>> ----------------------------------|----|-----------------------|--------=
-------
>>>                                  |    |<--------------------->
>>>                                  |    .  sysctl_sched_latency
>>>                                  |    .
>>> default/current latency entity    |    .
>>>                                  |    .
>>> 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1=
-1-1-1-
>>> se preempts curr at wakeup ------>|<- se doesn't preempt curr ----------=
-------
>>>                                  |    .
>>>                                  |    .
>>>                                  |    .
>>> low latency entity                |    .
>>>                                   ---------------------->|
>>>                               % of sysctl_sched_latency  |
>>> 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1=
-1-1-1-
>>> preempt ------------------------------------------------->|<- do not pre=
empt --
>>>                                  |    .
>>>                                  |    .
>>>                                  |    .
>>> high latency entity               |    .
>>>         |<-----------------------|----.
>>>         | % of sysctl_sched_latency   .
>>> 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-=
1-1-1-1
>>> preempt->|<- se doesn't preempt curr -----------------------------------=
-------
>>> Tests results of nice latency impact on heavy load like hackbench:
>>>=20
>>> hackbench -l (2560 / group) -g group
>>> group        latency 0             latency 19
>>> 1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
>>> 4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
>>> 8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
>>> 16           1.347(+/-  1%)      1.317(+/- 1%) + 2%
>>>=20
>>> hackbench -p -l (2560 / group) -g group
>>> group
>>> 1            1.836(+/- 17%)      1.148(+/- 5%) +37%
>>> 4            1.586(+/-  6%)      1.109(+/- 8%) +30%
>>> 8            1.209(+/-  4%)      0.780(+/- 4%) +35%
>>> 16           0.805(+/-  5%)      0.728(+/- 4%) +10%
>>>=20
>>> By deacreasing the latency prio, we reduce the number of preemption at
>>> wakeup and help hackbench making progress.
>>>=20
>>> Test results of nice latency impact on short live load like cyclictest
>>> while competing with heavy load like hackbench:
>>>=20
>>> hackbench -l 10000 -g $group &
>>> cyclictest --policy other -D 5 -q -n
>>>        latency 0           latency -20
>>> group   min  avg    max     min  avg    max
>>> 0       16    19     29      17   18     29
>>> 1       43   299   7359      63   84   3422
>>> 4       56   449  14806      45   83    284
>>> 8       63   820  51123      63   83    283
>>> 16      64  1326  70684      41  157  26852
>>>=20
>>> group =3D 0 means that hackbench is not running.
>>>=20
>>> The avg is significantly improved with nice latency -20 especially with
>>> large number of groups but min and max remain quite similar. If we add t=
he
>>> histogram parameter to get details of latency, we have :
>>>=20
>>> hackbench -l 10000 -g 16 &
>>> cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
>>>              latency 0    latency -20
>>> Min Latencies:    64           62
>>> Avg Latencies:  1170          107
>>> Max Latencies: 88069        10417
>>> 50% latencies:   122           86
>>> 75% latencies:   614           91
>>> 85% latencies:   961           94
>>> 90% latencies:  1225           97
>>> 95% latencies:  6120          102
>>> 99% latencies: 18328          159
>>>=20
>>> With percentile details, we see the benefit of nice latency -20 as
>>> only 1% of the latencies are above 159us whereas the default latency
>>> has got 15% around ~1ms or above and 5% over the 6ms.
>>>=20
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>> include/linux/sched.h      |  4 ++-
>>> include/linux/sched/prio.h |  9 ++++++
>>> init/init_task.c           |  2 +-
>>> kernel/sched/core.c        | 38 +++++++++++++++++++---
>>> kernel/sched/debug.c       |  2 +-
>>> kernel/sched/fair.c        | 66 ++++++++++++++++++++++++++++++++++----
>>> kernel/sched/sched.h       |  6 ++++
>>> 7 files changed, 112 insertions(+), 15 deletions(-)
>>>=20
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index 856240573300..2f33326adb8d 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -568,6 +568,8 @@ struct sched_entity {
>>>        /* cached value of my_q->h_nr_running */
>>>        unsigned long                   runnable_weight;
>>> #endif
>>> +       /* preemption offset in ns */
>>> +       long                            latency_offset;
>>>=20
>>> #ifdef CONFIG_SMP
>>>        /*
>>> @@ -784,7 +786,7 @@ struct task_struct {
>>>        int                             static_prio;
>>>        int                             normal_prio;
>>>        unsigned int                    rt_priority;
>>> -       int                             latency_nice;
>>> +       int                             latency_prio;
>>>=20
>>>        struct sched_entity             se;
>>>        struct sched_rt_entity          rt;
>>> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
>>> index bfcd7f1d1e11..be79503d86af 100644
>>> --- a/include/linux/sched/prio.h
>>> +++ b/include/linux/sched/prio.h
>>> @@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long prio)
>>>  * Default tasks should be treated as a task with latency_nice =3D 0.
>>>  */
>>> #define DEFAULT_LATENCY_NICE   0
>>> +#define DEFAULT_LATENCY_PRIO   (DEFAULT_LATENCY_NICE + LATENCY_NICE_WID=
TH/2)
>>> +
>>> +/*
>>> + * Convert user-nice values [ -20 ... 0 ... 19 ]
>>> + * to static latency [ 0..39 ],
>>> + * and back.
>>> + */
>>> +#define NICE_TO_LATENCY(nice)  ((nice) + DEFAULT_LATENCY_PRIO)
>>> +#define LATENCY_TO_NICE(prio)  ((prio) - DEFAULT_LATENCY_PRIO)
>>>=20
>>> #endif /* _LINUX_SCHED_PRIO_H */
>>> diff --git a/init/init_task.c b/init/init_task.c
>>> index 7dd71dd2d261..071deff8dbd1 100644
>>> --- a/init/init_task.c
>>> +++ b/init/init_task.c
>>> @@ -78,7 +78,7 @@ struct task_struct init_task
>>>        .prio           =3D MAX_PRIO - 20,
>>>        .static_prio    =3D MAX_PRIO - 20,
>>>        .normal_prio    =3D MAX_PRIO - 20,
>>> -       .latency_nice   =3D DEFAULT_LATENCY_NICE,
>>> +       .latency_prio   =3D DEFAULT_LATENCY_PRIO,
>>>        .policy         =3D SCHED_NORMAL,
>>>        .cpus_ptr       =3D &init_task.cpus_mask,
>>>        .user_cpus_ptr  =3D NULL,
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 18c31a68eb18..b2b8cb6c08cd 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1283,6 +1283,16 @@ static void set_load_weight(struct task_struct *p=
, bool update_load)
>>>        }
>>> }
>>>=20
>>> +static void set_latency_offset(struct task_struct *p)
>>> +{
>>> +       long weight =3D sched_latency_to_weight[p->latency_prio];
>>> +       s64 offset;
>>> +
>>> +       offset =3D weight * get_sleep_latency(false);
>>> +       offset =3D div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
>>> +       p->se.latency_offset =3D (long)offset;
>>> +}
>>> +
>>> #ifdef CONFIG_UCLAMP_TASK
>>> /*
>>>  * Serializes updates of utilization clamp values
>>> @@ -4592,7 +4602,9 @@ int sched_fork(unsigned long clone_flags, struct t=
ask_struct *p)
>>>                p->prio =3D p->normal_prio =3D p->static_prio;
>>>                set_load_weight(p, false);
>>>=20
>>> -               p->latency_nice =3D DEFAULT_LATENCY_NICE;
>>> +               p->latency_prio =3D NICE_TO_LATENCY(0);
>>> +               set_latency_offset(p);
>>> +
>>>                /*
>>>                 * We don't need the reset flag anymore after the fork. I=
t has
>>>                 * fulfilled its duty:
>>> @@ -7358,8 +7370,10 @@ static void __setscheduler_params(struct task_str=
uct *p,
>>> static void __setscheduler_latency(struct task_struct *p,
>>>                const struct sched_attr *attr)
>>> {
>>> -       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
>>> -               p->latency_nice =3D attr->sched_latency_nice;
>>> +       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
>>> +               p->latency_prio =3D NICE_TO_LATENCY(attr->sched_latency_=
nice);
>>> +               set_latency_offset(p);
>>> +       }
>>> }
>>>=20
>>> /*
>>> @@ -7544,7 +7558,7 @@ static int __sched_setscheduler(struct task_struct=
 *p,
>>>                if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>>>                        goto change;
>>>                if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
>>> -                   attr->sched_latency_nice !=3D p->latency_nice)
>>> +                   attr->sched_latency_nice !=3D LATENCY_TO_NICE(p->lat=
ency_prio))
>>>                        goto change;
>>>=20
>>>                p->sched_reset_on_fork =3D reset_on_fork;
>>> @@ -8085,7 +8099,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct s=
ched_attr __user *, uattr,
>>>        get_params(p, &kattr);
>>>        kattr.sched_flags &=3D SCHED_FLAG_ALL;
>>>=20
>>> -       kattr.sched_latency_nice =3D p->latency_nice;
>>> +       kattr.sched_latency_nice =3D LATENCY_TO_NICE(p->latency_prio);
>>>=20
>>> #ifdef CONFIG_UCLAMP_TASK
>>>        /*
>>> @@ -11294,6 +11308,20 @@ const u32 sched_prio_to_wmult[40] =3D {
>>>  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
>>> };
>>>=20
>>> +/*
>>> + * latency weight for wakeup preemption
>>> + */
>>> +const int sched_latency_to_weight[40] =3D {
>>> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
>>> + /* -15 */      -768,     -717,     -666,      -614,      -563,
>>> + /* -10 */      -512,     -461,     -410,      -358,      -307,
>>> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
>>> + /*   0 */         0,       51,      102,       154,       205,
>>> + /*   5 */       256,      307,      358,       410,       461,
>>> + /*  10 */       512,      563,      614,       666,       717,
>>> + /*  15 */       768,      819,      870,       922,       973,
>>> +};
>>> +
>>=20
>> The table is linear. You could approximate this as: weight =3D nice * 51
>> since it is a linear scale and do the conversion in place.
>>=20
>> Or, since the only place you are using the latency_to_weight is in
>> set_latency_offset(), can we drop the sched_latency_to_weight array
>> and simplify as follows?
>=20
> It's also used in cgroup patch and keeps a coherency between
> nice/weight an latency_nice/offset so I prefer

I dont think it=E2=80=99s a valid comparison as nice/weight conversion are n=
on linear and over there a table makes sense: weight =3D 1024 / 1.25 ^ nice

> keeping current
> implementation

I could be missing something, but, since its a linear scale, why does cgroup=
 need weight at all? Just store nice directly. Why would that not work?

In the end the TG and SE has the latency offset in the struct, that is all y=
ou care about. All the conversion back and forth is unnecessary, as it is a l=
inear scale and just increases LOC and takes more memory to store linear arr=
ays.

Again I could be missing something and I will try to play with your series a=
nd see if I can show you what I mean (or convince myself it=E2=80=99s needed=
).

>> static void set_latency_offset(struct task_struct *p)
>> {
>>  s64 offset =3D p->latency_prio * get_sleep_latency(false);
>>  p->latency_prio =3D (long)div_s64(offset, 40);
>> }
>>=20
>>> void call_trace_sched_update_nr_running(struct rq *rq, int count)
>>> {
>>>         trace_sched_update_nr_running_tp(rq, count);
>>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>>> index 68be7a3e42a3..b3922184af91 100644
>>> --- a/kernel/sched/debug.c
>>> +++ b/kernel/sched/debug.c
>>> @@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, s=
truct pid_namespace *ns,
>>> #endif
>>>        P(policy);
>>>        P(prio);
>>> -       P(latency_nice);
>>> +       P(latency_prio);
>>>        if (task_has_dl_policy(p)) {
>>>                P(dl.runtime);
>>>                P(dl.deadline);
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index c8a697f8db88..0e80e65113bd 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4858,6 +4858,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched=
_entity *se, int flags)
>>>                update_idle_cfs_rq_clock_pelt(cfs_rq);
>>> }
>>>=20
>>> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched=
_entity *se);
>>> +
>>> /*
>>>  * Preempt the current task with a newly woken task if needed:
>>>  */
>>> @@ -4866,7 +4868,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct s=
ched_entity *curr)
>>> {
>>>        unsigned long ideal_runtime, delta_exec;
>>>        struct sched_entity *se;
>>> -       s64 delta;
>>> +       s64 delta, offset;
>>>=20
>>>        ideal_runtime =3D sched_slice(cfs_rq, curr);
>>>        delta_exec =3D curr->sum_exec_runtime - curr->prev_sum_exec_runti=
me;
>>> @@ -4891,10 +4893,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct=
 sched_entity *curr)
>>>        se =3D __pick_first_entity(cfs_rq);
>>>        delta =3D curr->vruntime - se->vruntime;
>>>=20
>>> -       if (delta < 0)
>>> +       offset =3D wakeup_latency_gran(curr, se);
>>> +       if (delta < offset)
>>>                return;
>>=20
>> Agreed.
>>=20
>>> -       if (delta > ideal_runtime)
>>> +       if ((delta > ideal_runtime) ||
>>> +           (delta > get_latency_max()))
>>>                resched_curr(rq_of(cfs_rq));
>>> }
>>>=20
>>> @@ -6019,6 +6023,35 @@ static int sched_idle_cpu(int cpu)
>>> }
>>> #endif
>>>=20
>>> +static void set_next_buddy(struct sched_entity *se);
>>> +
>>> +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_=
entity *se)
>>> +{
>>> +       struct sched_entity *next;
>>> +
>>> +       if (se->latency_offset >=3D 0)
>>> +               return;
>>> +
>>> +       if (cfs->nr_running <=3D 1)
>>> +               return;
>>> +       /*
>>> +        * When waking from another class, we don't need to check to pre=
empt at
>>> +        * wakeup and don't set next buddy as a candidate for being pick=
ed in
>>> +        * priority.
>>> +        * In case of simultaneous wakeup when current is another class,=
 the
>>> +        * latency sensitive tasks lost opportunity to preempt non sensi=
tive
>>> +        * tasks which woke up simultaneously.
>>> +        */
>>> +
>>> +       if (cfs->next)
>>> +               next =3D cfs->next;
>>> +       else
>>> +               next =3D __pick_first_entity(cfs);
>>> +
>>> +       if (next && wakeup_preempt_entity(next, se) =3D=3D 1)
>>> +               set_next_buddy(se);
>>> +}
>>> +
>>> /*
>>>  * The enqueue_task method is called before nr_running is
>>>  * increased. Here we update the fair scheduling stats and
>>> @@ -6105,14 +6138,15 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
>>>        if (!task_new)
>>>                update_overutilized_status(rq);
>>>=20
>>> +       if (rq->curr->sched_class !=3D &fair_sched_class)
>>> +               check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
>>> +
>>> enqueue_throttle:
>>>        assert_list_leaf_cfs_rq(rq);
>>>=20
>>>        hrtick_update(rq);
>>> }
>>>=20
>>> -static void set_next_buddy(struct sched_entity *se);
>>> -
>>> /*
>>>  * The dequeue_task method is called before nr_running is
>>>  * decreased. We remove the task from the rbtree and
>>> @@ -7461,6 +7495,23 @@ balance_fair(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
>>> }
>>> #endif /* CONFIG_SMP */
>>>=20
>>> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched=
_entity *se)
>>> +{
>>> +       long latency_offset =3D se->latency_offset;
>>> +
>>> +       /*
>>> +        * A negative latency offset means that the sched_entity has lat=
ency
>>> +        * requirement that needs to be evaluated versus other entity.
>>> +        * Otherwise, use the latency weight to evaluate how much schedu=
ling
>>> +        * delay is acceptable by se.
>>> +        */
>>> +       if ((latency_offset < 0) || (curr->latency_offset < 0))
>>> +               latency_offset -=3D curr->latency_offset;
>>> +       latency_offset =3D min_t(long, latency_offset, get_latency_max()=
);
>>=20
>> Over here can we make positive latency offsets also be evaluated
>> "versus other entity"?
>>=20
>> It feels strange to have different rules for positive latency_offset
>> when comparing curr and se. IMO we should also factor in latency
>> requirements by comparing 2 positive nice values. It should be
>> relative even for positive values, just like regular nice IMO and not
>> have hidden meaning. If there is hidden meaning, it confuses the user
>> and requires documentation that most users will not read. Especially
>> because latency_nice shares the word "nice" with regular nice values.
>=20
> This has already been discussed in the previous revisions.

Sorry to be late to the party.

> This is not
> a hidden behavior but the normal behavior.
>=20
> A negative latency nice, means that the task are not tolerant to
> scheduling delay and it want to preempt current and run now. Or, if
> the task is current, it doesn't want to be preempted and finish its
> slice. In this case, we compare current and wake up task in case there
> is 2 latency sensitive tasks that are fighting to run 1st.
>=20
> Whereas a positive latency nice means that the task is tolerant to
> scheduling delay and you don't care preempting current as long as it's
> in an acceptable vruntime range. Why would the latency nice of the
> current task make the wakeup task less tolerant to the scheduling
> delay ? As an example, If current is latency_nice 19 and the wakeup
> task is latency nice 19 too, both are tolerant to scheduling delay and
> the waking up task should preempt current only if there is an
> unfairness problem. By comparing their positive latency nice values,
> you are back to the normal behavior which defeats the purpose of the
> feature.

I see it as, if 2 tasks are latency tolerant, then they will have higher lat=
ency with respect to a third tasks that is latency in tolerant. But I am ok w=
ith your definition as well=E2=80=A6

Thanks!

 - Joel

>=20
> Thanks
> Vincent
>=20
>>=20
>> Thanks,
>>=20
>> - Joel
>> .
>>=20
>>> +
>>> +       return latency_offset;
>>> +}
>>> +
>>> static unsigned long wakeup_gran(struct sched_entity *se)
>>> {
>>>        unsigned long gran =3D sysctl_sched_wakeup_granularity;
>>> @@ -7499,11 +7550,12 @@ static int
>>> wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se=
)
>>> {
>>>        s64 gran, vdiff =3D curr->vruntime - se->vruntime;
>>> +       s64 offset =3D wakeup_latency_gran(curr, se);
>>>=20
>>> -       if (vdiff <=3D 0)
>>> +       if (vdiff < offset)
>>>                return -1;
>>>=20
>>> -       gran =3D wakeup_gran(se);
>>> +       gran =3D offset + wakeup_gran(se);
>>>=20
>>>        /*
>>>         * At wake up, the vruntime of a task is capped to not be older t=
han
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 842ce0094d9c..7292652731d0 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -125,6 +125,11 @@ extern int sched_rr_timeslice;
>>>  */
>>> #define NS_TO_JIFFIES(TIME)    ((unsigned long)(TIME) / (NSEC_PER_SEC / H=
Z))
>>>=20
>>> +/* Maximum nice latency weight used to scale the latency_offset */
>>> +
>>> +#define NICE_LATENCY_SHIFT     (SCHED_FIXEDPOINT_SHIFT)
>>> +#define NICE_LATENCY_WEIGHT_MAX        (1L << NICE_LATENCY_SHIFT)
>>> +
>>> /*
>>>  * Increase resolution of nice-level calculations for 64-bit architectur=
es.
>>>  * The extra resolution improves shares distribution and load balancing o=
f
>>> @@ -2115,6 +2120,7 @@ static_assert(WF_TTWU =3D=3D SD_BALANCE_WAKE);
>>>=20
>>> extern const int               sched_prio_to_weight[40];
>>> extern const u32               sched_prio_to_wmult[40];
>>> +extern const int               sched_latency_to_weight[40];
>>>=20
>>> /*
>>>  * {de,en}queue flags:
>>> --
>>> 2.17.1
>>>=20
