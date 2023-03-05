Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F956AAF27
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCEKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCEKrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA410248;
        Sun,  5 Mar 2023 02:47:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F07B560AED;
        Sun,  5 Mar 2023 10:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0986C433EF;
        Sun,  5 Mar 2023 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678013231;
        bh=/c07qRM2x9b8dlpY7RT/f76aF+pTlnxCftn2bjFKDKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqIaf5Gp7UnM3q+l2vSIqVugZQ1uytBzC51mpClyyp2f8RX4XUhpBK74vubf7PsZ9
         4fKktH2eCXXqVSHEzqaVz4gO3/ESsv7P0oi02HmrcUC2yRC+I/arye0isYvgRMX/4+
         VImIa7qhSIlkv1SRY+UbfSVYDwqKeUKC+CZDLXt1RKsMddaUP0PuGnMwZ7RVS8pOkq
         7ddVxqkyaROoRx9xsd1mAIHhn3egegNyjVUKCrchRUg3R6V1Qy4PMhI1NTuVEyleSd
         D1MurtSpGMsAouqNRivX6NPVkiF1GNCRcSvoHtfwkK1WzmPe1i0e2DaadLMbUpMGFU
         G6byNQhDx5h2w==
Date:   Sun, 5 Mar 2023 10:47:04 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 02/10] mfd: rt5033: Fix chip revision readout
Message-ID: <20230305104704.GG2574592@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a667a64d0cbeef00baed2d4b117ba9f50eaf3988.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a667a64d0cbeef00baed2d4b117ba9f50eaf3988.1677620677.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Jakob Hauser wrote:

> After reading the data from the DEVICE_ID register, mask 0x0f needs to be
> applied to extract the revision of the chip [1].
> 
> The other part of the DEVICE_ID register, mask 0xf0, is a vendor identification
> code. That's how it is set up at similar products of Richtek, e.g. RT9455 [2]
> page 21 top.
> 
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L484
> [2] https://www.richtek.com/assets/product_file/RT9455/DS9455-00.pdf
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/mfd/rt5033.c               | 8 +++++---
>  include/linux/mfd/rt5033-private.h | 4 ++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> index 8029d444b794..d32467174cb5 100644
> --- a/drivers/mfd/rt5033.c
> +++ b/drivers/mfd/rt5033.c
> @@ -55,7 +55,8 @@ static const struct regmap_config rt5033_regmap_config = {
>  static int rt5033_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct rt5033_dev *rt5033;
> -	unsigned int dev_id;
> +	unsigned int data;

In terms of nomenclature, this is a regression.

'data' is a terrible variable name.  Why not keep it as-is?

> +	unsigned int chip_rev;
>  	int ret;
>  
>  	rt5033 = devm_kzalloc(&i2c->dev, sizeof(*rt5033), GFP_KERNEL);
> @@ -73,12 +74,13 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
>  		return PTR_ERR(rt5033->regmap);
>  	}
>  
> -	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &dev_id);
> +	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &data);
>  	if (ret) {
>  		dev_err(&i2c->dev, "Device not found\n");
>  		return -ENODEV;
>  	}
> -	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
> +	chip_rev = data & RT5033_CHIP_REV_MASK;
> +	dev_info(&i2c->dev, "Device found (rev. %d)\n", chip_rev);

Why not print both?

>  	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
>  			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
> index 2d1895c3efbf..d18cd4572208 100644
> --- a/include/linux/mfd/rt5033-private.h
> +++ b/include/linux/mfd/rt5033-private.h
> @@ -71,6 +71,10 @@ enum rt5033_reg {














g
>  /* RT5033 CHGCTRL2 register */
>  #define RT5033_CHGCTRL2_CV_MASK		0xfc
>  
> +/* RT5033 DEVICE_ID register */
> +#define RT5033_VENDOR_ID_MASK		0xf0
> +#define RT5033_CHIP_REV_MASK		0x0f
> +
>  /* RT5033 CHGCTRL3 register */
>  #define RT5033_CHGCTRL3_CFO_EN_MASK	0x40
>  #define RT5033_CHGCTRL3_TIMER_MASK	0x38
> -- 
> 2.39.1
> 

-- 
Lee Jones [李琼斯]
