Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A16DB192
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDGRZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDGRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF66902D;
        Fri,  7 Apr 2023 10:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268456113C;
        Fri,  7 Apr 2023 17:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE244C433EF;
        Fri,  7 Apr 2023 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680888336;
        bh=cTTdB6NCLVLo4ZehJfgOciAyyVOrerLqoUBKgwJchI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NnOrdl4FWC/G0lcBBkLoW5X8TYbsDYQcdN7xVap5xGGTkXsKlF8eV5Q6h448nv3II
         AGrhBk3fmEacGy3GiXkdaDN9c3SOPQhBDyNRAvXuwyarM+d7LevCM1RZYPsgbMxhHB
         0vvGY8O/M7w7VOJ2KA4GcPsJyZK8IyxP+CC1YXOcd447Ii7UP8gDqxAhPaJ4xZxsJP
         Zk1XrfGKUFV7as33DEZU0lz5hyr5jdBQMsdzYs2R2Rin1irexKxYV9k2m2ziQJ7+XR
         LQWfCmqg34+JI2SHCIdJuUc0HSs9b88vnXLes/livvBFcVI/c/JYMTsdkRbh7bzn1R
         I+Y4IN4A+miHg==
Date:   Fri, 7 Apr 2023 18:40:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: mcp4922: add support for mcp48xx series
 chips
Message-ID: <20230407184052.2315dd57@jic23-huawei>
In-Reply-To: <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
        <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 16:01:14 +0200
Nicolas Frattaroli <frattaroli.nicolas@gmail.com> wrote:

> The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822
> DACs are analogous to their MCP49XX counterparts, but contain
> an internal 2.048V voltage reference. Add support for them by
> refactoring the driver to allow for chips without a vref supply,
> and add the necessary device IDs.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  drivers/iio/dac/mcp4922.c | 112 ++++++++++++++++++++++++++++----------
>  1 file changed, 84 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index 0b9458cbbcff..56dcb90c8464 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -3,7 +3,8 @@
>   * mcp4922.c
>   *
>   * Driver for Microchip Digital to Analog Converters.
> - * Supports MCP4902, MCP4912, and MCP4922.
> + * Supports MCP4902, MCP4912, MCP4921, MCP4922, MCP4801, MCP4802, MCP4811,
> + * MCP4812, MCP4821, and MCP4822.
>   *
>   * Copyright (c) 2014 EMAC Inc.
>   */
> @@ -16,14 +17,21 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/bitops.h>
>  
> -#define MCP4922_NUM_CHANNELS	2
> -#define MCP4921_NUM_CHANNELS	1
> +#define MCP4922_NUM_CHANNELS		2
> +#define MCP4921_NUM_CHANNELS		1
> +#define MCP48XX_INTERNAL_VREF_MV	2048
>  
>  enum mcp4922_supported_device_ids {
>  	ID_MCP4902,
>  	ID_MCP4912,
>  	ID_MCP4921,
>  	ID_MCP4922,
> +	ID_MCP4801,

Numeric order preferred.

> +	ID_MCP4802,
> +	ID_MCP4811,
> +	ID_MCP4812,
> +	ID_MCP4821,
> +	ID_MCP4822,
>  };
>  
>  struct mcp4922_state {
> @@ -50,6 +58,35 @@ struct mcp4922_state {
>  	},						\
>  }
>  
> +static bool mcp4922_needs_vref(int device_id)
> +{
> +	switch (device_id) {
> +	case ID_MCP4902:
> +	case ID_MCP4912:
> +	case ID_MCP4921:
> +	case ID_MCP4922:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int mcp4922_num_channels(int device_id)
> +{
> +	switch (device_id) {
> +	case ID_MCP4902:
> +	case ID_MCP4912:
> +	case ID_MCP4922:
> +	case ID_MCP4802:
> +	case ID_MCP4812:
> +	case ID_MCP4822:
> +		return MCP4922_NUM_CHANNELS;

I'd rather see this as an actual number as the define is just reducing
readability in this particular case.

> +	default:
> +		return MCP4921_NUM_CHANNELS;
> +	}
> +
> +}
> +
>  static int mcp4922_spi_write(struct mcp4922_state *state, u8 addr, u32 val)
>  {
>  	state->mosi[1] = val & 0xff;
> @@ -108,11 +145,17 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
> +static const struct iio_chan_spec mcp4922_channels[10][MCP4922_NUM_CHANNELS] = {
>  	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
>  	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
>  	[ID_MCP4921] = { MCP4922_CHAN(0, 12),	{} },
>  	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
> +	[ID_MCP4801] = { MCP4922_CHAN(0, 8),	{} },

Numeric order preferred. 

> +	[ID_MCP4802] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
> +	[ID_MCP4811] = { MCP4922_CHAN(0, 10),	{} },
> +	[ID_MCP4812] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
> +	[ID_MCP4821] = { MCP4922_CHAN(0, 12),	{} },
> +	[ID_MCP4822] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
>  };
>  
>  static const struct iio_info mcp4922_info = {
> @@ -133,25 +176,31 @@ static int mcp4922_probe(struct spi_device *spi)
>  
>  	state = iio_priv(indio_dev);
>  	state->spi = spi;
> -	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
> -	if (IS_ERR(state->vref_reg))
> -		return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
> -				     "Vref regulator not specified\n");
> +	id = spi_get_device_id(spi);
> +	if (mcp4922_needs_vref(id->driver_data)) {
> +		state->vref_reg = devm_regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(state->vref_reg))
> +			return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
> +					"Vref regulator not specified\n");
>  
> -	ret = regulator_enable(state->vref_reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
> -				ret);
> -		return ret;
> -	}
> +		ret = regulator_enable(state->vref_reg);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
> +					ret);
> +			return ret;
> +		}

If you add a devm_add_action_or_reset() and a suitable callback function to
turn the regulator off again, you can avoid any need for special handing in
remove path.  The callback will only get called if were in this block of
code anyway and hence there is something to turn off.

>  
> -	ret = regulator_get_voltage(state->vref_reg);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
> -				ret);
> -		goto error_disable_vref_reg;
> +		ret = regulator_get_voltage(state->vref_reg);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
> +					ret);
> +			goto error_disable_vref_reg;
> +		}
> +		state->vref_mv = ret / 1000;
> +	} else {
> +		state->vref_mv = MCP48XX_INTERNAL_VREF_MV;
>  	}
> -	state->vref_mv = ret / 1000;
> +

Avoid unrelated white space changes

>  
>  	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");

>  
>  static const struct spi_device_id mcp4922_id[] = {
> @@ -209,6 +259,12 @@ static const struct spi_device_id mcp4922_id[] = {
>  	{"mcp4912", ID_MCP4912},
>  	{"mcp4921", ID_MCP4921},
>  	{"mcp4922", ID_MCP4922},
> +	{"mcp4801", ID_MCP4801},

I'd prefer this table to be in numeric order.

> +	{"mcp4802", ID_MCP4802},
> +	{"mcp4811", ID_MCP4811},
> +	{"mcp4812", ID_MCP4812},
> +	{"mcp4821", ID_MCP4821},
> +	{"mcp4822", ID_MCP4822},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, mcp4922_id);
> @@ -224,5 +280,5 @@ static struct spi_driver mcp4922_driver = {
>  module_spi_driver(mcp4922_driver);
>  
>  MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
> -MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
> +MODULE_DESCRIPTION("Microchip MCP49XX and MCP48XX DAC");
>  MODULE_LICENSE("GPL v2");

