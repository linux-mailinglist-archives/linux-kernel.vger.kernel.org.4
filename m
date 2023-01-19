Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497E672EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjASC2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjASC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:28:30 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9BD19A24E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:28:29 -0800 (PST)
Received: (qmail 233529 invoked by uid 1000); 18 Jan 2023 21:28:28 -0500
Date:   Wed, 18 Jan 2023 21:28:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <Y8iqzJXVZX1lS7Kp@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8cQ/94h7048nvQ6@rowland.harvard.edu>
 <839e1765-7d47-73df-02f0-8122306b5fb3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <839e1765-7d47-73df-02f0-8122306b5fb3@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonas, each of your emails introduces too many new thoughts and ideas!  
I can't keep up.  So in this reply I'm going to skip over most of what 
you wrote.  If you think any of the items I have elided are worth 
pursuing, you can bring them up in a new thread -- hopefully with just 
one main thought per email!  :-)

On Wed, Jan 18, 2023 at 12:25:05PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/17/2023 10:19 PM, Alan Stern wrote:
> > On Tue, Jan 17, 2023 at 06:48:12PM +0100, Jonas Oberhauser wrote:
> > > On 1/14/2023 5:42 PM, Alan Stern wrote:

> > > Pretending for simplicity that rscs and grace periods aren't reads&writes
> > They aren't.  You don't have to pretend.
> 
> rscs are reads& writes in herd. That's how the data dependency works in your
> patch, right?

No, you're mixing up RCU and SRCU.  The RCU operations rcu_read_lock() 
and rcu_read_unlock() are not loads or stores; they're just fences.  In 
the current form of the LKMM the same is true for the SRCU operations 
srcu_read_lock() and srcu_read_unlock(), but in the patch I submitted 
they are indeed loads and stores.

> I consider that a hack though and don't like it.

It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
is a lot like a load, in that it returns a value obtained by reading
something from memory (along with some other operations, though, so it
isn't a simple straightforward read -- perhaps more like an
atomic_inc_return_relaxed).

srcu_read_unlock() is somewhat less like a store, but it does have one 
notable similarity: It takes an input value and therefore can be the 
target of a data dependency.  The biggest difference is that an 
srcu_read_unlock() can't really be read-from.  It would be nice if herd 
had an event type that behaved this way.

Also, herd doesn't have any way of saying that the value passed to a 
store is an unmodified copy of the value obtained by a load.  In our 
case that doesn't matter much -- nobody should be writing litmus tests 
in which the value returned by srcu_read_lock() is incremented and then 
decremented again before being passed to srcu_write_lock()!

> > > > There was also something about what should happen when you have two
> > > > grace periods in a row.
> > > Note that two grace periods in a row are a subset of po;rcu-gp;po and thus
> > > gp, and so there's nothing to be done.
> > That is not stated carefully, but it probably is wrong.  Consider this:
> > 
> > 	P0                 P1                P2
> > 	---------------    --------------    -----------------
> > 	rcu_read_lock     Wy=1               rcu_read_lock
> > 	Wx=1              synchronize_rcu    Wz=1
> > 	Ry=0              synchronize_rcu    Rx=0
> > 	rcu_read_unlock   Rz=0               rcu_read_unlock
> > 
> > (W stands for Write and R for Read.)  This execution is forbidden by the
> > counting rule: Its cycle has two grace periods and two critical
> > sections.  But if we changed the definition of gp to be
> > 
> > 	let gp = po ; [Sync-rcu | Sync-srcu] ; po
> > 
> > then the memory model would allow the execution.  So having the po? at
> > the end of gp is vital.
> 
> I hadn't thought yet about the effect of modifying the definition of gp, but
> I don't think this example relies on gp at all.
> The model would forbid this even if rcu-fence and gp were both changed from
> po? to po.
> From Rz=0 we know
>     second sync() ->rcu-gp;po Rz ->prop Wz ->po P2 unlock() ->rcu-rscsi P2
> lock()
> From Ry=0 we know
>   P1 unlock() ->rcu-rsci P1 lock() ->po Ry ->prop Wy ->po;rcu-gp first
> sync()
> 
> which are both rcu-order.
> Then from Rx=0 we have
>   Rx ->prop Wx ->po P1 unlock() ->rcu-order  first sync() ->po second sync()
> ->rcu-order P2 lock() ->po Rx
> of course since po is one case of rcu-link, we get
>   Rx ->prop Wx ->po P1 unlock() ->rcu-order P2 lock() ->po Rx
> and hence
>   Rx ->prop Wx ->rcu-fence Rx
> which is supposed to be irreflexive (even with rcu-fence=po;rcu-order;po).

By golly, you're right!  I'm still thinking in terms of an older
version of the memory model, which used gp in place of rcu-gp.  In
that version, P1's write and read would be linked by gp but not by
(gp ; rcu-link ; gp) if the po? at the end of the definition of gp
was replaced by po.

> Note that if your ordering relies on actually using gp twice in a row, then
> these must come from strong-fence, but you should be able to just take the
> shortcut by merging them into a single gp.
>   po;rcu-gp;po;rcu-gp;po <= gp <= strong-fence <= hb & strong-order

I don't know what you mean by this.  The example above does rely on
having two synchronize_rcu() calls; with only one it would be allowed.


> > > I don't think rcu-order is necessary at all to define LKMM, and one can
> > > probably just use rcu-extend instead of rcu-order (and in fact even a
> > > version of rcu-extend without any lone rcu-gps).
> > Sure, you could do that, but it wouldn't make sense.  Why would anyone
> > want to define an RCU ordering relation that includes
> > 
> > 	gp ... rscs ... gp ... rscs
> > 
> > but not
> > 
> > 	gp ... rscs ... rscs ... gp
> > 
> > ?
> 
> Because the the RCU Grace Period Guarantee doesn't say "if a gp happens
> before a gp, with some rscs in between, ...".
> So I think even the picture is not the best picture to draw for RCU
> ordering. I think the right picture to draw for RCU ordering is something
> like this:
>     case (1): C ends before G does:
> 
> 	rcsc ... ... ... ... ... gp
> 
>   case (2): G ends before C does:
> 
> 	gp ... ... ... ... ... rscs
> 
> where the dots are some relation that means "happens before".

Okay.  So we could define rcu-order by:

let rec rcu-order = (rcu-gp ; rcu-link ; (rcu-order ; rcu-link)* ; rcu-rscsi) |
	(rcu-rscsi ; rcu-link ; (rcu-order ; rcu-link)* ; rcu-gp)

(ignoring the SRCU cases).  That is a little awkward; it might make
sense to factor out (rcu-link ; (rcu-order ; rcu-link)*) as a separate
relation and do a simultaneous recursion on both relations.

But either way, rcu-fence would have to be defined as (po ; rcu-order+ ; po?),
which looks a little odd.

Alan
