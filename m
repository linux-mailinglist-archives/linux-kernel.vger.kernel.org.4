Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1692461FD20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiKGSQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKGSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:15:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A331FCF1;
        Mon,  7 Nov 2022 10:14:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v28so11368522pfi.12;
        Mon, 07 Nov 2022 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqwrPz5XaFAPqaC5i7DZPaqfSXndPxcC58Brabuv55s=;
        b=P3iw55DLz21SyqpT1vwOTEvnZOGcqMjWXKV3GIrcCzMGda7w7D+I1039BxPSOLbyaI
         Mt7fSotDkggXcWzGV4Sxn6ke8dRvck6nRLKThbEmoMhM5+COGeo5/UYyBDpA/1FAxKa/
         TiSIiZoNhnQoTikFw4DynROAACoJyB8BDXiQYPSpjWQLV6t5/CBVWiahoKvaIUjqfhA9
         H12tsipaAYNi5sJGlxkmPBV0XpWZbVDQvtXo8rg1Qdd9yFr+tUBuBynEXluPHKOkNKNs
         2uMWkAzAuVzMoraLD32IORTCDv7YDliM+qH6i2t/Lr5KZHF0okFa4g+01ttPFVPOtLbM
         o4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqwrPz5XaFAPqaC5i7DZPaqfSXndPxcC58Brabuv55s=;
        b=2cJf/T6bzkuY3wyZhkB/Y/taBhUP0OYanPgrynA1BiKfvDBgI6jPVOHiqqziGjA5j6
         Ie/HPMNtVBj27lVIxuo61X0DoMYTGBFxKAYwRtq043xOElHildmrM3ay8jllrVROoSKt
         fVrBvyevNqO7QukHtrrZPD5sK4GLVfKMkBeuVjEK5nquTz57G4uNiACNnnYHUBYmnznC
         vnhAUTYbqqrSJQ7g9W6G2Wn87eB4v6Ecyvl70aNsjICJVWdJkemuWDRDB3ZoeN8k99L3
         YimsH9Sop+snkNyqo8SlF5lLftpBy5e1OZLvihLn+WN8vzA3gXhsmkLJRosZVI/i14Yd
         xizw==
X-Gm-Message-State: ACrzQf1sRf5i/6F/gZB+NPAlSp+uKQAMi64GvtTIzUsd48MXYlu+w7ja
        IziKY5nO/NbiQEK5GpzYRyrOKDQJl1k=
X-Google-Smtp-Source: AMsMyM4NE9Sn8XwakVQs2poEBe+uRhMRwVwTjOHQxBQoTgHzYZRm+XzWBOYG65ZPhQqIuzf1f/x8Xg==
X-Received: by 2002:a63:7909:0:b0:458:1ba6:ec80 with SMTP id u9-20020a637909000000b004581ba6ec80mr44495613pgc.414.1667844873160;
        Mon, 07 Nov 2022 10:14:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0056bd737fdf3sm4782030pfc.123.2022.11.07.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:14:32 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:14:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
Message-ID: <Y2lLBchlwBozRcDq@google.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:10:26PM +0200, Andy Shevchenko wrote:
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/gpio/gpiolib-of.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index be9c34cca322..000020eb78d8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1104,9 +1104,11 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip) { return 0; }
>  
>  int of_gpiochip_add(struct gpio_chip *chip)
>  {
> +	struct device_node *np;
>  	int ret;
>  
> -	if (!chip->of_node)
> +	np = to_of_node(chip->fwnode);
> +	if (!np)
>  		return 0;
>  
>  	if (!chip->of_xlate) {
> @@ -1123,18 +1125,18 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	if (ret)
>  		return ret;
>  
> -	of_node_get(chip->of_node);
> +	fwnode_handle_get(chip->fwnode);
>  
>  	ret = of_gpiochip_scan_gpios(chip);
>  	if (ret)
> -		of_node_put(chip->of_node);
> +		fwnode_handle_put(chip->fwnode);
>  
>  	return ret;
>  }
>  
>  void of_gpiochip_remove(struct gpio_chip *chip)
>  {
> -	of_node_put(chip->of_node);
> +	fwnode_handle_put(chip->fwnode);
>  }
>  
>  void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> -- 
> 2.35.1
> 

-- 
Dmitry
