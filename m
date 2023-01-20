Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5D675D44
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjATS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjATS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:59:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA21040C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:59:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7066205F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62EAC433EF;
        Fri, 20 Jan 2023 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674241191;
        bh=E9nHthsRUj25Gg+OkWAmUcgVGnr8amS8Yxj8mVFyGg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hcOWTnDS6iGUFHAkk1Qio+LYtb3ZzjgaX7MyxHBpMcBMJy3JuHT2tvg82H4sisNuM
         7rkZd76svT996pIzQ1b97/M55QvcaCGPcqGNodLR1A893UNzvoDfgoD6KoBZsdgacb
         6bM2EGTrQWuIYMJAdzc1ggP86xFrf1ewIGOPXMHgrc1MBlx7lMwtl/8DGu3ilRQeC+
         vLEfam6giR2RzYSVlAEMyfVhTq5gf0jKiFsTqeV4jhc9iwD1jVmk3SJzUR3vj6SP98
         75wIkTykS8cJbAeovr6DzH1CG3BbQ0o3CXNC8Ust52wbiTNgR4zdC/Iz1KdxLZtKVM
         TlLlRO9zIMdHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70EC95C17DC; Fri, 20 Jan 2023 10:59:51 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:59:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230120185951.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
 <Y8q9zjxA620GAFu2@rowland.harvard.edu>
 <20230120173054.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8raXtv5yL65B+9M@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8raXtv5yL65B+9M@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:15:58PM -0500, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 09:30:54AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 11:14:06AM -0500, Alan Stern wrote:
> > > My revised patch is below.
> > 
> > Thank you!  Are you OK with my putting this on a not-for-mainline branch
> > for experimental purposes?
> 
> Sure, go ahead.

And done!  This is on -rcu branch lkmm-srcu.2023.01.20a, as shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit f0d4b328e12cdc7f34c11f7c82b28a16e097f769
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jan 20 10:34:59 2023 -0800

    tools/memory-model: Provide exact SRCU semantics
    
    LKMM has long provided only approximate handling of SRCU read-side
    critical sections.  This has not been a pressing problem because LKMM's
    traditionall handling is correct for the common cases of non-overlapping
    and of properly nested critical sections.  However, LKMM's traditional
    handling of partially overlapping critical sections incorrectly fuses
    them into one large critical section.
    
    For example, consider the following litmus test:
    
    ------------------------------------------------------------------------
    
    C C-srcu-nest-5
    
    (*
     * Result: Sometimes
     *
     * This demonstrates non-nested overlapping of SRCU read-side critical
     * sections.  Unlike RCU, SRCU critical sections do not unconditionally
     * nest.
     *)
    
    {}
    
    P0(int *x, int *y, struct srcu_struct *s1)
    {
            int r1;
            int r2;
            int r3;
            int r4;
    
            r3 = srcu_read_lock(s1);
            r2 = READ_ONCE(*y);
            r4 = srcu_read_lock(s1);
            srcu_read_unlock(s1, r3);
            r1 = READ_ONCE(*x);
            srcu_read_unlock(s1, r4);
    }
    
    P1(int *x, int *y, struct srcu_struct *s1)
    {
            WRITE_ONCE(*y, 1);
            synchronize_srcu(s1);
            WRITE_ONCE(*x, 1);
    }
    
    locations [0:r1]
    exists (0:r1=1 /\ 0:r2=0)
    
    ------------------------------------------------------------------------
    
    But current mainline incorrectctly flattens the two critical section
    into one larger critical section, giving "Never" instead of the correct
    "Sometimes":
    
    ------------------------------------------------------------------------
    
    $ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
    Test C-srcu-nest-5 Allowed
    States 3
    0:r1=0; 0:r2=0;
    0:r1=0; 0:r2=1;
    0:r1=1; 0:r2=1;
    No
    Witnesses
    Positive: 0 Negative: 3
    Flag srcu-bad-nesting
    Condition exists (0:r1=1 /\ 0:r2=0)
    Observation C-srcu-nest-5 Never 0 3
    Time C-srcu-nest-5 0.01
    Hash=e692c106cf3e84e20f12991dc438ff1b
    
    ------------------------------------------------------------------------
    
    To its credit, it does complain.  But with this commit, we get the
    following result, which has the virtue of being correct:
    
    ------------------------------------------------------------------------
    
    $ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
    Test C-srcu-nest-5 Allowed
    States 4
    0:r1=0; 0:r2=0;
    0:r1=0; 0:r2=1;
    0:r1=1; 0:r2=0;
    0:r1=1; 0:r2=1;
    Ok
    Witnesses
    Positive: 1 Negative: 3
    Condition exists (0:r1=1 /\ 0:r2=0)
    Observation C-srcu-nest-5 Sometimes 1 3
    Time C-srcu-nest-5 0.05
    Hash=e692c106cf3e84e20f12991dc438ff1b
    
    ------------------------------------------------------------------------
    
    In addition, there are srcu_down_read() and srcu_up_read() functions on
    their way to mainline.  Roughly speaking, these are to srcu_read_lock()
    and srcu_read_unlock() as mutex_lock() and mutex_unlock() are to down()
    and up().  The key point is that srcu_down_read() can execute in one
    process and the matching srcu_up_read() in another, as shown in this
    litmus test:
    
    ------------------------------------------------------------------------
    
    C C-srcu-nest-6
    
    (*
     * Result: Never
     *
     * This would be valid for srcu_down_read() and srcu_up_read().
     *)
    
    {}
    
    P0(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
    {
            int r2;
            int r3;
    
            r3 = srcu_down_read(s1);
            WRITE_ONCE(*idx, r3);
            r2 = READ_ONCE(*y);
            smp_store_release(f, 1);
    }
    
    P1(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
    {
            int r1;
            int r3;
            int r4;
    
            r4 = smp_load_acquire(f);
            r1 = READ_ONCE(*x);
            r3 = READ_ONCE(*idx);
            srcu_up_read(s1, r3);
    }
    
    P2(int *x, int *y, struct srcu_struct *s1)
    {
            WRITE_ONCE(*y, 1);
            synchronize_srcu(s1);
            WRITE_ONCE(*x, 1);
    }
    
    locations [0:r1]
    filter (1:r4=1)
    exists (1:r1=1 /\ 0:r2=0)
    
    ------------------------------------------------------------------------
    
    When run on current mainline, this litmus test gets a complaint about
    an unknown macro srcu_down_read().  With this commit:
    
    ------------------------------------------------------------------------
    
    herd7 -conf linux-kernel.cfg C-srcu-nest-6.litmus
    Test C-srcu-nest-6 Allowed
    States 3
    0:r1=0; 0:r2=0; 1:r1=0;
    0:r1=0; 0:r2=1; 1:r1=0;
    0:r1=0; 0:r2=1; 1:r1=1;
    No
    Witnesses
    Positive: 0 Negative: 3
    Condition exists (1:r1=1 /\ 0:r2=0)
    Observation C-srcu-nest-6 Never 0 3
    Time C-srcu-nest-6 0.02
    Hash=c1f20257d052ca5e899be508bedcb2a1
    
    ------------------------------------------------------------------------
    
    Note that the user must supply the flag "f" and the "filter" clause,
    similar to what must be done to emulate call_rcu().
    
    [ paulmck: Fix space-before-tab whitespace nit. ]
    
    TBD-contributions-from: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
    Not-yet-signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 70a9073dec3e5..6e702cda15e18 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -53,38 +53,31 @@ let rcu-rscs = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
-let srcu-rscs = let rec
-	    unmatched-locks = Srcu-lock \ domain(matched)
-	and unmatched-unlocks = Srcu-unlock \ range(matched)
-	and unmatched = unmatched-locks | unmatched-unlocks
-	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
-	and unmatched-locks-to-unlocks =
-		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
-	and matched = matched | (unmatched-locks-to-unlocks \
-		(unmatched-po ; unmatched-po))
-	in matched
+let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
+let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
-flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
-flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
+flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 
 (* Validate SRCU dynamic match *)
-flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
+flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
 
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
-		LKR | LKW | UL | LF | RL | RU
+		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
 (* Redefine dependencies to include those carried through plain accesses *)
-let carry-dep = (data ; rfi)*
+let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index ef0f3c1850dee..e1f65e6de06f1 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // SRCU
-srcu_read_lock(X)  __srcu{srcu-lock}(X)
-srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
+srcu_read_lock(X) __load{srcu-lock}(*X)
+srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
+srcu_down_read(X) __load{srcu-lock}(*X)
+srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
 synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
 
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73ac..53b5a492739d0 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -36,9 +36,9 @@ let RU = try RU with emptyset
 (* Treat RL as a kind of LF: a read with no ordering properties *)
 let LF = LF | RL
 
-(* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF | RU
-flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
+(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
+let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
+flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 
 (* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
