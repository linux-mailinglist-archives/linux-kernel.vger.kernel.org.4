Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7366AD18
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjANRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjANRkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:40:41 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C31A9658F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:40:39 -0800 (PST)
Received: (qmail 67313 invoked by uid 1000); 14 Jan 2023 12:40:39 -0500
Date:   Sat, 14 Jan 2023 12:40:39 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y8LpF9O2tta86hEr@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:32:41PM -0800, Paul E. McKenney wrote:
> > Making LKMM correctly model all of this has been on my todo list for an
> > embarrassingly long time.
> 
> But there is no time like the present...
> 
> Here is what mainline has to recognize SRCU read-side critical sections:
> 
> ------------------------------------------------------------------------
> 
> (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> let srcu-rscs = let rec
> 	    unmatched-locks = Srcu-lock \ domain(matched)
> 	and unmatched-unlocks = Srcu-unlock \ range(matched)
> 	and unmatched = unmatched-locks | unmatched-unlocks
> 	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> 	and unmatched-locks-to-unlocks =
> 		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> 	and matched = matched | (unmatched-locks-to-unlocks \
> 		(unmatched-po ; unmatched-po))
> 	in matched
> 
> (* Validate nesting *)
> flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> 
> (* Check for use of synchronize_srcu() inside an RCU critical section *)
> flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> 
> (* Validate SRCU dynamic match *)
> flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> 
> ------------------------------------------------------------------------
> 
> And here is what I just now tried:
> 
> ------------------------------------------------------------------------
> 
> (* Compute matching pairs of Srcu-lock and Srcu-unlock *)
> let srcu-rscs = ([Srcu-lock] ; rfi ; [Srcu-unlock]) & loc

This doesn't make sense.  Herd treats srcu_read_lock() as a load
operation (it takes a pointer as argument and returns a value) and
srcu_read_unlock() as a store operation (it takes both a pointer and a
value as arguments and returns nothing).  So you can't connect them
with an rfi link; stores don't "read-from" loads.

I suppose you might be able to connect them with a data dependency,
though.  But then how would you handle situations where two unlock
calls both use the value returned from a single lock call?  You'd have
to check explicitly that srcu-rscs connected each lock with only one
unlock.

Alan

> (* Validate nesting *)
> flag empty srcu-rscs as no-srcu-readers
> flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> 
> (* Check for use of synchronize_srcu() inside an RCU critical section *)
> flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> 
> (* Validate SRCU dynamic match *)
> flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> 
> ------------------------------------------------------------------------
> 
> This gets me "Flag no-srcu-readers" when running this litmus test:
> 
> ------------------------------------------------------------------------
> 
> C C-srcu-nest-1
> 
> (*
>  * Result: Never
>  *)
> 
> {}
> 
> P0(int *x, int *y, struct srcu_struct *s)
> {
> 	int r1;
> 	int r2;
> 	int r3;
> 
> 	r3 = srcu_read_lock(s);
> 	r1 = READ_ONCE(*x);
> 	srcu_read_unlock(s, r3);
> 	r3 = srcu_read_lock(s);
> 	r2 = READ_ONCE(*y);
> 	srcu_read_unlock(s, r3);
> }
> 
> P1(int *x, int *y, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*x, 1);
> }
> 
> locations [0:r1]
> exists (0:r1=1 /\ 0:r2=0)
> 
> ------------------------------------------------------------------------
> 
> So what did I mess up this time?  ;-)
> 
> 							Thanx, Paul
