Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B361074B6E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjGGTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjGGTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:06:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927E2727
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VcC79p5FnMDwACqVyoSz3qMUxvEDx9IUffDrpYxsszc=; b=N8ZEPVxHT83vnm3M+WmDnfzVB6
        dhEiuQUir9TbVm5ORKOEIqSiak5ggPVHFoveW3X0jNSxGZ6dvIqWkZy09g8SjKrKgMn/igz+oRIj2
        FbZBWcko1aH6e7fJJflty4mm1y+OdN76mXh/Yuu8g5azTi6aQZFXiflsb4rV7alUEEGKyln9vVTdZ
        2+i3q4Z6FBzDkB3NFJUgSPOzX79bsOr1EaUB4wMoIN1Q7Xg01y0PRRPc/IUOF3SGKWBBzCWTKfwlG
        tKVvAg4LpUrWI48B71r2gfZ+cjDkQ3nqIWCzLOC+Cg80MBsmFYSbWqxMPjGYNf5Vr92B3R7XdNnmB
        hxeE8I3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHqmG-00CHRg-A1; Fri, 07 Jul 2023 19:06:00 +0000
Date:   Fri, 7 Jul 2023 20:06:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Message-ID: <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:54:33PM +0200, David Hildenbrand wrote:
> On 07.07.23 19:26, Matthew Wilcox wrote:
> > On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
> > > This series identified the large folio for mlock to two types:
> > >    - The large folio is in VM_LOCKED VMA range
> > >    - The large folio cross VM_LOCKED VMA boundary
> > 
> > This is somewhere that I think our fixation on MUST USE PMD ENTRIES
> > has led us astray.  Today when the arguments to mlock() cross a folio
> > boundary, we split the PMD entry but leave the folio intact.  That means
> > that we continue to manage the folio as a single entry on the LRU list.
> > But userspace may have no idea that we're doing this.  It may have made
> > several calls to mmap() 256kB at once, they've all been coalesced into
> > a single VMA and khugepaged has come along behind its back and created
> > a 2MB THP.  Now userspace calls mlock() and instead of treating that as
> > a hint that oops, maybe we shouldn't've done that, we do our utmost to
> > preserve the 2MB folio.
> > 
> > I think this whole approach needs rethinking.  IMO, anonymous folios
> > should not cross VMA boundaries.  Tell me why I'm wrong.
> 
> I think we touched upon that a couple of times already, and the main issue
> is that while it sounds nice in theory, it's impossible in practice.
> 
> THP are supposed to be transparent, that is, we should not let arbitrary
> operations fail.
> 
> But nothing stops user space from
> 
> (a) mmap'ing a 2 MiB region
> (b) GUP-pinning the whole range
> (c) GUP-pinning the first half
> (d) unpinning the whole range from (a)
> (e) munmap'ing the second half
> 
> 
> And that's just one out of many examples I can think of, not even
> considering temporary/speculative references that can prevent a split at
> random points in time -- especially when splitting a VMA.
> 
> Sure, any time we PTE-map a THP we might just say "let's put that on the
> deferred split queue" and cross fingers that we can eventually split it
> later. (I was recently thinking about that in the context of the mapcount
> ...)
> 
> It's all a big mess ...

Oh, I agree, there are always going to be circumstances where we realise
we've made a bad decision and can't (easily) undo it.  Unless we have a
per-page pincount, and I Would Rather Not Do That.  But we should _try_
to do that because it's the right model -- that's what I meant by "Tell
me why I'm wrong"; what scenarios do we have where a user temporarilly
mlocks (or mprotects or ...) a range of memory, but wants that memory
to be aged in the LRU exactly the same way as the adjacent memory that
wasn't mprotected?

GUP-pinning is different, and I don't think GUP-pinning should split
a folio.  That's a temporary use (not FOLL_LONGTERM), eg, we're doing
tcp zero-copy or it's the source/target of O_DIRECT.  That's not an
instruction that this memory is different from its neighbours.

Maybe we end up deciding to split folios on GUP-pin.  That would be
regrettable.
