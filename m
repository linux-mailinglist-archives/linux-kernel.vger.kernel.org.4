Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43746A61C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjB1Vv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Vv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:51:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FD12F11;
        Tue, 28 Feb 2023 13:51:48 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id j10so2194368qkg.12;
        Tue, 28 Feb 2023 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+dfh/VCiAl5Ymkzsu2S+IKfHY6gQX+dxWUJXya35fQ=;
        b=Eunq6xlHqH+DhN85nvZeFuvXm1Fqo3sOp5ElUTxUVyv9tkwEYBbF4MKsI55GyzTqJl
         PHKoeYq6kfq1bIF4YLWOloLsLGL3C/Ge9+v+mUGMc0kYJf+nuxl7iPUfyhnGqEPHr0BL
         ilZiin0a6IWyDTChphy3MLX5PHGX7qZ0UAQqJ659lQJNMPyzNpA0d8YWXmx9E88aWtEx
         rh0RbF83ky/IxHqix3KYgPCEKoZdw9aauiOBdzoAI02UZWXphCv4OlpPJM84hFPGeFuK
         DVIvMCu2mfNaBKzjgbAM3boCmMgnv1zTVDk+B71q5dz3utc6xCqEdwX1nssmXdRR/UWF
         IqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+dfh/VCiAl5Ymkzsu2S+IKfHY6gQX+dxWUJXya35fQ=;
        b=dBNasxjYyPSs7/9G5jKTwgD87YUxZzB6/GhQa8lpKfnuqmHNvu7/m97tJMIE21RIBT
         lN+OK6FymOuvxFMXmrBQv4hObgPmsq0lWcpIGwf57zaUhhJ9lNtlUTHDCfBLOHWeUpvE
         5xHtP+UiXMsiwG/2LgEyqD7NabZhDJ6QGbtm/W7mQMJcfzSlh1AZcqXJbievUJDBvspC
         TL38e5WeTvoFSPbV09NYef8fsbkvtlCnIna2OUGFGYT8H3K8RoEcQ15VmfcdD2EYIW6w
         nq5MOnW2JkEsVhOwAOg+4soqQjhghoRxSuLWDk1f7CwyaHFosGJ3PyW8ZNu62BCATL8X
         MyhA==
X-Gm-Message-State: AO0yUKXBJ8McFwyipt56te//+9wlr2I8B2GiVtK0tvZJvYcGRWA2VS5B
        WAqcYw6wa6p2s9rxVHY10mH6w6kzsMyO79yCugAq7HPuHpqYVA==
X-Google-Smtp-Source: AK7set8MLv0Y6D7hbNriT1diDGviWlx8nZPmG1xHdzks3ynlTB9lzelE3S6RTdorjMqkBdXm5D+x5bD9M/ZiNdrAlbQ=
X-Received: by 2002:a05:620a:1e9:b0:742:7e5a:4cee with SMTP id
 x9-20020a05620a01e900b007427e5a4ceemr1008610qkn.10.1677621107760; Tue, 28 Feb
 2023 13:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru> <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
In-Reply-To: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Feb 2023 23:51:11 +0200
Message-ID: <CAHp75Ve0vKSuO9ieSCKf758=uEbAj4aq1OwbtuSc_8tWkPtvWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:11=E2=80=AFPM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - Individual 64-level DIM currents

I'm wondering if I already commented on the v1 of this. A lot of
issues with the code and your email rings a bell...
Okay, I have dug into archives and it was something else.

...

> +Date:          February 2023

Blast from the past? The best you can get is March 2023.

...

> +Description:   64-level DIM current. If write negative value or "auto",

If you write a

> +               the dim will be calculated according to the brightness.

...

> +config LEDS_AW200XX
> +       tristate "LED support for Awinic AW20036/AW20054/AW20072"
> +       depends on LEDS_CLASS
> +       depends on I2C
> +       help
> +         This option enables support for the AW20036/AW20054/AW20072 LED=
 driver.
> +         It is a 3x12/6x9/6x12 matrix LED driver programmed via
> +         an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +         3 pattern controllers for auto breathing or group dimming contr=
ol.

What would be the name of the module if M?

...

> +/**

Is it a kernel doc?

> + * leds-aw200xx.c - Awinic AW20036/AW20054/AW20072 LED driver

No name of the file in the file. It's impractical (in case it will be
moved/renamed).

> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> + */

...

> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>

Can you keep this sorted?

...

> +#define AW200XX_DIM_MAX                  0x3F
> +#define AW200XX_FADE_MAX                 0xFF

If it is limited by the amount of bits in the bitfields, better to use
the form of (BIT(x) - 1), where x is the amount of bits.

...

> +#define AW200XX_IMAX_DEFAULT_MICROAMP    60000
> +#define AW200XX_IMAX_MAX_MICROAMP        160000
> +#define AW200XX_IMAX_MIN_MICROAMP        3300

A is the unit, and for microamperes we already use (in another
driver(s)) the _uA suffix.

...

> +/* Page 0 */
> +#define AW200XX_REG_PAGE0_BASE 0xc000

Indeed, like Pavel mentioned, why not consider the DRM approach for
this? If it's not really a display similar to LCD, then there is
drivers/auxdisplay folder for the non-standard / alphanumeric / etc
cases.

...

> +       (AW200XX_REG_PAGE0_BASE + ((page) * AW200XX_PAGE_SIZE) + (reg))

Multiplication doesn't require parentheses.

...

> +#define AW200XX_PAT_T3_LT_MASK      0xFF

> +#define AW200XX_PAT0_T3_LT_LSB(x)   ((x) & 0xFF)

GENMASK()

...

> +#define AW200XX_PAT0_T_LT_MAX       0xFFF

(BIT(12) - 1) ?

...

> +#define AW200XX_PAT_T1_T3_MASK      0xF0
> +#define AW200XX_PAT_T2_T4_MASK      0x0F

GENMASK()

...

> +#define AW200XX_TEMPLATE_TIME_MAX   0x0F

(BIT(4) - 1)

...

> +/* Duty ratio of display scan (see p.15 of datasheet for formula) */
> +#define AW200XX_DUTY_RATIO(rows) \
> +       (((592UL * 1000000UL) / 600500UL) * (1000UL / (rows)) / 1000UL)

Something to use from units.h?

...

> +struct aw200xx_led {
> +       struct aw200xx *chip;

> +       struct led_classdev cdev;

Moving embedded structure to be the first member might make some code
to be no-op at compile time.

> +       int dim;
> +       u32 num;
> +};

...

> +       ssize_t ret;

Useless, just use return directly.

> +       if (dim < 0)
> +               ret =3D sysfs_emit(buf, "auto\n");
> +       else
> +               ret =3D sysfs_emit(buf, "%d\n", dim);
> +
> +       return ret;

if (dim >=3D 0)
  return sysfs_emit(...);

return sysfs_emit(...);

...

> +               ret =3D kstrtoint(buf, 0, &dim);
> +               if (ret < 0 || dim > AW200XX_DIM_MAX)
> +                       return -EINVAL;

Why shadowing ret?
Hint: it may not be EINVAL in some cases.

...

> +       if (dim >=3D 0) {

Hmm... Why not simply use an unsigned type?

> +       }

...

> +       /* The output current of each LED (see p.14 of datasheet for form=
ula) */
> +       return (duty * global_imax_microamp) / 1000U;

units.h ?

...

> +       /* The output current of each LED (see p.14 of datasheet for form=
ula) */
> +       return (led_imax_microamp * 1000U) / duty;

Ditto.

...

> +static int aw200xx_set_imax(const struct aw200xx *const chip,
> +                           u32 led_imax_microamp)
> +{
> +       struct imax_global {
> +               u32 regval;
> +               u32 microamp;
> +       } imaxs[] =3D {
> +               { 8,  3300 },
> +               { 9,  6700 },
> +               { 0,  10000 },
> +               { 11, 13300 },
> +               { 1,  20000 },
> +               { 13, 26700 },
> +               { 2,  30000 },
> +               { 3,  40000 },
> +               { 15, 53300 },
> +               { 4,  60000 },
> +               { 5,  80000 },
> +               { 6,  120000 },
> +               { 7,  160000 },

This looks a bit random. Is there any pattern on how value is
connected to the register value?

> +       };
> +       u32 g_imax_microamp =3D aw200xx_imax_to_global(chip, led_imax_mic=
roamp);
> +       int i;

int i =3D ARRAY_SIZE(...);

> +       for (i =3D ARRAY_SIZE(imaxs) - 1; i >=3D 0; i--) {

while (i--) {

> +               if (g_imax_microamp >=3D imaxs[i].microamp)
> +                       break;
> +       }

> +

Redundant blank line.

> +       if (i < 0)
> +               return -EINVAL;
> +
> +       return regmap_update_bits(chip->regmap, AW200XX_REG_GCCR,
> +                                 AW200XX_GCCR_IMAX_MASK,
> +                                 AW200XX_GCCR_IMAX(imaxs[i].regval));
> +}

...

> +       ret =3D regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_C=
LEAR);
> +
> +       return ret;

return regmap_write(...);

...

> +       ret =3D regmap_update_bits(chip->regmap, AW200XX_REG_GCCR,
> +                                AW200XX_GCCR_ALLON, AW200XX_GCCR_ALLON);
> +
> +       return ret;

Ditto.

...

> +       ret =3D aw200xx_set_imax(chip, min_microamp);
> +
> +       return ret;

Ditto.

...

> +       chip =3D devm_kzalloc(&client->dev,
> +                           struct_size(chip, leds, count),
> +                           GFP_KERNEL);

There is a lot of room on the previous lines.

> +       if (!chip)
> +               return -ENOMEM;

...

> +static const struct of_device_id __maybe_unused aw200xx_match_table[] =
=3D {
> +       { .compatible =3D "awinic,aw20036", .data =3D &aw20036_cdef, },
> +       { .compatible =3D "awinic,aw20054", .data =3D &aw20054_cdef, },
> +       { .compatible =3D "awinic,aw20072", .data =3D &aw20072_cdef, },
> +       {},

Comma is not needed for the terminator entry.

> +};

...

> +static struct i2c_driver aw200xx_driver =3D {
> +       .driver =3D {
> +               .name =3D "aw200xx",
> +               .of_match_table =3D of_match_ptr(aw200xx_match_table),

Why of_match_ptr()? It's a very rare case when you really need this.

> +       },
> +       .probe_new =3D aw200xx_probe,
> +       .remove =3D aw200xx_remove,
> +       .id_table =3D aw200xx_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(aw200xx_driver);

...

> +MODULE_ALIAS("platform:leds-aw200xx");

What is this?! Or i.o.w. why is this violation of the subsystems?


--
With Best Regards,
Andy Shevchenko
