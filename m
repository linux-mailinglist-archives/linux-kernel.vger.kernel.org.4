Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0320C65E4A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjAEEYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAEEYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:24:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76EDF1F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:24:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso466825wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 20:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgd9Ot6naxiaI/TtbDtOJPnlzZys03z2yUHXxx+Dnb0=;
        b=ObY5FTqW2prSFPyKFqlize7AVcm/v6aYJ6P99m4vbqs13efQWqvZ/GKp/fqoJ/KHlJ
         VbBTglI8x8PsnRt62wzmwMXjqY2Qrw8s6BPFxWhhlDRQRozQRQwmVPNoPPIkP0Lm0qpQ
         6bLc7bBkUE7PeK9s7Pvz7Z8IAiy8oJwtEWPmdzuZAyTlGs/wVEmypSoieFSU94nrgIjE
         vVIEjZMqREs3uqnppbGhcm6s62XXXB4j3Pey/C5MENfRdy5G2323GdsHomaedbXDUv5n
         PKhVmoVlexkT1hc2SRRUOh07z9PnfW/vTkObYEmR4/ee/PG5O7eeqqAEKq1PcCj+6Bnz
         L/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hgd9Ot6naxiaI/TtbDtOJPnlzZys03z2yUHXxx+Dnb0=;
        b=7WqXk9MAq3kl50dJGkTKTUtq9o2UKKOavpousgYIDnOnKTZmd5bWuMMQzVnAtSFu87
         hPPpjbh7GljC7+4AUBPrz1ujeLAA/v7rLuPJwqMuKqRuH5epDyx4BwtPLufAejO95mSi
         bjUZ5BKBa3ZghUKOgeR4j/Obcp8JWUFnV6hBJyme9B0I+BEmNWAr1Vf29FWwAZp10dod
         cRM58oomnQNFwVS7vkxnwKuxuQXfgfKmYs8PoUNPg70023K61yHKTHklWq1axRcqbYbp
         NVVkfbUPyB5eJg3UfjbNq0NpoN2recfd5MODMgyvRurXB5/LjdeF3hraT1dCeRqLGBUW
         hA0Q==
X-Gm-Message-State: AFqh2kpBtqL7EUEU3VjMKWNIPxrUZbXqCLnr1NJHxejAM8xT+QYMFPvv
        h0rqRkQvJ5rHf9VcbxNFpyM1aybPzfoRbQ==
X-Google-Smtp-Source: AMrXdXuW/TANs9lnwR4p6FhzeCdpUe+QOQS7LpdKe9YXFcokWPsU0TMBtkks5sJXAHa2Y3jlcyUYPQ==
X-Received: by 2002:a7b:c3d2:0:b0:3c6:e62e:2e72 with SMTP id t18-20020a7bc3d2000000b003c6e62e2e72mr35892543wmj.13.1672892657443;
        Wed, 04 Jan 2023 20:24:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003d98a7aa12csm958404wmg.16.2023.01.04.20.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 20:24:16 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:23:51 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Hector Martin <marcan@marcan.st>, lkp@intel.com
Subject: Re: [PATCH v3 4/5] nvmem: core: fix cleanup after dev_set_name()
Message-ID: <Y7ZQ173m4vsTBvhc@kili>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <E1pCkdQ-004hv8-7U@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pCkdQ-004hv8-7U@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:59:32PM +0000, Russell King (Oracle) wrote:
> If dev_set_name() fails, we leak nvmem->wp_gpio as the cleanup does not
> put this. While a minimal fix for this would be to add the gpiod_put()
> call, we can do better if we split device_register(), and use the
> tested nvmem_release() cleanup code by initialising the device early,
> and putting the device.
> 
> This results in a slightly larger fix, but results in clear code.
> 
> Note: this patch depends on "nvmem: core: initialise nvmem->id early"
> and "nvmem: core: remove nvmem_config wp_gpio".
> 
> Fixes: 5544e90c8126 ("nvmem: core: add error handling for dev_set_name")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/nvmem/core.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 843e2f5696e6..19497f555e07 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -772,15 +772,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  
>  	nvmem->id = rval;
>  
> +	nvmem->dev.type = &nvmem_provider_type;
> +	nvmem->dev.bus = &nvmem_bus_type;
> +	nvmem->dev.parent = config->dev;
> +
> +	device_initialize(&nvmem->dev);
> +
>  	if (!config->ignore_wp)
>  		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>  						    GPIOD_OUT_HIGH);
> -	if (IS_ERR(nvmem->wp_gpio)) {
> -		ida_free(&nvmem_ida, nvmem->id);
> -		rval = PTR_ERR(nvmem->wp_gpio);
> -		kfree(nvmem);
> -		return ERR_PTR(rval);
> -	}
> +	if (IS_ERR(nvmem->wp_gpio))
> +		goto err_put_device;
>  

Missing error code.  It still needs the rval = PTR_ERR(nvmem->wp_gpio);

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

