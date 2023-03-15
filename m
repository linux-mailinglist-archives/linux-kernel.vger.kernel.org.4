Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969AB6BAC89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCOJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjCOJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:48:40 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878445CC34
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:48:27 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id f13so16445773vsg.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678873706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9wrGaACCmAawpvI5IWRWR5riYVn9bE721EgbamNCo8=;
        b=M3I5pqT0ftPGbU3JaYLh3CiD3Ge+e+0lK8AcQCt7aB7PF8QByEm6O/bbsd7ZvCk1yd
         odUDFSa9CLgnP6U9nZnpsD9vN70O8UXTK16HB64m7k528iHbd33Gu3HzLARTz1wHwDvV
         ZM8XD2odSOLMq1n5xx0vdB3sb4tv7RmpkRI65qO4mYibDZdraZkcE977MdHxYecZHpUw
         fJhgyOFNy1+TF/1tjvmkHsVlDYLFT6fQubCmefWUKlm+MvZFy2VMeK/jLUfzGRIDFdX7
         KWqhtI5eYAzLBJTsFWmJnTbUmRkYWwcfPF0A0seS+qxxCG9jQlfPE+vR09SjRSURvtIV
         Z2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9wrGaACCmAawpvI5IWRWR5riYVn9bE721EgbamNCo8=;
        b=MPGnBz2cZatO7SEms0GmiWN8EP4oke90PsOFu5Hv26WHNgdXJB3Dcm1bm00xUyUIUS
         ODfnswk/6/lQEmQ06cEnorBrao1drpzMc/yG+PX5YWfje01FUYJOQJ2dWt/ErYTfStmd
         7NhQZ+PCQMPKrTuhcEVIm9Ua0D15RepMaZWbEvpD2nGP4Z7aUVoNBUgo+/Tx/RY7MaW1
         7oDpgt4s1nEuGnzeCuQvL0vRLA0tyGZuV65D6u96b5sM+0++wbXd8RS1UR3nHC51CYy4
         O0rLKcWOp3AKWzcIqQkN8enzC6gQsQhCOQeDB5qzqJWmQ6wapVZ/iY1Abp0vLkTFZnj1
         VbEA==
X-Gm-Message-State: AO0yUKUNh0/6c3saGPAth9yKseA7/FDyeB/ohlj9fWCWwOrmzUt/KHTq
        xG31R0avjH1fufsHJsMvVeD9FUkUflWgGEEXKhHFag==
X-Google-Smtp-Source: AK7set9AFjmytAOZT2FHo+ktlYDH9ACmI1Dub/5Du0LrMXs2zgBbrQAxme3xfQUJ2jg0BJ7+0oGr3YhpKWzuXaFHdkI=
X-Received: by 2002:a67:ee48:0:b0:425:a141:2af5 with SMTP id
 g8-20020a67ee48000000b00425a1412af5mr4480269vsp.2.1678873706649; Wed, 15 Mar
 2023 02:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230309185626.84997-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230309185626.84997-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 10:48:16 +0100
Message-ID: <CAMRc=Mdsnvrh1NtKoSHwG-5NETGqjiZytPOJ-45YJvya1k0Ngg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove duplicative check in gpiod_find_and_request()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The gpiod_find_by_fwnode() already checks for NULL and returns
> correct error code in case fwnode is invalid. Drop the respective
> check and assignment in the gpiod_find_and_request().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 8ecfe3afde1e..333ccd44e2b2 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3927,13 +3927,10 @@ static struct gpio_desc *gpiod_find_and_request(s=
truct device *consumer,
>                                                 bool platform_lookup_allo=
wed)
>  {
>         unsigned long lookupflags =3D GPIO_LOOKUP_FLAGS_DEFAULT;
> -       struct gpio_desc *desc =3D ERR_PTR(-ENOENT);
> +       struct gpio_desc *desc;
>         int ret;
>
> -       if (!IS_ERR_OR_NULL(fwnode))
> -               desc =3D gpiod_find_by_fwnode(fwnode, consumer, con_id, i=
dx,
> -                                           &flags, &lookupflags);
> -
> +       desc =3D gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &fla=
gs, &lookupflags);
>         if (gpiod_not_found(desc) && platform_lookup_allowed) {
>                 /*
>                  * Either we are not using DT or ACPI, or their lookup di=
d not
> --
> 2.39.1
>

Applied, thanks!

Bart
