Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08336F6B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEDMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEDMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:23:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2D95FE1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:23:07 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a5e0f5b1aso3112517b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683202987; x=1685794987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFy1RBKM5Kcpg+NQ3BgZ5VLZiasvJE1KM8oJrv46mjo=;
        b=k8NGS2RoUaPlaFGnbNnozITZIC7RFzujBKehrchANS16GXgN2iRN7A8pcae/DY5ArN
         r98AVlVzAjzzwgwR7KQf80ueCnWJywuFiWLr5scCj3gK1yGJ5mLGpKlVlZF5ZeGS/M/x
         F8qhdfp46a1EM/ksrOdvkVmxPw5QUC6vENxN6mWILgEL7K/BXLiNdL6WZ+b+kwHO6UqL
         wdqWQCR6sE4Vv0P13PfheKzjD5G61R6EcrwIMBlOFkGk4Gudf7b3PySuxzc6bB0jO2Bx
         vph91wx7L5lF6GEE4ek4SMI9xgSEhbyMZuRx7A64D+t1q/WFhjk5atGWdEWBlIDIQWM4
         Y7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202987; x=1685794987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFy1RBKM5Kcpg+NQ3BgZ5VLZiasvJE1KM8oJrv46mjo=;
        b=atILP0Hm7CuB/SVxaIEbdwblEyEjUVNwzmoyxa+NSWIvZY0dmfPLCbxa8j/gzqNDgG
         SGgZEdgPlDprtZcmd743Awf9qPsXal03qX9alqyPEDSz6yd4TrKn3xTzv/hn6eg9LWrq
         1f3j3B8RX/rdcBCgS4Qz7R7ogVN9YrvKq+2Tt07cUa6ilX1wGWlYBmSZ2NnMNjeiWFde
         bWrKGbrxuFXo8tLZkwETD2FzQDBXFy6gal3JsbYTbeiFfxWxjcmXO/51Lu0IsURsjaZz
         lTMi1OQz2iR730MqXB9JkSeXh0Wb3VUcIbCWUu4mhFq/mELJ0lR9/LxnyD81xa8zXLcY
         PWcg==
X-Gm-Message-State: AC+VfDzDfHCg5QfZFo6nwGuo/U2eJITdf2GsBq+D9IIf1h4FQTZmRDys
        NC+6E9of6N/wkR6wJ+1TPdvRgrdwXjH1+PeUCtuyVq1jSWNrpBc7
X-Google-Smtp-Source: ACHHUZ7JAeBstDHq+3hR0npxfBMjYla1Q+/pPK5AHGlISOXcDEwBbF5CxCX3cGaKL2oYcROZ/tLej+iD9Pk4osSuIMQ=
X-Received: by 2002:a25:1885:0:b0:b92:3f59:26e with SMTP id
 127-20020a251885000000b00b923f59026emr21205278yby.41.1683202987075; Thu, 04
 May 2023 05:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230504060421.804168-1-andreas@kemnade.info>
In-Reply-To: <20230504060421.804168-1-andreas@kemnade.info>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 May 2023 14:22:56 +0200
Message-ID: <CACRpkdZ=ri8OxqwtLqQe--GGkNDdY7NSzyhzHLfcCv99togfJQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: fix allocation of mixed dynamic/static GPIOs
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     brgl@bgdev.pl, christophe.leroy@csgroup.eu,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 8:04=E2=80=AFAM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:

> If static allocation and dynamic allocation GPIOs are present,
> dynamic allocation pollutes the numberspace for static allocation,
> causing static allocation to fail.
> Enforce dynamic allocation above GPIO_DYNAMIC_BASE.
>
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
> but let's also fix that for devices where there is still
> a mixture of static and dynamic allocation.
>
> Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: <christophe.leroy@csgroup.eu>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
