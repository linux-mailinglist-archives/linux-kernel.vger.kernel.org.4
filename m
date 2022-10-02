Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295BD5F2351
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJBNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJBNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:19:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA4E19C31;
        Sun,  2 Oct 2022 06:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85CE0B80113;
        Sun,  2 Oct 2022 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372BFC433D6;
        Sun,  2 Oct 2022 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664716783;
        bh=Ja+aV72JBZL/hj4saSCDhVSEZpplFH6GQjZt1AeESUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HRZsD5RfXeR0RXXuW0KjquJ+f6TKu1YO5DP1ht5yiKonQxyErjNA5URmDPF2LaOL/
         izVpZgkwrHTJvdG/5JfaEgPlB2WVWBFvW0D5b2Cla1cDwKrBJmpWEgHlhiep0pBm62
         FliMrcAMGqwAXoaIVK4TwPuwVbFgMB4EYg9QrgHnNzT+1iEVHqsqpqJHoe5+9P2HT4
         QtQx4lZCKjwF9RWl6KJcq+Suq0FDDF4gr8pGIyWrQiguwKGyTZHM+j+sTguyO7Y2SP
         TdHA5/w0ZSHJlRSiVvl4UbdvvcPKolhmErJvGxYlyGJOW/8AcxeXGJD2ObSKnaHq4s
         CU/r+nnrpl12w==
Date:   Sun, 2 Oct 2022 14:19:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: mpl115: Implementing low power mode by
Message-ID: <20221002141959.105ebfc7@jic23-huawei>
In-Reply-To: <20220927173838.1776453-1-rajat.khandelwal@intel.com>
References: <20220927173838.1776453-1-rajat.khandelwal@intel.com>
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

On Tue, 27 Sep 2022 23:08:38 +0530
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

Hi Rajat,

5ms is a significant delay to add to the read paths on this device
(I think the normal readout is < 3msec total).

As such, have you considered implementing this as runtime_pm using
autosleep?  That way, if the user is doing a bunch of readings (perhaps
to compute a more accurate average value) they won't end up powering the
device up and down.  However, if the reads are infrequent then the
power saving will be achieved at the cost of more latency on the first
read after a long gap.

Thanks,

Jonathan


> ---
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

