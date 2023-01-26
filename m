Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0220F67CB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjAZNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjAZNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436C65357
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674737962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNhHcxjgyh62v/F1s2FhI6OychXR4x7uiTrIn5u70QI=;
        b=bZtReVziYgW1lpDIXh/ZaVcrn7/u34GP2ktf0AZJBopN2hS2fteB8aC1KdxLJN8nOi1Ok8
        iAIyQX1KU06CLNNEyw/RkBwLkfEp9+usg2P8V+ZPXrON3Hu5nQ16xQyDBywWw7G+ESZvWE
        nD6Ni1cqofAeUZszlV8c8UmPpmIq8U0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-9U81uqILMHmBfyMlnGp7Pw-1; Thu, 26 Jan 2023 07:59:19 -0500
X-MC-Unique: 9U81uqILMHmBfyMlnGp7Pw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDE6A1C05AFF;
        Thu, 26 Jan 2023 12:59:18 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCE3492B01;
        Thu, 26 Jan 2023 12:59:18 +0000 (UTC)
Message-ID: <0911bd7f-2d8b-e925-2816-a0b5e01134b6@redhat.com>
Date:   Thu, 26 Jan 2023 07:59:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20230126003628.365092-1-longman@redhat.com>
 <20230126100441.4823-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230126100441.4823-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 05:04, Hillf Danton wrote:
> On Wed, 25 Jan 2023 19:36:28 -0500 Waiman Long <longman@redhat.com>
>>   
>>   static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
>>   {
>> -	unsigned long flags;
>>   	DEFINE_WAKE_Q(wake_q);
>> +	unsigned long flags;
>> +	unsigned long count;
>>   
>>   	raw_spin_lock_irqsave(&sem->wait_lock, flags);
>>   
>> -	if (!list_empty(&sem->wait_list))
>> -		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>> +	if (list_empty(&sem->wait_list))
>> +		goto unlock_out;
>> +
>> +	/*
>> +	 * If the rwsem is free and handoff flag is set with wait_lock held,
>> +	 * no other CPUs can take an active lock.
>> +	 */
>> +	count = atomic_long_read(&sem->count);
>> +	if (!(count & RWSEM_LOCK_MASK) && (count & RWSEM_FLAG_HANDOFF)) {
>> +		/*
>> +		 * Since rwsem_mark_wake() will handle the handoff to reader
>> +		 * properly, we don't need to do anything extra for reader.
>> +		 * Special handoff processing will only be needed for writer.
>> +		 */
>> +		struct rwsem_waiter *waiter = rwsem_first_waiter(sem);
>> +		long adj = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
>> +
>> +		if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
>> +			atomic_long_set(&sem->owner, (long)waiter->task);
>> +			atomic_long_add(adj, &sem->count);
>> +			wake_q_add(&wake_q, waiter->task);
>> +			rwsem_del_waiter(sem, waiter);
>> +			waiter->task = NULL;	/* Signal the handoff */
> Nit, once waiter is signaled, the address of waiter on stack could be destructed,
> so use smp_store_release() instead.

The subsequent raw_spin_unlock_irqrestore() already has the release 
semantics. That is why I used a regular store. Note that this is in a 
lock critical section. I would have used smp_store_release() outside of 
that.

Cheers,
Longman

>> +			goto unlock_out;
>> +		}
>> +	}
>> +	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>>   
>> +unlock_out:
>>   	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
>>   	wake_up_q(&wake_q);
>>   
>> -- 
>> 2.31.1

