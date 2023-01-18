Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E076C672A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjARVNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjARVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:12:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502745BEE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:12:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBBD161985
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45056C433EF;
        Wed, 18 Jan 2023 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674076322;
        bh=iMPJ77K4YAm2cwcn3Rb5LHa03mLQK00o4lGQWC5ZJLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o3ND5r4FFL2O+yL6uLKz4sOku/uYeVzw8SqGcNKbwV5IR7ehi9XoDQqRyLhmpEita
         Ed9OvWMosop4FYS6IpFHBB5zosvnj19pFeb6hc22NHQmJVOTCGsdWQZ40anxP3bPLF
         1tYkM3ZN8Puyh/4e8LWcANcFgb5KmpXs8xj1jbFDFSYi/r03EibD8T4b8ow/nJY4za
         q6xOWjYNF8cs+WO6jeQPaX+q/43BiyOSaOQvmfURqDwEn3aW1VMUYgQDUBdEIUN5jB
         T5/BP2q3GoG8zjEtpfPkMyYYzISyeqFlNpBoSWfKyIwGnyVvtLUSWHm87lcvEEC/sq
         zIyZ81nQ+gXIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6A2B5C0920; Wed, 18 Jan 2023 13:12:01 -0800 (PST)
Date:   Wed, 18 Jan 2023 13:12:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
Message-ID: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:30:31PM +0100, Jonas Oberhauser wrote:
> On 1/18/2023 9:19 PM, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 08:42:36PM +0100, Jonas Oberhauser wrote:
> > > On 1/18/2023 5:50 PM, Alan Stern wrote:
> > > > On Tue, Jan 17, 2023 at 07:50:41PM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
> > > > > > On Tue, Jan 17, 2023 at 09
> > > > > > > Given an Srcu-down and an Srcu-up:
> > > > > > > 
> > > > > > > let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
> > > > > > > 		  parameter(Srcu-unlock, 2) ) |
> > > > > > > 		( return_value(Srcu-down) ; (dep | rf)* ;
> > > > > > > 		  parameter(Srcu-up, 2) )
> > > > > > > 
> > > > > > > Seem reasonable, or am I missing yet something else?
> > > > > > Not at all reasonable.
> > > > > > 
> > > > > > For one thing, consider this question: Which statements lie inside a
> > > > > > read-side critical section?
> > > > > Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
> > > > > srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
> > > > > and mutex_unlock().  Not that this should be all that much comfort
> > > > > given that I have no idea how one would go about modeling down_read()
> > > > > and up_read() in LKMM.
> > > > It might make sense to work on that first, before trying to do
> > > > srcu_down_read() and srcu_up_read().
> > > > 
> > > > > > With srcu_read_lock() and a matching srcu_read_unlock(), the answer is
> > > > > > clear: All statements po-between the two.  With srcu_down_read() and
> > > > > > srcu_up_read(), the answer is cloudy in the extreme.
> > > > > And I agree that it must be clearly specified, and my that previous try
> > > > > was completely lacking.  Here is a second attempt:
> > > > > 
> > > > > let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
> > > > > 		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)
> > > > > 
> > > > > (And I see your proposal and will try it.)
> > > > > 
> > > > > > Also, bear in mind that the Fundamental Law of RCU is formulated in
> > > > > > terms of stores propagating to a critical section's CPU.  What are we to
> > > > > > make of this when a single critical section can belong to more than one
> > > > > > CPU?
> > > > > One way of answering this question is by analogy with down() and up()
> > > > > when used as a cross-task mutex.  Another is by mechanically applying
> > > > > some of current LKMM.  Let's start with this second option.
> > > > > 
> > > > > LKMM works mostly with critical sections, but we also discussed ordering
> > > > > based on the set of events po-after an srcu_read_lock() on the one hand
> > > > > and the set of events po-before an srcu_read_unlock() on the other.
> > > > > Starting here, the critical section is the intersection of these two sets.
> > > > > 
> > > > > In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
> > > > > might be a critical section must span processes.  So what if instead of
> > > > > po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
> > > > > xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
> > > > > section is the intersection of A and B.
> > > > > 
> > > > > One objection to this approach is that a bunch of unrelated events could
> > > > > end up being defined as part of the critical section.  Except that this
> > > > > happens already anyway in real critical sections in the Linux kernel.
> > > > > 
> > > > > So what about down() and up() when used as cross-task mutexes?
> > > > > These often do have conceptual critical sections that protect some
> > > > > combination of resource, but these critical sections might span tasks
> > > > > and/or workqueue handlers.  And any reasonable definition of these
> > > > > critical sections would be just as likely to pull in unrelated accesses as
> > > > > the above intersection approach for srcu_down_read() and srcu_up_read().
> > > > > 
> > > > > But I am just now making all this up, so thoughts?
> > > > Maybe we don't really need to talk about read-side critical sections at
> > > > all.  Once again, here's what explanation.txt currently says:
> > > > 
> > > > 	For any critical section C and any grace period G, at least
> > > > 	one of the following statements must hold:
> > > > 
> > > > (1)	C ends before G does, and in addition, every store that
> > > > 	propagates to C's CPU before the end of C must propagate to
> > > > 	every CPU before G ends.
> > > > 
> > > > (2)	G starts before C does, and in addition, every store that
> > > > 	propagates to G's CPU before the start of G must propagate
> > > > 	to every CPU before C starts.
> > > > 
> > > > Suppose we change this to:
> > > > 
> > > > 	For any RCU lock operation L and matching unlock operation U,
> > > > 	and any matching grace period G, at least one of the following
> > > > 	statements must hold:
> > > > 
> > > > (1)	U executes before G ends, and in addition, every store that
> > > > 	propagates to U's CPU before U executes must propagate to
> > > > 	every CPU before G ends.
> > > > 
> > > > (2)	G starts before L executes, and in addition, every store that
> > > > 	propagates to G's CPU before the start of G must propagate
> > > > 	to every CPU before L executes.
> > > > 
> > > > (For SRCU, G matches L and U if it operates on the same srcu structure.)
> > > I think for the formalization, the definition of "critical section" is
> > > hidden inside the word "matching" here.
> > > You will still need to define what matching means for up and down.
> > > Can I understand down and up to create a large read-side critical section
> > > that is shared between multiple threads, analogously to a semaphore? With
> > > the restriction that for srcu, there are really multiple (two) such critical
> > > sections that can be open in parallel, which are indexed by the return value
> > > of down/the input of up?
> > > 
> > > If so I suspect that every down matches with every up within a "critical
> > > section"?
> > > maybe you can define balancing along the co analous to the balancing along
> > > po currently used for matching rcu_lock() and rcu_unlock(). I.e.,
> > > 
> > > down ------------- up
> > >     \down--------up/
> > >         \down-up/
> > >            \_/
> > > where diagonal links are co links and the straight links are "balanced
> > > match" links.
> > The SRCU read-side critical sections are fundamentally different than
> > those of RCU. [...]
> > In contrast, SRCU read-side critical sections are defined by the
> > return value of srcu_read_lock() being passed into the matching
> > srcu_read_unlock().
> 
> I'm a bit confused. I previously thought that there is srcu_lock/srcu_unlock
> and srcu_down/srcu_up and that these are different things.
> 
> Your explanation matches how I understood srcu_read_lock after reading the
> paper and pretending that there wasn't a single counter, while my
> understanding of srcu_read_down would be closer to the original
> implementation in the 2009 paper where there was a single counter, and thus
> srcu_read_down and srcu_read_up could open a multi-thread critical section.
> 
> Is there only one thing and read_down *is* read_lock?
> If they are not the same, is my understand of read_down correct?
> 
> And isn't it also true that the srcu_lock() needs to be on the same CPU as
> the matching srcu_unlock()?
> 
> I think for matching srcu_lock to srcu_unlock, you can just use the data
> dependency (following the "hack" of defining them as reads and writes).

The only difference between srcu_read_lock() and srcu_read_unlock()
on the one hand and srcu_down_read() and srcu_up_read() on the other
is that a matching pair of srcu_read_lock() and srcu_read_unlock()
must be running on the same task.  In contrast, srcu_down_read() and
srcu_up_read() are not subject to this constraint.

> What I was suggesting below is how to redefine "match" between read_down and
> read_up that work more like a cross-thread semaphore.

Understood, but what I don't understand is why not simply this:

let srcu-rscs-down = ([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc

> > > Then everything that is enclosed within a pair of "balanced match" is
> > > linked:
> > > 
> > > match-down-up = co^-1?; balanced-srcu-updown ; co^-1?
> > > 
> > > Since multiple critical sections can be in-flight, maybe you can use co &
> > > same-value (or whatever the relation is) to define this?
> > > 
> > > 
> > > let balanced-srcu-updown = let rec
> > >          unmatched-locks = Srcu-down \ domain(matched)
> > >      and unmatched-unlocks = Srcu-up \ range(matched)
> > >      and unmatched = unmatched-locks | unmatched-unlocks
> > >      and unmatched-co = [unmatched] ; co & same-value ; [unmatched]
> > >      and unmatched-locks-to-unlocks =
> > >          [unmatched-locks] ;  co & same-value ; [unmatched-unlocks]
> > >      and matched = matched | (unmatched-locks-to-unlocks \
> > >          (unmatched-co ; unmatched-co))
> > >      in matched
> > > let match-down-up = (co & same-value)^-1?; balanced-srcu-updown ; (co &
> > > same-value)^-1?
> 
> 
> 
> > > Is the implementation of srcu-lock and srcu-unlock still anything like the
> > > implementation in the 2009 paper?
> 
> > The interaction between readers and grace period is now mediated by a
> > per-CPU pair of lock counters and of unlock counters, so the 2009 paper is
> > not the best guide.  But yes, you would likely need three or four pairwise
> > overlapping critical sections for the current SRCU implementation to end
> > "early".
> 
> That makes sense.
> 
> Have fun, jonas

And you!  ;-)

							Thanx, Paul
