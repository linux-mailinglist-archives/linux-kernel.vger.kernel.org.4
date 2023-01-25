Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7367C0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjAYXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:33:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5334D2915D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:33:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D85616D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49593C433D2;
        Wed, 25 Jan 2023 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674689589;
        bh=ER0BCPLzg7nKd1C0QfOGjv1kjQ4/6/8I1wR5Rm+DgiY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sZ7vEGq8yIZjynbxFA+dJKctIBHpdccAlZzd1RhC+j4pz9bDWbuvhAitBVjtYEZL3
         5R4NNi3MdZihShQEtfBD04CHX5O5CG2Fq0++tPnXqA96Nrkk47mRhhBH6uBvpOlZVi
         Ajt7YxLK8xaN/6IjwNMg0X5mqhez4P4gz4mifnlL4HvWfO4tpUEIcTdu0eub+DhfOk
         DDc3DMJHSt+b0Abaf537pQN7wAiaVbAe2LtHRG8PYMIpJGbkbooTb9gdKv45sH6+hs
         G9PdAXcC7kCe7uCByJ6qk4RVfblCxdk2GTT0AkfHw1R9NeVWPJ+w18VrREfsTFWpUW
         vSQ0DT9Bvp8zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB8005C0865; Wed, 25 Jan 2023 15:33:08 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:33:08 -0800
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
Message-ID: <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 01:38:32PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 03:46:14PM -0500, Alan Stern wrote:
> > On Wed, Jan 25, 2023 at 11:46:51AM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 25, 2023 at 02:08:59PM -0500, Alan Stern wrote:
> > > > Why do you want the implementation to forbid it?  The pattern of the 
> > > > litmus test resembles 3+3W, and you don't care whether the kernel allows 
> > > > that pattern.  Do you?
> > > 
> > > Jonas asked a similar question, so I am answering you both here.
> > > 
> > > With (say) a release-WRITE_ONCE() chain implementing N+2W for some
> > > N, it is reasonably well known that you don't get ordering, hardware
> > > support otwithstanding.  After all, none of the Linux kernel, C, and C++
> > > memory models make that guarantee.  In addition, the non-RCU barriers
> > > and accesses that you can use to create N+2W have been in very wide use
> > > for a very long time.
> > > 
> > > Although RCU has been in use for almost as long as those non-RCU barriers,
> > > it has not been in wide use for anywhere near that long.  So I cannot
> > > be so confident in ruling out some N+2W use case for RCU.
> > > 
> > > Such a use case could play out as follows:
> > > 
> > > 1.	They try LKMM on it, see that LKMM allows it, and therefore find
> > > 	something else that works just as well.  This is fine.
> > > 
> > > 2.	They try LKMM on it, see that LKMM allows it, but cannot find
> > > 	something else that works just as well.  They complain to us,
> > > 	and we either show them how to get the same results some other
> > > 	way or adjust LKMM (and perhaps the implementations) accordingly.
> > > 	These are also fine.
> > > 
> > > 3.	They don't try LKMM on it, see that it works when they test it,
> > > 	and they send it upstream.  The use case is entangled deeply
> > > 	enough in other code that no one spots it on review.  The Linux
> > > 	kernel unconditionally prohibits the cycle.  This too is fine.
> > > 
> > > 4.	They don't try LKMM on it, see that it works when they test it,
> > > 	and they send it upstream.  The use case is entangled deeply
> > > 	enough in other code that no one spots it on review.  Because RCU
> > > 	grace periods incur tens of microseconds of latency at a minimum,
> > > 	all tests (almost) always pass, just due to delays and unrelated
> > > 	accesses and memory barriers.  Even in kernels built with some
> > > 	future SRCU equivalent of CONFIG_RCU_STRICT_GRACE_PERIOD=y.
> > > 	But the Linux kernel allows the cycle when there is a new moon
> > > 	on Tuesday during a triple solar eclipse of Jupiter, a condition
> > > 	that is eventually met, and at the worst possible time and place.
> > > 
> > > 	This is absolutely the opposite of fine.
> > > 
> > > I don't want to deal with #4.  So this is an RCU-maintainer use case
> > > that I would like to avoid.  ;-)
> > 
> > Since it is well known that the non-RCU barriers in the Linux kernel, C, 
> > and C++ do not enforce ordering in n+nW, and seeing as how your litmus 
> > test relies on an smp_store_release() at one point, I think it's 
> > reasonable to assume people won't expect it to provide ordering.
> 
> The presence of that grace period, which is well known to have super-heavy
> ordering properties, will likely reduce the number of people whose
> expectations are aligned with LKMM.  :-/
> 
> Plus it is not easy to create something that meets the LKMM grace-period
> requirements without also making it provide this additional ordering on
> real systems.
> 
> > Ah, but what about a litmus test that relies solely on RCU?
> > 
> > rcu_read_lock	Wy=2		rcu_read_lock	Wv=2
> > Wx=2		synchronize_rcu	Wu=2		synchronize_rcu
> > Wy=1		Wu=1		Wv=1		Wx=1
> > rcu_read_unlock			rcu_read_unlock
> > 
> > exists (x=2 /\ y=2 /\ u=2 /\ v=2)
> > 
> > Luckily, this _is_ forbidden by the LKMM.  So I think you're okay.
> 
> Some times I get lucky!  ;-)
> 
> The reader-free counterpart of your test is also forbidden, which is no
> surprise given that smp_mb() also suffices.

Ah, and returning to the earlier question as to whether srcu_read_unlock()
can use release semantics instead of smp_mb(), at the very least, this
portion of the synchronize_srcu() function's header comment must change:

	On systems with more than one CPU, when synchronize_srcu()
	returns, each CPU is guaranteed to have executed a full
	memory barrier since the end of its last corresponding SRCU
	read-side critical section whose beginning preceded the call
	to synchronize_srcu().

I don't know of any SRCU code that relies on this, but it would be good to
check.	There used to (and might still) be RCU code relying on this, which
is why this sentence was added to the header comment in the first place.

							Thanx, Paul
