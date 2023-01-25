Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3467BD51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjAYUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjAYUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:47:13 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 470044EC1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:46:41 -0800 (PST)
Received: (qmail 226353 invoked by uid 1000); 25 Jan 2023 15:46:14 -0500
Date:   Wed, 25 Jan 2023 15:46:14 -0500
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
Message-ID: <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
References: <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 11:46:51AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 02:08:59PM -0500, Alan Stern wrote:
> > Why do you want the implementation to forbid it?  The pattern of the 
> > litmus test resembles 3+3W, and you don't care whether the kernel allows 
> > that pattern.  Do you?
> 
> Jonas asked a similar question, so I am answering you both here.
> 
> With (say) a release-WRITE_ONCE() chain implementing N+2W for some
> N, it is reasonably well known that you don't get ordering, hardware
> support otwithstanding.  After all, none of the Linux kernel, C, and C++
> memory models make that guarantee.  In addition, the non-RCU barriers
> and accesses that you can use to create N+2W have been in very wide use
> for a very long time.
> 
> Although RCU has been in use for almost as long as those non-RCU barriers,
> it has not been in wide use for anywhere near that long.  So I cannot
> be so confident in ruling out some N+2W use case for RCU.
> 
> Such a use case could play out as follows:
> 
> 1.	They try LKMM on it, see that LKMM allows it, and therefore find
> 	something else that works just as well.  This is fine.
> 
> 2.	They try LKMM on it, see that LKMM allows it, but cannot find
> 	something else that works just as well.  They complain to us,
> 	and we either show them how to get the same results some other
> 	way or adjust LKMM (and perhaps the implementations) accordingly.
> 	These are also fine.
> 
> 3.	They don't try LKMM on it, see that it works when they test it,
> 	and they send it upstream.  The use case is entangled deeply
> 	enough in other code that no one spots it on review.  The Linux
> 	kernel unconditionally prohibits the cycle.  This too is fine.
> 
> 4.	They don't try LKMM on it, see that it works when they test it,
> 	and they send it upstream.  The use case is entangled deeply
> 	enough in other code that no one spots it on review.  Because RCU
> 	grace periods incur tens of microseconds of latency at a minimum,
> 	all tests (almost) always pass, just due to delays and unrelated
> 	accesses and memory barriers.  Even in kernels built with some
> 	future SRCU equivalent of CONFIG_RCU_STRICT_GRACE_PERIOD=y.
> 	But the Linux kernel allows the cycle when there is a new moon
> 	on Tuesday during a triple solar eclipse of Jupiter, a condition
> 	that is eventually met, and at the worst possible time and place.
> 
> 	This is absolutely the opposite of fine.
> 
> I don't want to deal with #4.  So this is an RCU-maintainer use case
> that I would like to avoid.  ;-)

Since it is well known that the non-RCU barriers in the Linux kernel, C, 
and C++ do not enforce ordering in n+nW, and seeing as how your litmus 
test relies on an smp_store_release() at one point, I think it's 
reasonable to assume people won't expect it to provide ordering.

Ah, but what about a litmus test that relies solely on RCU?

rcu_read_lock	Wy=2		rcu_read_lock	Wv=2
Wx=2		synchronize_rcu	Wu=2		synchronize_rcu
Wy=1		Wu=1		Wv=1		Wx=1
rcu_read_unlock			rcu_read_unlock

exists (x=2 /\ y=2 /\ u=2 /\ v=2)

Luckily, this _is_ forbidden by the LKMM.  So I think you're okay.

Alan
