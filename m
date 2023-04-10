Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E56DC4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDJItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:48:41 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82559F3;
        Mon, 10 Apr 2023 01:47:31 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BFC6924E0D6;
        Mon, 10 Apr 2023 16:43:40 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 16:43:41 +0800
Received: from [192.168.155.128] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 16:43:37 +0800
Message-ID: <6df549e9-d0f6-23ca-882f-527c4e40b553@starfivetech.com>
Date:   Mon, 10 Apr 2023 16:43:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
 <20230410073752.39506-5-jiajie.ho@starfivetech.com>
 <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2023 3:50 pm, Herbert Xu wrote:
> On Mon, Apr 10, 2023 at 03:37:52PM +0800, Jia Jie Ho wrote:
>>
>> +static void starfive_hash_start(void *param)
>> +{
>> +	struct starfive_cryp_ctx *ctx = param;
>> +	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
>> +	struct starfive_cryp_dev *cryp = ctx->cryp;
>> +	union starfive_alg_cr alg_cr;
>> +	union starfive_hash_csr csr;
>> +
>> +	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
>> +
>> +	alg_cr.v = 0;
>> +	alg_cr.clear = 1;
>> +
>> +	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
>> +
>> +	csr.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
>> +	csr.firstb = 0;
>> +	csr.final = 1;
>> +
>> +	reinit_completion(&cryp->hash_done);
>> +	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
>> +	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
>> +}
> 
> Why are you still using a completion? The callback function should
> invoke the crypto_engine finalize_request call directly.
> 

Hi Herbert,
The hardware requires user to set a 'final' bit after data transfer completed.
This completion is to wait for the interrupt signal from device that the final digest 
has been populated to the read registers.

I'll do the finalize_request call directly in the next version.

>> +static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
>> +{
>> +	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
>> +	struct starfive_cryp_dev *cryp = ctx->cryp;
>> +	int ret;
>> +
>> +	rctx->csr.hash.v = 0;
>> +	rctx->csr.hash.reset = 1;
>> +	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
>> +
>> +	if (starfive_hash_wait_busy(ctx))
>> +		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
>> +
>> +	rctx->csr.hash.v = 0;
>> +	rctx->csr.hash.mode = ctx->hash_mode & STARFIVE_HASH_MODE_MASK;
>> +	rctx->csr.hash.ie = 1;
>> +
>> +	if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS) {
>> +		ret = starfive_hash_hmac_key(ctx);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		rctx->csr.hash.start = 1;
>> +		rctx->csr.hash.firstb = 1;
>> +		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
>> +	}
>> +
>> +	ret = starfive_hash_xmit_dma(ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!wait_for_completion_timeout(&cryp->hash_done, msecs_to_jiffies(10000)))
>> +		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Timeout waiting for hash done\n");
> 
> There is no point in waiting for completion.  Just return 0 and
> you're done.
> 

I'll change this in the next version too.

Thanks for taking time reviewing this patch.

Best regards,
Jia Jie

