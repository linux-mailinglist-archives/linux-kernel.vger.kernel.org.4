Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25D63F4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiLAQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLAQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:02:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8053AB43D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:02:20 -0800 (PST)
Received: (qmail 491949 invoked by uid 1000); 1 Dec 2022 11:02:19 -0500
Date:   Thu, 1 Dec 2022 11:02:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Subject: Re: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general this seems like a good idea.  I haven't been able to think up 
any situations where adding these new dependencies would give a wrong 
answer (except for cases where the dependencies end up being 
non-semantic, which can already happen for the regular dependencies we 
currently have).

I just have a few stylistic comments...

On Thu, Dec 01, 2022 at 01:18:08PM +0100, Jonas Oberhauser wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> 
> As reported by Viktor, plain accesses in LKMM are weaker than
> accesses to registers: the latter carry dependencies but the former
> do not. This is exemplified in the following snippet:
> 
>   int r = READ_ONCE(*x);
>   WRITE_ONCE(*y, r);
> 
> Here a data dependency links the READ_ONCE() to the WRITE_ONCE(),
> preserving their order, because the model treats r as a register.
> If r is turned into a memory location accessed by plain accesses,
> however, the link is broken and the order between READ_ONCE() and
> WRITE_ONCE() is no longer preserved.
> 
> This is too conservative, since any optimizations on plain
> accesses that might break dependencies are also possible on
> registers; it also contradicts the intuitive notion of "dependency"
> as the data stored by the WRITE_ONCE() does depend on the data read
> by the READ_ONCE(), independently of whether r is a register or a
> memory location.
> 
> This is resolved by redefining all dependencies to include
> dependencies carried by memory accesses; a dependency is said to be
> carried by memory accesses (in the model: carry-dep) from one load
> to another load if the initial load is followed by an arbitrarily
> long sequence alternating between stores and loads of the same
> thread, where the data of each store depends on the previous load,
> and is read by the next load.
> 
> Any dependency linking the final load in the sequence to another
> access also links the initial load in the sequence to that access.
> 
> Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> ---
>  .../Documentation/explanation.txt             |  9 ++++-
>  tools/memory-model/linux-kernel.bell          |  7 ++++
>  .../litmus-tests/dep+plain.litmus             | 34 +++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..41f75dff0791 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -2544,7 +2544,7 @@ smp_store_release() -- which is basically how the Linux kernel treats
>  them.
>  
>  Although we said that plain accesses are not linked by the ppo
> -relation, they do contribute to it indirectly.  Namely, when there is
> +relation, they do contribute to it indirectly.  Firstly, when there is
>  an address dependency from a marked load R to a plain store W,
>  followed by smp_wmb() and then a marked store W', the LKMM creates a
>  ppo link from R to W'.  The reasoning behind this is perhaps a little
> @@ -2553,6 +2553,13 @@ for this source code in which W' could execute before R.  Just as with
>  pre-bounding by address dependencies, it is possible for the compiler
>  to undermine this relation if sufficient care is not taken.
>  
> +Secondly, plain accesses can carry dependencies: if a data dependency

When a colon is followed by a clause (as opposed to a list), it is 
customary to capitalize the first letter of that clause, just like we 
capitalize the first letter at the start of a sentence.

> +links a marked load R to a store W, and the store is read by a load R'
> +from the same thread, then the data loaded by R' depends on the data
> +loaded originally by R; thus if R' is linked to any access X by a

This is a run-on sentence.  Change the semicolon to a period and start a 
new sentence there.

> +dependency, R is also linked to access X by the same dependency,
> +in particular even if any of W' or R' are plain.

IMO the "in particular" isn't needed.  I'd change this to:

	even if W' or R' (or both!) is plain.

which seems a bit punchier.

> +
>  There are a few oddball fences which need special treatment:
>  smp_mb__before_atomic(), smp_mb__after_atomic(), and
>  smp_mb__after_spinlock().  The LKMM uses fence events with special
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 5be86b1025e8..f8ec21dd6b7b 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -82,3 +82,10 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
>  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>  		LKR | LKW | UL | LF | RL | RU
>  let Plain = M \ Marked
> +
> +(* Redefine dependencies to include dependencies carried
> + * through unmarked accesses *)

The style used in these files for multi-line comments is:

(*
 * blah blah blah
 * blah blah blah
 *)

On the other hand, if you change the second "dependencies" to "ones" and 
"unmarked" to "plain", maybe the whole thing will fit on one line.

> +let carry-dep = (data ; rfi)*
> +let addr = carry-dep ; addr
> +let ctrl = carry-dep ; ctrl
> +let data = carry-dep ; data
> diff --git a/tools/memory-model/litmus-tests/dep+plain.litmus b/tools/memory-model/litmus-tests/dep+plain.litmus
> new file mode 100644
> index 000000000000..c4f974b935c5
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/dep+plain.litmus
> @@ -0,0 +1,34 @@
> +C dep+plain
> +
> +(*
> + * Result: Never
> + *
> + * This litmus test demonstrates that in LKMM, plain accesses
> + * carry dependencies much like accesses to registers:

See the earlier recommendation about colons followed by clauses.

> + * the data stored to *z1 and *z2 by P0() originates from P0()'s
> + * READ_ONCE(), and therefore using that data to compute the
> + * conditional of P0()'s if-statement creates a control dependency
> + * from that READ_ONCE() to P0()'s WRITE_ONCE() which is inside
> + * the if-statement.

We don't need to tell the reader that P0's WRITE_ONCE is inside the "if" 
statement; it's pretty obvious.

> + *

Unnecessary blank line.

> + *)
> +
> +{}
> +
> +P0(int *x, int *y, int *z1, int *z2)
> +{
> +	int a = READ_ONCE(*x);
> +	*z1 = a;
> +	*z2 = *z1;
> +	if (*z2 == 1){
> +		WRITE_ONCE(*y, 1);
> +	}

Kernel programming style says that these {}'s should be omitted.

However, if you replaced the whole conditional with a simple

	WRITE_ONCE(*y, *z2);

then the litmus test would become an example of OOTA!

> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r = smp_load_acquire(y);
> +	smp_store_release(x, r);
> +}
> +
> +exists (x=1 /\ y=1)
> -- 
> 2.17.1

Alan
