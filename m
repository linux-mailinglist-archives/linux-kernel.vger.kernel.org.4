Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83183622C33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKINNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKINN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:13:26 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FFE24
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:13:25 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id g16so10963853vkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xGpBG68yF08lFUOD8FBdV6g+IPjUuqkuqMR+0AcmSk=;
        b=Y15zyMu5aj0OdVFCG2o69gYSzZu8TjRpqnGEAOUbLWgV8/N3lcgs6OLiOUGYsksj8T
         1H5ymxeAJt+w9z+BfBjUpEf++Ps7GDZULzl0y+SVk0rGrs/AJLhZUFaaolqQG9wWqrN1
         ie5IFmKCDXaqb5fXj3pWCd4A6aXlLSpq2plpJR0S1lDTvxkRiQdM5IVEyxhz9yQ4aOB6
         WOEw9sk/87nuFTr0OHku6N1YreSM4POJYQ3mJtO+e6UIu/IoejNCovvtZBXMeiaoQje1
         JqgFyQzgMc9ZEWQqn4+jZhCtzNwW6BibzCrq+doTz2I8cHtKMPcSivo0Ateq6M4PXGIv
         19fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xGpBG68yF08lFUOD8FBdV6g+IPjUuqkuqMR+0AcmSk=;
        b=jO2kRv06KNf2KVEyJDnX4n3PpbkOhfVoy0b84oF8re6Pt9H81wksgza37vBgrJhYN9
         yqnnqG888eTfI2BeOKw/fW6fNYalzele//YVpAcM/Zx/vuguYaNDsW2m9RzkhAxsB+Tu
         wDE5XnPjZHcmNNLdrgC4wqPPjd8wP9IYFk6ObcYfTmFaaj4D9OEjrri3GFaET5vZx0JE
         MnESnWM0u4DMaJDdY0nKxFzfVA55TmU7DM2KM2O7GEeg/nXelKKACS10UGSvDtlEj7nA
         GMsgL34DNkhR/vwk06c+BrfWGdNA/luiGYJJtbipK9idSy+JUhlu2Wbqk3mgkkHaclm6
         Nrbw==
X-Gm-Message-State: ACrzQf0L7E2Q/RaAxFScJiVt8AfZLksJ8iJLqxOX17VzTEfpKiIWjUsv
        PBZFrk6dUZFFJMXHjzpT3tqXANLo2jxuirfGPKGqKA==
X-Google-Smtp-Source: AMsMyM5aeaov7lpqDjWPDYQ2IhfUZRVLWjPERcWKtCe9KmX1ljQiJnMOLPgKrRur21mGztSmpgdFUq4KzpipyJbLj1M=
X-Received: by 2002:a1f:a695:0:b0:3ab:85c0:e1e8 with SMTP id
 p143-20020a1fa695000000b003ab85c0e1e8mr13359359vke.1.1667999604912; Wed, 09
 Nov 2022 05:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 9 Nov 2022 14:13:14 +0100
Message-ID: <CAMRc=Md7yN2cw14EAPbODGeLOXw=7VGceK_uYdTx-NsN6P64HQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 5:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
> +       struct device_node *np;
>         int ret;
>
> -       if (!chip->of_node)
> +       np = to_of_node(chip->fwnode);
> +       if (!np)
>                 return 0;
>
>         if (!chip->of_xlate) {
> @@ -1123,18 +1125,18 @@ int of_gpiochip_add(struct gpio_chip *chip)
>         if (ret)
>                 return ret;
>
> -       of_node_get(chip->of_node);
> +       fwnode_handle_get(chip->fwnode);
>
>         ret = of_gpiochip_scan_gpios(chip);
>         if (ret)
> -               of_node_put(chip->of_node);
> +               fwnode_handle_put(chip->fwnode);
>
>         return ret;
>  }
>
>  void of_gpiochip_remove(struct gpio_chip *chip)
>  {
> -       of_node_put(chip->of_node);
> +       fwnode_handle_put(chip->fwnode);
>  }
>
>  void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> --
> 2.35.1
>

Applied, thanks!

Bart
