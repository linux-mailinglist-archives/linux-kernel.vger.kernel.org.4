Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FF6A35E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0AXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjB0AXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:23:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5091FD2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677457369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xishXMkGoDfy9kJ+wW4pKQNYO+tlz5Bc1z9GlXdeBc=;
        b=RJTJL8WN2DUu1Jl99OdkzQQCCQ+igqtyr8qObRXes+c1rv91/H5Ko+BOZQ+sE2qzdB/ZKI
        bW9QxE+XglgcRmmpPo3PfbIYiJVN2OGi48ADfSdvoP9+NigZ4SMsKHKfAAVZDFYSWVOZJd
        nG1u9S4G3raJLsN2ltraJxfAUshTLF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-Z6X0-yLGP2mDE8eA01V5Kg-1; Sun, 26 Feb 2023 19:22:48 -0500
X-MC-Unique: Z6X0-yLGP2mDE8eA01V5Kg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A422E811E9C;
        Mon, 27 Feb 2023 00:22:47 +0000 (UTC)
Received: from [10.22.32.65] (unknown [10.22.32.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B96C492B12;
        Mon, 27 Feb 2023 00:22:47 +0000 (UTC)
Message-ID: <943686ee-975d-a463-46d1-04b200ac19b1@redhat.com>
Date:   Sun, 26 Feb 2023 19:22:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
 <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 11:51, Peter Zijlstra wrote:
> On Sun, Feb 26, 2023 at 04:04:35PM +0100, Peter Zijlstra wrote:
>> On Thu, Feb 23, 2023 at 01:26:45PM +0100, Peter Zijlstra wrote:
>>> @@ -1072,7 +1067,7 @@ rwsem_down_read_slowpath(struct rw_semap
>>>   	for (;;) {
>>>   		set_current_state(state);
>>>   		if (!smp_load_acquire(&waiter.task)) {
>>> -			/* Matches rwsem_mark_wake()'s smp_store_release(). */
>>> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>>>   			break;
>>>   		}
>>>   		if (signal_pending_state(state, current)) {
>>> @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
>>>   	} else {
>>>   		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
>> Found it; if we remove the try_write_lock below, then at least this
>> new-waiter path needs to still do a trylock.
>>
>> Let me go test the other patches on top of all this and push out a fresh
>> set if that all still works.
> queue.git locking/core
>
> We'll see what the robots make of it.

 From your new patch 3:

@@ -1151,55 +1154,39 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
                 }
         } else {
                 atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
+               if (rwsem_try_write_lock(sem, &waiter))
+                       waiter.task = NULL;
         }
+       raw_spin_unlock_irq(&sem->wait_lock);

         /* wait until we successfully acquire the lock */
-       set_current_state(state);
         trace_contention_begin(sem, LCB_F_WRITE);

         for (;;) {
-               if (rwsem_try_write_lock(sem, &waiter)) {
-                       /* rwsem_try_write_lock() implies ACQUIRE on 
success */
+               set_current_state(state);
+               if (!smp_load_acquire(&waiter.task)) {
+                       /* Matches rwsem_waiter_wake()'s 
smp_store_release(). */
                         break;
                 }
-

The additional rwsem_try_write_lock() call seems to address the missed 
wakeup problem AFAICT.

I do have some concern that early lock transfer to a lock owner that has 
not been woken up yet may suppress writer lock stealing from optimistic 
spinning causing some performance regression in some cases. Let's see if 
the test robot report anything.

Cheers,
Longman

