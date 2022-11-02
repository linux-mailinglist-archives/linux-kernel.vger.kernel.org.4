Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA0615C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKBGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKBGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:40:42 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166C26AE1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:40:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VTmPlCm_1667371236;
Received: from 30.97.48.210(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VTmPlCm_1667371236)
          by smtp.aliyun-inc.com;
          Wed, 02 Nov 2022 14:40:38 +0800
Message-ID: <9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com>
Date:   Wed, 2 Nov 2022 14:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched: Clear ttwu_pending after enqueue_task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>
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
 <Y2EkXYqZ15/Kjl6H@chenyu5-mobl1>
 <Y2E0TeFJorjOXikX@hirez.programming.kicks-ass.net>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <Y2E0TeFJorjOXikX@hirez.programming.kicks-ass.net>
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

On 2022/11/1 22:59, Peter Zijlstra wrote:
> On Tue, Nov 01, 2022 at 09:51:25PM +0800, Chen Yu wrote:
> 
>>> Could you try the below instead? Also note the comment; since you did
>>> the work to figure out why -- best record that for posterity.
>>>
>>> @@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
>>>   			set_task_cpu(p, cpu_of(rq));
>>>   
>>>   		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
>>> +		/*
>>> +		 * Must be after enqueueing at least once task such that
>>> +		 * idle_cpu() does not observe a false-negative -- if it does,
>>> +		 * it is possible for select_idle_siblings() to stack a number
>>> +		 * of tasks on this CPU during that window.
>>> +		 */
>>> +		WRITE_ONCE(rq->ttwu_pending, 0);
>> Just curious why do we put above code inside llist_for_each_entry_safe loop?
> 
>> My understanding is that once 1 task is queued, select_idle_cpu() would not
>> treat this rq as idle anymore because nr_running is not 0. But would this bring
>> overhead to write the rq->ttwu_pending multiple times, do I miss something?
> 
> So the consideration is that by clearing it late, you might also clear a
> next set; consider something like:
> 
> 
> 	cpu0			cpu1			cpu2
> 
> 	ttwu_queue()
> 	  ->ttwu_pending = 1;
> 	  llist_add()
> 
> 				sched_ttwu_pending()
> 				  llist_del_all()
> 				  ... long ...
> 							ttwu_queue()
> 							  ->ttwu_pending = 1
> 							  llist_add()
> 
> 				  ... time ...
> 				  ->ttwu_pending = 0
> 
> Which leaves you with a non-empty list but with ttwu_pending == 0.
> 
> But I suppose that's not actually better with my variant, since it keeps
> writing 0s. We can make it more complicated again, but perhaps it
> doesn't matter and your version is good enough.
> 

Yeah. Since your version repeats writting 0 to ttwu_pending, it finally reaches 
the same effect with mine. Although the performance results in my tests seem to 
be no difference, it may still bring more overhead.

IMO, according to the latest linux-next code, all callers querying 
rq->ttwu_pending only take cares about whether the cpu is idle because they 
always combine with querying nr_running. Actually no one cares about whether 
wake_entry.llist is empty. So for the use of checking cpu idle state, move 
rq->ttwu_pending=0 after enqueuing task can help fully cover the whole state.

For your case, although ttwu_pending is set to 0 with some tasks really pending, 
at this time nr_running is sure to be >0, so callers who query both ttwu_pending 
and nr_running will know this cpu is not idle.
(Now the callers querying these two values are lockless, so there may be race in 
a really small window? But this case is extremely rare, I think we should not 
make it more complicated.)

> But please update with a comment on why it needs to be after
> ttwu_do_activate().

OK. Should I send v2 or you directly add the comment?

Thanks.

