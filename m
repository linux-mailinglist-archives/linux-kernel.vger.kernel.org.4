Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CC69EDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjBVDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBVDxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:53:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B350C14F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dOYl3SjwxOmZgzkyta2mx+9MAywhcAllv7ncRUJlsRo=; b=TFBZF8n5EetVpuhq5Ay9jXh81s
        iMvH0WX9mrGWA/JHLmdGblgTZNQ0cs3D38RvB4qdHh5RS1K3ZN/7Nmabi9gD4OM1Eif5KK/DzPyRH
        oBSjdXY08Bxs2bw2WIad7XJgm/7wVOpt0V4ML7zYpauFpy70B6BVr29Lb8GNkTZxh0Xzurv/YAYY4
        i0U+n29f+IQ6uSB4uDWqi3dMAWRLe4NUCJqjdW2pDD90rkb2mbz1rJWdjBHuPEJrHJOYNxNAyHO3p
        /r1k0EM62tzlKdToqETEOZLf4yLkDm1ICN0LitVYTQU1aPgPLFGl5v+FiKuTsE5YZM3FcvvJP21N6
        FD74bpPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUgBa-00DAKv-0O; Wed, 22 Feb 2023 03:52:54 +0000
Date:   Wed, 22 Feb 2023 03:52:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: What size anonymous folios should we allocate?
Message-ID: <Y/WRlX+MkmxelNbg@casper.infradead.org>
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
 <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
> On Tue, Feb 21, 2023 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > In a sense this question is premature, because we don't have any code
> > in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
> > but let's pretend that code already exists and is just waiting for us
> > to answer this policy question.
> >
> > I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
> > option and 3. a sysfs tunable.  It is foolish to expect the distro
> > packager or the sysadmin to be able to make such a decision.  The
> > correct decision will depend upon the instantaneous workload of the
> > entire machine and we'll want different answers for different VMAs.
> 
> Yeah, I agree those 3 options should be avoided. For some
> architectures, there are a or multiple sweet size(s) benefiting from
> hardware. For example, ARM64 contiguous PTE supports up to 16
> consecutive 4K pages to form a 64K entry in TLB instead of 16 4K
> entries. Some implementations may support intermediate sizes (for
> example, 8K, 16K and 32K, but this may make the hardware design
> harder), but some may not. AMD's coalesce PTE supports a different
> size (128K if I remember correctly). So the multiple of the size
> supported by hardware (64K or 128K) seems like the common ground from
> maximizing hardware benefit point of view. Of course, nothing prevents
> the kernel from allocating other orders.

All of this is true (although I think AMDs intermediate size is actually
32kB, not 128kB), but irrelevant.  Software overhead is FAR more important
than hardware overhead.  If we swap out the wrong page or have to run
around doing reclaim, that absolutely dwarfs the performance impact of
using small TLB entries.

So we need to strike the right balance between using larger folios
for efficiency and smaller folios for precision of knowing which
pages are still part of the process working set.

> Actually I was thinking about the reverse, starting from the biggest
> possible order, for example, 2M -> 1M -> ... 64K -> ... 4K. And the
> page fault path should be able to use the same fallback order. But
> excessive fallback tries may be harmful either.

What's your reasoning here?

> > B. A further modification is that it will require three of the four
> >    folios being combined to be on the active list.  If two (or more)
> >    of the four folios are inactive, we should leave them alone; either
> >    they will remain inactive and eventually be evicted, or they will be
> >    activated and eligible for merging in a future pass of khugepaged.
> 
> If we use the fallback policy, we should be able to just leave it to
> reclamation time. When checking reference we could tell what PTEs are
> accessed, then split if there is significant internal fragmentation.

I think it's going to lead to excessive memory usage.  There was data
presented last LSFMM that we already have far too much memory tied up
in THP for many workloads.

> > C. We add a new wrinkle to the LRU handling code.  When our scan of the
> >    active list examines a folio, we look to see how many of the PTEs
> >    mapping the folio have been accessed.  If it is fewer than half, and
> >    those half are all in either the first or last half of the folio, we
> >    split it.  The active half stays on the active list and the inactive
> >    half is moved to the inactive list.
> 
> With contiguous PTE, every PTE still maintains its own access bit (but
> it is implementation defined, some implementations may just set access
> bit once for one PTE in the contiguous region per arm arm IIUC). But
> anyway this is definitely feasible.

If a CPU doesn't have separate access bits for PTEs, then we should just
not use the contiguous bits.  Knowing which parts of the folio are
unused is more important than using the larger TLB entries.

> > For the third case, in contrast, the parent had already established
> > an appropriate size folio to use for this VMA before calling fork().
> > Whether it is the parent or the child causing the COW, it should probably
> > inherit that choice and we should default to the same size folio that
> > was already found.
> 
> Actually this is not what THP does now. The current THP behavior is to
> split the PMD then fallback to order-0 page fault. For smaller orders,
> we may consider allocating a large folio.

I know it's not what THP does now.  I think that's because the gap
between PMD and PAGE size is too large and we end up wasting too much
memory.  We also have very crude mechanisms for determining when to
use THPs.  With the adaptive mechanism I described above, I think it's
time to change that.

