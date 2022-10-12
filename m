Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C537A5FC6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJLNnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:43:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E0CF840
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665582188; x=1697118188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FeNOVra0cl4W7hTzlgAF3UxoDuMIfhPlMvRJT86FU/M=;
  b=LYunV54sQYg1pROKEvtDcrxlTwe0csu42jBxv3jJy0O2x5aAsSE04SRf
   L1xXuL8RLvzIisotBqzdMEI33cvcSRiTPSXnuT0yGYT2CI8iszmFA9Ku+
   JC1wf+RN3y/Q/daoSKR2evdjAOuHGXWEqcGtqgT3F6MuwrZ4QbjmDdEX9
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Oct 2022 06:43:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 06:43:07 -0700
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 06:43:04 -0700
Message-ID: <edbb017b-2677-cd30-2091-ff347b00183d@quicinc.com>
Date:   Wed, 12 Oct 2022 19:12:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        <linux-mm@kvack.org>, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221012040410.403-1-hdanton@sina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221012040410.403-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2022 9:34 AM, Hillf Danton wrote:
> On 11 Oct 2022 18:46:20 +0530 Mukesh Ojha <quic_mojha@quicinc.com>
>> On 10/11/2022 4:16 PM, Hillf Danton wrote:
>>> On 10/10/22 06:24 Mukesh Ojha <quic_mojha@quicinc.com>
>>>> Hi Waiman,
>>>>
>>>> On 9/29/2022 11:36 PM, Waiman Long wrote:
>>>>> On 9/29/22 14:04, Waiman Long wrote:
>>>>>> A non-first waiter can potentially spin in the for loop of
>>>>>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>>>>> lock even if the rwsem is free if the following sequence happens:
>>>>>>
>>>>>>      Non-first waiter       First waiter      Lock holder
>>>>>>      ----------------       ------------      -----------
>>>>>>      Acquire wait_lock
>>>>>>      rwsem_try_write_lock():
>>>>>>        Set handoff bit if RT or
>>>>>>          wait too long
>>>>>>        Set waiter->handoff_set
>>>>>>      Release wait_lock
>>>>>>                             Acquire wait_lock
>>>>>>                             Inherit waiter->handoff_set
>>>>>>                             Release wait_lock
>>>>>>                          Clear owner
>>>>>>                                               Release lock
>>>>>>      if (waiter.handoff_set) {
>>>>>>        rwsem_spin_on_owner(();
>>>>>>        if (OWNER_NULL)
>>>>>>          goto trylock_again;
>>>>>>      }
>>>>>>      trylock_again:
>>>>>>      Acquire wait_lock
>>>>>>      rwsem_try_write_lock():
>>>>>>         if (first->handoff_set && (waiter != first))
>>>>>>             return false;
>>>>>>      Release wait_lock
>>>>>>
>>>>>> It is especially problematic if the non-first waiter is an RT task and
>>>>>> it is running on the same CPU as the first waiter as this can lead to
>>>>>> live lock.
>>>>>>
>>>>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>>>>>> consistent")
>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>> ---
>>>>>>     kernel/locking/rwsem.c | 13 ++++++++++---
>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> Mukesh, can you test if this patch can fix the RT task lockup problem?
>>>>>
>>>>
>>>> Looks like, There is still a window for a race.
>>>>
>>>> There is a chance when a reader who came first added it's BIAS and
>>>> goes to slowpath and before it gets added to wait list it got
>>>> preempted by RT task which  goes to slowpath as well and being the
>>>> first waiter gets its hand-off bit set and not able to get the lock
>>>> due to following condition in rwsem_try_write_lock()
>>
>> []
>>
>>>>
>>>>    630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has
>>>> sets its bias
>>>> ..
>>>> ...
>>>>
>>>>    634
>>>>    635                         new |= RWSEM_FLAG_HANDOFF;
>>>>    636                 } else {
>>>>    637                         new |= RWSEM_WRITER_LOCKED;
>>>>
>>>>
>>>> ---------------------->----------------------->-------------------------
>>>>
>>>> First reader (1)          writer(2) RT task             Lock holder(3)
>>>>
>>>> It sets
>>>> RWSEM_READER_BIAS.
>>>> while it is going to
>>>> slowpath(as the lock
>>>> was held by (3)) and
>>>> before it got added
>>>> to the waiters list
>>>> it got preempted
>>>> by (2).
>>>>                          RT task also takes
>>>>                           the slowpath and add              release the
>>>>                           itself into waiting list          rwsem lock
>>>>               and since it is the first         clear the
>>>>                           it is the next one to get         owner.
>>>>                           the lock but it can not
>>>>                           get the lock as (count &
>>>>                           RWSEM_LOCK_MASK) is set
>>>>                           as (1) has added it but
>>>>                           not able to remove its
>>>>               adjustment.
>>
>> []
>>
>>>>
>>> Hey Mukesh,
>>>
>>> Can you test the diff if it makes sense to you?
>>>
>>> It simply prevents the first waiter from spinning any longer after detecting
>>> it barely makes any progress to spin without lock owner.
>>>
>>> Hillf
>>>
>>> --- mainline/kernel/locking/rwsem.c
>>> +++ b/kernel/locking/rwsem.c
>>> @@ -611,26 +611,15 @@ static inline bool rwsem_try_write_lock(
>>>    	long count, new;
>>>    
>>>    	lockdep_assert_held(&sem->wait_lock);
>>> +	waiter->handoff_set = false;
>>>    
>>>    	count = atomic_long_read(&sem->count);
>>>    	do {
>>>    		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>>    
>>>    		if (has_handoff) {
>>> -			/*
>>> -			 * Honor handoff bit and yield only when the first
>>> -			 * waiter is the one that set it. Otherwisee, we
>>> -			 * still try to acquire the rwsem.
>>> -			 */
>>> -			if (first->handoff_set && (waiter != first))
>>> +			if (waiter != first)
>>>    				return false;
>>
>> you mean, you want to check and change waiter->handoff_set on every run
>> rwsem_try_write_lock().
>>
> Yes, with RWSEM_FLAG_HANDOFF set, it is too late for non first waiters to
> spin, and with both RWSEM_LOCK_MASK and RWSEM_FLAG_HANDOFF set, the rivals
> in the RWSEM_LOCK_MASK have an uphand over the first waiter wrt acquiring
> the lock, and it is not a bad option for the first waiter to take a step
> back off.
> 
> 		if (count & RWSEM_LOCK_MASK) {
> 			if (has_handoff || (!rt_task(waiter->task) &&
> 					    !time_after(jiffies, waiter->timeout)))
> 				return false;
> 
> 			new |= RWSEM_FLAG_HANDOFF;
> 		} else {
> 
>> But does it break optimistic spinning ? @waiman ?
> 
> Waiters spin for acquiring lock instead of lockup and your report shows
> spinning too much makes trouble. The key is stop spinning neither too
> late nor too early. My proposal is a simple one with as few heuristics
> added as possible.

 From the high level, it looks like it will work.
Let me check and get back on this.

-Mukesh
> 
> Hillf
