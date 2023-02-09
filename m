Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF2690419
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBIJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBIJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:47:33 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87334C36;
        Thu,  9 Feb 2023 01:47:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQ3W2-009E9r-OF; Thu, 09 Feb 2023 17:46:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Feb 2023 17:46:54 +0800
Date:   Thu, 9 Feb 2023 17:46:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <Y+TBDqkjsuMiA/P7@gondor.apana.org.au>
References: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
 <20230130154242.112613-5-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130154242.112613-5-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:42:42PM +0800, Jia Jie Ho wrote:
>
> +static inline int starfive_hash_wait_hmac_done(struct starfive_cryp_ctx *ctx)
> +{
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	u32 status;
> +
> +	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
> +					  (status & STARFIVE_HASH_HMAC_DONE), 10, 100000);
> +}
> +
> +static inline int starfive_hash_wait_busy(struct starfive_cryp_ctx *ctx)
> +{
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	u32 status;
> +
> +	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
> +					  !(status & STARFIVE_HASH_BUSY), 10, 100000);
> +}
> +
> +static inline int starfive_hash_wait_key_done(struct starfive_cryp_ctx *ctx)
> +{
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	u32 status;
> +
> +	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
> +					  (status & STARFIVE_HASH_KEY_DONE), 10, 100000);
> +}

Is there no IRQ mechanism for this?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
