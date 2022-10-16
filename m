Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA45FFEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJPLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJPLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7B32AB5;
        Sun, 16 Oct 2022 04:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5B560AFB;
        Sun, 16 Oct 2022 11:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377CC433D6;
        Sun, 16 Oct 2022 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665918750;
        bh=2w22Rvct4TRFUkN6xVjlfPIkEjaRnIDhj+c47zoeAA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z2dAzCf7CM8FOAURYRwUTOlCzmVxVXfq18IFkLbQg53UfAKn4UejQcbN81/RHn17h
         NvYUXsi+XdhDtz0ZCWC//DiFlZmmZ1Xf92svK0HkGi6+oG2uzfH10FZEoBrMmGWW2D
         BSw/er9DYf4A6ly9xAY3qIofeRskZZNlRjyG6pb0rzktI1deOnE67omPRGayqp9Jsg
         wi8Z0fJNPdO6OWfOG/AmbEWDKwu44U6qoTdVy5Uy70y2CVN7DbaOVHNgs5nqZ40wWq
         NOVKvBmExTXThPwpGbFQvMQJloUnrw/Ynbiv5T1bGc1GRMtJiNZwyy6K7p5XHpPk4E
         Tjd4/dQKICH6w==
Date:   Sun, 16 Oct 2022 12:12:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] iio: adxl372: Fix unsafe buffer attributes
Message-ID: <20221016121257.4a412573@jic23-huawei>
In-Reply-To: <19158499623cdf7f9c5efae1f13c9f1a918ff75f.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <19158499623cdf7f9c5efae1f13c9f1a918ff75f.1664782676.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 11:10:51 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The iio_triggered_buffer_setup_ext() was changed by
> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> to silently expect that all attributes given in buffer_attrs array are
> device-attributes. This expectation was not forced by the API - and some
> drivers did register attributes created by IIO_CONST_ATTR().
> 
> The added attribute "wrapping" does not copy the pointer to stored
> string constant and when the sysfs file is read the kernel will access
> to invalid location.
> 
> Change the IIO_CONST_ATTRs from the driver to IIO_DEVICE_ATTR in order
> to prevent the invalid memory access.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> ---
> 
> v2 => v3:
> Split change to own patch for simpler fix backporting.
> ---
>  drivers/iio/accel/adxl372.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index e3ecbaee61f7..bc53af809d5d 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -998,17 +998,30 @@ static ssize_t adxl372_get_fifo_watermark(struct device *dev,
>  	return sprintf(buf, "%d\n", st->watermark);
>  }
>  
> -static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> -static IIO_CONST_ATTR(hwfifo_watermark_max,
> -		      __stringify(ADXL372_FIFO_SIZE));
> +static ssize_t hwfifo_watermark_min_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", "1");
> +}
> +
> +static ssize_t hwfifo_watermark_max_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", __stringify(ADXL372_FIFO_SIZE));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
>  static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
>  		       adxl372_get_fifo_watermark, NULL, 0);
>  static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
>  		       adxl372_get_fifo_enabled, NULL, 0);
>  
>  static const struct attribute *adxl372_fifo_attributes[] = {
> -	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> -	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>  	NULL,

