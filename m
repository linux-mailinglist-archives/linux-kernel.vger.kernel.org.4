Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D963B110
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiK1SUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiK1STX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:19:23 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97662AC4C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:04:39 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id e26so4141662uaa.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aRgzKDDptj0PxBFeuEtEc9q33zQBrpSSLaR4YtDSbi4=;
        b=C9ZJknN+wkJeX8M3Cjm9f3H3y/u6tuWrAoxCrAgggba7HtYO0uFWrecbxIS5Dbtsnp
         HhUCP5UvL+eQXK1pa/Tt4BtBynUTozu86apzWmnxbkVRkH11tujGhqd3tXsGs/R9MNJy
         SrXBzC/TQoi79Lcp0SlQstazoA3dRRMpy77LxmXbhzGKILbAmsk5ErRGJJ7t5/nKr2bL
         eYM1/hhxt9aThMHStNm1la/suz0AvHkvIZfV1+mlE74IjSNYYh4hDUPHb/NVejv4xkOb
         QQC/oZ0L+bgcE1SvrjaAb42+vRdQAA/rtZ+NeQToJXfUcRmzzJ09m551ffblm4RccNvY
         qDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgzKDDptj0PxBFeuEtEc9q33zQBrpSSLaR4YtDSbi4=;
        b=H4+nm43X5XIP9DBNl5cK5OUXmWaiNg1oRf6q6nNMi9XkOmR9slBJ9k+AO5e6+v1AyC
         fluFu4dN+JZNkN6AyMs9rLSPtiiS6xW0RAHGAgHpgSz7EyfhhOwN1vmJI53IyGj5PVeN
         W/WGtuPzY/iC7AR80MGOoEMXUCzCJfJQOxJWt6im5G/1+5wI7e6arM5HJANkDvj8yrSS
         9VMoZIHL8+o9f0UZPM8AZDz6kz7tNvcCJgJiU1p+fwdnkQZznml1pGM/1W9nVMsMSf2U
         zO6mn5UacOnvWFghXJJYjYn09WJLFtjrRPgp/VN9TtyRYorNHpPPTlhNStY9rmUSk25Z
         ngHw==
X-Gm-Message-State: ANoB5pktrLz455Ri0bOQVlL9xzhdxcmlgkXVZs3hhZQai8Grs/WvDpHw
        OYhuTT7JQ6ghomRNWs6bvaw25uoQ6HeM+WC+j7nbLA==
X-Google-Smtp-Source: AA0mqf64DMzI4oiza1999/BrhLICzwvgy6pMHkTJ5IIJZxW9075dgEkwf5Ft3rQnDp9xVNlkFxDXk3btaU4mmPD0aMI=
X-Received: by 2002:ab0:7785:0:b0:415:65dc:4733 with SMTP id
 x5-20020ab07785000000b0041565dc4733mr21352191uar.87.1669658678871; Mon, 28
 Nov 2022 10:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 28 Nov 2022 19:04:28 +0100
Message-ID: <CAMRc=MccBY8ov4CGB3uWNBsWSAw48vWY8mekZg53QB1pF+itLg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Provide to_gpio_device() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Nov 25, 2022 at 7:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Provide to_gpio_device() helper which can be utilized in the existing
> and future code.
>
> While at it, make sure it becomes no-op at compilation time.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  drivers/gpio/gpiolib.h | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 119c9c3a2a50..9b935288db9d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
>
>  static void gpiodevice_release(struct device *dev)
>  {
> -       struct gpio_device *gdev = container_of(dev, struct gpio_device, dev);
> +       struct gpio_device *gdev = to_gpio_device(dev);
>         unsigned long flags;
>
>         spin_lock_irqsave(&gpio_lock, flags);
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index d900ecdbac46..027674025561 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -20,9 +20,9 @@
>
>  /**
>   * struct gpio_device - internal state container for GPIO devices
> - * @id: numerical ID number for the GPIO chip
>   * @dev: the GPIO device struct
>   * @chrdev: character device for the GPIO device
> + * @id: numerical ID number for the GPIO chip
>   * @mockdev: class device used by the deprecated sysfs interface (may be
>   * NULL)
>   * @owner: helps prevent removal of modules exporting active GPIOs
> @@ -47,9 +47,9 @@
>   * userspace.
>   */
>  struct gpio_device {
> -       int                     id;
>         struct device           dev;
>         struct cdev             chrdev;
> +       int                     id;
>         struct device           *mockdev;
>         struct module           *owner;
>         struct gpio_chip        *chip;
> @@ -72,6 +72,8 @@ struct gpio_device {
>  #endif
>  };
>
> +#define to_gpio_device(_dev_)  container_of(_dev_, struct gpio_device, dev)
> +

Just make it a static inline, please.

Bartosz

>  /* gpio suffixes used for ACPI and device tree lookup */
>  static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
>
> --
> 2.35.1
>
