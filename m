Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989E626AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiKLQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:54:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E4E44;
        Sat, 12 Nov 2022 08:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2249060C74;
        Sat, 12 Nov 2022 16:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B2BC433D6;
        Sat, 12 Nov 2022 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668272092;
        bh=1McgPERC3DCrHC2oJEgF7eHWRQMMJ5k3OBizaJyxN6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TNrSzxuhzPGEBZGvcoaHPweIKIoznIKz1mdVOR+RjRmb5cOTpkIm2ag1M6K/lNg18
         zAo43DPGPlRcDsfWnlLBpZmB58ZixLMBu9gvcQ2JKXHvolavaQViH67H72nWXKON27
         qB+Kz8VB9LuLu1D6nq1s5diD+LV9NIU+e/NkxsftgIq3TXzJ1dxqM5bSurBRLYbEFC
         QFE9jG4iTgTVHZw6pRGorPRwElrNvkNCL94jznuFzTv4iBLU0m0rDmYrMeJGoka4C6
         XsZrnS7hPcQyS+kJTX3vSSBQ24vvz4CwNYmUy6qGRdIGTHXMa/aokxySfjVN1SmuvR
         Uo4ieaCMgbEUg==
Date:   Sat, 12 Nov 2022 17:07:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Message-ID: <20221112170705.7efe1673@jic23-huawei>
In-Reply-To: <20221111143921.742194-6-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 15:39:21 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> We have a board where the reset pin of the ad74412 is connected to a
> gpio, but also pulled low by default. Hence to get the chip out of
> reset, the driver needs to know about that gpio and set it high before
> attempting to communicate with it.

I'm a little confused on polarity here.  The pin is a !reset so
we need to drive it low briefly to trigger a reset.
I'm guessing for your board the pin is set to active low? (an example
in the dt would have made that clearer) Hence the pulse
in here to 1 is actually briefly driving it low before restoring to high?

For a pin documented as !reset that seems backwards though you have
called it reset so that is fine, but this description doesn't make that
celar.

Perhaps just add some more description here to make it clear the GPIO
is active low, and then refer to setting it to true and false to avoid
the confusing high / low terminology which are inverted...

> 
> When a reset-gpio is given in device tree, use that instead of the
> software reset. According to the data sheet, the two methods are
> functionally equivalent.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/iio/addac/ad74413r.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 9f77d2f514de..af09d43f921c 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -71,6 +71,7 @@ struct ad74413r_state {
>  	struct regmap			*regmap;
>  	struct device			*dev;
>  	struct iio_trigger		*trig;
> +	struct gpio_desc		*reset_gpio;
>  
>  	size_t			adc_active_channels;
>  	struct spi_message	adc_samples_msg;
> @@ -393,6 +394,13 @@ static int ad74413r_reset(struct ad74413r_state *st)
>  {
>  	int ret;
>  
> +	if (st->reset_gpio) {
> +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> +		fsleep(50);
> +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> +		return 0;
> +	}
> +
>  	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
>  			   AD74413R_CMD_KEY_RESET1);
>  	if (ret)
> @@ -1316,6 +1324,10 @@ static int ad74413r_probe(struct spi_device *spi)
>  	if (IS_ERR(st->regmap))
>  		return PTR_ERR(st->regmap);
>  
> +	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +
>  	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
>  	if (IS_ERR(st->refin_reg)) {
>  		ret = PTR_ERR(st->refin_reg);

