Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A286DB158
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDGRO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDGROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E776A5CB;
        Fri,  7 Apr 2023 10:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC3D652DC;
        Fri,  7 Apr 2023 17:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40FC433EF;
        Fri,  7 Apr 2023 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680887659;
        bh=mTjUkJHoStDJ71hbzUhqyq+k2a+V8FszEAxAcLGiYWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aSGMFG98DXYw1cTVW5PzUBQ0l55Y85Qgsiay2RUWlJehbqwgVynC0iwEp/6qvTY8+
         KAGGQoffpOVP23UE8Y7GcKbHd8cche03jj118059pctdckzCtY+ygaWb/B8qTRdh5a
         PSY5x5S/dW16H4g9qL57UdojQXRjjNTx5tqrRmqBEMo53aG6m1DqnZYr6b4Fe+jjez
         b83olozb9+YdaqqwiyIShCzPHQN2bK3RC+DbHAi05/rW6gvfq5vJ+2eALhllSUBlH7
         FoGbR05ust3wg2sfeuL7GBKk4IGTLi4OfWQGPgcAsoNsgIVxtlSZbnf8nr4EwyQsoR
         golPKZe7UYtKw==
Date:   Fri, 7 Apr 2023 18:29:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <peterwu.pub@gmail.com>,
        <cy_huang@richtek.com>
Subject: Re: [PATCH v2] iio: adc: mt6370: Fix ibus and ibat scaling value of
 some specific vendor ID chips
Message-ID: <20230407182934.271cbfe4@jic23-huawei>
In-Reply-To: <1680750531-29365-1-git-send-email-chiaen_wu@richtek.com>
References: <1680750531-29365-1-git-send-email-chiaen_wu@richtek.com>
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

On Thu, 6 Apr 2023 11:08:51 +0800
ChiaEn Wu <chiaen_wu@richtek.com> wrote:

> The scale value of ibus and ibat on the datasheet is incorrect due to the
> customer report after the experimentation with some specific vendor ID
> chips.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

Hi,

Please give a fixes tag to aid backporting to right stable branches.

A minor formatting suggestion inline.  Otherwise looks fine to me.

Thanks,

Jonathan


> ---
> v2:
> - Move 'get_vendor_info' after iio_priv allocation done
> - For the special case, bypass indent, make it out-of-line
> - For a simple return, add a blank line
> - Drop else
> ---
>  drivers/iio/adc/mt6370-adc.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
> index bc62e5a..ae5cdff 100644
> --- a/drivers/iio/adc/mt6370-adc.c
> +++ b/drivers/iio/adc/mt6370-adc.c
> @@ -19,6 +19,7 @@
>  
>  #include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
>  
> +#define MT6370_REG_DEV_INFO		0x100
>  #define MT6370_REG_CHG_CTRL3		0x113
>  #define MT6370_REG_CHG_CTRL7		0x117
>  #define MT6370_REG_CHG_ADC		0x121
> @@ -27,6 +28,7 @@
>  #define MT6370_ADC_START_MASK		BIT(0)
>  #define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
>  #define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
> +#define MT6370_VENID_MASK		GENMASK(7, 4)
>  
>  #define MT6370_AICR_100_mA		0x0
>  #define MT6370_AICR_150_mA		0x1
> @@ -47,6 +49,10 @@
>  #define ADC_CONV_TIME_MS		35
>  #define ADC_CONV_POLLING_TIME_US	1000
>  
> +#define MT6370_VID_RT5081		0x8
> +#define MT6370_VID_RT5081A		0xA
> +#define MT6370_VID_MT6370		0xE
> +
>  struct mt6370_adc_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -55,6 +61,7 @@ struct mt6370_adc_data {
>  	 * from being read at the same time.
>  	 */
>  	struct mutex adc_lock;
> +	unsigned int vid;
>  };
>  
>  static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
> @@ -98,6 +105,22 @@ static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
>  	return ret;
>  }
>  
> +static int mt6370_adc_get_ibus_scale(struct mt6370_adc_data *priv)
> +{
> +	if (priv->vid == MT6370_VID_RT5081  || priv->vid == MT6370_VID_RT5081A || priv->vid == MT6370_VID_MT6370)
> +		return 3350;
> +
> +	return 3875;
> +}
> +
> +static int mt6370_adc_get_ibat_scale(struct mt6370_adc_data *priv)
> +{
> +	if (priv->vid == MT6370_VID_RT5081  || priv->vid == MT6370_VID_RT5081A || priv->vid == MT6370_VID_MT6370)
Line too long.  You could wrap it, but perhaps even better to just make this a switch
statement as that will be easier to enhance if we have more cases in future without
a lot of churn.

	switch (priv->vid) {
	case MT6370_VID_RT5081:
	case MT6370_VID_RT5081A:
	case MT6370_VID_RT6370:
		return 2680;
	default:
		return 3870; 
	}

Same for the other similar case above.

> +		return 2680;
> +
> +	return 3870;
> +}
> +
>  static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  				 int chan, int *val1, int *val2)
>  {
> @@ -123,7 +146,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  		case MT6370_AICR_250_mA:
>  		case MT6370_AICR_300_mA:
>  		case MT6370_AICR_350_mA:
> -			*val1 = 3350;
> +			*val1 = mt6370_adc_get_ibus_scale(priv);
>  			break;
>  		default:
>  			*val1 = 5000;
> @@ -150,7 +173,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
>  		case MT6370_ICHG_600_mA:
>  		case MT6370_ICHG_700_mA:
>  		case MT6370_ICHG_800_mA:
> -			*val1 = 2680;
> +			*val1 = mt6370_adc_get_ibat_scale(priv);
>  			break;
>  		default:
>  			*val1 = 5000;
> @@ -251,6 +274,20 @@ static const struct iio_chan_spec mt6370_adc_channels[] = {
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
> +
> +	return 0;
> +}
> +
>  static int mt6370_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -272,6 +309,10 @@ static int mt6370_adc_probe(struct platform_device *pdev)
>  	priv->regmap = regmap;
>  	mutex_init(&priv->adc_lock);
>  
> +	ret = mt6370_get_vendor_info(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get vid\n");
> +
>  	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to reset ADC\n");

