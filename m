Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9826E6546D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiLVTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiLVTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:45:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED218395;
        Thu, 22 Dec 2022 11:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E93761CED;
        Thu, 22 Dec 2022 19:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94132C433D2;
        Thu, 22 Dec 2022 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671738311;
        bh=xNqblJGSgmlKRE4lOsULWelwnd8P673BVC2C67doqHk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ngXF/sayw7wEEKjwiwcS9ouP6YcEuYi5cT2vCjJZaak4pHwd16ZLD5ZYSq8KGqSTl
         OdJXB+wBqxetmZeXcOkGqwdw6WNb5wJqiq4dStDtnV59kkv7sN0BxLI+UsiaIhx48q
         HR/1isARu4h/Einj+ZAVvViJmW9+CCsAdPaKhWyKuQDF3qT4ki4q29alS37yXRtRD2
         T7d3njqYKgqXg9I08KsCTVP+cP530WO55J7HnDSKamCRPWbM64fjwBp0SNVgz4bueL
         7Ahfca7M1Fdbr1pfu6AkxnwSeZ9KvHg+cEiR5fwXNKlTUmlVtmJ2ZVMH++YPdYVWb+
         cJnHgECabpvvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F4345C146C; Thu, 22 Dec 2022 11:45:11 -0800 (PST)
Date:   Thu, 22 Dec 2022 11:45:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:56:17PM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 22, 2022, at 1:53 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Thu, Dec 22, 2022 at 01:19:06PM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> ﻿On Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbecker wrote:
> >>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
> >>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> >>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
> >>>>> [...]
> >>>>>>> 
> >>>>>>> The memory ordering constraint I am concerned about here is:
> >>>>>>> 
> >>>>>>> * [...] In addition,
> >>>>>>> * each CPU having an SRCU read-side critical section that extends beyond
> >>>>>>> * the return from synchronize_srcu() is guaranteed to have executed a
> >>>>>>> * full memory barrier after the beginning of synchronize_srcu() and before
> >>>>>>> * the beginning of that SRCU read-side critical section. [...]
> >>>>>>> 
> >>>>>>> So if we have a SRCU read-side critical section that begins after the beginning
> >>>>>>> of synchronize_srcu, but before its first memory barrier, it would miss the
> >>>>>>> guarantee that the full memory barrier is issued before the beginning of that
> >>>>>>> SRCU read-side critical section. IOW, that memory barrier needs to be at the
> >>>>>>> very beginning of the grace period.
> >>>>>> 
> >>>>>> I'm confused, what's wrong with this ?
> >>>>>> 
> >>>>>> UPDATER                  READER
> >>>>>> -------                  ------
> >>>>>> STORE X = 1              STORE srcu_read_lock++
> >>>>>> // rcu_seq_snap()        smp_mb()
> >>>>>> smp_mb()                 READ X
> >>>>>> // scans
> >>>>>> READ srcu_read_lock
> >>>>> 
> >>>>> What you refer to here is only memory ordering of the store to X and load
> >>>>> from X wrt loading/increment of srcu_read_lock, which is internal to the
> >>>>> srcu implementation. If we really want to model the provided high-level
> >>>>> memory ordering guarantees, we should consider a scenario where SRCU is used
> >>>>> for its memory ordering properties to synchronize other variables.
> >>>>> 
> >>>>> I'm concerned about the following Dekker scenario, where synchronize_srcu()
> >>>>> and srcu_read_lock/unlock would be used instead of memory barriers:
> >>>>> 
> >>>>> Initial state: X = 0, Y = 0
> >>>>> 
> >>>>> Thread A                   Thread B
> >>>>> ---------------------------------------------
> >>>>> STORE X = 1                STORE Y = 1
> >>>>> synchronize_srcu()
> >>>>>                          srcu_read_lock()
> >>>>>                          r1 = LOAD X
> >>>>>                          srcu_read_unlock()
> >>>>> r0 = LOAD Y
> >>>>> 
> >>>>> BUG_ON(!r0 && !r1)
> >>>>> 
> >>>>> So in the synchronize_srcu implementation, there appears to be two
> >>>>> major scenarios: either srcu_gp_start_if_needed starts a gp or expedited gp,
> >>>>> or it uses an already started gp/expedited gp. When snapshotting with
> >>>>> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp_seq
> >>>>> load means that it does not order prior memory accesses before that load.
> >>>>> This sequence value is then used to identify which gp_seq to wait for when
> >>>>> piggy-backing on another already-started gp. I worry about reordering
> >>>>> between STORE X = 1 and load of ssp->srcu_gp_seq, which is then used to
> >>>>> piggy-back on an already-started gp.
> >>>>> 
> >>>>> I suspect that the implicit barrier in srcu_read_lock() invoked at the
> >>>>> beginning of srcu_gp_start_if_needed() is really the barrier that makes
> >>>>> all this behave as expected. But without documentation it's rather hard to
> >>>>> follow.
> >>>> 
> >>>> Oh ok I see now. It might be working that way by accident or on forgotten
> >>>> purpose. In any case, we really want to add a comment above that
> >>>> __srcu_read_lock_nmisafe() call.
> >>> 
> >>> Another test for the safety (or not) of removing either D or E is
> >>> to move that WRITE_ONCE() to follow (or, respectively, precede) the
> >>> adjacent scans.
> >> 
> >> Good idea, though I believe the MBs that the above talk about are not the flip ones. They are the ones in synchronize_srcu() beginning and end, that order with respect to grace period start and end.
> >> 
> >> So that (flipping MBs) is unrelated, or did I miss something?
> > 
> > The thought is to manually similate in the source code the maximum
> > memory-reference reordering that a maximally hostile compiler and CPU
> > would be permitted to carry out.  So yes, given that there are other
> > memory barriers before and after, these other memory barriers limit how
> > far the flip may be moved in the source code.
> > 
> > Here I am talking about the memory barriers associated with the flip,
> > but the same trick can of course be applied to other memory barriers.
> > In general, remove a given memory barrier and (in the source code)
> > maximally rearrange the memory references that were previously ordered
> > by the memory barrier in question.
> > 
> > Again, the presence of other memory barriers will limit the permitted
> > maximal source-code rearrangement.
> 
> 
> Makes sense if the memory barrier is explicit. In this case, the memory barriers are implicit apparently, with a srcu_read_lock() in the beginning of synchronize_rcu() having the implicit / indirect memory barrier. So I am not sure if that can be implemented without breaking SRCU readers.

First, are we talking about the same barrier?  I am talking about E.

Yes, this would require a bit of restructuring.  The overall
approach would be something like this, in SRCU_STATE_SCAN1:

1.	Scan the unlocks.

2.	smp_mb(); /* A */

3.	Flip the index.

4.	Scan the locks.

5.	If unlocks == locks, advance the state to SRCU_STATE_SCAN2.

6.	Otherwise, execute the current SRCU_STATE_SCAN1 code.

Give or take the usual devils in the details.

Alternatively, remove E and hammer it on a weakly ordered system.

							Thanx, Paul
