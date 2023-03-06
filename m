Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13106ABF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCFM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCFM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:26:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5323DA1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:26:20 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PVd8y4DBWz1gwr6;
        Mon,  6 Mar 2023 20:26:10 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 20:26:15 +0800
Message-ID: <885fd0df-6a1a-d8de-4f8c-dff8a0afd3ca@huawei.com>
Date:   Mon, 6 Mar 2023 20:26:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being migrated
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
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
References: <79850642-ebac-5c23-d32d-b28737dcb91e@huawei.com>
 <CAKfTPtArYhmq42ZEwi8gkVAEK0R5=PGws95j8KmQWutJaUZMAA@mail.gmail.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <CAKfTPtArYhmq42ZEwi8gkVAEK0R5=PGws95j8KmQWutJaUZMAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2023/3/6 19:12, Vincent Guittot 写道:
> On Sat, 4 Mar 2023 at 09:29, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>>
>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
>> entity being placed") fix an overflowing bug, but ignore
>> a case that se->exec_start is reset after a migration.
>>
>> For fix this case, we reset the vruntime of a loog sleep
>> task in migrate_task_rq_fair().
> 
> some typo:
> "For fixing this case, we reset the vruntime of a long sleeping task
> in migrate_task_rq_fair()."
> 
>>
>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> 
> Your patch doesn't apply. It seems to be malformed
> 
>> ---
>>  kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 53 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ff4dbbae3b10..6697462baf0f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4648,6 +4648,41 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>  #endif
>>  }
>>  +static inline bool entity_is_long_sleep(struct sched_entity *se)
> 
> This extra space at the beg of the line above looks strange
> 
>> +{
>> +       struct cfs_rq *cfs_rq;
>> +       u64 sleep_time;
>> +
>> +       if (se->exec_start == 0)
>> +               return false;
>> +
>> +       cfs_rq = cfs_rq_of(se);
>> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
>> +       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
>> +{
>> +       unsigned long thresh;
>> +
>> +       if (se_is_idle(se))
>> +               thresh = sysctl_sched_min_granularity;
>> +       else
>> +               thresh = sysctl_sched_latency;
>> +
>> +       /*
>> +        * Halve their sleep time's effect, to allow
>> +        * for a gentler effect of sleepers:
>> +        */
>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
>> +               thresh >>= 1;
>> +
>> +       return thresh;
>> +}
>> +
>>  static void
>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>  {
>> @@ -4664,23 +4699,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>                 vruntime += sched_vslice(cfs_rq, se);
>>         /* sleeps up to a single latency don't count. */
>> -       if (!initial) {
>> -               unsigned long thresh;
>> -
>> -               if (se_is_idle(se))
>> -                       thresh = sysctl_sched_min_granularity;
>> -               else
>> -                       thresh = sysctl_sched_latency;
>> -
>> -               /*
>> -                * Halve their sleep time's effect, to allow
>> -                * for a gentler effect of sleepers:
>> -                */
>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
>> -                       thresh >>= 1;
>> -
>> -               vruntime -= thresh;
>> -       }
>> +       if (!initial)
>> +               vruntime -= sched_sleeper_credit(se);
>>         /*
>>          * Pull vruntime of the entity being placed to the base level of
>> @@ -4689,8 +4709,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>          * the base as it may be too far off and the comparison may get
>>          * inversed due to s64 overflow.
>>          */
>> -       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>> +       if (entity_is_long_sleep(se))
>>                 se->vruntime = vruntime;
>>         else
>>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
>> @@ -7635,7 +7654,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>         if (READ_ONCE(p->__state) == TASK_WAKING) {
>>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>  -              se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>> +               /*
>> +                * We determine a task whether sleep for long by checking se->exec_start,
>> +                * and if it is, sanitize its vruntime at place_entity(). However, after
>> +                * a migration, this detection method fails due to se->exec_start is reset.
> 
> some typo
> 
> "We determine whether a task sleeps for long by checking
> se->exec_start, and if it is, we sanitize its vruntime at
> place_entity(). However, after a migration, this detection method
> fails due to se->exec_start being reset."
> 
>> +                *
>> +                * For fix this case, we add the same check at here. For a task which has
>> +                * slept for long, its vruntime should be reset cfs_rq->min_vruntime and get
>> +                * a sleep credit. Because waking task's vruntime will be added cfs_rq->min_vruntime
> 
> For fixing this case, we add the same check here. For a task which has
> slept for a long time, its vruntime should be reset to
> cfs_rq->min_vruntime with a sleep credit.
> 
> Beside the typo and malformed patch, the proposed fix looks good to me

HI, Vincent,

Thank you for your correction.


> 
>> +                * when enqueue, so we only need resetting the se->vruntime of waking task
>> +                * to a credit at here.
>> +                */
>> +               if (entity_is_long_sleep(se))
>> +                       se->vruntime = -sched_sleeper_credit(se);
>> +               else
>> +                       se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>>         }
>>         if (!task_on_rq_migrating(p)) {
>> --
>> 2.17.1
>>
>> .
> .
> 
