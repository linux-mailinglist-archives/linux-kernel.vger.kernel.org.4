Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5526ABDEA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCFLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCFLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:13:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1B28233
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:12:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 130so5286510pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678101161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4yO/4ikGRcg9UJ/g5KkI9P66rz7lPE6H/2uNJnO46s=;
        b=o3sD1KF5DiZyD3iZJ5ji9poZZlcb7Wq/v1LG/gMrjYpTqZVpi9RWmegqANbcGiQU4n
         wXYIdnKgnN4pdxQtOYd/JAEUxobuITKjxfo99xtmAaM/TC8sH5cZTU8qUm5u5kXuv2o8
         LULoto/LggzOJANi/0sE4npkQhDF0obtgu7w8eTvu5P8OSXVrpy9adWp+uZTPGCm4gUM
         g5FDsHeXZp6oGfbte7oUREucSZC3EYY70n0m5s92bgt/FkgKqZjOm7nin1YMWVJJdU/h
         vOdvGfNzFSMy1+M/WnnD0bWRXkUVVU35eF8F4be6SZ4owWlHDGKb+sxfv6EScyoB3bEu
         dJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4yO/4ikGRcg9UJ/g5KkI9P66rz7lPE6H/2uNJnO46s=;
        b=2GwBkuYow7PIXzO78ej47Wxshrbj+aoEA4caXRZfYEkNuz/I35zzO8OckO/rkmsx4D
         naJI0IwZAKeGyzAyaIQRDweZjd+HAbBwnQe1YUxvr01QWxP0BZ3GuOe3Xywf1v7qKFOd
         NlZ48q8Hlz4N+OfOJbr2WmCpK2BsBsQwo0peftrU2rnqMv8vdTIY2WDQWkDPi3wy7pIl
         FKjKI7rTNG0U/CKNWO2aIF7yHnt+LqVuGp3QbcyFwVhzeNFYadqVoz50rDozx7XfOHy1
         G8nFvJf88LwIDAPwykm1JU0R63kEWnGFyvNKYYGDeeSHPEVj/aXz2JJnXaJ6OZrJdqdF
         JcVg==
X-Gm-Message-State: AO0yUKW251l1Qp6I9jtAPFLdjU0kt/CfD+iIUH53qFOqpZYmHBJsD9HQ
        YgvqZd5Cl3cu4Hi49PkqWgUVi/8fY+u94775vDjWmQ==
X-Google-Smtp-Source: AK7set+zpdMAyIWX2is1kCSBd1kn95NSJbV1XQLGOgBogP1q2Fb1Ob2Ydde4FA1s0lLJYhwXiBLJChrMqEEQ/teoYfU=
X-Received: by 2002:a63:2950:0:b0:4fd:5105:eb93 with SMTP id
 bu16-20020a632950000000b004fd5105eb93mr3356480pgb.3.1678101160591; Mon, 06
 Mar 2023 03:12:40 -0800 (PST)
MIME-Version: 1.0
References: <79850642-ebac-5c23-d32d-b28737dcb91e@huawei.com>
In-Reply-To: <79850642-ebac-5c23-d32d-b28737dcb91e@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Mar 2023 12:12:29 +0100
Message-ID: <CAKfTPtArYhmq42ZEwi8gkVAEK0R5=PGws95j8KmQWutJaUZMAA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being migrated
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2023 at 09:29, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> entity being placed") fix an overflowing bug, but ignore
> a case that se->exec_start is reset after a migration.
>
> For fix this case, we reset the vruntime of a loog sleep
> task in migrate_task_rq_fair().

some typo:
"For fixing this case, we reset the vruntime of a long sleeping task
in migrate_task_rq_fair()."

>
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Your patch doesn't apply. It seems to be malformed

> ---
>  kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 53 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..6697462baf0f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,6 +4648,41 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
>  +static inline bool entity_is_long_sleep(struct sched_entity *se)

This extra space at the beg of the line above looks strange

> +{
> +       struct cfs_rq *cfs_rq;
> +       u64 sleep_time;
> +
> +       if (se->exec_start == 0)
> +               return false;
> +
> +       cfs_rq = cfs_rq_of(se);
> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +               return true;
> +
> +       return false;
> +}
> +
> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> +{
> +       unsigned long thresh;
> +
> +       if (se_is_idle(se))
> +               thresh = sysctl_sched_min_granularity;
> +       else
> +               thresh = sysctl_sched_latency;
> +
> +       /*
> +        * Halve their sleep time's effect, to allow
> +        * for a gentler effect of sleepers:
> +        */
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               thresh >>= 1;
> +
> +       return thresh;
> +}
> +
>  static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
> @@ -4664,23 +4699,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 vruntime += sched_vslice(cfs_rq, se);
>         /* sleeps up to a single latency don't count. */
> -       if (!initial) {
> -               unsigned long thresh;
> -
> -               if (se_is_idle(se))
> -                       thresh = sysctl_sched_min_granularity;
> -               else
> -                       thresh = sysctl_sched_latency;
> -
> -               /*
> -                * Halve their sleep time's effect, to allow
> -                * for a gentler effect of sleepers:
> -                */
> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -                       thresh >>= 1;
> -
> -               vruntime -= thresh;
> -       }
> +       if (!initial)
> +               vruntime -= sched_sleeper_credit(se);
>         /*
>          * Pull vruntime of the entity being placed to the base level of
> @@ -4689,8 +4709,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>          * the base as it may be too far off and the comparison may get
>          * inversed due to s64 overflow.
>          */
> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +       if (entity_is_long_sleep(se))
>                 se->vruntime = vruntime;
>         else
>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
> @@ -7635,7 +7654,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>         if (READ_ONCE(p->__state) == TASK_WAKING) {
>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  -              se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> +               /*
> +                * We determine a task whether sleep for long by checking se->exec_start,
> +                * and if it is, sanitize its vruntime at place_entity(). However, after
> +                * a migration, this detection method fails due to se->exec_start is reset.

some typo

"We determine whether a task sleeps for long by checking
se->exec_start, and if it is, we sanitize its vruntime at
place_entity(). However, after a migration, this detection method
fails due to se->exec_start being reset."

> +                *
> +                * For fix this case, we add the same check at here. For a task which has
> +                * slept for long, its vruntime should be reset cfs_rq->min_vruntime and get
> +                * a sleep credit. Because waking task's vruntime will be added cfs_rq->min_vruntime

For fixing this case, we add the same check here. For a task which has
slept for a long time, its vruntime should be reset to
cfs_rq->min_vruntime with a sleep credit.

Beside the typo and malformed patch, the proposed fix looks good to me

> +                * when enqueue, so we only need resetting the se->vruntime of waking task
> +                * to a credit at here.
> +                */
> +               if (entity_is_long_sleep(se))
> +                       se->vruntime = -sched_sleeper_credit(se);
> +               else
> +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>         }
>         if (!task_on_rq_migrating(p)) {
> --
> 2.17.1
>
> .
