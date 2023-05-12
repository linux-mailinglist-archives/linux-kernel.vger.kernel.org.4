Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66111700F25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbjELTDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbjELTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:03:13 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2602D48
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:03:11 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id a2075948-f0f7-11ed-a9de-005056bdf889;
        Fri, 12 May 2023 22:03:09 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 12 May 2023 22:03:08 +0300
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] spi: cs42l43: Add SPI controller support
Message-ID: <ZF6NbHVD4ay2S83R@surfacebook>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-10-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122838.243002-10-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 12, 2023 at 01:28:37PM +0100, Charles Keepax kirjoitti:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> The SPI component incorporates a SPI controller interface for
> communication with other peripheral components.

...

> +#define CS42L43_SPI_ROOT_HZ		40000000

HZ_PER_MHZ?

...

> +		const u8 *block = min_t(const u8 *, buf + CS42L43_FIFO_SIZE, end);

Wouldn't min() work?

...

> +		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32))
> +			regmap_write(regmap, CS42L43_TX_DATA, *(const u32 *)buf);

This casting might be potentially wrong taking alignment into consideration.
Perhaps you need get_unaligned(). Also here the return value isn't checked,
while in the read it is.

...

> +		const u8 *block = min_t(const u8 *, buf + CS42L43_FIFO_SIZE, end);

min() ?

...

> +		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32)) {
> +			ret = regmap_read(regmap, CS42L43_RX_DATA, (u32 *)buf);

put_unaligned() ?

> +			if (ret)
> +				return ret;
> +		}

...

> +static int cs42l43_prepare_transfer_hardware(struct spi_controller *ctlr)
> +{
> +	struct cs42l43_spi *priv = spi_controller_get_devdata(ctlr);
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, CS42L43_BLOCK_EN2, CS42L43_SPI_MSTR_EN_MASK);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to enable SPI controller: %d\n", ret);

> +		return ret;
> +	}
> +
> +	return 0;

	return ret; ?

> +}
> +
> +static int cs42l43_unprepare_transfer_hardware(struct spi_controller *ctlr)
> +{
> +	struct cs42l43_spi *priv = spi_controller_get_devdata(ctlr);
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, CS42L43_BLOCK_EN2, 0);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to disable SPI controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;

Ditto.

> +}

...

> +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
> +		priv->ctlr->dev.fwnode =
> +			fwnode_get_named_child_node(dev_fwnode(cs42l43->dev), "spi");
> +		priv->ctlr->dev.of_node = to_of_node(dev_fwnode(&priv->ctlr->dev));
> +	} else {
> +		priv->ctlr->dev.fwnode = dev_fwnode(priv->dev);
> +	}

Can you use device_set_node() once you have an fwnode that needs to be passed?

...

> +	priv->ctlr->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL;

SPI_MODE_X_MASK

...

> +static struct platform_driver cs42l43_spi_driver = {
> +	.driver = {
> +		.name	= "cs42l43-spi",
> +	},

> +

Unneeded blank line.

> +	.probe		= cs42l43_spi_probe,
> +	.remove		= cs42l43_spi_remove,
> +};

-- 
With Best Regards,
Andy Shevchenko


