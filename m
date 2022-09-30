Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7B5F11A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiI3SdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiI3Sc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E41B7D95
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77706623FE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60BAC433D6;
        Fri, 30 Sep 2022 18:32:53 +0000 (UTC)
Date:   Fri, 30 Sep 2022 19:32:50 +0100
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
Message-ID: <Yzc2UrX7ndWw1vKI@arm.com>
References: <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YypfJQqj8PeOp8A4@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:47:33PM -0700, Isaac Manjarres wrote:
> On Mon, Jul 18, 2022 at 06:53:43PM +0100, Catalin Marinas wrote:
> > So do I but holidays get in the way ;). I plan to refresh my kmalloc
> > minalign series at the end of August.
> > 
> > One significant change I have though is that now ARCH_KMALLOC_MINALIGN
> > now goes down all the way to 8 and using swiotlb bounce buffering if the
> > DMA mapping size is small.
> 
> This sounds like a good idea for optimizing kmalloc's memory usage
> beyond what this series originally achieved. I'm sure a few other things
> have come up in the meantime, but I was curious to know if you had a
> chance to get back to this?

I started refreshing the series but I got stuck on having to do bouncing
for small buffers even if when they go through the iommu (and I don't
have the set up to test it yet).

I hope to post something when the merging window closes. In the
meantime, I pushed my work-in-progress patches to:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign-v2-wip

Apart from the iommu think, I still need to figure out whether with an
ARCH_DMA_MINALIGN of 128 we need to disable the kmalloc-192 cache (so
far I don't think it's needed). There are no additional changes to the
crypto code from the last series, I still set CRYPTO_MINALIGN to
ARCH_DMA_MINALIGN (without any other patches, crypto DMA will break; so
I need to see how it interacts with Herbert's series).

Anyway, I hope for more discussions once 6.1-rc1 is out.

-- 
Catalin
