Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C44675DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjATTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjATTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:20:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C329155
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53DE61F61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C131C433EF;
        Fri, 20 Jan 2023 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674242433;
        bh=gA/x6nMJb7zcEt6OE7Ll6cxzMPt3SOU4GAAhL7ZrvHU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JAF8In5luBqauxtBPwMKQOsTBDdBjsx5z6FAu8ve8/H4/qvGAwoZIyU3hXrsSndm1
         RfWJ7zTaUISoUFZJ247VU5Uo+XnI0ACuYz4/dxrbYEWdPaoDIx7biSP+ATjOkYUvoA
         xG3FTgXbvUKTarRmj/7u0kCcYJj8liW28Y1r5eiOAvn8KEeSeS4RCdOT5/4duILab9
         d78rxm0aVq+OyI7xJ1KuAkXKzDWSOdgJsCIg6xwRPFFSBm8FFTG5HU4YQQ/K8lhMhe
         YoT222g0tQ5sL1R7VPloM3Q7dEbQoEOMPLe5ejp7nnQxNAv1JjfsjgrRQmtt3Tjegr
         jWfbe3MNwSmsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECAFD5C17DC; Fri, 20 Jan 2023 11:20:32 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:20:32 -0800
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
Message-ID: <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:37:51PM -0500, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 09:58:04AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 11:01:03AM -0500, Alan Stern wrote:
> > > On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> > > > There are pairs of per-CPU counters.  One pair (->srcu_lock_count[])
> > > > counts the number of srcu_down_read() operations that took place on
> > > > that CPU and another pair (->srcu_unlock_count[]) counts the number
> > > > of srcu_down_read() operations that took place on that CPU.  There is
> > > > an ->srcu_idx that selects which of the ->srcu_lock_count[] elements
> > > > should be incremented by srcu_down_read().  Of course, srcu_down_read()
> > > > returns the value of ->srcu_idx that it used so that the matching
> > > > srcu_up_read() will use that same index when incrementing its CPU's
> > > > ->srcu_unlock_count[].
> > > > 
> > > > Grace periods go something like this:
> > > > 
> > > > 1.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> > > > 
> > > > 2.	smp_mb().
> > > > 
> > > > 3.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> > > 
> > > Presumably you meant to write "lock" here, not "unlock".
> > 
> > You are quite right, and apologies for my confusion.
> > 
> > > > 4.	If the sums are not equal, retry from #1.
> > > > 
> > > > 5.	smp_mb().
> > > > 
> > > > 6.	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> > > > 
> > > > 7.	smp_mb().
> > > > 
> > > > 8.	Same loop as #1-4.
> > > > 
> > > > So similar to r/w semaphores, but with two separate distributed counts.
> > > > This means that the number of readers need not go to zero at any given
> > > > point in time, consistent with the need to wait only on old readers.
> > > 
> > > Reasoning from first principles, I deduce the following:
> > > 
> > > You didn't describe exactly how srcu_down_read() and srcu_up_read() 
> > > work.  Evidently the unlock increment in srcu_up_read() should have 
> > > release semantics, to prevent accesses from escaping out the end of the 
> > > critical section.  But the lock increment in srcu_down_read() has to be 
> > > stronger than an acquire; to prevent accesses in the critical section 
> > > escaping out the start, the increment has to be followed by smp_mb().
> > 
> > You got it!  There is some work going on to see if srcu_read_lock()'s
> > smp_mb() can be weakened to pure release, but we will see.
> 
> That doesn't make sense.  Release ordering in srcu_read_lock() would 
> only prevent accesses from leaking _in_ to the critical section.  It 
> would do nothing to prevent accesses from leaking _out_.

Yes, I should have said srcu_read_unlock().  I do seem to be having
lock/unlock difficulties.  :-/

We could remove the smp_mb() from srcu_read_lock(), but at the expense
of a round of IPIs from the grace-period code, along with interactions
with things like the CPU-hotplug code paths.  I am not proposing
doing that, for one thing, one of the attractions of SRCU is its fast
and disturbance-free grace period when there are no readers in flight.
It is possible, though: Tasks Trace RCU does just this, IPIs, CPU hotplug,
and all.

There are other ways to do this, but the ones I know of would restrict
the contexts in which srcu_read_lock() and srcu_read_unlock() can be
executed, for example, in the context of offline CPUs.

> > > The smp_mb() fences in steps 5 and 7 appear to be completely 
> > > unnecessary.
> > 
> > For correctness, agreed.  Their purpose is instead forward progress.
> 
> It's hard to say whether they would be effective at that.  smp_mb() 
> forces the processor to wait until some time when previous writes have 
> become visible to all CPUs.  But if you don't wait for that potentially 
> excessively long delay, you may be able to continue and be lucky enough 
> to find that all previous writes have already become visible to all the 
> CPUs that matter.
> 
> As far as I know, smp_mb() doesn't expedite the process of making 
> previous writes visible.  However, I am very far from being an expert 
> on system architecture design.

As you noticed, without the step-7 smp_mb(), a potentially large number
of invocations of srcu_read_lock() could use the old index value, that
is, the inces value that is to be counted in step 8.  Then the step-8
phase of the grace period could unncessarily wait on those readers.

Similarly, without the step-5 smp_mb() and without the control
dependencies extending from the loads feeding into step 4's sum,
srcu_read_lock() and srcu_read_unlock() on other CPUs might prematurely
use the new index, which could force the step 1-4 phase of the grace
period to unnecessarily wait on those readers.

> > One can argue that step 5 is redundant due to control dependency, but
> > control dependencies are fragile, and as you say below, this code is
> > nowhere near a fastpath.
> 
> Also, control dependencies do not contribute to forward progress.

I might be mistaken, and you can argue that the risk is small, but without
that ordering, step 4 could see unintended increments that could force
unnecessary retries of steps 1-3.

> > > Provided an smp_mb() is added at the very start and end of the grace 
> > > period, the memory barrier in step 2 and its copy in step 8 can be 
> > > demoted to smp_rmb().
> > 
> > This might need to be smp_mb() to allow srcu_read_unlock() to be
> > demoted to release ordering.  Work in progress.
> 
> I thought srcu_read_unlock() already _is_ a release operation.  The 
> smp_mb() fence mentioned earlier needs to be in srcu_read_lock(), not 
> unlock().  And there's no way that one can be demoted.

Agreed, my mistake earlier.  The smp_mb() in srcu_read_lock() must
remaain smp_mb().

> srcu_read_unlock() does not need a full smp_mb().

That is quite possible, and that is what we are looking into.  And testing
thus far agrees with you.  But the grace-period ordering constraints
are quite severe, so this requires careful checking and severe testing.

> > > These changes would be small optimizations at best, and you may consider 
> > > them unimportant in view of the fact that grace periods often last quite 
> > > a long time.
> > 
> > Agreed, keeping it simple and obvious is important on this code, which
> > is nowhere near a fastpath.  The case of srcu_read_unlock() is another
> > thing altogether.
> 
> Unfortunately, the full fence in srcu_read_lock() is unavoidable without 
> very major changes to the algorithm -- probably a complete redesign.  
> Without it, a read inside the critical section could be executed before 
> the store part of the increment, which could lead synchronize_srcu() to 
> believe that the critical section had not yet started when in fact it 
> had.

I actually did type "srcu_read_unlock()" correctly in this case.  ;-)

But yes, removing the smp_mb() from srcu_read_lock() is not in the cards.
On the other hand, doing so for srcu_read_unlock() just might be both
doable and worthwhile.

							Thanx, Paul
