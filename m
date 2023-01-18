Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE26728FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjARUGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjARUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172958289
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2CB61A0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C88C433EF;
        Wed, 18 Jan 2023 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674072361;
        bh=8qoAU5RY6rT6v/Vmw37PUEurrEYHDoEz/tqiZ2w9Pig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Xoj1xCNylrzECVGbGsZcBQwcTYdPuIqwFY4FI4VKJBTmjXTswYD54LHLaHrc2mGjN
         WZuId7PWU5UMDRpvFw1emUYsKG9WDlOIgLhsCkQzq0hMHUJLNVmS15IHzvLFwL9l+G
         wnsouQp7zDqpdM05je5/bdC7WUL6OIPSfNY0R2dXXh76bj3svdsf+DSYhs/0w/xpQe
         EivdG/zplA8OSelXGhSI9pUILsuUSydSfY67WjnB4YeAW+xcN0Vzp1IhMZ7aXwh3J6
         5V4ycFsVlZlKk8lermv2dI06/V60TkiiO08yY0ayyrzkkndxMNgMk3rnbRNzr1A2Dc
         r5v1XvhtL8+Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1B5755C0920; Wed, 18 Jan 2023 12:06:01 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:06:01 -0800
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
Message-ID: <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:50:24AM -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 07:50:41PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
> > > On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> > > > > Isn't it true that the current code will flag srcu-bad-nesting if a 
> > > > > litmus test has non-nested overlapping SRCU read-side critical sections?
> > > > 
> > > > Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> > > > 
> > > > Just to see if I understand, different-values yields true if the set
> > > > contains multiple elements with the same value mapping to different
> > > > values.  Or, to put it another way, if the relation does not correspond
> > > > to a function.
> > > 
> > > As I understand it, given a relation r (i.e., a set of pairs of events), 
> > > different-values(r) returns the sub-relation consisting of those pairs 
> > > in r for which the value associated with the first event of the pair is 
> > > different from the value associated with the second event of the pair.
> > 
> > OK, so different-values(r) is different than (r \ id) because the
> > former operates on values and the latter on events?
> 
> No.  Both of these things are relations, not values or events.
> 
> Suppose you had:
> 
> 	A: WRITE_ONCE(x, 1);
> 	B: WRITE_ONCE(y, 1);
> 	C: WRITE_ONCE(z, 2);
> 
> Then the po relation would consist of the pairs (A,B), (A,C), and (B,C).  
> 
> The different-values(po) relation would include only (A,C) and (B,C).  
> It would not include (A,B) because the two events in that pair have the 
> same value: 1.
> 
> And finally, (po \ id) would be the same as po, because the id relation 
> consists of the pairs (A,A), (B,B), and (C,C) -- and none of those are 
> in po to begin with, so removing them from po doesn't do anything.

Thank you for the much-needed tutorial!

The different values are in the domain, not the range, then.  Good.

> > > Right now the behavior is kind of strange.  The following simple litmus 
> > > test:
> > > 
> > > C test
> > > {}
> > > P0(int *x)
> > > {
> > > 	int r1;
> > > 	r1 = srcu_read_lock(x);
> > > 	srcu_read_unlock(x, r1);
> > > }
> > > exists (~0:r1=0)
> > > 
> > > produces the following output from herd7:
> > > 
> > > Test test Allowed
> > > States 1
> > > 0:r1=906;
> > > Ok
> > > Witnesses
> > > Positive: 1 Negative: 0
> > > Condition exists (not (0:r1=0))
> > > Observation test Always 1 0
> > > Time test 0.01
> > > Hash=2f42c87ae9c1d267f4e80c66f646b9bb
> > > 
> > > Don't ask me where that 906 value comes from or why it is't 0.  Also, 
> > > herd7's graphical output shows there is no data dependency from the lock 
> > > to the unlock, but we need to have one.
> > 
> > Is it still the case that any herd7 value greater than 127 is special?
> 
> I have no idea.

Boqun mentioned off-list this morning that this is still the case,
and that each execution of srcu_read_lock() will return a unique value.
Assuming that I understood him correctly, anyway.

> > > > Given an Srcu-down and an Srcu-up:
> > > > 
> > > > let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
> > > > 		  parameter(Srcu-unlock, 2) ) |
> > > > 		( return_value(Srcu-down) ; (dep | rf)* ;
> > > > 		  parameter(Srcu-up, 2) )
> > > > 
> > > > Seem reasonable, or am I missing yet something else?
> > > 
> > > Not at all reasonable.
> > > 
> > > For one thing, consider this question: Which statements lie inside a 
> > > read-side critical section?
> > 
> > Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
> > srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
> > and mutex_unlock().  Not that this should be all that much comfort
> > given that I have no idea how one would go about modeling down_read()
> > and up_read() in LKMM.
> 
> It might make sense to work on that first, before trying to do 
> srcu_down_read() and srcu_up_read().

The thing is that it is easy to associate an srcu_down_read() with the
corresponding srcu_up_read().  With down() and up(), although in the
Linux kernel this might be represented by a data structure tracking
(say) an I/O request, LKMM is going to be hard pressed to figure that out.

If I am not too confused, the bell code would look something like this
(NOT FOR MAINLINE!):

------------------------------------------------------------------------

(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
let srcu-rscs = ([Srcu-lock] ; (data | rf)* ; [Srcu-unlock]) & loc

(* Validate nesting *)
empty Srcu-lock \ domain(srcu-rscs) as mismatched-srcu-locking
empty Srcu-unlock \ range(srcu-rscs) as mismatched-srcu-unlocking
flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-unlocks

(* Check for use of synchronize_srcu() inside an RCU critical section *)
flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep

(* Validate SRCU dynamic match *)
flag ~empty different-values(srcu-rscs) as srcu-bad-nesting

------------------------------------------------------------------------

A for-mainline version would use Srcu-down and Srcu-up rather than
hijacking the current Srcu-lock and Srcu-unlock.  Which seems to require
herd7 changes, but not unless/until we have agreement that this is a
reasonable thing to do.

> > > With srcu_read_lock() and a matching srcu_read_unlock(), the answer is 
> > > clear: All statements po-between the two.  With srcu_down_read() and 
> > > srcu_up_read(), the answer is cloudy in the extreme.
> > 
> > And I agree that it must be clearly specified, and my that previous try
> > was completely lacking.  Here is a second attempt:
> > 
> > let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
> > 		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)
> > 
> > (And I see your proposal and will try it.)
> > 
> > > Also, bear in mind that the Fundamental Law of RCU is formulated in 
> > > terms of stores propagating to a critical section's CPU.  What are we to 
> > > make of this when a single critical section can belong to more than one 
> > > CPU?
> > 
> > One way of answering this question is by analogy with down() and up()
> > when used as a cross-task mutex.  Another is by mechanically applying
> > some of current LKMM.  Let's start with this second option.
> > 
> > LKMM works mostly with critical sections, but we also discussed ordering
> > based on the set of events po-after an srcu_read_lock() on the one hand
> > and the set of events po-before an srcu_read_unlock() on the other.
> > Starting here, the critical section is the intersection of these two sets.
> > 
> > In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
> > might be a critical section must span processes.  So what if instead of
> > po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
> > xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
> > section is the intersection of A and B.
> > 
> > One objection to this approach is that a bunch of unrelated events could
> > end up being defined as part of the critical section.  Except that this
> > happens already anyway in real critical sections in the Linux kernel.
> > 
> > So what about down() and up() when used as cross-task mutexes?
> > These often do have conceptual critical sections that protect some
> > combination of resource, but these critical sections might span tasks
> > and/or workqueue handlers.  And any reasonable definition of these
> > critical sections would be just as likely to pull in unrelated accesses as
> > the above intersection approach for srcu_down_read() and srcu_up_read().
> > 
> > But I am just now making all this up, so thoughts?
> 
> Maybe we don't really need to talk about read-side critical sections at 
> all.  Once again, here's what explanation.txt currently says:
> 
> 	For any critical section C and any grace period G, at least
> 	one of the following statements must hold:
> 
> (1)	C ends before G does, and in addition, every store that
> 	propagates to C's CPU before the end of C must propagate to
> 	every CPU before G ends.
> 
> (2)	G starts before C does, and in addition, every store that
> 	propagates to G's CPU before the start of G must propagate
> 	to every CPU before C starts.
> 
> Suppose we change this to:
> 
> 	For any RCU lock operation L and matching unlock operation U,
> 	and any matching grace period G, at least one of the following
> 	statements must hold:
> 
> (1)	U executes before G ends, and in addition, every store that
> 	propagates to U's CPU before U executes must propagate to
> 	every CPU before G ends.
> 
> (2)	G starts before L executes, and in addition, every store that
> 	propagates to G's CPU before the start of G must propagate
> 	to every CPU before L executes.
> 
> (For SRCU, G matches L and U if it operates on the same srcu structure.)
> 
> This can be applied sensibly to regular RCU, regular SRCU, and the 
> up/down version of SRCU.  Maybe it's what we want.

I do like your proposed change!

> > > Indeed, given:
> > > 
> > > 	P0(int *x) {
> > > 		srcu_down_read(x);
> > > 	}
> > > 
> > > 	P1(int *x) {
> > > 		srcu_up_read(x);
> > > 	}
> > > 
> > > what are we to make of executions in which P1 executes before P0?
> > 
> > Indeed, there had better be something else forbidding such executions, or
> > this is an invalid use of srcu_down_read() and srcu_up_read().  This might
> > become more clear if the example is expanded to include the index returned
> > from srcu_down_read() that is to be passed to srcu_up_read():
> > 
> > 	P0(int *x, int *i) {
> > 		WRITE_ONCE(i, srcu_down_read(x));
> > 	}
> > 
> > 	P1(int *x, int *i) {
> > 		srcu_up_read(x, READ_ONCE(i));
> > 	}
> 
> Hmmm.  What happens if you write:
> 
> 	r1 = srcu_down_read(x);
> 	r2 = srcu_down_read(x);
> 	srcu_up_read(x, r1);
> 	srcu_up_read(x, r2);
> 
> ?  I can't even tell what that would be _intended_ to do.

Let's take it one line at a time:

	r1 = srcu_down_read(x);
	// A
	r2 = srcu_down_read(x);
	// B
	srcu_up_read(x, r1);
	// C
	srcu_up_read(x, r2);
	// D

An SRCU grace period that starts at A is permitted to complete at
C, difficult though it might be to actually make this happen in the
Linux kernel.  It need wait only for pre-existing critical sections.
But an SRCU grace period that starts at either B or C must wait for both
critical sections, that is until D.

This applies to srcu_read_lock() and srcu_read_unlock() just as much as
to srcu_down_read() and srcu_up_read(), correct?  Each SRCU read-side
critical section is its own thing, and they do not flatten the way that
RCU read-side critical sections do.

I don't know of a safe and sane use of this pattern, as noted here:
https://paulmck.livejournal.com/40593.html

But someone might come up with such a use.

> In fact, it seems likely that to make this work, you have to store at 
> least two values in *x: the value of the up/down counter, and the value 
> returned by srcu_down_read or stored by srcu_up_read.  That means you 
> can't describe what's happening without using a structure, and herd7 
> doesn't support structures.

Yes, if we needed to combine the two overlapping grace periods into a
single larger grace period, this would be a problem.  But we do not,
because an SRCU grace period beginning just after the WRITE_ONCE(*x, 1)
is allowed to end right after the srcu_up_read(s, r1).  That grace period
is not required to wait for the end of the second critical section.

							Thanx, Paul
