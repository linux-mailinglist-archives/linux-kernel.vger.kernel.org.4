Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045936388CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKYLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:32:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147761902F;
        Fri, 25 Nov 2022 03:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AED4F623A5;
        Fri, 25 Nov 2022 11:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B1DC433D6;
        Fri, 25 Nov 2022 11:31:59 +0000 (UTC)
Date:   Fri, 25 Nov 2022 11:31:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
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
Message-ID: <Y4CnrGmT5o7zcLJr@arm.com>
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
 <E1oyQRz-000djH-3a@formenos.hmeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1oyQRz-000djH-3a@formenos.hmeau.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Thanks for putting this together. I'll try to go through the series but
my crypto knowledge is fairly limited.

On Fri, Nov 25, 2022 at 12:36:31PM +0800, Herbert Xu wrote:
> diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
> index f50c5d1725da..4c99eb66e654 100644
> --- a/include/crypto/algapi.h
> +++ b/include/crypto/algapi.h
> @@ -7,6 +7,7 @@
>  #ifndef _CRYPTO_ALGAPI_H
>  #define _CRYPTO_ALGAPI_H
>  
> +#include <asm/cache.h>
>  #include <linux/align.h>
>  #include <linux/crypto.h>
>  #include <linux/kconfig.h>
> @@ -25,6 +26,14 @@
>  #define MAX_CIPHER_BLOCKSIZE		16
>  #define MAX_CIPHER_ALIGNMASK		15
>  
> +#ifdef ARCH_DMA_MINALIGN
> +#define CRYPTO_DMA_ALIGN ARCH_DMA_MINALIGN
> +#else
> +#define CRYPTO_DMA_ALIGN CRYPTO_MINALIGN
> +#endif
> +
> +#define CRYPTO_DMA_PADDING ((CRYPTO_DMA_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))

Is the CRYPTO_DMA_PADDING used anywhere? I couldn't find it in this
series and I'd rather drop it, together with CRYPTO_DMA_ALIGN (see
below).

> +
>  struct crypto_aead;
>  struct crypto_instance;
>  struct module;
> @@ -189,10 +198,38 @@ static inline void crypto_xor_cpy(u8 *dst, const u8 *src1, const u8 *src2,
>  	}
>  }
>  
> +static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
> +{
> +	return tfm->__crt_ctx;
> +}
> +
> +static inline void *crypto_tfm_ctx_align(struct crypto_tfm *tfm,
> +					 unsigned int align)
> +{
> +	if (align <= crypto_tfm_ctx_alignment())
> +		align = 1;
> +
> +	return PTR_ALIGN(crypto_tfm_ctx(tfm), align);
> +}
> +
>  static inline void *crypto_tfm_ctx_aligned(struct crypto_tfm *tfm)
>  {
> -	return PTR_ALIGN(crypto_tfm_ctx(tfm),
> -			 crypto_tfm_alg_alignmask(tfm) + 1);
> +	return crypto_tfm_ctx_align(tfm, crypto_tfm_alg_alignmask(tfm) + 1);
>+}

I had an attempt to make crypto_tfm_alg_alignmask() the larger of the
cra_alignmask and ARCH_DMA_MINALIGN but for some reason the kernel
started to panic, so I gave up.

> +
> +static inline unsigned int crypto_dma_align(void)
> +{
> +	return CRYPTO_DMA_ALIGN;
> +}

We have a generic dma_get_cache_alignment() function which currently is
either 1 or ARCH_DMA_MINALIGN, if the latter is defined. My plan is to
make eventually make this dynamic based on the actual cache line size
(on most arm64 systems it would be 64 rather than 128). So could you use
this instead of defining a CRYPTO_DMA_ALIGN? The only difference would
be that dma_get_cache_alignment() returns 1 rather than
ARCH_KMALLOC_MINALIGN if ARCH_DMA_MINALIGN is not defined, but I don't
think that's an issue.

> +
> +static inline unsigned int crypto_dma_padding(void)
> +{
> +	return (crypto_dma_align() - 1) & ~(crypto_tfm_ctx_alignment() - 1);
> +}
> +
> +static inline void *crypto_tfm_ctx_dma(struct crypto_tfm *tfm)
> +{
> +	return crypto_tfm_ctx_align(tfm, crypto_dma_align());
>  }

These would need to cope with crypto_dma_align() < ARCH_KMALLOC_MINALIGN.
I think that's fine, the padding will be 0 if crypto_dma_align() is 1.

-- 
Catalin
