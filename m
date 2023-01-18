Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F063670EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjARAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjARAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:36:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADB61888
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:05:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674000331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6f8munmJxa/8WnZ4QEb9NOOrR0H3n/weATpS88Zphz4=;
        b=ManIwOntKUGcBX+Zl5XyOLE1TbKTDL96EhAOtJMw3o0RIE1HmJNovqcBfPll3fxvGuO1nK
        Lku9TV1YCyurN4Ddza8THbDIdyd7OvtDYfmXOWmlG0TnrlEoSEvsskaTNbH8dwqcqqH2ho
        ErqBAiIPQVihMOYrILPW4d8pKbVza91CjqrhXJ+b5egGHctXX1GyuOByGvrORPhRY3R7f0
        ptOobMxVs3SklkKEPq5EIMY24JfvGegU7U1Yo2pFx0MYTC6zrd3IcTba1B3iqg1YazFcio
        Rj2USoBPDfCTpDpxjQ7SEfaIsXgoFPKJaJCRI8hQk4iLPOfVTPVzl+dKQIYnjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674000331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6f8munmJxa/8WnZ4QEb9NOOrR0H3n/weATpS88Zphz4=;
        b=P0spGLxiHd4tr08jO2UoMb13FcMmChoIGZykjqdTXS7U5XZs4ElAVNA23li/n4zxiVZwHV
        JjqjAdzly1y44RCQ==
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
In-Reply-To: <20230117172649.52465-1-wander@redhat.com>
References: <20230117172649.52465-1-wander@redhat.com>
Date:   Wed, 18 Jan 2023 01:05:30 +0100
Message-ID: <875yd4k8qd.ffs@tglx>
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

Wander!

On Tue, Jan 17 2023 at 14:26, Wander Lairson Costa wrote:
> In task_blocked_on_lock() we save the owner, release the wait_lock and
> call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
> again, the owner may release the lock and deboost.

This does not make sense in several aspects:

  1) Who is 'we'? You, me, someone else? None of us does anything of the
     above.

        https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

  2) What has task_blocked_on_lock() to do with the logic in
     rt_mutex_adjust_prio_chain() which is called by other callsites
     too?

  3) If the owner releases the lock and deboosts then this has
     absolutely nothing to do with the lock because the priority of a
     the owner is determined by its own priority and the priority of the
     top most waiter. If the owner releases the lock then it marks the
     lock ownerless, wakes the top most waiter and deboosts itself. In
     this owner deboost rt_mutex_adjust_prio_chain() is not involved at
     all. Why?

     Because the owner deboost does not affect the priority of the
     waiters at all. It's the other way round: Waiter priority affects
     the owner priority if the waiter priority is higher than the owner
     priority.

> rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> phase, waiter may be initially in the top of the queue, but after
> dequeued and requeued it may no longer be true.

That's related to your above argumentation in which way?

rt_mutex_adjust_prio_chain()

        lock->wait_lock is held across the whole operation

        prerequeue_top_waiter = rt_mutex_top_waiter(lock);

  This saves the current top waiter before the dequeue()/enqueue()
  sequence.

	rt_mutex_dequeue(lock, waiter);
	waiter_update_prio(waiter, task);
	rt_mutex_enqueue(lock, waiter);

	if (!rt_mutex_owner(lock)) {

  This is the case where the lock has no owner, i.e. the previous owner
  unlocked and the chainwalk cannot be continued.

  Now the code checks whether the requeue changed the top waiter task:

		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))

  What can make this condition true?

    1) @waiter is the new top waiter due to the requeue operation

    2) @waiter is not longer the top waiter due to the requeue operation

  So in both cases the new top waiter must be woken up so it can take over
  the ownerless lock.

  Here is where the code is buggy. It only considers case #1, but not
  case #2, right?

So your patch is correct, but the explanation in your changelog has
absolutely nothing to do with the problem.

Why?

  #2 is caused by a top waiter dropping out due to a signal or timeout
     and thereby deboosting the whole lock chain.

  So the relevant callchain which causes the problem originates from
  remove_waiter()

See?

Thanks,

        tglx
