Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E86F9373
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEFRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFRvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309A2D68;
        Sat,  6 May 2023 10:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2086460B39;
        Sat,  6 May 2023 17:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B0C433D2;
        Sat,  6 May 2023 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683395505;
        bh=Xh7/cFAPigW0kTKV4NFFiavNpam6hMBWH8NZIcN1IkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6bRNFU45i2S7GJeBT7dGNbH9JCQmB4HcCBNASU6BY02mftAX7j2zBoVXU9AZWwcG
         1ZxMoP7KfC1WWqj2mVVXvu4cGniTRKknUrhhiZVPha8tbG0NA9Xeg2wqGex5uT0DDw
         QYurdXo7Nzepg4h01gIrJHOBhcpaIDWa6sRdzt5KUK8jE7C2XWloWHLXCuI7JtNIaL
         O9gYqPN61Ythq4L30sN9zjQATrHAHAGbPYxRnpoN1jlfCj8AMG6W8DxjG0YLt70kiM
         yfzBhewKrAjvqtYdlumBIzH3xaXC/DuWnCpyMIyVvA2kJ6V4nkKZQaW19YLl03honh
         pKvH3anApUFCg==
Date:   Sat, 6 May 2023 19:07:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bu27034: Reinit regmap cache after reset
Message-ID: <20230506190738.0b6e4b45@jic23-huawei>
In-Reply-To: <ZFM7lE4ZuDrUTspH@fedora>
References: <ZFM7lE4ZuDrUTspH@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 07:59:00 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> When BU27034 restores the default register values when SWRESET is
> issued. This can cause register cache to be outdated.
> 
> Rebuild register cache after SWRESET.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
> 
> ---
> I noticed this was missing while writing driver for another light
> sensor. The change is not tested in hardware as I don't have the BU27034
> at my hands right now. Careful review would be highly appreciated.
> 
> This change is built on top of the
> https://lore.kernel.org/all/ZFIw%2FKdApZe1euN8@fedora/
> and could probably be squashed with it. Unfortunately I spotted the
> missing cache re-init only after sending the fix linked above.
> 

I'm not sure I follow what would be happening here or if this makes sense.

Partly the following is based on my mental image of how regmap caching works
and could be completely wrong :)

I don't think it goes off an reads registers until they are actually accessed
the first time.  In this case nothing has been accessed before this point
other than the SYSTEM_CONTROL register and that happens to the one that
is set to trigger the reset.   

So at worst I think the only cache element that will potentially be wrong
is the SYSTEM_CONTROL register as the cache will contain the reset bits as set.

That would be a problem if you read it again anywhere in the driver after that
point, but you don't so not a 'bug' but perhaps prevention of potential future
bugs as this behaviour is odd.  If you were to try setting some other bits
then you'd probably accidentally reset the device :)

So, what's the ideal solution.  You could just bypass the regcache initially
and turn it on later.  Thus it would never become wrong due to the reset (as nothing
would be cached until after that).

Or just leave it as you have it here, but explain why it matters - as prevention
of potential issues due to wrong value in that single register.

Jonathan


> Please, let me know if you want me to squash and respin.
> ---
>  drivers/iio/light/rohm-bu27034.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 740ebd86b6e5..f85194fda6b0 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -1281,6 +1281,13 @@ static int bu27034_chip_init(struct bu27034_data *data)
>  		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
>  
>  	msleep(1);
> +
> +	ret = regmap_reinit_cache(data->regmap, &bu27034_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reinit reg cache\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Read integration time here to ensure it is in regmap cache. We do
>  	 * this to speed-up the int-time acquisition in the start of the buffer

