Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2858F6B5A40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCKJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:57:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC9D101121
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:57:07 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PYdY02WnGzSkbF;
        Sat, 11 Mar 2023 17:53:56 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 17:57:05 +0800
Message-ID: <ef2f07f1-fe3a-624f-52e7-1089138dc137@huawei.com>
Date:   Sat, 11 Mar 2023 17:57:04 +0800
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
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <ZAs+zV0o9ShO7nLT@vingu-book>
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



在 2023/3/10 22:29, Vincent Guittot 写道:
> Le jeudi 09 mars 2023 à 16:14:38 (+0100), Vincent Guittot a écrit :
>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
>>>>
>>>>> Then, even if we don't clear exec_start before migrating and keep
>>>>> current value to be used in place_entity on the new cpu, we can't
>>>>> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
>>>>
>>>> Blergh -- indeed, irq and steal time can skew them between CPUs :/
>>>> I suppose we can fudge that... wait_start (which is basically what we're
>>>> making it do) also does that IIRC.
>>>>
>>>> I really dislike having this placement muck spreadout like proposed.
>>>
>>> Also, I think we might be over-engineering this, we don't care about
>>> accuracy at all, all we really care about is 'long-time'.
>>
>> you mean taking the patch 1/2 that you mentioned here to add a
>> migrated field:
>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db705429d003b
>>
>> And assume that the divergence between the rq_clock_task() can be ignored ?
>>
>> That could probably work but we need to replace the (60LL *
>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
>> would not be unrealistic.
>> and a comment to explain why it's acceptable
> 
> Zhang,
> 
> Could you try the patch below ?
> This is a rebase/merge/update of:
> -patch 1/2 above and 
> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/


I applyed and tested this patch, and it make hackbench slower.
According to my previous test results. The good result is 82.1(s).
But the result of this patch is 108.725(s).


> version1: v6.2
> version2: v6.2 + commit 829c1651e9c4
> version3: v6.2 + commit 829c1651e9c4 + this patch
>
> -------------------------------------------------
> 	version1	version2	version3
> test1	81.0 		118.1 		82.1
> test2	82.1 		116.9 		80.3
> test3	83.2 		103.9 		83.3
> avg(s)	82.1 		113.0 		81.9
>
> -------------------------------------------------
> 
> The proposal accepts a divergence of up to 52 days between the 2 rqs.
> 
> If this work, we will prepare a proper patch
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 63d242164b1a..cb8af0a137f7 100644
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
> index 7a1b1f855b96..36acd9598b40 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         /*
>          * We are starting a new run period:
>          */
> +       se->migrated = 0;
>         se->exec_start = rq_clock_task(rq_of(cfs_rq));
>  }
> 
> @@ -4684,13 +4685,23 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> 
>         /*
>          * Pull vruntime of the entity being placed to the base level of
> -        * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> -        * slept for a long time, don't even try to compare its vruntime with
> -        * the base as it may be too far off and the comparison may get
> -        * inversed due to s64 overflow.
> +        * cfs_rq, to prevent boosting it if placed backwards.
> +        * However, min_vruntime can advance much faster than real time, with
> +        * the exterme being when an entity with the minimal weight always runs
> +        * on the cfs_rq. If the new entity slept for long, its vruntime
> +        * difference from min_vruntime may overflow s64 and their comparison
> +        * may get inversed, so ignore the entity's original vruntime in that
> +        * case.
> +        * The maximal vruntime speedup is given by the ratio of normal to
> +        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off on the

why not is `scale_load_down(NICE_0_LOAD) / MIN_SHARES` here ?


> +        * sleep time of 2^63 / NICE_0_LOAD should be safe.
> +        * When placing a migrated waking entity, its exec_start has been set
> +        * from a different rq. In order to take into account a possible
> +        * divergence between new and prev rq's clocks task because of irq and

This divergence might be larger, it cause `sleep_time` maybe negative.

> +        * stolen time, we take an additional margin.
>          */
>         sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> +       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2)>                 se->vruntime = vruntime;
>         else
>                 se->vruntime = max_vruntime(se->vruntime, vruntime);
> @@ -7658,7 +7669,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>         se->avg.last_update_time = 0;
> 
>         /* We have migrated, no longer consider this task hot */
> -       se->exec_start = 0;
> +       se->migrated = 1;
> 
>         update_scan_period(p, new_cpu);
>  }
> @@ -8344,6 +8355,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>         if (sysctl_sched_migration_cost == 0)
>                 return 0;
> 
> +       if (p->se.migrated)
> +               return 0;
> +
>         delta = rq_clock_task(env->src_rq) - p->se.exec_start;
> 
>         return delta < (s64)sysctl_sched_migration_cost;
> 
> 
> 
>>
>>
>>>
>>>
> .
> 
