Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A40672D39
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjASACY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjASACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DB4ABDA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53308B81F9F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4267C433EF;
        Thu, 19 Jan 2023 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086534;
        bh=QWufpft3+Ga+2YJlXrTs61UicSZ08sXkKsN6H0s96aU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eBqZ8xoT9s5wLd5SPjMlsJezKua10TAvLaKi2zLRpqt9uwEA0wf2ruqAYnUtwe68R
         s90LvjOiRpUSWY34IEc/P+6T16CSTYDKPd0U3grip70oiNBzUadGVy4TwdPgBnm1ZU
         YoNrNrg88c4oxecebqLTZU3UayRRg06FZAnNe7z85/syBXHN+apyIL3CLMG7Db+ZBl
         wmTBrk8Tj9cVocRnUE7CNrab9UHk03htebQAQ6E8l9Zi1Ns/MHx3JpqAU+i4DfOExP
         quNl420mWTZxLctK3VUJA0mGkN5oiT35uaOCL7KSgEi/LUHIm8bR4HDzP/ypv34wQs
         u1b44LdPOeOhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 480B45C0A1A; Wed, 18 Jan 2023 16:02:14 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:02:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hclxuhpGm+krkz@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:54:47PM -0500, Alan Stern wrote:
> On Wed, Jan 18, 2023 at 12:06:01PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 11:50:24AM -0500, Alan Stern wrote:
> > Boqun mentioned off-list this morning that this is still the case,
> > and that each execution of srcu_read_lock() will return a unique value.
> > Assuming that I understood him correctly, anyway.
> 
> That will no longer be true with the patch I posted yesterday.  Every 
> execution of srcu_read_lock() will return 0 (or whatever the initial 
> value of the lock variable is).
> 
> But with a small change to the .def file, each execution of 
> srcu_read_unlock() can be made to increment the lock's value, and then 
> the next srcu_read_lock() would naturally return the new value.

Different values might be good for debugging, but I am not sure that this
is worth the weight.  Happy to go with whatever you decide on this one.

> > > > given that I have no idea how one would go about modeling down_read()
> > > > and up_read() in LKMM.
> > > 
> > > It might make sense to work on that first, before trying to do 
> > > srcu_down_read() and srcu_up_read().
> > 
> > The thing is that it is easy to associate an srcu_down_read() with the
> > corresponding srcu_up_read().  With down() and up(), although in the
> > Linux kernel this might be represented by a data structure tracking
> > (say) an I/O request, LKMM is going to be hard pressed to figure that out.
> 
> It would help (or at least, it would help _me_) if you gave a short 
> explanation of how srcu_down_read() and srcu_up_read() are meant to 
> work.  With regular r/w semaphores, the initial lock value is 0, each 
> down() operation decrements the value, each up() operation increments 
> the value -- or vice versa if you don't like negative values -- and a 
> write_lock() will wait until the value is >= 0.  In that setting, it 
> makes sense to say that a down() which changes the value from n to n-1 
> matches the next up() which changes the value from n-1 to n.
> 
> I presume that srcu semaphores do not work this way.  Particularly since 
> the down() operation returns a value which must be passed to the 
> corresponding up() operation.  So how _do_ they work?

There are pairs of per-CPU counters.  One pair (->srcu_lock_count[])
counts the number of srcu_down_read() operations that took place on
that CPU and another pair (->srcu_unlock_count[]) counts the number
of srcu_down_read() operations that took place on that CPU.  There is
an ->srcu_idx that selects which of the ->srcu_lock_count[] elements
should be incremented by srcu_down_read().  Of course, srcu_down_read()
returns the value of ->srcu_idx that it used so that the matching
srcu_up_read() will use that same index when incrementing its CPU's
->srcu_unlock_count[].

Grace periods go something like this:

1.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.

2.	smp_mb().

3.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.

4.	If the sums are not equal, retry from #1.

5.	smp_mb().

6.	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);

7.	smp_mb().

8.	Same loop as #1-4.

So similar to r/w semaphores, but with two separate distributed counts.
This means that the number of readers need not go to zero at any given
point in time, consistent with the need to wait only on old readers.

> > > Hmmm.  What happens if you write:
> > > 
> > > 	r1 = srcu_down_read(x);
> > > 	r2 = srcu_down_read(x);
> > > 	srcu_up_read(x, r1);
> > > 	srcu_up_read(x, r2);
> > > 
> > > ?  I can't even tell what that would be _intended_ to do.
> > 
> > Let's take it one line at a time:
> > 
> > 	r1 = srcu_down_read(x);
> > 	// A
> > 	r2 = srcu_down_read(x);
> > 	// B
> > 	srcu_up_read(x, r1);
> > 	// C
> > 	srcu_up_read(x, r2);
> > 	// D
> > 
> > An SRCU grace period that starts at A is permitted to complete at
> > C, difficult though it might be to actually make this happen in the
> > Linux kernel.  It need wait only for pre-existing critical sections.
> 
> So the down() returning r1 matches the up() receiving r1?

Yes.

> > But an SRCU grace period that starts at either B or C must wait for both
> > critical sections, that is until D.
> 
> Implying that the down() returning r2 matches up() receiving r2?

Again, yes.

> And in general, an up() matches a down() iff they have the same values?  

I would instead say that the match is determined by the fact that a
given srcu_up_read() receives what was returned from the corresponding
srcu_down_read().  So not a comparison of values, but rather something
like (data | rf)*.

> And we can imagine that every down() returns a different value?  

For purposes of herd7 emuation before your rework, yes.  In real life,
and as an implementation detail, a given srcu_down_read() only ever
returns either 0 or 1.  And from what I can see playing around, the fact
that any given srcu_down_read() only ever returns zero is not a problem,
the (data | rf)* still works fine.  Thus far, anyway.  ;-)

> How does this differ from srcu_read_lock() and srcu_read_unlock()?  And 
> how do the "up" and "down" parts figure into it? -- what is going up or 
> down?

Functionally and from a performance/scalability viewpoint, they
are identical to srcu_read_lock() and srcu_read_unlock().  The only
difference is that srcu_down_read() and srcu_up_read() lack the lockdep
machinery that complains when a matching pair of srcu_read_lock() and
srcu_read_unlock() are used from different tasks.

Within the implementation, nothing ever goes down, it is all
this_cpu_inc().  The "down" and "up" are by analogy to down() and up(),
where "down()" says acquire some rights to a resource and "up()" says
release those rights.

Wait, I can make "down" work.

A call to srcu_down_read() reduces the quantity computed by summing the
unlocks then subtracting the sum of the locks.  A call to srcu_up_read()
increases that same quantity.  ;-)

							Thanx, Paul
