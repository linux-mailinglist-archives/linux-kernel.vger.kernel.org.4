Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0769C7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBTJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:49:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F5E3AA;
        Mon, 20 Feb 2023 01:49:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676886567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPl0DrGnr7zNxFgbqoWf6u0miQVU+auTMSGa2+U7pAY=;
        b=GIqR8oMFAsLUQb/X0Py0ja/UYy6u33oOOVFx5uoimI7PKyy7u7+oy5PUXlrFrTRqPjl7Ki
        mm2fYNVygVa7eeVjOt2jE/iGRq8wi+89RGwiC2PaKsXAo9CUnR8yTYzeiMRCzhPuTtLAqL
        MJhswGFTFul52sw/A5B/HxB/77t/wzT8v8E8RACm0JsmGrOfv5vZnqUJtUlAgQHHFTz+9I
        QzwOR1kbhzrNbYajrPtiAs+6Mc1MbH/M4kvs89bkXaScMNntC0f/JYsIpwA0eZOEpjqv54
        oZlLbjmKIPZ44clraoolcZq4AGwvqTETRFtfvajdJhgv90PoFO26KonGxmOQfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676886567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPl0DrGnr7zNxFgbqoWf6u0miQVU+auTMSGa2+U7pAY=;
        b=v9TvVu/l1u8eWKywTTPAtNEuZ+KY6NuHI3TRxi27J7Tq2Hrbm2KVw9D3KlcEkWcr/AjYAW
        uJqeo1Q/jB+XtBAw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Crystal Wood <swood@redhat.com>
Cc:     John Keeping <john@metanate.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
In-Reply-To: <Y+47FVJ+hI+NA2In@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
Date:   Mon, 20 Feb 2023 10:49:26 +0100
Message-ID: <87k00cr7ix.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16 2023 at 15:17, Sebastian Andrzej Siewior wrote:
> On 2023-02-09 22:31:57 [-0600], Crystal Wood wrote:
>> It is possible for blk_flush_plug() to be called while
>> current->pi_blocked_on is set, in the process of trying to acquire an rwsem.
>> If the block flush blocks trying to acquire some lock, then it appears that
>> current->pi_blocked_on will be overwritten, and then set to NULL once that
>> lock is acquired, even though the task is still blocked on the original
>> rwsem.  Am I missing something that deals with this situation?  It seems
>> like the lock types that are supposed to call blk_flush_plug() should do so
>> before calling task_blocks_on_rt_mutex().
>
> Do you experience a problem in v6.1-RT?
>
>> I originally noticed this while investigating a related issue on an older
>> RHEL kernel where task_blocked_on_mutex() has a BUG_ON if entered with
>> current->pi_blocked_on non-NULL.  Current kernels lack this check.
>
> The logic is different but the deadlock should be avoided:
> - mutex_t and rw_semaphore invoke schedule() while blocking on a lock.
>   As part of schedule() sched_submit_work() is invoked.
>   This is the same in RT and !RT so I don't expect any dead lock since
>   the involved locks are the same.

Huch?

xlog_cil_commit()
  down_read(&cil->xc_ctx_lock)
    __rwbase_read_lock()
       __rt_mutex_slowlock()
         current->pi_blocked_on = ...
         schedule()
           __blk_flush_plug()
             dd_insert_requests()
               rt_spin_lock()
                 WARN_ON(current->pi_blocked_on);

So something like the below is required. But that might not cut it
completely. wq_worker_sleeping() is fine, but I'm not convinced that
io_wq_worker_sleeping() is safe. That needs some investigation.

Thanks,

        tglx
---

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6666,6 +6666,9 @@ static inline void sched_submit_work(str
 	 */
 	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
 
+	if (current->pi_blocked_on)
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
