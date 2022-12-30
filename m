Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D2659B36
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiL3SF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiL3SFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:05:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A41178B5;
        Fri, 30 Dec 2022 10:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE90261B32;
        Fri, 30 Dec 2022 18:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F615C433D2;
        Fri, 30 Dec 2022 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672423522;
        bh=vaaGlDn5lukU30p0UlEvyAPikiJjlJp1zDhTh2mWxt0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Afq9jhn9Prt460DcO60BOhAV+uPWjtgG1eBHLGYEoPpTSXmpPVfvJm9zmQb7sAOs4
         P58zACGP8ffd9K9eabbg4JIMsI1cGqPv0085/iL6f7lEKtqb0yTutVjmaiCxbaW8gC
         MeCkIxA9HkEbxcr1ep4IBngCza0I2SkBHfKI4tn/VZbJo4vVyz+JCCQsuaSx806rp/
         o5EagFMcirteHqIFJRro8XdSVD6deX4dkjFEFKZbY16iPFqNdFxzw6DdqNJEG5HOkb
         iCOC8TOuwVHgVAnLIOIDkzqm2fvop7Y0ivjVX1K8jbGn5NLQ6z1QK8l6BeqF/NRFwQ
         z6YMdDIthOXPw==
Date:   Fri, 30 Dec 2022 18:18:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: pressure: bmp280: Add preinit callback
Message-ID: <20221230181839.43191be2@jic23-huawei>
In-Reply-To: <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
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

On Mon, 26 Dec 2022 15:29:21 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds preinit callback to execute operations on probe before applying
> initial configuration.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 46959a91408f..c37cf2caec68 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -217,6 +217,7 @@ struct bmp280_chip_info {
>  	int (*read_press)(struct bmp280_data *, int *, int *);
>  	int (*read_humid)(struct bmp280_data *, int *, int *);
>  	int (*read_calib)(struct bmp280_data *);
> +	int (*preinit)(struct bmp280_data *);
>  };
>  
>  /*
> @@ -935,6 +936,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
>  	.read_calib = bmp280_read_calib,
> +	.preinit = NULL,
C standard guarantees those are set to NULL anyway + the default is obvious.
Hence don't set them to NULL, just leave the automatic initialization of
unspecified structure elements to handle it for you.

>  };
>  
>  static int bme280_chip_config(struct bmp280_data *data)
> @@ -979,6 +981,7 @@ static const struct bmp280_chip_info bme280_chip_info = {
>  	.read_press = bmp280_read_press,
>  	.read_humid = bmp280_read_humid,
>  	.read_calib = bme280_read_calib,
> +	.preinit = NULL,
>  };
>  
>  /*
> @@ -1220,6 +1223,12 @@ static const int bmp380_odr_table[][2] = {
>  	[BMP380_ODR_0_0015HZ]	= {0, 1526},
>  };
>  
> +static int bmp380_preinit(struct bmp280_data *data)
> +{
> +	/* BMP3xx requires soft-reset as part of initialization */
> +	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> +}
> +
>  static int bmp380_chip_config(struct bmp280_data *data)
>  {
>  	bool change = false, aux;
> @@ -1349,6 +1358,7 @@ static const struct bmp280_chip_info bmp380_chip_info = {
>  	.read_temp = bmp380_read_temp,
>  	.read_press = bmp380_read_press,
>  	.read_calib = bmp380_read_calib,
> +	.preinit = bmp380_preinit,
>  };
>  
>  static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
> @@ -1604,6 +1614,7 @@ static const struct bmp280_chip_info bmp180_chip_info = {
>  	.read_temp = bmp180_read_temp,
>  	.read_press = bmp180_read_press,
>  	.read_calib = bmp180_read_calib,
> +	.preinit = NULL,
>  };
>  
>  static irqreturn_t bmp085_eoc_irq(int irq, void *d)
> @@ -1762,9 +1773,13 @@ int bmp280_common_probe(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	/* BMP3xx requires soft-reset as part of initialization */
> -	if (chip_id == BMP380_CHIP_ID) {
> -		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
> +	/*
> +	 * Some chips like the BMP3xx have preinit tasks to run
> +	 * before applying the initial configuration.
> +	 */
I would drop this comment. It's kind of obvious that some devices need you
to call something here - otherwise why have the clearly optional callback?
The specific BMP3xx requirements are well commented in your new callback above
so don't want to be here as well.

> +	if (data->chip_info->preinit) {
> +		ret = data->chip_info->preinit(data);
> +		dev_err(dev, "error running preinit tasks");

Error message printed on success...

>  		if (ret < 0)
>  			return ret;

			return dev_err_probe(dev, ret, "error running preinit tasks");

>  	}

