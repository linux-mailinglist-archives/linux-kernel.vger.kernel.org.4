Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3E674322
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjASTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjASTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:51:57 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9CB329D292
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:51:54 -0800 (PST)
Received: (qmail 262162 invoked by uid 1000); 19 Jan 2023 14:51:53 -0500
Date:   Thu, 19 Jan 2023 14:51:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
References: <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:41:07AM -0800, Paul E. McKenney wrote:
> In contrast, this actually needs srcu_down_read() and srcu_up_read():
> 
> ------------------------------------------------------------------------
> 
> C C-srcu-nest-6
> 
> (*
>  * Result: Never
>  *
>  * Flag unbalanced-srcu-locking
>  * This would be valid for srcu_down_read() and srcu_up_read().
>  *)
> 
> {}
> 
> P0(int *x, int *y, struct srcu_struct *s1, int *idx)
> {
> 	int r2;
> 	int r3;
> 
> 	r3 = srcu_down_read(s1);
> 	WRITE_ONCE(*idx, r3);
> 	r2 = READ_ONCE(*y);
> }
> 
> P1(int *x, int *y, struct srcu_struct *s1, int *idx)
> {
> 	int r1;
> 	int r3;
> 
> 	r1 = READ_ONCE(*x);
> 	r3 = READ_ONCE(*idx);
> 	srcu_up_read(s1, r3);
> }
> 
> P2(int *x, int *y, struct srcu_struct *s1)
> {
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s1);
> 	WRITE_ONCE(*x, 1);
> }
> 
> locations [0:r1]
> exists (1:r1=1 /\ 0:r2=0)

I modified this litmus test by adding a flag variable with an 
smp_store_release in P0, an smp_load_acquire in P1, and a filter clause 
to ensure that P1 reads the flag and idx from P1.

With the patch below, the results were as expected:

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
Time C-srcu-nest-6 0.04
Hash=2b010cf3446879fb84752a6016ff88c5

It turns out that the idea of removing rf edges from Srcu-unlock events 
doesn't work well.  The missing edges mess up herd's calculation of the 
fr relation and the coherence axiom.  So I've gone back to filtering 
those edges out of carry-dep.

Also, Boqun's suggestion for flagging ordinary accesses to SRCU 
structures no longer works, because the lock and unlock operations now 
_are_ normal accesses.  I removed that check too, but it shouldn't hurt 
much because I don't expect to encounter litmus tests that try to read 
or write srcu_structs directly.

Alan



Index: usb-devel/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.bell
+++ usb-devel/tools/memory-model/linux-kernel.bell
@@ -53,38 +53,30 @@ let rcu-rscs = let rec
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
+let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
 
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
+ 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
 (* Redefine dependencies to include those carried through plain accesses *)
-let carry-dep = (data ; rfi)*
+let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
Index: usb-devel/tools/memory-model/linux-kernel.def
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.def
+++ usb-devel/tools/memory-model/linux-kernel.def
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
 
