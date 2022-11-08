Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB8620DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiKHKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKHKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:53:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F339D101F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:53:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C0191FB;
        Tue,  8 Nov 2022 02:53:50 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E051F3F534;
        Tue,  8 Nov 2022 02:53:42 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:53:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <Y2o1NAE7d6Tf5ILt@FVFF77S0Q05N.cambridge.arm.com>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:49:01AM -0500, Waiman Long wrote:
> On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> > + locking, arm64
> > 
> > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > while the actual lock is modified via cmpxchg.
> > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > stops happening as well. So do you suspect some bug in the CPU itself?
> > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > then it looks very suspicious.
> > CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> > part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> > always fail (and so the slowpath under a raw_spinlock_t is done).
> > 
> > So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> > somehow smells like the CPU is misbehaving.
> > 
> > Could someone from the locking/arm64 department check if the locking in
> > RT-mutex (rtlock_lock()) is correct?
> > 
> > rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> > (and try_cmpxchg_release(, ptr, ptr) for unlock).
> > Now looking at it again, I don't see much difference compared to what
> > queued_spin_trylock() does except the latter always operates on 32bit
> > value instead a pointer.
> 
> Both the fast path of queued spinlock and rt_spin_lock are using
> try_cmpxchg_acquire(), the only difference I saw is the size of the data to
> be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock uses
> 64-bit pointer. So I believe it is more on how the arm64 does cmpxchg. I
> believe there are two different ways of doing it depending on whether LSE
> atomics is available in the platform. So exactly what arm64 system is being
> used here and what hardware capability does it have?

From the /proc/cpuinfo output earlier, this is a Neoverse N1 system, with the
LSE atomics. Assuming the kernel was built with support for atomics in-kernel
(which is selected by default), it'll be using the LSE version.

Mark.
