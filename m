Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C464DF61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLORK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLORJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:09:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD254222A3;
        Thu, 15 Dec 2022 09:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5324C61E6D;
        Thu, 15 Dec 2022 17:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A318DC433F0;
        Thu, 15 Dec 2022 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671124114;
        bh=BjSC4p6qs9G4cxFVKfgf+prYj1Il7cVlWF9Xla+bklI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bPWjRKWr7TBXiuZjbepvoke2AjFQGHVRJ3Kx1vYKpK8w805Kcr7NhbRCavIQ7nfqp
         JtMhecyB5eOYvMbTgDoRs+D4ZfzxosufPB6uvtLa+B0Z5Bz8i0C0z3FXRiGzLFC2Mn
         7yFWahGcxDj2XgT+IBvacETvC4pVrO6hIav8hS6v691et0flUHHj/MAZQcon64TISE
         oSPseoQDaP9LPPbuOqcHeIY4VO0nWajLgjmKHAFJgGxQfcnnRxOPcJXx7F6WPvEX9F
         QyeKlB+HCa+U780zOzp8GwSd1tnmt6++4bkGAjwb44TRJDqrna3HlaJM7BubMHCfh2
         rOLjmGgiaP/lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F2DE5C09D0; Thu, 15 Dec 2022 09:08:34 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:08:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     boqun.feng@gmail.com, joel@joelfernandes.org,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215165452.GA1957735@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:54:52PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 14, 2022 at 11:13:55AM -0800, Paul E. McKenney wrote:
> > The comment in srcu_readers_active_idx_check() following the smp_mb()
> > is out of date, hailing from a simpler time when preemption was disabled
> > across the bulk of __srcu_read_lock().  The fact that preemption was
> > disabled meant that the number of tasks that had fetched the old index
> > but not yet incremented counters was limited by the number of CPUs.
> > 
> > In our more complex modern times, the number of CPUs is no longer a limit.
> > This commit therefore updates this comment, additionally giving more
> > memory-ordering detail.
> > 
> > Reported-by: Boqun Feng <boqun.feng@gmail.com>
> > Reported-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Not really, while you guys were debating on that comment, I was still starring
> at the previous one (as usual).
> 
> Or to put it in an SRCU way, while you guys saw the flipped idx, I was still
> using the old one :)
> 
> > -	 * OK, how about nesting?  This does impose a limit on nesting
> > -	 * of floor(ULONG_MAX/NR_CPUS/2), which should be sufficient,
> > -	 * especially on 64-bit systems.
> > +	 * It can clearly do so once, given that it has already fetched
> > +	 * the old value of ->srcu_idx and is just about to use that value
> > +	 * to index its increment of ->srcu_lock_count[idx].  But as soon as
> > +	 * it leaves that SRCU read-side critical section, it will increment
> > +	 * ->srcu_unlock_count[idx], which must follow the updater's above
> > +	 * read from that same value.  Thus, as soon the reading task does
> > +	 * an smp_mb() and a later fetch from ->srcu_idx, that task will be
> > +	 * guaranteed to get the new index.  Except that the increment of
> > +	 * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
> > +	 * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
> > +	 * is before the smp_mb().  Thus, that task might not see the new
> > +	 * value of ->srcu_idx until the -second- __srcu_read_lock(),
> > +	 * which in turn means that this task might well increment
> > +	 * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
> > +	 * not just once.
> 
> You lost me on that one.
> 
>       UPDATER                               READER
>       -------                               ------
>       //srcu_readers_lock_idx               //srcu_read_lock
>       idx = ssp->srcu_idx;                  idx = ssp->srcu_idx;
>       READ srcu_lock_count[idx ^ 1]         srcu_lock_count[idx]++

Shouldn't this be "READ srcu_unlock_count[idx ^ 1]"?

And then the above paragraph assumes that the updater gets stuck here...

>       smp_mb();                             smp_mb();

...or here.

And only then do we do the read of srcu_lock_count[idx ^ 1], correct?

>       //flip_index                          /* srcu_read_unlock (ignoring on purpose) */
>       ssp->srcu_idx++;                      /* smp_mb(); */
>       smp_mb();                             /* srcu_unlock_count[old_idx]++ */
>       //srcu_readers_lock_idx               //srcu_read_lock again
>       idx = ssp->srcu_idx;                  idx = ssp->srcu_idx;
>       READ srcu_lock_count[idx ^ 1]

And likewise here?

> Scenario for the reader to increment the old idx once:
> 
> _ Assume ssp->srcu_idx is initially 0.
> _ The READER reads idx that is 0
> _ The updater runs and flips the idx that is now 1
> _ The reader resumes with 0 as an index but on the next srcu_read_lock()
>   it will see the new idx which is 1
> 
> What could be the scenario for it to increment the old idx twice?

Unless I am missing something, the reader must reference the
srcu_unlock_count[old_idx] and then do smp_mb() before it will be
absolutely guaranteed of seeing the new value of ->srcu_idx.

So what am I missing?

						Thanx, Paul
