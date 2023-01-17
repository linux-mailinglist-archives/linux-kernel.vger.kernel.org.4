Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C42670DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAQXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjAQXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:29 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1132C4B77D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:20:00 -0800 (PST)
Received: (qmail 183112 invoked by uid 1000); 17 Jan 2023 16:19:59 -0500
Date:   Tue, 17 Jan 2023 16:19:59 -0500
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
Message-ID: <Y8cQ/94h7048nvQ6@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
 <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
 <e51c82a113484b6bb62354a49376f248@huawei.com>
 <Y8LbeLflWLyivOz9@rowland.harvard.edu>
 <804a70fb-2028-a2d8-440e-347ee018c093@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <804a70fb-2028-a2d8-440e-347ee018c093@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:48:12PM +0100, Jonas Oberhauser wrote:
> 
> [I set up my huaweicloud.com address to send and receive mail, allegedly
> huaweicloud.com has fewer problems. Let's see. Also snipping together some
> mails that were sent to me in the meantime.]

That worked; your message was can be found on lore.kernel.org.

> On 1/14/2023 5:42 PM, Alan Stern wrote:
> > 
> > On Fri, Jan 13, 2023 at 02:55:34PM +0000, Jonas Oberhauser wrote:
> > > 
> > > I think the whole rcu-order topic can be summarized as the 'one
> > > rule': "if a grace period happens before a rcsc-unlock, it must also
> > > happen before the rcsc -lock, and analogously if rcsc-lock happens
> > > before a grace period, the rcsc-unlock also happens before the grace
> > > period" .
> > 
> > There is more to it than that, as I mentioned earlier. A complete
> > description can be found the explanation.txt document; it says: For any
> > critical section C and any grace period G, at least one of the following
> > statements must hold: (1) C ends before G does, and in addition, every
> > store that propagates to C's CPU before the end of C must propagate to
> > every CPU before G ends. (2) G starts before C does, and in addition,
> > every store that propagates to G's CPU before the start of G must
> > propagate to every CPU before C starts.
> 
> Yes, this difference took me a while to appreciate. If there was only (a
> strict interpretation of) the rule I mentioned, then the RCU axioms could be
> stated as just a regular atomicity axiom.
> 
> But because it also affects the surrounding operations, the recursion
> becomes necessary.
> 
> 
> > 
> > 
> > > > 
> > > > IMO it's generally better to think of grace periods as not being
> > > > instantaneous but as occurring over a prolonged period of time.
> > > > Thus we should say: If a grace period ends before an unlock
> > > > occurs, it must start before the corresponding lock. And
> > > > contrapositively, if a lock occurs before a grace period starts,
> > > > the corresponding unlock must occur before the grace period
> > > > ends.
> > > 
> > > I started thinking about it like this and comparing start/end times.
> > > That made it more complicated, but the math came out the same in the
> > > end. I could imagine that there are some scenarios where the
> > > intuition of collapsing the grace period to a single event could
> > > cause problems, but I haven't seen any.
> > 
> > 
> > 
> > IIRC (and it has been a long time), this may be vaguely connected with
> > the reason why the definitions of gp, rcu-link, and rcu-fence have po
> > one side but po? on the other.  But I can't remember the details.
> 
> 
> 
> There's at least some connection. And I think from an operational model
> perspective, the distinction has some effect.
> 
> That's because part (1) of the rule you quoted forces propagation before G

I prefer to say "requires" rather than "forces".  "Forces" sounds more 
like you're talking about a hardware mechanism that prevents something 
bad from happening, like the way the cache coherency rules are enforced.

> ends, which allows propagation to G's CPU after the start or before the end.

After the start or before the end of what?  G?  And what time could 
possibly count as being neither after the start nor before the end of G?

> Stores propagated in that time period are not forced to propagate by part
> (2).
> 
> If the two events in the operational model were merged, then all stores that
> need to propagate to G's CPU through rule (1) would also need to propagate
> to other CPU's through part (2).

Again, I don't know why you say this.  In fact, all stores that need to 
propagate to G's CPU through rule (1) are also required by to propagate 
to other CPU's through rule (1) -- not rule (2).  And this has nothing 
to do with whether the end of G occurs at the same time as the start or 
some time afterward.

> In particular, if we had an execution with 3 CPUs like below (time from top
> to bottom, also attached as a text file in case my e-mail client messes up
> the formatting)
> 
> CPU1             | CPU2           | CPU3
> start CS;        |                |
> read stage==0    |                |
>                  | stage = 1;     |
>                  |                |
>                  | GP {           |
> x = 1;           |                |
>                  |                | start CS;
>                  |                | read x == 0;
> end CS;          |                |
>                  | }              |
>                  | stage = 2;     |
>                  |                | read stage == 2;
>                  |                | read x == 1;
>                  |                | end CS;
> 
> then we allow x=1 not to propagate to the third CPU before it reads x.

I still can't understand what you're saying.  Since CPU3 reads x==1, of 
course we require x=1 to propagate to CPU3 before it reads x.

> But
> if there was only a single grace period step, which would not overlap with
> either CS, then this outcome would be forbidden.
> Because stage=1 didn't propagate to CPU1, the grace period would need to be
> after CPU1's critical section.
> Because stage=2 did propagate to CPU3, the grace period would need to be
> before CPU3's critical section.
> But then x=1 would need to propagate to CPU3 before the grace period, and
> thus before its CS starts.
> 
> I think it's because things can't happen "at the same time" in the
> operational model.

That's simply not true.  As an example, writes propagate to their own 
CPU at the same time as they execute.

>  Otherwise, x=1 could propagate "at the same time" as it
> executes the grace period, and then wouldn't be affected by rule (2)
> anymore.
> 
> But in the axiomatic model, we can use the po; ... to state that things must
> happen "strictly before" the start of G (instead of "kinda at the same
> time"). If there is a po-earlier event that observes the propagation, then
> the propagation happened before the start of G. If there is no po-earlier
> event that observes the propagation, then the store may as well have
> propagated at the same time as G (or "between the start and end"). So having
> the distinction of start and end of grace periods becomes at least less
> important.
> 
> I still haven't wrapped my head fully around why the other side has to be
> po?.
> 
> I asked Hernan to run all the old litmus tests with rcu-fence = po ;
> rcu-order ; po and he reported no difference in those tests either.
> 
> Now I'm thinking if it can be proven that some of them aren't necessary, or
> could be simplified.

Maybe.  But why go to the trouble?

> Pretending for simplicity that rscs and grace periods aren't reads&writes

They aren't.  You don't have to pretend.

> (and that prop must always start with overwrite&ext, but this can be done
> wlog if we define the rcu relations with prop? instead of prop).
> 
> I'm first looking at the rcu-link relation.
> Any use of rcu-link in rcu-order is preceded by an rscs or gp. Considering
> the cases where po? is not taken, the first edge of hb*;pb*;prop? can't be
> any of prop, rfe, or prop&int because the rcu-order never ends in
> write/reads. This leaves only ppo (or nothing), and we can use ppo <= po
> (with the patch that's currently lying on my hard disk :D) to get that he
> complete edge a subset of
> 
> (po ; hb*;pb*;prop? | id);po
> 
> Therefore I think we have rcu-link = (po ; hb*;pb*;prop? ; po) | po

This does not seem like a simplification to me.

> Next, I look at rcu-fence in rb = prop? ; rcu-fence ; hb* ; pb*.
> An rcu-fence ; hb* ; pb* which doesn't have the po at the end of rcu-fence
> can not have prop, rfe, or prop&int after the rcu-fence either. This leaves
> two cases, either the rb comes from prop? ; po ; rcu-order or from prop? ;
> po ; rcu-order ; ppo ; hb* ; pb*.
> 
> In the latter case we can use ppo <= po and get back  prop? ; po ; rcu-order
> ; po ; hb* ; pb, so considering po? here is not necessary.
> 
> In the former case, we can ask instead if po ; rcu-order ; prop? is
> irreflexive, and since prop can't follow on rcu-order, this is the same as
> po ; rcu-order.
> 
> This can only have an identity edge if at least some of the rcu-links in
> rcu-order are not just po. So let's look at the last such edge, when
> abbreviating RCU cs and grace periods as R we get
> 
>   po; (R ; rcu-link)* ; R ; po ; hb*;pb*;prop? ; (po ; R)+
> 
> where overall the number of gps >= number of rscs, and this can be rewritten
> as
> 
>   prop? ; (po ; R)+; po; (rcu-order ; rcu-link)? ; R ; po ; hb*;pb*
> 
> and I believe (po ; R)+; po; (R ; rcu-link)* ; R ; po  <= po ; rcu-order ;
> po (using the fact that overall the number of gps is still >= the number of
> rscs)
> 
> so then it simplifies again to
> 
>   prop? ; po ; rcu-order ; po ; hb*;pb*
> 
> and po? is again not necessary.
> 
> I'm again ignoring srcu here. I don't know if we can still shuffle the
> gp/rscs around like above when the locations have to match.

Indeed, before support for SRCU was added to the memory model, it did 
put the po and po? terms in other places.  I was forced to move them in 
order to add the tests for matching locations.

> Either way if you can confirm my suspicion that the po? in rcu-fence could
> be replaced by po, and that the po? in rcu-link could be replaced by (po ;
> ... ; po) | po, or have a counter example and some additional explanation
> for why the po? makes sense, I'd be thankful.
> 
> 
> > There was also something about what should happen when you have two
> > grace periods in a row.
> 
> Note that two grace periods in a row are a subset of po;rcu-gp;po and thus
> gp, and so there's nothing to be done.

That is not stated carefully, but it probably is wrong.  Consider this:

	P0                 P1                P2
	---------------    --------------    -----------------
	rcu_read_lock     Wy=1               rcu_read_lock
	Wx=1              synchronize_rcu    Wz=1
	Ry=0              synchronize_rcu    Rx=0
	rcu_read_unlock   Rz=0               rcu_read_unlock

(W stands for Write and R for Read.)  This execution is forbidden by the 
counting rule: Its cycle has two grace periods and two critical 
sections.  But if we changed the definition of gp to be

	let gp = po ; [Sync-rcu | Sync-srcu] ; po

then the memory model would allow the execution.  So having the po? at 
the end of gp is vital.  (Or at the beginning; I think either one would 
work as well and the choice was arbitrary.)

> Something more interesting happens with critical sections, where currently
> po ; rcu-rcsci ; po ; rcu-rcsci ; po should be a subset of po ; rcu-rcsci ;
> po  because of the forbidden partial overlap. But I currently don't think
> it's necessary to consider such cases.
> 
> The other thing that causes complications is when all the pb*,hb*,and prop
> links in rcu-link are just id, and then rcu-link becomes po?;po = po.
> Currently I don't understand why such pure po links should be necessary at
> all, since they should just merge with the neighboring rcu-gps into a gp
> edge.
> 
> > > 
> > > The only way I'd count rcu-link' as adding a case is if you say that
> > > the (...)* has two cases :D (or infinitely many :D) I don't count
> > > the existence of the definition because you could always inline it
> > > (but lose a lot of clarity imho).
> > 
> > 
> > 
> > If you did inline it, you'd probably find that the end result was
> > exactly what is currently in the LKMM.
> 
> Not quite. There are two differences. The first is that the
> rcu-order;rcu-link;rcu-order case disappears.
> 
> The second is that the ...;rcu-link;... and
> ...;rcu-link;rcu-order;rcu-link;... subcases get merged, and not to
> ...;rcu-link;(rcu-order;rcu-link)?;... but to
> ...;rcu-link;(rcu-order;rcu-link)*;...

Okay.

> Indeed the definitions of rcu-extend and rcu-order can't become exactly the
> same because they are different relations, e.g., rcu-order can begin and end
> with a grace period but rcu-extend can't.
> 
> That's why an additional non-recursive layer of
> 
>    rcu-order = rcu-extend ; (rcu-link; rcu-extend)*
> 
> is necessary to define rcu-order in terms of rcu-extend. But as I mentioned
> I don't think rcu-order is necessary at all to define LKMM, and one can
> probably just use rcu-extend instead of rcu-order (and in fact even a
> version of rcu-extend without any lone rcu-gps).

Sure, you could do that, but it wouldn't make sense.  Why would anyone 
want to define an RCU ordering relation that includes

	gp ... rscs ... gp ... rscs

but not

	gp ... rscs ... rscs ... gp

?

> > > the law is, well, um, "primarily empirical in nature"
> > 
> > 
> > 
> > Actually it isn't, not any more. That quote was written before we
> > formalized RCU in the LKMM.
> 
> I meant that the original formulation was empirical; of course you have
> formalized it, but how do you know that the formalization is valid?

We proved it in the ASPLOS paper.  That is, we proved that a particular 
implementation faithfully obeys the restrictions of the formalization.

>  I think
> the correspondence with "what's intended" is always an empirical thing, even
> if you formally prove the correctness of the imlementation against the
> specification you might have missed some parts or added some parts that are
> actually just implementation details.

While I agree that it is difficult to be sure that an informal 
specification agrees with a formal model, I wouldn't describe attempts 
to ensure this as "empirical".

Alan
