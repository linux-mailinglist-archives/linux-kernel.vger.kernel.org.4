Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8708D61FA77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiKGQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiKGQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A83140F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667839749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5nKiP6C0iv3WZDdZQnBDHbFvwXrm0G0wDMYyXauExM=;
        b=fcIv8/DGXQhooy1Inq0auA0y4oI3gBXbsZT/uenArsi+TDxQRp8LMvM6nAd7GSqQRoMlz5
        ECXFL41Ac/wTW9ih1o5ymdeL6+YR8cDthYgsPUWyUHKH94GxnFBi4ILTWcJFjbw2yh4V9b
        5lFIMKas2bvoq8C9yXNyAFyP9yly7Tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-j9xoNTqVMjik9C92MSv5Qw-1; Mon, 07 Nov 2022 11:49:02 -0500
X-MC-Unique: j9xoNTqVMjik9C92MSv5Qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 075A2101E148;
        Mon,  7 Nov 2022 16:49:02 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B68692166B29;
        Mon,  7 Nov 2022 16:49:01 +0000 (UTC)
Message-ID: <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
Date:   Mon, 7 Nov 2022 11:49:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de> <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y2kf6tcX47Cl7q0W@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> + locking, arm64
>
> On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
>>> spinlock_t and raw_spinlock_t differ slightly in terms of locking.
>>> rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
>>> enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
>>> always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
>>> while the actual lock is modified via cmpxchg.
>> So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
>> stops happening as well. So do you suspect some bug in the CPU itself?
> If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> then it looks very suspicious.
> CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> always fail (and so the slowpath under a raw_spinlock_t is done).
>
> So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> somehow smells like the CPU is misbehaving.
>
> Could someone from the locking/arm64 department check if the locking in
> RT-mutex (rtlock_lock()) is correct?
>
> rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> (and try_cmpxchg_release(, ptr, ptr) for unlock).
> Now looking at it again, I don't see much difference compared to what
> queued_spin_trylock() does except the latter always operates on 32bit
> value instead a pointer.

Both the fast path of queued spinlock and rt_spin_lock are using 
try_cmpxchg_acquire(), the only difference I saw is the size of the data 
to be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock 
uses 64-bit pointer. So I believe it is more on how the arm64 does 
cmpxchg. I believe there are two different ways of doing it depending on 
whether LSE atomics is available in the platform. So exactly what arm64 
system is being used here and what hardware capability does it have?

Cheers,
Longman

