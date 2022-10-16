Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694F5FFEDB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJPLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJPLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:11:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD233E23;
        Sun, 16 Oct 2022 04:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39956609AE;
        Sun, 16 Oct 2022 11:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD39EC433C1;
        Sun, 16 Oct 2022 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665918714;
        bh=haZgvxjEjKaGrnWpf/XakHvzA6ss1pVHMfzXnUyCxsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hTTrCsVzPfcijf8ZTSNizDVkrYqa2C04Rbi6ATJbieqribKliILfqN3RMucOdOhaO
         ydM5U+vtAO8kSwaOP4uZdAYdZ3+N+ml9Uld0MgmFMYAHLqNZacyfhz3MpfmE23Xvdn
         k1dX6HA2TfTIrlHIXi2C7VCfJ3moYpHL4z4UKTmeuu3Y5m1B8rW9vjVaRuIn6yh4ZY
         Q/bGS0x7ySRQmptShyADHQmMny0YH1YKCpZOSwweA2pyzoO/22ED5crdb+tFwUy1a4
         Pvp0gqUDebq2gZukUU2zh6s8bR7/9jequUSLyERrWrWvzEkqHlUg2wUpwoNjPkKUdg
         JjsMKCwRPSxNw==
Date:   Sun, 16 Oct 2022 12:12:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] iio: adxl367: Fix unsafe buffer attributes
Message-ID: <20221016121219.4114cab2@jic23-huawei>
In-Reply-To: <2e2d9ec34fb1df8ab8e2749199822db8cc91d302.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <2e2d9ec34fb1df8ab8e2749199822db8cc91d302.1664782676.git.mazziesaccount@gmail.com>
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

On Mon, 3 Oct 2022 11:10:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The devm_iio_kfifo_buffer_setup_ext() was changed by
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

Seems like a safe enough change to take without additional review.
Hence applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan

> 
> ---
> 
> v2 => v3:
> Split change to own patch for simpler fix backporting.
> ---
>  drivers/iio/accel/adxl367.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 47feb375b70b..7c7d78040793 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1185,17 +1185,30 @@ static ssize_t adxl367_get_fifo_watermark(struct device *dev,
>  	return sysfs_emit(buf, "%d\n", fifo_watermark);
>  }
>  
> -static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> -static IIO_CONST_ATTR(hwfifo_watermark_max,
> -		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
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
> +	return sysfs_emit(buf, "%s\n", __stringify(ADXL367_FIFO_MAX_WATERMARK));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
>  static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
>  		       adxl367_get_fifo_watermark, NULL, 0);
>  static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
>  		       adxl367_get_fifo_enabled, NULL, 0);
>  
>  static const struct attribute *adxl367_fifo_attributes[] = {
> -	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> -	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>  	NULL,

