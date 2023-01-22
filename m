Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF2677268
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjAVUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:32:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6E5F193C5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:32:24 -0800 (PST)
Received: (qmail 104934 invoked by uid 1000); 22 Jan 2023 15:32:24 -0500
Date:   Sun, 22 Jan 2023 15:32:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y82dWEW4RwclDTGM@rowland.harvard.edu>
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:20:37PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 03:36:24PM -0500, Alan Stern wrote:
> > On Fri, Jan 20, 2023 at 11:20:32AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 20, 2023 at 01:37:51PM -0500, Alan Stern wrote:
> > > > srcu_read_unlock() does not need a full smp_mb().
> > > 
> > > That is quite possible, and that is what we are looking into.  And testing
> > > thus far agrees with you.  But the grace-period ordering constraints
> > > are quite severe, so this requires careful checking and severe testing.
> > 
> > If you're interested, I can provide a simple argument to show that the 
> > Fundamental Law of RCU would continue to hold with only a release fence.  
> > There is an added requirement: merely that synchronize_srcu() must have 
> > an smp_mb() somewhere after its final read of the unlock counters -- 
> > which your version of the algorithm already has.
> 
> Please!
> 
> For your amusement, here is a very informal argument that this is
> the case:
> 
> https://docs.google.com/document/d/1xvwQzavmH474MBPAIBqVyvCrCcS5j2BpqhErPhRj7Is/edit?usp=sharing
> 
> See the "Read-Side Optimizations" section at the end.

It looks like you've got the basic idea.  Most of the complications seem 
to arise from the different ways a grace period can happen.

Here's what I was thinking.  Let C be a read-side critical section, with 
L being its invocation of srcu_down_read() and U being the matching 
invocation of srcu_up_read().  Let idx be the index value read by L (and 
used by U).  I will assume that L has the form:

	idx = READ_ONCE(ss->index);
	temp = this_cpu(ss->lock)[idx];
	WRITE_ONCE(this_cpu(ss->lock)[idx], temp + 1)
	smp_mb();

(or whatever is the right syntax for incrementing a per-cpu array 
element).  Likewise, assume U has the form:

	temp = this_cpu(ss->unlock)[idx];
	smp_store_release(&this_cpu(ss->unlock)[idx], temp + 1);

Let G be any SRCU grace period -- an invocation of synchronize_srcu(ss). 
Assume G has the overall form:

	accumulate_and_compare_loop(!ss->index);
	smp_mb();
	WRITE_ONCE(ss->index, !ss->index);
	smp_mb();
	accumulate_and_compare_loop(!ss->index);

where accumulate_and_compare_loop(i) has the form:

	do {
		s = t = 0;
		for each CPU c:
			s += READ_ONCE(cpu(c, ss->unlock)[i]);
		smp_mb();
		for each CPU c:
			t += READ_ONCE(cpu(c, ss->lock)[i]);
	} while (s != t);

It's not too hard to show, and I trust you already believe, that in the 
final iteration of the accumulate_and_compare_loop(i) call for which 
i = idx, the lock-counter increment in L is observed if and only if the 
unlock-counter increment in U is observed.  Thus we have two cases:

Case 1: Both of the increments are observed.  Since the increment in U 
is a store-release, every write that propagated to U's CPU before the 
increment is therefore visible to G's CPU before its last read of an 
unlock counter.  Since the full fence in accumulate_and_compare_loop() 
is executed after the last such read, these writes must propagate to 
every CPU before G ends.

Case 2: Neither of the increments is observed.  Let W be any write which 
propagated to G's CPU before G started.  Does W propagate to C before L 
ends?  We have the following SB or RWC pattern:

	G                          C
	------------------------   -----------------------
	W propagates to G's CPU    L writes lock counter
	G does smp_mb()            L does smp_mb()
	G reads L's lock counter   W propagates to C's CPU

(The smp_mb() in the left column is the one in 
accumulate_and_compare_loop(idx), which precedes the reads of the lock 
counters.)

If L's smp_mb() ended before G's did then L's write to the lock counter 
would have propagated to G's CPU before G's smp_mb() ended, and hence G 
would have observed the lock-counter increment.  Since this didn't 
happen, we know that G's smp_mb() ends before L's does.  This means that 
W must propagate to every CPU before L terminates, and hence before C's 
critical section starts.

Together, these two cases cover the requirements of the Fundamental Law 
of RCU.  The memory barrier in U was needed only in Case 1, and there it 
only needed to be a release fence.

Alan
