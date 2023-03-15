Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7D6BAD57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjCOKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjCOKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:16:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802232A6E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:15:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0342F4;
        Wed, 15 Mar 2023 03:15:55 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8BC3F67D;
        Wed, 15 Mar 2023 03:15:10 -0700 (PDT)
Message-ID: <5527ad0e-0f6d-fb4c-7505-a1c80192ed3b@arm.com>
Date:   Wed, 15 Mar 2023 11:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, rkagan@amazon.de
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
 <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
 <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
 <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
 <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 09:42, Vincent Guittot wrote:
> On Wed, 15 Mar 2023 at 08:18, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
>>>
>>>>> @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>>>>          * min_vruntime -- the latter is done by enqueue_entity() when placing
>>>>>          * the task on the new runqueue.
>>>>>          */
>>>>> -       if (READ_ONCE(p->__state) == TASK_WAKING) {
>>>>> -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>>> -
>>>>> +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
>>>>
>>>> That's somehow what was proposed in one of the previous proposals but
>>>> we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
>>>> be hold and rq task clock has not been updated before being used
>>>
>>> Argh indeed. I spend a lot of time ensuring we didn't take the old rq
>>> lock on wakeup -- and then a lot of time cursing about how we don't :-)
>>>
>>> Now, if we could rely on the rq-clock being no more than 1 tick behind
>>> current, this would still be entirely sufficient to catch the long sleep
>>> case.
>>
>> We should also take care when loading rq_clock_task that we are not
>> racing with an update especially for a 32bits system like pelt
>> last_update_time
> 
> We still have this possibility:
> https://lore.kernel.org/lkml/ZAiFxWLSb9HDazSI@vingu-book/
> 
> which uses pelt last_update_time when migrating and keep using
> rq_clock_task in place_entity

Isn't there an issue with this approach on asymmetric CPU capacity systems?

We do a sync_entity_load_avg() in select_task_rq_fair()
(find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
to sync cfs_rq and se.

[...]

