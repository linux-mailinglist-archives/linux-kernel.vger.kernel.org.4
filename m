Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618DE6786F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjAWT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAWT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:58:31 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9F69227D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:58:29 -0800 (PST)
Received: (qmail 139206 invoked by uid 1000); 23 Jan 2023 14:58:28 -0500
Date:   Mon, 23 Jan 2023 14:58:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <Y87m5KcSaieYZyeM@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8lynRI35cFeuqb5@rowland.harvard.edu>
 <2cde689d-69b1-b719-1739-e1657d8de044@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cde689d-69b1-b719-1739-e1657d8de044@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:16:27PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 5:41 PM, Alan Stern wrote:
> > The point is that in P1, we have Write ->(gp;gp) Read, but we do not
> > have Write ->(gp';gp') Read.  Only Write ->gp' Read.  So if you're using
> > gp' instead of gp, you'll analyze the litmus test as if it had only one
> > grace period but two critical sections, getting a wrong answer.
> 
> Are you writing about the old model? Otherwise I don't see how this can give
> a wrong answer.
> gp' isn't used to count the grace periods (anymore?). the po<=rcu-link
> allows using both grace periods to create rcu-order between the two read
> side critical sections.
> For the old model I believe it.

Yes, I was talking about the old version of the memory model.

> > If G is a grace period, let's write t1(G) for the time when G starts and
> > t2(G) for the time when G ends.
> > 
> > Likewise, if C is a read-side critical section, let's write t2(C) for
> > the time when C starts (or the lock executes if you prefer) and t1(C)
> > for the time when C ends (or the unlock executes).  This terminology
> > reflects the "backward" role that critical sections play in the memory
> > model.
> > 
> > Now we can can characterize rcu-order and rcu-link in operational terms.
> > Let A and B each be either a grace period or a read-side critical
> > section.  Then:
> > 
> > 	A ->rcu-order B  means  t1(A) < t2(B), and
> > 
> > 	A ->rcu-link B   means  t2(A) <= t1(B).
> 
> 
> That's a really elegant notation! I have thought about rcu-link and
> rcu-order as ordering ends or starts depending on which events are being
> ordered, but it quickly got out of hand because of all the different cases.
> With this notation it becomes quite trivial.
> 
> 
> > (Of course, we always have t1(X) < t2(X) for any grace period or
> > critical section X.)

Actually, it might make more sense to allow t1(C) = t2(C) for a critical 
section C, because critical sections can be empty.  Grace periods, by 
contrast, always have to contain at least a full memory barrier.

> > This explains quite a lot.  For example, we can justify including
> > 
> > 	C ->rcu-link G
> > 
> > into rcu-order as follows.  From C ->rcu-link G we get that t2(C) <=
> > t1(G), in other words, C starts when or before G starts.  Then the
> > Fundamental Law of RCU says that C must end before G ends, since
> > otherwise C would span all of G.  Thus t1(C) < t2(G), which is C
> > ->rcu-order G.
> > 
> > The case of G ->rcu-link C is similar.
> > 
> > This also explains why rcu-link can be extended by appending (rcu-order
> > ; rcu-link)*.
> 
> Indeed, by similar (but more clumsy) reasoning I observed that rcu-order can
> be thought of as "extending" rcu-link.
> 
> >    From X ->rcu-order Y ->rcu-link Z we get that t1(X) <
> > t2(Y) <= t1(Z) and thus t1(X) <= t1(Z).  So if
> > 
> > 	A ->rcu-link B ->(rcu-order ; rcu-link)* C
> > 
> > then t2(A) <= t1(B) <= t1(C), which justifies A ->rcu-link C.
> > 
> > The same sort of argument shows that rcu-order should be extendable by
> > appending (rcu-link ; rcu-order)* -- but not (rcu-order ; rcu-link)*.
> > 
> > This also justifies why a lone gp belongs in rcu-order: G ->rcu-order G
> > holds because t1(G) < t2(G).  But for critical sections we have t2(C) <
> > t1(C) and so C ->rcu-order C does not hold.
> I don't think that it justifies why it belongs there. It justifies that it
> could be included.
> Neither rcu-order nor rcu-link exactly capture the temporal ordering, they
> just imply it.
> For example, if you have L1 U1 and L2 U2 forming two read side critical
> sections C1 and C2, and
>     U1 ->(hb|pb)+ L2
> then I would say you would have
>     t1(C1) < t2(C2)
> but no rcu-order relation between any of the four events.

True, I should have said it suggests a reason for allowing rcu-order to 
contain a lone gp.

> > Assuming ordinary memory accesses occur in a single instant, you see why
> > it makes sense to consider (po ; rcu-order ; po) an ordering.
> 
> Do you mean "execute" in a single instant?

Yes, or to put it another way, t1(X) = t2(X) if X is a load or store.

> > But when you're comparing grace periods or critical sections to each other,
> > things get a little ambiguous.  Should G1 be considered to come before
> > G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?
> > Springing for (po ; rcu-order ; po?) amounts to choosing the second
> > alternative.
> 
> Aha, I see! Powerful notation indeed.
> Keeping that in mind, wouldn't it make sense for pb also be changed to
> `...;po?` ?

You mean changing the definition of pb to either:

	prop ; strong-fence ; hb* ; po? ; [Marked]

or

	prop ; strong-fence ; hb* ; [Marked] ; po? ; [Marked]

?  Neither would be right.  I'm sure you can easily come up with 
examples of cycles in these relations, invalidating the propagation 
axiom acyclic(pb).

rcu-fence is different because rcu-order has to begin and end with 
either a grace period or a critical section, and both of these restrict 
the execution order of surrounding events:

	If X is a synchronize_rcu() or rcu_read_unlock() then events 
	po-before X must execute before X;

	If X is a synchronize_rcu() or rcu_read_lock() then events
	po-after X must execute after X.

The same cannot be said of hb or pb.

Alan
