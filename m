Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD715FFEE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJPLNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJPLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:13:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA323A150;
        Sun, 16 Oct 2022 04:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A628B80C82;
        Sun, 16 Oct 2022 11:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00BDC433D6;
        Sun, 16 Oct 2022 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665918786;
        bh=uJ8EoO01+PdQiKTY2XpaRw+EP1zyXWcYZvdwYWh7l74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SuDy4NBcUFwjfQntV0fTCRP0gVruzgwg2Zos96EN83fMJZfJgzSa4ZlB8qqCs1LN2
         KLJ+Je9rTWhBYfM7YFa7Tcb+Lc3fKgrQZTXqLZ2l8m3/LBBFv0H+VfIIFSeO/R7SDF
         Uf2LIEfk4GX/cgfUeKd4IIMHL5sLUZXGcXIoZHeWYCqvCCNnKfgwVIlpBoUnLWOMoX
         qpufN3rKY4RxzgC1mDA4aGMackBjkgI0+TDsOBmrUwZ1qUtBO4iL9uk+pTzThoftJr
         s3A3KzlWjk5goUVnOA5njUXJkR/V+2cTOxSpsV8dzAMM/rnf7FG5XqSiujQ4UhX8CT
         pBg0ndOs78Aag==
Date:   Sun, 16 Oct 2022 12:13:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] iio: bmc150-accel-core: Fix unsafe buffer
 attributes
Message-ID: <20221016121332.4240fe60@jic23-huawei>
In-Reply-To: <cf8a56658fc38db8bed64f456d898f5ad5a2814f.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <cf8a56658fc38db8bed64f456d898f5ad5a2814f.1664782676.git.mazziesaccount@gmail.com>
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

On Mon, 3 Oct 2022 11:11:12 +0300
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
>  drivers/iio/accel/bmc150-accel-core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 57e8a8350cd1..92f8b139acce 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -925,17 +925,30 @@ static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
>  	{ }
>  };
>  
> -static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> -static IIO_CONST_ATTR(hwfifo_watermark_max,
> -		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
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
> +	return sysfs_emit(buf, "%s\n", __stringify(BMC150_ACCEL_FIFO_LENGTH));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
>  static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
>  		       bmc150_accel_get_fifo_state, NULL, 0);
>  static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
>  		       bmc150_accel_get_fifo_watermark, NULL, 0);
>  
>  static const struct attribute *bmc150_accel_fifo_attributes[] = {
> -	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> -	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>  	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>  	NULL,

