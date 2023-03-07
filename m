Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D616ADBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCGK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCGK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:26:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434E559E8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:26:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id ce7so7669528pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678184790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKGaqZk0m/nxKAlboqNZExksc63AGmg4hsIzLBdlFq8=;
        b=uiunapN+ax1QPtfYD89A0CCgzwOCvX9s+6pLcNBPjVtriL2PqLoH/0BlpSjEUni4VW
         1tIvK258bupkt11QrIrraUKcge25fDRHVtX3D75PGWxg9JRdHIp0NM2a62NT4peICToV
         v7HiWtgalsze+qzfXXN7hhnORgVQDx9EKiyq2Ja1+nIKa8n7DweJcjVPB0C/kLvQjc3X
         pJPaIfCaOUyzd1tPsY8+2WSNaaLvC5JG3pN2NFeuX6V7Gq+XFCsdyH1CcohWskMKgu7P
         SHzx3+TK046ig8IrF7lGB35vmJjjckE0cYrqJXvbv/43qVwwueaB93SvVJuk3Jx0IDVZ
         69/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKGaqZk0m/nxKAlboqNZExksc63AGmg4hsIzLBdlFq8=;
        b=FK285DtNJV+0e43ckh2oGM24eyXxTuKA9zgTrAeXDzJi9qucvM1zy3zgxujAs0AK3o
         yS0l10uX1rClTx6szfjtVnJ/5B9sf8IMuuqyeBh+g7Zk1ywnq6sTtw6JpWnURphqUkT6
         VDPJjNTMGxkamWhqhoBOBhHm86XLE01GqOfllfncikgamafTK78qGXOpbZcw12CvLKTF
         0VoRKNyK534BEF2+XdK/TeNJFqU+BZF9BTmakeqP2dRJRCt7xwq5YBXp3Ci0UEABRA99
         c3hrjz8Ln/BNj+HzMDeezoFWBz5bK4/t/OALz7DWYj2ALpZcIqjLd0k3CW1HqZ/1DPrG
         4Neg==
X-Gm-Message-State: AO0yUKVg0X5FhyhLwjq+eHP0XjjLUzTs11GSAm0UAfSCE8VQgjOLq9mn
        ozBRBKZ2/TZsk+hrM1BVuZcOUCFwVe0yYXYMT2nCMQ==
X-Google-Smtp-Source: AK7set/Y2uOU4qxK5se+bo5cH2gYXyImGoU2LHLnzpzuOGFqvUOP9pS0L8chmuMgyAJpYdmDJFJK3XXO3VKE1gYGneY=
X-Received: by 2002:a62:d443:0:b0:5df:9809:6220 with SMTP id
 u3-20020a62d443000000b005df98096220mr5767795pfl.3.1678184789668; Tue, 07 Mar
 2023 02:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com> <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Mar 2023 11:26:18 +0100
Message-ID: <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> >
> > Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> > entity being placed") fix an overflowing bug, but ignore
> > a case that se->exec_start is reset after a migration.
> >
> > For fixing this case, we reset the vruntime of a long
> > sleeping task in migrate_task_rq_fair().
> >
> > Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> > ---
> >
> > v1 -> v2:
> > - fix some typos and update comments
> > - reformat the patch
> >
> > ---
> >  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 55 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7a1b1f855b96..74c9918ffe76 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  #endif
> >  }
> >
> > +static inline bool entity_is_long_sleep(struct sched_entity *se)
> > +{
> > +       struct cfs_rq *cfs_rq;
> > +       u64 sleep_time;
> > +
> > +       if (se->exec_start == 0)
> > +               return false;
> > +
> > +       cfs_rq = cfs_rq_of(se);
> > +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> > +{
> > +       unsigned long thresh;
> > +
> > +       if (se_is_idle(se))
> > +               thresh = sysctl_sched_min_granularity;
> > +       else
> > +               thresh = sysctl_sched_latency;
> > +
> > +       /*
> > +        * Halve their sleep time's effect, to allow
> > +        * for a gentler effect of sleepers:
> > +        */
> > +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > +               thresh >>= 1;
> > +
> > +       return thresh;
> > +}
> > +
> >  static void
> >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >  {
> >         u64 vruntime = cfs_rq->min_vruntime;
> > -       u64 sleep_time;
> >
> >         /*
> >          * The 'current' period is already promised to the current tasks,
> > @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >                 vruntime += sched_vslice(cfs_rq, se);
> >
> >         /* sleeps up to a single latency don't count. */
> > -       if (!initial) {
> > -               unsigned long thresh;
> > -
> > -               if (se_is_idle(se))
> > -                       thresh = sysctl_sched_min_granularity;
> > -               else
> > -                       thresh = sysctl_sched_latency;
> > -
> > -               /*
> > -                * Halve their sleep time's effect, to allow
> > -                * for a gentler effect of sleepers:
> > -                */
> > -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > -                       thresh >>= 1;
> > -
> > -               vruntime -= thresh;
> > -       }
> > +       if (!initial)
> > +               vruntime -= sched_sleeper_credit(se);
> >
> >         /*
> >          * Pull vruntime of the entity being placed to the base level of
> > @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >          * the base as it may be too far off and the comparison may get
> >          * inversed due to s64 overflow.
> >          */
> > -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > +       if (entity_is_long_sleep(se))
> >                 se->vruntime = vruntime;
> >         else
> >                 se->vruntime = max_vruntime(se->vruntime, vruntime);
> > @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >         if (READ_ONCE(p->__state) == TASK_WAKING) {
> >                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >
> > -               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > +               /*
> > +                * We determine whether a task sleeps for long by checking
> > +                * se->exec_start, and if it is, we sanitize its vruntime at
> > +                * place_entity(). However, after a migration, this detection
> > +                * method fails due to se->exec_start being reset.
> > +                *
> > +                * For fixing this case, we add the same check here. For a task
> > +                * which has slept for a long time, its vruntime should be reset
> > +                * to cfs_rq->min_vruntime with a sleep credit. Because waking
> > +                * task's vruntime will be added to cfs_rq->min_vruntime when
> > +                * enqueue, we only need to reset the se->vruntime of waking task
> > +                * to a credit here.
> > +                */
> > +               if (entity_is_long_sleep(se))

I completely overlooked that we can't use rq_clock_task here. Need to
think a bit more on this

> > +                       se->vruntime = -sched_sleeper_credit(se);
> > +               else
> > +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> >         }
> >
> >         if (!task_on_rq_migrating(p)) {
> > --
> > 2.17.1
> >
