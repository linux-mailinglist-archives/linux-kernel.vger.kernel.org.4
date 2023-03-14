Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78996B9637
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjCNN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjCNN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:29:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66424984EA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:26:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1171272pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFSwB9eUcPPzGNR48YEQJOSNhQynwROdrT90OTmaN4I=;
        b=uzg8gUymhHbIeh9Cdcix2yxGaFICmheGtBcciKPjp2CVNDCfPwkQ7WuFf8gkZSvWs0
         OHN9+dK/puMSmTQjOm3UETBe7qnMeZzmVGOispay8/71GlsW7enujay1EPQGppMnLxNT
         Jfbs4iEBIzYWQXly0Cl+9h1d8dYw2m4VYcH8gHX0Nh/kcCBYnqpTt7E/gffsr8Km1P1r
         PKbemX5kenT6/mPKMcXsnw9v6GJnmCpQzehReFOIuOMtTKKj0waW0r8ay3jVVbNJi3pZ
         361BK1QgHmN7X2T+rE5QNth2wbjQfj5NJnwtkD7I7gVwDxeog0azAeJl6zFQVWyo9ib7
         nymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFSwB9eUcPPzGNR48YEQJOSNhQynwROdrT90OTmaN4I=;
        b=kC8A367y2pByzP0X1ohU6AuyNodQP0/8ow6Tsef0WFFRC33gn7CMgdkgCEaC04Yd/r
         VHciibGZqb/RpMQsdvUZlHVxkOq1CrbfyzwTGBWeW7/ozOIIOPyRow/pCg8wbPx0Od5O
         JA7Eg4ErVX1ZSwzpJW53sUPIfXvFceT9tCizugtCZj+t5BRlumrTg9YEa30fi2DX/itX
         BFr8Rkwe1X2uYbThazHxDDKozzrP7AQRRKGIBph2/Z5cdiOJSFdK6eAysY968sjifiXE
         VJAMKjdmamOF0Fs1/SSl1xW0lt40P+RHUoLLGkK6PNqLikccbBDg8TfoOzoruh4LdCbr
         DEtQ==
X-Gm-Message-State: AO0yUKVPLjpJvg1JueJs3HNUz+43BHi//9xvmMVrVpyFYd9O07Wfh2ig
        pLrRkYQGA6ypX03crx1KbH/wqeaUIdv3u3xu3wLdnQ==
X-Google-Smtp-Source: AK7set+VM9VS2Z03HeA0Dhkm+jTN0u0gU/RvzynqfbBVeOUNjepo1kjVbWuWTpU2mMfj0zz2aCbTdB0o1bks9vgnQ00=
X-Received: by 2002:a17:90a:4a15:b0:23c:fea4:770c with SMTP id
 e21-20020a17090a4a1500b0023cfea4770cmr2617066pjh.3.1678800396767; Tue, 14 Mar
 2023 06:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net> <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
 <CAKfTPtBaBdxfc9uoViNT8gsWU-GdgnHrDdWPpAduadTFmu1ZGg@mail.gmail.com> <55754a59-a01f-206a-43f6-d07ea37300dd@huawei.com>
In-Reply-To: <55754a59-a01f-206a-43f6-d07ea37300dd@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Mar 2023 14:26:25 +0100
Message-ID: <CAKfTPtCCQ0__kz8UfaSm7qrpOQc47rPheD+KLoyBAbmp_tLP0w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 12:03, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/13 22:23, Vincent Guittot =E5=86=99=E9=81=93:
> > On Sat, 11 Mar 2023 at 10:57, Zhang Qiao <zhangqiao22@huawei.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/3/10 22:29, Vincent Guittot =E5=86=99=E9=81=93:
> >>> Le jeudi 09 mars 2023 =C3=A0 16:14:38 (+0100), Vincent Guittot a =C3=
=A9crit :
> >>>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> w=
rote:
> >>>>>
> >>>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> >>>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> >>>>>>
> >>>>>>> Then, even if we don't clear exec_start before migrating and keep
> >>>>>>> current value to be used in place_entity on the new cpu, we can't
> >>>>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAIC=
T
> >>>>>>
> >>>>>> Blergh -- indeed, irq and steal time can skew them between CPUs :/
> >>>>>> I suppose we can fudge that... wait_start (which is basically what=
 we're
> >>>>>> making it do) also does that IIRC.
> >>>>>>
> >>>>>> I really dislike having this placement muck spreadout like propose=
d.
> >>>>>
> >>>>> Also, I think we might be over-engineering this, we don't care abou=
t
> >>>>> accuracy at all, all we really care about is 'long-time'.
> >>>>
> >>>> you mean taking the patch 1/2 that you mentioned here to add a
> >>>> migrated field:
> >>>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1=
.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8d=
b705429d003b
> >>>>
> >>>> And assume that the divergence between the rq_clock_task() can be ig=
nored ?
> >>>>
> >>>> That could probably work but we need to replace the (60LL *
> >>>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergen=
ce
> >>>> would not be unrealistic.
> >>>> and a comment to explain why it's acceptable
> >>>
> >>> Zhang,
> >>>
> >>> Could you try the patch below ?
> >>> This is a rebase/merge/update of:
> >>> -patch 1/2 above and
> >>> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.=
de/
> >>
> >>
> >> I applyed and tested this patch, and it make hackbench slower.
> >> According to my previous test results. The good result is 82.1(s).
> >> But the result of this patch is 108.725(s).
> >
> > By "the result of this patch is 108.725(s)",  you mean the result of
> > https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
> > alone, don't you ?
>
> No, with your patch, the test results is 108.725(s),

Ok

>
> git diff:
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 63d242164b1a..93a3909ae4c4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -550,6 +550,7 @@ struct sched_entity {
>         struct rb_node                  run_node;
>         struct list_head                group_node;
>         unsigned int                    on_rq;
> +       unsigned int                    migrated;
>
>         u64                             exec_start;
>         u64                             sum_exec_runtime;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..e60defc39f6e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se)
>         /*
>          * We are starting a new run period:
>          */
> +       se->migrated =3D 0;
>         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
>  }
>
> @@ -4690,9 +4691,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int initial)
>          * inversed due to s64 overflow.
>          */
>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +       if ((s64)sleep_time > (1ULL << 63) / scale_load_down(NICE_0_LOAD)=
 / 2) {
>                 se->vruntime =3D vruntime;
> -       else
> +       } else
>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime);
>  }
>
> @@ -7658,8 +7659,7 @@ static void migrate_task_rq_fair(struct task_struct=
 *p, int new_cpu)
>         se->avg.last_update_time =3D 0;
>
>         /* We have migrated, no longer consider this task hot */
> -       se->exec_start =3D 0;
> -
> +       se->migrated =3D 1;
>         update_scan_period(p, new_cpu);
>  }
>
> @@ -8343,6 +8343,8 @@ static int task_hot(struct task_struct *p, struct l=
b_env *env)
>
>         if (sysctl_sched_migration_cost =3D=3D 0)
>                 return 0;
> +       if (p->se.migrated)
> +               return 0;
>
>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
>
>
>
> >
> >>
> >>
> >>> version1: v6.2
> >>> version2: v6.2 + commit 829c1651e9c4
> >>> version3: v6.2 + commit 829c1651e9c4 + this patch
> >>>
> >>> -------------------------------------------------
> >>>       version1        version2        version3
> >>> test1 81.0            118.1           82.1
> >>> test2 82.1            116.9           80.3
> >>> test3 83.2            103.9           83.3
> >>> avg(s)        82.1            113.0           81.9
> >
> > Ok, it looks like we are back to normal figures

What do those results refer to then ?


> >
> >>>
> >>> -------------------------------------------------
> >>>
> >>> The proposal accepts a divergence of up to 52 days between the 2 rqs.
> >>>
> >>> If this work, we will prepare a proper patch
> >>>
> >>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>> index 63d242164b1a..cb8af0a137f7 100644
> >>> --- a/include/linux/sched.h
> >>> +++ b/include/linux/sched.h
> >>> @@ -550,6 +550,7 @@ struct sched_entity {
> >>>         struct rb_node                  run_node;
> >>>         struct list_head                group_node;
> >>>         unsigned int                    on_rq;
> >>> +       unsigned int                    migrated;
> >>>
> >>>         u64                             exec_start;
> >>>         u64                             sum_exec_runtime;
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 7a1b1f855b96..36acd9598b40 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
> >>>         /*
> >>>          * We are starting a new run period:
> >>>          */
> >>> +       se->migrated =3D 0;
> >>>         se->exec_start =3D rq_clock_task(rq_of(cfs_rq));
> >>>  }
> >>>
> >>> @@ -4684,13 +4685,23 @@ place_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int initial)
> >>>
> >>>         /*
> >>>          * Pull vruntime of the entity being placed to the base level=
 of
> >>> -        * cfs_rq, to prevent boosting it if placed backwards.  If th=
e entity
> >>> -        * slept for a long time, don't even try to compare its vrunt=
ime with
> >>> -        * the base as it may be too far off and the comparison may g=
et
> >>> -        * inversed due to s64 overflow.
> >>> +        * cfs_rq, to prevent boosting it if placed backwards.
> >>> +        * However, min_vruntime can advance much faster than real ti=
me, with
> >>> +        * the exterme being when an entity with the minimal weight a=
lways runs
> >>> +        * on the cfs_rq. If the new entity slept for long, its vrunt=
ime
> >>> +        * difference from min_vruntime may overflow s64 and their co=
mparison
> >>> +        * may get inversed, so ignore the entity's original vruntime=
 in that
> >>> +        * case.
> >>> +        * The maximal vruntime speedup is given by the ratio of norm=
al to
> >>> +        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off o=
n the
> >>
> >> why not is `scale_load_down(NICE_0_LOAD) / MIN_SHARES` here ?
> >
> > yes, you are right.
> >
> >>
> >>
> >>> +        * sleep time of 2^63 / NICE_0_LOAD should be safe.
> >>> +        * When placing a migrated waking entity, its exec_start has =
been set
> >>> +        * from a different rq. In order to take into account a possi=
ble
> >>> +        * divergence between new and prev rq's clocks task because o=
f irq and
> >>
> >> This divergence might be larger, it cause `sleep_time` maybe negative.
> >
> > AFAICT, we are safe with ((1ULL << 63) / scale_load_down(NICE_0_LOAD)
> > / 2) as long as the divergence between the 2 rqs clocks task is lower
> > than 2^52nsec. Do you expect a divergence higher than 2^52 nsec
> > (around 52 days)?
> >
> > We can probably keep using (1ULL << 63) / scale_load_down(NICE_0_LOAD)
> > which is already half the max value if needed.
> >
> > the fact that sleep_time can be negative is not a problem as
> > s64)sleep_time > will take care of this.
>
> In my opinion, when comparing signed with unsigned, the compiler converts=
 the signed value to unsigned.
> So, if sleep_time < 0, "(s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2"=
 will be true.
>
> >
> >>
> >>> +        * stolen time, we take an additional margin.
> >>>          */
> >>>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>> +       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2)>       =
          se->vruntime =3D vruntime;
> >>>         else
> >>>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime)=
;
> >>> @@ -7658,7 +7669,7 @@ static void migrate_task_rq_fair(struct task_st=
ruct *p, int new_cpu)
> >>>         se->avg.last_update_time =3D 0;
> >>>
> >>>         /* We have migrated, no longer consider this task hot */
> >>> -       se->exec_start =3D 0;
> >>> +       se->migrated =3D 1;
> >>>
> >>>         update_scan_period(p, new_cpu);
> >>>  }
> >>> @@ -8344,6 +8355,9 @@ static int task_hot(struct task_struct *p, stru=
ct lb_env *env)
> >>>         if (sysctl_sched_migration_cost =3D=3D 0)
> >>>                 return 0;
> >>>
> >>> +       if (p->se.migrated)
> >>> +               return 0;
> >>> +
> >>>         delta =3D rq_clock_task(env->src_rq) - p->se.exec_start;
> >>>
> >>>         return delta < (s64)sysctl_sched_migration_cost;
> >>>
> >>>
> >>>
> >>>>
> >>>>
> >>>>>
> >>>>>
> >>> .
> >>>
> > .
> >
