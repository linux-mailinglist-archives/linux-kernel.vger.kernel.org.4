Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439D56FBD44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEICbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEICbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80289EEB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683599445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/hIicPof1ds03Gxaw9pq69hx+KtN/AHhHGeF5Ck19M=;
        b=JVn4dfaEukx/gV9Ujk4EEEbxCucEoWv69xdsAyPzuWjn8aNbRKQ/dSUlda+7t3S0jUqP/2
        lGhesAQfRL9ze8Oll/H3riamqi9Q13VDxT4luKawN4PMSvgvdL6NL2qilsbUl41oInpI+a
        u/SsKcc0v4kOoOruLM+SQ2+I2MM02CA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-p7-hvP8NNc-sB33sOra8VA-1; Mon, 08 May 2023 22:30:40 -0400
X-MC-Unique: p7-hvP8NNc-sB33sOra8VA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096BA800047;
        Tue,  9 May 2023 02:30:40 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A875435453;
        Tue,  9 May 2023 02:30:39 +0000 (UTC)
Message-ID: <3e580bf2-2c76-739e-7636-4aa03f5628bd@redhat.com>
Date:   Mon, 8 May 2023 22:30:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
 <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
 <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 22:03, Zhuo, Qiuxu wrote:
> Hi Wainman,
>
> Thanks for your review. Please see the comments below.
>
>> From: Waiman Long <longman@redhat.com>
>> Sent: Monday, May 8, 2023 11:29 PM
>> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; Peter Zijlstra
>> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Will Deacon
>> <will@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
>> comments
>>
>>
>> On 5/6/23 02:29, Qiuxu Zhuo wrote:
>>> 1. There may be concurrent locker CPUs to set the qspinlock pending bit.
>>>
>>>      The first CPU (called pending CPU) of these CPUs sets the pending
>>>      bit to make the state transition (the qspinlock pending bit is set):
>>>
>>>            0,0,* -> 0,1,*
>>>
>>>      The rest of these CPUs are queued to the MCS queue to make the state
>>>      transition (the qspinlock tail is updated):
>>>
>>>            0,1,* -> *,1,*
>>>
>>>      The pending CPU waits until the locker owner goes away to make
>>>      the state transition (the qspinlock locked field is set to zero):
>>>
>>>            *,1,* -> *,1,0
>>>
>>>      The pending CPU takes the ownership and clears the pending bit
>>>      to make the state transition:
>>>
>>>            *,1,0 -> *,0,1
>>>
>>> 2. The header of the MCS queue takes the ownership and calls set_locked()
>>>      to make the state transition:
>>>
>>>            *,*,0 -> *,*,1
>> That is not true. The pending bit owner has priority over the MCS queue
>> head. So the pending bit must be 0 before the MCS queue head can take over
>> the lock. So
>>
>>       *,0,0 -> *,0,1
> Yes, the pending bit must be 0 before the header can take the lock.
> But as the statement "There may be concurrent locker CPUs to set the qspinlock pending bit " at
> the beginning. So just after the header takes over the lock, there is also a possible concurrent locker CPU
> to set the pending bit. That means at this time point here, the pending bit could be either 0 or 1.

OK, I am looking from the point of view of the CPU doing the transition. 
Otherwise, for an arch with very weak memory ordering, anything is 
possible. i.e. *,*,* -> *,*,* if we have to consider what all the CPUs 
in the system can see.


>
>>> Fix the state-transition changes above in the code comments accordingly.
>>>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> ---
>>>    kernel/locking/qspinlock.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index ebe6b8ec7cb3..efebbf19f887 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -257,7 +257,7 @@ static __always_inline u32
>> queued_fetch_set_pending_acquire(struct qspinlock *lo
>>>     * set_locked - Set the lock bit and own the lock
>>>     * @lock: Pointer to queued spinlock structure
>>>     *
>>> - * *,*,0 -> *,0,1
>>> + * *,*,0 -> *,*,1
>> set_locked() can only be called when it is sure that the pending bit isn't set.
>>>     */
>>>    static __always_inline void set_locked(struct qspinlock *lock)
>>>    {
>>> @@ -348,7 +348,7 @@ void __lockfunc queued_spin_lock_slowpath(struct
>> qspinlock *lock, u32 val)
>>>    	/*
>>>    	 * trylock || pending
>>>    	 *
>>> -	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
>>> +	 * 0,0,* -> 0,1,* -> ... -> *,0,1 pending, trylock
>> By the time trylock is done, there may be entries in the queue. However, I
>> doubt it helps by adding "..." in between possible multiple transitions.
>>
> The added "..." means there could be entries in the queue before trylock done.
> This is just for making the state transitions more complete ;-).
> If you think it doesn't help, I can remove it in the next version.

The transition flow does not show whether there is entry in the queue or 
not. It just shows the state of the lock word.


>
>>>    	 */
>>>    	val = queued_fetch_set_pending_acquire(lock);
>>>
>>> @@ -358,6 +358,8 @@ void __lockfunc queued_spin_lock_slowpath(struct
>> qspinlock *lock, u32 val)
>>>    	 * Undo and queue; our setting of PENDING might have made the
>>>    	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
>>>    	 * on @next to become !NULL.
>>> +	 *
>>> +	 * 0,1,* -> *,1,*
>> There is already a "n,0,0 -> 0,0,0" above, adding a new one may just
>> confuse people.
>>>    	 */
>>>    	if (unlikely(val & ~_Q_LOCKED_MASK)) {
>>>
>>> @@ -371,7 +373,7 @@ void __lockfunc queued_spin_lock_slowpath(struct
>> qspinlock *lock, u32 val)
>>>    	/*
>>>    	 * We're pending, wait for the owner to go away.
>>>    	 *
>>> -	 * 0,1,1 -> *,1,0
>>> +	 * *,1,* -> *,1,0
>> This refers to the wait loop. We don't need to wait if the owner has gone.
> But just before we wait for the locked field, the locked field could be
> either 0 (the locker can release the lock at any time) or 1.

Again, I take the viewpoint of the CPU doing the wait. It will only wait 
if it observes that the lock isn't free.


>
>>>    	 *
>>>    	 * this wait loop must be a load-acquire such that we match the
>>>    	 * store-release that clears the locked bit and create lock
>>> @@ -385,7 +387,7 @@ void __lockfunc queued_spin_lock_slowpath(struct
>> qspinlock *lock, u32 val)
>>>    	/*
>>>    	 * take ownership and clear the pending bit.
>>>    	 *
>>> -	 * 0,1,0 -> 0,0,1
>>> +	 * *,1,0 -> *,0,1
>> That is the part that we can make the change in the transition diagram
>> as noted.
> Sorry, I'm not clear about your request.
> Did you mean just make the change "*,1,0 -> *,0,1" above in the transition diagram or
> all the changes above in the transition diagram?

What I meant is that this particular change is correct AFAICS. Sorry for 
the confusion.

Cheers,
Longman

