Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB1674C37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjATF00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjATF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:26:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC77ED57
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:18:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 229EEB82678
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E34C433D2;
        Thu, 19 Jan 2023 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153667;
        bh=4q7UuSgnQj/XdomO6t3SiRsH3GQXdN+nFZBxlou396M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fTGNgBuswlUIpjUbMXRVrVwYbjz5O2MTMNxJ4z4PLkeGezAYx1rqQHRvWQr7HAuRd
         ekB7UDqpUtEGaG0WFfJGwEnStpIgOZTAwkpyE4dyMERkuT+b9nUrEAqBmz1sl2Kj5y
         aiTLTLa0swoiaMtivdLjurrpDV4w2lrVhk5+2ShrPQQvhEY5K8RNEeLu2/yoRsvCPd
         v1oKJaP+WHWYjEU2VBsFPbharFxR+R3Y6Trq36MeSSStMpLEyD2Pmy73HxFN2IM0yt
         g9TXJbV8U9FjoDVmPWxqwx0XRjE57P5ZfXqrXDHWVO3Aj5RKYPsJ4zLaVz0h92LxJz
         nVREMwro6N2QQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F9ED5C1A49; Thu, 19 Jan 2023 10:41:07 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:41:07 -0800
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
Message-ID: <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:39:01PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 1:11 AM, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
> > > What I was thinking of is more something like this:
> > > 
> > > P0{
> > >     idx1 = srcu_down(&ss);
> > >     srcu_up(&ss,idx1);
> > > }
> > > 
> > > P1{
> > >      idx2 = srcu_down(&ss);
> > >      srcu_up(&ss,idx2)
> > > }
> > And srcu_read_lock() and srcu_read_unlock() already do this.
> 
> I think I left out too much from my example.
> And filling in the details led me down a bit of a rabbit hole of confusion
> for a while.
> But here's what I ended up with:
> 
> 
> P0{
>     idx1 = srcu_down(&ss);
>     store_rel(p1, true);
> 
> 
>     shared cs
> 
>     R x == ?
> 
>     while (! load_acq(p2));
>     R idx2 == idx1 // for some reason, we got lucky!
>     srcu_up(&ss,idx1);

Although the current Linux-kernel implementation happens to be fine with
this sort of abuse, I am quite happy to tell people "Don't do that!"
For whatever it is worth, the Linux kernel would happily ignore the read
of idx2 and the comparison, and I am happy with its doing so.

There is still a data dependency running from the srcu_down_read() to
the srcu_up_read().  If you instead fed idx2 into the srcu_up_read(),
I believe that herd would yell at you (please see definitions below).

And if you tried feeding idx2 into the above srcu_up_read() without
checking for equality, the Linux kernel would give you an SRCU
grace-period hang.  So please don't do that.

The only valid use of the value returned from srcu_down_read() is to be
passed to a single execution of srcu_up_read().  If you do anything else
at all with it, anything at all, you just voided your SRCU warranty.
For that matter, if you just throw that value on the floor and don't
pass it to an srcu_up_read() execution, you also just voided your SRCU
warranty.

> }
> 
> P1{
>     idx2 = srcu_down(&ss);
>     store_rel(p2, true);
> 
>     shared cs
> 
>     R y == 0
> 
>     while (! load_acq(p1));
>     srcu_up(&ss,idx2);
> }
> 
> P2 {
>     W y = 1
>     srcu_sync(&ss);
>     W x = 1
> }

And you can do this with srcu_read_lock() and srcu_read_unlock().
In contrast, this actually needs srcu_down_read() and srcu_up_read():

------------------------------------------------------------------------

C C-srcu-nest-6

(*
 * Result: Never
 *
 * Flag unbalanced-srcu-locking
 * This would be valid for srcu_down_read() and srcu_up_read().
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1, int *idx)
{
	int r2;
	int r3;

	r3 = srcu_down_read(s1);
	WRITE_ONCE(*idx, r3);
	r2 = READ_ONCE(*y);
}

P1(int *x, int *y, struct srcu_struct *s1, int *idx)
{
	int r1;
	int r3;

	r1 = READ_ONCE(*x);
	r3 = READ_ONCE(*idx);
	srcu_up_read(s1, r3);
}

P2(int *x, int *y, struct srcu_struct *s1)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s1);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
exists (1:r1=1 /\ 0:r2=0)

------------------------------------------------------------------------

Here is the updated portion of linux-kernel.bell relative to Alan's
update:

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

And here is the updated portion of linux-kernel.def:

------------------------------------------------------------------------

srcu_down_read(X)  __load{srcu-lock}(*X)
srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }

------------------------------------------------------------------------

Could you please review the remainder to see what remains given the
usage restrictions that I called out above?

							Thanx, Paul

> Assuming that like indicated above both threads happen to read the same
> index, are you guaranteed that the shared cs lasts until both P0 and P1 have
> performed their final up?
> Is it allowed for P0 to read x==1?
> 
> If you define matching up&down as you do through the data link, then we get
> something like
> 
> P1's down ->po;prop;po  grace period
> thus
> P1's up  ->rcu-order  grace period
> P0's down ->po;hb;po  P1's up ->rcu-order grace period
> P0's up ->srcu-rscsi;rcu-link;rcu-order  grace-period
> Unfortunately, this is not enough to rcu-order  P0's up with the grace
> period -- you'd need a second rcu-gp for that!
> 
> Looking at it from the other side, because x reads x=1, we have
> grace period ->po;rfe;po P0's up
> and thus
> grace period ->rcu-order P0's down ->po;hb;po P1's up
> but again this would order the grace period with P1's up because you'd need
> a second grace period.
> 
> When sketching it out on paper, I couldn't find any forbidden cycles, and so
> x==1 would be allowed. (But as I side, I managed to confuse myself a few
> times with this, so if you find a forbidden cycle let me know).
> 
> But note that the synchronization in there and the fact that both have the
> same index ensures that the two grace periods overlap, in a hypothetical
> order it would be
>   down() -> down() -> up() -> up()
> (with any premutation of P0 and P1 over these events so that they each get 1
> up() and 1 down()) and thus the grace period must actually end after both,
> or start before both.
> 
> With the definition I offered, you would get
> P0's up() ->srcu-rscsi  P1's down()
> and
> P1's up() ->srcu-rscsi P0's down()
> and in particular
> 
> Rx1 ->po P0's up() ->srcu-rscsi  P1's down() ->po Ry0 ->prop Wy1 ->po
> srcu-gp on the same loc ->po Wx1 ->rfe Rx1
> which can be collapsed to
> Rx1 ->po;rcu-order;po;hb Rx1 which isn't irreflexive
> 
> Thus x==1 would be forbidden.
> 
> This is more semaphore-like, where the same cookie shared between threads
> implies that it's the same semaphore, and the overlapping guarantee (through
> synchronizing on p1,p2 in the beginning) means that the critical sections
> overlap.
> 
> In contrast, I wouldn't suggest the same for srcu_lock and srcu_unlock,
> where even though you may get the same cookie by accident, those might still
> be two completely independent critical sections.
> For example, you could imagine a single percpu counter _cnt (per index of
> course) that is incremented and decremented for lock() and unlock(), and the
> condition to pass an srcu_sync() of a given index is that the
> cpu[...]._cnt[idx] are all individually 0 and the sum of all ups[idx] is
> equal to the sum of all downs[idx].
> 
> If you create an operational model of up() and down() in terms of such a
> per-index semaphore, I think the x==1 case would similarly need to be
> forbidden. Since the grace period must end after P1's grace period, and P0's
> and P1's grace period overlap and use the same semaphore, the count is never
> 0 at any point in time either P0 or P1 are in the grace period, and so the
> grace period must also end after P0's grace period. But then x=1 can't yet
> have propagated to P0 when it reads x inside its grace period.
> 
> In contrast, if the operational model of lock() and unlock() is a per-index
> and per-cpu count, then the x==1 case would be allowed, e.g., as follows
> (time from left to right, all processes happen in parallel):
> P0:                      < Rx1         >
> P1: <    Ry0               >
> P2:           y=1  < P0!     P1! > x=1
> 
> here < and > mark the start and end of cs and gp, and Pn! is the time the gp
> realizes that Pn was not in a cs.
> 
> Best wishes,
> 
> jonas
> 
