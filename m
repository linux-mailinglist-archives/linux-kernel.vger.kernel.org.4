Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766F768BBC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBFLgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:36:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD02364F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:35:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg26so8453857wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pR8VY8MEaUw8uT3n7EK5kFq1p/76o+VV6eFTe4dXliU=;
        b=YJDQNV6/1J1q36ybp2G2ZKvs1dYPlTrqYzKO5Be1jCumUHzKAKcyozOg2lqBZOwjz2
         jIJCjKYnRDQ3IVAJ3fei9R4i1PIHUp5QXrZA8k0OrPo1D8Da445vzUbhu3XyQj7e/rlr
         I1T6M9Fkyp+g1rQK90eWCwcmHvmfY8OLcAvgpCHnXGTMUEKdTY1k4/OtVLZrIEh/lydG
         UTZ4xXB6PUy1Xjsliri3Iyem1Dp+5Z0YtKyxpNdFIl7Q4iFOpkogA/1AS70FrUZxtc6L
         ko71QhPlsvuCB93OxY+yso8p+yFtiNJidbQIDBI3bDmpbTRkmSlAgigdUPckAYky7klt
         WxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR8VY8MEaUw8uT3n7EK5kFq1p/76o+VV6eFTe4dXliU=;
        b=ZU8m+rwb9kQgeMNyTBRcD0YNaIGPSbEEioQhFFaUZtcGALjml5sNW5u1AbNPfxGDee
         zO5AG/UPtqnRATcYFy4dhRPxQW1ZlDf10xqJQfonxTE1lJABbY8ApYQE2bC/KI8KQqHc
         FyR/y+Lt0lsv1hQihuqwWpDcTBKGSQmYKimH3yxBNsxrA4ApuLTv6CPy0BBL8qHcBi07
         LGvMGKr6Ie4Yb3zyxfYORoKYMMkX8TX+4EkPht/9662KOq3pOvqI9iF1ApF6+1emjnZy
         QfZC6INHjuNssfaJDAuW4hzs2fmKcJkyFTrh40AstDqptj2zuDLKHnbVmSOTNkez3z9S
         GzSA==
X-Gm-Message-State: AO0yUKWq5BR59EWy7jbd3k3HsxwvHlpJpw+QUBGZJpgsH19lOFZ2WQig
        0XGybeyWV2MRq9TKnvlyWhCXNzPmc2eM8rML0rI=
X-Google-Smtp-Source: AK7set/xN77otnGQhZNbFbdcG8zsWM3YHu8lPSRThnKghUb3pLW4WPhKlBSWyxklGkVCuojuTBpHJQ==
X-Received: by 2002:a05:600c:4a9b:b0:3de:1d31:1043 with SMTP id b27-20020a05600c4a9b00b003de1d311043mr18725422wmp.21.1675683334991;
        Mon, 06 Feb 2023 03:35:34 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d5-20020a1c7305000000b003dcc82ce53fsm1068040wmb.38.2023.02.06.03.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:35:34 -0800 (PST)
Date:   Mon, 6 Feb 2023 11:35:32 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: hx8357: switch to using gpiod API
Message-ID: <Y+DmBGiq9kvRBHLY@aspen.lan>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:57:06PM -0800, Dmitry Torokhov wrote:
> Switch the driver from legacy gpio API that is deprecated to the newer
> gpiod API that respects line polarities described in ACPI/DT.
>
> This makes driver use standard property name for the reset gpio
> ("reset-gpios" vs "gpios-reset"), however there is a quirk in gpiolib
> to also recognize the legacy name and keep compatibility with older
> DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> All preparation gpiolib work to handle legacy names and polarity quirks
> has landed in mainline...
>
>  drivers/video/backlight/hx8357.c | 82 ++++++++++++++------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index 9b50bc96e00f..a93e14adb846 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> [snip]
> -	if (of_find_property(spi->dev.of_node, "im-gpios", NULL)) {
> -		lcd->use_im_pins = 1;
> -
> -		for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
> -			lcd->im_pins[i] = of_get_named_gpio(spi->dev.of_node,
> -							    "im-gpios", i);
> -			if (lcd->im_pins[i] == -EPROBE_DEFER) {
> -				dev_info(&spi->dev, "GPIO requested is not here yet, deferring the probe\n");
> -				return -EPROBE_DEFER;
> -			}
> -			if (!gpio_is_valid(lcd->im_pins[i])) {
> -				dev_err(&spi->dev, "Missing dt property: im-gpios\n");
> -				return -EINVAL;
> +	gpiod_set_consumer_name(lcd->reset, "hx8357-reset");
> +
> +	for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
> +		lcd->im_pins[i] = devm_gpiod_get_index(&spi->dev,
> +						       "im", i, GPIOD_OUT_LOW);
> +		ret = PTR_ERR_OR_ZERO(lcd->im_pins[i]);
> +		if (ret) {
> +			if (ret == -ENOENT) {
> +				if (i == 0)
> +					break;
> +				dev_err(&spi->dev, "Missing im gpios[%d]\n", i);
> +				ret = -EINVAL;
> +			} if (ret == -EPROBE_DEFER) {
> +				dev_info(&spi->dev, "im gpio[%d] is not here yet, deferring the probe\n",
> +					 i);
> +			} else {
> +				dev_err(&spi->dev, "failed to request im gpio[%d]: %d\n",
> +					i, ret);
>  			}

These last two clauses should be updated to return dev_err_probe(...)
instead.

With that change:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
