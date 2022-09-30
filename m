Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE025F0CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiI3N5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3N5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0A15C1C6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664546239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4F18ec+W3hmQ/hgQx7kLoFS28nqhE71/eik/yFzZuI=;
        b=guEZd6lYzxPGrOMAo/REwXIJfD322F2QuBEXAzNLyqxcix1Dh6LPonjHIwtgTkcWoyfixq
        TbU1/FXu3b6qCFfuUmLoTszwtdr6VyG9BHU46m7QqTODGq29M6RfFJsRt6vVZwQuvAOnNI
        6TlrxZjnril6yhqcXjsrmK2VsX4KWV8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-C1mSi-ThOFGqNJ3_kepP1g-1; Fri, 30 Sep 2022 09:57:16 -0400
X-MC-Unique: C1mSi-ThOFGqNJ3_kepP1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3677C38012CE;
        Fri, 30 Sep 2022 13:57:16 +0000 (UTC)
Received: from [10.22.32.213] (unknown [10.22.32.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E12FC15BA4;
        Fri, 30 Sep 2022 13:57:15 +0000 (UTC)
Message-ID: <68a994ae-caaf-a68a-c2b7-fc69baed57bb@redhat.com>
Date:   Fri, 30 Sep 2022 09:57:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <0e0a6a29-1b2a-ff86-123d-1f6da272879c@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <0e0a6a29-1b2a-ff86-123d-1f6da272879c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 00:46, Mukesh Ojha wrote:
> Hi,
>
> Thanks for looking into this issue.
>
> On 9/29/2022 11:34 PM, Waiman Long wrote:
>> A non-first waiter can potentially spin in the for loop of
>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>> lock even if the rwsem is free if the following sequence happens:
>>
>>    Non-first waiter       First waiter      Lock holder
>>    ----------------       ------------      -----------
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>      Set handoff bit if RT or
>>        wait too long
>>      Set waiter->handoff_set
>>    Release wait_lock
>>                           Acquire wait_lock
>>                           Inherit waiter->handoff_set
>>                           Release wait_lock
>>                        Clear owner
>>                                             Release lock
>>    if (waiter.handoff_set) {
>>      rwsem_spin_on_owner(();
>>      if (OWNER_NULL)
>>        goto trylock_again;
>>    }
>>    trylock_again:
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>       if (first->handoff_set && (waiter != first))
>>           return false;
>>    Release wait_lock
>>
>> It is especially problematic if the non-first waiter is an RT task and
>> it is running on the same CPU as the first waiter as this can lead to
>> live lock.
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>> consistent")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/locking/rwsem.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 65f0262f635e..ad676e99e0b3 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct 
>> rw_semaphore *sem,
>>           new = count;
>>             if (count & RWSEM_LOCK_MASK) {
>> +            /*
>> +             * A waiter (first or not) can set the handoff bit
>> +             * if it is an RT task or wait in the wait queue
>> +             * for too long.
>> +             */
>>               if (has_handoff || (!rt_task(waiter->task) &&
>>                           !time_after(jiffies, waiter->timeout)))
>>                   return false;
>> @@ -643,11 +648,13 @@ static inline bool rwsem_try_write_lock(struct 
>> rw_semaphore *sem,
>>       } while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, 
>> new));
>>         /*
>> -     * We have either acquired the lock with handoff bit cleared or
>> -     * set the handoff bit.
>> +     * We have either acquired the lock with handoff bit cleared or set
>> +     * the handoff bit. Only the first waiter can have its handoff_set
>> +     * set here to enable optimistic spinning in slowpath loop.
>>        */
>>       if (new & RWSEM_FLAG_HANDOFF) {
>> -        waiter->handoff_set = true;
>> +        if (waiter == first)
>> +            waiter->handoff_set = true;
>>           lockevent_inc(rwsem_wlock_handoff);
>
> nit: Should this not get incremented on waiter->handoff_set=true only ?

The lock event counter records the # of time a handoff bit is set. It is 
not related to how the handoff_set in the waiter structure is being set.

cheers,
Longman

