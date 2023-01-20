Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5883675905
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjATPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjATPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFEA977A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674229570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIQ05j4qL8S7Zw/2rcTjkqPUCnsfDJd6/KCcyaWJofw=;
        b=RZ0NN/PzksznyaUMtQniC4rirlM4BxolBOTi+gfchhVQconvDk+RpOc/Eq5khO9V9evVFK
        cFCQgfx0LHhEbw1x00KLudq/vRqAC7FSiL6ZXlEVkSwDJ9qcU82CtxBST+NY1BKkvHAEbU
        tUkuSlqwWLzo1a9pbw9YZQ14px+efA0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-rTjVJ9zxPXWEi79lbgXTng-1; Fri, 20 Jan 2023 10:46:08 -0500
X-MC-Unique: rTjVJ9zxPXWEi79lbgXTng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA1A23804511;
        Fri, 20 Jan 2023 15:46:07 +0000 (UTC)
Received: from [10.22.18.159] (unknown [10.22.18.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95C8A40C2064;
        Fri, 20 Jan 2023 15:46:07 +0000 (UTC)
Message-ID: <7af102f9-8f87-2b68-9d2a-4d2c4101b95b@redhat.com>
Date:   Fri, 20 Jan 2023 10:46:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH] kernel/locking: introduce stack_handle for tracing
 the callstack
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
References: <1674204502-32123-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <1674204502-32123-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 03:48, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> When deadlock happens, sometimes it is hard to know how the owner get the lock
> especially the owner is running when snapshot(ramdump). Introduce stack_handle
> to record the trace.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>   include/linux/rwsem.h  |  9 ++++++++-
>   kernel/locking/rwsem.c | 18 ++++++++++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index efa5c32..ad4c591 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -16,6 +16,11 @@
>   #include <linux/atomic.h>
>   #include <linux/err.h>
>   
> +#define CONFIG_TRACE_RWSEMS
> +#ifdef CONFIG_TRACE_RWSEMS
> +typedef u32 depot_stack_handle_t;
> +#endif
> +

We don't define CONFIG_* macro in header file like that. We define them 
in Kconfig files. There is a CONFIG_DEBUG_RWSEMS defined. Maybe you can 
use it for the time being. You should also include dependency on 
CONFIG_STACKDEPOT too.

Moreover, I believe depot_stack_handle_t has already been defined in 
include/linux/stackdepot.h. You should include this header file instead 
of defining your own.


>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   # define __RWSEM_DEP_MAP_INIT(lockname)			\
>   	.dep_map = {					\
> @@ -31,7 +36,6 @@
>   #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>   #include <linux/osq_lock.h>
>   #endif
> -
>   /*
>    * For an uncontended rwsem, count and owner are the only fields a task
>    * needs to touch when acquiring the rwsem. So they are put next to each
> @@ -60,6 +64,9 @@ struct rw_semaphore {
>   #ifdef CONFIG_DEBUG_RWSEMS
>   	void *magic;
>   #endif
> +#ifdef CONFIG_TRACE_RWSEMS
> +	depot_stack_handle_t trace_handle;
> +#endif
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   	struct lockdep_map	dep_map;
>   #endif
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 4487359..a12766e 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -28,6 +28,7 @@
>   #include <linux/rwsem.h>
>   #include <linux/atomic.h>
>   #include <trace/events/lock.h>
> +#include <linux/stacktrace.h>
>   
>   #ifndef CONFIG_PREEMPT_RT
>   #include "lock_events.h"
> @@ -74,6 +75,7 @@
>   		list_empty(&(sem)->wait_list) ? "" : "not "))	\
>   			debug_locks_off();			\
>   	} while (0)
> +#define MAX_TRACE		16
>   #else
>   # define DEBUG_RWSEMS_WARN_ON(c, sem)
>   #endif
> @@ -174,6 +176,9 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
>   		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
>   
>   	atomic_long_set(&sem->owner, val);
> +#ifdef CONFIG_TRACE_RWSEMS
> +	sem->trace_handle = owner ? set_track_prepare() : NULL;
> +#endif
>   }

The problem with tracking readers is that a rwsem can have many readers 
at the same time. We can store information for only one of the readers 
and it will be costly if we want to track them all.

>   
>   static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
> @@ -397,6 +402,19 @@ enum rwsem_wake_type {
>   	return false;
>   }
>   stack_depot_save
>
> +#ifdef CONFIG_TRACE_RWSEMS
> +static inline depot_stack_handle_t set_track_prepare(void)
> +{
> +	depot_stack_handle_t trace_handle;
> +	unsigned long entries[MAX_TRACE];
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +	return trace_handle;
> +}
> +#endif
>   /*
>    * handle the lock release when processes blocked on it that can now run
>    * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must

Similar set_track_prepare() is defined in mm/slub.c and mm/kmemleak.c. I 
would suggest consolidate them into a common library function and use it 
instead.

Even if we save the stack trace, where are you planning to have this 
information used. It is not clear from this patch.

Cheers,
Longman

