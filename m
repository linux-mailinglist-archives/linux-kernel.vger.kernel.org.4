Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33566A2F56
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBZL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 06:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 06:58:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CC4ED3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vMmON7Gd+AkIG4DhEsqO7ov/xwEysLNDcNS4Z3+gU+I=; b=Ljjd0b327zv2Th296EDBAeS6Ld
        7X+K9yKuMZDIq2Y0UVwU/fKmUTxHX7ow9bIiyp3ZRddosUNcoy7W3do635kS+9qI9F+gemGkn5cyK
        0Ml49953sJpir9NO9OFxd6BDAUd7/hW6lq983s7/syQiTADHoBeI29J/3bvgDcOHi/BgSahMPuCP5
        oVkEeYB6Q6sPfVraf21Pkt7yU7wclc6Wz4+AQlTmAW8yLwF76AMKHLYr1xYr4BKzoexU1Wg54lJyP
        2uGcXPInjEXKBSRz0aC6yJlEdDibdlYQXQWl3U92rxVuokwpG039XU7qtxtwLlfpQsVfGs3lzvmfw
        lrRBN24w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWFfi-00GrTX-Ol; Sun, 26 Feb 2023 11:58:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3730300380;
        Sun, 26 Feb 2023 12:58:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1F44203E17C9; Sun, 26 Feb 2023 12:58:29 +0100 (CET)
Date:   Sun, 26 Feb 2023 12:58:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/tJZXrDYpvdJKMh@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 04:38:08PM -0500, Waiman Long wrote:

> > +static void rwsem_writer_wake(struct rw_semaphore *sem,
> > +			      struct rwsem_waiter *waiter,
> > +			      struct wake_q_head *wake_q)
> > +{
> > +	struct rwsem_waiter *first = rwsem_first_waiter(sem);
> > +	long count, new;
> > +
> > +	lockdep_assert_held(&sem->wait_lock);
> > +
> > +	count = atomic_long_read(&sem->count);
> > +	do {
> > +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> > +
> > +		if (has_handoff) {
> > +			/*
> > +			 * Honor handoff bit and yield only when the first
> > +			 * waiter is the one that set it. Otherwisee, we
> > +			 * still try to acquire the rwsem.
> > +			 */
> > +			if (first->handoff_set && (waiter != first))
> > +				return;
> > +		}
> This "if" statement if for a non-first waiter that somehow got woken up to
> have a chance to steal the lock. Now the handoff is done in the wake side
> for the first waiter, this "if" statement is not applicable and can be
> removed.

Yeah, that can be cleaned up, something like the below. But that doesn't
appear to be the cause of issues.

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -427,25 +427,12 @@ static void rwsem_writer_wake(struct rw_
 			      struct rwsem_waiter *waiter,
 			      struct wake_q_head *wake_q)
 {
-	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
 
 	count = atomic_long_read(&sem->count);
 	do {
-		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
-
-		if (has_handoff) {
-			/*
-			 * Honor handoff bit and yield only when the first
-			 * waiter is the one that set it. Otherwisee, we
-			 * still try to acquire the rwsem.
-			 */
-			if (first->handoff_set && (waiter != first))
-				return;
-		}
-
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
@@ -454,8 +441,9 @@ static void rwsem_writer_wake(struct rw_
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!rt_task(waiter->task) &&
-					    !time_after(jiffies, waiter->timeout)))
+			if ((count & RWSEM_FLAG_HANDOFF) ||
+			    (!rt_task(waiter->task) &&
+			     !time_after(jiffies, waiter->timeout)))
 				return;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -474,7 +462,7 @@ static void rwsem_writer_wake(struct rw_
 	 * set here to enable optimistic spinning in slowpath loop.
 	 */
 	if (new & RWSEM_FLAG_HANDOFF) {
-		first->handoff_set = true;
+		waiter->handoff_set = true;
 		lockevent_inc(rwsem_wlock_handoff);
 		return;
 	}
