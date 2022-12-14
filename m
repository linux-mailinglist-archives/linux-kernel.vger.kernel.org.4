Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1964C553
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiLNIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLNIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:54:21 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511851AA0A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:54:20 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id f189so17206271vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXjEWuax68qWKJcttENVw+XN0QPH0HkqIrN33AvDPB8=;
        b=SeudXmB1MMQoKP1vWQUJF+Ghoir7e32kxGwbVDSWlp7nYEbvnt2uFsoTbtPmXUWKqK
         M3BC5RkOv+9lAkAWwqsvLR6nlaVIZB5YHRqNsj2lrrvIFm33bPthdHd1cZbjNAyKNZUL
         6BKgCyKGtafJ1RtkaEKf9oP+zntDKis+yOHRPi4+eQdniRWAVUNc5N1dMDutdhlNzkOU
         m/NVCDzp3fB2coymE7b/DlrepSIW8vkkmlY4Cw9+A/VKBQZSWFwui44C6ToQnmjJClCs
         yXytboF5ZMBUEUa3JWZURpydrB6By60/n+EY/1sdH7KsdqSV4ZdZzlX7VyvsLVXMXoZT
         OLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXjEWuax68qWKJcttENVw+XN0QPH0HkqIrN33AvDPB8=;
        b=Let4uX1f+mNmYNncyDgWK3aM8WzB3HBP8NSsFW17W19DnVm1kttBp9Fj8et11aRrH1
         f83vTXHe1bO8Q7+fvKJ0Jd9IYL4iDEbmSBsqQeBqO5HOP7Oo2DsScVrHHDeiuSg8ZlQv
         cixINskK4hPu64kBhR0QQXnJ41a5X2tSjJNgVLeQtsmveciYYKyJKNx8gqFog6k8o43U
         NaGY+XWTWur3FNe36pYG1ksy0Ymlxlhp/l8q5WwueaKk8bofRanJmuOAp1eCKnOQLAWH
         +EAMSZawgAnFyy7f9k1fTvjNMvvwA6Ipcok6EgjkxjAX0UGmd0HlPkACGERn66yVX3MF
         SADw==
X-Gm-Message-State: ANoB5pkIVg/WEuakR5xwI/v5f4uZQ+aD+QkjL+RkikEtfqS183EZI91F
        3c7qFKXlA36M10aXv+YVC3ZSBdEojIZcUxD2hZhGKQ==
X-Google-Smtp-Source: AA0mqf5Qi64j7EBBegzHu3WIzrlfAQ9x/VClcG1ccOHk09fQHOuRdWCIsCZqS7aJVtdAQycKSPIZtIDkQfua/FWkbf8=
X-Received: by 2002:a67:fc4b:0:b0:3b1:298c:45f9 with SMTP id
 p11-20020a67fc4b000000b003b1298c45f9mr13688545vsq.61.1671008059323; Wed, 14
 Dec 2022 00:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20221212130748.443416-1-brgl@bgdev.pl>
In-Reply-To: <20221212130748.443416-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Dec 2022 09:54:08 +0100
Message-ID: <CAMRc=MdhuQHcnWyjn5xGto219f7T7jR9XQ8KtmcZhnp63ZkiLQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: set a limit on the number of GPIOs
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 2:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With the removal of ARCH_NR_GPIOS in commit 7b61212f2a07 ("gpiolib: Get
> rid of ARCH_NR_GPIOS") the gpiolib core no longer sanitizes the number
> of GPIOs for us. This causes the gpio-sim selftests to now fail when
> setting the number of GPIOs to 99999 and expecting the probe() to fail.
>
> Set a sane limit of 1024 on the number of simulated GPIOs and bail out
> of probe if it's exceeded.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202212112236.756f5db9-oliver.sang@intel.com
> Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 1020c2feb249..60514bc5454f 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -31,6 +31,7 @@
>
>  #include "gpiolib.h"
>
> +#define GPIO_SIM_NGPIO_MAX     1024
>  #define GPIO_SIM_PROP_MAX      4 /* Max 3 properties + sentinel. */
>  #define GPIO_SIM_NUM_ATTRS     3 /* value, pull and sentinel */
>
> @@ -371,6 +372,9 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>         if (ret)
>                 return ret;
>
> +       if (num_lines > GPIO_SIM_NGPIO_MAX)
> +               return -ERANGE;
> +
>         ret = fwnode_property_read_string(swnode, "gpio-sim,label", &label);
>         if (ret) {
>                 label = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> --
> 2.37.2
>

Applied this, as it needs to go into the big PR for this merge window.

Bart
