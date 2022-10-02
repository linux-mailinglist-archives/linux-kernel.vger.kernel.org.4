Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22A5F2355
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJBNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:21:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF24621B;
        Sun,  2 Oct 2022 06:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E07CB80D31;
        Sun,  2 Oct 2022 13:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B486C433C1;
        Sun,  2 Oct 2022 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664716878;
        bh=KkBNlEX1wSNIgeTxdgBGFj0Kj0Q76m0kWPrOKhjgtLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f/tbLeQcCG1zEYWTRHBCZ/kwRtpnxyZpSNl+qm1RXzfmgGQlz8YguLUGGtu/ewA0l
         Aeft5p8hkKAhgmiR50/U0f8ckKTC62um2lG7b6XOM1uzLUpN0Nj0xyt7wE9kcH503S
         BX25TaCwVV8ukbxOhNb8jToPmxxlkqqgoz+6kSOPYKnJ+OM7nDgE9n2Wl4HAJnUxNP
         G2uSrfsMk5q75GSB3J9skFX1RsGgzGxctAGRkZaWI88zKSUQTWQXe4aFTMu7JzCPgy
         vu1Ch3/G/uErzOtQOLtmT9wlI/q5LmwjBmWpAew+BQzel+LXzTs6P4c3nBFvrZDZJL
         9GzUkVElNPnkQ==
Date:   Sun, 2 Oct 2022 14:21:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: mpl115: Implementing low power mode
 by shutdown gpio
Message-ID: <20221002142134.4d7c5fe9@jic23-huawei>
In-Reply-To: <20220927174212.1776567-1-rajat.khandelwal@intel.com>
References: <20220927174212.1776567-1-rajat.khandelwal@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 27 Sep 2022 23:12:12 +0530
Rajat Khandelwal <rajat.khandelwal@intel.com> wrote:

> MPL115 supports shutdown gpio which can be used to set the default
> state to low power mode. Power from all internal circuits and
> registers is removed. This is done by pulling the SHDN pin to low.
> This patch sets the default mode to low-power and only exits when
> a reading is required from the chip. This maximises power savings.
> 
> According to spec., a wakeup time period of ~5 ms exists between
> waking up and actually communicating with the device. This is
> implemented using sleep delay.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
Ah. I missed there was a v2 and replied to v1.

> ---
> 
> v2: Grammatically completing subject line
> 
>  drivers/iio/pressure/mpl115.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 5bf5b9abe6f1..c0ad3e941d05 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -3,13 +3,12 @@
>   * mpl115.c - Support for Freescale MPL115A pressure/temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> - *
> - * TODO: shutdown pin
>   */
>  
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "mpl115.h"
>  
> @@ -27,6 +26,7 @@ struct mpl115_data {
>  	s16 a0;
>  	s16 b1, b2;
>  	s16 c12;
> +	struct gpio_desc *shutdown;
>  	const struct mpl115_ops *ops;
>  };
>  
> @@ -102,13 +102,27 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = mpl115_comp_pressure(data, val, val2);
> +		if (data->shutdown) {
> +			gpiod_set_value(data->shutdown, 0);
> +			usleep_range(5000, 6000);
> +			ret = mpl115_comp_pressure(data, val, val2);
> +			gpiod_set_value(data->shutdown, 1);
> +		} else
> +			ret = mpl115_comp_pressure(data, val, val2);
> +
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_RAW:
>  		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
> -		ret = mpl115_read_temp(data);
> +		if (data->shutdown) {
> +			gpiod_set_value(data->shutdown, 0);
> +			usleep_range(5000, 6000);
> +			ret = mpl115_read_temp(data);
> +			gpiod_set_value(data->shutdown, 1);
> +		} else
> +			ret = mpl115_read_temp(data);
> +
>  		if (ret < 0)
>  			return ret;
>  		*val = ret >> 6;
> @@ -185,6 +199,17 @@ int mpl115_probe(struct device *dev, const char *name,
>  		return ret;
>  	data->c12 = ret;
>  
> +	data->shutdown = devm_gpiod_get_optional(dev, "shutdown",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->shutdown))
> +		return dev_err_probe(dev, PTR_ERR(data->shutdown),
> +				     "cannot get shutdown gpio\n");
> +
> +	if (data->shutdown)
> +		dev_dbg(dev, "low-power mode enabled");
> +	else
> +		dev_dbg(dev, "low-power mode disabled");
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);

