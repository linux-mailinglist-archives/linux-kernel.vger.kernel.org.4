Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8896BF885
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCRHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCRHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:45:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB652BF08
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:45:27 -0700 (PDT)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PdtHf3G7YzSlrV;
        Sat, 18 Mar 2023 15:42:06 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 15:45:25 +0800
Message-ID: <f0f7bce7-4d98-c5d0-5e75-55f27a9a0d69@huawei.com>
Date:   Sat, 18 Mar 2023 15:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20230317160810.107988-1-vincent.guittot@linaro.org>
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



在 2023/3/18 0:08, Vincent Guittot 写道:
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> fixes an overflowing bug, but ignore a case that se->exec_start is reset
> after a migration.
> 
> For fixing this case, we delay the reset of se->exec_start after
> placing the entity which se->exec_start to detect long sleeping task.
> 
> In order to take into account a possible divergence between the clock_task
> of 2 rqs, we increase the threshold to around 104 days.
> 
> 
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> My last proposal was not yet correct as the exec_start was not always
> reset after migrating a task. I finally found this solution which keeps
> the long sleep detection to one place as well as the reset of se->exec_start.
> 

Tested-by: Zhang Qiao <zhangqiao22@huawei.com>

I have retested it with this version, and the result is fine.

-------

 Performance counter stats for 'hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100' (10 runs):

             80.10 +- 1.22 seconds time elapsed  ( +-  1.53% )


Thanks,
Zhang Qiao.

>  kernel/sched/fair.c | 57 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f499e9a74b5..421173fde351 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,11 +4648,33 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
>  
> +static inline bool entity_is_long_sleeper(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq;
> +	u64 sleep_time;
> +
> +	if (se->exec_start == 0)
> +		return false;
> +
> +	cfs_rq = cfs_rq_of(se);
> +
> +	sleep_time = rq_clock_task(rq_of(cfs_rq));
> +
> +	/* Happen while migrating because of clock task divergence */
> +	if (sleep_time <= se->exec_start)
> +		return false;
> +
> +	sleep_time -= se->exec_start;
> +	if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>  	u64 vruntime = cfs_rq->min_vruntime;
> -	u64 sleep_time;
>  
>  	/*
>  	 * The 'current' period is already promised to the current tasks,
> @@ -4684,13 +4706,24 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  
>  	/*
>  	 * Pull vruntime of the entity being placed to the base level of
> -	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> -	 * slept for a long time, don't even try to compare its vruntime with
> -	 * the base as it may be too far off and the comparison may get
> -	 * inversed due to s64 overflow.
> -	 */
> -	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +	 * cfs_rq, to prevent boosting it if placed backwards.
> +	 * However, min_vruntime can advance much faster than real time, with
> +	 * the extreme being when an entity with the minimal weight always runs
> +	 * on the cfs_rq. If the waking entity slept for a long time, its
> +	 * vruntime difference from min_vruntime may overflow s64 and their
> +	 * comparison may get inversed, so ignore the entity's original
> +	 * vruntime in that case.
> +	 * The maximal vruntime speedup is given by the ratio of normal to
> +	 * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
> +	 * When placing a migrated waking entity, its exec_start has been set
> +	 * from a different rq. In order to take into account a possible
> +	 * divergence between new and prev rq's clocks task because of irq and
> +	 * stolen time, we take an additional margin.
> +	 * So, cutting off on the sleep time of
> +	 *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
> +	 * should be safe.
> +	 */
> +	if (entity_is_long_sleeper(se))
>  		se->vruntime = vruntime;
>  	else
>  		se->vruntime = max_vruntime(se->vruntime, vruntime);
> @@ -4770,6 +4803,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	if (flags & ENQUEUE_WAKEUP)
>  		place_entity(cfs_rq, se, 0);
> +	/* Entity has migrated, no longer consider this task hot */
> +	if (flags & ENQUEUE_MIGRATED)
> +		se->exec_start = 0;
>  
>  	check_schedstat_required();
>  	update_stats_enqueue_fair(cfs_rq, se, flags);
> @@ -7665,9 +7701,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	/* Tell new CPU we are migrated */
>  	se->avg.last_update_time = 0;
>  
> -	/* We have migrated, no longer consider this task hot */
> -	se->exec_start = 0;
> -
>  	update_scan_period(p, new_cpu);
>  }
>  
> @@ -8701,7 +8734,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
>  	lockdep_assert_rq_held(rq);
>  
>  	WARN_ON_ONCE(task_rq(p) != rq);
> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
>  	check_preempt_curr(rq, p, 0);
>  }
>  
> 
