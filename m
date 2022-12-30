Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58168659B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiL3SgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiL3SgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:36:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E4193D7;
        Fri, 30 Dec 2022 10:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A01BCCE175F;
        Fri, 30 Dec 2022 18:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E79C433D2;
        Fri, 30 Dec 2022 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672425371;
        bh=t1Ep3yE+UPYrmEucrzGo/7bQGiZxo5BU23bcF+bvORk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kmYRJKzn3xxwMicF8I1GP7IgQHU9NSLi6GTw1btUsR5O3yLIxsI9FoJHp1Y8aAVGu
         CwsEdEMhHJJs4sSymYQj2qfq180Rt2TKtHSzha25NzRaflX0z50aMLT7asfRMbH3Dp
         h43CKLzS2adP5YLpKtnAiaAzJxx8rL5mMPQrKpxBTcB2P3uGN+o6jERyUF/PepY5Uw
         ++sh75Yse3UtuzPhkZgRH2I2cLp/cbm6dBWP/w6On3hZOo3iHBd/QCYs0YNyL4U+kn
         bWXP4HiMKxOYcnA+4brrpfD7hAYha+tf2S7GEBKUxAenipSDQEa29uCiQPKX+YUyYS
         miVUdTeRcITFw==
Date:   Fri, 30 Dec 2022 18:49:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Add nvmem operations for
 BMP580
Message-ID: <20221230184928.011a7851@jic23-huawei>
In-Reply-To: <92664164d24cbd9c6541cdbd73b163dbf964ab68.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <92664164d24cbd9c6541cdbd73b163dbf964ab68.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 15:29:24 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> The pressure sensor BMP580 contains a non-volatile memory that stores
> trimming and configuration params. That memory provides an programmable
> user range of three 2-byte words.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Not much in this one from me other than follow on from earlier patch.
Thanks,

Jonathan

> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 44901c6eb2f9..578d145be55d 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -28,6 +28,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> @@ -1628,8 +1629,140 @@ static const int bmp580_odr_table[][2] = {
>  	[BMP580_ODR_0_125HZ] =	{0, 125000},
>  };
>  
> +const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
> +
> +static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct bmp280_data *data = priv;
> +	u16 *dst = val;
> +	int ret, addr;
> +
> +	pm_runtime_get_sync(data->dev);
> +	mutex_lock(&data->lock);
> +
> +	/* Set sensor in standby mode */
> +	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
> +				 BMP580_ODR_DEEPSLEEP_DIS |
> +				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
> +	if (ret) {
> +		dev_err(data->dev, "failed to change sensor to standby mode\n");
> +		goto exit;
> +	}
> +	/* Wait standby transition time */
> +	usleep_range(2500, 3000);
> +
> +	while (bytes >= sizeof(u16)) {
> +		addr = bmp580_nvmem_addrs[offset / sizeof(u16)];
> +
> +		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
> +				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
> +		if (ret) {
> +			dev_err(data->dev, "error writing nvm address\n");
> +			goto exit;
> +		}
> +
> +		ret = bmp580_cmd(data, BMP580_NVM_READ_CMD);
Ah. Here is the command being used.  Good to pull that code forwards to this patch.

> +		if (ret)
> +			goto exit;
> +
> +		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
> +				       sizeof(data->le16));
> +		if (ret) {
> +			dev_err(data->dev, "error reading nvm data regs\n");
> +			goto exit;
> +		}
> +
> +		*dst++ = le16_to_cpu(data->le16);
> +		bytes -= sizeof(u16);

sizeof(le16) seems more appropriate (obviously it's the same value).

> +		offset += sizeof(u16);
> +	}
> +exit:
> +	/* Restore chip config */
> +	data->chip_info->chip_config(data);
> +	mutex_unlock(&data->lock);
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +
> +static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct bmp280_data *data = priv;
> +	u16 *buf = val;
> +	int ret, addr;
> +
> +	pm_runtime_get_sync(data->dev);
> +	mutex_lock(&data->lock);
> +
> +	/* Set sensor in standby mode */
> +	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
> +				 BMP580_ODR_DEEPSLEEP_DIS |
> +				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
> +	if (ret) {
> +		dev_err(data->dev, "failed to change sensor to standby mode\n");
> +		goto exit;
> +	}
> +	/* Wait standby transition time */
> +	usleep_range(2500, 3000);
> +
> +	while (bytes >= sizeof(u16)) {
> +		addr = bmp580_nvmem_addrs[offset / sizeof(u16)];
> +
> +		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
> +				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
> +		if (ret) {
> +			dev_err(data->dev, "error writing nvm address\n");
> +			goto exit;
> +		}
> +		data->le16 = cpu_to_le16(*buf++);
> +
> +		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
> +					sizeof(data->le16));
> +		if (ret) {
> +			dev_err(data->dev, "error writing LSB NVM data regs\n");
> +			goto exit;
> +		}
> +
> +		ret = bmp580_cmd(data, BMP580_NVM_WRITE_CMD);
> +		if (ret)
> +			goto exit;
> +
> +		/* Disable programming mode bit */
> +		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
> +					 BMP580_NVM_PROG_EN, 0);
> +		if (ret) {
> +			dev_err(data->dev, "error resetting nvm write\n");
> +			goto exit;
> +		}
> +
> +		bytes -= sizeof(u16);

As above, maybe sizeof(le16)

> +		offset += sizeof(u16);
> +	}
> +exit:
> +	/* Restore chip config */
> +	data->chip_info->chip_config(data);
> +	mutex_unlock(&data->lock);
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +


