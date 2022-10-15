Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0A5FFB43
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJOQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D046858;
        Sat, 15 Oct 2022 09:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C6060EAE;
        Sat, 15 Oct 2022 16:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B961C433C1;
        Sat, 15 Oct 2022 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665852218;
        bh=2LF2yYi7JrAqwRSsaAHxccbrJiutpUhFO4yfJ/0148g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UyhvhMIHct7X5GF1ivLVHnMCbs5ZWk755fe/7FknNlV/Nz7WPgxqLXfh9W/4+9lIn
         TSsquUchgSzAV3rYYGj27jvrbCXqr8yCfMmg278IQn9ey3tDkMVZip+H8xXhiQ7Dy0
         LaAgsidxNKCERL8c3oceEEYnHqhV42E2xwih3vAmVbwGjozREvAyyCpIAh8wFDbgZo
         NSVUqvkSIgjm9NmvMQ2xPhZPxroZbLfnCTAkMKn5L2aDkbmVx8qkfYOLAfbGl8PKYT
         7jv/vhsFtim5U55xw0cDeAHUA+PyWmEdSFqQv/d9uHsSDlMZ7EkVYHyTtD81GjMEES
         7fAPv/1+9+FOw==
Date:   Sat, 15 Oct 2022 17:44:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v5] iio: pressure: mpl115: Implementing low power mode
 by shutdown gpio
Message-ID: <20221015174403.186d505f@jic23-huawei>
In-Reply-To: <20221010173720.568916-1-rajat.khandelwal@linux.intel.com>
References: <20221010173720.568916-1-rajat.khandelwal@linux.intel.com>
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

On Mon, 10 Oct 2022 23:07:20 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> MPL115 supports shutdown gpio which can be used to set the state
> to low power mode. Power from all internal circuits and
> registers is removed. This is done by pulling the SHDN pin to low.
> This patch enables runtime PM on MPL115 to increase power savings.
> 
> According to spec., a wakeup time period of ~5 ms exists between
> waking up and actually communicating with the device. This is
> implemented using sleep delay.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing until I can
rebase that tree on rc1 in a few days time.

Thanks,

Jonathan

> ---
> 
> v5:
> 1. Removing build error by exporting EXPORT_NS_RUNTIME_DEV_PM_OPS
> 2. Using runtime PM for low power mode and not forcing shutdown pin
> 3. Changing patch comment
> 4. Increasing autosuspend timeout to 2 sec to make the driver more
> responsive to user
> 
>  drivers/iio/pressure/mpl115.c     | 61 ++++++++++++++++++++++++++++++-
>  drivers/iio/pressure/mpl115.h     |  5 +++
>  drivers/iio/pressure/mpl115_i2c.c |  1 +
>  drivers/iio/pressure/mpl115_spi.c |  1 +
>  4 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 5bf5b9abe6f1..ec7527161844 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -4,12 +4,13 @@
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> - * TODO: shutdown pin
> + * TODO: synchronization with system suspend
>   */
>  
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "mpl115.h"
>  
> @@ -27,6 +28,7 @@ struct mpl115_data {
>  	s16 a0;
>  	s16 b1, b2;
>  	s16 c12;
> +	struct gpio_desc *shutdown;
>  	const struct mpl115_ops *ops;
>  };
>  
> @@ -102,16 +104,24 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> +		pm_runtime_get_sync(data->dev);
>  		ret = mpl115_comp_pressure(data, val, val2);
>  		if (ret < 0)
>  			return ret;
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_RAW:
> +		pm_runtime_get_sync(data->dev);
>  		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
>  		ret = mpl115_read_temp(data);
>  		if (ret < 0)
>  			return ret;
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
>  		*val = ret >> 6;
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = -605;
> @@ -168,6 +178,8 @@ int mpl115_probe(struct device *dev, const char *name,
>  	if (ret)
>  		return ret;
>  
> +	dev_set_drvdata(dev, indio_dev);
> +
>  	ret = data->ops->read(data->dev, MPL115_A0);
>  	if (ret < 0)
>  		return ret;
> @@ -185,10 +193,58 @@ int mpl115_probe(struct device *dev, const char *name,
>  		return ret;
>  	data->c12 = ret;
>  
> +	data->shutdown = devm_gpiod_get_optional(dev, "shutdown",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(data->shutdown))
> +		return dev_err_probe(dev, PTR_ERR(data->shutdown),
> +				     "cannot get shutdown gpio\n");
> +
> +	if (data->shutdown) {
> +		/* Enable runtime PM */
> +		pm_runtime_get_noresume(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +
> +		/*
> +		 * As the device takes 3 ms to come up with a fresh
> +		 * reading after power-on and 5 ms to actually power-on,
> +		 * do not shut it down unnecessarily. Set autosuspend to
> +		 * 2000 ms.
> +		 */
> +		pm_runtime_set_autosuspend_delay(dev, 2000);
> +		pm_runtime_use_autosuspend(dev);
> +		pm_runtime_put(dev);
> +
> +		dev_dbg(dev, "low-power mode enabled");
> +	} else
> +		dev_dbg(dev, "low-power mode disabled");
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);
>  
> +static int mpl115_runtime_suspend(struct device *dev)
> +{
> +	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	gpiod_set_value(data->shutdown, 1);
> +
> +	return 0;
> +}
> +
> +static int mpl115_runtime_resume(struct device *dev)
> +{
> +	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	gpiod_set_value(data->shutdown, 0);
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +EXPORT_NS_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops, mpl115_runtime_suspend,
> +			  mpl115_runtime_resume, NULL, IIO_MPL115);
> +
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
>  MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/pressure/mpl115.h b/drivers/iio/pressure/mpl115.h
> index 57d55eb8e661..78a0068a17bb 100644
> --- a/drivers/iio/pressure/mpl115.h
> +++ b/drivers/iio/pressure/mpl115.h
> @@ -6,6 +6,8 @@
>   * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
>   */
>  
> +#include <linux/pm_runtime.h>
Seems unnecessary to introduce this here.
Just provide a
> +
>  #ifndef _MPL115_H_
>  #define _MPL115_H_
>  
> @@ -18,4 +20,7 @@ struct mpl115_ops {
>  int mpl115_probe(struct device *dev, const char *name,
>  			const struct mpl115_ops *ops);
>  
> +/*PM ops */
> +extern const struct dev_pm_ops mpl115_dev_pm_ops;
> +
>  #endif
> diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
> index 099ab1c6832c..555bda1146fb 100644
> --- a/drivers/iio/pressure/mpl115_i2c.c
> +++ b/drivers/iio/pressure/mpl115_i2c.c
> @@ -53,6 +53,7 @@ MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
>  static struct i2c_driver mpl115_i2c_driver = {
>  	.driver = {
>  		.name	= "mpl115",
> +		.pm = pm_ptr(&mpl115_dev_pm_ops),
>  	},
>  	.probe = mpl115_i2c_probe,
>  	.id_table = mpl115_i2c_id,
> diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
> index 7feec87e2704..58d218fd90dc 100644
> --- a/drivers/iio/pressure/mpl115_spi.c
> +++ b/drivers/iio/pressure/mpl115_spi.c
> @@ -92,6 +92,7 @@ MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
>  static struct spi_driver mpl115_spi_driver = {
>  	.driver = {
>  		.name   = "mpl115",
> +		.pm = pm_ptr(&mpl115_dev_pm_ops),
>  	},
>  	.probe = mpl115_spi_probe,
>  	.id_table = mpl115_spi_ids,

