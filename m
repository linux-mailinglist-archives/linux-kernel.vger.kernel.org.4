Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9126768A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAUT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:56:59 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4413E1E9EB
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:56:58 -0800 (PST)
Received: (qmail 75823 invoked by uid 1000); 21 Jan 2023 14:56:57 -0500
Date:   Sat, 21 Jan 2023 14:56:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <Y8xDieO/iYOk9Ty1@rowland.harvard.edu>
References: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
 <20230121184032.GF2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230121184032.GF2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 10:40:32AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 21, 2023 at 12:36:26PM -0500, Alan Stern wrote:
> > On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
> > > 
> > > 
> > > On 1/20/2023 5:18 PM, Alan Stern wrote:
> > > > On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
> > > > > Perhaps we could say that reading an index without using it later is
> > > > > forbidden?
> > > > > 
> > > > > flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
> > > > > thrown-srcu-cookie-on-floor
> > > > We already flag locks that don't have a matching unlock.
> > > 
> > > Of course, but as you know this is completely orthogonal.
> > 
> > Yeah, okay.  It doesn't hurt to add this check, but the check isn't 
> > complete.  For example, it won't catch the invalid usage here:
> > 
> > P0(srcu_struct *ss)
> > {
> > 	int r1, r2;
> > 
> > 	r1 = srcu_read_lock(ss);
> > 	srcu_read_unlock(&ss, r1);
> > 	r2 = srcu_read_lock(ss);
> > 	srcu_read_unlock(&ss, r2);
> > }
> > 
> > exists (~0:r1=0:r2)
> > 
> > On the other hand, how often will people make this sort of mistake in 
> > their litmus tests?  My guess is not very.
> 
> I must be blind this morning.  I see a well-formed pair of back-to-back
> SRCU read-side critical sections.  A rather useless pair, given that
> both are empty,

And there are no synchronize_srcu() calls.

>  but valid nonetheless.
> 
> Or is the bug the use of 0:r1 and 0:r2 in the "exists" clause?  If so,
> then I agree that this is not at all a high-priority bug to flag.

Yes, that is the bug.  The patched version of LKMM and the 
implementation you described say the exist clause will never be 
satisfied, the current version of LKMM says it will always be 
satisfied, and the theoretical model for SRCU says it will sometimes 
be satisfied -- which is the answer we want.

> > > Can you briefly explain how the operational model you have in mind for
> > > srcu's up and down allows x==1 (and y==0 and idx1==idx2) in the example I
> > > sent before (copied with minor edit below for convenience)?
> > > 
> > > P0{
> > >     idx1 = srcu_down(&ss);
> > >     store_rel(p1, true);
> > > 
> > > 
> > >     shared cs
> > > 
> > >     R x == 1
> > > 
> > >     while (! load_acq(p2));
> > >     R idx2 == idx1 // for some reason, we got lucky!
> > >     srcu_up(&ss,idx1);
> > > }
> > > 
> > > P1{
> > >     idx2 = srcu_down(&ss);
> > >     store_rel(p2, true);
> > > 
> > >     shared cs
> > > 
> > >     R y == 0
> > > 
> > >     while (! load_acq(p1));
> > >     srcu_up(&ss,idx2);
> > > }
> > > 
> > > P2 {
> > >     W y = 1
> > >     srcu_sync(&ss);
> > >     W x = 1
> > > }
> > > 
> > > 
> > > I can imagine models that allow this but they aren't pretty. Maybe you have
> > > a better operational model?
> > 
> > The operational model is not very detailed as far as SRCU is concerned.  
> > It merely says that synchronize_srcu() executing on CPU C waits until:
> > 
> > 	All writes received by C prior to the start of the function have 
> > 	propagated to all CPUs (call this time t1).  This could be 
> > 	arranged by having synchronize_srcu() start with an smp_mb().
> > 
> > 	For every srcu_down_read() that executed prior to t1, the 
> > 	matching srcu_up_read() has finished and all writes received 
> > 	by the unlocking CPU prior to the unlock have propagated to all 
> > 	CPUs.  This could be arranged by having the srcu_up_read() 
> > 	call include a release write which has been received by C and 
> > 	having synchronize_srcu() end with an smp_mb().
> 
> Agreed.  It took me a few reads to see that this prohibited later writes
> by other CPUs affecting reads in the prior critical section, but the "all
> writes received by the unlocking CPU" does seem to me to prohibit this.
> 
> > The operational model doesn't specify exactly how synchronize_srcu() 
> > manages to do these things, though.
> 
> Which is a good thing, given the wide variety of possible implementations.
> 
> > Oh yes, it also says that the value returned by srcu_down_read() is an 
> > unpredictable int.  This differs from the code in the patched herd 
> > model, which says that the value will always be 0.
> 
> As noted earlier, I believe that this is fine.  If significant problems
> arise, then we might need to do something.  However, there is some
> cost to complexity, so we should avoid getting too speculative about
> possible probems.
> 
> > Anyway, the operational model says the litmus test can succeed as 
> > follows:
> > 
> > P0                    P1                     P2
> > --------------------- ---------------------- -------------------------
> >                       Widx2=srcu_down_read()
> >                       Wrel p2=1
> >                       Ry=0
> >                                              Wy=1
> >                                              synchronize_srcu() starts
> > 	... idx2, p2, and y propagate to all CPUs ...
> >                                              Time t1
> > Widx1=srcu_down_read()
> > Wrel p1=1
> > 	,,, idx1 and p1 propagate to all CPUs ...
> >                       Racq p1=1
> >                       srcu_up_read(idx2)
> >                                              synchronize_srcu() ends
> >                                              Wx=1
> > Rx=1
> > Racq p2=1
> > Ridx2=idx1
> > srcu_up_read(idx1)
> > 
> > (The final equality in P0 is allowed because idx1 and idx2 are both 
> > random numbers, so they might be equal.)
> 
> This all makes sense to me.
> 
> > Incidentally, it's worth pointing out that the algorithm Paul described 
> > will forbid this litmus test even if you remove the while loop and the 
> > read of idx2 from P0.
> 
> Given that the values returned by those two srcu_down_read() calls must
> be the same, then, yes, the current Linux-kernel Tree RCU implementation
> would forbid this.
> 
> On the other hand, if the two indexes differ, then P2's synchronize_srcu()
> can see that there are no really old readers on !Widx2, then flip
> the index.  This would mean that P0's Widx1 would be equal to !Widx2,
> which has already been waited on.  Then P2's synchronize_srcu() can
> return as soon as it sees P1's srcu_up_read().

Sorry, what I said may not have been clear.  I meant that even if you 
remove the while loop and read of idx2 from P0, your algorithm will 
still not allow idx1 = idx2 provided everything else is as written.

> > 	If you don't pass the value to exactly one srcu_up_read() call, 
> > 	you void the SRCU warranty.  In addition, if you do anything 
> > 	else with the value that might affect the outcome of the litmus 
> > 	test, you incur the risk that herd7 might compute an incorrect 
> > 	result [as in the litmus test I gave near the start of this
> > 	email].
> > 
> > Merely storing the value in a shared variable which then doesn't get 
> > used or is used only for something inconsequential would not cause any 
> > problems.
> 
> That is consistent with my understanding, but please let me try again
> in list form:

...

> 4.	If a value returned from a given srcu_read_lock() is passed to
> 	exactly one srcu_read_unlock(), and then that value is later
> 	manipulated, that is bad practice (exactly what are you trying
> 	to accomplish by so doing?), but SRCU won't know the difference.
> 
> 	In particular, the Linux-kernel SRCU implementation doesn't know
> 	about the herd7 "exists" clause, but kudos to Jonas for casting
> 	his conceptual net widely indeed!

In addition, herd7 might give an answer different from what would 
actually happen in the kernel, depending on what the manipulation does.

Yes, that is more or less what I was trying to express.

Alan
