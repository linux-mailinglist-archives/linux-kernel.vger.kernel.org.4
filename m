Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB77D6A92BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCCImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCCImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:42:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14938B4B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DE06B81732
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD4C433D2;
        Fri,  3 Mar 2023 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677832919;
        bh=azjRvVmh5QtPCcQyst3g1jyvlF46sxpBu2e0AE5jEWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVaxTeb3yBAGDIUfujccZ6x6eaFZwavT6a28sBUFIXrgmgcP9oXs+mwfXMJ022/Yh
         m/zClPKY3KbQMIOSAmYNr74j8LJ9cbrUxR7tvWTJR6kR5hAV0x9O2OCO0UOHT+jCf+
         kMNFLub/+HzdF3j18UusHRMIFxSfh0WW1GetfKg/5aGdSx7/0wCmtIgiSr1YbKF5UH
         0wnVoeCKY4pHaxFauiyy+Q2WaFsjt2bOqbJDYvu+B3sRBEMv8i8yBtnAWe3B8Rm9mx
         RKf1DIliDQMZEARqHL5xpu+cZWZYjMCeI24j4v23R2lyj5MZH+DeIvMnoQN8M8CT7P
         /O3GCeaSDf8GQ==
Date:   Fri, 3 Mar 2023 08:41:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mfd: da9062: Remove IRQ requirement
Message-ID: <20230303084153.GI2303077@google.com>
References: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023, Christoph Niedermaier wrote:

> This patch removes the requirement for an IRQ, because for the core
> functionality IRQ isn't needed. So this makes the DA9061/62 chip
> useable for designs which haven't connected the IRQ pin.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rebase on current next 20230209
>     - Add Lee Jones to Cc list
> ---
>  drivers/mfd/da9062-core.c | 98 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 73 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 40cde51e5719..caa597400dd1 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -212,6 +212,27 @@ static const struct mfd_cell da9061_devs[] = {
>  	},
>  };
>  
> +static const struct mfd_cell da9061_devs_without_irq[] = {

"_noirq"

> +	{
> +		.name		= "da9061-core",
> +	},
> +	{
> +		.name		= "da9062-regulators",
> +	},

Place the one line entries on one line please.

Even better, use MFD_CELL_NAME()

> +	{
> +		.name		= "da9061-watchdog",
> +		.of_compatible  = "dlg,da9061-watchdog",
> +	},

MFD_CELL_OF(<name>, NULL, NULL, NULL, 0, <compatible>);

> +	{
> +		.name		= "da9061-thermal",
> +		.of_compatible  = "dlg,da9061-thermal",
> +	},
> +	{
> +		.name		= "da9061-onkey",
> +		.of_compatible = "dlg,da9061-onkey",
> +	},
> +};
> +
>  static const struct resource da9062_core_resources[] = {
>  	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
>  };
> @@ -288,6 +309,35 @@ static const struct mfd_cell da9062_devs[] = {
>  	},
>  };
>  
> +static const struct mfd_cell da9062_devs_without_irq[] = {
> +	{
> +		.name		= "da9062-core",
> +	},
> +	{
> +		.name		= "da9062-regulators",
> +	},
> +	{
> +		.name		= "da9062-watchdog",
> +		.of_compatible  = "dlg,da9062-watchdog",
> +	},
> +	{
> +		.name		= "da9062-thermal",
> +		.of_compatible  = "dlg,da9062-thermal",
> +	},
> +	{
> +		.name		= "da9062-rtc",
> +		.of_compatible  = "dlg,da9062-rtc",
> +	},
> +	{
> +		.name		= "da9062-onkey",
> +		.of_compatible	= "dlg,da9062-onkey",
> +	},
> +	{
> +		.name		= "da9062-gpio",
> +		.of_compatible	= "dlg,da9062-gpio",
> +	},
> +};

As above.

>  static int da9062_clear_fault_log(struct da9062 *chip)
>  {
>  	int ret;
> @@ -625,7 +675,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
>  	struct da9062 *chip;
> -	unsigned int irq_base;
> +	unsigned int irq_base = 0;
>  	const struct mfd_cell *cell;
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
> @@ -645,21 +695,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
>  	i2c_set_clientdata(i2c, chip);
>  	chip->dev = &i2c->dev;
>  
> -	if (!i2c->irq) {
> -		dev_err(chip->dev, "No IRQ configured\n");
> -		return -EINVAL;
> -	}
> -
>  	switch (chip->chip_type) {
>  	case COMPAT_TYPE_DA9061:
> -		cell = da9061_devs;
> -		cell_num = ARRAY_SIZE(da9061_devs);
> +		cell = i2c->irq ? da9061_devs : da9061_devs_without_irq;
> +		cell_num = i2c->irq ? ARRAY_SIZE(da9061_devs) : ARRAY_SIZE(da9061_devs_without_irq);

This is hideous.

Why not just NULLify the resources below instead?

>  		irq_chip = &da9061_irq_chip;
>  		config = &da9061_regmap_config;
>  		break;
>  	case COMPAT_TYPE_DA9062:
> -		cell = da9062_devs;
> -		cell_num = ARRAY_SIZE(da9062_devs);
> +		cell = i2c->irq ? da9062_devs : da9062_devs_without_irq;
> +		cell_num = i2c->irq ? ARRAY_SIZE(da9062_devs) : ARRAY_SIZE(da9062_devs_without_irq);
>  		irq_chip = &da9062_irq_chip;

Still setting this despite no IRQs?

>  		config = &da9062_regmap_config;
>  		break;
  __
 _||_
 \  /
  \/

[...]

if (i2c->irq <= 0)
  cell->resources = NULL;
  cell->num_resources = 0;

> @@ -695,29 +740,32 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> -	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "Failed to configure IRQ type\n");
> -		return ret;
> -	}
> +	if (i2c->irq) {
> +		ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "Failed to configure IRQ type\n");
> +			return ret;
> +		}
>  
> -	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
> -			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
> -			-1, irq_chip, &chip->regmap_irq);
> -	if (ret) {
> -		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> -			i2c->irq, ret);
> -		return ret;
> -	}
> +		ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
> +				trigger_type | IRQF_SHARED | IRQF_ONESHOT,
> +				-1, irq_chip, &chip->regmap_irq);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> +				i2c->irq, ret);
> +			return ret;
> +		}
>  
> -	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
> +		irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
> +	}
>  
>  	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
>  			      cell_num, NULL, irq_base,
>  			      NULL);
>  	if (ret) {
>  		dev_err(chip->dev, "Cannot register child devices\n");
> -		regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
> +		if (i2c->irq)
> +			regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
>  		return ret;
>  	}
>  
> -- 
> 2.11.0
> 

-- 
Lee Jones [李琼斯]
