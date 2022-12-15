Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38564E01D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLOR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLOR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:58:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA943862;
        Thu, 15 Dec 2022 09:58:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F34B81C1D;
        Thu, 15 Dec 2022 17:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBEDC433F0;
        Thu, 15 Dec 2022 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671127113;
        bh=5nUdni6kMSxlkQsgOfN7RADvXOH+O7IR7t9X9s82vNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEHteaTcnf6eI5tnllywQeT0QMo1Oz9kmc8Zc9zLI+80lbk8RwPscY79mzYIl9+OK
         QUfQ09ShR8TjIQZlN8A5gJNGNAYFcNP+7pOSawf4cJM7swMpX9gZgHs1sF74Ycb4ol
         JPlHd6zxXBFzSkqzGcBGYsk2w85jmtcimMSAZsqg+Gau9InxQTKSYJItVZg7jaiVp7
         409ERVHpV33+APUndC1b0JtQhFHCfT1CIove3UoYXGJetSYXglFQpp9PV5b1+RAUOu
         U5cK+u0qhfKDMm4GE45xrbaiC+l9nqGPZmu9ac8IjjdgELZ4FIw5TJifTA9qgYdZ/L
         o928iNa/+BQzw==
Date:   Thu, 15 Dec 2022 18:58:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     boqun.feng@gmail.com, joel@joelfernandes.org,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215175830.GA1958071@lothringen>
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen>
 <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:08:34AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 15, 2022 at 05:54:52PM +0100, Frederic Weisbecker wrote:
> > On Wed, Dec 14, 2022 at 11:13:55AM -0800, Paul E. McKenney wrote:
> > > The comment in srcu_readers_active_idx_check() following the smp_mb()
> > > is out of date, hailing from a simpler time when preemption was disabled
> > > across the bulk of __srcu_read_lock().  The fact that preemption was
> > > disabled meant that the number of tasks that had fetched the old index
> > > but not yet incremented counters was limited by the number of CPUs.
> > > 
> > > In our more complex modern times, the number of CPUs is no longer a limit.
> > > This commit therefore updates this comment, additionally giving more
> > > memory-ordering detail.
> > > 
> > > Reported-by: Boqun Feng <boqun.feng@gmail.com>
> > > Reported-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Not really, while you guys were debating on that comment, I was still starring
> > at the previous one (as usual).
> > 
> > Or to put it in an SRCU way, while you guys saw the flipped idx, I was still
> > using the old one :)
> > 
> > > -	 * OK, how about nesting?  This does impose a limit on nesting
> > > -	 * of floor(ULONG_MAX/NR_CPUS/2), which should be sufficient,
> > > -	 * especially on 64-bit systems.
> > > +	 * It can clearly do so once, given that it has already fetched
> > > +	 * the old value of ->srcu_idx and is just about to use that value
> > > +	 * to index its increment of ->srcu_lock_count[idx].  But as soon as
> > > +	 * it leaves that SRCU read-side critical section, it will increment
> > > +	 * ->srcu_unlock_count[idx], which must follow the updater's above
> > > +	 * read from that same value.  Thus, as soon the reading task does
> > > +	 * an smp_mb() and a later fetch from ->srcu_idx, that task will be
> > > +	 * guaranteed to get the new index.  Except that the increment of
> > > +	 * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
> > > +	 * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
> > > +	 * is before the smp_mb().  Thus, that task might not see the new
> > > +	 * value of ->srcu_idx until the -second- __srcu_read_lock(),
> > > +	 * which in turn means that this task might well increment
> > > +	 * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
> > > +	 * not just once.
> > 
> > You lost me on that one.
> > 
> >       UPDATER                               READER
> >       -------                               ------
> >       //srcu_readers_lock_idx               //srcu_read_lock
> >       idx = ssp->srcu_idx;                  idx = ssp->srcu_idx;
> >       READ srcu_lock_count[idx ^ 1]         srcu_lock_count[idx]++
> 
> Shouldn't this be "READ srcu_unlock_count[idx ^ 1]"?
> 
> And then the above paragraph assumes that the updater gets stuck here...

Right I ignored the unlock part on purpose. But ok let's add it (later note: just switch
directly to the next paragraph to see how I realize I'm wrong)


      UPDATER                               READER
      -------                               ------
      idx = ssp->srcu_idx;                  idx = ssp->srcu_idx;
      READ srcu_unlock_count[idx ^ 1]       srcu_lock_count[idx]++
      smp_mb();                             smp_mb();
      READ srcu_lock_count[idx ^ 1]         // read side crit
      smp_mb();                             smp_mb();
      idx = ssp->srcu_idx;                  srcu_unlock_count[old_idx]++
      ssp->srcu_idx++;                      idx = ssp->srcu_idx;
      smp_mb();                             
      READ srcu_unlock_count[idx ^ 1]
      smp_mb();
      READ srcu_lock_count[idx ^ 1]  

> Unless I am missing something, the reader must reference the
> srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> absolutely guaranteed of seeing the new value of ->srcu_idx.
> 
> So what am I missing?

But there is the smp_mb() between the srcu_lock_count[idx]++ of the 1st
srcu_read_lock() and the idx READ from the second srcu_read_lock():

         WRITER                                READER
         -----                                 -------
         WRITE idx                             WRITE srcu_lock_count[old_idx]
         smp_mb()                              smp_mb()
         READ srcu_lock_count[new_idx]         READ idx

Ah wait! On SCAN2 we are reading the count from the _new_ idx, not the old one, ok
that's why it doesn't work. So then for it to write twice on the old idx we have:

_ idx is initially 0
_ READER fetches idx (idx=0) and is preempted
_ New GP: Updater goes through its whole thing and flips idx
_ Yet another new GP: Updater goes again but is preempted in the middle of
SCAN1: it has read unlock_count but not yet lock_count
_ READER increments lock_count, then unlock_count, for the old idx (0).
_ New READER: indeed we don't have a barrier between unlock_count and idx read.
  So we read again the idx unordered against the previous WRITE to unlock_count.
  So this may be still the old idx (0): we increment lock_count, there goes the
  desired smp_mb(), we increment unlock_count of the old idx (0).
_ Yet another READER: finally we see the new idx (1).

Phew! Did I get it right this time? :))
