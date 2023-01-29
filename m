Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6867FCCC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjA2FJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848821B55D;
        Sat, 28 Jan 2023 21:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27C58B80BEC;
        Sun, 29 Jan 2023 05:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED6DC433EF;
        Sun, 29 Jan 2023 05:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674968944;
        bh=QM7+/0IWikT1TrPpqMq9BrH2GxaLsA6deOKIiP7Arhk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TqJxQVphq+hUN7LS24fUosY3MM3ESWLPcOiUFjx6v5zC9s5xe3axZLP7Ue9fHHTtM
         73UNIIkbI0wxQ9X8zIiXcbrSI3sM3LNdK0OBFz6myr9oK2fP1xIpfvMmZnjIH/CxDt
         +zcLc/yTDK3j0fPkqIbm/FtBHvy+Vc5gkj8r8CGRgpvPLSw+oMCB/x91RNAAZqu39K
         zc/VFB5fT1XZVjVlqSyB+NEOuYTWkr9CfF5EvFtv9xzXQx2PsekNQAmSxEmVftg3HB
         uTSty0q78jPypTC6vtgnZYe+sq/MYpOjaiy4a4OI3cNfpvXIi7jR1fgUnOB0XGl/wb
         Y5jmrAyvO93pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 636405C0882; Sat, 28 Jan 2023 21:09:04 -0800 (PST)
Date:   Sat, 28 Jan 2023 21:09:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4] srcu: Clarify comments on memory barrier "E"
Message-ID: <20230129050904.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230128035902.1758726-1-joel@joelfernandes.org>
 <20230128182440.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTK1ejOcuNyAqJ3ibKKyfR21UYHRNa7jpWS_H71xpnTpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTK1ejOcuNyAqJ3ibKKyfR21UYHRNa7jpWS_H71xpnTpg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:16:34PM -0500, Joel Fernandes wrote:
> On Sat, Jan 28, 2023 at 1:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Jan 28, 2023 at 03:59:01AM +0000, Joel Fernandes (Google) wrote:
> > > During a flip, we have a full memory barrier before srcu_idx is incremented.
> > >
> > > The idea is we intend to order the first phase scan's read of lock
> > > counters with the flipping of the index.
> > >
> > > However, such ordering is already enforced because of the
> > > control-dependency between the 2 scans. We would be flipping the index
> > > only if lock and unlock counts matched.
> > >
> > > But such match will not happen if there was a pending reader before the flip
> > > in the first place (observation courtesy Mathieu Desnoyers).
> > >
> > > The litmus test below shows this:
> > > (test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):
> >
> > Much better, thank you!
> >
> > I of course did the usual wordsmithing, as shown below.  Does this
> > version capture your intent and understanding?
> >
> 
> It looks good to me.
> According to [1] , the architecture at least should not be reordering
> read-write control dependency. Only read-read is problematic. But I am
> not 100% sure, is that not true?

Agreed, READ_ONCE() or stronger through condition to WRITE_ONCE()
or stronger is ordered.  Replace that WRITE_ONCE() with any type of
unordered read and all bets are off.

And now that the ARM folks chimed in, this is a solid guarantee at
the hardware level.

Not so much at the compiler level.  Oddly enough, compilers do provide
ordering for plain C-language stores, but that is helpful only if no
other CPU or thread is concurrently accessing that variable.

> For the compiler, you are saying that read-write control dependency
> can be reordered even with *ONCE() accesses? In other words, the
> flipping of idx can happen in ->po order before the locks and unlock
> counts match? That sounds sort of like a broken compiler.

One case where a sane compiler can reasonably enable the hardware to
do the reordering is where you have the same WRITE_ONCE() in both the
then-clause and else-clause of an "if" statement.  Another is if it can
somehow prove something about the value returned from that READ_ONCE(),
for example, if that value is used to index a singleton array, then the
compiler has to do the READ_ONCE(), but it can then assume that the
value returned was zero, throwing away the real value returned.

Fun with undefined behavior!

> [1] https://lpc.events/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> 
> More comments below:
> 
> > ------------------------------------------------------------------------
> >
> > commit 963f34624beb2af1ec08527e637d16ab6a1dacbd
> > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Date:   Sat Jan 28 03:59:01 2023 +0000
> >
> >     srcu: Clarify comments on memory barrier "E"
> >
> >     There is an smp_mb() named "E" in srcu_flip() immediately before the
> >     increment (flip) of the srcu_struct structure's ->srcu_idx.
> >
> >     The purpose of E is to order the preceding scan's read of lock counters
> >     against the flipping of the ->srcu_idx, in order to prevent new readers
> >     from continuing to use the old ->srcu_idx value, which might needlessly
> >     extend the grace period.
> >
> >     However, this ordering is already enforced because of the control
> >     dependency between the preceding scan and the ->srcu_idx flip.
> >     This control dependency exists because atomic_long_read() is used
> >     to scan the counts, because WRITE_ONCE() is used to flip ->srcu_idx,
> >     and because ->srcu_idx is not flipped until the ->srcu_lock_count[] and
> >     ->srcu_unlock_count[] counts match.  And such a match cannot happen when
> >     there is an in-flight reader that started before the flip (observation
> >     courtesy Mathieu Desnoyers).
> 
> Agreed.
> 
> >     The litmus test below (courtesy of Frederic Weisbecker, with changes
> >     for ctrldep by Boqun and Joel) shows this:
> >
> >     C srcu
> >     (*
> >      * bad condition: P0's first scan (SCAN1) saw P1's idx=0 LOCK count inc, though P1 saw flip.
> >      *
> >      * So basically, the ->po ordering on both P0 and P1 is enforced via ->ppo
> >      * (control deps) on both sides, and both P0 and P1 are interconnected by ->rf
> >      * relations. Combining the ->ppo with ->rf, a cycle is impossible.
> >      *)
> >
> >     {}
> >
> >     // updater
> >     P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> >     {
> >             int lock1;
> >             int unlock1;
> >             int lock0;
> >             int unlock0;
> >
> >             // SCAN1
> >             unlock1 = READ_ONCE(*UNLOCK1);
> >             smp_mb(); // A
> >             lock1 = READ_ONCE(*LOCK1);
> >
> >             // FLIP
> >             if (lock1 == unlock1) {   // Control dep
> >                     smp_mb(); // E    // Remove E and still passes.
> >                     WRITE_ONCE(*IDX, 1);
> >                     smp_mb(); // D
> >
> >                     // SCAN2
> >                     unlock0 = READ_ONCE(*UNLOCK0);
> >                     smp_mb(); // A
> >                     lock0 = READ_ONCE(*LOCK0);
> >             }
> >     }
> >
> >     // reader
> >     P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> >     {
> >             int tmp;
> >             int idx1;
> >             int idx2;
> >
> >             // 1st reader
> >             idx1 = READ_ONCE(*IDX);
> >             if (idx1 == 0) {         // Control dep
> >                     tmp = READ_ONCE(*LOCK0);
> >                     WRITE_ONCE(*LOCK0, tmp + 1);
> >                     smp_mb(); /* B and C */
> >                     tmp = READ_ONCE(*UNLOCK0);
> >                     WRITE_ONCE(*UNLOCK0, tmp + 1);
> >             } else {
> >                     tmp = READ_ONCE(*LOCK1);
> >                     WRITE_ONCE(*LOCK1, tmp + 1);
> >                     smp_mb(); /* B and C */
> >                     tmp = READ_ONCE(*UNLOCK1);
> >                     WRITE_ONCE(*UNLOCK1, tmp + 1);
> >             }
> >     }
> >
> >     exists (0:lock1=1 /\ 1:idx1=1)
> >
> >     More complicated litmus tests with multiple SRCU readers also show that
> >     memory barrier E is not needed.
> >
> >     This commit therefore clarifies the comment on memory barrier E.
> >
> >     Why not also remove that redundant smp_mb()?
> >
> >     Because control dependencies are quite fragile due to their not being
> >     recognized by most compilers and tools.  Control dependencies therefore
> >     exact an ongoing maintenance burden, and such a burden cannot be justified
> >     in this slowpath.  Therefore, that smp_mb() stays until such time as
> >     its overhead becomes a measurable problem in a real workload running on
> >     a real production system, or until such time as compilers start paying
> >     attention to this sort of control dependency.
> >
> >     Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> >     Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >     Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> >     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c541b82646b63..cd46fe063e50f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1085,16 +1085,36 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
> >  static void srcu_flip(struct srcu_struct *ssp)
> >  {
> >         /*
> > -        * Ensure that if this updater saw a given reader's increment
> > -        * from __srcu_read_lock(), that reader was using an old value
> > -        * of ->srcu_idx.  Also ensure that if a given reader sees the
> > -        * new value of ->srcu_idx, this updater's earlier scans cannot
> > -        * have seen that reader's increments (which is OK, because this
> > -        * grace period need not wait on that reader).
> > +        * Because the flip of ->srcu_idx is executed only if the
> > +        * preceding call to srcu_readers_active_idx_check() found that
> > +        * the ->srcu_unlock_count[] and ->srcu_lock_count[] sums matched
> > +        * and because that summing uses atomic_long_read(), there is
> > +        * ordering due to a control dependency between that summing and
> > +        * the WRITE_ONCE() in this call to srcu_flip().  This ordering
> > +        * ensures that if this updater saw a given reader's increment from
> > +        * __srcu_read_lock(), that reader was using a value of ->srcu_idx
> > +        * from before the previous call to srcu_flip(), which should be
> > +        * quite rare.  This ordering thus helps forward progress because
> > +        * the grace period could otherwise be delayed by additional
> > +        * calls to __srcu_read_lock() using that old (soon to be new)
> > +        * value of ->srcu_idx.
> > +        *
> > +        * This sum-equality check and ordering also ensures that if
> > +        * a given call to __srcu_read_lock() uses the new value of
> > +        * ->srcu_idx, this updater's earlier scans cannot have seen
> > +        * that reader's increments, which is all to the good, because
> > +        * this grace period need not wait on that reader.  After all,
> > +        * if those earlier scans had seen that reader, there would have
> > +        * been a sum mismatch and this code would not be reached.
> > +        *
> > +        * This means that the following smp_mb() is redundant, but
> > +        * it stays until either (1) Compilers learn about this sort of
> > +        * control dependency or (2) Some production workload running on
> > +        * a production system is unduly delayed by this slowpath smp_mb().
> >          */
> 
> I agree that a read-write control dependency reordering by the
> compiler can cause a reader to observe the flipped srcu_idx too soon,
> thus perhaps delaying the grace period from ending (because the second
> scan will now end up waiting on that reader..).

Very good!  I will push the commit out on -rcu.

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> >         smp_mb(); /* E */  /* Pairs with B and C. */
> >
> > -       WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> > +       WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
> >
> >         /*
> >          * Ensure that if the updater misses an __srcu_read_unlock()
