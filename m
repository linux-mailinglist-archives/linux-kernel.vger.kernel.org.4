Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3764BE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiLMVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:02:49 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2F6258
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qJukAe0ZhMLhBRoM2r/uNvI61JciOoth8w9NcwQw5lg=; b=h+p3gaZza13Yh6svZF4sTtW4yL
        PGLxrPd284B7xaY78dMRoofCNOOgXo9BQqDHCETegDlHkbgPHCpkJD0QnjYjqWQrd1p2ecrDcTmAo
        /2i4BFyjE76v4eI/IPbKo6L2g9ZXeBcaMbMMfocxp3UKOGmXvhcoDCcaJYJr2zETl2EuE9H2YU+Jo
        KE9ugcYaaRoNEc1bLCurv/RreNkZUXiX6qeepbpUYe7iDQa5yBmGUcDRKGWbp0j5Pcx5Bh3vx3pzZ
        BmkpMocWDGj57Fy7d5S/XM8cdSzTQAK6u4yKiPd5t23ad/ahF+ja0wN9CXaImqZk3NCQlBQgRXRy8
        zRQd0ToQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p5CQC-00Bg76-2Y;
        Tue, 13 Dec 2022 21:02:40 +0000
Date:   Tue, 13 Dec 2022 21:02:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 2/3] fs/ufs: Change the signature of ufs_get_page()
Message-ID: <Y5jocC08THah/nHz@ZenIV>
References: <Y5glgpD7fFifC4Fi@ZenIV>
 <3174926.0WQXIW03uk@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174926.0WQXIW03uk@suse>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:08:22PM +0100, Fabio M. De Francesco wrote:

> But I can't yet understand why that pointer was returned unconditionally in 
> the code which I'm changing with this patch (i.e., regardless of any potential  
> errors from read_mapping_page()) :-/ 

Because on error from read_mapping_page() you get page or ERR_PTR(-E...),
which is what you want the sucker to return on error.

Here you want to return page_address(page) on success or ERR_PTR(-E...) on
error.

For original calling conventions return page; worked both on success and
on error.  With the new ones it's no longer true - giving page_address() an
error value (address in range (unsigned long)(-4095) to (unsigned long)(-1))
is *not* going to return the same error value.

It's even more obvious with your third patch - on read_mapping_page() failure
you want to return the same bit pattern it gave you, on its success you want
to pass the pointer it gave you to kmap_local_page() and return the address
you get from kmap_local_page(), right?  Check what your patch ends up doing -
you store result of kmap_local_page() in kaddr, then return it.  Including
the case when you have *not* called kmap_local_page() at all...

Again, warnings are occasionally useful...

Brain dump on ERR_PTR() and related things: kernel makes sure that the top 4K
of possible addresses are never used for objects of any type (that's
0xfffff000--0xffffffff on 32bit, 0xfffffffffffff000--0xffffffffffffffff
on 64bit).  That gives us 4095 values that are never going to clash with
any valid pointer values.  One way of thinking about those is "split NULL" -
instead of one value that is guaranteed to be distinct from address of
any object we have a small bunch of those and we can use the _choice_ of
such value to carry information.  Similar to how NaN are used for real
numbers, actually.

If function returns a pointer on success and errno value on failure,
it can be declared to return a pointer type, using ERR_PTR(-22) to represent
"error #22", etc.  These values can be easily recognized; IS_ERR(p) is
true for those and only for those.  PTR_ERR() converts those to numbers -
PTR_ERR(ERR_PTR(-22)) is -22, etc.

On non-error values PTR_ERR() yields garbage; it won't break (or do any
calculations, actually - just cast to signed long), but the value is
going to be useless for anything.

IS_ERR() is annotated so that compiler knows that it's unlikely to be
true; i.e. if (IS_ERR(...)) {do something} won't have the body cluttering
the hot path.

You can compare them for (in)equality just fine -
	if (p == ERR_PTR(-ENOMEM))
is fine; no need to bother with the things like
	if (PTR_ERR(p) == -ENOMEM)

You obviously can't dereference them and (slightly less obviously) can't do
ordered comparisons.  You definitely can't do pointer arithmetics on those.

These values are used with all pointer types; something like
struct foo *f()
{
	struct foo *p;
	char *s;

	p = kmalloc(sizeof(struct foo), GFP_KERNEL);
	if (!p)
		return ERR_PTR(-ENOMEM);
	s = bar();
	// if bar() has failed, return the error it gave you
	if (IS_ERR(s)) {
		kfree(p);
		return (void *)s;	// UNIDIOMATIC
	}
	....
	return p;
}

is valid, but it's better spelled as ERR_CAST(s) instead of (void *)s.

Note that these values can also be used as arguments - it's less common
that use as return values, but there are situations when it makes sense.
Not the case here, though...

See include/linux/err.h; one warning - use of IS_ERR_OR_NULL() is very
often a mistake.  Mixing NULL and ERR_PTR() in calling conventions is
a good way to end up with massive confusion down the road; sometimes
it's warranted, but such cases are rare and generally you want to ask
yourself "do I really want to go there?"


> P.S.: While at this patch I'd like to gently ping you about another conversion 
> that I sent (and resent) months ago:
> 
> [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page() at:
> https://lore.kernel.org/lkml/20221016150656.5803-1-fmdefrancesco@gmail.com/
> 
> This patch to fs/aio.c has already received two "Reviewed-by" tags: the first 
> from Ira Weiny and the second from Jeff Moyer (you won't see the second there, 
> because I forgot to forward it when I sent again :-( ).
> 
> The tag from Jeff is in the following message (from another [RESEND PATCH] 
> thread):
> https://lore.kernel.org/lkml/x49h6zzvn1a.fsf@segfault.boston.devel.redhat.com/
> 
> In that same thread, I explained better I meant in the last sentence of the 
> commit message, because Jeff commented that it is ambiguous (I'm adding him in 
> the Cc list of recipients).
> 
> The original patch, submitted on Thu, 7 Jul 2022 01:33:28 +0200 is at:
> https://lore.kernel.org/lkml/20220706233328.18582-1-fmdefrancesco@gmail.com/
> 
> I'd appreciate very much if you can spend some time on that patch too :)

Will check...
