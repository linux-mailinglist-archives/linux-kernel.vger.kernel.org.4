Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84864EC67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLPN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:55:57 -0500
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com [46.22.139.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC491145B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:55:54 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 4E9921C3C1E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:55:53 +0000 (GMT)
Received: (qmail 25094 invoked from network); 16 Dec 2022 13:55:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Dec 2022 13:55:52 -0000
Date:   Fri, 16 Dec 2022 13:55:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20221216135548.itw2xrqbvuldk35y@techsingularity.net>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
 <20221216111412.GA8666@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221216111412.GA8666@willie-the-truck>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:14:12AM +0000, Will Deacon wrote:
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 35212f260148..af0dbe4d5e97 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -238,6 +238,13 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
> >  		owner = *p;
> >  	} while (cmpxchg_relaxed(p, owner,
> >  				 owner | RT_MUTEX_HAS_WAITERS) != owner);
> > +
> > +	/*
> > +	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE
> > +	 * operations in the event of contention. Ensure the successful
> > +	 * cmpxchg is visible.
> > +	 */
> > +	smp_mb__after_atomic();
> 
> Could we use smp_acquire__after_ctrl_dep() instead?
> 

It's might be sufficient but it's not as obviously correct. It lacks an
obvious pairing that is definitely correct but the control dependency
combined with the smp_acquire__after_ctrl_dep *should* be sufficient
against the lock fast path based on the available documentation. However,
I was unable to convince myself that this is definitely correct on all CPUs.

Given that arm64 was trivial to crash on PREEMPT_RT before the patch
(hackbench pipes also triggers the same problem), I'm reluctant to try and
be too clever particularly as I didn't have a reproducer for a problem in
this specific path. If someone can demonstrate a reasonable case where
smp_mb__after_atomic() is too heavy and document that it can be safely
relaxed then great. At least if that relaxing is wrong, there will be a
bisection point between the fix and the reintroduction of damage.

-- 
Mel Gorman
SUSE Labs
