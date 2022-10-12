Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761CD5FC631
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJLNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E87E0E1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665580608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1SlhP8YtCDLXQxqiYxHrawoN/1E0Lo/8a/OQeBjWs8=;
        b=QyTmGotBuw4hXOdUDwGIdLUMIx9oqxWkrRHZV2c8zz6wGdsmpccxWevG4HIxo23ucZOfnJ
        G9PYP70/tYTSTRoofpoHqjXDI/P7uFFUQNPRCPvpXUAJdNdn4BWaCi3PeYFZeQ+/fz2Mtu
        blnjNtaNi5d2Aga5PTxoQJ//Y1Nk44Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-CeUP5aDlOrCUhp0CWW6c4w-1; Wed, 12 Oct 2022 09:16:47 -0400
X-MC-Unique: CeUP5aDlOrCUhp0CWW6c4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EDBC811E84;
        Wed, 12 Oct 2022 13:16:46 +0000 (UTC)
Received: from [10.22.33.120] (unknown [10.22.33.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E311F4EA5F;
        Wed, 12 Oct 2022 13:16:45 +0000 (UTC)
Message-ID: <41871fa1-897d-c43e-671b-1ad927c0b9da@redhat.com>
Date:   Wed, 12 Oct 2022 09:16:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221011104621.231-1-hdanton@sina.com>
 <3967aca6-3403-655d-d8eb-34312c2bb1b9@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3967aca6-3403-655d-d8eb-34312c2bb1b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 09:16, Mukesh Ojha wrote:
> Hi @Hilf,
>
> Thanks for looking into this issue.
>
> On 10/11/2022 4:16 PM, Hillf Danton wrote:
>> On 10/10/22 06:24 Mukesh Ojha <quic_mojha@quicinc.com>
>>> Hi Waiman,
>>>
>>> On 9/29/2022 11:36 PM, Waiman Long wrote:
>>>> On 9/29/22 14:04, Waiman Long wrote:
>>>>> A non-first waiter can potentially spin in the for loop of
>>>>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>>>> lock even if the rwsem is free if the following sequence happens:
>>>>>
>>>>>     Non-first waiter       First waiter      Lock holder
>>>>>     ----------------       ------------      -----------
>>>>>     Acquire wait_lock
>>>>>     rwsem_try_write_lock():
>>>>>       Set handoff bit if RT or
>>>>>         wait too long
>>>>>       Set waiter->handoff_set
>>>>>     Release wait_lock
>>>>>                            Acquire wait_lock
>>>>>                            Inherit waiter->handoff_set
>>>>>                            Release wait_lock
>>>>>                         Clear owner
>>>>>                                              Release lock
>>>>>     if (waiter.handoff_set) {
>>>>>       rwsem_spin_on_owner(();
>>>>>       if (OWNER_NULL)
>>>>>         goto trylock_again;
>>>>>     }
>>>>>     trylock_again:
>>>>>     Acquire wait_lock
>>>>>     rwsem_try_write_lock():
>>>>>        if (first->handoff_set && (waiter != first))
>>>>>            return false;
>>>>>     Release wait_lock
>>>>>
>>>>> It is especially problematic if the non-first waiter is an RT task 
>>>>> and
>>>>> it is running on the same CPU as the first waiter as this can lead to
>>>>> live lock.
>>>>>
>>>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>>>>> consistent")
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>    kernel/locking/rwsem.c | 13 ++++++++++---
>>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> Mukesh, can you test if this patch can fix the RT task lockup problem?
>>>>
>>>
>>> Looks like, There is still a window for a race.
>>>
>>> There is a chance when a reader who came first added it's BIAS and
>>> goes to slowpath and before it gets added to wait list it got
>>> preempted by RT task which  goes to slowpath as well and being the
>>> first waiter gets its hand-off bit set and not able to get the lock
>>> due to following condition in rwsem_try_write_lock()
>
> []
>
>>>
>>>   630                 if (count & RWSEM_LOCK_MASK) { ==> reader has
>>> sets its bias
>>> ..
>>> ...
>>>
>>>   634
>>>   635                         new |= RWSEM_FLAG_HANDOFF;
>>>   636                 } else {
>>>   637                         new |= RWSEM_WRITER_LOCKED;
>>>
>>>
>>> ---------------------->----------------------->------------------------- 
>>>
>>>
>>> First reader (1)          writer(2) RT task             Lock holder(3)
>>>
>>> It sets
>>> RWSEM_READER_BIAS.
>>> while it is going to
>>> slowpath(as the lock
>>> was held by (3)) and
>>> before it got added
>>> to the waiters list
>>> it got preempted
>>> by (2).
>>>                         RT task also takes
>>>                          the slowpath and add release the
>>>                          itself into waiting list rwsem lock
>>>              and since it is the first         clear the
>>>                          it is the next one to get owner.
>>>                          the lock but it can not
>>>                          get the lock as (count &
>>>                          RWSEM_LOCK_MASK) is set
>>>                          as (1) has added it but
>>>                          not able to remove its
>>>              adjustment.
>
> []
>
>>>
>> Hey Mukesh,
>>
>> Can you test the diff if it makes sense to you?
>>
>> It simply prevents the first waiter from spinning any longer after 
>> detecting
>> it barely makes any progress to spin without lock owner.
>>
>> Hillf
>>
>> --- mainline/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -611,26 +611,15 @@ static inline bool rwsem_try_write_lock(
>>       long count, new;
>>         lockdep_assert_held(&sem->wait_lock);
>> +    waiter->handoff_set = false;
>>         count = atomic_long_read(&sem->count);
>>       do {
>>           bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>             if (has_handoff) {
>> -            /*
>> -             * Honor handoff bit and yield only when the first
>> -             * waiter is the one that set it. Otherwisee, we
>> -             * still try to acquire the rwsem.
>> -             */
>> -            if (first->handoff_set && (waiter != first))
>> +            if (waiter != first)
>>                   return false;
>
> you mean, you want to check and change waiter->handoff_set on every 
> run rwsem_try_write_lock().
>
> But does it break optimistic spinning ? @waiman ?
>
As I said in my previous mail, this is equivalent to allow only one 
optimistic spinning attempt after setting the handoff bit. That will 
likely reduce the performance benefit provided by this feature.

Cheers,
Longman

