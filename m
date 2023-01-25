Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF467C02E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjAYWws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:52:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E2E6FEE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:52:43 -0800 (PST)
Received: (qmail 231182 invoked by uid 1000); 25 Jan 2023 17:52:42 -0500
Date:   Wed, 25 Jan 2023 17:52:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
Message-ID: <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 9:21 PM, Alan Stern wrote:
> >   (* Validate nesting *)
> >   flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> >   flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
> > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> 
> Have you considered adding
> flag ~empty (srcu-rscs ; srcu-rscs^-1) \ id as mixed-srcu-cookie

I had not considered it.  You'd have to do something pretty bizarre if 
you wanted to trigger this warning, though.  Like:

	r1 = srcu_read_lock(s);
	r2 = srcu_read_lock(s);
	srcu_read_unlock(s, r1 + r2);

> Although I think one has to be intentionally trying to trick herd
> to be violating this. If herd could produce different cookies, this would be
> easy to detect just by the different-values flag you already have.

Unless you did: srcu_read_unlock(s, r1 + r2 * 0).  :-)

> >   (* Check for use of synchronize_srcu() inside an RCU critical section *)
> >   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > @@ -80,11 +73,11 @@ flag ~empty different-values(srcu-rscs)
> >   (* Compute marked and plain memory accesses *)
> >   let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> > -		LKR | LKW | UL | LF | RL | RU
> > +		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
> 
> Good catch! But why wasn't this necessary before? Is it only necessary now
> because the accesses became loads and stores (maybe to avoid data races?)

Exactly.  Before this those events weren't memory accesses at all.

> >   // SRCU
> > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > +srcu_down_read(X) __load{srcu-lock}(*X)
> > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> 
> How do you feel about introducing Srcu-up and Srcu-down with this patch?

Why invent new classes for them?  They are literally the same operation 
as Srcu-lock and Srcu-unlock; the only difference is how the kernel's 
lockdep checker treats them.

> > +(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
> > +let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
> > +flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> 
> Since this was pointed out by Boqun, would it be appropriate to mention him
> in the patch somehow?

True.  After we settle everything else, I'll add something to that 
effect.

Alan
