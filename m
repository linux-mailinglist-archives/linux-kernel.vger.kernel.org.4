Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F167292C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjARUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:19:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5914FAFB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 091E3619F3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D114C433EF;
        Wed, 18 Jan 2023 20:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674073159;
        bh=Rld7f9woOyxMMbxIv1287uHCNGo2cFSN516vUrr8fJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NuNMIxf0nu5OVfjKM0tHGzx05aFKFCW7SncTfm2QuLTXVJt6yj4HDIVtW7qUx5YVQ
         IkiRto54lmThuRPySqCUWruDIB9k0w9rg2u2voP16iaIMitNtGlURWuMVkmzzcs/1u
         O4GjzjqkLD9RMqN05sFgUXwhjMBVVQgMPLjRuiJPxRH8X3KgLyPXlaf286JDn9sMfQ
         iMIx749BwQVTXKlPWJN1kMBmIUop6mV6wPDp2c6Meg3R6WOGjoIZLTfPlqV2zOL/3a
         ttYJffq8n1H4gZjKmng6LUOtH3skirNAPmyJhY+rijyBNBoBYNW/H2mi8Cg2YBKQWJ
         e+8lGPhG0dFqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0239C5C0920; Wed, 18 Jan 2023 12:19:18 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:19:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <s9joober@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:42:36PM +0100, Jonas Oberhauser wrote:
> On 1/18/2023 5:50 PM, Alan Stern wrote:
> > On Tue, Jan 17, 2023 at 07:50:41PM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
> > > > On Tue, Jan 17, 2023 at 09
> > > > > Given an Srcu-down and an Srcu-up:
> > > > > 
> > > > > let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
> > > > > 		  parameter(Srcu-unlock, 2) ) |
> > > > > 		( return_value(Srcu-down) ; (dep | rf)* ;
> > > > > 		  parameter(Srcu-up, 2) )
> > > > > 
> > > > > Seem reasonable, or am I missing yet something else?
> > > > Not at all reasonable.
> > > > 
> > > > For one thing, consider this question: Which statements lie inside a
> > > > read-side critical section?
> > > Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
> > > srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
> > > and mutex_unlock().  Not that this should be all that much comfort
> > > given that I have no idea how one would go about modeling down_read()
> > > and up_read() in LKMM.
> > It might make sense to work on that first, before trying to do
> > srcu_down_read() and srcu_up_read().
> > 
> > > > With srcu_read_lock() and a matching srcu_read_unlock(), the answer is
> > > > clear: All statements po-between the two.  With srcu_down_read() and
> > > > srcu_up_read(), the answer is cloudy in the extreme.
> > > And I agree that it must be clearly specified, and my that previous try
> > > was completely lacking.  Here is a second attempt:
> > > 
> > > let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
> > > 		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)
> > > 
> > > (And I see your proposal and will try it.)
> > > 
> > > > Also, bear in mind that the Fundamental Law of RCU is formulated in
> > > > terms of stores propagating to a critical section's CPU.  What are we to
> > > > make of this when a single critical section can belong to more than one
> > > > CPU?
> > > One way of answering this question is by analogy with down() and up()
> > > when used as a cross-task mutex.  Another is by mechanically applying
> > > some of current LKMM.  Let's start with this second option.
> > > 
> > > LKMM works mostly with critical sections, but we also discussed ordering
> > > based on the set of events po-after an srcu_read_lock() on the one hand
> > > and the set of events po-before an srcu_read_unlock() on the other.
> > > Starting here, the critical section is the intersection of these two sets.
> > > 
> > > In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
> > > might be a critical section must span processes.  So what if instead of
> > > po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
> > > xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
> > > section is the intersection of A and B.
> > > 
> > > One objection to this approach is that a bunch of unrelated events could
> > > end up being defined as part of the critical section.  Except that this
> > > happens already anyway in real critical sections in the Linux kernel.
> > > 
> > > So what about down() and up() when used as cross-task mutexes?
> > > These often do have conceptual critical sections that protect some
> > > combination of resource, but these critical sections might span tasks
> > > and/or workqueue handlers.  And any reasonable definition of these
> > > critical sections would be just as likely to pull in unrelated accesses as
> > > the above intersection approach for srcu_down_read() and srcu_up_read().
> > > 
> > > But I am just now making all this up, so thoughts?
> > Maybe we don't really need to talk about read-side critical sections at
> > all.  Once again, here's what explanation.txt currently says:
> > 
> > 	For any critical section C and any grace period G, at least
> > 	one of the following statements must hold:
> > 
> > (1)	C ends before G does, and in addition, every store that
> > 	propagates to C's CPU before the end of C must propagate to
> > 	every CPU before G ends.
> > 
> > (2)	G starts before C does, and in addition, every store that
> > 	propagates to G's CPU before the start of G must propagate
> > 	to every CPU before C starts.
> > 
> > Suppose we change this to:
> > 
> > 	For any RCU lock operation L and matching unlock operation U,
> > 	and any matching grace period G, at least one of the following
> > 	statements must hold:
> > 
> > (1)	U executes before G ends, and in addition, every store that
> > 	propagates to U's CPU before U executes must propagate to
> > 	every CPU before G ends.
> > 
> > (2)	G starts before L executes, and in addition, every store that
> > 	propagates to G's CPU before the start of G must propagate
> > 	to every CPU before L executes.
> > 
> > (For SRCU, G matches L and U if it operates on the same srcu structure.)
> 
> I think for the formalization, the definition of "critical section" is
> hidden inside the word "matching" here.
> You will still need to define what matching means for up and down.
> Can I understand down and up to create a large read-side critical section
> that is shared between multiple threads, analogously to a semaphore? With
> the restriction that for srcu, there are really multiple (two) such critical
> sections that can be open in parallel, which are indexed by the return value
> of down/the input of up?
> 
> If so I suspect that every down matches with every up within a "critical
> section"?
> maybe you can define balancing along the co analous to the balancing along
> po currently used for matching rcu_lock() and rcu_unlock(). I.e.,
> 
> down ------------- up
>    \down--------up/
>        \down-up/
>           \_/
> where diagonal links are co links and the straight links are "balanced
> match" links.

The SRCU read-side critical sections are fundamentally different than
those of RCU.  RCU's critical sections are defined by po and they nest
and flatten, so that a nested set of RCU read-side critical sections is
equivalent to a single critical section spanning the full set.  Your
example above illustrates this nicely.

In contrast, SRCU read-side critical sections are defined by the
return value of srcu_read_lock() being passed into the matching
srcu_read_unlock().  They can be nested, overlapped, or whatever,
but each SRCU read-side critical section is its own thing.
Yes, in SRCU's fully nested case, you cannot tell the difference,
but you can with partially overlapping critical sections, as in
Alan's example:

	r1 = srcu_read_lock(s);
	r2 = srcu_read_lock(s);
	srcu_read_unlock(s, r1);
	srcu_read_unlock(s, r2);

An SRCU grace period that starts between that pair of srcu_read_lock()
invocations is permitted to end between the pair of srcu_read_unlock()
invocations because the second critical section has not yet started.

Mainline LKMM's current SRCU definitions are an approximation, which
we are now trying to make exact.

> Then everything that is enclosed within a pair of "balanced match" is
> linked:
> 
> match-down-up = co^-1?; balanced-srcu-updown ; co^-1?
> 
> Since multiple critical sections can be in-flight, maybe you can use co &
> same-value (or whatever the relation is) to define this?
> 
> 
> let balanced-srcu-updown = let rec
>         unmatched-locks = Srcu-down \ domain(matched)
>     and unmatched-unlocks = Srcu-up \ range(matched)
>     and unmatched = unmatched-locks | unmatched-unlocks
>     and unmatched-co = [unmatched] ; co & same-value ; [unmatched]
>     and unmatched-locks-to-unlocks =
>         [unmatched-locks] ;  co & same-value ; [unmatched-unlocks]
>     and matched = matched | (unmatched-locks-to-unlocks \
>         (unmatched-co ; unmatched-co))
>     in matched
> let match-down-up = (co & same-value)^-1?; balanced-srcu-updown ; (co &
> same-value)^-1?

Or just substitute "(data | rf)*" for the "data" in Alan's
current definition.  (But keeping Alan's definition or similar for
srcu_read_lock() and using the "(data | rf)*" only for srcu_down_read().)

> > > > Indeed, given:
> > > > 
> > > > 	P0(int *x) {
> > > > 		srcu_down_read(x);
> > > > 	}
> > > > 
> > > > 	P1(int *x) {
> > > > 		srcu_up_read(x);
> > > > 	}
> > > > 
> > > > what are we to make of executions in which P1 executes before P0?
> > > Indeed, there had better be something else forbidding such executions, or
> > > this is an invalid use of srcu_down_read() and srcu_up_read().
> 
> Would it be sufficient to flag executions in which an up is not matched with
> any down event?
> 
> > >    This might
> > > become more clear if the example is expanded to include the index returned
> > > from srcu_down_read() that is to be passed to srcu_up_read():
> > > 
> > > 	P0(int *x, int *i) {
> > > 		WRITE_ONCE(i, srcu_down_read(x));
> > > 	}
> > > 
> > > 	P1(int *x, int *i) {
> > > 		srcu_up_read(x, READ_ONCE(i));
> > > 	}
> > Hmmm.  What happens if you write:
> > 
> > 	r1 = srcu_down_read(x);
> > 	r2 = srcu_down_read(x);
> > 	srcu_up_read(x, r1);
> > 	srcu_up_read(x, r2);
> > 
> > ?  I can't even tell what that would be _intended_ to do.
> 
> Is it correct that it creates one or two read-side critical sections
> depending on whether the two down() happen to return the same value, which
> either spans at least all four lines (plus perhaps more if other threads
> also do down()) or the first spans lines 1-3 and the second spans 2-4?

It creates two of them.

> Is the implementation of srcu-lock and srcu-unlock still anything like the
> implementation in the 2009 paper?

The interaction between readers and grace period is now mediated by a
per-CPU pair of lock counters and of unlock counters, so the 2009 paper is
not the best guide.  But yes, you would likely need three or four pairwise
overlapping critical sections for the current SRCU implementation to end
"early".

> best wishes and thanks for your patient explanations, jonas

Not a problem!  Though I will be distracted most of this afternoon,
Pacific Time.

							Thanx, Paul
