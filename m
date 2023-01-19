Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D7673F19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjASQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjASQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:41:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6760378A93
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:41:02 -0800 (PST)
Received: (qmail 254430 invoked by uid 1000); 19 Jan 2023 11:41:01 -0500
Date:   Thu, 19 Jan 2023 11:41:01 -0500
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
Message-ID: <Y8lynRI35cFeuqb5@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8iqzJXVZX1lS7Kp@rowland.harvard.edu>
 <a2b89243-ddd7-c114-541f-0aff7806d217@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2b89243-ddd7-c114-541f-0aff7806d217@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:22:50PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 3:28 AM, Alan Stern wrote:
> > > This is a permanent error; I've given up. Sorry it didn't
> > work out.
> 
> [It seems the e-mail still reached me through the mailing list]

[For everyone else, Jonas is referring to the fact that the last two 
emails I sent to his huaweicloud.com address could not be delivered, so 
I copied them off-list to his huawei.com address.]

> > > I consider that a hack though and don't like it.
> > It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
> > is a lot like a load, in that it returns a value obtained by reading
> > something from memory (along with some other operations, though, so it
> > isn't a simple straightforward read -- perhaps more like an
> > atomic_inc_return_relaxed).
> The issue I have with this is that it might create accidental ordering. How
> does it behave when you throw fences in the mix?

I think this isn't going to be a problem.  Certainly any real 
implementation of scru_read_lock() is going to involve some actual load 
operations, so any unintentional ordering caused by fences will also 
apply to real executions.  Likewise for srcu_read_unlock and store 
operations.

> It really does not work like an increment at all, I think srcu_read_lock()
> only reads the currently active index, but the index is changed by
> srcu_sync. But even that is an implementation detail of sorts. I think the
> best way to think of it would be for srcu_read_lock to just return an
> arbitrary value.

I think I'll stick to it always returning the initial value.  Paul said 
that would be okay.

> The user can not rely on any kind of "accidental" rfe edges between these
> events for ordering.
> 
> Perhaps if you flag any use of these values in address or control
> dependencies, as well as any event which depends on more than one of these
> values, you could prove that it's impossible to contrain the behavior
> through these rfe(and/or co) edges because you can anyways never inspect the
> value returned by the operation (except to pass it into srcu_unlock).
> 
> Or you might be able to explicitly eliminate the events everywhere, just
> like you have done for carry-dep in your patch.

On second thought, I'll make it impossible to read from the 
srcu_read_unlock events by removing them from the rf (and rfi/rfe) 
relation.  Then it won't be necessary to change carry-dep or anything 
else.

> But it looks so brittle.

Maybe not so much after this change?

> > srcu_read_unlock() is somewhat less like a store, but it does have one
> > notable similarity: It takes an input value and therefore can be the
> > target of a data dependency.  The biggest difference is that an
> > srcu_read_unlock() can't really be read-from.  It would be nice if herd
> > had an event type that behaved this way.
> Or if you could declare your own : )
> Obviously, you will have accidental rf edges going from srcu_read_unlock()
> to srcu_read_lock() if you model them this way.

Not when those edges are erased.

> > Also, herd doesn't have any way of saying that the value passed to a
> > store is an unmodified copy of the value obtained by a load.  In our
> > case that doesn't matter much -- nobody should be writing litmus tests
> > in which the value returned by srcu_read_lock() is incremented and then
> > decremented again before being passed to srcu_write_lock()!
> 
> It would be nice if herd allowed declaring structs that can be used for such
> purposes.
> (anyways, I am not sure if Luc is still following everything in this deeply
> nested thread that started somewhere completely different. But maybe if Paul
> or you open a feature request, let me know so that I can give my 2ct)

I thought you were against adding into herd features that were specific 
to the Linux kernel?

> > > Note that if your ordering relies on actually using gp twice in a row, then
> > > these must come from strong-fence, but you should be able to just take the
> > > shortcut by merging them into a single gp.
> > >    po;rcu-gp;po;rcu-gp;po <= gp <= strong-fence <= hb & strong-order
> > I don't know what you mean by this.  The example above does rely on
> > having two synchronize_rcu() calls; with only one it would be allowed.
> 
> I mean that if you have a cycle that is formed by having two adjacent actual
> `gp` edges, like .... ; gp;gp ; ....  with gp= po ; rcu-gp ; po?,
> (not like your example, where the cycle uses two *rcu*-gp but no gp edges)

Don't forget that I had in mind a version of the model where rcu-gp did 
not exist.

> and assume we define gp' = po ; rcu-gp ; po and hb' and pb' to use gp'
> instead of gp,
> then there are two cases for how that cycle came to be, either 1) as
>  ... ; hb;hb ; ....
> but then you can refactor as
>  ... ; po;rcu-gp;po;rcu-gp;po ; ...
>  ... ; po;rcu-gp;     po      ; ...
>  ... ;         gp'            ; ...
>  ... ;         hb'            ; ...
> which again creates a cycle, or 2) as
>   ... ; pb ; hb ; ...
> coming from
>   ... ; prop ; gp ; gp ; ....
> which you can similarly refactor as
>   ... ; prop ; po;rcu-gp;po ; ....
>   ... ; prop ;      gp'     ; ....
> and again get a cycle with
> ... ; pb' ; ....
> Therefore, gp = po;rcu-gp;po should be equivalent.

The point is that in P1, we have Write ->(gp;gp) Read, but we do not 
have Write ->(gp';gp') Read.  Only Write ->gp' Read.  So if you're using 
gp' instead of gp, you'll analyze the litmus test as if it had only one 
grace period but two critical sections, getting a wrong answer.


Here's a totally different way of thinking about these things, which may 
prove enlightening.  These thoughts originally occurred to me years ago, 
and I had forgotten about them until last night.

If G is a grace period, let's write t1(G) for the time when G starts and 
t2(G) for the time when G ends.

Likewise, if C is a read-side critical section, let's write t2(C) for 
the time when C starts (or the lock executes if you prefer) and t1(C) 
for the time when C ends (or the unlock executes).  This terminology 
reflects the "backward" role that critical sections play in the memory 
model.

Now we can can characterize rcu-order and rcu-link in operational terms.
Let A and B each be either a grace period or a read-side critical 
section.  Then:

	A ->rcu-order B  means  t1(A) < t2(B), and

	A ->rcu-link B   means  t2(A) <= t1(B).

(Of course, we always have t1(X) < t2(X) for any grace period or 
critical section X.)

This explains quite a lot.  For example, we can justify including

	C ->rcu-link G

into rcu-order as follows.  From C ->rcu-link G we get that t2(C) <= 
t1(G), in other words, C starts when or before G starts.  Then the 
Fundamental Law of RCU says that C must end before G ends, since 
otherwise C would span all of G.  Thus t1(C) < t2(G), which is C 
->rcu-order G.

The case of G ->rcu-link C is similar.

This also explains why rcu-link can be extended by appending (rcu-order 
; rcu-link)*.  From X ->rcu-order Y ->rcu-link Z we get that t1(X) < 
t2(Y) <= t1(Z) and thus t1(X) <= t1(Z).  So if

	A ->rcu-link B ->(rcu-order ; rcu-link)* C

then t2(A) <= t1(B) <= t1(C), which justifies A ->rcu-link C.

The same sort of argument shows that rcu-order should be extendable by 
appending (rcu-link ; rcu-order)* -- but not (rcu-order ; rcu-link)*.

This also justifies why a lone gp belongs in rcu-order: G ->rcu-order G 
holds because t1(G) < t2(G).  But for critical sections we have t2(C) < 
t1(C) and so C ->rcu-order C does not hold.

Assuming ordinary memory accesses occur in a single instant, you see why 
it makes sense to consider (po ; rcu-order ; po) an ordering.  But when 
you're comparing grace periods or critical sections to each other, 
things get a little ambiguous.  Should G1 be considered to come before 
G2 when t1(G1) < t1(G2), when t2(G1) < t2(G2), or when t2(G1) < t1(G2)?  
Springing for (po ; rcu-order ; po?) amounts to choosing the second 
alternative.

Alan
