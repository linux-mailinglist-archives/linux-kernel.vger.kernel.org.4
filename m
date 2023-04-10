Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACB6DC401
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDJHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:51:28 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A63C0A;
        Mon, 10 Apr 2023 00:51:25 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1plmIR-00EEnN-4P; Mon, 10 Apr 2023 15:50:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Apr 2023 15:50:39 +0800
Date:   Mon, 10 Apr 2023 15:50:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
References: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
 <20230410073752.39506-5-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410073752.39506-5-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:37:52PM +0800, Jia Jie Ho wrote:
>
> +static void starfive_hash_start(void *param)
> +{
> +	struct starfive_cryp_ctx *ctx = param;
> +	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	union starfive_alg_cr alg_cr;
> +	union starfive_hash_csr csr;
> +
> +	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
> +
> +	alg_cr.v = 0;
> +	alg_cr.clear = 1;
> +
> +	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
> +
> +	csr.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
> +	csr.firstb = 0;
> +	csr.final = 1;
> +
> +	reinit_completion(&cryp->hash_done);
> +	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
> +	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
> +}

Why are you still using a completion? The callback function should
invoke the crypto_engine finalize_request call directly.

> +static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
> +{
> +	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	int ret;
> +
> +	rctx->csr.hash.v = 0;
> +	rctx->csr.hash.reset = 1;
> +	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
> +
> +	if (starfive_hash_wait_busy(ctx))
> +		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
> +
> +	rctx->csr.hash.v = 0;
> +	rctx->csr.hash.mode = ctx->hash_mode & STARFIVE_HASH_MODE_MASK;
> +	rctx->csr.hash.ie = 1;
> +
> +	if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS) {
> +		ret = starfive_hash_hmac_key(ctx);
> +		if (ret)
> +			return ret;
> +	} else {
> +		rctx->csr.hash.start = 1;
> +		rctx->csr.hash.firstb = 1;
> +		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
> +	}
> +
> +	ret = starfive_hash_xmit_dma(ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (!wait_for_completion_timeout(&cryp->hash_done, msecs_to_jiffies(10000)))
> +		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Timeout waiting for hash done\n");

There is no point in waiting for completion.  Just return 0 and
you're done.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
