Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801167B848
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjAYRSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjAYRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:18:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE06B469
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:18:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B6861599
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5C0C433D2;
        Wed, 25 Jan 2023 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674667112;
        bh=mxJ3PYwtfCpG+djmSWMaOFmJZBmxC0t3vTB/RbPWHVU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d8HV19O123guAuVC87/ZTu/bu6RAmloZYl61V9bOHk7VWiE2y0pwyDM5NwtA6hnHL
         PQkCTzUTlc4PwZYb1JFJXRwZDUNf1pxwob1yBDZffPOy6eYdqKvgGSYxf4jJi1cmNj
         eSjfHF6QrzwbOP6e/TpCKUxu9iPHm6v64TUxxHPlBDyGmtp++IYHrCIXzE8YRG9T6d
         ncL6DixRwukmUvxGE0WPYKuc7yg3vqdKhBuPq/SMPirCnMr8vOePLQCI+ktcTdvx0F
         crYWS6azmjNN+BFDRBw4rwfePreqxdMjN5yHW6X1btjx1PP2pbD/Vuu9iWmbDD6mVy
         Yx+4VyG8+WScQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 267D85C03B9; Wed, 25 Jan 2023 09:18:32 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:18:32 -0800
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
Message-ID: <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:34:40AM -0500, Alan Stern wrote:
> On Wed, Jan 25, 2023 at 07:05:20AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 25, 2023 at 02:10:08PM +0100, Jonas Oberhauser wrote:
> > > 
> > > 
> > > On 1/25/2023 3:20 AM, Paul E. McKenney wrote:
> > > > On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
> > > > > On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
> > > > > > 
> > > > > > Within the Linux kernel, the rule for a given RCU "domain" is that if
> > > > > > an event follows a grace period in pretty much any sense of the word,
> > > > > > then that event sees the effects of all events in all read-side critical
> > > > > > sections that began prior to the start of that grace period.
> > > > > > 
> > > > > > Here the senses of the word "follow" include combinations of rf, fr,
> > > > > > and co, combined with the various acyclic and irreflexive relations
> > > > > > defined in LKMM.
> > > > > The LKMM says pretty much the same thing.  In fact, it says the event
> > > > > sees the effects of all events po-before the unlock of (not just inside)
> > > > > any read-side critical section that began prior to the start of the
> > > > > grace period.
> > > > > 
> > > > > > > And are these anything the memory model needs to worry about?
> > > > > > Given that several people, yourself included, are starting to use LKMM
> > > > > > to analyze the Linux-kernel RCU implementations, maybe it does.
> > > > > > 
> > > > > > Me, I am happy either way.
> > > > > Judging from your description, I don't think we have anything to worry
> > > > > about.
> > > > Sounds good, and let's proceed on that assumption then.  We can always
> > > > revisit later if need be.
> > > > 
> > > > 							Thanx, Paul
> > > 
> > > FWIW, I currently don't see a need for either RCU nor "base" LKMM to have
> > > this kind of guarantee.
> > 
> > In the RCU case, it is because it is far easier to provide this guarantee,
> > even though it is based on hardware and compilers rather than LKMM,
> > than it would be to explain to some random person why the access that
> > is intuitively clearly after the grace period can somehow come before it.
> > 
> > > But I'm curious for why it doesn't exist in LKMM -- is it because of Alpha
> > > or some other issues that make it hard to guarantee (like a compiler merging
> > > two threads and optimizing or something?), or is it simply that it seemed
> > > like a complicated guarantee with no discernible upside, or something else?
> > 
> > Because to the best of my knowledge, no one has ever come up with a
> > use for 2+2W and friends that isn't better handled by some much more
> > straightforward pattern of accesses.  So we did not guarantee it in LKMM.
> > 
> > Yes, you could argue that my "ease of explanation" paragraph above is
> > a valid use case, but I am not sure that this is all that compelling of
> > an argument.  ;-)
> 
> Are we all talking about the same thing?  There were two different 
> guarantees mentioned above:
> 
> 	The RCU guarantee about writes in a read-side critical section
> 	becoming visible to all CPUs before a later grace period ends;
> 
> 	The guarantee about the 2+2W pattern and friends being 
> 	forbidden.
> 
> The LKMM includes the first of these but not the second (for the reason 
> Paul stated).

I am not sure whether or not we are talking about the same thing,
but given this litmus test:

------------------------------------------------------------------------

C C-srcu-observed-4

(*
 * Result: Sometimes
 *
 * The Linux-kernel implementation is suspected to forbid this.
 *)

{}

P0(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*y, 2);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r1);
}

P1(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	WRITE_ONCE(*y, 1);
	synchronize_srcu(s);
	WRITE_ONCE(*z, 2);
}

P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	WRITE_ONCE(*z, 1);
	smp_store_release(x, 2);
}

exists (x=1 /\ y=1 /\ z=1)

------------------------------------------------------------------------

We get the following from herd7:

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg C-srcu-observed-4.litmus
Test C-srcu-observed-4 Allowed
States 8
x=1; y=1; z=1;
x=1; y=1; z=2;
x=1; y=2; z=1;
x=1; y=2; z=2;
x=2; y=1; z=1;
x=2; y=1; z=2;
x=2; y=2; z=1;
x=2; y=2; z=2;
Ok
Witnesses
Positive: 1 Negative: 7
Condition exists (x=1 /\ y=1 /\ z=1)
Observation C-srcu-observed-4 Sometimes 1 7
Time C-srcu-observed-4 0.02
Hash=8b6020369b73ac19070864a9db00bbf8

------------------------------------------------------------------------

This does not seem to me to be consistent with your "The RCU guarantee
about writes in a read-side critical section becoming visible to all
CPUs before a later grace period ends".

So what am I missing here?

Again, I am OK with LKMM allowing C-srcu-observed-4.litmus, as long as
the actual Linux-kernel implementation forbids it.

							Thanx, Paul
