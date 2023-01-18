Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2001E6710F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjARCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:15:17 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 88A0D51C66
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:15:16 -0800 (PST)
Received: (qmail 190654 invoked by uid 1000); 17 Jan 2023 21:15:15 -0500
Date:   Tue, 17 Jan 2023 21:15:15 -0500
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
Message-ID: <Y8dWMyBfz1iiaF8M@rowland.harvard.edu>
References: <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:

> > Isn't it true that the current code will flag srcu-bad-nesting if a 
> > litmus test has non-nested overlapping SRCU read-side critical sections?
> 
> Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> 
> Just to see if I understand, different-values yields true if the set
> contains multiple elements with the same value mapping to different
> values.  Or, to put it another way, if the relation does not correspond
> to a function.
> 
> Or am I still missing something?
> 
> > And if it is true, is there any need to change the memory model at this 
> > point?
> > 
> > (And if it's not true, that's most likely due to a bug in herd7.)
> 
> Agreed, changes must wait for SRCU support in herd7.

Maybe we don't.  Please test the patch below; I think it will do what 
you want -- and it doesn't rule out nesting.

Alan



Index: usb-devel/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.bell
+++ usb-devel/tools/memory-model/linux-kernel.bell
@@ -57,20 +57,12 @@ flag ~empty Rcu-lock \ domain(rcu-rscs)
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
 
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
+let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
 
 (* Validate nesting *)
 flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
-flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlocking
+flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-unlocks
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
@@ -80,11 +72,11 @@ flag ~empty different-values(srcu-rscs)
 
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
-		LKR | LKW | UL | LF | RL | RU
+ 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
 (* Redefine dependencies to include those carried through plain accesses *)
-let carry-dep = (data ; rfi)*
+let carry-dep = (data ; rfi ; [~Srcu-lock])*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
Index: usb-devel/tools/memory-model/linux-kernel.def
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.def
+++ usb-devel/tools/memory-model/linux-kernel.def
@@ -49,8 +49,8 @@ synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // SRCU
-srcu_read_lock(X)  __srcu{srcu-lock}(X)
-srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
+srcu_read_lock(X)  __load{srcu-lock}(*X)
+srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
 synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
 

