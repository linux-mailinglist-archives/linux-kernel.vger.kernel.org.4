Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4DE67875F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjAWURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAWURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:17:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540C34C13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:17:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC93B80E94
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48749C433EF;
        Mon, 23 Jan 2023 20:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674505020;
        bh=kq2ExAlpBw5+7g+/b6W0B1Cpiq4JKdLt0vagwVtLwTI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f6tCv5ZZYXL1Zu4qtAt/R5L3ZCeSu9s4tDidsYrJ8POXzEqWdRQO2LgAZ3FUmvk+y
         BaJSAgl2eOu3PS69duCl78164PJfkKVkutDxkqnws4G+Thw9JlR4SMiE73e5zVt+Mh
         pVhxarp+cYE84h9fe9nm6IixoW/QeLU4Mc1LWD52kwJfEbgk0VUnS+ixyowRBNi7w3
         6UZR+EzwytHIc9HMiHELuTOIy/o4z+IxqHAofX5+hU/pBYBZAq6Y65IUdgSV9E8wZk
         7Mg1vtnHK5e8uQknI8baqEf0QtxPBh5J1w2A43lJfXI5P7DNZkYPu2lTzfXYTIS38L
         9yDUNMXFBAI4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE4635C044F; Mon, 23 Jan 2023 12:16:59 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:16:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y82dWEW4RwclDTGM@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 03:32:24PM -0500, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 01:20:37PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 03:36:24PM -0500, Alan Stern wrote:
> > > On Fri, Jan 20, 2023 at 11:20:32AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 20, 2023 at 01:37:51PM -0500, Alan Stern wrote:
> > > > > srcu_read_unlock() does not need a full smp_mb().
> > > > 
> > > > That is quite possible, and that is what we are looking into.  And testing
> > > > thus far agrees with you.  But the grace-period ordering constraints
> > > > are quite severe, so this requires careful checking and severe testing.
> > > 
> > > If you're interested, I can provide a simple argument to show that the 
> > > Fundamental Law of RCU would continue to hold with only a release fence.  
> > > There is an added requirement: merely that synchronize_srcu() must have 
> > > an smp_mb() somewhere after its final read of the unlock counters -- 
> > > which your version of the algorithm already has.
> > 
> > Please!
> > 
> > For your amusement, here is a very informal argument that this is
> > the case:
> > 
> > https://docs.google.com/document/d/1xvwQzavmH474MBPAIBqVyvCrCcS5j2BpqhErPhRj7Is/edit?usp=sharing
> > 
> > See the "Read-Side Optimizations" section at the end.
> 
> It looks like you've got the basic idea.  Most of the complications seem 
> to arise from the different ways a grace period can happen.
> 
> Here's what I was thinking.  Let C be a read-side critical section, with 
> L being its invocation of srcu_down_read() and U being the matching 
> invocation of srcu_up_read().  Let idx be the index value read by L (and 
> used by U).  I will assume that L has the form:
> 
> 	idx = READ_ONCE(ss->index);
> 	temp = this_cpu(ss->lock)[idx];
> 	WRITE_ONCE(this_cpu(ss->lock)[idx], temp + 1)
> 	smp_mb();
> 
> (or whatever is the right syntax for incrementing a per-cpu array 
> element).

The actual code uses this_cpu_inc() in order to permit srcu_read_lock()
and srcu_read_unlock() to be used in softirq and interrupt handlers,
but yes, ignoring interrupts, this is the form.

>            Likewise, assume U has the form:
> 
> 	temp = this_cpu(ss->unlock)[idx];
> 	smp_store_release(&this_cpu(ss->unlock)[idx], temp + 1);

And same here.

> Let G be any SRCU grace period -- an invocation of synchronize_srcu(ss). 
> Assume G has the overall form:
> 
> 	accumulate_and_compare_loop(!ss->index);
> 	smp_mb();
> 	WRITE_ONCE(ss->index, !ss->index);
> 	smp_mb();
> 	accumulate_and_compare_loop(!ss->index);
> 
> where accumulate_and_compare_loop(i) has the form:
> 
> 	do {
> 		s = t = 0;
> 		for each CPU c:
> 			s += READ_ONCE(cpu(c, ss->unlock)[i]);
> 		smp_mb();
> 		for each CPU c:
> 			t += READ_ONCE(cpu(c, ss->lock)[i]);
> 	} while (s != t);
> 
> It's not too hard to show, and I trust you already believe, that in the 
> final iteration of the accumulate_and_compare_loop(i) call for which 
> i = idx, the lock-counter increment in L is observed if and only if the 
> unlock-counter increment in U is observed.  Thus we have two cases:
> 
> Case 1: Both of the increments are observed.  Since the increment in U 
> is a store-release, every write that propagated to U's CPU before the 
> increment is therefore visible to G's CPU before its last read of an 
> unlock counter.  Since the full fence in accumulate_and_compare_loop() 
> is executed after the last such read, these writes must propagate to 
> every CPU before G ends.
> 
> Case 2: Neither of the increments is observed.  Let W be any write which 
> propagated to G's CPU before G started.  Does W propagate to C before L 
> ends?  We have the following SB or RWC pattern:
> 
> 	G                          C
> 	------------------------   -----------------------
> 	W propagates to G's CPU    L writes lock counter
> 	G does smp_mb()            L does smp_mb()
> 	G reads L's lock counter   W propagates to C's CPU
> 
> (The smp_mb() in the left column is the one in 
> accumulate_and_compare_loop(idx), which precedes the reads of the lock 
> counters.)
> 
> If L's smp_mb() ended before G's did then L's write to the lock counter 
> would have propagated to G's CPU before G's smp_mb() ended, and hence G 
> would have observed the lock-counter increment.  Since this didn't 
> happen, we know that G's smp_mb() ends before L's does.  This means that 
> W must propagate to every CPU before L terminates, and hence before C's 
> critical section starts.
> 
> Together, these two cases cover the requirements of the Fundamental Law 
> of RCU.  The memory barrier in U was needed only in Case 1, and there it 
> only needed to be a release fence.

Looks good to me!

One twist is that the design of both SRCU and RCU are stronger than LKMM
requires, as illustrated by the litmus test at the end of this email.

I believe that your proof outline above also covers this case, but I
figure that I should ask.

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-observed-2

(*
 * Result: Sometimes
 *
 * But please note that the Linux-kernel SRCU implementation is designed
 * to provide Never.
 *)

{}

P0(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;
	int r2;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*y, 1);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r3);
}

P1(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*y);
	synchronize_srcu(s);
	WRITE_ONCE(*z, 1);
}

P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	WRITE_ONCE(*z, 2);
	smp_mb();
	r2 = READ_ONCE(*x);
}

exists (1:r1=1 /\ 1:r2=0 /\ z=1)
