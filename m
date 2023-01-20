Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B4675CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjATShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:37:53 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F19A2618BC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:37:51 -0800 (PST)
Received: (qmail 43159 invoked by uid 1000); 20 Jan 2023 13:37:51 -0500
Date:   Fri, 20 Jan 2023 13:37:51 -0500
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
Message-ID: <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
References: <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:58:04AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 11:01:03AM -0500, Alan Stern wrote:
> > On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> > > There are pairs of per-CPU counters.  One pair (->srcu_lock_count[])
> > > counts the number of srcu_down_read() operations that took place on
> > > that CPU and another pair (->srcu_unlock_count[]) counts the number
> > > of srcu_down_read() operations that took place on that CPU.  There is
> > > an ->srcu_idx that selects which of the ->srcu_lock_count[] elements
> > > should be incremented by srcu_down_read().  Of course, srcu_down_read()
> > > returns the value of ->srcu_idx that it used so that the matching
> > > srcu_up_read() will use that same index when incrementing its CPU's
> > > ->srcu_unlock_count[].
> > > 
> > > Grace periods go something like this:
> > > 
> > > 1.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> > > 
> > > 2.	smp_mb().
> > > 
> > > 3.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> > 
> > Presumably you meant to write "lock" here, not "unlock".
> 
> You are quite right, and apologies for my confusion.
> 
> > > 4.	If the sums are not equal, retry from #1.
> > > 
> > > 5.	smp_mb().
> > > 
> > > 6.	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> > > 
> > > 7.	smp_mb().
> > > 
> > > 8.	Same loop as #1-4.
> > > 
> > > So similar to r/w semaphores, but with two separate distributed counts.
> > > This means that the number of readers need not go to zero at any given
> > > point in time, consistent with the need to wait only on old readers.
> > 
> > Reasoning from first principles, I deduce the following:
> > 
> > You didn't describe exactly how srcu_down_read() and srcu_up_read() 
> > work.  Evidently the unlock increment in srcu_up_read() should have 
> > release semantics, to prevent accesses from escaping out the end of the 
> > critical section.  But the lock increment in srcu_down_read() has to be 
> > stronger than an acquire; to prevent accesses in the critical section 
> > escaping out the start, the increment has to be followed by smp_mb().
> 
> You got it!  There is some work going on to see if srcu_read_lock()'s
> smp_mb() can be weakened to pure release, but we will see.

That doesn't make sense.  Release ordering in srcu_read_lock() would 
only prevent accesses from leaking _in_ to the critical section.  It 
would do nothing to prevent accesses from leaking _out_.

> > The smp_mb() fences in steps 5 and 7 appear to be completely 
> > unnecessary.
> 
> For correctness, agreed.  Their purpose is instead forward progress.

It's hard to say whether they would be effective at that.  smp_mb() 
forces the processor to wait until some time when previous writes have 
become visible to all CPUs.  But if you don't wait for that potentially 
excessively long delay, you may be able to continue and be lucky enough 
to find that all previous writes have already become visible to all the 
CPUs that matter.

As far as I know, smp_mb() doesn't expedite the process of making 
previous writes visible.  However, I am very far from being an expert 
on system architecture design.

> One can argue that step 5 is redundant due to control dependency, but
> control dependencies are fragile, and as you say below, this code is
> nowhere near a fastpath.

Also, control dependencies do not contribute to forward progress.

> > Provided an smp_mb() is added at the very start and end of the grace 
> > period, the memory barrier in step 2 and its copy in step 8 can be 
> > demoted to smp_rmb().
> 
> This might need to be smp_mb() to allow srcu_read_unlock() to be
> demoted to release ordering.  Work in progress.

I thought srcu_read_unlock() already _is_ a release operation.  The 
smp_mb() fence mentioned earlier needs to be in srcu_read_lock(), not 
unlock().  And there's no way that one can be demoted.

srcu_read_unlock() does not need a full smp_mb().

> > These changes would be small optimizations at best, and you may consider 
> > them unimportant in view of the fact that grace periods often last quite 
> > a long time.
> 
> Agreed, keeping it simple and obvious is important on this code, which
> is nowhere near a fastpath.  The case of srcu_read_unlock() is another
> thing altogether.

Unfortunately, the full fence in srcu_read_lock() is unavoidable without 
very major changes to the algorithm -- probably a complete redesign.  
Without it, a read inside the critical section could be executed before 
the store part of the increment, which could lead synchronize_srcu() to 
believe that the critical section had not yet started when in fact it 
had.

Alan
