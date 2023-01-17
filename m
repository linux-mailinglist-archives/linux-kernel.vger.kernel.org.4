Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54251670E97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjARA0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjARAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:25:33 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772851E291
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:46:01 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id k12so1862023qvj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEmtBD+iB+7oyDFdTLtOVBbWtMMsXJE3a/oA0OfwnFM=;
        b=mYqFMeBBD1VGTAumRjy6lukzab30A4z6uxCjQ2NEWfYdKRyfAlmdFCsSIug41mjjrr
         jwp3nVWT0Sy8ppR8884R+RxQo2dQwJ3zUBto1NBCl83YuFBtJ1UQEiWVadNE328hi0fY
         Pw6q3/7Tk0EalCeXWEONHjpl7BuQ0Wtk3cTztJF/C9AoQ7Lxp9M9DnZcZLXqFTvkOmKc
         i5uAAXZtag32+oiVvRdjAkMJpCGGs8Ps1JZUuvzurzp1xZINf3ZJQpbmnboLBPDkUBQo
         3WJpVc2/z35/7aoq3fIYug0KOdXRHzSW4S9ljie11Dvq2OBEqXBsnSwWrCIwK3zchDa/
         E7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEmtBD+iB+7oyDFdTLtOVBbWtMMsXJE3a/oA0OfwnFM=;
        b=wKYSrnwOeAnNv/8NjCoP/1MsgI7R9q39v6dozWaZHcL+KSIigegpLdMlIoaovjpPV4
         aY4uiKtyK51RvhIYdO68a9YYNDhbcwjlZAkVXXY/Xl0mBkp/sydajITtFV8FmTklPIqw
         QXInF4WIs2ods9PQZSKjiL3d49uB0eeUl6VvgG8yutV5QTr7AQZ3NFVri1NGpCGmu2b+
         MoVX6549W4kMmX1fc881uv3jADI1DqPz+nomGXTuKB4LEPLBh96X/Ulw6htZCwZIUZRi
         FcLaLYjV9Bh/NU8iVe2g/HeRq0CnPGwkuxAJ7XIKW8Fli13vLW2WpUgE4Uxww9oIGHfG
         7kLA==
X-Gm-Message-State: AFqh2kof8dfqYHOwnNmdo6LHmjIBV+wHTWM88PrMmlMNqPznjCNmHqti
        ATBYxZsZ3n6KxwZFZzB2C3s=
X-Google-Smtp-Source: AMrXdXv0cCL8F+h0zbipChr1i3b4EAxIbn4XtdWSI2Ju5VlpjRXhuzYB+VZPgVTvOXXNBUirRryyPw==
X-Received: by 2002:a0c:ec43:0:b0:4c6:ed83:9f73 with SMTP id n3-20020a0cec43000000b004c6ed839f73mr6263901qvq.50.1673999160420;
        Tue, 17 Jan 2023 15:46:00 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce76811a07sm21620505qkp.75.2023.01.17.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:45:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1350527C0054;
        Tue, 17 Jan 2023 18:45:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jan 2023 18:45:59 -0500
X-ME-Sender: <xms:NjPHY3ADcgV28orFRXSTdq-E-LRYKcgpyrTyT7v9wZXUpb1kyo4JNA>
    <xme:NjPHY9gy2FMFURN7gTe5c0s4_mmfBCiK8EmoLotR2NiIKUgiDpDt0XsnyAw6pSIsT
    9tTlNpV1K7I41EHgg>
X-ME-Received: <xmr:NjPHYykOPBeyj9CNzfIuJxpyWG1Dea6ForTrSe3npION8oX9Ns5EsBPlOCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NjPHY5xJ-rlc9Qt16MYjQsrGrt2VY3sNB8RS3KZbmPTp3YGH_FxWgA>
    <xmx:NjPHY8RDx20Vb34HthEglQjS_cwtZHs1X1qwSIvFtNhCc40ypXYX4Q>
    <xmx:NjPHY8aOULae-Gqs5STh2HFTnGOE0viWoE1bXTpfaVPejaSzAgp_3w>
    <xmx:NjPHY1BK-Kbk5Y9uCwT8oMXfwYuQXuNYJmVlen2RY7FtiITRFBGKSg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 18:45:57 -0500 (EST)
Date:   Tue, 17 Jan 2023 15:45:39 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8czI5O2CikVlIp8@boqun-archlinux>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence relations, which (as one
> case) provide order when locks are passed between threads followed
> by an smp_mb__after_unlock_lock() fence.  This is illustrated in
> the following litmus test (as can be seen when using herd7 with
> `doshow ppo`):
> 
> P0(int *x, int *y)
> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }
> 
> The ppo relation will link P0's spin_lock(x) and P1's *y=1,
> because P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by eliminating this
> possibility from mb and strong-fence, and instead introduces the
> notion of strong ordering operations, which are allowed to link
> events of distinct threads.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  .../Documentation/explanation.txt             | 101 +++++++++++-------
>  tools/memory-model/linux-kernel.cat           |  20 ++--

I've reviewed the cat change part, and it looks good to me. Now going to
catch up with the interesting discussion on rcu-order...

One more thing, do we want something in the cat file to describe our
"internal axioms" as follow?

	(* Model internal invariants *)
	(* ppo is the subset of po *)
	flag ~empty (ppo \ po) as INTERNAL-ERROR-PPO

Maybe it's helpful for people working on other tools to understand LKMM
cat file?

Anyway, with or without it:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  2 files changed, 76 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index e901b47236c3..4f5f6ac098de 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -865,14 +865,44 @@ propagates stores.  When a fence instruction is executed on CPU C:
>  	propagate to all other CPUs before any instructions po-after
>  	the strong fence are executed on C.
>  
> -The propagation ordering enforced by release fences and strong fences
> -affects stores from other CPUs that propagate to CPU C before the
> -fence is executed, as well as stores that are executed on C before the
> -fence.  We describe this property by saying that release fences and
> -strong fences are A-cumulative.  By contrast, smp_wmb() fences are not
> -A-cumulative; they only affect the propagation of stores that are
> -executed on C before the fence (i.e., those which precede the fence in
> -program order).
> +	Whenever any CPU C' executes an unlock operation U such that
> +	CPU C executes a lock operation L followed by a po-later
> +	smp_mb__after_unlock_lock() fence, and L is either a later lock
> +	operation on the lock released by U or is po-after U, then any
> +	store that propagates to C' before U must propagate to all other
> +	CPUs before any instructions po-after the fence are executed on C.
> +
> +While smp_wmb() and release fences only force certain earlier stores
> +to propagate to another CPU C' before certain later stores propagate
> +to the same CPU C', strong fences and smp_mb__after_unlock_lock()
> +force those stores to propagate to all other CPUs before any later
> +instruction is executed.  We collectively refer to the latter
> +operations as strong ordering operations, as they provide much
> +stronger ordering in two ways:
> +
> +	Firstly, strong ordering operations also create order between
> +	earlier stores and later reads.
> +
> +	Secondly, strong ordering operations create a form of global
> +	ordering: When an earlier store W propagates to CPU C and is
> +	ordered by a strong ordering operation with a store W' of C,
> +	and another CPU C' observes W' and in response issues yet
> +	another store W'', then W'' also can not propagate to any CPU
> +	before W.  By contrast, a release fence or smp_wmb() would only
> +	order W and W', but not force any ordering between W and W''.
> +	To summarize, the ordering forced by strong ordering operations
> +	extends to later stores of all CPUs, while other fences only
> +	force ordering with relation to stores on the CPU that executes
> +	the fence.
> +
> +The propagation ordering enforced by release fences and strong ordering
> +operations affects stores from other CPUs that propagate to CPU C before
> +the fence is executed, as well as stores that are executed on C before
> +the fence.  We describe this property by saying that release fences and
> +strong ordering operations are A-cumulative.  By contrast, smp_wmb()
> +fences are not A-cumulative; they only affect the propagation of stores
> +that are executed on C before the fence (i.e., those which precede the
> +fence in program order).
>  
>  rcu_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
>  other properties which we discuss later.
> @@ -1425,36 +1455,36 @@ requirement is the content of the LKMM's "happens-before" axiom.
>  
>  The LKMM defines yet another relation connected to times of
>  instruction execution, but it is not included in hb.  It relies on the
> -particular properties of strong fences, which we cover in the next
> -section.
> +particular properties of strong ordering operations, which we cover in the
> +next section.
>  
>  
>  THE PROPAGATES-BEFORE RELATION: pb
>  ----------------------------------
>  
>  The propagates-before (pb) relation capitalizes on the special
> -features of strong fences.  It links two events E and F whenever some
> -store is coherence-later than E and propagates to every CPU and to RAM
> -before F executes.  The formal definition requires that E be linked to
> -F via a coe or fre link, an arbitrary number of cumul-fences, an
> -optional rfe link, a strong fence, and an arbitrary number of hb
> -links.  Let's see how this definition works out.
> +features of strong ordering operations.  It links two events E and F
> +whenever some store is coherence-later than E and propagates to every
> +CPU and to RAM before F executes.  The formal definition requires that
> +E be linked to F via a coe or fre link, an arbitrary number of
> +cumul-fences, an optional rfe link, a strong ordering operation, and an
> +arbitrary number of hb links.  Let's see how this definition works out.
>  
>  Consider first the case where E is a store (implying that the sequence
>  of links begins with coe).  Then there are events W, X, Y, and Z such
>  that:
>  
> -	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F,
> +	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-order Z ->hb* F,
>  
>  where the * suffix indicates an arbitrary number of links of the
>  specified type, and the ? suffix indicates the link is optional (Y may
>  be equal to X).  Because of the cumul-fence links, we know that W will
>  propagate to Y's CPU before X does, hence before Y executes and hence
> -before the strong fence executes.  Because this fence is strong, we
> -know that W will propagate to every CPU and to RAM before Z executes.
> -And because of the hb links, we know that Z will execute before F.
> -Thus W, which comes later than E in the coherence order, will
> -propagate to every CPU and to RAM before F executes.
> +before the strong ordering operation executes.  Because of the strong
> +ordering, we know that W will propagate to every CPU and to RAM before
> +Z executes.  And because of the hb links, we know that Z will execute
> +before F.  Thus W, which comes later than E in the coherence order,
> +will propagate to every CPU and to RAM before F executes.
>  
>  The case where E is a load is exactly the same, except that the first
>  link in the sequence is fre instead of coe.
> @@ -1637,8 +1667,8 @@ does not imply X ->rcu-order V, because the sequence contains only
>  one rcu-gp link but two rcu-rscsi links.
>  
>  The rcu-order relation is important because the Grace Period Guarantee
> -means that rcu-order links act kind of like strong fences.  In
> -particular, E ->rcu-order F implies not only that E begins before F
> +means that rcu-order links act kind of like a strong ordering operation.
> +In particular, E ->rcu-order F implies not only that E begins before F
>  ends, but also that any write po-before E will propagate to every CPU
>  before any instruction po-after F can execute.  (However, it does not
>  imply that E must execute before F; in fact, each synchronize_rcu()
> @@ -1675,24 +1705,23 @@ The rcu-fence relation is a simple extension of rcu-order.  While
>  rcu-order only links certain fence events (calls to synchronize_rcu(),
>  rcu_read_lock(), or rcu_read_unlock()), rcu-fence links any events
>  that are separated by an rcu-order link.  This is analogous to the way
> -the strong-fence relation links events that are separated by an
> +the strong-order relation links events that are separated by an
>  smp_mb() fence event (as mentioned above, rcu-order links act kind of
> -like strong fences).  Written symbolically, X ->rcu-fence Y means
> -there are fence events E and F such that:
> +like strong ordering operations).  Written symbolically, X ->rcu-fence Y
> +means there are fence events E and F such that:
>  
>  	X ->po E ->rcu-order F ->po Y.
>  
>  From the discussion above, we see this implies not only that X
>  executes before Y, but also (if X is a store) that X propagates to
> -every CPU before Y executes.  Thus rcu-fence is sort of a
> -"super-strong" fence: Unlike the original strong fences (smp_mb() and
> +every CPU before Y executes.  Thus unlike strong fences (smp_mb() and
>  synchronize_rcu()), rcu-fence is able to link events on different
>  CPUs.  (Perhaps this fact should lead us to say that rcu-fence isn't
>  really a fence at all!)
>  
>  Finally, the LKMM defines the RCU-before (rb) relation in terms of
>  rcu-fence.  This is done in essentially the same way as the pb
> -relation was defined in terms of strong-fence.  We will omit the
> +relation was defined in terms of strong-order.  We will omit the
>  details; the end result is that E ->rb F implies E must execute
>  before F, just as E ->pb F does (and for much the same reasons).
>  
> @@ -2134,7 +2163,7 @@ intermediate event Z such that:
>  
>  and either:
>  
> -	Z is connected to Y by a strong-fence link followed by a
> +	Z is connected to Y by a strong-order link followed by a
>  	possibly empty sequence of xb links,
>  
>  or:
> @@ -2153,10 +2182,10 @@ The motivations behind this definition are straightforward:
>  	from W, which certainly means that W must have propagated to
>  	R's CPU before R executed.
>  
> -	strong-fence memory barriers force stores that are po-before
> -	the barrier, or that propagate to the barrier's CPU before the
> -	barrier executes, to propagate to all CPUs before any events
> -	po-after the barrier can execute.
> +	Strong ordering operations force stores that are po-before
> +	the operation or that propagate to the CPU that begins the
> +	operation before the operation executes, to propagate to all
> +	CPUs before any events po-after the operation execute.
>  
>  To see how this works out in practice, consider our old friend, the MP
>  pattern (with fences and statement labels, but without the conditional
> @@ -2485,7 +2514,7 @@ sequence or if W can be linked to R by a
>  sequence.  For the cases involving a vis link, the LKMM also accepts
>  sequences in which W is linked to W' or R by a
>  
> -	strong-fence ; xb* ; {w and/or r}-pre-bounded
> +	strong-order ; xb* ; {w and/or r}-pre-bounded
>  
>  sequence with no post-bounding, and in every case the LKMM also allows
>  the link simply to be a fence with no bounding at all.  If no sequence
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 07f884f9b2bf..1d91edbc10fe 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> -		fencerel(After-unlock-lock) ; [M])
> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>  let strong-fence = mb | gp
>  
> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>  (* Write and fence propagation ordering *)
>  (****************************************)
>  
> -(* Propagation: Each non-rf link needs a strong fence. *)
> -let pb = prop ; strong-fence ; hb* ; [Marked]
> +(* Strong ordering operations *)
> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
> +		[After-unlock-lock] ; po ; [M])
> +
> +(* Propagation: Each non-rf link needs a strong ordering operation. *)
> +let pb = prop ; strong-order ; hb* ; [Marked]
>  acyclic pb as propagation
>  
>  (*******)
> @@ -141,7 +143,7 @@ let rec rcu-order = rcu-gp | srcu-gp |
>  	(rcu-order ; rcu-link ; rcu-order)
>  let rcu-fence = po ; rcu-order ; po?
>  let fence = fence | rcu-fence
> -let strong-fence = strong-fence | rcu-fence
> +let strong-order = strong-order | rcu-fence
>  
>  (* rb orders instructions just as pb does *)
>  let rb = prop ; rcu-fence ; hb* ; pb* ; [Marked]
> @@ -169,7 +171,7 @@ flag ~empty mixed-accesses as mixed-accesses
>  (* Executes-before and visibility *)
>  let xbstar = (hb | pb | rb)*
>  let vis = cumul-fence* ; rfe? ; [Marked] ;
> -	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
> +	((strong-order ; [Marked] ; xbstar) | (xbstar & int))
>  
>  (* Boundaries for lifetimes of plain accesses *)
>  let w-pre-bounded = [Marked] ; (addr | fence)?
> @@ -180,9 +182,9 @@ let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
>  	[Marked]
>  
>  (* Visibility and executes-before for plain accesses *)
> -let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
> +let ww-vis = fence | (strong-order ; xbstar ; w-pre-bounded) |
>  	(w-post-bounded ; vis ; w-pre-bounded)
> -let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
> +let wr-vis = fence | (strong-order ; xbstar ; r-pre-bounded) |
>  	(w-post-bounded ; vis ; r-pre-bounded)
>  let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)
>  
> -- 
> 2.17.1
> 
