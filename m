Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5784F6A3440
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBZVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZVcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 16:32:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7817E136E9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 13:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677447078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JTLPK52vR8NMYckhklXr1mFkJBN6aWpVD5URwhBTL0=;
        b=i+WuzEDW20SMU7Ov7VNhswnC7J/01ZP6m5mSD7xW33+vWioY0B/LbwE3h5qV5Wwna7QHrV
        9wzGLDLB5j/gExg8J3ch10CwWm8ma/8bXvZEalbw0fpWpa7T2Be7ktOVwm87EeLsmFQboM
        /oX1oeS42icZXJFDlmRU8swiqoVyu8g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-tCXx9y5NNvCa5Qm4rIK4yw-1; Sun, 26 Feb 2023 16:31:16 -0500
X-MC-Unique: tCXx9y5NNvCa5Qm4rIK4yw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDE513801F4E;
        Sun, 26 Feb 2023 21:31:15 +0000 (UTC)
Received: from [10.22.32.65] (unknown [10.22.32.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD54C404BEC0;
        Sun, 26 Feb 2023 21:31:15 +0000 (UTC)
Message-ID: <1147abb3-fb72-dd63-8e32-25ff8000972e@redhat.com>
Date:   Sun, 26 Feb 2023 16:31:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
 <Y/tJ2n1e22YhsZ17@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y/tJ2n1e22YhsZ17@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 07:00, Peter Zijlstra wrote:
> On Thu, Feb 23, 2023 at 04:38:08PM -0500, Waiman Long wrote:
>
>>> @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
>>>    	} else {
>>>    		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
>>>    	}
>>> +	raw_spin_unlock_irq(&sem->wait_lock);
>>>    	/* wait until we successfully acquire the lock */
>>> -	set_current_state(state);
>>>    	trace_contention_begin(sem, LCB_F_WRITE);
>>>    	for (;;) {
>>> -		if (rwsem_try_write_lock(sem, &waiter)) {
>>> -			/* rwsem_try_write_lock() implies ACQUIRE on success */
>>> +		set_current_state(state);
>>> +		if (!smp_load_acquire(&waiter.task)) {
>>> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>>>    			break;
>>>    		}
>>> -
>>> -		raw_spin_unlock_irq(&sem->wait_lock);
>>> -
>>> -		if (signal_pending_state(state, current))
>>> -			goto out_nolock;
>>> -
>>> -		/*
>>> -		 * After setting the handoff bit and failing to acquire
>>> -		 * the lock, attempt to spin on owner to accelerate lock
>>> -		 * transfer. If the previous owner is a on-cpu writer and it
>>> -		 * has just released the lock, OWNER_NULL will be returned.
>>> -		 * In this case, we attempt to acquire the lock again
>>> -		 * without sleeping.
>>> -		 */
>>> -		if (waiter.handoff_set) {
>>> -			enum owner_state owner_state;
>>> -
>>> -			owner_state = rwsem_spin_on_owner(sem);
>>> -			if (owner_state == OWNER_NULL)
>>> -				goto trylock_again;
>>> +		if (signal_pending_state(state, current)) {
>>> +			raw_spin_lock_irq(&sem->wait_lock);
>>> +			if (waiter.task)
>>> +				goto out_nolock;
>>> +			raw_spin_unlock_irq(&sem->wait_lock);
>>> +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
>>> +			break;
>>>    		}
>>> -
>>>    		schedule_preempt_disabled();
>>>    		lockevent_inc(rwsem_sleep_writer);
>>> -		set_current_state(state);
>>> -trylock_again:
>>> -		raw_spin_lock_irq(&sem->wait_lock);
>>>    	}
>>>    	__set_current_state(TASK_RUNNING);
>>> -	raw_spin_unlock_irq(&sem->wait_lock);
>>>    	lockevent_inc(rwsem_wlock);
>>>    	trace_contention_end(sem, 0);
>>>    	return sem;
>>>    out_nolock:
>>> -	__set_current_state(TASK_RUNNING);
>>> -	raw_spin_lock_irq(&sem->wait_lock);
>>>    	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
>>> +	__set_current_state(TASK_RUNNING);
>>>    	lockevent_inc(rwsem_wlock_fail);
>>>    	trace_contention_end(sem, -EINTR);
>>>    	return ERR_PTR(-EINTR);
>> I believe it is better to change state inside the wait_lock critical section
>> to provide a release barrier for free.
> I can't follow... a release for what? Note that the reader slowpath has
> this exact form already.\

You are right. I forgot that we don't need synchronization when setting 
state to TASK_RUNNING.

Cheers,
Longman

