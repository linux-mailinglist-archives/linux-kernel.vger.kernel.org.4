Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8196F6C9633
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjCZPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33119BA;
        Sun, 26 Mar 2023 08:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0836D60DE7;
        Sun, 26 Mar 2023 15:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D533C433D2;
        Sun, 26 Mar 2023 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679845262;
        bh=21uEPRsfEI6Bmn4l2Yo3fQlTwIXz1UGKObvRJC3gEzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W8UV2+C20/Ija6ZI/S572nlTDADojVrGdQ31d3VqGtzPothV7yLPpcN73LCcBY9/v
         LBURlPry05C4uENgAOfQjGxzcLpNGk8EksOGlPsJOIRDIsFP/c2j5pbmXTi9WQO2Jm
         Dr9hMyewDKdIwPmgw1sXDfjQo0mnTL/k7Ek1S951FQHLKAUTH/skK1DHc8hTC4GMpX
         +jw/2Shj2oVOANbym7tOoUYtFkYMmDRF4UA/mN19HhKdlQ8Zno+Fp1fPZVmIMhLyV7
         P3KxigVaIZ/uRjRu8+SVaAzGPnEZb6lOdqdFAWFRgXF0U6mpSFK32bj9kqB0Xn8yRu
         Yu31MHVyBCy6g==
Date:   Sun, 26 Mar 2023 16:56:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <peterwu.pub@gmail.com>,
        <cy_huang@richtek.com>
Subject: Re: [PATCH] iio: adc: mt6370: Fix ibus and ibat scaling value of
 some specific vendor ID chips
Message-ID: <20230326165604.27338cc6@jic23-huawei>
In-Reply-To: <1679667167-16261-1-git-send-email-chiaen_wu@richtek.com>
References: <1679667167-16261-1-git-send-email-chiaen_wu@richtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 22:12:47 +0800
ChiaEn Wu <chiaen_wu@richtek.com> wrote:

> The scale value of ibus and ibat on the datasheet is incorrect due to the
> customer report after the experimentation with some specific vendor ID
> chips.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

Hi. Only significant issue here is the one the build bot found.
A few other trivial formatting suggestions inline.

Thanks,

Jonathan


>  
>  static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
> @@ -98,6 +105,26 @@ static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
>  	return ret;
>  }
>  
> +static int mt6370_adc_get_ibus_scale(struct mt6370_adc_data *priv)
> +{
> +	if (priv->vid == MT6370_VID_RT5081  ||
> +	    priv->vid == MT6370_VID_RT5081A ||
> +	    priv->vid == MT6370_VID_MT6370)
> +		return 3350;
> +	else

I'd drop the else.  We are special casing the matches above, so it makes sense
for them to be out of line.  The 'normal' case doesn't need to be indented.

> +		return 3875;
> +}
> +
> +static int mt6370_adc_get_ibat_scale(struct mt6370_adc_data *priv)
> +{
> +	if (priv->vid == MT6370_VID_RT5081  ||
> +	    priv->vid == MT6370_VID_RT5081A ||
> +	    priv->vid == MT6370_VID_MT6370)
> +		return 2680;
> +	else
> +		return 3870;
> +}
> +
>  static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  				 int chan, int *val1, int *val2)
>  {
> @@ -123,7 +150,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  		case MT6370_AICR_250_mA:
>  		case MT6370_AICR_300_mA:
>  		case MT6370_AICR_350_mA:
> -			*val1 = 3350;
> +			*val1 = mt6370_adc_get_ibus_scale(priv);
>  			break;
>  		default:
>  			*val1 = 5000;
> @@ -150,7 +177,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  		case MT6370_ICHG_600_mA:
>  		case MT6370_ICHG_700_mA:
>  		case MT6370_ICHG_800_mA:
> -			*val1 = 2680;
> +			*val1 = mt6370_adc_get_ibat_scale(priv);
>  			break;
>  		default:
>  			*val1 = 5000;
> @@ -251,6 +278,19 @@ static const struct iio_chan_spec mt6370_adc_channels[] = {
>  	MT6370_ADC_CHAN(TEMP_JC, IIO_TEMP, 12, BIT(IIO_CHAN_INFO_OFFSET)),
>  };
>  
> +static int mt6370_get_vendor_info(struct mt6370_adc_data *priv)
> +{
> +	unsigned int dev_info;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &dev_info);
> +	if (ret)
> +		return ret;
> +
> +	priv->vid = FIELD_GET(MT6370_VENID_MASK, dev_info);

Blank line preferred before a simple return like this.  Makes the code a tiny
bit more readable.

> +	return 0;
> +}
> +
>  static int mt6370_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -263,6 +303,10 @@ static int mt6370_adc_probe(struct platform_device *pdev)
>  	if (!regmap)
>  		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
>  
> +	ret = mt6370_get_vendor_info(priv);

The build bot spotted this one.  Can't use priv yet as it doesn't exist
for a few more lines.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get vid\n");
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
>  		return -ENOMEM;

