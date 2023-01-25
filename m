Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB567BAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAYTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjAYTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:46:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F445589BF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA045B819A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 19:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04FC433D2;
        Wed, 25 Jan 2023 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674676011;
        bh=5AWWkKAESQ1j1pnT+sy6f9hHSl97KrX1wEu0DL+nY8E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jin5WWVaLhWx6GrUnFlyCOiY4xaTiN74lXiZ5bSwxTxE0yIBuKlMrO6SNwB+3bnjd
         SvId5lhhNd0Rn+4Rv9IKufVojXIvRrUEzAStSmjryrFrsuaTKvF33fWOqBUQIBomae
         t32NPMImSQ6Kk/zJ5n5yDyA4WmydWF8LEKGp/TbVdWqgVyhRDb/JWD0OSTm09QA05m
         FHbCIcGo+hs69XNatE0gCsPOh8oSQ8iznrw8pzu7iWq8qYohmZrBxCWxFesky9BHbv
         4pYwyzaieJpdOcv1pGj01IZ3k4X2rcdXv1Ur9YiAowE4DCflFEKmMES4vXCmhYyZ+2
         lBYzRQv9Gxt4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2CDAB5C0865; Wed, 25 Jan 2023 11:46:51 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:46:51 -0800
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
Message-ID: <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:08:59PM -0500, Alan Stern wrote:
> On Wed, Jan 25, 2023 at 09:18:32AM -0800, Paul E. McKenney wrote:
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-observed-4
> > 
> > (*
> >  * Result: Sometimes
> >  *
> >  * The Linux-kernel implementation is suspected to forbid this.
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	r1 = srcu_read_lock(s);
> > 	WRITE_ONCE(*y, 2);
> > 	WRITE_ONCE(*x, 1);
> > 	srcu_read_unlock(s, r1);
> > }
> > 
> > P1(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	WRITE_ONCE(*y, 1);
> > 	synchronize_srcu(s);
> > 	WRITE_ONCE(*z, 2);
> > }
> > 
> > P2(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	WRITE_ONCE(*z, 1);
> > 	smp_store_release(x, 2);
> > }
> > 
> > exists (x=1 /\ y=1 /\ z=1)
> > 
> > ------------------------------------------------------------------------
> > 
> > We get the following from herd7:
> > 
> > ------------------------------------------------------------------------
> > 
> > $ herd7 -conf linux-kernel.cfg C-srcu-observed-4.litmus
> > Test C-srcu-observed-4 Allowed
> > States 8
> > x=1; y=1; z=1;
> > x=1; y=1; z=2;
> > x=1; y=2; z=1;
> > x=1; y=2; z=2;
> > x=2; y=1; z=1;
> > x=2; y=1; z=2;
> > x=2; y=2; z=1;
> > x=2; y=2; z=2;
> > Ok
> > Witnesses
> > Positive: 1 Negative: 7
> > Condition exists (x=1 /\ y=1 /\ z=1)
> > Observation C-srcu-observed-4 Sometimes 1 7
> > Time C-srcu-observed-4 0.02
> > Hash=8b6020369b73ac19070864a9db00bbf8
> > 
> > ------------------------------------------------------------------------
> > 
> > This does not seem to me to be consistent with your "The RCU guarantee
> > about writes in a read-side critical section becoming visible to all
> > CPUs before a later grace period ends".
> 
> Let's see.  That guarantee requires only that x=1 and y=2 become visible 
> to P1 and P2 before the grace period ends.  And since synchronize_srcu 
> is a strong fence, y=1 must become visible to P0 and P2 before the grace 
> period ends.  Presumably after y=2 does, because it overwrites y=2.  
> Okay so far.
> 
> Now at some point P2 executes x=2.  If this were to happen after the 
> grace period ended, it would overwrite x=1.  Therefore it must happen 
> before the grace period ends, and therefore P2 must also write z=1 
> before the grace period ends.
> 
> So we have P2 writing z=1 before P1 writes z=2.  But this doesn't mean 
> z=2 has to overwrite z=1!  (You had a diagram illustrating this point in 
> one of your own slides for a talk about the LKMM.)  Overwriting is 
> required only when the earlier write becomes visible to the later 
> write's CPU before the later write occurs, and nothing in this test 
> forces z=2 to propagate to P1 before the z=1 write executes.
> 
> So the litmus test's outcome can happen without violating my guarantee.

Makes sense, thank you!

> > So what am I missing here?
> 
> Can't tell.  I'm not sure why you think the litmus test isn't consistent 
> with the guarantee.

I was missing that additional non-temporal co link.

> > Again, I am OK with LKMM allowing C-srcu-observed-4.litmus, as long as
> > the actual Linux-kernel implementation forbids it.
> 
> Why do you want the implementation to forbid it?  The pattern of the 
> litmus test resembles 3+3W, and you don't care whether the kernel allows 
> that pattern.  Do you?

Jonas asked a similar question, so I am answering you both here.

With (say) a release-WRITE_ONCE() chain implementing N+2W for some
N, it is reasonably well known that you don't get ordering, hardware
support otwithstanding.  After all, none of the Linux kernel, C, and C++
memory models make that guarantee.  In addition, the non-RCU barriers
and accesses that you can use to create N+2W have been in very wide use
for a very long time.

Although RCU has been in use for almost as long as those non-RCU barriers,
it has not been in wide use for anywhere near that long.  So I cannot
be so confident in ruling out some N+2W use case for RCU.

Such a use case could play out as follows:

1.	They try LKMM on it, see that LKMM allows it, and therefore find
	something else that works just as well.  This is fine.

2.	They try LKMM on it, see that LKMM allows it, but cannot find
	something else that works just as well.  They complain to us,
	and we either show them how to get the same results some other
	way or adjust LKMM (and perhaps the implementations) accordingly.
	These are also fine.

3.	They don't try LKMM on it, see that it works when they test it,
	and they send it upstream.  The use case is entangled deeply
	enough in other code that no one spots it on review.  The Linux
	kernel unconditionally prohibits the cycle.  This too is fine.

4.	They don't try LKMM on it, see that it works when they test it,
	and they send it upstream.  The use case is entangled deeply
	enough in other code that no one spots it on review.  Because RCU
	grace periods incur tens of microseconds of latency at a minimum,
	all tests (almost) always pass, just due to delays and unrelated
	accesses and memory barriers.  Even in kernels built with some
	future SRCU equivalent of CONFIG_RCU_STRICT_GRACE_PERIOD=y.
	But the Linux kernel allows the cycle when there is a new moon
	on Tuesday during a triple solar eclipse of Jupiter, a condition
	that is eventually met, and at the worst possible time and place.

	This is absolutely the opposite of fine.

I don't want to deal with #4.  So this is an RCU-maintainer use case
that I would like to avoid.  ;-)

							Thanx, Paul
