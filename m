Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D05FDE94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJMQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJMQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C192FC5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B468B81FBD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 16:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30FEC433D6;
        Thu, 13 Oct 2022 16:57:29 +0000 (UTC)
Date:   Thu, 13 Oct 2022 17:57:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y0hDdmD0yJ+PS2Kz@arm.com>
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0b9SYI7v94ig5v8@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:45:45AM -0700, Isaac Manjarres wrote:
> On Fri, Sep 30, 2022 at 07:32:50PM +0100, Catalin Marinas wrote:
> > I started refreshing the series but I got stuck on having to do bouncing
> > for small buffers even if when they go through the iommu (and I don't
> > have the set up to test it yet).
> 
> For devices that go through the IOMMU, are you planning on adding
> similar logic as you did in the direct-DMA path to bounce the buffer
> prior to calling into whatever DMA ops are registered for the device?

Yes.

> Also, there are devices with ARM64 CPUs that disable SWIOTLB usage because
> none of the peripherals that they engage in DMA with need bounce buffering,
> and also to reclaim the default 64 MB of memory that SWIOTLB uses. With
> this approach, SWIOTLB usage will become mandatory if those devices need
> to perform non-coherent DMA transactions that may not necessarily be DMA
> aligned (e.g. small buffers), correct?

Correct. I've been thinking about this and a way around is to combine
the original series (dynamic kmalloc_minalign) with the new one so that
the arch code can lower the minimum alignment either to 8 if swiotlb is
available (usually in server space with more RAM) or the cache line size
if there is no bounce buffer.

> If so, would there be concerns that the memory savings we get back from
> reducing the memory footprint of kmalloc might be defeated by how much
> memory is needed for bounce buffering?

It's not necessarily about the saved memory but also locality of the
small buffer allocations, less cache and TLB pressure.

> I understand that we can use the
> "swiotlb=num_slabs" command line parameter to minimize the amount of
> memory allocated for bounce buffering. If this is the only way to
> minimize this impact, how much memory would you recommend to allocate
> for bounce buffering on a system that will only use bounce buffers for
> non-DMA-aligned buffers?

It's hard to tell, it would need to be guessed by trial and error on
specific hardware if you want to lower it. Another issue is that IIRC
the swiotlb is allocated in 2K slots, so you may need a lot more bounce
buffers than the actual memory allocated.

I wonder whether swiotlb is actually the best option for bouncing
unaligned buffers. We could use something like mempool_alloc() instead
if we stick to small buffers rather than any (even large) buffer that's
not aligned to a cache line. Or just go for kmem_cache_alloc() directly.
A downside is that we may need GFP_ATOMIC for such allocations, so
higher risk of failure.

-- 
Catalin
