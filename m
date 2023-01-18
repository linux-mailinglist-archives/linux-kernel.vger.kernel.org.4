Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556716729C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjARUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjARUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:54:50 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 845F57ED0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:54:48 -0800 (PST)
Received: (qmail 224150 invoked by uid 1000); 18 Jan 2023 15:54:47 -0500
Date:   Wed, 18 Jan 2023 15:54:47 -0500
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
Message-ID: <Y8hclxuhpGm+krkz@rowland.harvard.edu>
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:06:01PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 11:50:24AM -0500, Alan Stern wrote:
> Boqun mentioned off-list this morning that this is still the case,
> and that each execution of srcu_read_lock() will return a unique value.
> Assuming that I understood him correctly, anyway.

That will no longer be true with the patch I posted yesterday.  Every 
execution of srcu_read_lock() will return 0 (or whatever the initial 
value of the lock variable is).

But with a small change to the .def file, each execution of 
srcu_read_unlock() can be made to increment the lock's value, and then 
the next srcu_read_lock() would naturally return the new value.

> > > given that I have no idea how one would go about modeling down_read()
> > > and up_read() in LKMM.
> > 
> > It might make sense to work on that first, before trying to do 
> > srcu_down_read() and srcu_up_read().
> 
> The thing is that it is easy to associate an srcu_down_read() with the
> corresponding srcu_up_read().  With down() and up(), although in the
> Linux kernel this might be represented by a data structure tracking
> (say) an I/O request, LKMM is going to be hard pressed to figure that out.

It would help (or at least, it would help _me_) if you gave a short 
explanation of how srcu_down_read() and srcu_up_read() are meant to 
work.  With regular r/w semaphores, the initial lock value is 0, each 
down() operation decrements the value, each up() operation increments 
the value -- or vice versa if you don't like negative values -- and a 
write_lock() will wait until the value is >= 0.  In that setting, it 
makes sense to say that a down() which changes the value from n to n-1 
matches the next up() which changes the value from n-1 to n.

I presume that srcu semaphores do not work this way.  Particularly since 
the down() operation returns a value which must be passed to the 
corresponding up() operation.  So how _do_ they work?

> > Hmmm.  What happens if you write:
> > 
> > 	r1 = srcu_down_read(x);
> > 	r2 = srcu_down_read(x);
> > 	srcu_up_read(x, r1);
> > 	srcu_up_read(x, r2);
> > 
> > ?  I can't even tell what that would be _intended_ to do.
> 
> Let's take it one line at a time:
> 
> 	r1 = srcu_down_read(x);
> 	// A
> 	r2 = srcu_down_read(x);
> 	// B
> 	srcu_up_read(x, r1);
> 	// C
> 	srcu_up_read(x, r2);
> 	// D
> 
> An SRCU grace period that starts at A is permitted to complete at
> C, difficult though it might be to actually make this happen in the
> Linux kernel.  It need wait only for pre-existing critical sections.

So the down() returning r1 matches the up() receiving r1?

> But an SRCU grace period that starts at either B or C must wait for both
> critical sections, that is until D.

Implying that the down() returning r2 matches up() receiving r2?

And in general, an up() matches a down() iff they have the same values?  
And we can imagine that every down() returns a different value?  

How does this differ from srcu_read_lock() and srcu_read_unlock()?  And 
how do the "up" and "down" parts figure into it? -- what is going up or 
down?

Alan
