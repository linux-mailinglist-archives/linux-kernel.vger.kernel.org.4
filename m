Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DB68E6A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBHDik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBHDig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:38:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8F252B1;
        Tue,  7 Feb 2023 19:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D27861473;
        Wed,  8 Feb 2023 03:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700B2C433D2;
        Wed,  8 Feb 2023 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675827513;
        bh=c9lUrSDIq49yjtyRlepsWp4tlv/aSoe1gAPSMO8DfLY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IxlYvhGZDul0LzQTryXITZY4nTSZgyecUCobzxckMss7Ckr3YgQqgAZJf2P6kp5xx
         eUQp1FoxWJvgE+ShkgbmSO7qXyey6NlqPGqo390tzDDI50Y8vCMW83OXmRKsoGrQVZ
         rLo028CQVxYxWqA/36ubFyq1b/7nmTPLYKVWdx/em/h8NAkQsIkq40kL3lUzAwrnG+
         9TIZAd0UaBOpkTyB/762LqHfY7NUdI7c4Jpr02MsgHBil9cggSuogGuwddgmW5EOJ5
         1ygMMmrUcd13i1GHgk8S/LBD4HRDOtumfWeKnDQgvNQlSYNZIjwTpY/JDXAYqT2XAe
         Zc2dWgFrw2pig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ABE325C08F3; Tue,  7 Feb 2023 19:38:31 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:38:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, akiyks@gmail.com
Subject: Re: [PATCH v4] srcu: Clarify comments on memory barrier "E"
Message-ID: <20230208033831.GA3160511@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230128035902.1758726-1-joel@joelfernandes.org>
 <20230128182440.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTK1ejOcuNyAqJ3ibKKyfR21UYHRNa7jpWS_H71xpnTpg@mail.gmail.com>
 <20230129050904.GD2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129050904.GD2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 09:09:04PM -0800, Paul E. McKenney wrote:
> On Sat, Jan 28, 2023 at 04:16:34PM -0500, Joel Fernandes wrote:
> > On Sat, Jan 28, 2023 at 1:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Jan 28, 2023 at 03:59:01AM +0000, Joel Fernandes (Google) wrote:
> > > > During a flip, we have a full memory barrier before srcu_idx is incremented.
> > > >
> > > > The idea is we intend to order the first phase scan's read of lock
> > > > counters with the flipping of the index.
> > > >
> > > > However, such ordering is already enforced because of the
> > > > control-dependency between the 2 scans. We would be flipping the index
> > > > only if lock and unlock counts matched.
> > > >
> > > > But such match will not happen if there was a pending reader before the flip
> > > > in the first place (observation courtesy Mathieu Desnoyers).
> > > >
> > > > The litmus test below shows this:
> > > > (test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):
> > >
> > > Much better, thank you!
> > >
> > > I of course did the usual wordsmithing, as shown below.  Does this
> > > version capture your intent and understanding?
> > >
> > 
> > It looks good to me.
> > According to [1] , the architecture at least should not be reordering
> > read-write control dependency. Only read-read is problematic. But I am
> > not 100% sure, is that not true?
> 
> Agreed, READ_ONCE() or stronger through condition to WRITE_ONCE()
> or stronger is ordered.  Replace that WRITE_ONCE() with any type of
> unordered read and all bets are off.
> 
> And now that the ARM folks chimed in, this is a solid guarantee at
> the hardware level.
> 
> Not so much at the compiler level.  Oddly enough, compilers do provide
> ordering for plain C-language stores, but that is helpful only if no
> other CPU or thread is concurrently accessing that variable.
> 
> > For the compiler, you are saying that read-write control dependency
> > can be reordered even with *ONCE() accesses? In other words, the
> > flipping of idx can happen in ->po order before the locks and unlock
> > counts match? That sounds sort of like a broken compiler.
> 
> One case where a sane compiler can reasonably enable the hardware to
> do the reordering is where you have the same WRITE_ONCE() in both the
> then-clause and else-clause of an "if" statement.  Another is if it can
> somehow prove something about the value returned from that READ_ONCE(),
> for example, if that value is used to index a singleton array, then the
> compiler has to do the READ_ONCE(), but it can then assume that the
> value returned was zero, throwing away the real value returned.
> 
> Fun with undefined behavior!
> 
> > [1] https://lpc.events/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > 
> > More comments below:

Except that it was pointed out to me that the Co-developed-by tags also
need Signed-off-by tags.  If there are no objections to the update shown
below, I will fix this on my next rebase.

							Thanx, Paul

------------------------------------------------------------------------

commit 6c135bb38c55d354527a6659cbf2f4e7e20b4360
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sat Jan 28 03:59:01 2023 +0000

    srcu: Clarify comments on memory barrier "E"
    
    There is an smp_mb() named "E" in srcu_flip() immediately before the
    increment (flip) of the srcu_struct structure's ->srcu_idx.
    
    The purpose of E is to order the preceding scan's read of lock counters
    against the flipping of the ->srcu_idx, in order to prevent new readers
    from continuing to use the old ->srcu_idx value, which might needlessly
    extend the grace period.
    
    However, this ordering is already enforced because of the control
    dependency between the preceding scan and the ->srcu_idx flip.
    This control dependency exists because atomic_long_read() is used
    to scan the counts, because WRITE_ONCE() is used to flip ->srcu_idx,
    and because ->srcu_idx is not flipped until the ->srcu_lock_count[] and
    ->srcu_unlock_count[] counts match.  And such a match cannot happen when
    there is an in-flight reader that started before the flip (observation
    courtesy Mathieu Desnoyers).
    
    The litmus test below (courtesy of Frederic Weisbecker, with changes
    for ctrldep by Boqun and Joel) shows this:
    
    C srcu
    (*
     * bad condition: P0's first scan (SCAN1) saw P1's idx=0 LOCK count inc, though P1 saw flip.
     *
     * So basically, the ->po ordering on both P0 and P1 is enforced via ->ppo
     * (control deps) on both sides, and both P0 and P1 are interconnected by ->rf
     * relations. Combining the ->ppo with ->rf, a cycle is impossible.
     *)
    
    {}
    
    // updater
    P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
    {
            int lock1;
            int unlock1;
            int lock0;
            int unlock0;
    
            // SCAN1
            unlock1 = READ_ONCE(*UNLOCK1);
            smp_mb(); // A
            lock1 = READ_ONCE(*LOCK1);
    
            // FLIP
            if (lock1 == unlock1) {   // Control dep
                    smp_mb(); // E    // Remove E and still passes.
                    WRITE_ONCE(*IDX, 1);
                    smp_mb(); // D
    
                    // SCAN2
                    unlock0 = READ_ONCE(*UNLOCK0);
                    smp_mb(); // A
                    lock0 = READ_ONCE(*LOCK0);
            }
    }
    
    // reader
    P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
    {
            int tmp;
            int idx1;
            int idx2;
    
            // 1st reader
            idx1 = READ_ONCE(*IDX);
            if (idx1 == 0) {         // Control dep
                    tmp = READ_ONCE(*LOCK0);
                    WRITE_ONCE(*LOCK0, tmp + 1);
                    smp_mb(); /* B and C */
                    tmp = READ_ONCE(*UNLOCK0);
                    WRITE_ONCE(*UNLOCK0, tmp + 1);
            } else {
                    tmp = READ_ONCE(*LOCK1);
                    WRITE_ONCE(*LOCK1, tmp + 1);
                    smp_mb(); /* B and C */
                    tmp = READ_ONCE(*UNLOCK1);
                    WRITE_ONCE(*UNLOCK1, tmp + 1);
            }
    }
    
    exists (0:lock1=1 /\ 1:idx1=1)
    
    More complicated litmus tests with multiple SRCU readers also show that
    memory barrier E is not needed.
    
    This commit therefore clarifies the comment on memory barrier E.
    
    Why not also remove that redundant smp_mb()?
    
    Because control dependencies are quite fragile due to their not being
    recognized by most compilers and tools.  Control dependencies therefore
    exact an ongoing maintenance burden, and such a burden cannot be justified
    in this slowpath.  Therefore, that smp_mb() stays until such time as
    its overhead becomes a measurable problem in a real workload running on
    a real production system, or until such time as compilers start paying
    attention to this sort of control dependency.
    
    Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c541b82646b63..cd46fe063e50f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1085,16 +1085,36 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Because the flip of ->srcu_idx is executed only if the
+	 * preceding call to srcu_readers_active_idx_check() found that
+	 * the ->srcu_unlock_count[] and ->srcu_lock_count[] sums matched
+	 * and because that summing uses atomic_long_read(), there is
+	 * ordering due to a control dependency between that summing and
+	 * the WRITE_ONCE() in this call to srcu_flip().  This ordering
+	 * ensures that if this updater saw a given reader's increment from
+	 * __srcu_read_lock(), that reader was using a value of ->srcu_idx
+	 * from before the previous call to srcu_flip(), which should be
+	 * quite rare.  This ordering thus helps forward progress because
+	 * the grace period could otherwise be delayed by additional
+	 * calls to __srcu_read_lock() using that old (soon to be new)
+	 * value of ->srcu_idx.
+	 *
+	 * This sum-equality check and ordering also ensures that if
+	 * a given call to __srcu_read_lock() uses the new value of
+	 * ->srcu_idx, this updater's earlier scans cannot have seen
+	 * that reader's increments, which is all to the good, because
+	 * this grace period need not wait on that reader.  After all,
+	 * if those earlier scans had seen that reader, there would have
+	 * been a sum mismatch and this code would not be reached.
+	 *
+	 * This means that the following smp_mb() is redundant, but
+	 * it stays until either (1) Compilers learn about this sort of
+	 * control dependency or (2) Some production workload running on
+	 * a production system is unduly delayed by this slowpath smp_mb().
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
