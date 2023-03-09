Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540036B28BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCIPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjCIPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:23:02 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECEF1444
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:22:31 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id d7so1955831vsj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678375350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnQ1JLkorEsC0faYzxDw+JFZG2Ei/m3Pat9Daw2w3Gk=;
        b=Q4LtAtcwLUPWrpzaXeGN56IlGGfWu+kYpEOvHSLS/L4jH1ri6By3E9pqF9M2TdUYbT
         l30gkFtPBW6LwRTH9Efqo6pOwGoYv/8Jgf1ijfmXIiWOqJKGs+UxQD92eqp6kQuLKVmF
         lapgpQDEfjPQoL0LG+RQW+qABMNzbhGcOBF33XEfm0aIRsspijGgoE/xRXYMKUrqrK4s
         aLHab+Itc7i0Lt2vhCR8bSvo5Lt8cXFNzMUY9gjQqweotGH4gbTuMHU3flHb2DDCuoDj
         kT5evC8vWodEdpmrNIVfgEWgDfE8GHMGg9pv7TIKsKW0PdRCHYgx+Gjc4M4vdEeUXZNR
         Pceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678375350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnQ1JLkorEsC0faYzxDw+JFZG2Ei/m3Pat9Daw2w3Gk=;
        b=0GdGxmucyKIDISv+gy78xerNwXvOyM2O9FabN7LjnyeWuEi6b9qG3R3E6Ox7J+Up1m
         3GUecsirmz3Eghp4I4davtWqyemX9/j+qz4of7DgnEsswIlnbKMSi72r0ITrdj0HRFZR
         fw/vNc7H3UKvmyEoqDLuNs6SBwDtTgyEnhb3OE7TOisgyXjKKb6DAPw8ydbVn5RgzZ65
         4DPYj5s+6XO3F7R7wg0elw7LEiqTZaDouWq7B8NjTTiPaKUY50IB8fXM4KfOVxm/5jrS
         a7RwDxDA1D8WamFOIVCKc5o9LJJOdkPnkGJ+5IBTmpyAs3qp+EIBHOfJevfpNSE+8l5D
         aFjA==
X-Gm-Message-State: AO0yUKUWSuZ/H6xc6rzg5cw+yXgKB6GCTbA3Y0L5n6PMn1UZ1l187ngN
        nnJzJM851EjHCQjbqudjzemJyaZhNguqrxm/VioHXg==
X-Google-Smtp-Source: AK7set99Wa14Cl7q41QmEjig3d5y5XriZa4QovGX0AF/AQi3FUH59Z9nsjhzY/teq5TZvqlm1Mn1bo+B5wbkcw5GyVQ=
X-Received: by 2002:a67:d48c:0:b0:402:999f:44d2 with SMTP id
 g12-20020a67d48c000000b00402999f44d2mr15314715vsj.0.1678375350449; Thu, 09
 Mar 2023 07:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Mar 2023 16:22:19 +0100
Message-ID: <CAMRc=Me-FMZ3e=EaUA1kimEonz=HVHBp7coxCz53bJK9NYBuFg@mail.gmail.com>
Subject: Re: [PATCH v1 00/16] gpio: Use string_choices.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
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

On Mon, Mar 6, 2023 at 8:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use string_choices.h in the GPIO drivers and library.
> It has been tested on x86_64 and (semi-)compile tested
> over all.
>
> Andy Shevchenko (16):
>   lib/string_helpers: Add missing header files to MAINTAINERS database
>   lib/string_helpers: Split out string_choices.h
>   lib/string_choices: Add str_high_low() helper
>   lib/string_choices: Add str_input_output() helper
>   gpiolib: Utilize helpers from string_choices.h
>   gpio: adnp: Utilize helpers from string_choices.h
>   gpio: brcmstb: Utilize helpers from string_choices.h
>   gpio: crystalcove: Utilize helpers from string_choices.h
>   gpio: grgpio: Utilize helpers from string_choices.h
>   gpio: mvebu: Utilize helpers from string_choices.h
>   gpio: pl061: Utilize helpers from string_choices.h
>   gpio: stmpe: Utilize helpers from string_choices.h
>   gpio: wcove: Utilize helpers from string_choices.h
>   gpio: wm831x: Utilize helpers from string_choices.h
>   gpio: wm8994: Utilize helpers from string_choices.h
>   gpio: xra1403: Utilize helpers from string_choices.h
>
>  MAINTAINERS                     |  3 ++
>  drivers/gpio/gpio-adnp.c        | 24 ++++----------
>  drivers/gpio/gpio-brcmstb.c     |  3 +-
>  drivers/gpio/gpio-crystalcove.c | 17 +++++-----
>  drivers/gpio/gpio-grgpio.c      |  3 +-
>  drivers/gpio/gpio-mvebu.c       | 27 +++++++---------
>  drivers/gpio/gpio-pl061.c       |  4 +--
>  drivers/gpio/gpio-stmpe.c       | 19 +++++------
>  drivers/gpio/gpio-wcove.c       | 15 ++++-----
>  drivers/gpio/gpio-wm831x.c      |  5 +--
>  drivers/gpio/gpio-wm8994.c      |  6 ++--
>  drivers/gpio/gpio-xra1403.c     |  5 +--
>  drivers/gpio/gpiolib-sysfs.c    |  3 +-
>  drivers/gpio/gpiolib.c          | 13 ++++----
>  include/linux/string_choices.h  | 56 +++++++++++++++++++++++++++++++++
>  include/linux/string_helpers.h  | 26 +--------------
>  16 files changed, 125 insertions(+), 104 deletions(-)
>  create mode 100644 include/linux/string_choices.h
>
> --
> 2.39.1
>

I've been thinking about this and I must say it doesn't make much
sense to me. Not only does it NOT reduce the code size (even if we
assume the unlikely case where we'd build all those modules that use
the helpers) but also decreases the readability for anyone not
familiar with the new interfaces (meaning time spent looking up the
new function). The "%s", x ? "if" : "else" statement is concise and
clear already, I don't see much improvement with this series. And I'm
saying it from the position of someone who loves factoring out common
code. :)

I'll wait to hear what others have to say but if it were up to me, I'd
politely say no.

(I mean: I guess, in the end it is up to me, but I'm open to arguments.) :)

Bart
