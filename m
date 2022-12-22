Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35A65454D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLVQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:43:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99F3055A;
        Thu, 22 Dec 2022 08:43:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DAB9B81F16;
        Thu, 22 Dec 2022 16:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEBBC433EF;
        Thu, 22 Dec 2022 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671727383;
        bh=iBoboq8V+MkKG68qcYOvNkQ11HNT4uTZp8kdEy42vO8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ayITOcRHJKR4pPiNfFByHMll3uOo45twcRMAsr9RR8Q+uI+UN0Rs7IY9qZM8vmvmj
         l9O1Y57/fF42G+Na8VOHsXmRyAUHS5sGhC/wdiiUma6Se9kGNmtuMICJ2SsHMAes4K
         TJHaXtVjIiTh2YnVWtdfF1vabWGycsFdzGAFG1GNFWOoBP0o0hK4jM1gCMiNjLhfx1
         1OISM2/qKInjgEG2QPBxYwY2P+gE7cKEZuPMGjRpFee9TlOYcDDaiCb1Wo3kaGGyLl
         86bmGjQqjBv1iqPcD+fzQjVflRYMsK5QPCkvoGzvz0vUHrxw1e1bOkjwNvkbnwZd8L
         c4hQts2lF1pig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B89205C146C; Thu, 22 Dec 2022 08:43:02 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:43:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221222164302.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <20221220225756.GB26563@lothringen>
 <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
 <20221221115924.GA34934@lothringen>
 <bb794e83-992e-8181-d9b9-acc68536ce5a@efficios.com>
 <20221222124010.GC44777@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222124010.GC44777@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
> > On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > > On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
> > [...]
> > > > 
> > > > The memory ordering constraint I am concerned about here is:
> > > > 
> > > >   * [...] In addition,
> > > >   * each CPU having an SRCU read-side critical section that extends beyond
> > > >   * the return from synchronize_srcu() is guaranteed to have executed a
> > > >   * full memory barrier after the beginning of synchronize_srcu() and before
> > > >   * the beginning of that SRCU read-side critical section. [...]
> > > > 
> > > > So if we have a SRCU read-side critical section that begins after the beginning
> > > > of synchronize_srcu, but before its first memory barrier, it would miss the
> > > > guarantee that the full memory barrier is issued before the beginning of that
> > > > SRCU read-side critical section. IOW, that memory barrier needs to be at the
> > > > very beginning of the grace period.
> > > 
> > > I'm confused, what's wrong with this ?
> > > 
> > > UPDATER                  READER
> > > -------                  ------
> > > STORE X = 1              STORE srcu_read_lock++
> > > // rcu_seq_snap()        smp_mb()
> > > smp_mb()                 READ X
> > > // scans
> > > READ srcu_read_lock
> > 
> > What you refer to here is only memory ordering of the store to X and load
> > from X wrt loading/increment of srcu_read_lock, which is internal to the
> > srcu implementation. If we really want to model the provided high-level
> > memory ordering guarantees, we should consider a scenario where SRCU is used
> > for its memory ordering properties to synchronize other variables.
> > 
> > I'm concerned about the following Dekker scenario, where synchronize_srcu()
> > and srcu_read_lock/unlock would be used instead of memory barriers:
> > 
> > Initial state: X = 0, Y = 0
> > 
> > Thread A                   Thread B
> > ---------------------------------------------
> > STORE X = 1                STORE Y = 1
> > synchronize_srcu()
> >                            srcu_read_lock()
> >                            r1 = LOAD X
> >                            srcu_read_unlock()
> > r0 = LOAD Y
> > 
> > BUG_ON(!r0 && !r1)
> > 
> > So in the synchronize_srcu implementation, there appears to be two
> > major scenarios: either srcu_gp_start_if_needed starts a gp or expedited gp,
> > or it uses an already started gp/expedited gp. When snapshotting with
> > rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp_seq
> > load means that it does not order prior memory accesses before that load.
> > This sequence value is then used to identify which gp_seq to wait for when
> > piggy-backing on another already-started gp. I worry about reordering
> > between STORE X = 1 and load of ssp->srcu_gp_seq, which is then used to
> > piggy-back on an already-started gp.
> > 
> > I suspect that the implicit barrier in srcu_read_lock() invoked at the
> > beginning of srcu_gp_start_if_needed() is really the barrier that makes
> > all this behave as expected. But without documentation it's rather hard to
> > follow.
> 
> Oh ok I see now. It might be working that way by accident or on forgotten
> purpose. In any case, we really want to add a comment above that
> __srcu_read_lock_nmisafe() call.

Another test for the safety (or not) of removing either D or E is
to move that WRITE_ONCE() to follow (or, respectively, precede) the
adjacent scans.

							Thanx, Paul
