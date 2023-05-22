Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1A70CA82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjEVUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjEVUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:13:23 -0400
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [IPv6:2001:41d0:203:375::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0EB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:13:20 -0700 (PDT)
Date:   Mon, 22 May 2023 16:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684786399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLkEu2YRVIsJRUJTOl9DKppQXvRE/KxZmCxT56Vvw1Q=;
        b=Hzyd7PEaBiENg/q15S468+yLmCD91luoPUU42U1NKHcKF4NQcmDHzxqFc/H2Go/VdGEVyj
        ywdQ+FOubtAFjSPwcGTlObGjHEODeej2yYjoqLDeps8ITPebXaJ4ueM0iaFOREqPept3aa
        8OUqR6epbOjjoOxj8aCEUmp7G8P3yWM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZGvM2nqmft0IbB2U@moria.home.lan>
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
 <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:58:33AM -0700, Linus Torvalds wrote:
> On Mon, May 22, 2023 at 10:13 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> 
> > +static inline unsigned u32_mask_to_ulong_bitnr(u32 mask)
> > +{
> > +       union ulong_u32 {
> > +               u32     v32;
> > +               ulong   vlong;
> > +       } v = { .v32 = mask };
> > +
> > +       return ilog2(v.vlong);
> 
> No, this is still wrong.
> 
> The above is actively undefined - the high bits of 'vlong' can contain
> random garbage. And you can't even fix it anyway, because even if you
> add a second 32-bit word and zero it, on big-endian architectures
> you'll get a result that is bigger than 32, and then when you do
> this:L

Uh, I think you're wrong on this one - structs with designated
initializers have unspecified fields initialized to 0, and I would
expect the same to hold for unions, and the language in the C standard
isn't completely explicit but it appears to apply to both.

And checking the generated assembly for a six_set_nospin() that calls a
six_set_bitmask() with the test_bit() taken out, for simplicity

00000000000002c0 <six_set_nospin>:
 2c0:	e8 00 00 00 00       	call   2c5 <six_set_nospin+0x5>
 2c5:	55                   	push   %rbp
 2c6:	48 89 e5             	mov    %rsp,%rbp
 2c9:	f0 80 4f 03 80       	lock orb $0x80,0x3(%rdi)
 2ce:	5d                   	pop    %rbp
 2cf:	c3                   	ret

meaning the compiler properly constant-propagated and didn't read
uninitialized memory. And I did the same test in userspace too, in the
unlikely event -ftrivial-auto-var-init=zero was affecting things.

> > +static inline void six_set_bitmask(struct six_lock *lock, u32 mask)
> > +{
> > +       unsigned bitnr = u32_mask_to_ulong_bitnr(mask);
> > +
> > +       if (!test_bit(bitnr, (unsigned long *) &lock->state))
> > +               set_bit(bitnr, (unsigned long *) &lock->state);
> 
> you're back to basically just undefined behaviour.
> 
> You *cannot* do "set_bit()" on a u32. It's that simple. Stop trying to
> do it with these wrappers that happen to work on x86 but are
> fundamentally broken.

Because of aliasing issues? I thought it had been declared that the
kernel would never do strict aliasing.

> We don't do locking by playing games like this. It's wrong.
> 
> You clearly don't even want the return value, so you're actually much
> better off just using an atomic_t and "atomic_or()", I suspect.
> 
> But these broken games with casting pointers to invalid types MUST END.

...but, atomic_or() is clearly the right way to do this :)
