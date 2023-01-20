Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DC674A63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjATDz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjATDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:55:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F4A1030
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:55:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F2261DF7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04EDC433D2;
        Fri, 20 Jan 2023 03:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674186921;
        bh=/nyUGWTBGkGKmgR9Z/paqCp0QZIVo/z2O7z4QZifI74=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rvx32qxKtC1aqH7UbCiWNqx8f4c/XRLucFSrK5nCROuA4txFLwnN81IDuXxABgjrh
         sD6B3jH1RgzPtRdipE1si9UJ2gwxufBNSKr3ZiERO6bw3YXbVC+MWpQ/EeUr5zJBiz
         rOztkwVBmOIRoJV4oUXN9k7O99/I0HjCLPYBL/O+bNC371HF+mZpSYPB4xWVD6QbDV
         Nj5x4BecWzhv0cYOmn8CBCq5JjGFEH7g3QuD3rfpby6Nw6KIbxCkgjztRUO6ZRDBxV
         cUk8AgVaJsmOGDQ1A3nO8urQgoxQPRXVvTjBe3I6Bql2LTno0btqKiBTi5R3Ghcett
         mcW5XNv7yWgZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B1735C1B08; Thu, 19 Jan 2023 19:55:21 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:55:21 -0800
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
Message-ID: <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 10:41:07AM -0800, Paul E. McKenney wrote:
> > In contrast, this actually needs srcu_down_read() and srcu_up_read():
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-nest-6
> > 
> > (*
> >  * Result: Never
> >  *
> >  * Flag unbalanced-srcu-locking
> >  * This would be valid for srcu_down_read() and srcu_up_read().
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, struct srcu_struct *s1, int *idx)
> > {
> > 	int r2;
> > 	int r3;
> > 
> > 	r3 = srcu_down_read(s1);
> > 	WRITE_ONCE(*idx, r3);
> > 	r2 = READ_ONCE(*y);
> > }
> > 
> > P1(int *x, int *y, struct srcu_struct *s1, int *idx)
> > {
> > 	int r1;
> > 	int r3;
> > 
> > 	r1 = READ_ONCE(*x);
> > 	r3 = READ_ONCE(*idx);
> > 	srcu_up_read(s1, r3);
> > }
> > 
> > P2(int *x, int *y, struct srcu_struct *s1)
> > {
> > 	WRITE_ONCE(*y, 1);
> > 	synchronize_srcu(s1);
> > 	WRITE_ONCE(*x, 1);
> > }
> > 
> > locations [0:r1]
> > exists (1:r1=1 /\ 0:r2=0)
> 
> I modified this litmus test by adding a flag variable with an 
> smp_store_release in P0, an smp_load_acquire in P1, and a filter clause 
> to ensure that P1 reads the flag and idx from P1.
> 
> With the patch below, the results were as expected:
> 
> Test C-srcu-nest-6 Allowed
> States 3
> 0:r1=0; 0:r2=0; 1:r1=0;
> 0:r1=0; 0:r2=1; 1:r1=0;
> 0:r1=0; 0:r2=1; 1:r1=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (1:r1=1 /\ 0:r2=0)
> Observation C-srcu-nest-6 Never 0 3
> Time C-srcu-nest-6 0.04
> Hash=2b010cf3446879fb84752a6016ff88c5
> 
> It turns out that the idea of removing rf edges from Srcu-unlock events 
> doesn't work well.  The missing edges mess up herd's calculation of the 
> fr relation and the coherence axiom.  So I've gone back to filtering 
> those edges out of carry-dep.
> 
> Also, Boqun's suggestion for flagging ordinary accesses to SRCU 
> structures no longer works, because the lock and unlock operations now 
> _are_ normal accesses.  I removed that check too, but it shouldn't hurt 
> much because I don't expect to encounter litmus tests that try to read 
> or write srcu_structs directly.
> 
> Alan
> 
> 
> 
> Index: usb-devel/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> +++ usb-devel/tools/memory-model/linux-kernel.bell
> @@ -53,38 +53,30 @@ let rcu-rscs = let rec
>  	in matched
>  
>  (* Validate nesting *)
> -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> +flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
> +flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
>  
>  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> -let srcu-rscs = let rec
> -	    unmatched-locks = Srcu-lock \ domain(matched)
> -	and unmatched-unlocks = Srcu-unlock \ range(matched)
> -	and unmatched = unmatched-locks | unmatched-unlocks
> -	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> -	and unmatched-locks-to-unlocks =
> -		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> -	and matched = matched | (unmatched-locks-to-unlocks \
> -		(unmatched-po ; unmatched-po))
> -	in matched
> +let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
>  
>  (* Validate nesting *)
> -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> +flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
> +flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
> +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
>  
>  (* Check for use of synchronize_srcu() inside an RCU critical section *)
>  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>  
>  (* Validate SRCU dynamic match *)
> -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> +flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
>  
>  (* Compute marked and plain memory accesses *)
>  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> -		LKR | LKW | UL | LF | RL | RU
> + 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
>  let Plain = M \ Marked
>  
>  (* Redefine dependencies to include those carried through plain accesses *)
> -let carry-dep = (data ; rfi)*
> +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
>  let addr = carry-dep ; addr
>  let ctrl = carry-dep ; ctrl
>  let data = carry-dep ; data
> Index: usb-devel/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.def
> +++ usb-devel/tools/memory-model/linux-kernel.def
> @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
>  synchronize_rcu_expedited() { __fence{sync-rcu}; }
>  
>  // SRCU
> -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> +srcu_read_lock(X) __load{srcu-lock}(*X)
> +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> +srcu_down_read(X) __load{srcu-lock}(*X)
> +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
>  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
>  synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }

And for some initial tests:

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-1.litmus

	"Flag multiple-srcu-matches" but otherwise OK.
	As a "hail Mary" exercise, I used r4 for the second SRCU
	read-side critical section, but this had no effect.
	(This flag is expected and seen for #4 below.)

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-2.litmus
https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-3.litmus
https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-4.litmus
https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-5.litmus

	All as expected.

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-6.litmus

	Get "Flag unbalanced-srcu-lock" and "Flag unbalanced-srcu-unlock",
	but this is srcu_down_read() and srcu_up_read(), where this should
	be OK.	Ah, but I need to do the release/acquire/filter trick.  Once
	I did that, it works as expected.

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-7.litmus
https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-8.litmus

	Both as expected.

Getting there!!!

I also started a regression test, hopefully without pilot error.  :-/

							Thanx, Paul
