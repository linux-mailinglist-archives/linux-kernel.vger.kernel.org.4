Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9942460037B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJPViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 17:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2830F66
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 14:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90AA7B80D54
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85814C433C1;
        Sun, 16 Oct 2022 21:37:52 +0000 (UTC)
Date:   Sun, 16 Oct 2022 22:37:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y0x5rGRcjn996ZOo@arm.com>
References: <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com>
 <Y0hDdmD0yJ+PS2Kz@arm.com>
 <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
 <Y0mNek2pRpXexZxX@arm.com>
 <CAGETcx9zGaFFBqQ8d4kF-jz3nOjyShkbu3Z4YHpFY9_N+16g-w@mail.gmail.com>
 <CAHk-=wjgaWEsObv2SO-xa6g6ncj53q8tPpM3cgJGr+wtWknVyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgaWEsObv2SO-xa6g6ncj53q8tPpM3cgJGr+wtWknVyA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:44:25PM -0700, Linus Torvalds wrote:
> On Fri, Oct 14, 2022 at 1:24 PM Saravana Kannan <saravanak@google.com> wrote:
> > Agreed. Even allowing a 64-byte kmalloc cache on a system with a
> > 64-byte cacheline size saves quite a bit of memory.
> 
> Well, the *really* trivial thing to do is to just say "if the platform
> is DMA coherent, just allow any size kmalloc cache". And just
> consciously leave the broken garbage behind.

The problem is we don't have a reliable way to tell whether the platform
is DMA-coherent. The CPU IDs don't really say much and in most cases
it's a property of the interconnect/bus and device. We describe the DMA
coherency in DT or ACPI and the latter is somewhat better as it assumes
coherent by default. But for DT, not having a 'dma-coherent' property
means non-coherent DMA (or no DMA at all). We can't even tell whether
the device is going to do any DMA, arch_setup_dma_ops() is called even
for devices like the PMU. We could look into defining new properties
(e.g. "no-dma") and adjust the DTs but we may also have late probed
devices, long after the slab allocator was initialised. A big
'dma-coherent' property on the top node may work but most Android
systems won't benefit from this (your laptop may, I haven't checked).

I think the best bet is still either (a) bounce for small sizes or (b) a
new GFP_NODMA/PACKED/etc. flag for the hot small allocations. (a) is
somehow more universal but lots (most) Android devices are deployed with
no swiotlb buffer as the vendor knows the device needs and don't need
extra buffer waste. Not sure how reliable it would be to trigger another
slab allocation on the dma_map_*() calls for the bounce (it may need to
be GFP_ATOMIC). Option (b) looks more appealing on such systems, though
a lot more churn throughout the kernel.

-- 
Catalin
