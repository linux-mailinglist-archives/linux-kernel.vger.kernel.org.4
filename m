Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6934C6DB0C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDGQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDGQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE164C01;
        Fri,  7 Apr 2023 09:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7C462D10;
        Fri,  7 Apr 2023 16:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89123C433EF;
        Fri,  7 Apr 2023 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680885391;
        bh=etitddCZwTTTG1EgyGdc17CuU1cpdOMzVjNv6qZw6k4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diUNrEnZ8yN6WitBb8SYFLMAdzIAzokKc5ubq9dq5Z033RANnKcbvqwRXhLmgFkBO
         oQtGh5WRnUnAYKsYSJA4Cl0zJ2ycRt82xOJfRrtr2Y9whppi+2BvwH8xTXEWsHISm1
         0B6syMX8ppnTAtMhrp3A42u9FIYP3GfBLxroqR0uve6yOO81bgVKST/UsXtf1VsePs
         HNLOx0GlDFwH9bimJSV89ys1CPIBVF3PMPXRRrkffm4QfHvvFInoYOvmInXDimqqPy
         rQOu3xSZ4Yw0O4pZSwGtc4TZKDx59vzESXm8zwAZoE9QLTCQcE1/5zFKost/3WsA5W
         EhEXu1pdCKtMg==
Date:   Fri, 7 Apr 2023 17:51:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/6] iio: addac: stx104: Fix race condition for
 stx104_write_raw()
Message-ID: <20230407175147.180f9f44@jic23-huawei>
In-Reply-To: <c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
        <c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org>
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

On Thu,  6 Apr 2023 10:40:10 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> The priv->chan_out_states array and actual DAC value can become
> mismatched if stx104_write_raw() is called concurrently. Prevent such a
> race condition by utilizing a mutex.
> 
> Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Marked these first two patches for stable as probably worth a backport
even if no one notices the affect of the race. I'll queue them for the
next merge window though as we are fairly late in this cycle and I don't
want to delay the 4 patches that follow a whole cycle.

Thanks,

Jonathan

> ---
> Changes in v5: none
> 
>  drivers/iio/addac/stx104.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
> index e45b70aa5bb7..4239aafe42fc 100644
> --- a/drivers/iio/addac/stx104.c
> +++ b/drivers/iio/addac/stx104.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  
> @@ -69,10 +70,12 @@ struct stx104_reg {
>  
>  /**
>   * struct stx104_iio - IIO device private data structure
> + * @lock: synchronization lock to prevent I/O race conditions
>   * @chan_out_states:	channels' output states
>   * @reg:		I/O address offset for the device registers
>   */
>  struct stx104_iio {
> +	struct mutex lock;
>  	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
>  	struct stx104_reg __iomem *reg;
>  };
> @@ -178,9 +181,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
>  			if ((unsigned int)val > 65535)
>  				return -EINVAL;
>  
> +			mutex_lock(&priv->lock);
> +
>  			priv->chan_out_states[chan->channel] = val;
>  			iowrite16(val, &priv->reg->dac[chan->channel]);
>  
> +			mutex_unlock(&priv->lock);
>  			return 0;
>  		}
>  		return -EINVAL;
> @@ -351,6 +357,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  
>  	indio_dev->name = dev_name(dev);
>  
> +	mutex_init(&priv->lock);
> +
>  	/* configure device for software trigger operation */
>  	iowrite8(0, &priv->reg->acr);
>  

