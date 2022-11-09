Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E76622974
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKILBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKILBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:01:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1411C23
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:01:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B39B2265E;
        Wed,  9 Nov 2022 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667991694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXvwkg4cJ5mGJOX68l5LsHjNU1SQ0l17g9x6H9hGlm8=;
        b=XljVTrsHT/IKGXk6F9sZZfw8nXaMa4tWRLTazk49Bkx193cc9MDrGo+ojCl/4BJuOgOv7I
        fkD9E8/sFBfEF3ucwNBGvdaWKSyrxtF1oEAkB8yIySrslKXvc+wdw5UCh+4orn7kLI7ALv
        KAUKBNTP6c1lh0dz5T5LATs/Q8JOvqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667991694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXvwkg4cJ5mGJOX68l5LsHjNU1SQ0l17g9x6H9hGlm8=;
        b=wzBmLH92F0ivnISVxQ2MS6bhsx2QP/COTuHxc0wKN4ClEFtL7YaMcGQDe2luuzCDH71vpS
        JnBMMVRGqbBMTJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B7601331F;
        Wed,  9 Nov 2022 11:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3FyuBo6Ia2OHKwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 11:01:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A752DA0704; Wed,  9 Nov 2022 12:01:33 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:01:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221109110133.txft66ukwfw2ifkj@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <Y2o1NAE7d6Tf5ILt@FVFF77S0Q05N.cambridge.arm.com>
 <20221108174529.pp4qqi2mhpzww77p@quack3>
 <Y2t4+6MwVZEhoV5n@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2t4+6MwVZEhoV5n@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-11-22 09:55:07, Mark Rutland wrote:
> On Tue, Nov 08, 2022 at 06:45:29PM +0100, Jan Kara wrote:
> > On Tue 08-11-22 10:53:40, Mark Rutland wrote:
> > > On Mon, Nov 07, 2022 at 11:49:01AM -0500, Waiman Long wrote:
> > > > On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> > > > > + locking, arm64
> > > > > 
> > > > > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > > > > while the actual lock is modified via cmpxchg.
> > > > > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > > > > stops happening as well. So do you suspect some bug in the CPU itself?
> > > > > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > > > > then it looks very suspicious.
> > > > > CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> > > > > part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> > > > > always fail (and so the slowpath under a raw_spinlock_t is done).
> > > > > 
> > > > > So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> > > > > somehow smells like the CPU is misbehaving.
> > > > > 
> > > > > Could someone from the locking/arm64 department check if the locking in
> > > > > RT-mutex (rtlock_lock()) is correct?
> > > > > 
> > > > > rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> > > > > (and try_cmpxchg_release(, ptr, ptr) for unlock).
> > > > > Now looking at it again, I don't see much difference compared to what
> > > > > queued_spin_trylock() does except the latter always operates on 32bit
> > > > > value instead a pointer.
> > > > 
> > > > Both the fast path of queued spinlock and rt_spin_lock are using
> > > > try_cmpxchg_acquire(), the only difference I saw is the size of the data to
> > > > be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock uses
> > > > 64-bit pointer. So I believe it is more on how the arm64 does cmpxchg. I
> > > > believe there are two different ways of doing it depending on whether LSE
> > > > atomics is available in the platform. So exactly what arm64 system is being
> > > > used here and what hardware capability does it have?
> > > 
> > > From the /proc/cpuinfo output earlier, this is a Neoverse N1 system, with the
> > > LSE atomics. Assuming the kernel was built with support for atomics in-kernel
> > > (which is selected by default), it'll be using the LSE version.
> > 
> > So I was able to reproduce the corruption both with LSE atomics enabled &
> > disabled in the kernel. It seems the problem takes considerably longer to
> > reproduce with LSE atomics enabled but it still does happen.
> > 
> > BTW, I've tried to reproduced the problem on another aarch64 machine with
> > CPU from a different vendor:
> > 
> > processor       : 0
> > BogoMIPS        : 200.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm
> > CPU implementer : 0x48
> > CPU architecture: 8
> > CPU variant     : 0x1
> > CPU part        : 0xd01
> > CPU revision    : 0
> > 
> > And there the problem does not reproduce. So might it be a genuine bug in
> > the CPU implementation?
> 
> Perhaps, though I suspect it's more likely that we have an ordering bug in the
> kernel code, and it shows up on CPUs with legitimate but more relaxed ordering.
> We've had a couple of those show up on Apple M1, so it might be worth trying on
> one of those.
> 
> How easy is this to reproduce? What's necessary?

As Pierre writes, on Ampere Altra machine running dbench benchmark on XFS
filesystem triggers this relatively easily (it takes it about 10 minutes to
trigger without atomics and about 30 minutes to trigger with the atomics
enabled).

Running the benchmark on XFS somehow seems to be important, we didn't see
the crash happen on ext4 (which may just mean it is less frequent on ext4
and didn't trigger in our initial testing after which we've started to
investigate crashes with XFS).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
