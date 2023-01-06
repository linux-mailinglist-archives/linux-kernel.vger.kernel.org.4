Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A265FF8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjAFL2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjAFL2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:28:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A642126C0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:28:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1772A11FB;
        Fri,  6 Jan 2023 03:29:13 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9FE53F23F;
        Fri,  6 Jan 2023 03:28:27 -0800 (PST)
Message-ID: <1913041e-ee67-1e65-68fa-ef08b97ed9d5@arm.com>
Date:   Fri, 6 Jan 2023 12:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task
 check
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
 <Y7fdEruJGTux4fYH@chenyu5-mobl1>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Y7fdEruJGTux4fYH@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 09:34, Chen Yu wrote:
> Hi Dietmar,
> thanks for reviewing the patch!
> On 2023-01-05 at 12:33:16 +0100, Dietmar Eggemann wrote:
>> On 16/12/2022 07:11, Chen Yu wrote:
>>
>> [...]
>>
>>> @@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>  
>>>  static void set_next_buddy(struct sched_entity *se);
>>>  
>>> +static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
>>> +{
>>> +	u64 dur;
>>> +
>>> +	if (!task_sleep)
>>> +		return;
>>> +
>>> +	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
>>> +	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
>>
>> Shouldn't se->prev_sum_exec_runtime_vol be set in enqueue_task_fair()
>> and not in dequeue_task_fair()->dur_avg_update()? Otherwise `dur` will
>> contain sleep time.
>>
> After the task p is dequeued, p's sum_exec_runtime will not be increased.

True.

> Unless task p is switched in again, p's sum_exec_runtime will continue to
> increase. So dur should not include the sleep time, because we substract

Not sure I get this sentence? p's se->sum_exec_runtime will only
increase if p is current, so running?

> between the sum_exec_runtime rather than rq->clock_task. Not sure if I understand
> this correctly?

No, you're right. We're not dealing with time snapshots but rather with
sum_exec_runtime snapshots. So the value will not change between dequeue
and the next enqueue.

e ... enqueue_task_fair()
d ... dequeue_task_fair()
s ... set_next_entity()
p ... put_prev_entity()
u ... update_curr_fair()->update_curr()

p1:

---|---||--|--|---|--|--||---
   d   es  u  p   s  u  pd

   ^   ^
   |   |
  (A) (B)

Same se->prev_sum_exec_runtime_vol value in (A) and (B).

> My original thought was that, record the average run time of every section:
> Only consider that task voluntarily relinquishes the CPU.
> For example, suppose on CPU1, task p1 and p2 run alternatively:
> 
>  --------------------> time
> 
>  | p1 runs 1ms | p2 preempt p1 | p1 switch in, runs 0.5ms and blocks |
>                ^               ^                                     ^
>  |_____________|               |_____________________________________|
>                                                                      ^
>                                                                      |
>                                                                   p1 dequeued
> 
> p1's duration in one section is (1 + 0.5)ms. Because if p2 does not
> preempt p1, p1 can run 1.5ms. This reflects the nature of a task,
> how long it wishes to run at most.
> 
>> Like we do for se->prev_sum_exec_runtime in set_next_entity() but for
>> one `set_next_entity()-put_prev_entity()` run section.
>>
>> AFAICS, you want to measure the exec_runtime sum over all run sections
>> between enqueue and dequeue.
> Yes, we tried to record the 'decayed' average exec_runtime for each section.
> Say, task p runs for a ms , then p is dequeued and blocks for b ms, and then
> runs for c ms, its average duration is 0.875 * a + 0.125 * c , which is
> what update_avg() does.

OK.

