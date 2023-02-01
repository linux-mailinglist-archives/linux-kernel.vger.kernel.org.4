Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA3685DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBAD3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjBAD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:29:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B54530CA;
        Tue, 31 Jan 2023 19:29:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v10so16341819edi.8;
        Tue, 31 Jan 2023 19:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Za6O9sKNygt8ZgqoDMJLAq6ETOnrwxVxbOgdsg2ySg8=;
        b=ID0j9/f857bu8IVxOMdZo6KOHGhZVY7ptgwSgNiZqVLZBvHf7ApznbqbWVRKX9tfjg
         PMahGnTvMt9aCba2b8G4+EKuDXVULUeCMD1gTfePqDkX/6jXo2S386BBD5XIUm8teVm6
         hdf6cTfaNrSsOkPZRZu1v4lof2DE9DnLRpuOP++w/s04b1nqPyC/piDd+VD0m/4ZG2M2
         eKe7ym2Ng3y3iVvhk0mH+O3io5RZjLPxLmxPINKHR4ir05m3mnHGrRgqaitSM3xjeyJO
         8w53oeWqA/e6AMFaj7EamjzqadiWa2NE+SPQ64hW+qfGg4q2FgXxj5zYtQeZUEo765w9
         N7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za6O9sKNygt8ZgqoDMJLAq6ETOnrwxVxbOgdsg2ySg8=;
        b=ipv07CXnCChrD3wsgRamAUROoTwpNpsfRKb1jrUK+qipZAGpXfRVnmYeXKVbNPjm7I
         +lziwdN9RL6gE/gw0p6sUlNDhwjK3ZkXqT6B1i1Cmb1vuBV/YM51n3RYCszz0Q48Ynyt
         RakSf4nmtVSCYulysjrhes6eaIUA0CVIHxTwPS0ActdUWbMFjiaFwDm2vGDcuJU9RmQ4
         ORiKWURe1tN0jcv78v12Tqxee/ErbYl/yD2RAo9teSg7Egu0pkYXId4e2W5tnHyPQcf2
         9m3hx8RkqhSB5mcZArJnf/xPVACdVlRsKR6Q4J9CnNFof6kqQ28lS5eHPoPAf9KOmvS2
         GkGw==
X-Gm-Message-State: AO0yUKWjj8a6SJeudgWfXMsV/NC2HIqvhhrxB6floZZr0mCfoWrqqP54
        7WLC7Ktie/0ftiMvhu3ZcnF2QtQJMedNE9GAtyJv6Fhc
X-Google-Smtp-Source: AK7set8ULzRT5ighTT0WLuUgiqvHUSx233o6CALvXiC/A9KF7IvSq+cnbFzQial14HS/WTVzgjDEyJ7ENpRrrWiVnJQ=
X-Received: by 2002:a05:6402:1f8e:b0:49c:9760:2def with SMTP id
 c14-20020a0564021f8e00b0049c97602defmr118279edc.64.1675222189786; Tue, 31 Jan
 2023 19:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20230130131003.668888-1-arnd@kernel.org>
In-Reply-To: <20230130131003.668888-1-arnd@kernel.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 31 Jan 2023 19:29:37 -0800
Message-ID: <CAKdAkRQt15PNbwzDv0sciE5xfQ8LT76cyPepzmMdNsAYg1P1vA@mail.gmail.com>
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 5:31 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The gpio usage in the function is fairly straightforward,
> but the normal gpiod_get() interface cannot be used here
> since the gpio is referenced by a child node of the device.
>
> Using devm_fwnode_gpiod_get_index() is the best alternative
> here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../st/sti/c8sectpfe/c8sectpfe-core.c         | 30 ++++++++-----------
>  .../st/sti/c8sectpfe/c8sectpfe-core.h         |  2 +-
>  2 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> index c38b62d4f1ae..86a2c77c5471 100644
> --- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> +++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> @@ -22,7 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -812,30 +812,24 @@ static int c8sectpfe_probe(struct platform_device *pdev)
>                 }
>                 of_node_put(i2c_bus);
>
> -               tsin->rst_gpio = of_get_named_gpio(child, "reset-gpios", 0);
> -
> -               ret = gpio_is_valid(tsin->rst_gpio);
> -               if (!ret) {
> -                       dev_err(dev,
> -                               "reset gpio for tsin%d not valid (gpio=%d)\n",
> -                               tsin->tsin_id, tsin->rst_gpio);
> -                       ret = -EINVAL;
> -                       goto err_node_put;
> -               }
> -
> -               ret = devm_gpio_request_one(dev, tsin->rst_gpio,
> -                                       GPIOF_OUT_INIT_LOW, "NIM reset");
> +               tsin->rst_gpio = devm_fwnode_gpiod_get_index(dev,
> +                                                            of_node_to_fwnode(child),
> +                                                            "reset-gpios",

Wrong name.

> +                                                            0, GPIOD_OUT_LOW,
> +                                                            "NIM reset");
> +               ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
>                 if (ret && ret != -EBUSY) {
> -                       dev_err(dev, "Can't request tsin%d reset gpio\n"
> -                               , fei->channel_data[index]->tsin_id);
> +                       dev_err_probe(dev, ret,
> +                                     "reset gpio for tsin%d not valid\n",
> +                                     tsin->tsin_id);
>                         goto err_node_put;
>                 }
>
>                 if (!ret) {
>                         /* toggle reset lines */
> -                       gpio_direction_output(tsin->rst_gpio, 0);
> +                       gpiod_direction_output(tsin->rst_gpio, 0);

It is already set up as output, and you either need to use "raw" or
fix polarity.

>                         usleep_range(3500, 5000);
> -                       gpio_direction_output(tsin->rst_gpio, 1);
> +                       gpiod_direction_output(tsin->rst_gpio, 1);
>                         usleep_range(3000, 5000);
>                 }

Thanks.

-- 
Dmitry
