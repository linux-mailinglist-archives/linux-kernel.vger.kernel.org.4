Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38486F2464
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjD2LL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjD2LLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 07:11:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D5C199D;
        Sat, 29 Apr 2023 04:11:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef33f12995so3990511cf.3;
        Sat, 29 Apr 2023 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682766683; x=1685358683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX1/EEyk9xXLvQqBe37n3RdcEO2pLurpeMiD17UTbTs=;
        b=A01Ejd9CB4zCK/Va1s1K9Z4mLmriZnmXBjDLpKj6fIV4PrcL6274UsoTlx6tiGlo3J
         Tf8ZrKkwUyZCXZ2ib1e2f3OYLkJ9r1bd+2o8yCAfDrwa19X/A6SgRcDDvNafIplVUI/G
         wkcQuMEwF5/OA6DfXmguDm9+UCXSINPCaGX4RPhMltWMNVVkVdvwPDJ+yDc9q0sqMZl5
         XCkQkEx0v+NuWenON0zkoehMeiiGB4JKtfNIdNskU5t8Rv0CImwPWaC9jsKQBpV7Yx6b
         etfBZszSLR8XTJj28tLU4QX3BbQ4GfLTv8SLy05D1P92vJ5bVuFhfufGXyAUWDQPxntV
         nkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682766683; x=1685358683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX1/EEyk9xXLvQqBe37n3RdcEO2pLurpeMiD17UTbTs=;
        b=dhnYe1b2HIuy58vCOemkHR3I08mK5N7vvDwHs5TZieU7BczI9MbBThEnTTi7vVQK50
         1R+4VDzvFxdB6ZcNsiGNAwnZPr2KqzAAmfeV5a5aNwFySeQsIQoi0dEwYen6gZ6C2jPa
         gTUdxDv/sOP4vMc5JZ2ueykrptQo4gqNqNgu8e5EhTu/krv9U7iAYRIqxqQa8woKATtY
         U40N18Mx70BYQCesCsNwr+ptB+hs2LDAXR5MsOuTQvm+hejmIfw7npn1QIFXM8x7OehX
         fh9dRrSrYq3HpLCt97m6jb8ol7cQTeOH1iLSx5Bn5uCDMyz496S3FMfcrZCjtavXt1ad
         mzpQ==
X-Gm-Message-State: AC+VfDySn0tgF+pgvlO1w9Jv4iJy7DlYm3ilkjS4Iw6FEsbDP7SDK0zf
        VuCCtnuGtR26R5977460wt4f3W3FNHZ+cxW257g=
X-Google-Smtp-Source: ACHHUZ5I0DskjV6EwNo65xx80cLj5WRrF1tmqU+2NYSElnE5HaXX61LvPeJhLEhwi9LuG5LJsazF2T22kA0eHNErDEk=
X-Received: by 2002:ac8:57c4:0:b0:3f2:f11:76e0 with SMTP id
 w4-20020ac857c4000000b003f20f1176e0mr2451809qta.1.1682766683215; Sat, 29 Apr
 2023 04:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230428194541.510674-1-andreas@kemnade.info>
In-Reply-To: <20230428194541.510674-1-andreas@kemnade.info>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Apr 2023 14:10:46 +0300
Message-ID: <CAHp75Vfv5kO2q+xF6=fRMfMsM3xajfRs8iR10d06dfogBfYAOg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: fix allocation of mixed dynamic/static GPIOs
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        christophe.leroy@csgroup.eu, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:45=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
>
> If static allocation and dynamic allocation GPIOs are present,
> dynamic allocation pollutes the numberspace for static allocation,
> causing static allocation to fail.
> Enfore dynamic allocation above GPIO_DYNAMIC_BASE.

Enforce

> Seen on a GTA04 when omap-gpio (static) and twl-gpio (dynamic)
> raced:
> [some successful registrations of omap_gpio instances]
> [    2.553833] twl4030_gpio twl4030-gpio: gpio (irq 145) chaining IRQs 16=
1..178
> [    2.561401] gpiochip_find_base: found new base at 160
> [    2.564392] gpio gpiochip5: (twl4030): added GPIO chardev (254:5)
> [    2.564544] gpio gpiochip5: registered GPIOs 160 to 177 on twl4030
> [...]
> [    2.692169] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> [    2.697357] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> [    2.703643] gpiochip_find_base: found new base at 178
> [    2.704376] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
> [    2.704589] gpio gpiochip6: registered GPIOs 178 to 181 on omap-gpmc
> [...]
> [    2.840393] gpio gpiochip7: Static allocation of GPIO base is deprecat=
ed, use dynamic allocation.
> [    2.849365] gpio gpiochip7: (gpio-160-191): GPIO integer space overlap=
, cannot add chip
> [    2.857513] gpiochip_add_data_with_key: GPIOs 160..191 (gpio-160-191) =
failed to register, -16
> [    2.866149] omap_gpio 48310000.gpio: error -EBUSY: Could not register =
gpio chip
>
> On that device it is fixed invasively by
> commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")
> but lets also fix that for devices where there is still

let's

> a mixture of static and dynamic allocation.

It might be that it can be optimized, but OK for now. Thanks for fixing it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in V2:
>    handle also the case of overlapping static allocation
>    across DYNAMIC_BASE
>
>  drivers/gpio/gpiolib.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 19bd23044b017..4472214fcd43a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -193,6 +193,8 @@ static int gpiochip_find_base(int ngpio)
>                         break;
>                 /* nope, check the space right after the chip */
>                 base =3D gdev->base + gdev->ngpio;
> +               if (base < GPIO_DYNAMIC_BASE)
> +                       base =3D GPIO_DYNAMIC_BASE;
>         }
>
>         if (gpio_is_valid(base)) {
> --
> 2.39.2
>


--=20
With Best Regards,
Andy Shevchenko
