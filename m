Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2E6031AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJRRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJRRh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAAD038B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666114645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEybKauCdgd6YIkHlr+iEVr5RqBpDho20JihxoHBxbM=;
        b=b6Won7Bs255GQMtjfiWKCb/YDW0p8rR0fDe3WkN0+YW86iI0F7LiNqbi5J4/CG3z4ljyJg
        zt+JnNfwlzLjushwzMmxEsiyXul+wqkF1jgvgO+ih4j1NxdLEoSmIUVk+4rweaYUzHHxCM
        C8LZyeTiEGzVh/BFfQDv+3YreCsnvEk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-iigGy_CVMZGj0kCAis02uA-1; Tue, 18 Oct 2022 13:37:22 -0400
X-MC-Unique: iigGy_CVMZGj0kCAis02uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DC783C02193;
        Tue, 18 Oct 2022 17:37:21 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBC251121315;
        Tue, 18 Oct 2022 17:37:20 +0000 (UTC)
Message-ID: <ef17f410-1cc2-7159-5e4c-f146a9e4aad1@redhat.com>
Date:   Tue, 18 Oct 2022 13:37:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 4/5] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221018111424.1007-1-hdanton@sina.com>
 <9b63611e-8d9a-529b-dcdc-05b10a8a712a@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <9b63611e-8d9a-529b-dcdc-05b10a8a712a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 10:13, Mukesh Ojha wrote:
> Hi,
>
> On 10/18/2022 4:44 PM, Hillf Danton wrote:
>> On 17 Oct 2022 17:13:55 -0400 Waiman Long <longman@redhat.com>
>>> @@ -1067,13 +1119,33 @@ rwsem_down_read_slowpath(struct rw_semaphore 
>>> *sem, long count, unsigned int stat
>>>               return sem;
>>>           }
>>>           adjustment += RWSEM_FLAG_WAITERS;
>>> +    } else if ((count & RWSEM_FLAG_HANDOFF) &&
>>> +          ((count & RWSEM_LOCK_MASK) == RWSEM_READER_BIAS)) {
>>
>> Could a couple of CPUs go read slow path in parallel?
This is under wait_lock protection. So no parallel execution is possible.
>>
>>> +        /*
>>> +         * If the waiter to be handed off is a reader, this reader
>>> +         * can piggyback on top of top of that.
>>> +         */
>>> +        if (rwsem_first_waiter(sem)->type == RWSEM_WAITING_FOR_READ)
>>> +            adjustment = 0;
>>> +        rwsem_handoff(sem, adjustment, &wake_q);
>>> +
>>> +        if (!adjustment) {
>>> +            raw_spin_unlock_irq(&sem->wait_lock);
>>> +            wake_up_q(&wake_q);
>>> +            return sem;
>>> +        }
>>> +        adjustment = 0;
>>>       }
>>>       rwsem_add_waiter(sem, &waiter);
>>
>> Why can this acquirer pigyback without becoming a waiter?
The idea is to have as much reader parallelism as possible without 
writer starvation. In other word, a continuous stream of readers is not 
allowed to block out writer. However, there are places where allow one 
more reader to get the lock won't cause writer starvation.
>>
>>>   -    /* we're now waiting on the lock, but no longer actively 
>>> locking */
>>> -    count = atomic_long_add_return(adjustment, &sem->count);
>>> -
>>> -    rwsem_cond_wake_waiter(sem, count, &wake_q);
>>> +    if (adjustment) {
>>> +        /*
>>> +         * We are now waiting on the lock with no handoff, but no
>>> +         * longer actively locking.
>>> +         */
>>> +        count = atomic_long_add_return(adjustment, &sem->count);
>>> +        rwsem_cond_wake_waiter(sem, count, &wake_q);
>>> +    }
>>>       raw_spin_unlock_irq(&sem->wait_lock);
>>>         if (!wake_q_empty(&wake_q))
>>> @@ -1120,7 +1192,6 @@ static struct rw_semaphore __sched *
>>>   rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>>   {
>>>       struct rwsem_waiter waiter;
>>> -    int null_owner_retries;
>>
>> This reverts 2/5 and feel free to drop it directly.
>
> I think, he intents to tag the first two patches to go to stable 
> branches.

This patch is too disruptive to go to the stable branches. Yes, I do 
intend the first 2 patches to go into stable branches.

Cheers,
Longman

