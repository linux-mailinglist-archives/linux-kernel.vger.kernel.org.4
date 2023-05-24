Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702AC70F38D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEXJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEXJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:56:23 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C19E;
        Wed, 24 May 2023 02:56:21 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1lDy-00Ckbo-Ar; Wed, 24 May 2023 17:56:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 May 2023 17:56:06 +0800
Date:   Wed, 24 May 2023 17:56:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     olivia@selenic.com, Jason@zx2c4.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
Subject: Re: [PATCH] hwrng: cn10k: Add extended trng register support
Message-ID: <ZG3fNmNfUHeWIsNZ@gondor.apana.org.au>
References: <20230518064734.18819-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518064734.18819-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:17:34PM +0530, Bharat Bhushan wrote:
>
> -static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
> +static size_t cn10k_read_trng(struct cn10k_rng *rng, u64 *value)

Since the return value is either 0 or 8, why did you pick size_t
as the return value?

>  {
> +	u16 retry_count = 0;
>  	u64 upper, lower;
> +	u64 status;
> +
> +	if (rng->extended_trng_regs) {
> +		do {
> +			*value = readq(rng->reg_base + RNM_PF_TRNG_DAT);
> +			if (*value)
> +				return 8;
> +			status = readq(rng->reg_base + RNM_PF_TRNG_RES);
> +			if (!status && (retry_count++ > 0x1000))
> +				return 0;
> +		} while (!status);
> +	}
>  
>  	*value = readq(rng->reg_base + RNM_PF_RANDOM);
>  
> @@ -82,6 +130,7 @@ static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
>  
>  		*value = (upper & 0xFFFFFFFF00000000) | (lower & 0xFFFFFFFF);
>  	}
> +	return 8;
>  }
>  
>  static int cn10k_rng_read(struct hwrng *hwrng, void *data,
> @@ -100,7 +149,9 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
>  	size = max;
>  
>  	while (size >= 8) {
> -		cn10k_read_trng(rng, &value);
> +		err = cn10k_read_trng(rng, &value);
> +		if (!err)
> +			goto out;

It appears that err is either 8 or 0, so it's not really an error.
Could you plesae use a more meaningful name for this variable?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
