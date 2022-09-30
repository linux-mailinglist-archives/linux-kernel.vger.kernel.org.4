Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC35F021E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiI3BKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiI3BKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234F491FD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664500204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTknVwK5ijEGjivlMOJH3822T9jdH1X7jFH7qnaAiec=;
        b=CcQdX127DibUETcrFHFgsI3jytKFbz5YHc/bSQlwlnaHSwPrINEMIJA1zM67hf48ayt/Li
        io1MrM3HaI4Cvt/CHPRCbchK8s91BWUpaALnxo2i9rySiP+Z8Ih7qoTP6AOJ00CnuKih27
        P8lbsXA/kk30xqpbTV9WQBvjgCq2xMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-YtJTjvBxPoyhWgiBehkejA-1; Thu, 29 Sep 2022 21:10:00 -0400
X-MC-Unique: YtJTjvBxPoyhWgiBehkejA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FCEA8630C4;
        Fri, 30 Sep 2022 01:09:59 +0000 (UTC)
Received: from [10.22.16.9] (unknown [10.22.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA4A340C6EC2;
        Fri, 30 Sep 2022 01:09:58 +0000 (UTC)
Message-ID: <998fd708-df53-7141-182e-6cbc02cd7819@redhat.com>
Date:   Thu, 29 Sep 2022 21:09:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     John Donnelly <john.p.donnelly@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <f2778291-38a8-457f-d61e-0f9f7d401075@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <f2778291-38a8-457f-d61e-0f9f7d401075@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 17:15, John Donnelly wrote:
> On 9/29/22 13:04, Waiman Long wrote:
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
>>           return false;
>>       }
> Hi,.
>
> Are you missing
>
>
> [PATCH 5.18 87/88] locking/rwsem: Allow slowpath writer to ignore 
> handoff bit if not set by first waiter
>
>
>
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
> consistent")
>
> Or is this another regression ?
>
It is another regression which.

Cheers,
Longman

