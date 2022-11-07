Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429361F73B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiKGPKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiKGPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:10:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77991DA6F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:10:37 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:10:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667833836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxahy4MUlQGdZAiwUootSdpPQQmTuITFh2KW+Ggp0P4=;
        b=zZN4uPxRUSJhni6VwYnJbJeRxq5/VSSrOO+7qqhdQVXQLagFpDyfxGfvh4mapMEreFdYLs
        drBA4t3nwscD8A5FbCL2tNdJVRkM+6SR9nL+poFMPJhbMfunF40EawvdHVflKNJpCfW42Y
        EQkWeYqZAHNvVsqTq6vlN1KNQ9LMJTeQecGiMRy6UJSqpHF5vOs9Kl0+m/yMojmXZ8drw/
        FdJ8T70NNQA1aOf6pxPraG5QglrTM925SX8dArWixKeozV5OGxt0bGJHR92ICU3Ao4BBV8
        I8DM2kLVuRxNPvQhUajh8xuwQdOlcWUe7KaE35EdcmyEzMgwZ8mKvxPT24T4aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667833836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxahy4MUlQGdZAiwUootSdpPQQmTuITFh2KW+Ggp0P4=;
        b=wHFjQXHG5/PTHlPPZ/eqlfZ4qw6X0XP6KRdlCwyZCygmYqoqs4jY8xznt6ew7Zm2PGowBr
        OJY2UY43JxK74ABg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <Y2kf6tcX47Cl7q0W@linutronix.de>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107135636.biouna36osqc4rik@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ locking, arm64

On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > while the actual lock is modified via cmpxchg. 
> 
> So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> stops happening as well. So do you suspect some bug in the CPU itself?

If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
then it looks very suspicious. 
CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
always fail (and so the slowpath under a raw_spinlock_t is done).

So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
somehow smells like the CPU is misbehaving.

Could someone from the locking/arm64 department check if the locking in
RT-mutex (rtlock_lock()) is correct?

rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
(and try_cmpxchg_release(, ptr, ptr) for unlock).
Now looking at it again, I don't see much difference compared to what
queued_spin_trylock() does except the latter always operates on 32bit
value instead a pointer.

> 								Honza
> 

Sebastian
