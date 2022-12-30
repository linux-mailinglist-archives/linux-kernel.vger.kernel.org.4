Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFC659684
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiL3JFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:05:23 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8712614;
        Fri, 30 Dec 2022 01:05:21 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBBJk-00CI0k-7E; Fri, 30 Dec 2022 17:04:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 17:04:44 +0800
Date:   Fri, 30 Dec 2022 17:04:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, Jason@zx2c4.com, ardb@kernel.org,
        ap420073@gmail.com, David.Laight@aculab.com, ebiggers@kernel.org,
        tim.c.chen@linux.intel.com, peter@n8pjl.ca, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] crypto: x86/ghash - restructure FPU context saving
Message-ID: <Y66prPh5Bvpkdxv2@gondor.apana.org.au>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-8-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219220223.3982176-8-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:02:17PM -0600, Robert Elliott wrote:
> Wrap each of the calls to clmul_hash_update and clmul_ghash__mul
> in its own set of kernel_fpu_begin and kernel_fpu_end calls, preparing
> to limit the amount of data processed by each _update call to avoid
> RCU stalls.
> 
> This is more like how polyval-clmulni_glue is structured.
> 
> Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  arch/x86/crypto/ghash-clmulni-intel_glue.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
> index beac4b2eddf6..1bfde099de0f 100644
> --- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
> +++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
> @@ -80,7 +80,6 @@ static int ghash_update(struct shash_desc *desc,
>  	struct ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
>  	u8 *dst = dctx->buffer;
>  
> -	kernel_fpu_begin();
>  	if (dctx->bytes) {
>  		int n = min(srclen, dctx->bytes);
>  		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
> @@ -91,10 +90,14 @@ static int ghash_update(struct shash_desc *desc,
>  		while (n--)
>  			*pos++ ^= *src++;
>  
> -		if (!dctx->bytes)
> +		if (!dctx->bytes) {
> +			kernel_fpu_begin();
>  			clmul_ghash_mul(dst, &ctx->shash);
> +			kernel_fpu_end();
> +		}
>  	}
>  
> +	kernel_fpu_begin();
>  	clmul_ghash_update(dst, src, srclen, &ctx->shash);
>  	kernel_fpu_end();

Why is this necessary? Couldn't you just add the kernel_fpu_yield
calls even without this patch?

This just seems to be adding some unnecessary begin/end calls.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
