Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5769CA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjBTLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:42:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FA1040A;
        Mon, 20 Feb 2023 03:42:25 -0800 (PST)
Date:   Mon, 20 Feb 2023 12:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676893343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UO5ZIv6WLOFEvDgns9PNAXGt0c83/QH7iEoB+8xr5cE=;
        b=TpFU0Mzz4cJQmZSdZxnfvdtapdoOFOuLBPxJYP5m2R7hXXLg1d+hLhnT7Zp7WIfmCdGq84
        /dfUDSsCzXS9SXNvIdYvvA6UhjYGHC6+o4FcqbpE/++E01nLMNT+z6lj/SeEkWLa0p+bHz
        VK+zdxVJgk582UW0asyf9FmlqsSDz4OT1LpKwWcTVeh1EN7UVtNGmOjZnqXBVJDVlgdXpL
        C3WwjEFa2jzrn3mD+F08A3I8SqYS94mH6qo66Y9wgP0ui8NE3wRfhAwIrZdGs2SgMnOwgM
        USDX4exeMwtD5JtfwQstPI1qIEmJS8o1wqsiwFF9pjupuHSIbC3tdZyoRtv51w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676893343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UO5ZIv6WLOFEvDgns9PNAXGt0c83/QH7iEoB+8xr5cE=;
        b=3xB0T8Z9+hNe/WqLw9i7fazxKleH7XCKyMjzYxAt3zXypHgzJ3+gRGWbcx9eFBVN1eOYyk
        CRoIILg8Y0hL9YDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <Y/NcnrwKr2u6tamQ@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
 <87k00cr7ix.ffs@tglx>
 <Y/NT1/ynarp9cDlS@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/NT1/ynarp9cDlS@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-20 12:04:56 [+0100], To Thomas Gleixner wrote:
> The ->pi_blocked_on field is set by __rwbase_read_lock() before
> schedule() is invoked while blocking on the sleeping lock. By doing this
> we avoid __blk_flush_plug() and as such will may deadlock because we are
> going to sleep and made I/O progress earlier which is not globally
> visibly but might be (s/might be/is/ in the deadlock case) expected by
> the owner of the lock.
> 
> We could trylock and if this fails, flush and do the proper lock.
> This would ensure that we set pi_blocked_on after we flushed.

Something like the diff below takes down_read(), down_write() into
account. read_lock()/ write_lock() is excluded via the state check.
mutex_t is missing. It needs to be flushed before the pi_blocked_on is
assigned, before the wait lock is acquired:

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bbf..95731d0c9e87f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1700,6 +1700,13 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	if (state != TASK_RTLOCK_WAIT) {
+		/*
+		 * If we are going to sleep and we have plugged IO queued,
+		 * make sure to submit it to avoid deadlocks.
+		 */
+		blk_flush_plug(tsk->plug, true);
+	}
 	return rt_mutex_slowlock(lock, NULL, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb93017..6c6c88a2d9228 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -143,6 +143,14 @@ static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
+	if (state != TASK_RTLOCK_WAIT) {
+		/*
+		 * If we are going to sleep and we have plugged IO queued,
+		 * make sure to submit it to avoid deadlocks.
+		 */
+		blk_flush_plug(tsk->plug, true);
+	}
+
 	return __rwbase_read_lock(rwb, state);
 }
 
Sebastian
