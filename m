Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0456C7F79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjCXOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCXOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:04:17 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B815CB1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:03:19 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id v48so1463896uad.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679666590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnbpfcqGanbrwxTimMfIRYuXDJDuBG+s0gPnBVVk/Bo=;
        b=vHBto2XQMyBoDyv2V3lWV93YknLET2STEkfA7BDeD0Rib/Bfn9J/fWb2Ikjp1f+TuE
         TJpJR1VryraL97ejyEKLYhaYXWaEzKTVZ4B5fA5fXspfeiCFjpX1GheQOvw1+qoaX1zN
         P7B0fsSpK0OV4Neu8d1gEnVoKPkHKcZDKAeqyz1G4UEv5CdQaN0MvHzPT3jGwDcuIt/K
         PS7bOPrJ+HgAXeBSYTywBwveDk93HLiiGJc6mI3pb7iP3ZcucuJcbhNYb8Xw/cUYkOGv
         DAp9Gw3TQddBAz4EfEnKG1f2xq+PyZOJv5Yrjv8Z7MdWU+blpCox61DdDcatzW9+3lEr
         ydMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnbpfcqGanbrwxTimMfIRYuXDJDuBG+s0gPnBVVk/Bo=;
        b=xE0uKXRIzYz2t8HMC4K8uxwGtPDG3EIRrfgaUJUnfwk7oqV+Nk0poq6X/h1BSpAKuH
         gQ9DKWMemx4Vk/i4wRh5Q2O5Dyg94a/JJZQhn7A8LBieWRCG+9jPhxArydo3fFgd/BwO
         T+dDRTMR3TG+vCZowUnAq+MZmMh3lR1mBq1BcB4dCONOSuxHTs8g+bdPia97vVajj13s
         msOJPXl+kWBgDalpPSMF6VPmk9yKrTg6PnXCld+n7p5zVZBsdl2bjMjbfOzRRHOXYr5/
         l2ju05T6D/yJe3z13ts2yCDZeEcuZmHZzm8cjKcaeEJM+3W1ojpjs1BvM8IH+yWoNCG9
         +2cA==
X-Gm-Message-State: AO0yUKW1h2YZTNh43kgVDCvDGeCN5601fIJOrap5COkk0E70OGmkTqmD
        NY0KLKW+gZvIMcyKS/ANR/3IOB2OSGj6gFRVYO1DNw==
X-Google-Smtp-Source: AK7set+9WcFXpz0boVN0YWBQl1e+e1tBYWi5noB1uxTlSy+gP+ccbS/F9Q5p1wp+yz7yqVLFoA39hP/gmG3hBXX6Wt0=
X-Received: by 2002:a05:6122:11af:b0:401:d1f4:bccf with SMTP id
 y15-20020a05612211af00b00401d1f4bccfmr5291512vkn.0.1679666590340; Fri, 24 Mar
 2023 07:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230322121547.14997-1-wse@tuxedocomputers.com>
In-Reply-To: <20230322121547.14997-1-wse@tuxedocomputers.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 24 Mar 2023 15:02:59 +0100
Message-ID: <CAMRc=MfOPiG9cbxqZLN53uEizW50ey4dH28oY47qR0BhmMFnPg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 22, 2023 at 1:16=E2=80=AFPM Werner Sembach <wse@tuxedocomputers=
.com> wrote:
>
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
>
> However on Clevo NL5xNU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.
>
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 9.
>
> This patch is analoge to a very similar patch for NL5xRU, just the DMI
> string changed.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpio/gpiolib-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 34ff048e70d0e..055013f959b25 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1624,6 +1624,19 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
>                         .ignore_interrupt =3D "AMDI0030:00@18",
>                 },
>         },
> +       {
> +               /*
> +                * Spurious wakeups from TP_ATTN# pin
> +                * Found in BIOS 1.7.8
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#n=
ote_1720627
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
> +               },
> +               .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> +                       .ignore_wake =3D "ELAN0415:00@9",
> +               },
> +       },
>         {
>                 /*
>                  * Spurious wakeups from TP_ATTN# pin
> --
> 2.34.1
>

Queued for fixes.

Bart
