Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A371951E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjFAIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:11:59 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DACFB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:11:52 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-456ddefe8acso103751e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685607111; x=1688199111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCNt7JHDPKltpB2tDN0OKpgilYKKrD1VrNt024Ba9sA=;
        b=kEponCeN/V+TB1wCYbXPKgw8TCs8n3dFAKWDsav24yZL2x/mad2aBOU0mx2Ha+oX/O
         dwYXnrv5ZjOLW5l4JqNoPUokOAbgxkiAtBv9KYodAU6hu+tJRF5TYpaaEBQoakWzWOke
         LUeQyWJ7yo2jq6HXlObaZ+KQ0txqod1YyZnM56wlNwyvElfj8kgcLHAdBnufZdiROCY1
         dRSfgIbK9SFEd7bsBx9MFykLWQ6sDh0GTYHB5lEtVxh3vpDF4CCP437xmIjj4bGQmVQP
         xaVyKQ7vdP/H1h8CfU4UbHV7Vjg1rSp0oYNhSOmDAYl9HDwNrignQqzvJFTl1pltNanB
         3z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607111; x=1688199111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCNt7JHDPKltpB2tDN0OKpgilYKKrD1VrNt024Ba9sA=;
        b=cDkuc+EObXM05qJRh/XTCSy3Ot48uBL3pA+NbO5o5nUFYPEa3AGkoHUesihECwUaCf
         N4dIzBi398xkRsk1cWk14TigHG9FLn4BdIiCP/DGfjG1/Vp6zKKwEsAxPJlywlHJr8tO
         109WU+fdgyl2SWLEyPA9Ko7meMh+jhLj38nI1OvMehsswd4hWO5/r3tk5Qo4JMh2Y84p
         RZhal8oU8KI2oXMGTUYAJLS1QdxjfOjTuRdh+kKtuOLLjkBb0lRhrH3YD51FRQfDSo0y
         RvTIoooxtdw8S6f5RQqxZrhuCVMPWkFuT+BETspJIs9FKUj7h0GpbwmYIHK0fy7T1/Sd
         MOrA==
X-Gm-Message-State: AC+VfDxmnzLXkktui49INN/rLY0YgbhVoc5cYnSeZHggRNu3JKQog/XX
        9qwFwAt9C48fra7AaYj7SDl8DlpxHD3PFbRx1FG+4Q==
X-Google-Smtp-Source: ACHHUZ5bYn66mtfqeSUmaD99HXeA0LEVwfIBM7CAtbchCjbjjcnshadqoDomwqchuInyD6sVmpvPAs6fRv8KlyKdQDg=
X-Received: by 2002:a1f:604a:0:b0:45d:2f01:a52f with SMTP id
 u71-20020a1f604a000000b0045d2f01a52fmr165527vkb.0.1685607110650; Thu, 01 Jun
 2023 01:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230531151918.105223-1-nick.hawkins@hpe.com> <20230531151918.105223-3-nick.hawkins@hpe.com>
In-Reply-To: <20230531151918.105223-3-nick.hawkins@hpe.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Jun 2023 10:11:39 +0200
Message-ID: <CAMRc=MfETRjy+yzEpYmEVZvd+MzpynC1M6tdDwimXHD_Je9K=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: gxp: Add HPE GXP GPIO
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
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

On Wed, May 31, 2023 at 5:23=E2=80=AFPM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The GXP SoC supports GPIO on multiple interfaces. The interfaces are
> CPLD and Host. The GPIOs is a combination of both physical and virtual
> I/O across the interfaces. The gpio-gxp driver specifically covers the
> CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The
> gpio-gxp-pl driver covers the CPLD which takes physical I/O from the
> board and shares it with GXP via a propriety interface that maps the I/O
> onto a specific register area of the GXP. The drivers both support
> interrupts but from different interrupt parents.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>
> ---
>
> v2:
>  *Separated code into two files to keep size down: gpio-gxp.c and
>   gpio-gxp-pl.c
>  *Fixed Kconfig indentation as well as add new entry for gpio-gxp-pl
>  *Removed use of linux/of.h and linux/of_device.h
>  *Added mod_devicetable.h and property.h
>  *Fixed indentation of defines and uses consistent number of digits
>  *Corrected defines with improper GPIO_ namespace.
>  *For masks now use BIT()
>  *Added comment for PLREG offsets
>  *Move gpio_chip to be first in structure
>  *Calculate offset for high and low byte GPIO reads instead of having
>   H(High) and L(Low) letters added to the variables.
>  *Removed repeditive use of "? 1 : 0"
>  *Switched to handle_bad_irq()
>  *Removed improper bailout on gpiochip_add_data
>  *Used GENMASK to arm interrupts
>  *Removed use of of_match_device
>  *fixed sizeof in devm_kzalloc
>  *Added COMPILE_TEST to Kconfig
>  *Added dev_err_probe
>  *Removed unecessary parent and compatible checks
> ---
>  drivers/gpio/Kconfig       |  18 ++
>  drivers/gpio/Makefile      |   2 +
>  drivers/gpio/gpio-gxp-pl.c | 536 +++++++++++++++++++++++++++++++
>  drivers/gpio/gpio-gxp.c    | 637 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 1193 insertions(+)
>  create mode 100644 drivers/gpio/gpio-gxp-pl.c
>  create mode 100644 drivers/gpio/gpio-gxp.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..b0a24ef18392 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1235,6 +1235,24 @@ config HTC_EGPIO
>           several HTC phones.  It provides basic support for input
>           pins, output pins, and IRQs.
>
> +config GPIO_GXP
> +       tristate "GXP GPIO support"
> +       depends on ARCH_HPE_GXP || COMPILE_TEST
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support GXP GPIO controllers. It provides
> +         support for the multiple GPIO interfaces available to be
> +         available to the Host.
> +
> +config GPIO_GXP_PL
> +       tristate "GXP GPIO PL support"
> +       depends on ARCH_HPE_GXP || COMPILE_TEST
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support GXP GPIO PL controller. It provides
> +         support for the GPIO PL interface available to be
> +         available to the Host.
> +
>  config GPIO_JANZ_TTL
>         tristate "Janz VMOD-TTL Digital IO Module"
>         depends on MFD_JANZ_CMODIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c048ba003367..a401dd472c93 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_GPIO_FTGPIO010)          +=3D gpio-ftgpio0=
10.o
>  obj-$(CONFIG_GPIO_GE_FPGA)             +=3D gpio-ge.o
>  obj-$(CONFIG_GPIO_GPIO_MM)             +=3D gpio-gpio-mm.o
>  obj-$(CONFIG_GPIO_GRGPIO)              +=3D gpio-grgpio.o
> +obj-$(CONFIG_GPIO_GXP)                  +=3D gpio-gxp.o
> +obj-$(CONFIG_GPIO_GXP_PL)              +=3D gpio-gxp-pl.o
>  obj-$(CONFIG_GPIO_GW_PLD)              +=3D gpio-gw-pld.o
>  obj-$(CONFIG_GPIO_HISI)                 +=3D gpio-hisi.o
>  obj-$(CONFIG_GPIO_HLWD)                        +=3D gpio-hlwd.o
> diff --git a/drivers/gpio/gpio-gxp-pl.c b/drivers/gpio/gpio-gxp-pl.c
> new file mode 100644
> index 000000000000..3b27848d6bfc
> --- /dev/null
> +++ b/drivers/gpio/gpio-gxp-pl.c
> @@ -0,0 +1,536 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.=
P. */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* Specific offsets in CPLD registers for interrupts */
> +#define PLREG_INT_GRP_STAT_MASK        0x08
> +#define PLREG_INT_HI_PRI_EN    0x0C
> +#define PLREG_INT_GRP5_BASE    0x31
> +#define PLREG_INT_GRP6_BASE    0x35
> +#define PLREG_INT_GRP5_FLAG    0x30
> +#define PLREG_INT_GRP6_FLAG    0x34
> +
> +/* Specific bits to enable Group 4 and Group 5 interrupts */
> +#define PLREG_GRP4_GRP5_MASK   GENMASK(5, 4)
> +
> +/* Specific offsets in CPLD registers */
> +#define PLREG_IOP_LED          0x04
> +#define PLREG_IDENT_LED                0x05
> +#define PLREG_HEALTH_LED       0x0D
> +#define PLREG_PSU_INST         0x19
> +#define PLREG_PSU_AC           0x1B
> +#define PLREG_PSU_DC           0x1C
> +#define PLREG_FAN_INST         0x27
> +#define PLREG_FAN_FAIL         0x29
> +
> +#define GXP_GPIO_DIR_OUT        0x00
> +#define GXP_GPIO_DIR_IN         0x01
> +
> +enum pl_gpio_pn {
> +       IOP_LED1 =3D 0,
> +       IOP_LED2 =3D 1,
> +       IOP_LED3 =3D 2,
> +       IOP_LED4 =3D 3,
> +       IOP_LED5 =3D 4,
> +       IOP_LED6 =3D 5,
> +       IOP_LED7 =3D 6,
> +       IOP_LED8 =3D 7,
> +       FAN1_INST =3D 8,
> +       FAN2_INST =3D 9,
> +       FAN3_INST =3D 10,
> +       FAN4_INST =3D 11,
> +       FAN5_INST =3D 12,
> +       FAN6_INST =3D 13,
> +       FAN7_INST =3D 14,
> +       FAN8_INST =3D 15,
> +       FAN1_FAIL =3D 16,
> +       FAN2_FAIL =3D 17,
> +       FAN3_FAIL =3D 18,
> +       FAN4_FAIL =3D 19,
> +       FAN5_FAIL =3D 20,
> +       FAN6_FAIL =3D 21,
> +       FAN7_FAIL =3D 22,
> +       FAN8_FAIL =3D 23,
> +       LED_IDENTIFY =3D 24,
> +       LED_HEALTH_RED =3D 25,
> +       LED_HEALTH_AMBER =3D 26,
> +       PWR_BTN_INT =3D 27,
> +       UID_PRESS_INT =3D 28,
> +       SLP_INT =3D 29,
> +       ACM_FORCE_OFF =3D 30,
> +       ACM_REMOVED =3D 31,
> +       ACM_REQ_N =3D 32,
> +       PSU1_INST =3D 33,
> +       PSU2_INST =3D 34,
> +       PSU3_INST =3D 35,
> +       PSU4_INST =3D 36,
> +       PSU5_INST =3D 37,
> +       PSU6_INST =3D 38,
> +       PSU7_INST =3D 39,
> +       PSU8_INST =3D 40,
> +       PSU1_AC =3D 41,
> +       PSU2_AC =3D 42,
> +       PSU3_AC =3D 43,
> +       PSU4_AC =3D 44,
> +       PSU5_AC =3D 45,
> +       PSU6_AC =3D 46,
> +       PSU7_AC =3D 47,
> +       PSU8_AC =3D 48,
> +       PSU1_DC =3D 49,
> +       PSU2_DC =3D 50,
> +       PSU3_DC =3D 51,
> +       PSU4_DC =3D 52,
> +       PSU5_DC =3D 53,
> +       PSU6_DC =3D 54,
> +       PSU7_DC =3D 55,
> +       PSU8_DC =3D 56,
> +       RESET =3D 57,
> +       NMI_OUT =3D 58,
> +       VPBTN =3D 59,
> +       PGOOD =3D 60,
> +       PERST =3D 61,
> +       POST_COMPLETE =3D 62,
> +};
> +
> +/* Provide info for fan driver */
> +u8 fan_presence;
> +EXPORT_SYMBOL(fan_presence);
> +

This is awful. Not only do you export a random global variable with no
namespace prefix - that's also not declared in any header - but you
then set this singular global variable from per-device probe().

There's no other mention of this anywhere, so please explain who needs
that and I'm sure we can find a better solution.

Bart

> +u8 fan_fail;
> +EXPORT_SYMBOL(fan_fail);
> +
> +/* Remember last PSU config */
> +u8 psu_presence;
> +
> +struct gxp_gpio_drvdata {
> +       struct regmap *base;
> +       struct regmap *interrupt;
> +       struct gpio_chip chip;
> +       int irq;
> +};
> +
> +static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
> +                                          char *reg_name, u8 bits)
> +{
> +       struct regmap_config regmap_config =3D {
> +               .reg_bits =3D 32,
> +               .reg_stride =3D 4,
> +               .val_bits =3D 32,
> +       };
> +       void __iomem *base;
> +
> +       if (bits =3D=3D 8) {
> +               regmap_config.reg_bits =3D 8;
> +               regmap_config.reg_stride =3D 1;
> +               regmap_config.val_bits =3D 8;
> +               regmap_config.max_register =3D 0xff;
> +       }
> +
> +       base =3D devm_platform_ioremap_resource_byname(pdev, reg_name);
> +       if (IS_ERR(base))
> +               return ERR_CAST(base);
> +
> +       regmap_config.name =3D reg_name;
> +
> +       return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> +}
> +
> +static int gxp_gpio_pl_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +       int ret =3D 0;
> +
> +       switch (offset) {
> +       case IOP_LED1 ... IOP_LED8:
> +               regmap_read(drvdata->base, PLREG_IOP_LED, &val);
> +               ret =3D (val & BIT(offset)) ? 1 : 0;
> +               break;
> +       case FAN1_INST ...FAN8_INST:
> +               regmap_read(drvdata->base, PLREG_FAN_INST, &val);
> +               fan_presence =3D (u8)val;
> +               ret =3D (fan_presence & BIT((offset - FAN1_INST))) ? 1 : =
0;
> +               break;
> +       case FAN1_FAIL ... FAN8_FAIL:
> +               regmap_read(drvdata->base, PLREG_FAN_FAIL, &val);
> +               fan_fail =3D (u8)val;
> +               ret =3D (fan_fail & BIT((offset - FAN1_FAIL))) ? 1 : 0;
> +               break;
> +       case PWR_BTN_INT ... SLP_INT:
> +               regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
> +               /* Active low */
> +               ret =3D (val & BIT((offset - PWR_BTN_INT) + 16)) ? 0 : 1;
> +               break;
> +       case  PSU1_INST ... PSU8_INST:
> +               regmap_read(drvdata->base, PLREG_PSU_INST, &val);
> +               psu_presence =3D (u8)val;
> +               ret =3D (psu_presence & BIT((offset - PSU1_INST))) ? 1 : =
0;
> +               break;
> +       case PSU1_AC ... PSU8_AC:
> +               regmap_read(drvdata->base, PLREG_PSU_AC, &val);
> +               ret =3D (val & BIT((offset - PSU1_AC))) ? 1 : 0;
> +               break;
> +       case PSU1_DC ... PSU8_DC:
> +               regmap_read(drvdata->base, PLREG_PSU_DC, &val);
> +               ret =3D (val & BIT((offset - PSU1_DC))) ? 1 : 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static void gxp_gpio_pl_set(struct gpio_chip *chip,
> +                           unsigned int offset, int value)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +
> +       switch (offset) {
> +       case IOP_LED1 ... IOP_LED8:
> +               regmap_update_bits(drvdata->base,
> +                                  PLREG_IOP_LED,
> +                                  BIT(offset),
> +                                  value =3D=3D 0 ? 0 : BIT(offset));
> +               break;
> +       case LED_IDENTIFY:
> +               regmap_update_bits(drvdata->base,
> +                                  PLREG_IDENT_LED,
> +                                  BIT(7) | BIT(6),
> +                                  value =3D=3D 0 ? BIT(7) : BIT(7) | BIT=
(6));
> +               break;
> +       case LED_HEALTH_RED:
> +               regmap_update_bits(drvdata->base,
> +                                  PLREG_HEALTH_LED,
> +                                  BIT(7),
> +                                  value =3D=3D 0 ? 0 : BIT(7));
> +               break;
> +       case LED_HEALTH_AMBER:
> +               regmap_update_bits(drvdata->base,
> +                                  PLREG_HEALTH_LED,
> +                                  BIT(6),
> +                                  value =3D=3D 0 ? 0 : BIT(6));
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_pl_get_direction(struct gpio_chip *chip, unsigned in=
t offset)
> +{
> +       int ret =3D GXP_GPIO_DIR_IN;
> +
> +       switch (offset) {
> +       case IOP_LED1 ... IOP_LED8:
> +       case LED_IDENTIFY ... LED_HEALTH_AMBER:
> +       case ACM_FORCE_OFF:
> +       case ACM_REQ_N:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_pl_direction_input(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case 8 ... 55:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       case 59 ... 65:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_pl_direction_output(struct gpio_chip *chip,
> +                                       unsigned int offset, int value)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case IOP_LED1 ... IOP_LED8:
> +       case LED_IDENTIFY ... LED_HEALTH_AMBER:
> +       case ACM_FORCE_OFF:
> +       case ACM_REQ_N:
> +               gxp_gpio_pl_set(chip, offset, value);
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static void gxp_gpio_pl_irq_ack(struct irq_data *d)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +
> +       /* Read latched interrupt for group 5 */
> +       regmap_read(drvdata->interrupt, PLREG_INT_GRP5_FLAG, &val);
> +       /* Clear latched interrupt */
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLAG,
> +                          0xFF, 0xFF);
> +
> +       /* Read latched interrupt for group 6 */
> +       regmap_read(drvdata->interrupt, PLREG_INT_GRP6_FLAG, &val);
> +       /* Clear latched interrupt */
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
> +                          0xFF, 0xFF);
> +}
> +
> +static void gxp_gpio_pl_irq_set_mask(struct irq_data *d, bool set)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
> +                          BIT(0) | BIT(2), set ? 0 : BIT(0) | BIT(2));
> +
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
> +                          BIT(2), set ? 0 : BIT(2));
> +}
> +
> +static void gxp_gpio_pl_irq_mask(struct irq_data *d)
> +{
> +       gxp_gpio_pl_irq_set_mask(d, false);
> +}
> +
> +static void gxp_gpio_pl_irq_unmask(struct irq_data *d)
> +{
> +       gxp_gpio_pl_irq_set_mask(d, true);
> +}
> +
> +static int gxp_gpio_irq_init_hw(struct gpio_chip *chip)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
> +                          BIT(0) | BIT(2), 0);
> +
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
> +                          BIT(2), 0);
> +
> +       return 0;
> +}
> +
> +static int gxp_gpio_pl_set_type(struct irq_data *d, unsigned int type)
> +{
> +       if (type & IRQ_TYPE_LEVEL_MASK)
> +               irq_set_handler_locked(d, handle_level_irq);
> +       else
> +               irq_set_handler_locked(d, handle_edge_irq);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t gxp_gpio_pl_irq_handle(int irq, void *_drvdata)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D (struct gxp_gpio_drvdata *)_=
drvdata;
> +       unsigned int val, girq, i;
> +
> +       /* Check group 5 interrupts */
> +
> +       regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
> +
> +       if (val) {
> +               for_each_set_bit(i, (unsigned long *)&val, 3) {
> +                       girq =3D irq_find_mapping(drvdata->chip.irq.domai=
n,
> +                                               i + PWR_BTN_INT);
> +                       generic_handle_irq(girq);
> +               }
> +
> +               /* Clear latched interrupt */
> +               regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLA=
G,
> +                                  0xFF, 0xFF);
> +               regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BAS=
E,
> +                                  BIT(0) | BIT(2), 0);
> +       }
> +
> +       /* Check group 6 interrupts */
> +
> +       regmap_read(drvdata->base, PLREG_INT_GRP6_FLAG, &val);
> +
> +       if (val & BIT(2)) {
> +               u8 old_psu =3D psu_presence;
> +
> +               regmap_read(drvdata->base, PLREG_PSU_INST, &val);
> +               psu_presence =3D (u8)val;
> +
> +               if (old_psu !=3D psu_presence) {
> +                       /* Identify all bits which differs */
> +                       u8 current_val =3D psu_presence;
> +                       u8 old_val =3D old_psu;
> +
> +                       for (i =3D 0 ; i < 8 ; i++) {
> +                               if ((current_val & 0x1) !=3D (old_val & 0=
x1)) {
> +                               /* PSU state has changed */
> +                                       girq =3D irq_find_mapping(drvdata=
->chip.irq.domain,
> +                                                               i + PSU1_=
INST);
> +                                       if (girq)
> +                                               generic_handle_irq(girq);
> +                               }
> +                               current_val =3D current_val >> 1;
> +                               old_val =3D old_val >> 1;
> +                       }
> +               }
> +       }
> +
> +       /* Clear latched interrupt */
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
> +                          0xFF, 0xFF);
> +       regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
> +                          BIT(2), 0);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static struct gpio_chip plreg_chip =3D {
> +       .label                  =3D "gxp_gpio_plreg",
> +       .owner                  =3D THIS_MODULE,
> +       .get                    =3D gxp_gpio_pl_get,
> +       .set                    =3D gxp_gpio_pl_set,
> +       .get_direction =3D gxp_gpio_pl_get_direction,
> +       .direction_input =3D gxp_gpio_pl_direction_input,
> +       .direction_output =3D gxp_gpio_pl_direction_output,
> +       .base =3D -1,
> +};
> +
> +static struct irq_chip gxp_plreg_irqchip =3D {
> +       .name           =3D "gxp_plreg",
> +       .irq_ack        =3D gxp_gpio_pl_irq_ack,
> +       .irq_mask       =3D gxp_gpio_pl_irq_mask,
> +       .irq_unmask     =3D gxp_gpio_pl_irq_unmask,
> +       .irq_set_type   =3D gxp_gpio_pl_set_type,
> +};
> +
> +static int gxp_gpio_pl_init(struct platform_device *pdev)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(&pdev->dev);
> +       struct gpio_irq_chip *girq;
> +       int ret;
> +       unsigned int val;
> +
> +       drvdata->base =3D gxp_gpio_init_regmap(pdev, "base", 8);
> +       if (IS_ERR(drvdata->base))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->base),
> +                                    "failed to map base\n");
> +
> +       drvdata->interrupt =3D gxp_gpio_init_regmap(pdev, "interrupt", 8)=
;
> +       if (IS_ERR(drvdata->interrupt))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->interru=
pt),
> +                                    "failed to map interrupt base\n");
> +
> +       regmap_read(drvdata->base, PLREG_FAN_INST, &val);
> +       fan_presence =3D (u8)val;
> +
> +       regmap_read(drvdata->base, PLREG_FAN_FAIL, &val);
> +       fan_fail =3D (u8)val;
> +
> +       regmap_read(drvdata->base, PLREG_PSU_INST, &val);
> +       psu_presence =3D (u8)val;
> +
> +       drvdata->chip =3D plreg_chip;
> +       drvdata->chip.ngpio =3D 57;
> +       drvdata->chip.parent =3D &pdev->dev;
> +
> +       girq =3D &drvdata->chip.irq;
> +       girq->chip =3D &gxp_plreg_irqchip;
> +       girq->parent_handler =3D NULL;
> +       girq->num_parents =3D 0;
> +       girq->parents =3D NULL;
> +       girq->default_type =3D IRQ_TYPE_NONE;
> +       girq->handler =3D handle_bad_irq;
> +
> +       girq->init_hw =3D gxp_gpio_irq_init_hw;
> +
> +       ret =3D devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdat=
a);
> +       if (ret < 0)
> +               dev_err_probe(&pdev->dev, ret, "Could not register gpioch=
ip for plreg\n");
> +
> +       regmap_update_bits(drvdata->base,
> +                          PLREG_INT_HI_PRI_EN,
> +                          PLREG_GRP4_GRP5_MASK,
> +                          PLREG_GRP4_GRP5_MASK);
> +       regmap_update_bits(drvdata->base,
> +                          PLREG_INT_GRP_STAT_MASK,
> +                          PLREG_GRP4_GRP5_MASK,
> +                          0x00);
> +       regmap_read(drvdata->base, PLREG_INT_HI_PRI_EN, &val);
> +       regmap_read(drvdata->base, PLREG_INT_GRP_STAT_MASK, &val);
> +
> +       ret =3D platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return dev_err_probe(&pdev->dev, ret, "Get irq from platf=
orm fail\n");
> +
> +       drvdata->irq =3D ret;
> +
> +       ret =3D devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_ir=
q_handle,
> +                              IRQF_SHARED, "gxp-pl", drvdata);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id gxp_gpio_of_match[] =3D {
> +       { .compatible =3D "hpe,gxp-gpio-pl" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
> +
> +static int gxp_gpio_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct gxp_gpio_drvdata *drvdata;
> +
> +       /* Initialize global vars */
> +       fan_presence =3D 0;
> +       fan_fail =3D 0;
> +       psu_presence =3D 0;
> +
> +       drvdata =3D devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL=
);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, drvdata);
> +
> +       ret =3D gxp_gpio_pl_init(pdev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver gxp_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "gxp-gpio-pl",
> +               .of_match_table =3D gxp_gpio_of_match,
> +       },
> +       .probe =3D gxp_gpio_probe,
> +};
> +module_platform_driver(gxp_gpio_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("GPIO PL interface for GXP");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpio/gpio-gxp.c b/drivers/gpio/gpio-gxp.c
> new file mode 100644
> index 000000000000..ed6d8577e6b7
> --- /dev/null
> +++ b/drivers/gpio/gpio-gxp.c
> @@ -0,0 +1,637 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.=
P. */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define GPIDAT         0x040
> +#define GPODAT         0x0b0
> +#define GPODAT2                0x0f8
> +#define GPOOWN         0x110
> +#define GPOOWN2                0x118
> +#define ASR_OFS                0x05c
> +
> +#define GXP_GPIO_DIR_OUT       0
> +#define GXP_GPIO_DIR_IN                1
> +
> +#define PGOOD_MASK     BIT(0)
> +
> +struct gxp_gpio_drvdata {
> +       struct gpio_chip chip;
> +       struct regmap *csm_map;
> +       void __iomem *fn2_vbtn;
> +       struct regmap *fn2_stat;
> +       struct regmap *vuhc0_map;
> +       int irq;
> +};
> +
> +/*
> + * Note: Instead of definining all PINs here are the select few that
> + * are specifically defined in DTS and offsets are used here.
> + */
> +enum gxp_gpio_pn {
> +       RESET =3D 192,
> +       VPBTN =3D 210, /* aka POWER_OK */
> +       PGOOD =3D 211, /* aka PS_PWROK */
> +       PERST =3D 212, /* aka PCIERST */
> +       POST_COMPLETE =3D 213,
> +};
> +
> +static int gxp_gpio_csm_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       int ret =3D 0;
> +
> +       switch (offset) {
> +       case 0 ... 31:
> +               regmap_read(drvdata->csm_map, GPIDAT, &ret);
> +               ret =3D (ret & BIT(offset));
> +               break;
> +       case 32 ... 63:
> +               regmap_read(drvdata->csm_map, GPIDAT + 0x20, &ret);
> +               ret =3D (ret & BIT(offset - 32));
> +               break;
> +       case 64 ... 95:
> +               regmap_read(drvdata->csm_map, GPODAT, &ret);
> +               ret =3D (ret & BIT(offset - 64));
> +               break;
> +       case 96 ... 127:
> +               regmap_read(drvdata->csm_map, GPODAT + 0x04, &ret);
> +               ret =3D (ret & BIT(offset - 96));
> +               break;
> +       case 128 ...  159:
> +               regmap_read(drvdata->csm_map, GPODAT2, &ret);
> +               ret =3D (ret & BIT(offset - 128));
> +               break;
> +       case 160 ... 191:
> +               regmap_read(drvdata->csm_map, GPODAT2 + 0x04, &ret);
> +               ret =3D (ret & BIT(offset - 160));
> +               break;
> +       case RESET:
> +               /* SW_RESET */
> +               regmap_read(drvdata->csm_map, ASR_OFS, &ret);
> +               ret =3D (ret & BIT(15));
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       /* Return either 1 or 0 */
> +       return (ret ? 1 : 0);
> +}
> +
> +static void gxp_gpio_csm_set(struct gpio_chip *chip, unsigned int offset=
,
> +                            int value)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       u32 tmp;
> +
> +       switch (offset) {
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
> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_csm_get_direction(struct gpio_chip *chip,
> +                                     unsigned int offset)
> +{
> +       int ret =3D 0;
> +
> +       switch (offset) {
> +       case 0 ... 63:
> +               ret =3D GXP_GPIO_DIR_IN;
> +               break;
> +       case 64 ... 191:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       case 192 ... 193:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       case 194:
> +               ret =3D GXP_GPIO_DIR_IN;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_csm_direction_input(struct gpio_chip *chip,
> +                                       unsigned int offset)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case 0 ... 63:
> +               ret =3D 0;
> +               break;
> +       case 194:
> +               ret =3D 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_csm_direction_output(struct gpio_chip *chip,
> +                                        unsigned int offset, int value)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case 64 ... 191:
> +       case 192 ... 193:
> +               gxp_gpio_csm_set(chip, offset, value);
> +               ret =3D 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_vuhc_get(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +       int ret =3D 0;
> +
> +       if (offset < 8) {
> +               regmap_read(drvdata->vuhc0_map, 0x64 + 4 * offset,   &val=
);
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
> +       switch (offset) {
> +       default:
> +               break;
> +       }
> +}
> +
> +static int gxp_gpio_vuhc_get_direction(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       int ret =3D 0;
> +
> +       switch (offset) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               ret =3D GXP_GPIO_DIR_IN;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_vuhc_direction_input(struct gpio_chip *chip,
> +                                        unsigned int offset)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               ret =3D 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_vuhc_direction_output(struct gpio_chip *chip,
> +                                         unsigned int offset, int value)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_fn2_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +       int ret =3D 0;
> +
> +       switch (offset) {
> +       case PGOOD:
> +               regmap_read(drvdata->fn2_stat, 0, &val);
> +               ret =3D (val & BIT(24));
> +
> +               break;
> +       case PERST:
> +               regmap_read(drvdata->fn2_stat, 0, &val);
> +               ret =3D (val & BIT(25));
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       /* Return either 1 or 0 */
> +       return (ret ? 1 : 0);
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
> +       int ret =3D GXP_GPIO_DIR_IN;
> +
> +       switch (offset) {
> +       case VPBTN:
> +               ret =3D GXP_GPIO_DIR_OUT;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_fn2_direction_input(struct gpio_chip *chip,
> +                                       unsigned int offset)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       switch (offset) {
> +       case PGOOD:
> +       case PERST:
> +       case POST_COMPLETE:
> +               ret =3D 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       int ret =3D 0;
> +
> +       if (offset < 200)
> +               ret =3D gxp_gpio_csm_get(chip, offset);
> +       else if (offset >=3D 250 && offset < 300)
> +               ret =3D gxp_gpio_vuhc_get(chip, offset - 250);
> +       else if (offset >=3D 300)
> +               ret =3D gxp_gpio_fn2_get(chip, offset);
> +
> +       return ret;
> +}
> +
> +static void gxp_gpio_set(struct gpio_chip *chip,
> +                        unsigned int offset, int value)
> +{
> +       if (offset < 200)
> +               gxp_gpio_csm_set(chip, offset, value);
> +       else if (offset >=3D 250 && offset < 300)
> +               gxp_gpio_vuhc_set(chip, offset - 250, value);
> +       else if (offset >=3D 300)
> +               gxp_gpio_fn2_set(chip, offset, value);
> +}
> +
> +static int gxp_gpio_get_direction(struct gpio_chip *chip,
> +                                 unsigned int offset)
> +{
> +       int ret =3D 0;
> +
> +       if (offset < 200)
> +               ret =3D gxp_gpio_csm_get_direction(chip, offset);
> +       else if (offset >=3D 250 && offset < 300)
> +               ret =3D gxp_gpio_vuhc_get_direction(chip, offset - 250);
> +       else if (offset >=3D 300)
> +               ret =3D gxp_gpio_fn2_get_direction(chip, offset);
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_direction_input(struct gpio_chip *chip,
> +                                   unsigned int offset)
> +{
> +       int ret =3D 0;
> +
> +       if (offset < 200)
> +               ret =3D gxp_gpio_csm_direction_input(chip, offset);
> +       else if (offset >=3D 250 && offset < 300)
> +               ret =3D gxp_gpio_vuhc_direction_input(chip, offset - 250)=
;
> +       else if (offset >=3D 300)
> +               ret =3D gxp_gpio_fn2_direction_input(chip, offset);
> +
> +       return ret;
> +}
> +
> +static int gxp_gpio_direction_output(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +{
> +       int ret =3D 0;
> +
> +       if (offset < 200)
> +               ret =3D gxp_gpio_csm_direction_output(chip, offset, value=
);
> +       else if (offset >=3D 250 && offset < 300)
> +               ret =3D gxp_gpio_vuhc_direction_output(chip, offset - 250=
, value);
> +       return ret;
> +}
> +
> +static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
> +                                          char *reg_name, u8 bits)
> +{
> +       struct regmap_config regmap_config =3D {
> +               .reg_bits =3D 32,
> +               .reg_stride =3D 4,
> +               .val_bits =3D 32,
> +       };
> +       void __iomem *base;
> +
> +       if (bits =3D=3D 8) {
> +               regmap_config.reg_bits =3D 8;
> +               regmap_config.reg_stride =3D 1;
> +               regmap_config.val_bits =3D 8;
> +               regmap_config.max_register =3D 0xff;
> +       }
> +
> +       base =3D devm_platform_ioremap_resource_byname(pdev, reg_name);
> +       if (IS_ERR(base))
> +               return ERR_CAST(base);
> +
> +       regmap_config.name =3D reg_name;
> +
> +       return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> +}
> +
> +static void gxp_gpio_fn2_irq_ack(struct irq_data *d)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +       unsigned int val;
> +
> +       /* Read latched interrupt */
> +       regmap_read(drvdata->fn2_stat, 0, &val);
> +       /* Clear latched interrupt */
> +       regmap_update_bits(drvdata->fn2_stat, 0,
> +                          0xFFFF, 0xFFFF);
> +}
> +
> +#define FN2_SEVMASK BIT(2)
> +static void gxp_gpio_fn2_irq_set_mask(struct irq_data *d, bool set)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(chip->parent=
);
> +
> +       regmap_update_bits(drvdata->fn2_stat, FN2_SEVMASK,
> +                          BIT(0), set ? BIT(0) : 0);
> +}
> +
> +static void gxp_gpio_fn2_irq_mask(struct irq_data *d)
> +{
> +       gxp_gpio_fn2_irq_set_mask(d, false);
> +}
> +
> +static void gxp_gpio_fn2_irq_unmask(struct irq_data *d)
> +{
> +       gxp_gpio_fn2_irq_set_mask(d, true);
> +}
> +
> +static int gxp_gpio_fn2_set_type(struct irq_data *d, unsigned int type)
> +{
> +       if (type & IRQ_TYPE_LEVEL_MASK)
> +               irq_set_handler_locked(d, handle_level_irq);
> +       else
> +               irq_set_handler_locked(d, handle_edge_irq);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t gxp_gpio_fn2_irq_handle(int irq, void *_drvdata)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D (struct gxp_gpio_drvdata *)_=
drvdata;
> +       unsigned int val, girq;
> +
> +       regmap_read(drvdata->fn2_stat, 0, &val);
> +
> +       if (val & PGOOD_MASK) {
> +               girq =3D irq_find_mapping(drvdata->chip.irq.domain, PGOOD=
);
> +               generic_handle_irq(girq);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static struct irq_chip gxp_gpio_irqchip =3D {
> +       .name           =3D "gxp_fn2",
> +       .irq_ack        =3D gxp_gpio_fn2_irq_ack,
> +       .irq_mask       =3D gxp_gpio_fn2_irq_mask,
> +       .irq_unmask     =3D gxp_gpio_fn2_irq_unmask,
> +       .irq_set_type   =3D gxp_gpio_fn2_set_type,
> +};
> +
> +static struct gpio_chip common_chip =3D {
> +       .label                  =3D "gxp_gpio",
> +       .owner                  =3D THIS_MODULE,
> +       .get                    =3D gxp_gpio_get,
> +       .set                    =3D gxp_gpio_set,
> +       .get_direction          =3D gxp_gpio_get_direction,
> +       .direction_input        =3D gxp_gpio_direction_input,
> +       .direction_output       =3D gxp_gpio_direction_output,
> +       .base =3D 0,
> +};
> +
> +static int gxp_gpio_init(struct platform_device *pdev)
> +{
> +       struct gxp_gpio_drvdata *drvdata =3D dev_get_drvdata(&pdev->dev);
> +       struct gpio_irq_chip *girq;
> +       int ret;
> +
> +       drvdata->csm_map =3D gxp_gpio_init_regmap(pdev, "csm", 32);
> +       if (IS_ERR(drvdata->csm_map))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->csm_map=
),
> +                                    "failed to map csm_handle\n");
> +
> +       drvdata->fn2_vbtn =3D devm_platform_ioremap_resource_byname(pdev,=
 "fn2-vbtn");
> +       if (IS_ERR(drvdata->fn2_vbtn))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_vbt=
n),
> +                                    "failed to map fn2_vbtn\n");
> +
> +       drvdata->fn2_stat =3D gxp_gpio_init_regmap(pdev, "fn2-stat", 32);
> +       if (IS_ERR(drvdata->fn2_stat))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_sta=
t),
> +                                    "failed to map fn2_stat\n");
> +
> +       drvdata->vuhc0_map =3D gxp_gpio_init_regmap(pdev, "vuhc", 32);
> +       if (IS_ERR(drvdata->vuhc0_map))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->vuhc0_m=
ap),
> +                                    "failed to map vuhc0_map\n");
> +
> +       girq =3D &drvdata->chip.irq;
> +       girq->chip =3D &gxp_gpio_irqchip;
> +       girq->parent_handler =3D NULL;
> +       girq->num_parents =3D 0;
> +       girq->parents =3D NULL;
> +       girq->default_type =3D IRQ_TYPE_NONE;
> +       girq->handler =3D handle_bad_irq;
> +
> +       ret =3D platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "Get irq from platform fail\n");
> +
> +       drvdata->irq =3D ret;
> +
> +       ret =3D devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_fn2_i=
rq_handle,
> +                              IRQF_SHARED, "gxp-fn2", drvdata);
> +       if (ret < 0)
> +               return ret;
> +
> +       drvdata->chip =3D common_chip;
> +       drvdata->chip.ngpio =3D 220;
> +
> +       drvdata->chip.parent =3D &pdev->dev;
> +       ret =3D devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, NULL);
> +       if (ret < 0)
> +               return dev_err_probe(&pdev->dev, ret,
> +                       "Could not register gpiochip for fn2\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id gxp_gpio_of_match[] =3D {
> +       { .compatible =3D "hpe,gxp-gpio" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
> +
> +static int gxp_gpio_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct gxp_gpio_drvdata *drvdata;
> +
> +       drvdata =3D devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL=
);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, drvdata);
> +
> +       ret =3D gxp_gpio_init(pdev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver gxp_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "gxp-gpio",
> +               .of_match_table =3D gxp_gpio_of_match,
> +       },
> +       .probe =3D gxp_gpio_probe,
> +};
> +module_platform_driver(gxp_gpio_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("GPIO interface for GXP");
> +MODULE_LICENSE("GPL");
> --
> 2.17.1
>
