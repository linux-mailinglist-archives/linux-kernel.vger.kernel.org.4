Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57B26746ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjASXLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjASXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:11:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BCBA838A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:03:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C4872CE25BD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE15C433D2;
        Thu, 19 Jan 2023 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674169401;
        bh=PnW6JmMe4/FWLfJmhEnYnN46VQgwGO5FtbcMab52fRM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=no4JGYGJzpL1XvlpHM0yZj6OlixeBlL0rx/jCLfGINm+BpkUqUz86PdfrW6Nhbe0r
         Z83y//2mFElk/Ax8ZBie0Vq/lb3xUhmaMN3ViN2lfbCjXE+RY+0dS74okH/mKRdKy1
         V49TH8lrneEyw/dhFMn2qjbY5yP+dpKZzpRGTnaKXmZ+VARqarVC7C7RpcMds+Zjta
         YZExZx4c2E41UES32NGsel9mwgerqKVUDed+mcXeTx2wv/t/HsOCufbYKadUP+0XNf
         Hie+7sCf2Fa4tSeC3y8b7f5TncBBLFKMWCAZ7BpY/el+LdLmO699xZGd31PrQDsSrL
         /NBd0LjEPd0nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A32C85C1B07; Thu, 19 Jan 2023 15:03:20 -0800 (PST)
Date:   Thu, 19 Jan 2023 15:03:20 -0800
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
Message-ID: <20230119230320.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8m+gRMMpiTuLPj2@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8m+gRMMpiTuLPj2@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:04:49PM -0500, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 01:53:04PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
> > > Index: usb-devel/tools/memory-model/linux-kernel.bell
> > > ===================================================================
> > > --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> > > +++ usb-devel/tools/memory-model/linux-kernel.bell
> > > @@ -53,38 +53,30 @@ let rcu-rscs = let rec
> > >  	in matched
> > >  
> > >  (* Validate nesting *)
> > > -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> > > -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> > > +flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
> > > +flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
> > 
> > This renaming makes sense to me.
> 
> But I'll put it in a separate patch, since it's not related to the main 
> purpose of this change.

Even better!

> > >  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> > > -let srcu-rscs = let rec
> > > -	    unmatched-locks = Srcu-lock \ domain(matched)
> > > -	and unmatched-unlocks = Srcu-unlock \ range(matched)
> > > -	and unmatched = unmatched-locks | unmatched-unlocks
> > > -	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> > > -	and unmatched-locks-to-unlocks =
> > > -		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> > > -	and matched = matched | (unmatched-locks-to-unlocks \
> > > -		(unmatched-po ; unmatched-po))
> > > -	in matched
> > > +let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
> > 
> > The point of the "+" instead of the "*" is to avoid LKMM being confused by
> > an srcu_read_lock() immediately preceding an unrelated srcu_read_unlock(),
> > right?  Or am I missing something more subtle?
> 
> No, and it's not to avoid confusion.  It merely indicates that there has 
> to be at least one instance of data or rf here; we will never have a 
> case where the lock and the unlock are the same event.

Got it, thank you!

> > >  (* Validate nesting *)
> > > -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > > -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > > +flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
> > > +flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
> > > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> > >  
> > >  (* Check for use of synchronize_srcu() inside an RCU critical section *)
> > >  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > >  
> > >  (* Validate SRCU dynamic match *)
> > > -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > > +flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
> > >  
> > >  (* Compute marked and plain memory accesses *)
> > >  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> > > -		LKR | LKW | UL | LF | RL | RU
> > > + 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
> > >  let Plain = M \ Marked
> > >  
> > >  (* Redefine dependencies to include those carried through plain accesses *)
> > > -let carry-dep = (data ; rfi)*
> > > +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
> > 
> > The "[~ Srcu-unlock]" matches the store that bridges the data and rfi",
> > correct?
> 
> Right.
> 
> > >  let addr = carry-dep ; addr
> > >  let ctrl = carry-dep ; ctrl
> > >  let data = carry-dep ; data
> > > Index: usb-devel/tools/memory-model/linux-kernel.def
> > > ===================================================================
> > > --- usb-devel.orig/tools/memory-model/linux-kernel.def
> > > +++ usb-devel/tools/memory-model/linux-kernel.def
> > > @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
> > >  synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > >  
> > >  // SRCU
> > > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > +srcu_down_read(X) __load{srcu-lock}(*X)
> > > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> > 
> > And here srcu_down_read() and srcu_up_read() are synonyms for
> > srcu_read_lock() and srcu_read_unlock(), respectively, which I believe
> > should suffice.
> > 
> > >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > >  synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> > 
> > So this looks quite reasonable to me.
> 
> Okay, good.  In theory we could check for read_lock and read_unlock on 
> different CPUs, but I don't think it's worth the trouble.

Given that lockdep already complains about that sort of thing in the
Linux kernel, agreed, it is not worth much trouble at all.

							Thanx, Paul
