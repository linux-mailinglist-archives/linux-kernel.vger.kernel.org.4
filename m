Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3F6935EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 05:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBLEHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 23:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBLEHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 23:07:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A89757
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 20:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jzp5Gfw3Znt+vCFjS3OKhPej988pLhpWvnD0qzs7wg8=; b=idg3rNsrQpcUl7QxDY5HlFz0Qi
        EFAGbu7eE2ZZ/KZsNjGRqd0egiWALFm+el7PBRKM63JVFHnCBCljLEzLynrU6cnWmtVx4ocY2fIyd
        Y2a0MiU3eUFvVlhDeV2/+UfvLRvF1xx5zZ7iFl4l7wgJSjQxdnzBnZpuSgfDZL5NMNaxyedo3L4kN
        bOzDFW1N8UFU6rC/t+PxlJOduJmoeHWaFAs19MlJwldVxZ2YL+weAyq8e15PUybgEV3qrVr9HG/gn
        EOxL7JhiskNBkw6E0d6AriyWp0mtbVuvZoJl2dX/CaBbXKPEZ7eJ00scIU9wv4IFkn/qD7ONx0khY
        ZajfeDNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pR3dn-004bVU-Vz; Sun, 12 Feb 2023 04:07:04 +0000
Date:   Sun, 12 Feb 2023 04:07:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Vlastimil Babka <vbabka@suse.cz>,
        David Chen <david.chen@nutanix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2023-02-11]
Message-ID: <Y+hl552juPj8BNux@casper.infradead.org>
References: <167613641114.2124708.9785978428796571420@leemhuis.info>
 <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
 <CAHk-=whncfNmZmWe4yh-M=DXYT6L6Eq1r=UYKdt57=4jUmKbTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whncfNmZmWe4yh-M=DXYT6L6Eq1r=UYKdt57=4jUmKbTA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 02:31:53PM -0800, Linus Torvalds wrote:
> On Sat, Feb 11, 2023 at 1:39 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Or even just reverting the original commit e320d3012d25
> > ("mm/page_alloc.c: fix freeing non-compound pages") and say that the
> > (very rare) memory leak is much less dangerous than that hacky fix
> > (that was buggy).
> >
> > Because it's a bit dodgy how commit e320d3012d25 ends up hooking into
> > __free_pages(),
> 
> Actually, that's not the only dodgy thing about it.
> 
> It assumes that any multi-order page allocator user doesn't use the
> page counts and only ever has a single "alloc" and a "free".
> 
> And apparently that assumption is correct, or we'd have seen a lot of problems.
> 
> But it *also* assumes that the speculative page alloc/free was for one
> single page, and while that used to be true, the whole higher-order
> folio code means that it's not necessarily true any more.
> 
> Or rather, I guess it *is* true in practice, but if you ever want to
> enable 16kB folios on some filesystem, that commit e320d3012d25 is
> just plain unfixably buggy.
> 
> Are we there yet? Clearly not, considering bugs like this. But it all
> does make me go "Hmm, maybe we'd be better off with the outright
> revert and accept the unlikely memory leak for now".
> 
> Willy?

OK, you've somehow got hold of the wrong end of this problem and that's
why you think it's larger than it is.

Compound pages are not the problem.  They carry their size with them, and
when the refcount drops to zero, we free the whole allocation as one unit.

The problem is high-order allocations that don't set __GFP_COMP.
They don't record the size of the allocation.  And so we had this problem
where if there's a speculative refcount on the first page while the owner
calls __free_pages(), the tail pages weren't freed.  And the first page
isn't a head page, it looks like an order-0 page, so when the speculative
owner calls put_page(), we still don't free the tail page.

Somewhat complicating this is that some places which allocate a
compound page free it by calling __free_pages().  It's not wrong,
but we can't free the tail pages at this time because they'll be
freed by put_page().  So that's why we're testing PageHead() --
it's "Is this a compound page".

What I was vaguely afraid of was that some code would do something like:

p = alloc_pages(gfp, 2);
get_page(p);
__free_pages(p, 2);
... do something with p[1] ...
__free_pages(p, 2);

but it seems like nobody does that, or we'd've seen complaints by now.

If we could get rid of all non-compound allocations, I'd be happy, but I
haven't even looked to see how hard that would be.  Slab, page cache and
anon memory all use compound pages, including hugetlb.  I think crypto
is the main remaining user of non-compound high-order allocations.
