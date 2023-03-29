Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB746CD893
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjC2Lhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Lh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:37:29 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E540E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:37:27 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id n17so11087392uaj.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680089847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g51Q4Tu8fp/Rzn2CfJ5imCFgpcoPRbT7aJ+EXc3cRP0=;
        b=JiPYir+3q973/+LAd8/0WhIxsgTQPg1gD0U5QuiGzpX92a64tQz4AKEqU2JKF9SXxD
         /nmE/X6L0zSlazsiXv7OcQm7651aspavCtAK95FwSWhIJGJG3s9joE0wMsvPWszhpK4T
         H72YnSg+y2CxI13TMuYCKtOBDrB5Bu05XKqRaGlNCfQrtABe+MGnZNxo779zecIAQ5aU
         6xkMV9ojo1eob6bKb9lZ78uhQLqCjJMStP3UQYQo6tacMKwNtfzSDcZlo4hSKDdu31bz
         6sZu/VOTGd70ozX/JohDh6IDEtML7sZuxGO1FlE/Dn+q13jGNpS0hGrMZ24C7M8vua/t
         97bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g51Q4Tu8fp/Rzn2CfJ5imCFgpcoPRbT7aJ+EXc3cRP0=;
        b=dEJ9GVVCZ0ayKP/3u1I0DXnBtfRi/9oRmdlrZVwZWDiC7hi7UamWtSiRB29b8+wnzq
         NZ8xI9AkaLWjanIywZkRISz+ignkDFr1t7Ut78SzMqCqlRH7Gne3DdnRatYNvjev/wzd
         RUe6BhbU1olKgXisTmql6NToYtRQ32t7tDtW8Eu/Wcs51R6DIOTEE10DqUnSR5BKWxVT
         ufLI0yiplxdztxd5I3WCDf9n8E7w8aD/18fnGF/Zngoo5g1rseI0LptKbRK1Y0xurhYc
         0ITEw08TG5UW5M4egnHQQkoYAxQKbUUBoVxJTT7GsTuv+0L+4sWfLv8+N9BNnfqN1eVE
         KbiQ==
X-Gm-Message-State: AAQBX9cBI1AXutGJ0rqB67tzS2l7YtVpM+KWg5kl7pqpWtDH2b+K6Cd5
        ruc4VrWXaAfM1ZppMWJzaAsrlQ0bdT0MSDrS6zYy4A==
X-Google-Smtp-Source: AKy350YqPdiHRbWnvpq8LBYFUHmYcGm0qvONzHR6X4KgdMSxAL6WXk/tGnKHxAQg/xVUWVcvjbtOMjq/wTQ6qWosarM=
X-Received: by 2002:a1f:b2d2:0:b0:43b:96b8:1a9f with SMTP id
 b201-20020a1fb2d2000000b0043b96b81a9fmr6782532vkf.2.1680089846918; Wed, 29
 Mar 2023 04:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230321135310.73153-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230321135310.73153-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Mar 2023 13:37:16 +0200
Message-ID: <CAMRc=MeBbdHYV-_2utMBVy-31GzGbWM8GUD9RRV8vYQ3OzHWrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Split property name from the warning message
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 2:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Split property name from the warning message to make object file
> shorter. The linker will use the single copy of it. It's fine
> to pass a pointer to the printing function since it's a slow path
> anyway.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 51a19cbe39a4..112d99a5eec4 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -403,8 +403,8 @@ static int gpiochip_set_names(struct gpio_chip *chip)
>          * gpiochips.
>          */
>         if (count <=3D chip->offset) {
> -               dev_warn(dev, "gpio-line-names too short (length %d), can=
not map names for the gpiochip at offset %u\n",
> -                        count, chip->offset);
> +               dev_warn(dev, "%s too short (length %d), cannot map names=
 for the gpiochip at offset %u\n",
> +                        "gpio-line-names", count, chip->offset);
>                 return 0;
>         }
>
> --
> 2.40.0.1.gaa8946217a0b
>

I'd say being able to grep the code easily for messages is more
important than saving a couple bytes here?

Bart
