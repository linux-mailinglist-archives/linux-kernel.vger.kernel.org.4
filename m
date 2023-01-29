Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D021367FC14
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjA2B1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjA2B1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:27:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03FF21A17
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:27:09 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P4DBt1Swpz16Mgj;
        Sun, 29 Jan 2023 09:25:10 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 09:27:07 +0800
Message-ID: <8a2e400f-868c-1d98-3c9b-de2e0d41f55c@huawei.com>
Date:   Sun, 29 Jan 2023 09:27:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
To:     Chen Yu <yu.c.chen@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Roman Kagan <rkagan@amazon.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230127163230.3339408-1-rkagan@amazon.de>
 <Y9Va5HJgEDteceg3@chenyu5-mobl1>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Y9Va5HJgEDteceg3@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chenyu,

在 2023/1/29 1:27, Chen Yu 写道:
> Hi Roman, Qiao,
> On 2023-01-27 at 17:32:30 +0100, Roman Kagan wrote:
>> From: Zhang Qiao <zhangqiao22@huawei.com>
>>
>> When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
>> to the base level (around cfs_rq->min_vruntime), so that the entity
>> doesn't gain extra boost when placed backwards.
>>
>> However, if the entity being placed wasn't executed for a long time, its
>> vruntime may get too far behind (e.g. while cfs_rq was executing a
>> low-weight hog), which can inverse the vruntime comparison due to s64
>> overflow.  This results in the entity being placed with its original
>> vruntime way forwards, so that it will effectively never get to the cpu.
>>
> Looks interesting,
> case 1:
>   se->vruntime = 1, cfs_rq->min_vruntime = ULONG_MAX
>   ==> max = 1
> case 2:
>   se->vruntime = 1, cfs_rq->min_vruntime = LONG_MAX
>   ==> max = LONG_MAX
> 
> May I know if the issue you described above is in case 1? We want
> the max to be ULONG_MAX but it returns 1 because of s64
> comparison? Then max = 1 is incorrectly used as se's vruntime?
> Could you please elaborate a little more about this issue?

Yes, the issue is in case 1.

For more detailed discussion, can see https://lkml.org/lkml/2022/12/21/435.

>> To prevent that, ignore the vruntime of the entity being placed if it
>> didn't execute for much longer than the characteristic sheduler time
>> scale.
>>
>> [rkagan: formatted, adjusted commit log, comments, cutoff value]
>> Co-developed-by: Roman Kagan <rkagan@amazon.de>
>> Signed-off-by: Roman Kagan <rkagan@amazon.de>
>> ---
>> @zhangqiao22, I took the liberty to put you as the author of the patch,
>> as this is essentially what you posted for discussion, with minor
>> tweaks.  Please stamp with your s-o-b if you're ok with it.
>>
>>  kernel/sched/fair.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0f8736991427..d6cf131ebb0b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4656,6 +4656,7 @@ static void
>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>  {
>>  	u64 vruntime = cfs_rq->min_vruntime;
>> +	u64 sleep_time;
>>  
>>  	/*
>>  	 * The 'current' period is already promised to the current tasks,
>> @@ -4685,8 +4686,18 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>>  		vruntime -= thresh;
>>  	}
>>  
>> -	/* ensure we never gain time by being placed backwards. */
>> -	se->vruntime = max_vruntime(se->vruntime, vruntime);
>> +	/*
>> +	 * Pull vruntime of the entity being placed to the base level of
>> +	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
>> +	 * slept for a long time, don't even try to compare its vruntime with
>> +	 * the base as it may be too far off and the comparison may get
>> +	 * inversed due to s64 overflow.
>> +	 */
>> +	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> If I understand correctly, se->exec_start is just updated by enqueue_entity()->update_curr(cfs_rq),

When a task go to sleep, se->exec_start will update at dequeue_entity()->update_curr(cfs_rq).
And enqueue_entity()->update_curr(cfs_rq) just update current se.

Thank,
Qiao.

> then place_entity() in invoked here, I'm not sure if sleep_time above
> could reflect the real sleep time. Maybe something like:
> rq_clock_task(rq_of(cfs_rq)) - se->time_stamp_dequeued ?
> 
> thanks,
> Chenyu
> .
> 
