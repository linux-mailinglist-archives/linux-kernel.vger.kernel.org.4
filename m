Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593826551E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiLWPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLWPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:04:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEB26115;
        Fri, 23 Dec 2022 07:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 380BF6128D;
        Fri, 23 Dec 2022 15:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99472C433EF;
        Fri, 23 Dec 2022 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671807880;
        bh=3gYnMqQTk6UXrBYy6yQE49uv+FnsaJlPV1VozT0NIyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RCveZkxQwU0OJbnbr+dZf9JwmEiN+6aAmo5yH1cppBjFd2WB2aZ2hL0uCVZ74R/m1
         NRkh7hfAX1E+B+enHduRBawxPZL5ecMUfj0DpdJb9ygH8Be3gWJj3CVjx2TPMOWhlk
         VpqiN5OT4/wxI6p0mWnvgg5cVhBLlhgXGYJGv9G22GWoQ9yWMPHKesW9A5Bj6jKVp+
         +gwfxqSvIdMo6CJeJXlZf6ou9BnABYpsCMg720tUkGw3xJUAnU7icELwCBHHS1dAvv
         7vQ5GdZLfM9vtDoma5R8LY4RKJmR36VDk+cgepEjXMuA5bD3/3koN3qm9xwMckAVWW
         OJf4g5VYAgQew==
Date:   Fri, 23 Dec 2022 15:17:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Use
 get_unaligned_beXX()
Message-ID: <20221223151750.6cb55f12@jic23-huawei>
In-Reply-To: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
References: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 14 Dec 2022 14:02:01 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> While at it, use GENMASK() as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy,

Patch looks good, but it got me thinking.  Why not just flip this driver
over to using spi_write_then_read().  Would let us drop the DMA safety
protections and simplify the code + use a __be16 as the read buffer
and this would then be the slightly nicer aligned form.

Worth doing whilst you are here?

Jonathan

> ---
>  drivers/iio/adc/ti-adc128s052.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index fc09ee6bb174..7c4e8025861c 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -9,6 +9,7 @@
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> @@ -17,6 +18,8 @@
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <asm/unaligned.h>
> +
>  struct adc128_configuration {
>  	const struct iio_chan_spec	*channels;
>  	u8				num_channels;
> @@ -33,6 +36,7 @@ struct adc128 {
>  
>  static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  {
> +	u16 value;
>  	int ret;
>  
>  	mutex_lock(&adc->lock);
> @@ -53,7 +57,8 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	value = get_unaligned_be16(&adc->buffer);
> +	return value & GENMASK(11, 0);
>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,

