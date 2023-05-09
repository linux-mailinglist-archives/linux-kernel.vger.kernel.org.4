Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9A6FBD68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjEIC6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEIC6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02240F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683601063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m51J/7WAQ24Xh6a2T/ImLiEcpOzq4VFm8Si3E+i8UgE=;
        b=L6fGEExJNbB9VC3OxECItpUpbUV+rfLuQjxTKlZgUBOUinc/GHVTXccdBbZLegtCyg4ZYr
        akRrcgj1d1u0nS3iRN4X46z4ITvCC48AHmvmNlvqSwudsV0JSb6N7zTHp7Pp2mM/NF109s
        6C3jr/XVmdjxBr0LfZ0GjnwmGcv3V9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-fzSF-E1wNw-xNdW3t1P0iw-1; Mon, 08 May 2023 22:57:40 -0400
X-MC-Unique: fzSF-E1wNw-xNdW3t1P0iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30CCD101A531;
        Tue,  9 May 2023 02:57:40 +0000 (UTC)
Received: from [10.22.17.224] (unknown [10.22.17.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FCFD1121314;
        Tue,  9 May 2023 02:57:39 +0000 (UTC)
Message-ID: <3432de9e-6642-10c0-31e5-ac0ce65bea23@redhat.com>
Date:   Mon, 8 May 2023 22:57:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230508081532.36379-1-qiuxu.zhuo@intel.com>
 <29297e16-2c79-8367-cd6c-efedd0a8d9ed@redhat.com>
 <IA1PR11MB617102EB293516D2DC81F28089769@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <IA1PR11MB617102EB293516D2DC81F28089769@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/23 22:45, Zhuo, Qiuxu wrote:
> Hi Waiman,
>
> Thanks for your review of this patch.
> Please see the comments below.
>
>> From: Waiman Long <longman@redhat.com>
>> Sent: Monday, May 8, 2023 11:31 PM
>> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; Peter Zijlstra
>> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Will Deacon
>> <will@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
>> locked_pending bits
>>
>>
>> On 5/8/23 04:15, Qiuxu Zhuo wrote:
>>> The 1st spinner (header of the MCS queue) spins on the whole qspinlock
>>> variable to check whether the lock is released. For a contended
>>> qspinlock, this spinning is a hotspot as each CPU queued in the MCS
>>> queue performs the spinning when it becomes the 1st spinner (header of
>> the MCS queue).
>>> The granularity among SMT h/w threads in the same core could be "byte"
>>> which the Load-Store Unit (LSU) inside the core handles. Making the
>>> 1st spinner only spin on locked_pending bits (not the whole qspinlock)
>>> can avoid the false dependency between the tail field and the
>>> locked_pending field. So this micro-optimization helps the h/w thread
>>> (the 1st spinner) stay in a low power state and prevents it from being
>>> woken up by other h/w threads in the same core when they perform
>>> xchg_tail() to update the tail field. Please see a similar discussion in the link
>> [1].
>>> [1]
>>> https://lore.kernel.org/r/20230105021952.3090070-1-guoren@kernel.org
>>>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> ---
>>>    kernel/locking/qspinlock.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index efebbf19f887..e7b990b28610 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -513,7 +513,20 @@ void __lockfunc
>> queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>>    	if ((val = pv_wait_head_or_lock(lock, node)))
>>>    		goto locked;
>>>
>>> +#if _Q_PENDING_BITS == 8
>>> +	/*
>>> +	 * Spinning on the 2-byte locked_pending instead of the 4-byte
>> qspinlock
>>> +	 * variable can avoid the false dependency between the tail field and
>>> +	 * the locked_pending field. This helps the h/w thread (the 1st
>> spinner)
>>> +	 * stay in a low power state and prevents it from being woken up by
>> other
>>> +	 * h/w threads in the same core when they perform xchg_tail() to
>> update
>>> +	 * the tail field only.
>>> +	 */
>>> +	smp_cond_load_acquire(&lock->locked_pending, !VAL);
>>> +	val = atomic_read_acquire(&lock->val); #else
>>>    	val = atomic_cond_read_acquire(&lock->val, !(VAL &
>>> _Q_LOCKED_PENDING_MASK));
>>> +#endif
>>>
>>>    locked:
>>>    	/*
>> What hardware can benefit from this change? Do you have any micro-
>> benchmark that can show the performance benefit?
> i)  I don't have the hardware to measure the data.
>      But I run a benchmark [1] for the contended spinlock on an Intel Sapphire Rapids
>      server (192 h/w threads, 2sockets) that showed that the 1st spinner spinning was
>      a hotspot (contributed ~55% cache bouncing traffic measured by the perf C2C.
>       I don't analyze the cache bouncing here, but just say the spinning is a hotspot).
I believe the amount of cacheline bouncing will be the same whether you 
read 32 or 16 bits from the lock word. At least this is my understanding 
of the x86 arch. Please correct me if my assumption is incorrect.

>
> ii) The similar micro-optimization discussion [2] (looked like it was accepted by you 😉) that
>      avoiding the false dependency (between the tail field and the locked_pending field)
>      should help some arches (e.g., some ARM64???) the h/w thread (spinner) stay in a
>      low-power state without the disruption by its sibling h/w threads in the same core.

That is true. However, this patch causes one more read from the lock 
cacheline which isn't necessary for arches that won't benefit from it.  
So I am less incline to accept it unless there is evidence of the 
benefit it can bring.

Cheers,
Longman

