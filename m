Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6C66A41D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjAMUcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAMUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:32:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4E10FD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8290BCE213C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8332C433D2;
        Fri, 13 Jan 2023 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673641961;
        bh=BWrL4wk/3WPSVzxYNc66fDaltd5GFXnajjc4d8LJwRc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tMy1oPw16KXSgt5/+zNYz8qOZhiwRYzhfZLMRcnST+ILC9EtG2xQ/YebQxHdu+H9v
         SPAJcmPbaFq9o6dM7/6dFOH8BN+XgWI5wndUyUkfnw6if8wX/UgXkx2/o/8DRZTPfc
         BdyD+jXtgH/Cc/IwgoJgNsJpBOTpPMHYqz1oIldpq1cpMdKhE/SyXb9x5bBjFbQRNB
         41y1SKYpYcKSl5CS1TkwLrkYYBfN6UJTbQSGHRoTsa5R8e6YOqgIFqWEymWbut7R3o
         M9+1JKXqVodkzBD5PpqtoNS0zQ3ObZomK43/l5jH3La1ProWsLkwkhLQ3C3p8keT/8
         AABZ+CMt4n2Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4ADAC5C06D0; Fri, 13 Jan 2023 12:32:41 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:32:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:07:06PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 13, 2023 at 11:28:10AM -0500, Alan Stern wrote:
> > On Thu, Jan 12, 2023 at 01:48:26PM +0000, Jonas Oberhauser wrote:
> > > From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> > > Sent: Wednesday, January 11, 2023 4:06 PM

[ . . . ]

> > SRCU is exactly like RCU except for one aspect: The SRCU primitives
> > (synchronize_srcu(), srcu_lock(), and srcu_unlock()) each take an
> > argument, a pointer to an srcu structure.  The ordering restrictions
> > apply only in cases where the arguments to the corresponding
> > primitives point to the _same_ srcu structure.  That's why you see all
> > those "& loc" expressions sprinkled throughout the definitions of
> > srcu-rscs and rcu-order.
> 
> In addition, the actual Linux-kernel SRCU has srcu_read_lock() return a
> value that must be passed to srcu_read_unlock().  This means that SRCU
> can have distinct overlapping SRCU read-side critical sections within
> the confines of a given process.
> 
> Worse yet, the upcoming addition of srcu_down_read() and srcu_up_read()
> means that a given SRCU read-side critical section might begin on one
> process and end on another.  Thus srcu_down_read() is to srcu_read_lock()
> as down_sema() is to mutex_lock(), more or less.
> 
> Making LKMM correctly model all of this has been on my todo list for an
> embarrassingly long time.

But there is no time like the present...

Here is what mainline has to recognize SRCU read-side critical sections:

------------------------------------------------------------------------

(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
let srcu-rscs = let rec
	    unmatched-locks = Srcu-lock \ domain(matched)
	and unmatched-unlocks = Srcu-unlock \ range(matched)
	and unmatched = unmatched-locks | unmatched-unlocks
	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
	and unmatched-locks-to-unlocks =
		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
	and matched = matched | (unmatched-locks-to-unlocks \
		(unmatched-po ; unmatched-po))
	in matched

(* Validate nesting *)
flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking

(* Check for use of synchronize_srcu() inside an RCU critical section *)
flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep

(* Validate SRCU dynamic match *)
flag ~empty different-values(srcu-rscs) as srcu-bad-nesting

------------------------------------------------------------------------

And here is what I just now tried:

------------------------------------------------------------------------

(* Compute matching pairs of Srcu-lock and Srcu-unlock *)
let srcu-rscs = ([Srcu-lock] ; rfi ; [Srcu-unlock]) & loc

(* Validate nesting *)
flag empty srcu-rscs as no-srcu-readers
flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking

(* Check for use of synchronize_srcu() inside an RCU critical section *)
flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep

(* Validate SRCU dynamic match *)
flag ~empty different-values(srcu-rscs) as srcu-bad-nesting

------------------------------------------------------------------------

This gets me "Flag no-srcu-readers" when running this litmus test:

------------------------------------------------------------------------

C C-srcu-nest-1

(*
 * Result: Never
 *)

{}

P0(int *x, int *y, struct srcu_struct *s)
{
	int r1;
	int r2;
	int r3;

	r3 = srcu_read_lock(s);
	r1 = READ_ONCE(*x);
	srcu_read_unlock(s, r3);
	r3 = srcu_read_lock(s);
	r2 = READ_ONCE(*y);
	srcu_read_unlock(s, r3);
}

P1(int *x, int *y, struct srcu_struct *s)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
exists (0:r1=1 /\ 0:r2=0)

------------------------------------------------------------------------

So what did I mess up this time?  ;-)

							Thanx, Paul
