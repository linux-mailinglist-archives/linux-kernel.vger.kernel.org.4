Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D196BABE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjCOJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjCOJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:16:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6A75861
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:16:29 -0700 (PDT)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pc4TM6PwYzHwmD;
        Wed, 15 Mar 2023 17:14:15 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:16:26 +0800
Message-ID: <5a08aa29-f197-1379-c441-8c1db5fa7ab7@huawei.com>
Date:   Wed, 15 Mar 2023 17:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book>
 <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
 <CAKfTPtBaBdxfc9uoViNT8gsWU-GdgnHrDdWPpAduadTFmu1ZGg@mail.gmail.com>
 <55754a59-a01f-206a-43f6-d07ea37300dd@huawei.com>
 <CAKfTPtCCQ0__kz8UfaSm7qrpOQc47rPheD+KLoyBAbmp_tLP0w@mail.gmail.com>
 <3f43273a-5b73-0a44-a452-8a8427bb9ff2@huawei.com>
 <CAKfTPtD7g5JKDAbob0pPS8EPsHGZhjrE+JEuiEmj19moFbY1HQ@mail.gmail.com>
 <ZBCTg/dGAIRsldHU@vingu-book>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <ZBCTg/dGAIRsldHU@vingu-book>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DIET_1,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/14 23:32, Vincent Guittot 写道:
> Le mardi 14 mars 2023 à 14:39:49 (+0100), Vincent Guittot a écrit :
>> On Tue, 14 Mar 2023 at 14:38, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>>>
>>>
>>>
>>> 在 2023/3/14 21:26, Vincent Guittot 写道:
>>>> On Tue, 14 Mar 2023 at 12:03, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> 在 2023/3/13 22:23, Vincent Guittot 写道:
>>>>>> On Sat, 11 Mar 2023 at 10:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 在 2023/3/10 22:29, Vincent Guittot 写道:
>>>>>>>> Le jeudi 09 mars 2023 à 16:14:38 (+0100), Vincent Guittot a écrit :
>>>>>>>>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
>>>>>>>>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Then, even if we don't clear exec_start before migrating and keep
>>>>>>>>>>>> current value to be used in place_entity on the new cpu, we can't
>>>>>>>>>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
>>>>>>>>>>>
>>>>>>>>>>> Blergh -- indeed, irq and steal time can skew them between CPUs :/
>>>>>>>>>>> I suppose we can fudge that... wait_start (which is basically what we're
>>>>>>>>>>> making it do) also does that IIRC.
>>>>>>>>>>>
>>>>>>>>>>> I really dislike having this placement muck spreadout like proposed.
>>>>>>>>>>
>>>>>>>>>> Also, I think we might be over-engineering this, we don't care about
>>>>>>>>>> accuracy at all, all we really care about is 'long-time'.
>>>>>>>>>
>>>>>>>>> you mean taking the patch 1/2 that you mentioned here to add a
>>>>>>>>> migrated field:
>>>>>>>>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db705429d003b
>>>>>>>>>
>>>>>>>>> And assume that the divergence between the rq_clock_task() can be ignored ?
>>>>>>>>>
>>>>>>>>> That could probably work but we need to replace the (60LL *
>>>>>>>>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
>>>>>>>>> would not be unrealistic.
>>>>>>>>> and a comment to explain why it's acceptable
>>>>>>>>
>>>>>>>> Zhang,
>>>>>>>>
>>>>>>>> Could you try the patch below ?
>>>>>>>> This is a rebase/merge/update of:
>>>>>>>> -patch 1/2 above and
>>>>>>>> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
>>>>>>>
>>>>>>>
>>>>>>> I applyed and tested this patch, and it make hackbench slower.
>>>>>>> According to my previous test results. The good result is 82.1(s).
>>>>>>> But the result of this patch is 108.725(s).
>>>>>>
>>>>>> By "the result of this patch is 108.725(s)",  you mean the result of
>>>>>> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
>>>>>> alone, don't you ?
>>>>>
>>>>> No, with your patch, the test results is 108.725(s),
>>>>
>>>> Ok
>>>>
>>>>>
>>>>> git diff:
>>>>>
>>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>>> index 63d242164b1a..93a3909ae4c4 100644
>>>>> --- a/include/linux/sched.h
>>>>> +++ b/include/linux/sched.h
>>>>> @@ -550,6 +550,7 @@ struct sched_entity {
>>>>>         struct rb_node                  run_node;
>>>>>         struct list_head                group_node;
>>>>>         unsigned int                    on_rq;
>>>>> +       unsigned int                    migrated;
>>>>>
>>>>>         u64                             exec_start;
>>>>>         u64                             sum_exec_runtime;
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index ff4dbbae3b10..e60defc39f6e 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>>         /*
>>>>>          * We are starting a new run period:
>>>>>          */
>>>>> +       se->migrated = 0;
>>>>>         se->exec_start = rq_clock_task(rq_of(cfs_rq));
>>>>>  }
>>>>>
>>>>> @@ -4690,9 +4691,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>>>>          * inversed due to s64 overflow.
>>>>>          */
>>>>>         sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
>>>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
>>>>> +       if ((s64)sleep_time > (1ULL << 63) / scale_load_down(NICE_0_LOAD) / 2) {
>>>>>                 se->vruntime = vruntime;
>>>>> -       else
>>>>> +       } else
>>>>>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
>>>>>  }
>>>>>
>>>>> @@ -7658,8 +7659,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>>>>         se->avg.last_update_time = 0;
>>>>>
>>>>>         /* We have migrated, no longer consider this task hot */
>>>>> -       se->exec_start = 0;
>>>>> -
>>>>> +       se->migrated = 1;
>>>>>         update_scan_period(p, new_cpu);
>>>>>  }
>>>>>
>>>>> @@ -8343,6 +8343,8 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>>>>>
>>>>>         if (sysctl_sched_migration_cost == 0)
>>>>>                 return 0;
>>>>> +       if (p->se.migrated)
>>>>> +               return 0;
>>>>>
>>>>>         delta = rq_clock_task(env->src_rq) - p->se.exec_start;
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> version1: v6.2
>>>>>>>> version2: v6.2 + commit 829c1651e9c4
>>>>>>>> version3: v6.2 + commit 829c1651e9c4 + this patch
>>>>>>>>
>>>>>>>> -------------------------------------------------
>>>>>>>>       version1        version2        version3
>>>>>>>> test1 81.0            118.1           82.1
>>>>>>>> test2 82.1            116.9           80.3
>>>>>>>> test3 83.2            103.9           83.3
>>>>>>>> avg(s)        82.1            113.0           81.9
>>>>>>
>>>>>> Ok, it looks like we are back to normal figures
>>>>
>>>> What do those results refer to then ?
>>>
>>> Quote from this email (https://lore.kernel.org/lkml/1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com/).
>>
>> ok.
>>
>> Then, there is something wrong in my patch. Let me look at it more deeply
> 
> Coudl you try the patc below. It fixes the problem on my system
> 

Yes, it fixes the problem.

------

 Performance counter stats for 'hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100' (10 runs):

             79.53 +- 1.21 seconds time elapsed  ( +-  1.52% )



> ---
>  kernel/sched/fair.c | 84 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 59 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f499e9a74b5..f8722e47bb0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4648,23 +4648,36 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #endif
>  }
> 
> +static inline bool entity_is_long_sleeper(struct sched_entity *se)
> +{
> +       struct cfs_rq *cfs_rq;
> +       u64 sleep_time;
> +
> +       if (se->exec_start == 0)
> +               return false;
> +
> +       cfs_rq = cfs_rq_of(se);
> +
> +       sleep_time = rq_clock_task(rq_of(cfs_rq));
> +
> +       /* Happen while migrating because of clock task divergence */
> +       if (sleep_time <= se->exec_start)
> +	       return false;
> +
> +       sleep_time -= se->exec_start;
> +       if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
> +               return true;
> +
> +       return false;
> +}
> +
>  static void
> -place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> +place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>  	u64 vruntime = cfs_rq->min_vruntime;
> -	u64 sleep_time;
> -
> -	/*
> -	 * The 'current' period is already promised to the current tasks,
> -	 * however the extra weight of the new task will slow them down a
> -	 * little, place the new task so that it fits in the slot that
> -	 * stays open at the end.
> -	 */
> -	if (initial && sched_feat(START_DEBIT))
> -		vruntime += sched_vslice(cfs_rq, se);
> 
>  	/* sleeps up to a single latency don't count. */
> -	if (!initial) {
> +	if (flags & ENQUEUE_WAKEUP) {
>  		unsigned long thresh;
> 
>  		if (se_is_idle(se))
> @@ -4680,20 +4693,43 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  			thresh >>= 1;
> 
>  		vruntime -= thresh;
> +	} else if sched_feat(START_DEBIT) {

There's a parenthesis missing here.


> +		/*
> +		 * The 'current' period is already promised to the current tasks,
> +		 * however the extra weight of the new task will slow them down a
> +		 * little, place the new task so that it fits in the slot that
> +		 * stays open at the end.
> +		 */
> +		vruntime += sched_vslice(cfs_rq, se);
>  	}
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
> +	 * the exterme being when an entity with the minimal weight always runs
> +	 * on the cfs_rq. If the new entity slept for long, its vruntime
> +	 * difference from min_vruntime may overflow s64 and their comparison
> +	 * may get inversed, so ignore the entity's original vruntime in that
> +	 * case.
> +	 * The maximal vruntime speedup is given by the ratio of normal to
> +	 * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
> +	 * When placing a migrated waking entity, its exec_start has been set
> +	 * from a different rq. In order to take into account a possible
> +	 * divergence between new and prev rq's clocks task because of irq and
> +	 * stolen time, we take an additional margin.
> +	 * So, cutting off on the sleep time of
> +	 *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
> +	 * should be safe.
> +
> +	 */
> +	if (entity_is_long_sleeper(se))
>  		se->vruntime = vruntime;
>  	else
>  		se->vruntime = max_vruntime(se->vruntime, vruntime);
> +
> +	if (flags & ENQUEUE_MIGRATED)
> +		se->exec_start = 0;
>  }
> 
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> @@ -4769,7 +4805,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	account_entity_enqueue(cfs_rq, se);
> 
>  	if (flags & ENQUEUE_WAKEUP)
> -		place_entity(cfs_rq, se, 0);
> +		place_entity(cfs_rq, se, flags);
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
> @@ -11993,7 +12026,7 @@ static void task_fork_fair(struct task_struct *p)
>  		update_curr(cfs_rq);
>  		se->vruntime = curr->vruntime;
>  	}
> -	place_entity(cfs_rq, se, 1);
> +	place_entity(cfs_rq, se, 0);
> 
>  	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
>  		/*
> @@ -12137,8 +12170,9 @@ static void detach_task_cfs_rq(struct task_struct *p)
>  		/*
>  		 * Fix up our vruntime so that the current sleep doesn't
>  		 * cause 'unlimited' sleep bonus.
> +		 * This is the same as placing a waking task.
>  		 */
> -		place_entity(cfs_rq, se, 0);
> +		place_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>  		se->vruntime -= cfs_rq->min_vruntime;
>  	}
> 
> --
> 2.34.1
> 
> 
>>
>>>
>>>>
> .
> 
