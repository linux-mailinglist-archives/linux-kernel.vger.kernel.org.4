Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD3675243
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:21:52 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC364617D;
        Fri, 20 Jan 2023 02:21:51 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pIoWd-002BGR-8C; Fri, 20 Jan 2023 18:21:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 18:21:35 +0800
Date:   Fri, 20 Jan 2023 18:21:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] crypto: stm32/hash: Support Ux500 hash
Message-ID: <Y8prL1fzhdf1jEyT@gondor.apana.org.au>
References: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
 <20221227-ux500-stm32-hash-v2-5-bc443bc44ca4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227-ux500-stm32-hash-v2-5-bc443bc44ca4@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:19:16PM +0100, Linus Walleij wrote:
>  
> +static void stm32_hash_emptymsg_fallback(struct ahash_request *req)
> +{
> +	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
> +	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(ahash);
> +	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
> +	struct stm32_hash_dev *hdev = rctx->hdev;
> +	struct crypto_shash *xtfm;
> +	struct shash_desc *sdesc;
> +	size_t len;
> +	int ret;
> +
> +	dev_dbg(hdev->dev, "use fallback message size 0 key size %d\n",
> +		ctx->keylen);
> +	xtfm = crypto_alloc_shash(crypto_ahash_alg_name(ahash),
> +				  0, CRYPTO_ALG_NEED_FALLBACK);
> +	if (IS_ERR(xtfm)) {
> +		dev_err(hdev->dev, "failed to allocate synchronous fallback\n");
> +		return;
> +	}
> +
> +	len = sizeof(*sdesc) + crypto_shash_descsize(xtfm);
> +	sdesc = kmalloc(len, GFP_KERNEL);
> +	if (!sdesc)
> +		goto err_hashkey_sdesc;
> +	sdesc->tfm = xtfm;
> +
> +	if (ctx->keylen) {
> +		ret = crypto_shash_setkey(xtfm, ctx->key, ctx->keylen);
> +		if (ret) {
> +			dev_err(hdev->dev, "failed to set key ret=%d\n", ret);
> +			goto err_hashkey;
> +		}
> +	}
> +
> +	ret = crypto_shash_init(sdesc);
> +	if (ret) {
> +		dev_err(hdev->dev, "shash init error ret=%d\n", ret);
> +		goto err_hashkey;
> +	}
> +
> +	ret = crypto_shash_finup(sdesc, NULL, 0, rctx->digest);
> +	if (ret)
> +		dev_err(hdev->dev, "shash finup error\n");
> +err_hashkey:
> +	kfree(sdesc);
> +err_hashkey_sdesc:
> +	crypto_free_shash(xtfm);
> +}

Calling crypto_alloc_shash is not allowed in this context.  For
example, we might have been called down from the block layer due to
swapping.  Even if you intermediate this with kernel threads, it
still doesn't change the nature of the dead-lock.

So if you need a fallback for zero-length messages, just allocate
it unconditionally in the init_tfm function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
