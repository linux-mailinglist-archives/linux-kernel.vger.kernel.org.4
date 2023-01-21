Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31A5676812
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAUSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F71F5D7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A2D060ADD
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 18:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B035C433EF;
        Sat, 21 Jan 2023 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674326432;
        bh=kMWIzHJn3ScgxAKaE9K4mDKpufuqbv0mKc7mM2MRZdk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UzctnnfGJekMF+D5g02Hrrqk4ZB8UsQ+5KK8dVQNQWrH4JbCxuHtcxKM/PQ4H7dvc
         82mP+4uc3hdfVOQFuaIKn5sa7lQ4deY2AfJ7An/lzumI159Azxu6M5AfayKUy/nsQC
         UdrbUhgROQ280LHj3vKu6br5xL6Ea6afUjVWlrawRUTgwYNKeUVOAib+JBcse+J0+f
         4x2PMxDmD3hv63LmK5/0YAlRysEXy4pwAlwKIdntHzDn3n9xpWTFrcHN72Zs89z13Q
         g9nTvzaT4CklM4TK504XkmuaI9/YCHUpbhH5Zx4F3Dldv4+DGFKQPaNYve/JabvHCs
         eYnelMQCM2rQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 303165C06AB; Sat, 21 Jan 2023 10:40:32 -0800 (PST)
Date:   Sat, 21 Jan 2023 10:40:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20230121184032.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8wimpMpajLudrYb@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:36:26PM -0500, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > On 1/20/2023 5:18 PM, Alan Stern wrote:
> > > On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
> > > > Perhaps we could say that reading an index without using it later is
> > > > forbidden?
> > > > 
> > > > flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
> > > > thrown-srcu-cookie-on-floor
> > > We already flag locks that don't have a matching unlock.
> > 
> > Of course, but as you know this is completely orthogonal.
> 
> Yeah, okay.  It doesn't hurt to add this check, but the check isn't 
> complete.  For example, it won't catch the invalid usage here:
> 
> P0(srcu_struct *ss)
> {
> 	int r1, r2;
> 
> 	r1 = srcu_read_lock(ss);
> 	srcu_read_unlock(&ss, r1);
> 	r2 = srcu_read_lock(ss);
> 	srcu_read_unlock(&ss, r2);
> }
> 
> exists (~0:r1=0:r2)
> 
> On the other hand, how often will people make this sort of mistake in 
> their litmus tests?  My guess is not very.

I must be blind this morning.  I see a well-formed pair of back-to-back
SRCU read-side critical sections.  A rather useless pair, given that
both are empty, but valid nonetheless.

Or is the bug the use of 0:r1 and 0:r2 in the "exists" clause?  If so,
then I agree that this is not at all a high-priority bug to flag.

> > Can you briefly explain how the operational model you have in mind for
> > srcu's up and down allows x==1 (and y==0 and idx1==idx2) in the example I
> > sent before (copied with minor edit below for convenience)?
> > 
> > P0{
> >     idx1 = srcu_down(&ss);
> >     store_rel(p1, true);
> > 
> > 
> >     shared cs
> > 
> >     R x == 1
> > 
> >     while (! load_acq(p2));
> >     R idx2 == idx1 // for some reason, we got lucky!
> >     srcu_up(&ss,idx1);
> > }
> > 
> > P1{
> >     idx2 = srcu_down(&ss);
> >     store_rel(p2, true);
> > 
> >     shared cs
> > 
> >     R y == 0
> > 
> >     while (! load_acq(p1));
> >     srcu_up(&ss,idx2);
> > }
> > 
> > P2 {
> >     W y = 1
> >     srcu_sync(&ss);
> >     W x = 1
> > }
> > 
> > 
> > I can imagine models that allow this but they aren't pretty. Maybe you have
> > a better operational model?
> 
> The operational model is not very detailed as far as SRCU is concerned.  
> It merely says that synchronize_srcu() executing on CPU C waits until:
> 
> 	All writes received by C prior to the start of the function have 
> 	propagated to all CPUs (call this time t1).  This could be 
> 	arranged by having synchronize_srcu() start with an smp_mb().
> 
> 	For every srcu_down_read() that executed prior to t1, the 
> 	matching srcu_up_read() has finished and all writes received 
> 	by the unlocking CPU prior to the unlock have propagated to all 
> 	CPUs.  This could be arranged by having the srcu_up_read() 
> 	call include a release write which has been received by C and 
> 	having synchronize_srcu() end with an smp_mb().

Agreed.  It took me a few reads to see that this prohibited later writes
by other CPUs affecting reads in the prior critical section, but the "all
writes received by the unlocking CPU" does seem to me to prohibit this.

> The operational model doesn't specify exactly how synchronize_srcu() 
> manages to do these things, though.

Which is a good thing, given the wide variety of possible implementations.

> Oh yes, it also says that the value returned by srcu_down_read() is an 
> unpredictable int.  This differs from the code in the patched herd 
> model, which says that the value will always be 0.

As noted earlier, I believe that this is fine.  If significant problems
arise, then we might need to do something.  However, there is some
cost to complexity, so we should avoid getting too speculative about
possible probems.

> Anyway, the operational model says the litmus test can succeed as 
> follows:
> 
> P0                    P1                     P2
> --------------------- ---------------------- -------------------------
>                       Widx2=srcu_down_read()
>                       Wrel p2=1
>                       Ry=0
>                                              Wy=1
>                                              synchronize_srcu() starts
> 	... idx2, p2, and y propagate to all CPUs ...
>                                              Time t1
> Widx1=srcu_down_read()
> Wrel p1=1
> 	,,, idx1 and p1 propagate to all CPUs ...
>                       Racq p1=1
>                       srcu_up_read(idx2)
>                                              synchronize_srcu() ends
>                                              Wx=1
> Rx=1
> Racq p2=1
> Ridx2=idx1
> srcu_up_read(idx1)
> 
> (The final equality in P0 is allowed because idx1 and idx2 are both 
> random numbers, so they might be equal.)

This all makes sense to me.

> Incidentally, it's worth pointing out that the algorithm Paul described 
> will forbid this litmus test even if you remove the while loop and the 
> read of idx2 from P0.

Given that the values returned by those two srcu_down_read() calls must
be the same, then, yes, the current Linux-kernel Tree RCU implementation
would forbid this.

On the other hand, if the two indexes differ, then P2's synchronize_srcu()
can see that there are no really old readers on !Widx2, then flip
the index.  This would mean that P0's Widx1 would be equal to !Widx2,
which has already been waited on.  Then P2's synchronize_srcu() can
return as soon as it sees P1's srcu_up_read().

> Does this answer your question satisfactorily?
> 
> > > > So if there is an srcu_down() that produces a cookie that is read by some
> > > > read R, and R doesn't then pass that value into an srcu_up(), the
> > > > srcu-warranty is voided.
> > > No, it isn't.
> > I quote Paul:
> > "If you do anything else at all with it, anything at all, you just voided
> > your SRCU warranty. For that matter, if you just throw that value on the
> > floor and don't pass it to an srcu_up_read() execution, you also just voided
> > your SRCU warranty."
> 
> I suspect Paul did not express himself very precisely,

You know me too well!  ;-)

>                                                        and what he 
> really meant was more like this:
> 
> 	If you don't pass the value to exactly one srcu_up_read() call, 
> 	you void the SRCU warranty.  In addition, if you do anything 
> 	else with the value that might affect the outcome of the litmus 
> 	test, you incur the risk that herd7 might compute an incorrect 
> 	result [as in the litmus test I gave near the start of this
> 	email].
> 
> Merely storing the value in a shared variable which then doesn't get 
> used or is used only for something inconsequential would not cause any 
> problems.

That is consistent with my understanding, but please let me try again
in list form:

1.	If a value returned from a given srcu_read_lock() is never passed
	to an srcu_read_unlock(), later calls to synchronize_srcu()
	are within their rights to simply never return.

2.	If a value returned from a given srcu_read_lock() is modified in
	any way before being passed to an srcu_read_unlock(), any calls
	to synchronize_srcu() that have not yet returned are within
	their rights to simply never return and they are also within
	their rights to return prematurely.

3.	If a value returned from a given srcu_read_lock() is passed to
	more than one srcu_read_unlock(), any calls to synchronize_srcu()
	that have not yet returned are within their rights to simply
	never return and they are also within their rights to return
	prematurely.

4.	If a value returned from a given srcu_read_lock() is passed to
	exactly one srcu_read_unlock(), and then that value is later
	manipulated, that is bad practice (exactly what are you trying
	to accomplish by so doing?), but SRCU won't know the difference.

	In particular, the Linux-kernel SRCU implementation doesn't know
	about the herd7 "exists" clause, but kudos to Jonas for casting
	his conceptual net widely indeed!

5.	All of the above apply with equal force to srcu_down_read()
	and srcu_up_read().

6.	If the value returned from a given srcu_read_lock() is transmitted
	to an srcu_read_unlock() on another thread, the SRCU algorithm
	will do the right thing, but lockdep will complain bitterly.
	(This is the use case that srcu_down_read() and srcu_up_read()
	are intended to address.)

This is not exactly concise, but does it help?

							Thanx, Paul
