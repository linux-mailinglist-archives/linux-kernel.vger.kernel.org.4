Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436246CC1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjC1OEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1OEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:04:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E782CA2D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A3w95t3Y79Y8W3NoFIxjXeMSyu9Go6dr+2vTrbGZEj4=; b=eA3PiZxsnoKlBNnWiV65LpSpXP
        MMaILDer/ZJSYltW+wA//8K5Uxtk37bEgr6+4/5AObdPbiOhPV3Qi0COQLe1Bt/PnGX/DSC0yK1io
        u3iYFINPNH7w20UrdgmzZLi03soWpBwL/y7L/N5DnB24fuXhCp4gC9KC7jjw3Hh8RzirsxjGZBYds
        cwpnrK9Gw1PYGmJxKgnLQp322PlnPoBMLTfBFwcD2/FPI9Bp12W4BUIOri9rghvgibYnWbJOiFtwb
        Q4fYX1BWjgDqu1cpEiKlZBvpaG1esPBuG4t2BWyoOxeBrC7qWgWFBSO+ZbSTlBoGilWDWG8gSFES7
        52e7KQ3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph9ue-008TpY-UG; Tue, 28 Mar 2023 14:03:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61D773001E5;
        Tue, 28 Mar 2023 16:02:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3ACB42CB95721; Tue, 28 Mar 2023 16:02:59 +0200 (CEST)
Date:   Tue, 28 Mar 2023 16:02:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] locking/rwsem: Restore old write lock slow path
 behavior
Message-ID: <20230328140259.GF4253@hirez.programming.kicks-ass.net>
References: <20230327202413.1955856-1-longman@redhat.com>
 <20230327202413.1955856-9-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327202413.1955856-9-longman@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:24:13PM -0400, Waiman Long wrote:

>  kernel/locking/rwsem.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 7bd26e64827a..cf9dc1e250e0 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -426,6 +426,7 @@ rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
>  static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  					struct rwsem_waiter *waiter)
>  {
> +	bool first = (rwsem_first_waiter(sem) == waiter);
>  	long count, new;
>  
>  	lockdep_assert_held(&sem->wait_lock);
> @@ -434,6 +435,9 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  	do {
>  		new = count;
>  
> +		if (!first && (count & (RWSEM_FLAG_HANDOFF | RWSEM_LOCK_MASK)))
> +			return false;
> +
>  		if (count & RWSEM_LOCK_MASK) {
>  			/*
>  			 * A waiter (first or not) can set the handoff bit

I couldn't immediately make sense of the above, and I think there's case
where not-first would still want to set handoff you're missing.

After a few detours, I ended up with the below; does that make sense or
did I just make a bigger mess? (entirely possible due to insufficient
sleep etc..).


--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -426,12 +426,27 @@ rwsem_waiter_wake(struct rwsem_waiter *w
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
+	bool first = (rwsem_first_waiter(sem) == waiter);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
 
 	count = atomic_long_read(&sem->count);
 	do {
+		/*
+		 * first handoff
+		 *
+		 *   0     0     | take
+		 *   0     1     | not take
+		 *   1     0     | take
+		 *   1     1     | take
+		 *
+		 */
+		bool handoff = count & RWSEM_FLAG_HANDOFF;
+
+		if (!first && handoff)
+			return false;
+
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
@@ -440,7 +455,7 @@ static inline bool rwsem_try_write_lock(
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if ((count & RWSEM_FLAG_HANDOFF) ||
+			if (handoff ||
 			    (!rt_task(waiter->task) &&
 			     !time_after(jiffies, waiter->timeout)))
 				return false;
@@ -501,11 +516,19 @@ static void rwsem_writer_wake(struct rw_
 		 */
 		list_del(&waiter->list);
 		atomic_long_set(&sem->owner, (long)waiter->task);
-
-	} else if (!rwsem_try_write_lock(sem, waiter))
+		rwsem_waiter_wake(waiter, wake_q);
 		return;
+	}
 
-	rwsem_waiter_wake(waiter, wake_q);
+	/*
+	 * Mark writer at the front of the queue for wakeup.
+	 *
+	 * Until the task is actually awoken later by the caller, other writers
+	 * are able to steal it. Readers, on the other hand, will block as they
+	 * will notice the queued writer.
+	 */
+	wake_q_add(wake_q, waiter->task);
+	lockevent_inc(rwsem_wake_writer);
 }
 
 static void rwsem_reader_wake(struct rw_semaphore *sem,
@@ -1038,6 +1061,25 @@ rwsem_waiter_wait(struct rw_semaphore *s
 			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
 			break;
 		}
+		if (!reader) {
+			/*
+			 * If rwsem_writer_wake() did not take the lock, we must
+			 * rwsem_try_write_lock() here.
+			 */
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter->task && rwsem_try_write_lock(sem, waiter)) {
+				waiter->task = NULL;
+				raw_spin_unlock_irq(&sem->wait_lock);
+				break;
+			}
+			raw_spin_unlock_irq(&sem->wait_lock);
+
+			if (waiter->handoff_set)
+				rwsem_spin_on_owner(sem);
+
+			if (!smp_load_acquire(&waiter->task))
+				break;
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter->task)
