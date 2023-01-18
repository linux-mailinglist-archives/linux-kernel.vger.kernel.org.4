Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9A67205C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjARO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjARO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:57:58 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8310EF;
        Wed, 18 Jan 2023 06:54:18 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pI9pD-001P0M-LV; Wed, 18 Jan 2023 22:54:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 18 Jan 2023 22:54:03 +0800
Date:   Wed, 18 Jan 2023 22:54:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix possible crash in GCM cryption
Message-ID: <Y8gIC8Yn/E8Kwtf0@gondor.apana.org.au>
References: <20230118141928.48136-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118141928.48136-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:19:28PM +0800, Tianjia Zhang wrote:
> When the cryption total length is zero, GCM cryption call
> skcipher_walk_done() will cause an unexpected crash, so skip calling
> this function to avoid possible crash when the GCM cryption length
> is equal to zero.
> 
> Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/arm64/crypto/sm4-ce-gcm-glue.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
> index c450a2025ca9..9b63bcf9aa85 100644
> --- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
> +++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
> @@ -178,11 +178,13 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
>  
>  		kernel_neon_end();
>  
> -		err = skcipher_walk_done(walk, tail);
> -		if (err)
> -			return err;
> -		if (walk->nbytes)
> -			kernel_neon_begin();
> +		if (walk->nbytes) {

Please do
		if (!walk->nbytes)
			break;

As an additional improvement, the tail calculation can be removed
entirely because you already set the chunksize so the walker should
only be feeding you multiples of chunksize except at the end.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
