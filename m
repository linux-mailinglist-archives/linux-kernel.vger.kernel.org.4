Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9E6DDBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDKNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDKNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:10:14 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C34691
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681218611;
        bh=F4WwQC4ssFxJtwjW/TnXAnGUbfZVX9MmC9hHRnJil/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gPXDLOW2v+xI5Io3c1VmebBRotqPAv9B6jeMs+h8Bdjcz+BSTkqp76NU1NAi/hDDZ
         hkhHdjmMdERL8/gv7T7uMh9N7gfrD6Mx/6QVULxDKrjSzLKANQEpIFulHRwvKmvdRb
         xYrF0sYjkuKp+5TH9+6VLbdk7/OmclTkKaDCpG7uocU8Qv9zgz8aSh1m0RwGrPUS50
         1tSYcPXY03xj5f9uZT7jDILXO2nqMYgkWnvHj/R3D/Fbi+84oWRFcGk/NPOd2zT/uV
         vEzfhcvwXE3o3wGDEPPgDhjbBUxbGoj1iy57HMm8a++UL02ghu4jHLLLTjS5VBm4Ql
         8I7L9kP1SRzYg==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PwmR65HddzvR0;
        Tue, 11 Apr 2023 09:10:10 -0400 (EDT)
Message-ID: <d97b567d-a86b-c180-a019-f66962c4a6ac@efficios.com>
Date:   Tue, 11 Apr 2023 09:10:10 -0400
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
 <20230411102532.GA580235@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230411102532.GA580235@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 06:25, Peter Zijlstra wrote:
> On Tue, Apr 11, 2023 at 11:37:05AM +0200, Peter Zijlstra wrote:
>> On Fri, Apr 07, 2023 at 09:14:36PM -0400, Mathieu Desnoyers wrote:
>>
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index bc0e1cd0d6ac..f3e7dc2cd1cc 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -3354,6 +3354,37 @@ static inline int mm_cid_get(struct mm_struct *mm)
>>>   static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
>>>   {
>>> +	/*
>>> +	 * Provide a memory barrier between rq->curr store and load of
>>> +	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
>>> +	 *
>>> +	 * Should be adapted if context_switch() is modified.
>>> +	 */
>>> +	if (!next->mm) {                                // to kernel
>>> +		/*
>>> +		 * user -> kernel transition does not guarantee a barrier, but
>>> +		 * we can use the fact that it performs an atomic operation in
>>> +		 * mmgrab().
>>> +		 */
>>> +		if (prev->mm)                           // from user
>>> +			smp_mb__after_mmgrab();
>>> +		/*
>>> +		 * kernel -> kernel transition does not change rq->curr->mm
>>> +		 * state. It stays NULL.
>>> +		 */
>>> +	} else {                                        // to user
>>> +		/*
>>> +		 * kernel -> user transition does not provide a barrier
>>> +		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
>>> +		 * Provide it here.
>>> +		 */
>>> +		if (!prev->mm)                          // from kernel
>>> +			smp_mb();
>>> +		/*
>>> +		 * user -> user transition guarantees a memory barrier through
>>> +		 * switch_mm().
>>> +		 */
>>
>> What about the user->user case where next->mm == prev->mm ? There
>> sys_membarrier() relies on finish_task_switch()'s mmdrop(), but we
>> can't.
> 
> Ah, I suppose that's either a N->N or Y->Y transition and we don't care.
> 
> Not the clearest comment though.

For sake of completeness, here is the updated comment:



                 /*
                  * user -> user transition guarantees a memory barrier through
                  * switch_mm() when current->mm changes. If current->mm is
                  * unchanged, no barrier is needed.
                  */

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

