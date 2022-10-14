Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC115FF239
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJNQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJNQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB7D8ED7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B034E61BC5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 16:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F26C433C1;
        Fri, 14 Oct 2022 16:25:34 +0000 (UTC)
Date:   Fri, 14 Oct 2022 17:25:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y0mNek2pRpXexZxX@arm.com>
References: <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com>
 <Y0hDdmD0yJ+PS2Kz@arm.com>
 <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:58:22AM -0700, Saravana Kannan wrote:
> On Thu, Oct 13, 2022 at 9:57 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > If so, would there be concerns that the memory savings we get back from
> > > reducing the memory footprint of kmalloc might be defeated by how much
> > > memory is needed for bounce buffering?
> >
> > It's not necessarily about the saved memory but also locality of the
> > small buffer allocations, less cache and TLB pressure.
> 
> Part of the pushback we get when we try to move some of the Android
> ecosystem from 32-bit to 64-bit is the memory usage increase. So,
> while the main goal might not be memory savings, it'll be good to keep
> that in mind too. I'd definitely not want this patch series to make
> things worse. Ideally, it'd make things better. 10MB is considered a
> lot on some of the super low speced devices.

Well, we can still add the option to skip allocating from the small
kmalloc caches if there's no swiotlb available.

> > I wonder whether swiotlb is actually the best option for bouncing
> > unaligned buffers. We could use something like mempool_alloc() instead
> > if we stick to small buffers rather than any (even large) buffer that's
> > not aligned to a cache line. Or just go for kmem_cache_alloc() directly.
> > A downside is that we may need GFP_ATOMIC for such allocations, so
> > higher risk of failure.
> 
> Yeah, a temporary kmem_cache_alloc() to bounce buffers off of feels
> like a better idea than swiotlb. Especially for small allocations (say
> 8 byte allocations) that might have gone into the kmem-cache-64 if we
> hadn't dropped KMALLOC_MIN_ALIGN to 8.

I now remembered why this isn't trivial. On the dma_unmap_*() side, we
can't easily tell whether the buffer was bounced and it needs freeing.
The swiotlb solves this by checking whether the address is within the
pre-allocated swiotlb range. With kmem_caches, we could dig into the
slab internals and check whether the pointer is part of a slab page,
then check with kmem_cache that was. It looks too complicated and I'm
rather tempted to just go for swiotlb if available or prevent the
creation of small kmalloc caches if no swiotlb (TBH, even the initial
series was an improvement dropping KMALLOC_MIN_ALIGN from 128 to 64).

-- 
Catalin
