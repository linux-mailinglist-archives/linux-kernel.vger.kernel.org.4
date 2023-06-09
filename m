Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3809729BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFINrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjFINrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDC30F4;
        Fri,  9 Jun 2023 06:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE35B657A5;
        Fri,  9 Jun 2023 13:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A2C433A0;
        Fri,  9 Jun 2023 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686318449;
        bh=Fpy7celFZGatD5owR93EUYOL5tv2PvT6RXRUlBKZx+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=juAfkEV/QoIFMNIJUtOB5a7L3bkm1EOeqnE37OXZH0LvR6jQVRnqApSJ310AvPzIl
         iTV0FDk6QljWVYFatQxg7hhwHGzSmdHGr8VjMzNdQAY2dKzbYDhizAxFcyhf3AAyWU
         eJuZNlJcvY9ZC1JSjk4xgv6sX2aZ+GTMr6m0iOw4GdPoOQ8FeqGQNLbMfMLmQXTHxR
         7kLAaT+fzxieDkI8HrQYC6PBnfdymx0Ntxm1V+N6b5xhsCoy2BCaGaIJTFTI7ZvA8o
         GILje+k/mOdhKsxHTk/EmeqfKVxyAhYvGdOfdEDNf1/iscnX3K7sYGxT9roO1YWSna
         VpyKIrMQo1WXA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b1ba018d94so19857701fa.0;
        Fri, 09 Jun 2023 06:47:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDzo9s9aybsoyeuHyKP0+vmGvFWnPuAn8HxgaPBksPO1CkjPsqtV
        BdN4TQ3CQhZ1ZQ89yYcnkTZwpNshUCbYXoN4VA==
X-Google-Smtp-Source: ACHHUZ5RY7MY7nzfB0xginROJl3JTEIDk/s2SmvBClsN/NmPZzW+X8ZT/ej5ju6vEi1Q4GR7Z/SMr6RguI0NQ2BLwHQ=
X-Received: by 2002:a2e:961a:0:b0:2b1:b831:47d with SMTP id
 v26-20020a2e961a000000b002b1b831047dmr1153093ljh.50.1686318447024; Fri, 09
 Jun 2023 06:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125248.279921-1-brgl@bgdev.pl>
In-Reply-To: <20230605125248.279921-1-brgl@bgdev.pl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Jun 2023 07:47:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
Message-ID: <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 6:53=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Drivers should be silent when they work correctly. There's no reason to
> emit info messages when GPIO lines are hogged. Demote the message to
> debug.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Suggested-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib.c |  2 +-
>  drivers/of/unittest.c  | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a7220e04a93e..e4515bda8915 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *n=
ame,
>         /* Mark GPIO as hogged so it can be identified and removed later =
*/
>         set_bit(FLAG_IS_HOGGED, &desc->flags);
>
> -       gpiod_info(desc, "hogged as %s%s\n",
> +       gpiod_dbg(desc, "hogged as %s%s\n",
>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
>                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" :=
 "");
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 2191c0136531..0060334a98a7 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
>          * driver is registered
>          */
>
> -       EXPECT_BEGIN(KERN_INFO,
> +       EXPECT_BEGIN(KERN_DEBUG,
>                      "gpio-<<int>> (line-B-input): hogged as input\n");

As debug messages are normally off, I think you can just remove these.

Rob
