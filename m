Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CAC67A57C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjAXWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjAXWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:15:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D12CEC50
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E851AB816AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7EDC433D2;
        Tue, 24 Jan 2023 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674598524;
        bh=BtYx9xvLhys/0OqlUuW88DW4J11v7lVFN5im9YpN2rI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NEKv0BVyFfDSdd2XtmGY67fos2tdYZcl35cAUwwuLU4kTadLEhMHwxOqW4L6Uy3Qg
         QdwPT48Yv/Ct4KLBUETrWnAmTS8NyXokPomhl76upPe/mdsBrzrs2OM76CfBCEDnNx
         HVpyqIuhEM1Jv7UbYxA7+WFVTcc9S7nGI8ilAmx3E6Vr2H8ukT06j3lySK2AR6OpxL
         e3Q2f9V85hqu0hPKovybCv5+VKlMGpuT5xjEQc0Q/jo5srgA9HwMQAMTAEtZfSMBpt
         ikFK1sCrw8prWKZwWUN7il7FbzsrPr1Hj4Sw0xOWiEWDI/m1ce8B5+iSrAq0wt3164
         /kaUO+0ww2SFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10C9D5C1183; Tue, 24 Jan 2023 14:15:24 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:15:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:30:08PM +0100, Jonas Oberhauser wrote:
> On 1/24/2023 6:26 PM, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 05:39:53PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/24/2023 5:22 PM, Paul E. McKenney wrote:
> > > > I clearly recall some
> > > > store-based lack of ordering after a grace period from some years back,
> > > > and am thus far failing to reproduce it.
> > > > 
> > > > And here is another attempt that herd7 actually does allow.
> > > > 
> > > > So what did I mess up this time?  ;-)
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > C C-srcu-observed-4
> > > > 
> > > > (*
> > > >    * Result: Sometimes
> > > >    *
> > > >    * The Linux-kernel implementation is suspected to forbid this.
> > > >    *)
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y, int *z, struct srcu_struct *s)
> > > > {
> > > > 	int r1;
> > > > 
> > > > 	r1 = srcu_read_lock(s);
> > > > 	WRITE_ONCE(*y, 2);
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	srcu_read_unlock(s, r1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z, struct srcu_struct *s)
> > > > {
> > > > 	int r1;
> > > > 
> > > > 	WRITE_ONCE(*y, 1);
> > > > 	synchronize_srcu(s);
> > > > 	WRITE_ONCE(*z, 2);
> > > > }
> > > > 
> > > > P2(int *x, int *y, int *z, struct srcu_struct *s)
> > > > {
> > > > 	WRITE_ONCE(*z, 1);
> > > > 	smp_store_release(x, 2);
> > > > }
> > > > 
> > > > exists (x=1 /\ y=1 /\ z=1)
> > > I think even if you implement the unlock as mb() followed by some store that
> > > is read by the gp between mb()s, this would still be allowed.
> > The implementation of synchronize_srcu() has quite a few smp_mb()
> > invocations.
> > 
> > But exactly how are you modeling this?  As in what additional accesses
> > and memory barriers are you placing in which locations?
> 
> Along these lines:
> 
> P0(int *x, int *y, int *z, int *magic_location)
> {
> 	int r1;
> 
> 
> 	WRITE_ONCE(*y, 2);
> 	WRITE_ONCE(*x, 1);
> 
>         smp_mb();
> 	WRITE_ONCE(*magic_location, 1);
> 
> }
> 
> P1(int *x, int *y, int *z, int *magic_location)
> {
> 	int r1;
> 
> 	WRITE_ONCE(*y, 1);
> 
>         smp_mb();
>         while (! READ_ONCE(*magic_location))
> 		;
> 	smp_mb();
> 	WRITE_ONCE(*z, 2);
> }
> 
> 
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*z, 1);
> 	smp_store_release(x, 2);
> }
> 
> 
> 
> Note that you can add as many additional smp_mb() and other accesses as you
> want around the original srcu call sites. I don't see how they could
> influence the absence of a cycle.
> 
> (Also, to make it work with herd it seems you need to replace the loop with
> a single read and state in the exists clause that it happens to read a 1.)

I agree that LKMM would allow such a litmus test.

> > > I have already forgotten the specifics, but I think the power model allows
> > > certain stores never propagating somewhere?
> > PowerPC would forbid the 3.2W case, where each process used an
> > smp_store_release() as its sole ordering (no smp_mb() calls at all).
> > 
> > [...]
> > 
> > This propagation is modulated by the memory barriers, though.
> 
> Ah, looking at the model now. Indeed it's forbidden, because in order to say
> that something is in co, there must not be a (resulting) cycle of co and
> barriers. But you'd get that here.  In the axiomatic model, this corresponds
> to saying Power's "prop | co" is acyclic. The same isn't true in LKMM. So
> that's probably why.

Which means that the RCU and SRCU implementations need to make (admittedly
small) guarantees that cannot be expressed in LKMM.  Which is in fact
what I was remembering, so I feel better now.

Not sure about the rest of you, though.  ;-)

							Thanx, Paul
