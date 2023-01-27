Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361C267EBAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjA0Qyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjA0Qyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:54:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EE1ADD6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B40BB82163
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93BC4339B;
        Fri, 27 Jan 2023 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674838458;
        bh=piQYLUeO0v4Qhv4z0kkS8iV7ReaZ5dDkVhhX32yz3Zw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=USXJOyV9s6R5vKB3CbnVHpG2CIgvjgdhr/3ImHtSTHDAG6yipSiQ9+Wl6zNyqbqaT
         dSkVehgVO0j2/OFcA/Kx3LqbQvuMVO1fJPeYvytYuUoc8yO1kmD2iReASsOSPn/H6P
         QhptrKJTLbsgNk2WkRCqxazwBtojqAUrudaxP3ehX9M3xobFuMl9rb/+ed0KW2mEmq
         ZdNjP9PPA3d1NgNVMaYbj+r1MVoznn9+Hz0Fong03OVuGUYNcwHrhlL/tMOQdHDI5e
         ncnNvKUo9vix/c9BwldWc9ojkyY0RkmqGNaEdgpvSunevAaDh8JTvi1gEIt434HSIb
         8pZkoDzPZSIvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38DF95C0510; Fri, 27 Jan 2023 08:54:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:54:18 -0800
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
Message-ID: <20230127165418.GA955158@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
 <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
 <20230126184802.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <c94ad1d4-c7ac-4570-6f33-85656b041090@huaweicloud.com>
 <20230127165059.GV2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127165059.GV2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:50:59AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 27, 2023 at 04:03:16PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > On 1/26/2023 7:48 PM, Paul E. McKenney wrote:
> > > On Thu, Jan 26, 2023 at 01:17:49PM +0100, Jonas Oberhauser wrote:
> > > > [...]
> > > > Note that this interpretation is analogous to the promise of smp_mb__after_unlock_lock(), which says that an
> > > > UNLOCK+LOCK pair act as a full fence: here the read-side unlock+gp act as a
> > > > full memory barrier.
> > > Good point that the existing smp_mb__after_unlock_lock() can be used for
> > > any use cases relying on the more literal interpretation of this promise.
> > > We already have the work-around!  ;-)
> > 
> > Can it? I meant that the less-literal form is similar to the one given by
> > smp_mb__after_unlock_lock().

Apologies, missed this on the first go...

I suppose that you could have a situation where the grace period ended
between the srcu_read_unlock() and the smp_mb__after_unlock_lock(),
but how would software detect that?

							Thanx, Paul

> > > > [...] I suppose you might be able to write
> > > > some absurd client that inspects every store of the reader thread and sees
> > > > that there is no line in the reader side code that acts like a full fence.
> > > > But it would take a lot of effort to discern this.
> > > The usual litmus test is shown at the end of this email [...]
> > > > [...] I hope few people would have this unhealthy idea. But you
> > > > never know.
> > > Given that the more literal interpretation is not unreasonable, we should
> > > assume that someone somewhere might have interpreted it that way.
> > > 
> > > But I agree that the odds of someone actually relying on this are low,
> > > and any such use case can be fixed with smp_mb__before_srcu_read_unlock(),
> > > similar to smp_mb__after_srcu_read_unlock() that you note is already in use.
> > > 
> > > It would still be good to scan SRCU use for this sort of pattern, maybe
> > > manually, maybe via something like coccinelle.  Alternatively, I could
> > > post on my blog (with right of first refusal to LWN and you guys as
> > > co-authors) telling the community of our intent to change this and see
> > > what people say.  Probably both rather than either/or.
> > > 
> > > Thoughts?
> > 
> > My first thought is "there is a 'usual' litmus test for this?" :D
> > But yes, the test you have given has at least the same structure as what I
> > would expect.
> 
> Exactly!  ;-)
> 
> > Communicating this with the community sounds very reasonable.
> > 
> > For some automated combing, I'm really not sure what pattern to look for.
> > I'm afraid someone with a lot of time might have to look (semi-)manually.
> 
> Please continue giving it some thought.  The number of srcu_read_unlock()
> calls in v6.1 is about 250, which is within the realm of manual
> inspection, but it is all too easy to miss something.
> 
> 							Thanx, Paul
> 
> > Best wishes, jonas
> > 
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C C-srcu-observed-6
> > > 
> > > (*
> > >   * Result: Sometimes
> > >   *
> > >   * The result is Never if any of the smp_mb() calls is uncommented.
> > >   *)
> > > 
> > > {}
> > > 
> > > P0(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > > {
> > > 	int r1;
> > > 	int r2;
> > > 	int r3;
> > > 	int r4;
> > > 
> > > 	r1 = srcu_read_lock(s);
> > > 	WRITE_ONCE(*b, 2);
> > > 	r2 = READ_ONCE(*a);
> > > 	// smp_mb();
> > > 	srcu_read_unlock(s, r1);
> > > 	// smp_mb();
> > > 	r3 = READ_ONCE(*c);
> > > 	// smp_mb();
> > > 	r4 = READ_ONCE(*d);
> > > }
> > > 
> > > P1(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > > {
> > > 	WRITE_ONCE(*b, 1);
> > > 	synchronize_srcu(s);
> > > 	WRITE_ONCE(*c, 1);
> > > }
> > > 
> > > P2(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > > {
> > > 	WRITE_ONCE(*d, 1);
> > > 	smp_mb();
> > > 	WRITE_ONCE(*a, 1);
> > > }
> > > 
> > > exists (0:r2=1 /\ 0:r3=1 /\ 0:r4=0 /\ b=1)
> > 
