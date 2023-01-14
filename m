Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86166AD0E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjANR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjANR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:27:22 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C96CCA5F9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:27:20 -0800 (PST)
Received: (qmail 66736 invoked by uid 1000); 14 Jan 2023 12:27:20 -0500
Date:   Sat, 14 Jan 2023 12:27:20 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
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
Message-ID: <Y8Ll+GhWsZtevRZT@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <17078dd97cb6480f9c51e27058af3197@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17078dd97cb6480f9c51e27058af3197@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:14:08PM +0000, Jonas Oberhauser wrote:
> > [...] cat uses least-fixed-point definitions.
> 
> Ah, but it's probably stricter than this. Even least fixed points are not always unique for these types of equations, e.g.,
>    let rec either-x-or-y = if x \in either-x-or-y then {x} else {y}
> both {x} and {y} are least fixed points of this relation.
> But I believe that cat will use only the {y} solution, right? (Yes this isn't cat syntax, but you can probably do something similar in cat using intersections, set difference, and unions?).

As I understand it, herd handles a recursive definition by starting
from an empty relation and repeatedly calculating a new value from the
definition until there are no more changes.


> > IMO it's generally better to think of grace periods as not being instantaneous but as occurring over a prolonged period of time.  Thus we should say: If a grace period ends before an unlock occurs, it must start before the corresponding lock.  And contrapositively, if a lock occurs before a grace period starts, the corresponding unlock must occur before the grace period ends.
> 
> I started thinking about it like this and comparing start/end times. That made it more complicated, but the math came out the same in the end. I could imagine that there are some scenarios where the intuition of collapsing the grace period to a single event could cause problems, but I haven't seen any.

IIRC (and it has been a long time), this may be vaguely connected with
the reason why the definitions of gp, rcu-link, and rcu-fence have po
one side but po? on the other.  There was also something about what
should happen when you have two grace periods in a row.  But I can't
remember the details.


> > SRCU is exactly like RCU except for one aspect: The SRCU primitives (synchronize_srcu(), srcu_lock(), and srcu_unlock()) each take an argument, a pointer to an srcu structure.  The ordering restrictions apply only in cases where the arguments to the corresponding primitives point to the _same_ srcu structure.  That's why you see all those "& loc" expressions sprinkled throughout the definitions of srcu-rscs and rcu-order.
> 
> I see. So in a sense it's like fine-grained RCU? I also saw Paul's e-mail hinting at some other differences, which remind me of sequence locking.
> Is it something like speculative RCU that is fine-grained to keep the number of false-positive aborts low?

Not at all.  In terms of the memory model, agreement of the srcu
structure pointers (and passing the value returned from
srcu_read_lock() to the corresponding srcu_read_unlock(), as Paul
mentioned) is the only difference.

But in terms of actual kernel programming there is another, HUGE
difference: Code executing inside an RCU read-side critical section is
not allowed to sleep or be preempted, whereas code executing inside an
SRCU read-side critical section _is_ allowed.  That's where the "S" in
"SRCU" comes from; it stands for "Sleepable".


> > > If this is true, defining rcu-order like this cuts away roughly half 
> > > of the cases (ignoring srcu, rcu-order has 6 cases and rcu-extend has 
> > > 3),
> 
> > The definition of rcu-link' should count as a case, so you have only eliminated one-third of the cases.  :-)
> 
> The only way I'd count rcu-link' as adding a case is if you say that the (...)* has two cases :D (or infinitely many :D)
> I don't count the existence of the definition because you could always inline it (but lose a lot of clarity imho).

If you did inline it, you'd probably find that the end result was
exactly what is currently in the LKMM.


> > The lone gp is present in the definition of rcu-order because I wanted to express explicitly the condition that the number of grace periods in a cycle must be _at least_ as large as the number of critical sections.  There can be more grace periods, meaning that some of them need not be paired with a critical section.
> > However, it's true that (rcu-link ; gp ; rcu-link) is a sub-relation of rcu-link.
> > Hence the only need for a lone gp in these definitions is to cover the case where there are no critical sections at all in the cycle (which I would like be to be forbidden by the rcu axiom, even if it's already forbidden by the propagation axiom).
> 
> Right, but that counting condition isn't the heart of RCU, it rather seems like an observation that helped formalize RCU at the time.
> If for example in the paper version you had excluded gp-link from the rcu-path, then the counting condition would be that the number of rcsc-link and gp-link in each rcu-path must be exactly equal.
> [The rest of the proof shouldn't be impacted (as you already point out in the paper, link ; strong-fence ; link <= link). The special case gp-link <= rcu-path is also already resolved by hb*;pb+ being irreflexive, since irreflexive(gp-link) is irreflexive(link;gp) and link;gp = hb*;pb*;prop;gp <= hb*;pb*;pb = hb*;pb+.]
> 
> Similarly,  I don't yet understand why lone gp should be mentioned in the rcu axiom. To me the fact that it works on its own is just a consequence of the strong-fence used to implement RCU. Not really a specific RCU semantics/mechanism.

It's RCU-specific in the sense that gp is an RCU primitive.

> I would prefer the rcu axiom to focus on and have a clear correspondence to the fundamental law of RCU (using the nice term from the ASPLOS paper), with as close a correspondence as possible (within constraints, like what is easy to compute and the fact that the law is, well, um, "primarily empirical in nature").

Actually it isn't, not any more.  That quote was written before we
formalized RCU in the LKMM.

In the end it doesn't matter, since cycles with grace periods but no
critical sections are already handled by the propagation axiom.

Alan
