Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C85675C52
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjATR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjATR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F9798FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A7D62048
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 17:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257C1C433EF;
        Fri, 20 Jan 2023 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674237485;
        bh=/ZdyZhBxfOiGdCU2uFEVnfOTiSOQJAMC3RsZpA+qcbA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a32/TknIp0rKVFV9cvYjMpjcnZrh+drImZ5Sxd5znvfjz37y19tqBau4VtmbhPmOw
         4cdpjH46mfw4XKibyB94f+QHqDVoZdevDwvDZeFVjACsv6FF3Pf0f66JwSQV9A3Aod
         fho0GQw6HoznnnOHF1ReOzO9nTb80qFwMPbXoLjTHQKG2GsPLOkyMuf/NcKI5TEaTY
         nWdOT9uWtGfFZIlHrFnOP4Y1Q29Y+NCm+i6uYmiPTIs3hBcQs9pNiGAo/N4DsPePQ4
         qUEwQM1xxn714wYeAE4WhkxOiL/igHJOKMPF/KR8jZx/acCvSgMgw8ULZvwq4I3B8o
         a5gSoOZ5rLihA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C155C5C17DC; Fri, 20 Jan 2023 09:58:04 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:58:04 -0800
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
Message-ID: <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:01:03AM -0500, Alan Stern wrote:
> On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> > There are pairs of per-CPU counters.  One pair (->srcu_lock_count[])
> > counts the number of srcu_down_read() operations that took place on
> > that CPU and another pair (->srcu_unlock_count[]) counts the number
> > of srcu_down_read() operations that took place on that CPU.  There is
> > an ->srcu_idx that selects which of the ->srcu_lock_count[] elements
> > should be incremented by srcu_down_read().  Of course, srcu_down_read()
> > returns the value of ->srcu_idx that it used so that the matching
> > srcu_up_read() will use that same index when incrementing its CPU's
> > ->srcu_unlock_count[].
> > 
> > Grace periods go something like this:
> > 
> > 1.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> > 
> > 2.	smp_mb().
> > 
> > 3.	Sum up the ->srcu_unlock_count[!ssp->srcu_idx] counters.
> 
> Presumably you meant to write "lock" here, not "unlock".

You are quite right, and apologies for my confusion.

> > 4.	If the sums are not equal, retry from #1.
> > 
> > 5.	smp_mb().
> > 
> > 6.	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> > 
> > 7.	smp_mb().
> > 
> > 8.	Same loop as #1-4.
> > 
> > So similar to r/w semaphores, but with two separate distributed counts.
> > This means that the number of readers need not go to zero at any given
> > point in time, consistent with the need to wait only on old readers.
> 
> Reasoning from first principles, I deduce the following:
> 
> You didn't describe exactly how srcu_down_read() and srcu_up_read() 
> work.  Evidently the unlock increment in srcu_up_read() should have 
> release semantics, to prevent accesses from escaping out the end of the 
> critical section.  But the lock increment in srcu_down_read() has to be 
> stronger than an acquire; to prevent accesses in the critical section 
> escaping out the start, the increment has to be followed by smp_mb().

You got it!  There is some work going on to see if srcu_read_lock()'s
smp_mb() can be weakened to pure release, but we will see.

> The smp_mb() fences in steps 5 and 7 appear to be completely 
> unnecessary.

For correctness, agreed.  Their purpose is instead forward progress.
One can argue that step 5 is redundant due to control dependency, but
control dependencies are fragile, and as you say below, this code is
nowhere near a fastpath.

> Provided an smp_mb() is added at the very start and end of the grace 
> period, the memory barrier in step 2 and its copy in step 8 can be 
> demoted to smp_rmb().

This might need to be smp_mb() to allow srcu_read_unlock() to be
demoted to release ordering.  Work in progress.

> These changes would be small optimizations at best, and you may consider 
> them unimportant in view of the fact that grace periods often last quite 
> a long time.

Agreed, keeping it simple and obvious is important on this code, which
is nowhere near a fastpath.  The case of srcu_read_unlock() is another
thing altogether.

							Thanx, Paul
