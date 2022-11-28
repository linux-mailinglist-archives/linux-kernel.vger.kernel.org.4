Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD363A042
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK1EAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiK1EAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:00:31 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB813CDB;
        Sun, 27 Nov 2022 20:00:27 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ozVJH-001OeH-TB; Mon, 28 Nov 2022 12:00:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Nov 2022 11:59:59 +0800
Date:   Mon, 28 Nov 2022 11:59:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v2 PATCH 2/9] crypto: api - Add crypto_tfm_ctx_dma
Message-ID: <Y4QyPzcc3xpOoXyK@gondor.apana.org.au>
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
 <E1oyQRz-000djH-3a@formenos.hmeau.com>
 <Y4CnrGmT5o7zcLJr@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4CnrGmT5o7zcLJr@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:31:56AM +0000, Catalin Marinas wrote:
> 
> Is the CRYPTO_DMA_PADDING used anywhere? I couldn't find it in this
> series and I'd rather drop it, together with CRYPTO_DMA_ALIGN (see
> below).

Yes it's used by caam which needs it in a struct initialiser.

> We have a generic dma_get_cache_alignment() function which currently is
> either 1 or ARCH_DMA_MINALIGN, if the latter is defined. My plan is to
> make eventually make this dynamic based on the actual cache line size
> (on most arm64 systems it would be 64 rather than 128). So could you use
> this instead of defining a CRYPTO_DMA_ALIGN? The only difference would
> be that dma_get_cache_alignment() returns 1 rather than
> ARCH_KMALLOC_MINALIGN if ARCH_DMA_MINALIGN is not defined, but I don't
> think that's an issue.

I'm trying to make the driver patches as robotic as possible.

We could always improve upon this with driver-specific patches
to change the struct initialiser to a run-time assignment to
improve things further.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
