Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC386C11E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCTM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCTM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:29:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68B48683
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:29:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE27FEC;
        Mon, 20 Mar 2023 05:29:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF8D3F67D;
        Mon, 20 Mar 2023 05:29:06 -0700 (PDT)
Message-ID: <df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com>
Date:   Mon, 20 Mar 2023 13:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
 <f0f7bce7-4d98-c5d0-5e75-55f27a9a0d69@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <f0f7bce7-4d98-c5d0-5e75-55f27a9a0d69@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 08:45, Zhang Qiao wrote:
> 
> 
> 在 2023/3/18 0:08, Vincent Guittot 写道:
>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> fixes an overflowing bug, but ignore a case that se->exec_start is reset
>> after a migration.
>>
>> For fixing this case, we delay the reset of se->exec_start after
>> placing the entity which se->exec_start to detect long sleeping task.
>>
>> In order to take into account a possible divergence between the clock_task
>> of 2 rqs, we increase the threshold to around 104 days.
>>
>>
>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>
>> My last proposal was not yet correct as the exec_start was not always
>> reset after migrating a task. I finally found this solution which keeps
>> the long sleep detection to one place as well as the reset of se->exec_start.
>>
> 
> Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
> 
> I have retested it with this version, and the result is fine.
> 
> -------
> 
>  Performance counter stats for 'hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100' (10 runs):
> 
>              80.10 +- 1.22 seconds time elapsed  ( +-  1.53% )

[...]

>> @@ -8701,7 +8734,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
>>  	lockdep_assert_rq_held(rq);
>>  
>>  	WARN_ON_ONCE(task_rq(p) != rq);
>> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
>> +	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
>>  	check_preempt_curr(rq, p, 0);

Why not:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9bc1ab67aaa..96dd3a62e683 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7674,7 +7674,10 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
 
-	if (!task_on_rq_migrating(p)) {
+	if (task_on_rq_migrating(p)) {
+		/* We have migrated, no longer consider this task hot */
+		se->exec_start = 0;
+	} else {
 		remove_entity_load_avg(se);
 
 		/*
@@ -8726,7 +8729,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
 	lockdep_assert_rq_held(rq);
 
 	WARN_ON_ONCE(task_rq(p) != rq);
-	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
+	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	check_preempt_curr(rq, p, 0);
 }


entity_is_long_sleeper() will bail early for these rq-migrating tasks
for which a long-sleep test would make little sense anyway.

Plus move_queued_task() (e.g. from sched_exex()) would be covered as well.
