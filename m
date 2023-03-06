Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0656AC1E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCFNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCFNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:53:31 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4520692
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:53:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x7so3831076pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678110810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m36Zf4qpmqz3Sb0ht3fhBo9XI/t/djRJmql4ojKfHz4=;
        b=mTwyzZihAMQKmMesznG8HaKvTbUgt8QnT4333hU3+ZMfEwrT7Jw96pJ9ocoZGuXsY7
         lI0gvww2SS3Jncncr5/G0n5NQPiSFKVyeQC3ftARGZNeRRFOQyop1uFn8wFHIfFb/Ycs
         iQo1SGzuXJivtwDrAn/ts5j1OQEqU9b0ucd+CbYrhtaE7tGloAmDn3BIQLhcWsf+FBxV
         9Fc26TDOoSAcSbhsOrSVxTS/KAPz4j1hPWFyGWpoAZnhJyQp+SpfAo0pFO0PUEJ2f+oh
         t3Ef98LnrvmnMRDeLALncvkMGJUsxRTQiEKUVX6FTpZMZLWvPNvAYxq1QhiVhJ3C4So2
         AiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m36Zf4qpmqz3Sb0ht3fhBo9XI/t/djRJmql4ojKfHz4=;
        b=m6PYki86dJF7oyb+YLPowywHRmClAu5p8Ch0t9MJ7WbeOEzIiso3JoBw6Xp7u/9+zN
         jrztPYBn/i2yeI+Ar8mFniQbXYYk2Pb8TD+AbiYj5cEhH0ItGkEg9k0BWvpPv/zvJCVu
         MqTA5AtWK3pZYWwqHL4zu0dnMuSdpVhUJuLUgq0AJ7vY6ki5snEDeVua7zA8zm3+4kCs
         PNW4aETOxCcqZo6jf2U/XCGU2pO4KzxLYM7ZxanVSmdDBSzcMNHYZH3/YFdRX3EYea/B
         WuYrA2hQa8DLkYGZZRvmAPDeDfE1B3fX62277u5JH0xNevlQTuWTp7HDP7q09+fQhCtm
         xFdw==
X-Gm-Message-State: AO0yUKU7SASWdJFBEJQTj1cOXkE/wt9r5aVucNHEHb3LydHKXxsMbxy7
        L/Itz4dWJIDW6BbkmhWQxJgpvb1ltM/QVjNgCzgJZw==
X-Google-Smtp-Source: AK7set/sZVIh6GKeFV+uo3q/F9cwXIQ2aKDCYValHAeEXrvIJ3wpelFWfjVTW6nPFzp2CBixdV8rq5kNQwgLSMWWEG8=
X-Received: by 2002:a63:7f5d:0:b0:501:26b5:f0d2 with SMTP id
 p29-20020a637f5d000000b0050126b5f0d2mr3724756pgn.3.1678110809649; Mon, 06 Mar
 2023 05:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
In-Reply-To: <20230306132418.50389-1-zhangqiao22@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Mar 2023 14:53:18 +0100
Message-ID: <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> entity being placed") fix an overflowing bug, but ignore
> a case that se->exec_start is reset after a migration.
>
> For fixing this case, we reset the vruntime of a long
> sleeping task in migrate_task_rq_fair().
>
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> v1 -> v2:
> - fix some typos and update comments
> - reformat the patch
>
> ---
>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..74c9918ffe76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
>
> +static inline bool entity_is_long_sleep(struct sched_entity *se)
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
>         u64 vruntime = cfs_rq->min_vruntime;
> -       u64 sleep_time;
>
>         /*
>          * The 'current' period is already promised to the current tasks,
> @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 vruntime += sched_vslice(cfs_rq, se);
>
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
>
>         /*
>          * Pull vruntime of the entity being placed to the base level of
> @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>          * the base as it may be too far off and the comparison may get
>          * inversed due to s64 overflow.
>          */
> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +       if (entity_is_long_sleep(se))
>                 se->vruntime = vruntime;
>         else
>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>         if (READ_ONCE(p->__state) == TASK_WAKING) {
>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> -               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> +               /*
> +                * We determine whether a task sleeps for long by checking
> +                * se->exec_start, and if it is, we sanitize its vruntime at
> +                * place_entity(). However, after a migration, this detection
> +                * method fails due to se->exec_start being reset.
> +                *
> +                * For fixing this case, we add the same check here. For a task
> +                * which has slept for a long time, its vruntime should be reset
> +                * to cfs_rq->min_vruntime with a sleep credit. Because waking
> +                * task's vruntime will be added to cfs_rq->min_vruntime when
> +                * enqueue, we only need to reset the se->vruntime of waking task
> +                * to a credit here.
> +                */
> +               if (entity_is_long_sleep(se))
> +                       se->vruntime = -sched_sleeper_credit(se);
> +               else
> +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>         }
>
>         if (!task_on_rq_migrating(p)) {
> --
> 2.17.1
>
