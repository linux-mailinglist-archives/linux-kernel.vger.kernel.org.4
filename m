Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB0675969
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjATQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:01:08 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id ABF01707C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:01:04 -0800 (PST)
Received: (qmail 37304 invoked by uid 1000); 20 Jan 2023 11:01:03 -0500
Date:   Fri, 20 Jan 2023 11:01:03 -0500
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
Message-ID: <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
References: <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> There are pairs of per-CPU counters.  One pair (->srcu_lock_count[])
> counts the number of srcu_down_read() operations that took place on
> that CPU and another pair (->srcu_unlock_count[]) counts the number
> of srcu_down_read() operations that took place on that CPU.  There is
> an ->srcu_idx that selects which of the ->srcu_lock_count[] elements
> should be incremented by srcu_down_read().  Of course, srcu_down_read()
> returns the value of ->srcu_idx that it used so that the matching
> srcu_up_read() will use that same index when incrementing its CPU's
> ->srcu_unlock_count[].
> 
> Grace periods go something like this:
> 
> 1.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> 
> 2.	smp_mb().
> 
> 3.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.

Presumably you meant to write "lock" here, not "unlock".

> 
> 4.	If the sums are not equal, retry from #1.
> 
> 5.	smp_mb().
> 
> 6.	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> 
> 7.	smp_mb().
> 
> 8.	Same loop as #1-4.
> 
> So similar to r/w semaphores, but with two separate distributed counts.
> This means that the number of readers need not go to zero at any given
> point in time, consistent with the need to wait only on old readers.

Reasoning from first principles, I deduce the following:

You didn't describe exactly how srcu_down_read() and srcu_up_read() 
work.  Evidently the unlock increment in srcu_up_read() should have 
release semantics, to prevent accesses from escaping out the end of the 
critical section.  But the lock increment in srcu_down_read() has to be 
stronger than an acquire; to prevent accesses in the critical section 
escaping out the start, the increment has to be followed by smp_mb().

The smp_mb() fences in steps 5 and 7 appear to be completely 
unnecessary.

Provided an smp_mb() is added at the very start and end of the grace 
period, the memory barrier in step 2 and its copy in step 8 can be 
demoted to smp_rmb().

These changes would be small optimizations at best, and you may consider 
them unimportant in view of the fact that grace periods often last quite 
a long time.

Alan
