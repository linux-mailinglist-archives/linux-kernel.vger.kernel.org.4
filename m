Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC28685F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBAFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBAFoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:44:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F485AA4F;
        Tue, 31 Jan 2023 21:44:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11so16312831pji.0;
        Tue, 31 Jan 2023 21:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VUSXz5oiUQzUPPLXOFquXDII3pYY0FoDQHxExlFjJwA=;
        b=ipm3n1b5KqSemHjgdVTe2BY8fI4A4GAJ307zSHPmpNB1gpzUaLslA3dqrylTAfXYYJ
         UXUeBIV+cDWee5nz5nixzXKHyasm4eCKuYuoVQIYMDycvwLjCw53hMjfihCfOFBvd57y
         KdQxjgJo1bRSEv6KXvh9PIzLjmLquGiUek34YqXsVATvBrdnOqvfeyN+8StAqkyDZEa8
         o0oyhijysjdCWPcOb8qCKewaZyCYPJayexzjCpkLrGwyzC6l4CyYamA/dV2SWTIWM3ne
         4IrsZrW3juQxC/KghP9+eSEi268tNAwqfF8zBKVt4g6VI4346WFdLWbaeGJ4mQqy69Jl
         U6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUSXz5oiUQzUPPLXOFquXDII3pYY0FoDQHxExlFjJwA=;
        b=UuwkvES+N7oJZXc012FocBThkBfSbMsidrTWxN45NGI7JCu5b8wrf0aVPD0h0HJsHE
         OZjrBCZKPHeYPgO3g30w41IUlYerbv5NJDpAXEk0drxdNHyRt9slh5Q9RFFHMO4gLzki
         0xGrhbT4B+vdr/UGOryCnDhQQcZ7NhPuodE71UWmNOafVJSWvUtpUfH+j0w8V/Sy9L3R
         SN3jVHfMH9lfWMuh0tRTXEAnuGUDUXRSSixZWyyBUo0AXWoAOEhZ3/cOeqhTQIUNIOq/
         cfJ9LexvRKR/TtvWJtcNbO3mTkSoUK8O0bjbilNaIR+XvzhDp/7HoffWdyRxJ2QClNKk
         KkAw==
X-Gm-Message-State: AO0yUKXScEsKdCE428E9+FBle7PnTvT8U1PliG1FAhBCAwJfQQVc91uT
        LgfyXHZjUE7kI5siBEhGBCY=
X-Google-Smtp-Source: AK7set/suMfeSqpa9Wrl1DhhrPBU0Sm2LO2MnRTiq6S9s6c3CXW6occY0sIgTftgc0A0lDZ6EuFqgw==
X-Received: by 2002:a17:902:f102:b0:194:a60a:2900 with SMTP id e2-20020a170902f10200b00194a60a2900mr1404958plb.6.1675230275453;
        Tue, 31 Jan 2023 21:44:35 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ecc100b001948720f6bdsm10703959plh.98.2023.01.31.21.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:44:34 -0800 (PST)
Date:   Tue, 31 Jan 2023 21:44:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] gpiolib: remove gpio_set_debounce
Message-ID: <Y9n8P1rP+cYyoNIH@google.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127101149.3475929-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:11:46AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gpio_set_debounce() only has a single user, which is trivially
> converted to gpiod_set_debounce().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/driver-api/gpio/legacy.rst      |  2 --
>  .../zh_CN/driver-api/gpio/legacy.rst          |  1 -
>  Documentation/translations/zh_TW/gpio.txt     |  1 -
>  drivers/input/touchscreen/ads7846.c           | 25 ++++++++++---------
>  include/linux/gpio.h                          | 10 --------
>  5 files changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
> index a0559d93efd1..e0306e78e34b 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -238,8 +238,6 @@ setup or driver probe/teardown code, so this is an easy constraint.)::
>          ## 	gpio_free_array()
>  
>                  gpio_free()
> -                gpio_set_debounce()
> -
>  
>  
>  Claiming and Releasing GPIOs
> diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> index 74fa473bb504..dee2a0517c1c 100644
> --- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> +++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> @@ -219,7 +219,6 @@ GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其
>          ## 	gpio_free_array()
>  
>                  gpio_free()
> -                gpio_set_debounce()
>  
>  
>  
> diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
> index 1b986bbb0909..dc608358d90a 100644
> --- a/Documentation/translations/zh_TW/gpio.txt
> +++ b/Documentation/translations/zh_TW/gpio.txt
> @@ -226,7 +226,6 @@ GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其
>  ## 	gpio_free_array()
>  
>  	gpio_free()
> -	gpio_set_debounce()
>  
>  
>  
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 4c3dd01902d0..da3c55d9cb98 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -25,8 +25,8 @@
>  #include <linux/slab.h>
>  #include <linux/pm.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> @@ -139,7 +139,7 @@ struct ads7846 {
>  	int			(*filter)(void *data, int data_idx, int *val);
>  	void			*filter_data;
>  	int			(*get_pendown_state)(void);
> -	int			gpio_pendown;
> +	struct gpio_desc	*gpio_pendown;
>  
>  	void			(*wait_for_sync)(void);
>  };
> @@ -222,7 +222,7 @@ static int get_pendown_state(struct ads7846 *ts)
>  	if (ts->get_pendown_state)
>  		return ts->get_pendown_state();
>  
> -	return !gpio_get_value(ts->gpio_pendown);
> +	return !gpiod_get_value(ts->gpio_pendown);

No, we can not blindly do that without checking annotations on GPIOs.

> +		ts->gpio_pendown = gpiod_get(&spi->dev, "pendown-gpio", GPIOD_IN);

Wrong name, you will be looking for "pendown-gpio-gpios".

Sorry, but I have to NAK this in the current form.

Thanks.

-- 
Dmitry
