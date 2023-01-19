Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB96745D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjASWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjASWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:21:18 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1971E45897
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:04:50 -0800 (PST)
Received: (qmail 10391 invoked by uid 1000); 19 Jan 2023 17:04:49 -0500
Date:   Thu, 19 Jan 2023 17:04:49 -0500
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
Message-ID: <Y8m+gRMMpiTuLPj2@rowland.harvard.edu>
References: <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:53:04PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
> > Index: usb-devel/tools/memory-model/linux-kernel.bell
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> > +++ usb-devel/tools/memory-model/linux-kernel.bell
> > @@ -53,38 +53,30 @@ let rcu-rscs = let rec
> >  	in matched
> >  
> >  (* Validate nesting *)
> > -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> > -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> > +flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
> > +flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
> 
> This renaming makes sense to me.

But I'll put it in a separate patch, since it's not related to the main 
purpose of this change.

> 
> >  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> > -let srcu-rscs = let rec
> > -	    unmatched-locks = Srcu-lock \ domain(matched)
> > -	and unmatched-unlocks = Srcu-unlock \ range(matched)
> > -	and unmatched = unmatched-locks | unmatched-unlocks
> > -	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> > -	and unmatched-locks-to-unlocks =
> > -		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> > -	and matched = matched | (unmatched-locks-to-unlocks \
> > -		(unmatched-po ; unmatched-po))
> > -	in matched
> > +let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
> 
> The point of the "+" instead of the "*" is to avoid LKMM being confused by
> an srcu_read_lock() immediately preceding an unrelated srcu_read_unlock(),
> right?  Or am I missing something more subtle?

No, and it's not to avoid confusion.  It merely indicates that there has 
to be at least one instance of data or rf here; we will never have a 
case where the lock and the unlock are the same event.

> 
> >  (* Validate nesting *)
> > -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > +flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
> > +flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
> > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> >  
> >  (* Check for use of synchronize_srcu() inside an RCU critical section *)
> >  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> >  
> >  (* Validate SRCU dynamic match *)
> > -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > +flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
> >  
> >  (* Compute marked and plain memory accesses *)
> >  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> > -		LKR | LKW | UL | LF | RL | RU
> > + 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
> >  let Plain = M \ Marked
> >  
> >  (* Redefine dependencies to include those carried through plain accesses *)
> > -let carry-dep = (data ; rfi)*
> > +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
> 
> The "[~ Srcu-unlock]" matches the store that bridges the data and rfi",
> correct?

Right.

> 
> >  let addr = carry-dep ; addr
> >  let ctrl = carry-dep ; ctrl
> >  let data = carry-dep ; data
> > Index: usb-devel/tools/memory-model/linux-kernel.def
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/linux-kernel.def
> > +++ usb-devel/tools/memory-model/linux-kernel.def
> > @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
> >  synchronize_rcu_expedited() { __fence{sync-rcu}; }
> >  
> >  // SRCU
> > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > +srcu_down_read(X) __load{srcu-lock}(*X)
> > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> 
> And here srcu_down_read() and srcu_up_read() are synonyms for
> srcu_read_lock() and srcu_read_unlock(), respectively, which I believe
> should suffice.
> 
> >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> >  synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> 
> So this looks quite reasonable to me.

Okay, good.  In theory we could check for read_lock and read_unlock on 
different CPUs, but I don't think it's worth the trouble.

Alan
