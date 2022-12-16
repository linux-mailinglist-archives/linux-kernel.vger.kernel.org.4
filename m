Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42D64EE55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiLPP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiLPP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:58:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEDA6DCCF;
        Fri, 16 Dec 2022 07:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9CB62166;
        Fri, 16 Dec 2022 15:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0862EC433EF;
        Fri, 16 Dec 2022 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206290;
        bh=Hwl7jph0tUeSs3x14knC3ALms+GSrlpG4Qg8RqqGh4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQO9cSRJpvu2dcIlJ4yg/aMix6YvsEDExgowcKYb6pVxMOO33Q2y+ml6SUYvizbLp
         19Vb3+EXD0ENq1kzG5P18IVWKWWZVGxD2CuJ2QibpjqRPkSZQ14QP75McqVSDTa6it
         JVO+C1vOjVpR3HN35ypWQ12bjA0b1HUd/55/azTLN0WvsbOf+qCwzXIjTMPdLiJ7ME
         f7ptXxtkd0eoUy39p7enGm7kOQk5ThFMg7a3KeA9CX0l9IW0IQD6oUbETUyUNAs5by
         7eX03ec5RuVS1/X+fU7rJy1B5OJ8DTxHmt8RAsx+kb3aGu8nIEt+Go2VHz+Oautod+
         OSAzKfd3nuO5A==
Date:   Fri, 16 Dec 2022 15:58:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rtmutex: Add acquire semantics for rtmutex lock
 acquisition
Message-ID: <20221216155803.GB8949@willie-the-truck>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
 <20221216111412.GA8666@willie-the-truck>
 <20221216135548.itw2xrqbvuldk35y@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216135548.itw2xrqbvuldk35y@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mel,

On Fri, Dec 16, 2022 at 01:55:48PM +0000, Mel Gorman wrote:
> On Fri, Dec 16, 2022 at 11:14:12AM +0000, Will Deacon wrote:
> > > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > > index 35212f260148..af0dbe4d5e97 100644
> > > --- a/kernel/locking/rtmutex.c
> > > +++ b/kernel/locking/rtmutex.c
> > > @@ -238,6 +238,13 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
> > >  		owner = *p;
> > >  	} while (cmpxchg_relaxed(p, owner,
> > >  				 owner | RT_MUTEX_HAS_WAITERS) != owner);
> > > +
> > > +	/*
> > > +	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE
> > > +	 * operations in the event of contention. Ensure the successful
> > > +	 * cmpxchg is visible.
> > > +	 */
> > > +	smp_mb__after_atomic();
> > 
> > Could we use smp_acquire__after_ctrl_dep() instead?
> > 
> 
> It's might be sufficient but it's not as obviously correct. It lacks an
> obvious pairing that is definitely correct but the control dependency
> combined with the smp_acquire__after_ctrl_dep *should* be sufficient
> against the lock fast path based on the available documentation. However,
> I was unable to convince myself that this is definitely correct on all CPUs.

I'm reasonably confident (insofar as you can be confident about any of
this) that it will work, and on arm64 it will result in a slightly cheaper
instruction being emitted. However, I just chimed in because you asked for
my opinion so I'm absolutely fine with whichever direction you prefer to
take!

> Given that arm64 was trivial to crash on PREEMPT_RT before the patch
> (hackbench pipes also triggers the same problem), I'm reluctant to try and
> be too clever particularly as I didn't have a reproducer for a problem in
> this specific path. If someone can demonstrate a reasonable case where
> smp_mb__after_atomic() is too heavy and document that it can be safely
> relaxed then great. At least if that relaxing is wrong, there will be a
> bisection point between the fix and the reintroduction of damage.

I guess bigeasy can give the weaker barrier a try if he has the time, but
otherwise we can leave the change as-is.

Cheers,

Will
