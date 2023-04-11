Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDE6DDB51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDKM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDKM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:57:22 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4812D6B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681217840;
        bh=R71Ny685Hr5M27HLajWR2rPefiJ5qNShyDh+8hV4kK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=paEQMBoAbiBqIQyZd2N9rq21cS8YS+VbznxaUyIjYzsMeGMmdvCV/olwPvZ8/244e
         DGZ26BsHqODCF2H3v7nFgprxHij47z81o/QeT5iqXHI6dcocugQhZNx9S1bSpqzmOs
         8oQlyrbb2pidLy33/56DYFXeZhrPfY4+HIMzBxW6BPYg8gVkJIPe78AQ0XzkaQ0c49
         atF2TMr76/KBFMa0LVy0e/bPMIZkSQ8v9K5/F7kMHTdUMQ8m40AAaVSvCmHbMcNxCz
         iGy+rzmWF5S/z5CMdUhNIxoHi5Jr9O2jdCueZkRdTgniC/CwPJLl98RX+jE16PBpI+
         HuWH8U763MX7w==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pwm8J3ZKGzvcq;
        Tue, 11 Apr 2023 08:57:20 -0400 (EDT)
Message-ID: <f96978d0-ae96-0b4e-042f-531d17cb217e@efficios.com>
Date:   Tue, 11 Apr 2023 08:57:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
 <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
 <20230411093705.GB578657@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230411093705.GB578657@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 05:37, Peter Zijlstra wrote:
> On Fri, Apr 07, 2023 at 09:14:36PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index bc0e1cd0d6ac..f3e7dc2cd1cc 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3354,6 +3354,37 @@ static inline int mm_cid_get(struct mm_struct *mm)
>>   static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
>>   {
>> +	/*
>> +	 * Provide a memory barrier between rq->curr store and load of
>> +	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
>> +	 *
>> +	 * Should be adapted if context_switch() is modified.
>> +	 */
>> +	if (!next->mm) {                                // to kernel
>> +		/*
>> +		 * user -> kernel transition does not guarantee a barrier, but
>> +		 * we can use the fact that it performs an atomic operation in
>> +		 * mmgrab().
>> +		 */
>> +		if (prev->mm)                           // from user
>> +			smp_mb__after_mmgrab();
>> +		/*
>> +		 * kernel -> kernel transition does not change rq->curr->mm
>> +		 * state. It stays NULL.
>> +		 */
>> +	} else {                                        // to user
>> +		/*
>> +		 * kernel -> user transition does not provide a barrier
>> +		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
>> +		 * Provide it here.
>> +		 */
>> +		if (!prev->mm)                          // from kernel
>> +			smp_mb();
>> +		/*
>> +		 * user -> user transition guarantees a memory barrier through
>> +		 * switch_mm().
>> +		 */
> 
> What about the user->user case where next->mm == prev->mm ? There
> sys_membarrier() relies on finish_task_switch()'s mmdrop(), but we
> can't.

AFAIU the finish_task_switch()'s mmdrop() is for the case where:

                  * [...] or in
                  * case 'prev->active_mm == next->mm' through
                  * finish_task_switch()'s mmdrop().

which applies for the case where we schedule from a kernel thread (which
kept the prior user task's mm as active mm) to a user task with the same
mm.

But this is really a transition from kernel -> user, not user -> user ?

Why should either membarrier or mm_cid care about a transition from
prev->mm to next->mm where mm is unchanged ? It does not register
as a transition from the comparison perspective.

I'll update my comment in switch_mm_cid to:

      /*
       * user -> user transition guarantees a memory barrier through
       * switch_mm() when current->mm changes. If current->mm is
       * unchanged, no barrier is needed.
       */

Thanks,

Mathieu


> 
>> +	}
>>   	if (prev->mm_cid_active) {
>>   		mm_cid_put_lazy(prev);
>>   		prev->mm_cid = -1;
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

