Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5C73FCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjF0NhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjF0NhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:37:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62922D54;
        Tue, 27 Jun 2023 06:37:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso38120001fa.0;
        Tue, 27 Jun 2023 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687873038; x=1690465038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETDFNDZWinpC/aFtbei5FiJnygZAXqoORMAlq5jv57w=;
        b=aF/wQk25Iw4x8Hp43v4Ugsm5g5IKCkj/tGr+Nu1Ip1XDP1gK+N8HPrZJjzJbvoNDNW
         9PFLLMclHiDoZz+PrnAzQgZjX+/awiQbDlF0kmDVgSxlE5pXRrCtb9eIelaPboB/hWq0
         E0ybFkBQ1FBhL0G8Bam1fWKHfVNclXiuRKeC91dH8SfG2dZjzAhhF+tuToBU8zC8FZrg
         z8OUc1xCVZn6ZtkUy6iwZp12/Xo3BqdqhOsSghGbL9Y66+zoBGE67BfgFR85OYbcdnH7
         14GVqmOq+JXGKaE0nKU2zHp+o9KPOw1N/1MYH4NlihEJt7bDIDL9gV9GI6i8LfiTIAF6
         UhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873038; x=1690465038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETDFNDZWinpC/aFtbei5FiJnygZAXqoORMAlq5jv57w=;
        b=hLd7zptyiCwYHD3LgHc6Rkzv89ilU7Sd4oj1G87QnHAcjAgd8JBzGZyzGjtLZzDblC
         Jp7//7Z9jjUh602SciumUd5FhTnma5r5OlEJasJ6oNDzvhCuwdwNa5RPywb5BTRUgQSZ
         5rBh3CCuIebeuXYDmPmXdhES+eBtdeSCX75oBIKGd8qYCqEAeG6448rthekyM7FN9Ei8
         kl6TUinFJy4/6ksYhkcO6r7t0psNYveril91lcNV8/kZxMOGp7PFOcfhvPKERljqyFsH
         uv/k3/gZm4XlXWCiRedgq3SjDUPB5NDUBTZhcBzCFFojk+vKEAGnJac1g+BZydn/yMXe
         flvg==
X-Gm-Message-State: AC+VfDyY1+5/gk4sZkCmJHumznQenNxoCsPT7DRo0lzg2sdlc/Ko52sr
        CW0ZI+nHRVLdpcX6CpjHIQFrPztHe30W8PFuUc8=
X-Google-Smtp-Source: ACHHUZ5T6CDSPttbIEtmWvCkSIE0M/q7GjjkVTjMdtmGc9ogXOiyMwkBmVe3SH0MCjrKpkMd5tRFg3jHxnwB4+FGhp4=
X-Received: by 2002:a2e:9591:0:b0:2b6:3651:f12f with SMTP id
 w17-20020a2e9591000000b002b63651f12fmr5093226ljh.3.1687873037172; Tue, 27 Jun
 2023 06:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230621213115.113266-1-nick.hawkins@hpe.com> <20230621213115.113266-2-nick.hawkins@hpe.com>
In-Reply-To: <20230621213115.113266-2-nick.hawkins@hpe.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Jun 2023 16:36:40 +0300
Message-ID: <CAHp75Vczq+5JCFW+qi4Y7M7+JY3MPe7GAMdjMzOpVukcBybH7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpio: gxp: Add HPE GXP GPIO
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
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

On Thu, Jun 22, 2023 at 12:35=E2=80=AFAM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The GXP SoC supports GPIO on multiple interfaces. The interfaces are
> CPLD and Host. The GPIOs is a combination of both physical and virtual

are a

> I/O across the interfaces. The gpio-gxp driver specifically covers the
> CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The

A bit of elaboration what the Host interface means and what is the
difference to the CPLD. Perhaps spell it here as "Host interface", so
it will be clear that above you mentioned it already.

> driver supports interrupts from the host.

...

> +#define GPIDAT         0x040
> +#define GPODAT         0x0b0
> +#define GPODAT2                0x0f8
> +#define GPOOWN         0x110
> +#define GPOOWN2                0x118
> +#define ASR_OFS                0x05c
> +#define VUHC_OFS       0x064

Hmm... No GPIDAT2? I'm wondering if you can drop all these *2
definitions. Let see below...

...

> +struct gxp_gpio_drvdata {
> +       struct gpio_chip chip;
> +       struct regmap *csm_map;

> +       void __iomem *fn2_vbtn;

Looking into the code I have no clue why this is in this driver. You
have regmaps and a separate resource for this. Why?! Is it in the
window of GPIO MMIO?

> +       struct regmap *fn2_stat;
> +       struct regmap *vuhc0_map;
> +       int irq;
> +};

...

> +/*
> + * Note: Instead of definining all PINs here are the select few that

defining (I have a d=C3=A9j=C3=A0 vu of already showing you typos in the co=
mmit
message and comments and it looks like you ignored all of that. If so,
then why?)

> + * are specifically defined in DTS and offsets are used here.
> + */
> +enum gxp_gpio_pn {
> +       RESET =3D 192,
> +       VPBTN =3D 210, /* aka POWER_OK */
> +       PGOOD =3D 211, /* aka PS_PWROK */
> +       PERST =3D 212, /* aka PCIERST */
> +       POST_COMPLETE =3D 213,

So, vbtn is a GPIO? Why does it need a special treatment?

> +};

...

> +static int gxp_gpio_csm_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);

> +       int ret =3D 0;

Seems like a weird assignment.

> +       unsigned int reg_offset;
> +       unsigned int reg_mask;
> +
> +       switch (offset) {
> +       case 0 ... 31:
> +               reg_offset =3D GPIDAT;
> +               reg_mask =3D BIT(offset);
> +               break;
> +       case 32 ... 63:
> +               reg_offset =3D GPIDAT + 0x20;
> +               reg_mask =3D BIT(offset - 32);
> +               break;

So, here is the 0x20 offset shift...

> +       case 64 ... 95:
> +               reg_offset =3D GPODAT;
> +               reg_mask =3D BIT(offset - 64);
> +               break;
> +       case 96 ... 127:
> +               reg_offset =3D GPODAT + 0x04;
> +               reg_mask =3D BIT(offset - 96);
> +               break;

...and here (between two groups of GPO) is 0x48. Looks a bit weird.
Does this GPIO have more functions than simply being a GPIO? To me
looks like a PMIC-ish one. Is there any datasheet available?

> +       case 128 ...  159:
> +               reg_offset =3D GPODAT2;
> +               reg_mask =3D BIT(offset - 128);
> +               break;
> +       case 160 ... 191:
> +               reg_offset =3D GPODAT2 + 0x04;
> +               reg_mask =3D BIT(offset - 160);
> +               break;

These (64-192) are two groups of the sequential bits in the address
space. Why do you do this instead of the simplest calculus with bit
and offset?

> +       case RESET:
> +               /* SW_RESET */
> +               reg_offset =3D ASR_OFS;
> +               reg_mask =3D BIT(15);
> +               break;

Does it really belong to this driver? Maybe it should be an MFD with
GPIO and special functions with valid_mask properly assigned?

> +       default:
> +               break;
> +       }

> +       regmap_read(drvdata->csm_map, reg_offset, &ret);
> +       ret =3D (ret & reg_mask) ? 1 : 0;
> +
> +       return ret;


  ret =3D regmap_read(, &value);
  if (ret)
    return ret;

  return !!(value & mask);

> +}
> +
> +static void gxp_gpio_csm_set(struct gpio_chip *chip, unsigned int offset=
,
> +                            int value)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       u32 tmp;

> +       switch (offset) {

You definitely don't need this. All bits are in the sequential addresses.

> +       case 64 ... 95:
> +               /* Keep ownership setting */
> +               regmap_read(drvdata->csm_map, GPOOWN, &tmp);
> +               tmp =3D (tmp & BIT(offset - 64)) ? 1 : 0;
> +
> +               regmap_update_bits(drvdata->csm_map, GPOOWN,
> +                                  BIT(offset - 64), BIT(offset - 64));
> +               regmap_update_bits(drvdata->csm_map, GPODAT,
> +                                  BIT(offset - 64), value ? BIT(offset -=
 64) : 0);
> +
> +               /* Restore ownership setting */
> +               regmap_update_bits(drvdata->csm_map, GPOOWN,
> +                                  BIT(offset - 64), tmp ? BIT(offset - 6=
4) : 0);
> +               break;
> +       case 96 ... 127:
> +               /* Keep ownership setting */
> +               regmap_read(drvdata->csm_map, GPOOWN + 0x04, &tmp);
> +               tmp =3D (tmp & BIT(offset - 96)) ? 1 : 0;
> +
> +               regmap_update_bits(drvdata->csm_map, GPOOWN + 0x04,
> +                                  BIT(offset - 96), BIT(offset - 96));
> +               regmap_update_bits(drvdata->csm_map, GPODAT + 0x04,
> +                                  BIT(offset - 96), value ? BIT(offset -=
 96) : 0);
> +
> +               /* Restore ownership setting */
> +               regmap_update_bits(drvdata->csm_map, GPOOWN + 0x04,
> +                                  BIT(offset - 96), tmp ? BIT(offset - 9=
6) : 0);
> +               break;
> +       case 128 ... 159:
> +               /* Keep ownership setting */
> +               regmap_read(drvdata->csm_map, GPOOWN2, &tmp);
> +               tmp =3D (tmp & BIT(offset - 128)) ? 1 : 0;
> +
> +               regmap_update_bits(drvdata->csm_map, GPOOWN2,
> +                                  BIT(offset - 128), BIT(offset - 128));
> +               regmap_update_bits(drvdata->csm_map, GPODAT2,
> +                                  BIT(offset - 128), value ? BIT(offset =
- 128) : 0);
> +
> +               /* Restore ownership setting */
> +               regmap_update_bits(drvdata->csm_map, GPOOWN2,
> +                                  BIT(offset - 128), tmp ? BIT(offset - =
128) : 0);
> +               break;
> +       case 160 ... 191:
> +               /* Keep ownership setting */
> +               regmap_read(drvdata->csm_map, GPOOWN2 + 0x04,   &tmp);
> +               tmp =3D (tmp & BIT(offset - 160)) ? 1 : 0;
> +
> +               regmap_update_bits(drvdata->csm_map, GPOOWN2 + 0x04,
> +                                  BIT(offset - 160), BIT(offset - 160));
> +               regmap_update_bits(drvdata->csm_map, GPODAT2 + 0x04,
> +                                  BIT(offset - 160), value ? BIT(offset =
- 160) : 0);
> +
> +               /* Restore ownership setting */
> +               regmap_update_bits(drvdata->csm_map, GPOOWN2 + 0x04,
> +                                  BIT(offset - 160), tmp ? BIT(offset - =
160) : 0);
> +               break;

> +       case 192:
> +               if (value) {
> +                       regmap_update_bits(drvdata->csm_map, ASR_OFS,
> +                                          BIT(0), BIT(0));
> +                       regmap_update_bits(drvdata->csm_map, ASR_OFS,
> +                                          BIT(15), BIT(15));
> +               } else {
> +                       regmap_update_bits(drvdata->csm_map, ASR_OFS,
> +                                          BIT(15), 0);
> +               }
> +               break;

Again, seems like a special function of GPIO that should probably have
another driver that shares regmap with GPIO and GPIO marks this one is
not valid for the GPIO operations.

> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_csm_get_direction(struct gpio_chip *chip,
> +                                     unsigned int offset)
> +{
> +       switch (offset) {

Why do you use your custom definitions for the direction? We already
have the generic ones for this. Please use them.

> +       case 0 ... 63:
> +               return GXP_GPIO_DIR_IN;
> +       case 64 ... 191:
> +               return GXP_GPIO_DIR_OUT;

> +       case 192 ... 193:
> +               return GXP_GPIO_DIR_OUT;
> +       case 194:
> +               return GXP_GPIO_DIR_IN;

These are special cases. Not sure if it's for the GPIO, but basically
you can check them separately and reduce switch-case to simple

  type =3D offset / 64;
  if (type)
    return OUT;
  return IN;

Something similar to the rest of the functions.

Note, that range operator in switch-case is non-standard.

> +       default:
> +               return -ENOTSUPP;
> +       }
> +}

...

> +static int gxp_gpio_vuhc_get(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +       int ret =3D 0;
> +
> +       if (offset < 8) {
> +               regmap_read(drvdata->vuhc0_map, VUHC_OFS + 4 * offset,   =
&val);
> +               ret =3D (val & BIT(13)) ? 1 : 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static void gxp_gpio_vuhc_set(struct gpio_chip *chip, unsigned int offse=
t,
> +                             int value)
> +{
> +       /* Currently we are not supporting setting of these values yet */
> +       switch (offset) {
> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_vuhc_get_direction(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       switch (offset) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               return GXP_GPIO_DIR_IN;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}
> +
> +static int gxp_gpio_vuhc_direction_input(struct gpio_chip *chip,
> +                                        unsigned int offset)
> +{
> +       switch (offset) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               return 0;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}
> +
> +static int gxp_gpio_vuhc_direction_output(struct gpio_chip *chip,
> +                                         unsigned int offset, int value)
> +{
> +       switch (offset) {
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}

I'm not sure this belongs to the GPIO driver.

> +static int gxp_gpio_fn2_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +       int ret =3D 0;
> +       unsigned int reg_mask;
> +
> +       switch (offset) {
> +       case PGOOD:
> +               regmap_read(drvdata->fn2_stat, 0, &val);
> +               reg_mask =3D BIT(24);
> +
> +               break;
> +       case PERST:
> +               regmap_read(drvdata->fn2_stat, 0, &val);
> +               reg_mask =3D BIT(25);
> +
> +               break;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +
> +       regmap_read(drvdata->fn2_stat, 0, &val);
> +       ret =3D (val & reg_mask);
> +       /* Return either 1 or 0 */
> +       return ret ? 1 : 0;
> +}
> +
> +static void gxp_gpio_fn2_set(struct gpio_chip *chip, unsigned int offset=
,
> +                            int value)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +
> +       switch (offset) {
> +       case VPBTN:
> +               writeb(1, drvdata->fn2_vbtn);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_fn2_get_direction(struct gpio_chip *chip,
> +                                     unsigned int offset)
> +{
> +       switch (offset) {
> +       case VPBTN:
> +               return GXP_GPIO_DIR_OUT;
> +       default:
> +               return GXP_GPIO_DIR_IN;
> +       }
> +}
> +
> +static int gxp_gpio_fn2_direction_input(struct gpio_chip *chip,
> +                                       unsigned int offset)
> +{
> +       switch (offset) {
> +       case PGOOD:
> +       case PERST:
> +       case POST_COMPLETE:
> +               return 0;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}
> +
> +static int gxp_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       if (offset < 200)
> +               return gxp_gpio_csm_get(chip, offset);
> +       else if (offset >=3D 200 && offset < 210)
> +               return gxp_gpio_vuhc_get(chip, offset - 200);
> +       else if (offset >=3D 210)
> +               return gxp_gpio_fn2_get(chip, offset);
> +
> +       return 0;
> +}
> +
> +static void gxp_gpio_set(struct gpio_chip *chip,
> +                        unsigned int offset, int value)
> +{
> +       if (offset < 200)
> +               gxp_gpio_csm_set(chip, offset, value);
> +       else if (offset >=3D 200 && offset < 210)
> +               gxp_gpio_vuhc_set(chip, offset - 200, value);
> +       else if (offset >=3D 210)
> +               gxp_gpio_fn2_set(chip, offset, value);
> +}
> +
> +static int gxp_gpio_get_direction(struct gpio_chip *chip,
> +                                 unsigned int offset)
> +{
> +       if (offset < 200)
> +               return gxp_gpio_csm_get_direction(chip, offset);
> +       else if (offset >=3D 200 && offset < 210)
> +               return gxp_gpio_vuhc_get_direction(chip, offset - 200);
> +       else if (offset >=3D 210)
> +               return gxp_gpio_fn2_get_direction(chip, offset);
> +
> +       return 0;
> +}
> +
> +static int gxp_gpio_direction_input(struct gpio_chip *chip,
> +                                   unsigned int offset)
> +{
> +       if (offset < 200)
> +               return gxp_gpio_csm_direction_input(chip, offset);
> +       else if (offset >=3D 200 && offset < 210)
> +               return gxp_gpio_vuhc_direction_input(chip, offset - 200);
> +       else if (offset >=3D 210)
> +               return gxp_gpio_fn2_direction_input(chip, offset);
> +
> +       return 0;
> +}
> +
> +static int gxp_gpio_direction_output(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +{
> +       if (offset < 200)
> +               return gxp_gpio_csm_direction_output(chip, offset, value)=
;
> +       else if (offset >=3D 200 && offset < 210)
> +               return gxp_gpio_vuhc_direction_output(chip, offset - 200,=
 value);
> +
> +       return 0;
> +}

...

> +       /* Clear latched interrupt */
> +       regmap_update_bits(drvdata->fn2_stat, 0,
> +                          GENMASK(15, 0), GENMASK(15, 0));

  unsigned int mask =3D GENMASK(...);
  unsigned int value =3D mask;
  regmap_update_bits(..., mask, value);

...

> +       regmap_update_bits(drvdata->fn2_stat, FN2_SEVMASK,
> +                          BIT(0), set ? BIT(0) : 0);

Ditto.

  unsigned int mask =3D BIT(0);
  unsigned int value =3D set ? mask : 0;

...

So, overall it looks to me like an MFD device which should be split to
GPIO, GPIO with IRQ (fh2), special cases and designated
functionalities (somelike ~5 drivers all together). Without having a
datasheet it's hard to say.


--
With Best Regards,
Andy Shevchenko
