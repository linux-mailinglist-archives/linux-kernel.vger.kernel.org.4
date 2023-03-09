Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCE6B21D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCIKsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCIKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:48:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21474B80D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:48:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z11so1192344pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678358899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fdf06Wc/hjHlJCDWhceIlR7LCjzW41wgVQLFvvDfsGQ=;
        b=AoKmt2o2IfK9u/cEDex8hQPRZcVHfAWaW5bT/gXz1s4Qob1Z/60hElFQyJv+eouy3y
         2cf8q6rySUMGcb5B5C7xW1c2y7pePtYHoudZqHp7+yTNAjrISEBBFwfuI9cZD3/qdbZZ
         M8qnZx+p0YbhYeWm/1Xit+vvfSp1ZwQBQiIoVjicIuSTE9zzqz6Fs87J53b2YrWgHJES
         ogxok0jPx758J5mb+89IiWLLxE7TDXa6iWUgP6XZH5Dxb87V2WNbXJbdrHQBYvR8/MPt
         Ts1CTl6mwxT6wE/mrHTCrd4+lrT7OuWodnS1IrKNiDUnGoDeVvxwvnpjfEbTLtcK3+Sp
         WMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdf06Wc/hjHlJCDWhceIlR7LCjzW41wgVQLFvvDfsGQ=;
        b=e/TiMAr4wMoOFS2Rv4bo5QS0tTQ83mFmvrFh0Xy/+dndLbtBhWuDb3l9pd0yB9MHFP
         nuRq5qsfi4mP4/7tPiCiBg+Jh21kUALUpEWlXLyDvtBy7VrneYyGL3PlrR066haZ9yBf
         soGBus8lM4S4atPbnnJfGRbSbH+f//SVmK0BcWriUkjGahSISQrTPXbTYMQK2ECaWjoW
         MharSAiQdwWEG8COpx8ergumLMZrA+8dBQ6f4HPitjB0mzF5eWlsISp38CxJ22cQC/r+
         td1iyJ5ZfOBcVOd+IcClm/egQBkK2DyySin9ZgOhpAefBcmiQAFrfSD0zzFUPHlVTZQA
         LVEQ==
X-Gm-Message-State: AO0yUKVGgpbwzGCbiy8MJCFXk6yGEVia/NE9s1/ZflBuMzGHAUeKWTyS
        VETlQJIfIxYLXHWDvrEnnbm2yvJT2EcL9WqGUoEHiQ==
X-Google-Smtp-Source: AK7set99q261VcruWpEMDwarBj0RoZRYjii5IwQsB1k7d24+dcgAQHZRhnr++j3PKW9/JgEzgB1/vhH8YbUVnwflHco=
X-Received: by 2002:a63:7f5d:0:b0:501:26b5:f0d2 with SMTP id
 p29-20020a637f5d000000b0050126b5f0d2mr7289900pgn.3.1678358899206; Thu, 09 Mar
 2023 02:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
 <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com> <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
 <ZAiFxWLSb9HDazSI@vingu-book> <07c692fd-fe59-1bd4-a6d0-e84bee6dbb3b@huawei.com>
In-Reply-To: <07c692fd-fe59-1bd4-a6d0-e84bee6dbb3b@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Mar 2023 11:48:07 +0100
Message-ID: <CAKfTPtDQOjY9mnVELijktZtN5wLR66yU7gByc2G+-kMg3FsGAg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 09:37, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/8 20:55, Vincent Guittot =E5=86=99=E9=81=93:
> > Le mercredi 08 mars 2023 =C3=A0 09:01:05 (+0100), Vincent Guittot a =C3=
=A9crit :
> >> On Tue, 7 Mar 2023 at 14:41, Zhang Qiao <zhangqiao22@huawei.com> wrote=
:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2023/3/7 18:26, Vincent Guittot =E5=86=99=E9=81=93:
> >>>> On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro=
.org> wrote:
> >>>>>
> >>>>> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wr=
ote:
> >>>>>>
> >>>>>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> >>>>>> entity being placed") fix an overflowing bug, but ignore
> >>>>>> a case that se->exec_start is reset after a migration.
> >>>>>>
> >>>>>> For fixing this case, we reset the vruntime of a long
> >>>>>> sleeping task in migrate_task_rq_fair().
> >>>>>>
> >>>>>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity bein=
g placed")
> >>>>>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>>>>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> >>>>>
> >>>>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> v1 -> v2:
> >>>>>> - fix some typos and update comments
> >>>>>> - reformat the patch
> >>>>>>
> >>>>>> ---
> >>>>>>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++--------=
-----
> >>>>>>  1 file changed, 55 insertions(+), 21 deletions(-)
> >>>>>>
> >>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>> index 7a1b1f855b96..74c9918ffe76 100644
> >>>>>> --- a/kernel/sched/fair.c
> >>>>>> +++ b/kernel/sched/fair.c
> >>>>>> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cf=
s_rq, struct sched_entity *se)
> >>>>>>  #endif
> >>>>>>  }
> >>>>>>
> >>>>>> +static inline bool entity_is_long_sleep(struct sched_entity *se)
> >>>>>> +{
> >>>>>> +       struct cfs_rq *cfs_rq;
> >>>>>> +       u64 sleep_time;
> >>>>>> +
> >>>>>> +       if (se->exec_start =3D=3D 0)
> >>>>>> +               return false;
> >>>>>> +
> >>>>>> +       cfs_rq =3D cfs_rq_of(se);
> >>>>>> +       sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_sta=
rt;
> >>>>>> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>>>> +               return true;
> >>>>>> +
> >>>>>> +       return false;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> >>>>>> +{
> >>>>>> +       unsigned long thresh;
> >>>>>> +
> >>>>>> +       if (se_is_idle(se))
> >>>>>> +               thresh =3D sysctl_sched_min_granularity;
> >>>>>> +       else
> >>>>>> +               thresh =3D sysctl_sched_latency;
> >>>>>> +
> >>>>>> +       /*
> >>>>>> +        * Halve their sleep time's effect, to allow
> >>>>>> +        * for a gentler effect of sleepers:
> >>>>>> +        */
> >>>>>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>>>>> +               thresh >>=3D 1;
> >>>>>> +
> >>>>>> +       return thresh;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static void
> >>>>>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int =
initial)
> >>>>>>  {
> >>>>>>         u64 vruntime =3D cfs_rq->min_vruntime;
> >>>>>> -       u64 sleep_time;
> >>>>>>
> >>>>>>         /*
> >>>>>>          * The 'current' period is already promised to the current=
 tasks,
> >>>>>> @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct =
sched_entity *se, int initial)
> >>>>>>                 vruntime +=3D sched_vslice(cfs_rq, se);
> >>>>>>
> >>>>>>         /* sleeps up to a single latency don't count. */
> >>>>>> -       if (!initial) {
> >>>>>> -               unsigned long thresh;
> >>>>>> -
> >>>>>> -               if (se_is_idle(se))
> >>>>>> -                       thresh =3D sysctl_sched_min_granularity;
> >>>>>> -               else
> >>>>>> -                       thresh =3D sysctl_sched_latency;
> >>>>>> -
> >>>>>> -               /*
> >>>>>> -                * Halve their sleep time's effect, to allow
> >>>>>> -                * for a gentler effect of sleepers:
> >>>>>> -                */
> >>>>>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>>>>> -                       thresh >>=3D 1;
> >>>>>> -
> >>>>>> -               vruntime -=3D thresh;
> >>>>>> -       }
> >>>>>> +       if (!initial)
> >>>>>> +               vruntime -=3D sched_sleeper_credit(se);
> >>>>>>
> >>>>>>         /*
> >>>>>>          * Pull vruntime of the entity being placed to the base le=
vel of
> >>>>>> @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct s=
ched_entity *se, int initial)
> >>>>>>          * the base as it may be too far off and the comparison ma=
y get
> >>>>>>          * inversed due to s64 overflow.
> >>>>>>          */
> >>>>>> -       sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_sta=
rt;
> >>>>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>>>> +       if (entity_is_long_sleep(se))
> >>>>>>                 se->vruntime =3D vruntime;
> >>>>>>         else
> >>>>>>                 se->vruntime =3D max_vruntime(se->vruntime, vrunti=
me);
> >>>>>> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct tas=
k_struct *p, int new_cpu)
> >>>>>>         if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
> >>>>>>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >>>>>>
> >>>>>> -               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntim=
e);
> >>>>>> +               /*
> >>>>>> +                * We determine whether a task sleeps for long by =
checking
> >>>>>> +                * se->exec_start, and if it is, we sanitize its v=
runtime at
> >>>>>> +                * place_entity(). However, after a migration, thi=
s detection
> >>>>>> +                * method fails due to se->exec_start being reset.
> >>>>>> +                *
> >>>>>> +                * For fixing this case, we add the same check her=
e. For a task
> >>>>>> +                * which has slept for a long time, its vruntime s=
hould be reset
> >>>>>> +                * to cfs_rq->min_vruntime with a sleep credit. Be=
cause waking
> >>>>>> +                * task's vruntime will be added to cfs_rq->min_vr=
untime when
> >>>>>> +                * enqueue, we only need to reset the se->vruntime=
 of waking task
> >>>>>> +                * to a credit here.
> >>>>>> +                */
> >>>>>> +               if (entity_is_long_sleep(se))
> >>>>
> >>>> I completely overlooked that we can't use rq_clock_task here. Need t=
o
> >>>> think a bit more on this
> >>>
> >>> Hi,Vincent,
> >>>
> >>> How about using exec_start of the parent sched_entity instant of rq_c=
lock_task()?
> >>
> >> How do we handle sched_entity without a parent sched_entity ?
> >
> > The change below should do the stuff. Not that we can't use it in place=
 entity because
> > pelt is not enabled in UP.
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 74c9918ffe76..b8b381b0ff20 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7635,6 +7635,32 @@ select_task_rq_fair(struct task_struct *p, int p=
rev_cpu, int wake_flags)
> >         return new_cpu;
> >  }
> >
> > +static inline bool migrate_long_sleeper(struct sched_entity *se)
> > +{
> > +       struct cfs_rq *cfs_rq;
> > +       u64 sleep_time;
> > +
> > +       if (se->exec_start =3D=3D 0)
>
> How about use `se->avg.last_update_time =3D=3D 0` here?
>
> > +               return false;
> > +
> > +       cfs_rq =3D cfs_rq_of(se);
> > +       /*
> > +        * If the entity slept for a long time, don't even try to norma=
lize its
> > +        * vruntime with the base as it may be too far off and might ge=
nerate
> > +        * wrong decision because of s64 overflow.
> > +        * We estimate its sleep duration with the last update of se's =
pelt.
> > +        * The last update happened before sleeping. The cfs' pelt is n=
ot
> > +        * always updated when cfs is idle but this is not a problem be=
cause
> > +        * its min_vruntime is not updated too, so the situation can't =
get
> > +        * worse.
> > +        */
> > +       sleep_time =3D cfs_rq_last_update_time(cfs_rq) - se->avg.last_u=
pdate_time;
> > +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>
> I tested with this patch and found it make hackbench slower.

Compared to which version ?
- v6.2 + revert commit 829c1651e9c4 ?
- v6.2 ?

v6.2 has a bug because newly migrated task gets a runtime credit
whatever its previous vruntime and hackbench generates a lot of
migration



>
>
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  /*
> >   * Called immediately before a task is migrated to a new CPU; task_cpu=
(p) and
> >   * cfs_rq_of(p) references at time of call are still valid and identif=
y the
> > @@ -7666,7 +7692,7 @@ static void migrate_task_rq_fair(struct task_stru=
ct *p, int new_cpu)
> >                  * enqueue, we only need to reset the se->vruntime of w=
aking task
> >                  * to a credit here.
> >                  */
> > -               if (entity_is_long_sleep(se))
> > +               if (migrate_long_sleeper(se))
> >                         se->vruntime =3D -sched_sleeper_credit(se);
> >                 else
> >                         se->vruntime -=3D u64_u32_load(cfs_rq->min_vrun=
time);
> >
> >
> >
> >>
> >>
> >>
> >>>>
> >>>>>> +                       se->vruntime =3D -sched_sleeper_credit(se)=
;
> >>>>>> +               else
> >>>>>> +                       se->vruntime -=3D u64_u32_load(cfs_rq->min=
_vruntime);
> >>>>>>         }
> >>>>>>
> >>>>>>         if (!task_on_rq_migrating(p)) {
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>> .
> >>>>
> > .
> >
