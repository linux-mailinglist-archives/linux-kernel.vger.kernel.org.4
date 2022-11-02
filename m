Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43A615C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKBGki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:40:35 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F425EAE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:40:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VTmeN2I_1667371229;
Received: from 30.97.48.210(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VTmeN2I_1667371229)
          by smtp.aliyun-inc.com;
          Wed, 02 Nov 2022 14:40:30 +0800
Message-ID: <84750ddd-43cf-a439-fb3e-2b047ffe1cfc@linux.alibaba.com>
Date:   Wed, 2 Nov 2022 14:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched: Clear ttwu_pending after enqueue_task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/1 18:34, Peter Zijlstra wrote:
> On Tue, Nov 01, 2022 at 03:36:30PM +0800, Tianchen Ding wrote:
>> We found a long tail latency in schbench whem m*t is close to nr_cpus.
>> (e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)
>>
>> This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
>> too early, and idle_cpu() will return true until the wakee task enqueued.
>> This will mislead the waker when selecting idle cpu, and wake multiple
>> worker threads on the same wakee cpu. This situation is enlarged by
>> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
>> wakelist if wakee cpu is idle") because it tends to use wakelist.
>>
>> Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
>> (Intel(R) Xeon(R) Platinum 8369B).
>>
>> Latency percentiles (usec):
>>                  base      base+revert_f3dd3f674555   base+this_patch
>> 50.0000th:         9                            13                 9
>> 75.0000th:        12                            19                12
>> 90.0000th:        15                            22                15
>> 95.0000th:        18                            24                17
>> *99.0000th:       27                            31                24
>> 99.5000th:      3364                            33                27
>> 99.9000th:     12560                            36                30
> 
> Nice; but have you also ran other benchmarks and confirmed it doesn't
> negatively affect those?
> 
> If so; mentioning that is very helpful. If not; best go do so :-)
> 

Thanks for the review.

We've tested with unixbench and hackbench (they show the average scores), and 
the performance result seems no difference.
We don't mention here because what we found is a specific case in schbench 
(where m*t==nr_cpus). It only affect long tail latency, so the problem and the 
fix should also take effects on only this case, not the average scores.

>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> ---
>>   kernel/sched/core.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 87c9cdf37a26..b07de1753be5 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
>>   	if (!llist)
>>   		return;
>>   
>> -	/*
>> -	 * rq::ttwu_pending racy indication of out-standing wakeups.
>> -	 * Races such that false-negatives are possible, since they
>> -	 * are shorter lived that false-positives would be.
>> -	 */
>> -	WRITE_ONCE(rq->ttwu_pending, 0);
>> -
>>   	rq_lock_irqsave(rq, &rf);
>>   	update_rq_clock(rq);
>>   
> 
> Could you try the below instead? Also note the comment; since you did
> the work to figure out why -- best record that for posterity.
> 

It works well for me. But I have the same thought with Chen Yu, and will explain 
in detail in my next reply.

Thanks.

> @@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
>   			set_task_cpu(p, cpu_of(rq));
>   
>   		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> +		/*
> +		 * Must be after enqueueing at least once task such that
> +		 * idle_cpu() does not observe a false-negative -- if it does,
> +		 * it is possible for select_idle_siblings() to stack a number
> +		 * of tasks on this CPU during that window.
> +		 */
> +		WRITE_ONCE(rq->ttwu_pending, 0);
>   	}
>   
>   	rq_unlock_irqrestore(rq, &rf);

