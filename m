Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B104675B65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjATRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjATRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47FDBD4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BC26B82956
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 17:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DAEC433EF;
        Fri, 20 Jan 2023 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674235855;
        bh=8e4Oc+PdMZoEdCmDtdRPbRTfE/AHEwGW7EDTg0vRnz0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fce2d1vLKJstX2cdLzemNpjClcD/epa65GMxVTCzayQyw5UwngFwYcPZ1q4U/PIyD
         dkWSmIsw9n0D634BAybynmOU2aXpDwM7pAeLb6wh5NSVFl1b06cNyXqzJJLRwdEIhL
         LWzHtPbrxbB0Ie04opG+i3Cp0260AR+6CwJclcG8gBtW2cIuN6LDQ00U4lA91ny8/V
         9h3YgEvu0/sI/BKMPyBt2cjo6xgOMwExCFpThRB8389hOPqMvIP9YT/GeeMqOn/qU9
         a4iY8Q/TGZ8YXRLKYRSJdRlVDpH+Rk7pGqM1vnzRDyoLmkb6Yd7uj960637wxJuhLu
         vwJXULzN6xOfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E4FE35C17DC; Fri, 20 Jan 2023 09:30:54 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:30:54 -0800
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
Message-ID: <20230120173054.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
 <Y8q9zjxA620GAFu2@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8q9zjxA620GAFu2@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:14:06AM -0500, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 07:55:21PM -0800, Paul E. McKenney wrote:
> > And for some initial tests:
> > 
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-1.litmus
> > 
> > 	"Flag multiple-srcu-matches" but otherwise OK.
> > 	As a "hail Mary" exercise, I used r4 for the second SRCU
> > 	read-side critical section, but this had no effect.
> > 	(This flag is expected and seen for #4 below.)
> 
> Jonas is right about the reason for this.  Also, his suggestion for 
> fixing the check in lock.cat makes sense.

Very good!

> My revised patch is below.

Thank you!  Are you OK with my putting this on a not-for-mainline branch
for experimental purposes?

> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-2.litmus
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-3.litmus
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-4.litmus
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-5.litmus
> > 
> > 	All as expected.
> > 
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-6.litmus
> > 
> > 	Get "Flag unbalanced-srcu-lock" and "Flag unbalanced-srcu-unlock",
> > 	but this is srcu_down_read() and srcu_up_read(), where this should
> > 	be OK.	Ah, but I need to do the release/acquire/filter trick.  Once
> > 	I did that, it works as expected.
> > 
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-7.litmus
> > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-8.litmus
> > 
> > 	Both as expected.
> > 
> > Getting there!!!
> 
> Good news.

And all of the litmus-repo tests up to ten processes passed.  Woo-hoo!!!

							Thanx, Paul

> Alan
> 
> 
> 
> Index: usb-devel/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> +++ usb-devel/tools/memory-model/linux-kernel.bell
> @@ -53,38 +53,31 @@ let rcu-rscs = let rec
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
> +let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> +let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
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
>  
> Index: usb-devel/tools/memory-model/lock.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/lock.cat
> +++ usb-devel/tools/memory-model/lock.cat
> @@ -36,9 +36,9 @@ let RU = try RU with emptyset
>  (* Treat RL as a kind of LF: a read with no ordering properties *)
>  let LF = LF | RL
>  
> -(* There should be no ordinary R or W accesses to spinlocks *)
> -let ALL-LOCKS = LKR | LKW | UL | LF | RU
> -flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> +(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
> +let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
> +flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
>  
>  (* Link Lock-Reads to their RMW-partner Lock-Writes *)
>  let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
