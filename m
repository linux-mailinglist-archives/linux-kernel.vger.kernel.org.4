Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D636B077B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCHMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:55:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E3BCBBE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:55:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t15so15256655wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4yn1RaESf7wZqm/BnONmDXrFb6D4xWGHvNmA0s5U1A=;
        b=USaroYCrEDVYfUj8FCjHUuoXYBtTiGm8L9ym5e/r3ZFieinsqfaeKzhck0cf1k2QpI
         kR35TeHqv971NUT4G7VdGH2HnrThytlbW5bQHScS3TDNf3G1uaf4hrVPlrm4BPkei+tf
         Xirhl+GphpTyotir8r359lTdzicjGL6fjiDQSvW1e43NYRbxnrdL/ou8lVaHfxrtj3wN
         2NQvPCkkIyHWR1d+DdzxpSMnzmvWYweQ+ol0v8rWgwrK1kA+fRAJR2QZrP9n64iA+RqK
         iy2WeTubvYC2X/LxsNckTjlm9lxhJaGpwKRqDRzNFsZWkPT5h02DV7tanyE4ap5OsKH+
         wFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4yn1RaESf7wZqm/BnONmDXrFb6D4xWGHvNmA0s5U1A=;
        b=kApPWkmmTSpstD9T2GqGeecJOWu883Q4jQdw9WpDEe/oES41gHWZBEvcbzWshPzYBG
         zWLr5rrn0Z5rV3u4dZpkQ1fi/B2fbf/n6/N4vDoCD7blANT9wtoSa88ZiPp9polS/9ux
         PI9CvcgY5AJUyLn1G2tJvPYq+fRrZytiGC8KO2oIUo9KbITlVOeWu6JJ5gTKFHWY8NEX
         WiE4fFftbXZlExe0shB8eFJOIm9zcAVjCAE0NKmotTvlux7cyb/HWun24zCO3ktMvecA
         7LXC7xW+0MLiTlTkSu4hxYTwORJSS3VqnBHdKkThS4r5pZDfDMXPuD65cqsJTukSuS34
         SOgw==
X-Gm-Message-State: AO0yUKW581hDOV5ayF1Bq9wMxMhSfHy3ZbjQ+RIgbqTwGABEyNsyg73F
        iFw5ya79M56DAKlIrja89iOdzQ==
X-Google-Smtp-Source: AK7set/U2s38MgEh9hI/weajibKuJZQtcGKqYKpPjrkhp59AagTPgFeluOOw5h2iPSWuIOjJuP2pYQ==
X-Received: by 2002:adf:e302:0:b0:2c5:5ff8:6b02 with SMTP id b2-20020adfe302000000b002c55ff86b02mr12443757wrj.0.1678280136279;
        Wed, 08 Mar 2023 04:55:36 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:90de:b2fd:d459:aebb])
        by smtp.gmail.com with ESMTPSA id x17-20020adfdcd1000000b002c5804b6afasm15349223wrm.67.2023.03.08.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:55:35 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:55:33 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <ZAiFxWLSb9HDazSI@vingu-book>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
 <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com>
 <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 08 mars 2023 à 09:01:05 (+0100), Vincent Guittot a écrit :
> On Tue, 7 Mar 2023 at 14:41, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> >
> >
> >
> > 在 2023/3/7 18:26, Vincent Guittot 写道:
> > > On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > >>
> > >> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> > >>>
> > >>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> > >>> entity being placed") fix an overflowing bug, but ignore
> > >>> a case that se->exec_start is reset after a migration.
> > >>>
> > >>> For fixing this case, we reset the vruntime of a long
> > >>> sleeping task in migrate_task_rq_fair().
> > >>>
> > >>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> > >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > >>
> > >> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >>
> > >>> ---
> > >>>
> > >>> v1 -> v2:
> > >>> - fix some typos and update comments
> > >>> - reformat the patch
> > >>>
> > >>> ---
> > >>>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-------------
> > >>>  1 file changed, 55 insertions(+), 21 deletions(-)
> > >>>
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index 7a1b1f855b96..74c9918ffe76 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >>>  #endif
> > >>>  }
> > >>>
> > >>> +static inline bool entity_is_long_sleep(struct sched_entity *se)
> > >>> +{
> > >>> +       struct cfs_rq *cfs_rq;
> > >>> +       u64 sleep_time;
> > >>> +
> > >>> +       if (se->exec_start == 0)
> > >>> +               return false;
> > >>> +
> > >>> +       cfs_rq = cfs_rq_of(se);
> > >>> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > >>> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > >>> +               return true;
> > >>> +
> > >>> +       return false;
> > >>> +}
> > >>> +
> > >>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> > >>> +{
> > >>> +       unsigned long thresh;
> > >>> +
> > >>> +       if (se_is_idle(se))
> > >>> +               thresh = sysctl_sched_min_granularity;
> > >>> +       else
> > >>> +               thresh = sysctl_sched_latency;
> > >>> +
> > >>> +       /*
> > >>> +        * Halve their sleep time's effect, to allow
> > >>> +        * for a gentler effect of sleepers:
> > >>> +        */
> > >>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > >>> +               thresh >>= 1;
> > >>> +
> > >>> +       return thresh;
> > >>> +}
> > >>> +
> > >>>  static void
> > >>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >>>  {
> > >>>         u64 vruntime = cfs_rq->min_vruntime;
> > >>> -       u64 sleep_time;
> > >>>
> > >>>         /*
> > >>>          * The 'current' period is already promised to the current tasks,
> > >>> @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >>>                 vruntime += sched_vslice(cfs_rq, se);
> > >>>
> > >>>         /* sleeps up to a single latency don't count. */
> > >>> -       if (!initial) {
> > >>> -               unsigned long thresh;
> > >>> -
> > >>> -               if (se_is_idle(se))
> > >>> -                       thresh = sysctl_sched_min_granularity;
> > >>> -               else
> > >>> -                       thresh = sysctl_sched_latency;
> > >>> -
> > >>> -               /*
> > >>> -                * Halve their sleep time's effect, to allow
> > >>> -                * for a gentler effect of sleepers:
> > >>> -                */
> > >>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > >>> -                       thresh >>= 1;
> > >>> -
> > >>> -               vruntime -= thresh;
> > >>> -       }
> > >>> +       if (!initial)
> > >>> +               vruntime -= sched_sleeper_credit(se);
> > >>>
> > >>>         /*
> > >>>          * Pull vruntime of the entity being placed to the base level of
> > >>> @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >>>          * the base as it may be too far off and the comparison may get
> > >>>          * inversed due to s64 overflow.
> > >>>          */
> > >>> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> > >>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > >>> +       if (entity_is_long_sleep(se))
> > >>>                 se->vruntime = vruntime;
> > >>>         else
> > >>>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
> > >>> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >>>         if (READ_ONCE(p->__state) == TASK_WAKING) {
> > >>>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > >>>
> > >>> -               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > >>> +               /*
> > >>> +                * We determine whether a task sleeps for long by checking
> > >>> +                * se->exec_start, and if it is, we sanitize its vruntime at
> > >>> +                * place_entity(). However, after a migration, this detection
> > >>> +                * method fails due to se->exec_start being reset.
> > >>> +                *
> > >>> +                * For fixing this case, we add the same check here. For a task
> > >>> +                * which has slept for a long time, its vruntime should be reset
> > >>> +                * to cfs_rq->min_vruntime with a sleep credit. Because waking
> > >>> +                * task's vruntime will be added to cfs_rq->min_vruntime when
> > >>> +                * enqueue, we only need to reset the se->vruntime of waking task
> > >>> +                * to a credit here.
> > >>> +                */
> > >>> +               if (entity_is_long_sleep(se))
> > >
> > > I completely overlooked that we can't use rq_clock_task here. Need to
> > > think a bit more on this
> >
> > Hi,Vincent,
> >
> > How about using exec_start of the parent sched_entity instant of rq_clock_task()?
> 
> How do we handle sched_entity without a parent sched_entity ?

The change below should do the stuff. Not that we can't use it in place entity because
pelt is not enabled in UP.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74c9918ffe76..b8b381b0ff20 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7635,6 +7635,32 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
        return new_cpu;
 }

+static inline bool migrate_long_sleeper(struct sched_entity *se)
+{
+       struct cfs_rq *cfs_rq;
+       u64 sleep_time;
+
+       if (se->exec_start == 0)
+               return false;
+
+       cfs_rq = cfs_rq_of(se);
+       /*
+        * If the entity slept for a long time, don't even try to normalize its
+        * vruntime with the base as it may be too far off and might generate
+        * wrong decision because of s64 overflow.
+        * We estimate its sleep duration with the last update of se's pelt.
+        * The last update happened before sleeping. The cfs' pelt is not
+        * always updated when cfs is idle but this is not a problem because
+        * its min_vruntime is not updated too, so the situation can't get
+        * worse.
+        */
+       sleep_time = cfs_rq_last_update_time(cfs_rq) - se->avg.last_update_time;
+       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+               return true;
+
+       return false;
+}
+
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7666,7 +7692,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
                 * enqueue, we only need to reset the se->vruntime of waking task
                 * to a credit here.
                 */
-               if (entity_is_long_sleep(se))
+               if (migrate_long_sleeper(se))
                        se->vruntime = -sched_sleeper_credit(se);
                else
                        se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);



> 
> 
> 
> > >
> > >>> +                       se->vruntime = -sched_sleeper_credit(se);
> > >>> +               else
> > >>> +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > >>>         }
> > >>>
> > >>>         if (!task_on_rq_migrating(p)) {
> > >>> --
> > >>> 2.17.1
> > >>>
> > > .
> > >
