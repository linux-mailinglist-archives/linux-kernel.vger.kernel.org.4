Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070C46759EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjATQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjATQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC66E40E;
        Fri, 20 Jan 2023 08:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD7E6B82915;
        Fri, 20 Jan 2023 16:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FFC4339C;
        Fri, 20 Jan 2023 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674232096;
        bh=9/RPi6pw/xT0UDVDrxKzKczKe5NeWC2HStFjAAbJdwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a05c2Oiwc60gejDflrrUiHDnmFq+dGW+gEGrdZf46xm0VB3gv/xVALs2UKSsIpZw+
         MB/YZ7eo4j1tOtfI17S4joyKCdFodVzc07PrRkDyUFZeb+HoGEvjHFQBISERlLKATj
         eYF7hlDE6mpF0dbIP4N05E5vaNfapDfNtxSpRZAZ0/xeG5+1vcRgNJSyJr3tvprg67
         wWeB/EhC97VCNLhwtqQOCaUT84dc6CS9vE76Ub4QxnoD7e3cJqDdWYDt2maSXUe+fI
         Uc0dvRgO6jTvYixqvLCvu/OnNAUZqkSAkX0hwUWokq2aQ0UZgRBF9XBfsx1Jq482cP
         qQPwdTDJavRPA==
Date:   Fri, 20 Jan 2023 16:28:09 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 05/10] mfd: rk808: split into core and i2c
Message-ID: <Y8rBGdddgjTfm/gU@google.com>
References: <20230109172723.60304-1-sebastian.reichel@collabora.com>
 <20230109172723.60304-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109172723.60304-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Sebastian Reichel wrote:

> Split rk808 into a core and an i2c part in preperation for
> SPI support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/Kconfig                   |   2 +-
>  drivers/input/misc/Kconfig            |   2 +-
>  drivers/mfd/Kconfig                   |   7 +-
>  drivers/mfd/Makefile                  |   3 +-
>  drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
>  drivers/mfd/rk8xx-i2c.c               | 209 ++++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig               |   2 +-
>  drivers/power/supply/Kconfig          |   2 +-
>  drivers/regulator/Kconfig             |   2 +-
>  drivers/rtc/Kconfig                   |   2 +-
>  include/linux/mfd/rk808.h             |   6 +
>  sound/soc/codecs/Kconfig              |   2 +-
>  12 files changed, 265 insertions(+), 183 deletions(-)
>  rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
>  create mode 100644 drivers/mfd/rk8xx-i2c.c

[...]

> diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
> new file mode 100644
> index 000000000000..7babb0e1e64c
> --- /dev/null
> +++ b/drivers/mfd/rk8xx-i2c.c

[...]

> +static int rk8xx_i2c_get_variant(struct i2c_client *client)
> +{
> +	u8 pmic_id_msb, pmic_id_lsb;
> +	int msb, lsb;
> +
> +	if (of_device_is_compatible(client->dev.of_node, "rockchip,rk817") ||
> +	    of_device_is_compatible(client->dev.of_node, "rockchip,rk809")) {
> +		pmic_id_msb = RK817_ID_MSB;
> +		pmic_id_lsb = RK817_ID_LSB;
> +	} else {
> +		pmic_id_msb = RK808_ID_MSB;
> +		pmic_id_lsb = RK808_ID_LSB;
> +	}

Appreciate that this is probably old code, but it would be better do to
device matching with OF match.

> +	/* Read chip variant */
> +	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
> +	if (msb < 0)
> +		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
> +
> +	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
> +	if (lsb < 0)
> +		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
> +
> +	return ((msb << 8) | lsb) & RK8XX_ID_MSK;

So this device provides the ability to dynamically read the chip IDs,
but in order to do so, you need to know what chip you're operating on?
Why wouldn't they always put the chip IDs in the same place!  I
understand this is just the variant, but still ...

> +static int rk8xx_i2c_probe(struct i2c_client *client)
> +{
> +	const struct regmap_config *regmap_cfg;
> +	struct regmap *regmap;
> +	int variant;
> +
> +	variant = rk8xx_i2c_get_variant(client);
> +	if (variant < 0)
> +		return variant;
> +
> +	switch (variant) {
> +	case RK805_ID:
> +		regmap_cfg = &rk805_regmap_config;
> +		break;
> +	case RK808_ID:
> +		regmap_cfg = &rk808_regmap_config;
> +		break;
> +	case RK818_ID:
> +		regmap_cfg = &rk818_regmap_config;
> +		break;
> +	case RK809_ID:
> +	case RK817_ID:
> +		regmap_cfg = &rk817_regmap_config;
> +		break;
> +	default:
> +		return dev_err_probe(&client->dev, -EINVAL, "Unsupported RK8XX ID %x\n", variant);
> +	}

All of this stuff could be passed through the OF match API.

> +
> +	regmap = devm_regmap_init_i2c(client, regmap_cfg);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	return rk8xx_probe(&client->dev, variant, client->irq, regmap);
> +}
> +
> +static void rk8xx_i2c_shutdown(struct i2c_client *client)
> +{
> +	rk8xx_shutdown(&client->dev);
> +}
> +
> +static int __maybe_unused rk8xx_i2c_suspend(struct device *dev)
> +{
> +	return rk8xx_suspend(dev);
> +}
> +
> +static int __maybe_unused rk8xx_i2c_resume(struct device *dev)
> +{
> +	return rk8xx_resume(dev);
> +}
> +static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_i2c_suspend, rk8xx_i2c_resume);

Why not place the exported functions straight into the MACRO?

> +static const struct of_device_id rk8xx_i2c_of_match[] = {
> +	{ .compatible = "rockchip,rk805" },
> +	{ .compatible = "rockchip,rk808" },
> +	{ .compatible = "rockchip,rk809" },
> +	{ .compatible = "rockchip,rk817" },
> +	{ .compatible = "rockchip,rk818" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
> +
> +static struct i2c_driver rk8xx_i2c_driver = {
> +	.driver = {
> +		.name = "rk8xx-i2c",
> +		.of_match_table = rk8xx_i2c_of_match,
> +		.pm = &rk8xx_i2c_pm_ops,
> +	},
> +	.probe_new = rk8xx_i2c_probe,
> +	.shutdown  = rk8xx_i2c_shutdown,
> +};
> +module_i2c_driver(rk8xx_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> +MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
> +MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
> +MODULE_DESCRIPTION("RK8xx I2C PMIC driver");

-- 
Lee Jones [李琼斯]
