Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8893A6519CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLTDyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTDyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:54:12 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5812D1C;
        Mon, 19 Dec 2022 19:54:11 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7The-008kFq-AP; Tue, 20 Dec 2022 11:54:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 11:54:06 +0800
Date:   Tue, 20 Dec 2022 11:54:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: skcipher - always yield at end of walk
Message-ID: <Y6Ex3qhftA/jXVUS@gondor.apana.org.au>
References: <20221219203733.3063192-1-elliott@hpe.com>
 <20221219203733.3063192-2-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219203733.3063192-2-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:37:31PM -0600, Robert Elliott wrote:
>
> diff --git a/crypto/skcipher.c b/crypto/skcipher.c
> index 0ecab31cfe79..cdead632117a 100644
> --- a/crypto/skcipher.c
> +++ b/crypto/skcipher.c
> @@ -153,13 +153,20 @@ int skcipher_walk_done(struct skcipher_walk *walk, int err)
>  	scatterwalk_done(&walk->in, 0, nbytes);
>  	scatterwalk_done(&walk->out, 1, nbytes);
>  
> -	if (nbytes) {
> -		crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
> -			     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
> +	/*
> +	 * Allow scheduler to use the CPU since it has been busy,
> +	 * regardless of whether another loop pass is due
> +	 */
> +	crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
> +		     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
> +
> +	if (nbytes)
>  		return skcipher_walk_next(walk);
> -	}
>  
>  finish:
> +	crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
> +		     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
> +

You're calling crypto_yield twice if nbytes == 0.  How about
deleting the second crypto_yield call because the only case
where it would matter is when n == 0.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
