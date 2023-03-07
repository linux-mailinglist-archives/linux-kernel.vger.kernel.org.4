Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB7F6ADCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCGLJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCGLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:09:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B27FF15
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:05:27 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWCFS6LnYzSkdD;
        Tue,  7 Mar 2023 19:02:04 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 19:05:07 +0800
Message-ID: <8adcf1c1-b1a4-3f06-0419-c857868ef13e@huawei.com>
Date:   Tue, 7 Mar 2023 19:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <rkagan@amazon.de>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/7 18:26, Vincent Guittot 写道:
> On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>>>
>>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
>>> entity being placed") fix an overflowing bug, but ignore
>>> a case that se->exec_start is reset after a migration.
>>>
>>> For fixing this case, we reset the vruntime of a long
>>> sleeping task in migrate_task_rq_fair().
>>>
>>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>>
>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>>
>>> ---
>>>
>>> v1 -> v2:
>>> - fix some typos and update comments
>>> - reformat the patch
>>>
>>> ---
>>>  kernel/sched/fair.c | 76 ++++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 55 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 7a1b1f855b96..74c9918ffe76 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4648,11 +4648,45 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>  #endif
>>>  }
>>>
>>> +static inline bool entity_is_long_sleep(struct sched_entity *se)
>>> +{
>>> +       struct cfs_rq *cfs_rq;
>>> +       u64 sleep_time;
>>> +
>>> +       if (se->exec_start == 0)
>>> +               return false;
>>> +
>>> +       cfs_rq = cfs_rq_of(se);
>>> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
>>> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>>> +               return true;
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
>>> +{
>>> +       unsigned long thresh;
>>> +
>>> +       if (se_is_idle(se))
>>> +               thresh = sysctl_sched_min_granularity;
>>> +       else
>>> +               thresh = sysctl_sched_latency;
>>> +
>>> +       /*
>>> +        * Halve their sleep time's effect, to allow
>>> +        * for a gentler effect of sleepers:
>>> +        */
>>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
>>> +               thresh >>= 1;
>>> +
>>> +       return thresh;
>>> +}
>>> +
>>>  static void
>>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>>  {
>>>         u64 vruntime = cfs_rq->min_vruntime;
>>> -       u64 sleep_time;
>>>
>>>         /*
>>>          * The 'current' period is already promised to the current tasks,
>>> @@ -4664,23 +4698,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>>                 vruntime += sched_vslice(cfs_rq, se);
>>>
>>>         /* sleeps up to a single latency don't count. */
>>> -       if (!initial) {
>>> -               unsigned long thresh;
>>> -
>>> -               if (se_is_idle(se))
>>> -                       thresh = sysctl_sched_min_granularity;
>>> -               else
>>> -                       thresh = sysctl_sched_latency;
>>> -
>>> -               /*
>>> -                * Halve their sleep time's effect, to allow
>>> -                * for a gentler effect of sleepers:
>>> -                */
>>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
>>> -                       thresh >>= 1;
>>> -
>>> -               vruntime -= thresh;
>>> -       }
>>> +       if (!initial)
>>> +               vruntime -= sched_sleeper_credit(se);
>>>
>>>         /*
>>>          * Pull vruntime of the entity being placed to the base level of
>>> @@ -4689,8 +4708,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>>          * the base as it may be too far off and the comparison may get
>>>          * inversed due to s64 overflow.
>>>          */
>>> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>>> +       if (entity_is_long_sleep(se))
>>>                 se->vruntime = vruntime;
>>>         else
>>>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
>>> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>>         if (READ_ONCE(p->__state) == TASK_WAKING) {
>>>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>
>>> -               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>>> +               /*
>>> +                * We determine whether a task sleeps for long by checking
>>> +                * se->exec_start, and if it is, we sanitize its vruntime at
>>> +                * place_entity(). However, after a migration, this detection
>>> +                * method fails due to se->exec_start being reset.
>>> +                *
>>> +                * For fixing this case, we add the same check here. For a task
>>> +                * which has slept for a long time, its vruntime should be reset
>>> +                * to cfs_rq->min_vruntime with a sleep credit. Because waking
>>> +                * task's vruntime will be added to cfs_rq->min_vruntime when
>>> +                * enqueue, we only need to reset the se->vruntime of waking task
>>> +                * to a credit here.
>>> +                */
>>> +               if (entity_is_long_sleep(se))
> 
> I completely overlooked that we can't use rq_clock_task here. Need to
> think a bit more on this

yes, i am trying to slove it.

> 
>>> +                       se->vruntime = -sched_sleeper_credit(se);
>>> +               else
>>> +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>>>         }
>>>
>>>         if (!task_on_rq_migrating(p)) {
>>> --
>>> 2.17.1
>>>
> .
> 
