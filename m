Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C15F2051
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJAWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJAWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 18:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E218C19C2C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 15:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF4260DD1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 22:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26403C433D6;
        Sat,  1 Oct 2022 22:29:54 +0000 (UTC)
Date:   Sat, 1 Oct 2022 23:29:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Yzi/X12rQTuT9Uqk@arm.com>
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
 <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:35:45PM -0700, Linus Torvalds wrote:
> On Fri, Sep 30, 2022 at 11:33 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > I started refreshing the series but I got stuck on having to do bouncing
> > for small buffers even if when they go through the iommu (and I don't
> > have the set up to test it yet).
> 
> May I suggest doing that "force bouncing" and "change kmalloc to have
> a 8-byte minalign" to be the two first commits?
> 
> IOW, if we force bouncing for unaligned DMA, then that *should* mean
> that allocation alignment is no longer a correctness issue, it's
> purely a performance one due to the bouncing.

I've been thinking about this and even ended up with a CBMC model
(included below; it found a bug in dma_kmalloc_needs_bounce()).

The "force bouncing" in my series currently only checks for small
(potentially kmalloc'ed) sizes under the assumption that intra-object
DMA buffers were properly aligned to 128. So for something like below:

struct devres {
	struct devres_node		node;
	u8 __aligned(ARCH_DMA_MINALIGN) data[];
};

we'd need ARCH_DMA_MINALIGN of 128 even if ARCH_KMALLOC_MINALIGN is 8.
Original the code has __aligned(ARCH_KMALLOC_MINALIGN), so lowering the
latter to 8 without any changes would be problematic (the sizeof(devres)
may be sufficiently large to look cacheline-aligned).

If data[] contains a single DMA buffer, dma_kmalloc_needs_bounce() can
get the start of the buffer as another parameter and check that it's a
multiple of cache_line_size().

However, things get more complicated if data[] is used for several
sub-allocations of multiples of ARCH_KMALLOC_MINALIGN. Not much to do
with kmalloc() caches at this point. I haven't got my head around the
crypto code but it looked to me like it needs ARCH_DMA_MINALIGN in some
places if we are to lower ARCH_KMALLOC_MINALIGN. We could attempt to
force bouncing in dma_kmalloc_needs_bounce() by:

	if (ptr % dma_align != || size % dma_align != 0)
		return true;

but that's orthogonal to the kmalloc caches. I tried this some years ago
and IIRC many buffers get bounced even with ARCH_KMALLOC_MINALIGN of 128
because drivers don't necessarily have cacheline-aligned sized
structures shared with devices (but they are allocated from a
cacheline-aligned slab). So this check results in unnecessary bouncing.

So my series attempts to (1) fix the (static) alignment for intra-object
buffers by changing a few ARCH_KMALLOC_MINALIGN uses to
ARCH_DMA_MINALIGN and (2) address the kmalloc() DMA safety by bouncing
non-cacheline-aligned sizes. I don't think we can do (2) first as the
logic for handling (1) in the absence of a large ARCH_DMA_MINALIGN is
different.

And that's the CMBC model:

------------------------------------8<----------------------------
// SPDX-License-Identifier: GPL-2.0-only
/*
 * Check with:
 *   cbmc --trace dma-bounce.c
 */

#define PAGE_SIZE		4096

#define ARCH_KMALLOC_MINALIGN	8
#define ARCH_DMA_MINALIGN	128

#define KMALLOC_MIN_SIZE	ARCH_KMALLOC_MINALIGN
#define KMALLOC_SHIFT_LOW	3
#define KMALLOC_SHIFT_HIGH	25
#define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_HIGH)

#define INIT_KMALLOC_INFO(__size, __short_size)			\
{								\
	.size = __size,						\
}

static unsigned int nondet_uint(void);

struct kmalloc_info_struct {
	unsigned int size;
};

struct kmalloc_slab {
	unsigned int ptr;
	unsigned int size;
};

static const struct kmalloc_info_struct kmalloc_info[] = {
	INIT_KMALLOC_INFO(0, 0),
	INIT_KMALLOC_INFO(96, 96),
	INIT_KMALLOC_INFO(192, 192),
	INIT_KMALLOC_INFO(8, 8),
	INIT_KMALLOC_INFO(16, 16),
	INIT_KMALLOC_INFO(32, 32),
	INIT_KMALLOC_INFO(64, 64),
	INIT_KMALLOC_INFO(128, 128),
	INIT_KMALLOC_INFO(256, 256),
	INIT_KMALLOC_INFO(512, 512),
	INIT_KMALLOC_INFO(1024, 1k),
	INIT_KMALLOC_INFO(2048, 2k),
	INIT_KMALLOC_INFO(4096, 4k),
	INIT_KMALLOC_INFO(8192, 8k),
	INIT_KMALLOC_INFO(16384, 16k),
	INIT_KMALLOC_INFO(32768, 32k),
	INIT_KMALLOC_INFO(65536, 64k),
	INIT_KMALLOC_INFO(131072, 128k),
	INIT_KMALLOC_INFO(262144, 256k),
	INIT_KMALLOC_INFO(524288, 512k),
	INIT_KMALLOC_INFO(1048576, 1M),
	INIT_KMALLOC_INFO(2097152, 2M),
	INIT_KMALLOC_INFO(4194304, 4M),
	INIT_KMALLOC_INFO(8388608, 8M),
	INIT_KMALLOC_INFO(16777216, 16M),
	INIT_KMALLOC_INFO(33554432, 32M)
};

static unsigned int cache_line_size(void)
{
	static const unsigned int cls = nondet_uint();

	__CPROVER_assume(cls == 32 || cls == 64 || cls == 128);

	return cls;
}

static unsigned int kmalloc_index(unsigned int size)
{
	if (!size)
		return 0;

	if (size <= KMALLOC_MIN_SIZE)
		return KMALLOC_SHIFT_LOW;

	if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
		return 1;
	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
		return 2;
	if (size <=          8) return 3;
	if (size <=         16) return 4;
	if (size <=         32) return 5;
	if (size <=         64) return 6;
	if (size <=        128) return 7;
	if (size <=        256) return 8;
	if (size <=        512) return 9;
	if (size <=       1024) return 10;
	if (size <=   2 * 1024) return 11;
	if (size <=   4 * 1024) return 12;
	if (size <=   8 * 1024) return 13;
	if (size <=  16 * 1024) return 14;
	if (size <=  32 * 1024) return 15;
	if (size <=  64 * 1024) return 16;
	if (size <= 128 * 1024) return 17;
	if (size <= 256 * 1024) return 18;
	if (size <= 512 * 1024) return 19;
	if (size <= 1024 * 1024) return 20;
	if (size <=  2 * 1024 * 1024) return 21;
	if (size <=  4 * 1024 * 1024) return 22;
	if (size <=  8 * 1024 * 1024) return 23;
	if (size <=  16 * 1024 * 1024) return 24;
	if (size <=  32 * 1024 * 1024) return 25;

	__CPROVER_assert(0, "Invalid kmalloc() size");

	return -1;
}

unsigned int kmalloc(unsigned int size, struct kmalloc_slab *slab)
{
	unsigned int nr = nondet_uint();

	slab->size = kmalloc_info[kmalloc_index(size)].size;
	slab->ptr = nr * slab->size;

	__CPROVER_assume(slab->ptr < PAGE_SIZE);
	__CPROVER_assume(slab->ptr % slab->size == 0);

	return slab->ptr;
}

/*
 * Implemented only for 32, 64 and 128 cache line sizes.
 */
int dma_kmalloc_needs_bounce(unsigned int size)
{
	unsigned int dma_align = cache_line_size();

	/*
	 * Less than half dma_align, there's definitely a smaller kmalloc()
	 * cache.
	 */
	if (size <= dma_align / 2)
		return 1;

	/*
	 * From this point, any kmalloc cache size is 32-byte aligned.
	 */
	if (dma_align == 32)
		return 0;

	/*
	 * dma_align == 64 => 96 needs bouncing.
	 * dma_align == 128 => 96 and 192 need bouncing.
	 */
	if (size > 64 && size <= 96)
		return 1;
	if (dma_align == 128 && size > 128 && size <= 192)
		return 1;

	return 0;
}

/*
 * Simulate DMA cache maintenance. The 'slab' object is only used for
 * verification.
 */
void dma_map_single(unsigned int ptr, unsigned int size,
		    struct kmalloc_slab *slab)
{
	unsigned int mask = cache_line_size() - 1;

	if (dma_kmalloc_needs_bounce(size)) {
		/* was the bounce really necessary? */
		__CPROVER_assert((ptr & mask) != 0 || (size & mask) != 0,
				 "Bouncing aligned DMA buffer");
		return;
	}

	/*
	 * Check for cache maintenance outside the kmalloc'ed object. We don't
	 * care about intra-object overlap, it's the caller's responsibility
	 * to ensure alignment.
	 */
	__CPROVER_assert((ptr & ~mask) >= slab->ptr, "DMA cache maintenance underflow");
	__CPROVER_assert(((ptr + size + mask) & ~mask) <= slab->ptr + slab->size,
			 "DMA cache maintenance overflow");
}

int main(void)
{
	struct kmalloc_slab slab;
	unsigned int size = nondet_uint();
	unsigned int offset = nondet_uint();
	unsigned int ptr;

	__CPROVER_assume(size <= KMALLOC_MAX_SIZE);
	__CPROVER_assume(offset < size);
	__CPROVER_assume(offset % ARCH_DMA_MINALIGN == 0);

	ptr = kmalloc(size, &slab);
	dma_map_single(ptr + offset, size - offset, &slab);

	return 0;
}

-- 
Catalin
