Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA96519CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLTDz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTDz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:55:26 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B904D13E04;
        Mon, 19 Dec 2022 19:55:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7Tip-008kGn-Kk; Tue, 20 Dec 2022 11:55:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 11:55:19 +0800
Date:   Tue, 20 Dec 2022 11:55:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: aead/shash - yield at end of operations
Message-ID: <Y6EyJ3MDOMXZ7Yku@gondor.apana.org.au>
References: <20221219203733.3063192-1-elliott@hpe.com>
 <20221219203733.3063192-3-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219203733.3063192-3-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:37:32PM -0600, Robert Elliott wrote:
> Add crypto_yield() calls at the end of all the encrypt and decrypt
> functions to let the scheduler use the CPU after possibly a long
> tenure by the crypto driver.
> 
> This reduces RCU stalls and soft lockups when running crypto
> functions back-to-back that don't have their own yield calls
> (e.g., aligned generic functions).
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  crypto/aead.c  |  4 ++++
>  crypto/shash.c | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/crypto/aead.c b/crypto/aead.c
> index 16991095270d..f88378f4d4f5 100644
> --- a/crypto/aead.c
> +++ b/crypto/aead.c
> @@ -93,6 +93,8 @@ int crypto_aead_encrypt(struct aead_request *req)
>  	else
>  		ret = crypto_aead_alg(aead)->encrypt(req);
>  	crypto_stats_aead_encrypt(cryptlen, alg, ret);
> +
> +	crypto_yield(crypto_aead_get_flags(aead));

This is the wrong place to do it.  It should be done by the code
that's actually doing the work, just like skcipher.

> diff --git a/crypto/shash.c b/crypto/shash.c
> index 868b6ba2b3b7..6fea17a50048 100644
> --- a/crypto/shash.c
> +++ b/crypto/shash.c
> @@ -114,11 +114,15 @@ int crypto_shash_update(struct shash_desc *desc, const u8 *data,
>  	struct crypto_shash *tfm = desc->tfm;
>  	struct shash_alg *shash = crypto_shash_alg(tfm);
>  	unsigned long alignmask = crypto_shash_alignmask(tfm);
> +	int ret;
>  
>  	if ((unsigned long)data & alignmask)
> -		return shash_update_unaligned(desc, data, len);
> +		ret = shash_update_unaligned(desc, data, len);
> +	else
> +		ret = shash->update(desc, data, len);
>  
> -	return shash->update(desc, data, len);
> +	crypto_yield(crypto_shash_get_flags(tfm));
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(crypto_shash_update);

Ditto.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
