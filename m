Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEE69BACE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBRP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 10:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:57:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FF1717E;
        Sat, 18 Feb 2023 07:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2EB44CE32D3;
        Sat, 18 Feb 2023 15:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D167C4339B;
        Sat, 18 Feb 2023 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676735831;
        bh=ZeC2BrAHMzTNQu4Ad1PbQlNWapR/3luIWA6SiQG14ZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gHzM1E5lfvJTrIUmSxn9Lwml8CJL6gxKuF2K47U38X1ZU1AT3Al5pPVvO3cegN9zl
         41LEEc9xXdqsGqA6ZcEqP2RSt2qdE8su9LdM0tVeOQ/x6QjAoGMY3KOFfQk2muZgMw
         3WD3nwjoXrUFnrhYZE2IJuzBXOXA05wCSbPEtYRUNlpF45yBOsAKgnhY5wAymaOcoB
         njjjegCZuL9pp6VXeSQolO6gLkME9iEN2W7VlaFL1M9hCdVzOySIaPEaio87QCrI6X
         zAIjQ8qAoGNohe7PUXAoWgNFa7EPCuLvCRv71nhEGC116v48jUCBvou6+CW2ZoVJSw
         RNW93zpyR0W7g==
Date:   Sat, 18 Feb 2023 16:11:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     wens@csie.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH v6 2/2] iio: adc: axp20x_adc: Replace adc_en2
 flag with adc_en2_mask field
Message-ID: <20230218161130.126fe7f8@jic23-huawei>
In-Reply-To: <20230217153404.32481-2-aidanmacdonald.0x0@gmail.com>
References: <20230217153404.32481-1-aidanmacdonald.0x0@gmail.com>
        <20230217153404.32481-2-aidanmacdonald.0x0@gmail.com>
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

On Fri, 17 Feb 2023 15:34:04 +0000
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The adc_en2 flag is essentially specific to axp20x-compatible devices
> because it hardcodes register values. Replace it with a mask field
> so the register value can be specified in device match data.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> This is a resend of a preparatory patch from a larger series adding support
> for the AXP192 PMIC[1]. Since I don't think there's much hope of getting it
> merged in one development cycle, there's no point letting these cleanups sit
> around unapplied -- apply them whenever convienient!
> 
> [1] https://lore.kernel.org/all/20221016234335.904212-1-aidanmacdonald.0x0@gmail.com/
Both applied to the togreg branch of iio.git, however we are to late
to hit this cycle, so these are queued up for next one and I'll only
push them out as testing until I can rebase on rc1.

Thanks,

Jonathan

> 
> ---
>  drivers/iio/adc/axp20x_adc.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index ab25e6e1ff65..75bda94dbce1 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -623,9 +623,9 @@ struct axp_data {
>  	int				num_channels;
>  	struct iio_chan_spec const	*channels;
>  	unsigned long			adc_en1_mask;
> +	unsigned long			adc_en2_mask;
>  	int				(*adc_rate)(struct axp20x_adc_iio *info,
>  						    int rate);
> -	bool				adc_en2;
>  	struct iio_map			*maps;
>  };
>  
> @@ -634,8 +634,8 @@ static const struct axp_data axp20x_data = {
>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
>  	.channels = axp20x_adc_channels,
>  	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
> +	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
>  	.adc_rate = axp20x_adc_rate,
> -	.adc_en2 = true,
>  	.maps = axp20x_maps,
>  };
>  
> @@ -645,7 +645,6 @@ static const struct axp_data axp22x_data = {
>  	.channels = axp22x_adc_channels,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp22x_adc_rate,
> -	.adc_en2 = false,
>  	.maps = axp22x_maps,
>  };
>  
> @@ -655,7 +654,6 @@ static const struct axp_data axp813_data = {
>  	.channels = axp813_adc_channels,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp813_adc_rate,
> -	.adc_en2 = false,
>  	.maps = axp22x_maps,
>  };
>  
> @@ -713,10 +711,10 @@ static int axp20x_probe(struct platform_device *pdev)
>  	/* Enable the ADCs on IP */
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
>  
> -	if (info->data->adc_en2)
> -		/* Enable GPIO0/1 and internal temperature ADCs */
> +	if (info->data->adc_en2_mask)
>  		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> -				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +				   info->data->adc_en2_mask,
> +				   info->data->adc_en2_mask);
>  
>  	/* Configure ADCs rate */
>  	info->data->adc_rate(info, 100);
> @@ -741,7 +739,7 @@ static int axp20x_probe(struct platform_device *pdev)
>  fail_map:
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>  
> -	if (info->data->adc_en2)
> +	if (info->data->adc_en2_mask)
>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>  
>  	return ret;
> @@ -757,7 +755,7 @@ static int axp20x_remove(struct platform_device *pdev)
>  
>  	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>  
> -	if (info->data->adc_en2)
> +	if (info->data->adc_en2_mask)
>  		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>  
>  	return 0;

