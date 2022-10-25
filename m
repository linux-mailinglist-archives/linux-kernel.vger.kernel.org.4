Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC14E60C233
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiJYDVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJYDVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:21:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77BC48A16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2YhJiurh3yeqLAY7/HFpg3fq1seSTJqbsUcJnHEJrjo=; b=FAxLsAyIHFrQpx9r+joBCrVs5x
        CNiXnOy8QwPnLgfHFTn7fUAU/HuLeneBCnASS0XmIpblKGn9GFaViAhQf98i95OtmscUry5Ugi168
        hJku8DlWqsby24PS/6iYJSsU+E1lvtnVhilzbDXpmW6ZhbfUf2t9V35r1nvc5zxXzxwQyQucVfq5V
        BXKo4JXccKH4MQ9jWphalnX7IVHdwH2QnVyZa4EslliANXYAQknYyvEpNu3Jiq1H56/zDSf6y1Kdl
        f0Pd0VvvvClevk+knHycWRlUbdvSZBuQxCKil6J5qtEKRrWVRpCS291PXzgSBQT/aT2tC9LfFuy7C
        OVMHO4JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onAVX-00Fxrc-9n; Tue, 25 Oct 2022 03:21:39 +0000
Date:   Tue, 25 Oct 2022 04:21:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1dWQ+YQyiz3V9Sp@casper.infradead.org>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
 <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:23:51PM +0200, Jann Horn wrote:
> """
> This guarantees that the page tables that are being walked
> aren't freed concurrently, but at the end of the walk, we
> have to grab a stable reference to the referenced page.
> For this we use the grab-reference-and-revalidate trick
> from above again:
> First we (locklessly) load the page
> table entry, then we grab a reference to the page that it
> points to (which can fail if the refcount is zero, in that
> case we bail), then we recheck that the page table entry
> is still the same, and if it changed in between, we drop the
> page reference and bail.
> This can, again, grab a reference to a page after it has
> already been freed and reallocated. The reason why this is
> fine is that the metadata structure that holds this refcount,
> `struct folio` (or `struct page`, depending on which kernel
> version you're looking at; in current kernels it's `folio`
> but `struct page` and `struct folio` are actually aliases for
> the same memory, basically, though that is supposed to maybe
> change at some point) is never freed; even when a page is
> freed and reallocated, the corresponding `struct folio`
> stays. This does have the fun consequence that whenever a
> page/folio has a non-zero refcount, the refcount can
> spuriously go up and then back down for a little bit.
> (Also it's technically not as simple as I just described it,
> because the `struct page` that the PTE points to might be
> a "tail page" of a `struct folio`.
> So actually we first read the PTE, the PTE gives us the
> `page*`, then from that we go to the `folio*`, then we
> try to grab a reference to the `folio`, then if that worked
> we check that the `page` still points to the same `folio`,
> and then we recheck that the PTE is still the same.)
> """

Nngh.  In trying to make this description fit all kernels (with
both pages and folios), you've complicated it maximally.  Let's
try a more simple explanation:

First we (locklessly) load the page table entry, then we grab a
reference to the folio that contains it (which can fail if the
refcount is zero, in that case we bail), then we recheck that the
page table entry is still the same, and if it changed in between,
we drop the folio reference and bail.
This can, again, grab a reference to a folio after it has
already been freed and reallocated. The reason why this is
fine is that the metadata structure that holds this refcount,
`struct folio` is never freed; even when a folio is
freed and reallocated, the corresponding `struct folio`
stays. This does have the fun consequence that whenever a
folio has a non-zero refcount, the refcount can
spuriously go up and then back down for a little bit.
(Also it's slightly more complex than I just described,
because the PTE that we just loaded might be in the middle of
being reallocated into a different folio.
So actually we first read the PTE, translate the PTE into the
`page*`, then from that we go to the `folio*`, then we
try to grab a reference to the `folio`, then if that worked
we check that the `page` is still in the same `folio`,
and then we recheck that the PTE is still the same.  Older kernels
did not make a clear distinction between pages and folios, so
it was even more confusing.)


Better?
