Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4B6E8FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjDTKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjDTKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:13:22 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF446A1;
        Thu, 20 Apr 2023 03:11:08 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ppRF8-000YMk-Qu; Thu, 20 Apr 2023 18:10:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 20 Apr 2023 18:10:23 +0800
Date:   Thu, 20 Apr 2023 18:10:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <ZEEPjzLIlZW6HaAM@gondor.apana.org.au>
References: <20230411081424.131912-1-jiajie.ho@starfivetech.com>
 <20230411081424.131912-5-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411081424.131912-5-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:14:24PM +0800, Jia Jie Ho wrote:
>
> +static int starfive_hash_export(struct ahash_request *req, void *out)
> +{
> +	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
> +
> +	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
> +	ahash_request_set_callback(&rctx->ahash_fbk_req,
> +				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
> +				   req->base.complete, req->base.data);
> +
> +	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
> +				req->result, req->nbytes);
> +
> +	return crypto_ahash_export(&rctx->ahash_fbk_req, out);
> +}

You can't export a freshly created request.  The fallback
request needs to have been created by the usual init/update
calls.

The export function should simply invoke export.

> +static int starfive_hash_cra_init_algs(struct crypto_tfm *tfm,
> +				       const char *algs_hmac_name,
> +				       unsigned int mode,
> +				       const char *alg_name)
> +{
> +	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct crypto_ahash *ahash = __crypto_ahash_cast(tfm);
> +
> +	ctx->cryp = starfive_cryp_find_dev(ctx);
> +
> +	if (!ctx->cryp)
> +		return -ENODEV;
> +
> +	ctx->ahash_fbk = crypto_alloc_ahash(alg_name, 0,
> +					    CRYPTO_ALG_NEED_FALLBACK);
> +
> +	if (IS_ERR(ctx->ahash_fbk))
> +		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->ahash_fbk),
> +				     "starfive_hash: Could not load fallback driver.\n");
> +
> +	crypto_hash_alg_common(ahash)->statesize = crypto_ahash_statesize(ctx->ahash_fbk);

I've just posted a patch to linux-crypto to do this properly:

https://lore.kernel.org/linux-crypto/ZEEOXIHwqKblKfBJ@gondor.apana.org.au/T/#u

Please switch to using the helper that I added.

> +static int starfive_hash256_setkey(struct crypto_ahash *tfm,
> +				   const u8 *key, unsigned int keylen)
> +{
> +	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
> +	unsigned int digestsize = crypto_ahash_digestsize(tfm);
> +	unsigned int blocksize;
> +	int ret = 0;
> +
> +	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));

Please use crypto_ahash_blocksize.  We should never use crypto_ahash_tfm
in new code.

> +static int starfive_hash_cra_sha224_init(struct crypto_tfm *tfm)
> +{
> +	return starfive_hash_cra_init_algs(tfm, NULL,
> +					   STARFIVE_HASH_SHA224,
> +					   "sha224-generic");
> +}

Please switch to the new API and use init_tfm/exit_tfm instead of
cra_init/cra_exit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
