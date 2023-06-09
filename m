Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412A57295C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjFIJpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbjFIJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:44:45 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9081BFF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:39:50 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-43dc3f77accso517566137.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686303550; x=1688895550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZOvjl+KYnuwjPj8wMvZkMia9UoF/x6M2Pm8GzNj1fU=;
        b=HTewIAYg8quf786duI/CctcxA7gPrI2VugNo0oh1CvFgRXeezqSxn/G2tzv6nbA5nr
         KGSya9okyuMEBET7DW1QschhzujiYprvRtM2dXCWdO8EFZgbc0LzHQzx0nBEvozGCo0d
         p//9u1NrJ6wG0OM+phgZMV6sE8nKY9yb0ryKm2WH9ZmTEg4uD0BujMVAcGr5wcMlWvy8
         AOKLeEVMQm2QQmPVWBeNmY6HQKwzBZA37bno5fkZYynw71l2y1LTyuZn8FdUUTUzHhXb
         iYm4HV/kXqvHHeruvbE/Zk43KLw3xkC/d4qqRmoeWrgyZMJR0aSrIchxFYTU3TtLmKbO
         RhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303550; x=1688895550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZOvjl+KYnuwjPj8wMvZkMia9UoF/x6M2Pm8GzNj1fU=;
        b=h8M2tkIG7loY28vCm0Hj2iR5SeKl+SRtMQCrWhZy8Oyyka3Q3efT7Rsfhdvs2RHMmT
         7jCSgA24tVlQE8WbDA9lCuUEL1oo1rPD29YxxA4hEplRXu83rk8E/H6BeYxG+SWoXBEQ
         mjTdjzJqm0V09+yt+iDI0Jg3TK+gJ9yK5VDV0PTA2x6jCqKM5QeWSucj03RN9JDANiAY
         kbkA3UVkCZOWKB922WSfouM4Gc5CivcIMZG0AABMcJDjLwGSikJg3siOILwliuW7VCnh
         jrPPpaIKcLyYh04EKNjfKM+3lQ4zhFLrn0Rh+Qxik6Xa38OSyWTu1XSaqvbGjhDOGcQR
         Ic3A==
X-Gm-Message-State: AC+VfDwoTGzJFx3iwSeGptqAoJkg/jNYKuUYQEcp4YpCsM++IR5j9wn9
        qgpDxtJoQ2oRhSL/NSNZfRa/VAArwtJSGXJuk/rxSp/zwRaswLkR
X-Google-Smtp-Source: ACHHUZ6ookoq9XF4FuMkQPAWhkCYvNPv8RIYZ7pD5vhFYy92iWzbLEsqF15OSs9k96UjYo8p4ePG3CBGpIhQJ4oDpec=
X-Received: by 2002:a05:6102:408:b0:430:e0:ac2e with SMTP id
 d8-20020a056102040800b0043000e0ac2emr498462vsq.15.1686303549994; Fri, 09 Jun
 2023 02:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125810.61456-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230605125810.61456-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Jun 2023 11:38:59 +0200
Message-ID: <CAMRc=Mf_TamPbL2m2RnV9NNwXKe=P=7cbZy0YJkFw6e=L64xNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Do not unexport GPIO on freeing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 2:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
> Kill unused GPIOF_EXPORT and Co") there is no need to unexport
> GPIO on freeing. Remove that call.
>
> Note, the other users of this functionality do that explicitly,
> except one SH and one OMAP boardfile which don't free GPIO anyways,
> so it is safe to drop the call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: mentioned OMAP boardfile as well
>  drivers/gpio/gpiolib.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a8da38ee721a..7a9c9934365a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2117,8 +2117,6 @@ static bool gpiod_free_commit(struct gpio_desc *des=
c)
>
>         might_sleep();
>
> -       gpiod_unexport(desc);
> -
>         spin_lock_irqsave(&gpio_lock, flags);
>
>         gc =3D desc->gdev->chip;
> --
> 2.40.0.1.gaa8946217a0b
>

Ah, you already sent a v2. I applied this one.

Bart
