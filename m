Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D963ED71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLAKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLAKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:17:32 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1186934D6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:17:28 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id c184so1093720vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZCKGaqTSd8c0ZGF+iWS00lEI9D8MG9fU/uPERWzZsk=;
        b=rn0fee2LbYEWpSGXks1bbs/bDYRgcFb0lE93TZVHuzvA0EAUsdLufXpRqJasnGx+uG
         L3/2fTYSO3CA1GBce0I2nbqaelQZDnwGJQPPeoqDd/b8zzNCgptMYu0innREmhoWKcM1
         K02NkacZapCQzIa+ECeURID9vJJBgv9GavHKPtvAtMowDuUp1OsMWP1As3WR1Mq84B2g
         QKphHiJZ9mKnyDFakJYzdP/Oj/v83rhX2RdWCErUTXJ4kq1hWJV0d679pjiHK44yUOXx
         o/00GREyTxNl7dgXHiBlYaVTGv6cbcUSuuiazSTthXezDR6LWHUoGtawAiWc2NNV6j0i
         Smtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZCKGaqTSd8c0ZGF+iWS00lEI9D8MG9fU/uPERWzZsk=;
        b=cl96/7No4X+61xzZJpdpBtslI9k/D5GdD0IuYaKMQN+bhVvlb6zT9UaoSMB4awEoLN
         R4tCvx0ky2kTqmILPx0tPyzbBI01Q7kSm1H6ApKwYSFbisBcY/ypQhaXBzrrobhxn3kb
         9yv3cS657kPJRxCIlPnoUt118ZUD7iu204O74yPyAGTsfmXh8lcp/NNCWfNeAmOo7yAO
         PYKcFLfFOqcjlwi3/ApzFyq7VbFVYLBQYmjk/q51TY8rQc6QXJSCx2hlrcc968oXHAc1
         9cG9jiilnYUubBY100zio/34L/bokfJPzphcP9THzgbHd0ptWEpFYozf1Df+KbFyHNQV
         tomg==
X-Gm-Message-State: ANoB5pnQ2LslB4KDy68iSVJhuJ7zAISuJsos4EXa+9p/q/VbjArhflmF
        MmLyQVsNFCXnDGRk625JToXPZcn3QWCHTT3zhC62GA==
X-Google-Smtp-Source: AA0mqf5DN/ifLrkiIFhZvFQ8yi8/eTprE87KQrHPNLlbfHQq/EhqcBxQs6q+7cnKLJEMKfNr0DDejJhjI7J2JPB6ITM=
X-Received: by 2002:a67:eb11:0:b0:3b0:c9bc:7abe with SMTP id
 a17-20020a67eb11000000b003b0c9bc7abemr5961331vso.61.1669889847692; Thu, 01
 Dec 2022 02:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20221129020047.12151-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221129020047.12151-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Dec 2022 11:17:16 +0100
Message-ID: <CAMRc=Mcc43R3m2hGWbwGYQhPo64cgwjXvine=S5OYfoSPZT8QQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 3:00 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>
> The Loongson platforms GPIO controller contains 60 GPIO pins in total,
> 4 of which are dedicated GPIO pins, and the remaining 56 are reused
> with other functions. Each GPIO can set input/output and has the
> interrupt capability.
>
> This driver added support for Loongson GPIO controller and support to
> use DTS or ACPI to descibe GPIO device resources.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

This looks mostly good and ready but I still have a couple nits to point out.

> Change in v9:
>                 1. Fixup the xxx_device_id data field naming method.
>                 2. Remove the "offset >= chip->ngpio" judgement in loongson_gpio_to_irq.
> Change in v8:
>                 1. Return the loongson_gpio_init function directly in probe.
> Change in v7:
>                 1. Add the gpio irqchip support.
>                 2. Replace __set_direction with loongson_commit_direction.
>                 3. Replace __set_level with loongson_commit_level.
>                 4. Remove the parser of gsi_idx_map.
>                 5. Add the support_irq flag.
>                 6. Replace string platform_data with chip_data.
>                 7. Remove the loongson_gpio_request.
> Change in v6:
>                 1. Remove the bit mode keep byte mode in all function except
>                    loongson_gpio_init.
>                 2. Use bgpio_init replace bit mode.
>                 3. Implement the function loongson_gpio_get_direction for byte mode.
>                 4. Set ngpios after call bgpio_init.
>                 5. Use gpio-loongson-64bit.c as driver filename.
>                 6. Ignore that loongson legacy drvier and remove the patch about
>                    "gpio: loongson2ef: move driver to original location".
> Change in v5:
>                 1. Move legacy gpio driver to proper location.
>                 2. Remove the "gpio_base".
>                 3. Add of_device_id and acpi_device_id data field for platform
>                    data.
>                 4. Remove the ACPI_PTR().
>                 5. Remove the gpio label judgement logic and use mode instead.
>                 6. Drop platform_loongson_gpio_get_props.
>                 7. Using devres for all resource.
>                 8. Remove the loongson_gpio_remove.
>                 9. Remove the unmatched print information.
>                 10. Remove the loongson_gpio_exit.
> Change in v4:
>                 1. Fixup name spelling about Signed-off-by.
>                 2. Drop "series" here and everywhere else.
>                 3. Fixup the copyright in driver.
>                 4. Drop the "else" in loongson_gpio_request.
>                 5. Use trinocular operation replace the related logic.
>                 6. Remove lable judgement in context about "lgpio->chip.to_irq =
>                    loongson_gpio_to_irq"
>                 7. Use dev_err replace pr_err in probe.
>                 8. Make legacy platform_data should be left out of this patch.
>                 9. Remove the mips config in gpio Kconfig.
> Change in v3:
>                 1. Move the gpio platform data struct from arch/ into include/linux/
>                    platform_data/.
>                 2. Replace platform_gpio_data with loongson_gpio_platform_data in .c.
>                 3. Add maintainer in MAINTAINERS file for include/linux/platform_data/
>                    gpio-loongson.h and gpio-loongson.c
> Change in v2:
>                 1. Fixup of_loongson_gpio_get_props and remove the parse logic about
>                    "loongson,conf_offset", "loongson,out_offset", "loongson,in_offset",
>                    "loongson,gpio_base", "loongson,support_irq" then kernel driver will
>                    initial them that depend compatible except "loongson,gpio_base".
>
>  MAINTAINERS                        |   6 +
>  drivers/gpio/Kconfig               |  12 +
>  drivers/gpio/Makefile              |   1 +
>  drivers/gpio/gpio-loongson-64bit.c | 375 +++++++++++++++++++++++++++++
>  4 files changed, 394 insertions(+)
>  create mode 100644 drivers/gpio/gpio-loongson-64bit.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114db9c8f32..2854da69cabb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12051,6 +12051,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>  F:     drivers/soc/loongson/loongson2_guts.c
>
> +LOONGSON GPIO DRIVER
> +M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:     linux-gpio@vger.kernel.org
> +S:     Maintained
> +F:     drivers/gpio/gpio-loongson-64bit.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>  M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a01af1180616..d3e2380dbacf 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -381,6 +381,18 @@ config GPIO_LOONGSON
>         help
>           Driver for GPIO functionality on Loongson-2F/3A/3B processors.
>
> +config GPIO_LOONGSON_64BIT
> +       tristate "Loongson 64 bit GPIO support"
> +       depends on LOONGARCH || COMPILE_TEST
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to support the GPIO functionality of a number of
> +         Loongson series of chips. The Loongson GPIO controller supports
> +         up to 60 GPIOS in total, 4 of which are dedicated GPIO pins, and
> +         the remaining 56 are reused with other functions, with edge or
> +         level triggered interrupts.
> +
>  config GPIO_LPC18XX
>         tristate "NXP LPC18XX/43XX GPIO support"
>         default y if ARCH_LPC18XX
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 29e3beb6548c..fc832484cc77 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_GPIO_KEMPLD)             += gpio-kempld.o
>  obj-$(CONFIG_GPIO_LOGICVC)             += gpio-logicvc.o
>  obj-$(CONFIG_GPIO_LOONGSON1)           += gpio-loongson1.o
>  obj-$(CONFIG_GPIO_LOONGSON)            += gpio-loongson.o
> +obj-$(CONFIG_GPIO_LOONGSON_64BIT)      += gpio-loongson-64bit.o
>  obj-$(CONFIG_GPIO_LP3943)              += gpio-lp3943.o
>  obj-$(CONFIG_GPIO_LP873X)              += gpio-lp873x.o
>  obj-$(CONFIG_GPIO_LP87565)             += gpio-lp87565.o
> diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
> new file mode 100644
> index 000000000000..32e4ef7ebf52
> --- /dev/null
> +++ b/drivers/gpio/gpio-loongson-64bit.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Loongson GPIO Support
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitops.h>
> +#include <linux/of_irq.h>
> +#include <asm/types.h>
> +
> +#define LOONGSON_GPIO_IN(x)            (x->reg_base +\
> +                                       x->p_data->in_offset)
> +#define LOONGSON_GPIO_OUT(x)           (x->reg_base +\
> +                                       x->p_data->out_offset)
> +#define LOONGSON_GPIO_OEN(x)           (x->reg_base +\
> +                                       x->p_data->conf_offset)
> +#define LOONGSON_GPIO_IN_BYTE(x, gpio) (x->reg_base +\
> +                                       x->p_data->in_offset + gpio)
> +#define LOONGSON_GPIO_OUT_BYTE(x, gpio)        (x->reg_base +\
> +                                       x->p_data->out_offset + gpio)
> +#define LOONGSON_GPIO_OEN_BYTE(x, gpio)        (x->reg_base +\
> +                                       x->p_data->conf_offset + gpio)
> +
> +enum loongson_gpio_mode {
> +       BIT_CTRL_MODE,
> +       BYTE_CTRL_MODE,
> +};
> +
> +struct loongson_gpio_chip_data {
> +       const char              *label;
> +       enum loongson_gpio_mode mode;
> +       int                     conf_offset;
> +       int                     out_offset;
> +       int                     in_offset;

Offsets should be expressed as unsigned ints IMO.

> +       bool                    support_irq;
> +};
> +
> +struct loongson_gpio_chip {
> +       struct gpio_chip        chip;
> +       struct fwnode_handle    *fwnode;
> +       spinlock_t              lock;
> +       void __iomem            *reg_base;
> +       const struct loongson_gpio_chip_data *p_data;

This is still called p_data suggesting some link to platform data.
Please change it.

> +};
> +
> +static inline void loongson_commit_direction(
> +                               struct loongson_gpio_chip *lgpio,
> +                               unsigned int pin, int input)
> +{
> +       u8  bval;
> +
> +       bval = input ? 1 : 0;

You can save a line by initializing the variable when declaring it.
Same elsewhere.

> +       writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
> +}
> +
> +static void loongson_commit_level(struct loongson_gpio_chip *lgpio,
> +                               unsigned int pin, int high)
> +{
> +       u8 bval;
> +
> +       bval = high ? 1 : 0;
> +       writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
> +}
> +
> +static int loongson_gpio_direction_input(
> +                               struct gpio_chip *chip, unsigned int pin)
> +{
> +       unsigned long flags;
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);

Please add a static inline to_loongson_gpio_chip() helper that wraps
the container_of() expansion and only needs a single argument.

> +
> +       spin_lock_irqsave(&lgpio->lock, flags);
> +       loongson_commit_direction(lgpio, pin, 1);
> +       spin_unlock_irqrestore(&lgpio->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int loongson_gpio_direction_output(
> +                               struct gpio_chip *chip, unsigned int pin,
> +                               int value)
> +{
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&lgpio->lock, flags);
> +       loongson_commit_level(lgpio, pin, value);
> +       loongson_commit_direction(lgpio, pin, 0);
> +       spin_unlock_irqrestore(&lgpio->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
> +{
> +       u8  bval;
> +       int val;
> +
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
> +       val = bval & 1;
> +
> +       return val;
> +}
> +
> +static int loongson_gpio_get_direction(
> +                               struct gpio_chip *chip, unsigned int pin)
> +{
> +       u8  bval;
> +       int val;
> +
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       bval = readb(LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
> +       val = bval & 1;
> +
> +       return val;
> +}
> +
> +static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin,
> +                       int value)
> +{
> +       unsigned long flags;
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       spin_lock_irqsave(&lgpio->lock, flags);
> +       loongson_commit_level(lgpio, pin, value);
> +       spin_unlock_irqrestore(&lgpio->lock, flags);
> +}
> +
> +static int loongson_gpio_to_irq(
> +                       struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct platform_device *pdev =
> +               container_of(chip->parent, struct platform_device, dev);
> +
> +       return platform_get_irq(pdev, offset);
> +}
> +
> +static void loongson_gpio_irq_ack(struct irq_data *d)
> +{
> +       irq_chip_ack_parent(d);
> +}
> +
> +static void loongson_gpio_mask_irq(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +       irq_chip_mask_parent(d);
> +       gpiochip_disable_irq(gc, d->hwirq);
> +}
> +
> +static void loongson_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +       gpiochip_enable_irq(gc, d->hwirq);
> +       irq_chip_unmask_parent(d);
> +}
> +
> +static int loongson_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_set_handler_locked(d, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               irq_set_handler_locked(d, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               irq_set_handler_locked(d, handle_level_irq);
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               irq_set_handler_locked(d, handle_level_irq);
> +               break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               irq_set_handler_locked(d, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_NONE:
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return irq_chip_set_type_parent(d, type);
> +}
> +
> +static const struct irq_chip loongson_gpio_irqchip = {
> +       .name = "loongson-gpio-irqchip",
> +       .irq_ack = loongson_gpio_irq_ack,
> +       .irq_mask = loongson_gpio_mask_irq,
> +       .irq_unmask = loongson_gpio_irq_unmask,
> +       .irq_set_type = loongson_gpio_irq_set_type,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static int loongson_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
> +                                            unsigned int child,
> +                                            unsigned int child_type,
> +                                            unsigned int *parent,
> +                                            unsigned int *parent_type)
> +{
> +       *parent_type = child_type;
> +
> +       /* GPIO lines 0..3 have dedicated IRQs */
> +       if (child >= 0 && child <= 3) {
> +               *parent = child + 60;
> +               return 0;
> +       }
> +
> +       if (child >= 4 && child <= 31) {
> +               *parent = 58;
> +               return 0;
> +       }
> +
> +       if (child >= 32 && child <= 63) {
> +               *parent = 59;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int loongson_gpio_init(
> +                       struct device *dev, struct loongson_gpio_chip *lgpio,
> +                       struct device_node *np, void __iomem *reg_base)
> +{
> +       int ret;
> +       u32 ngpios;
> +       struct irq_domain __maybe_unused *parent;

How is this __maybe_unused if it's clearly used below? Same for the other two.

> +       struct gpio_irq_chip __maybe_unused *girq;
> +       struct device_node __maybe_unused *irq_parent;
> +
> +       lgpio->reg_base = reg_base;
> +
> +       if (lgpio->p_data->mode == BIT_CTRL_MODE) {
> +               ret = bgpio_init(&lgpio->chip, dev, 8,
> +                               LOONGSON_GPIO_IN(lgpio),
> +                               LOONGSON_GPIO_OUT(lgpio), 0,
> +                               LOONGSON_GPIO_OEN(lgpio), NULL, 0);
> +               if (ret) {
> +                       dev_err(dev, "unable to init generic GPIO\n");
> +                       return ret;
> +               }
> +       } else {
> +               lgpio->chip.direction_input = loongson_gpio_direction_input;
> +               lgpio->chip.get = loongson_gpio_get;
> +               lgpio->chip.get_direction = loongson_gpio_get_direction;
> +               lgpio->chip.direction_output = loongson_gpio_direction_output;
> +               lgpio->chip.set = loongson_gpio_set;
> +               lgpio->chip.can_sleep = 0;
> +               lgpio->chip.of_node = np;
> +               lgpio->chip.parent = dev;
> +               spin_lock_init(&lgpio->lock);
> +       }
> +
> +       device_property_read_u32(dev, "ngpios", &ngpios);
> +
> +       lgpio->chip.ngpio = ngpios;
> +       lgpio->chip.label = lgpio->p_data->label;
> +
> +       if (lgpio->p_data->support_irq == true) {
> +               lgpio->chip.to_irq = loongson_gpio_to_irq;
> +               irq_parent = of_irq_find_parent(np);
> +               if (irq_parent)
> +                       parent = irq_find_host(irq_parent);
> +
> +               lgpio->fwnode = of_node_to_fwnode(np);
> +
> +               girq = &lgpio->chip.irq;
> +               gpio_irq_chip_set_chip(girq, &loongson_gpio_irqchip);
> +               girq->fwnode = lgpio->fwnode;
> +               girq->parent_domain = parent;
> +               girq->child_to_parent_hwirq = loongson_gpio_child_to_parent_hwirq;
> +               girq->handler = handle_bad_irq;
> +               girq->default_type = IRQ_TYPE_NONE;
> +       }
> +
> +       devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);

You still don't return this function directly as I asked for 3 versions earlier.

> +
> +       return 0;
> +}
> +
> +static int loongson_gpio_probe(struct platform_device *pdev)
> +{
> +       void __iomem *reg_base;
> +       struct loongson_gpio_chip *lgpio;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device *dev = &pdev->dev;
> +
> +       lgpio = devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
> +       if (!lgpio)
> +               return -ENOMEM;
> +
> +       lgpio->p_data = device_get_match_data(&pdev->dev);
> +
> +       reg_base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       return loongson_gpio_init(dev, lgpio, np, reg_base);
> +}
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k_data = {
> +       .label = "ls2k_gpio",
> +       .mode = BIT_CTRL_MODE,
> +       .conf_offset = 0x0,
> +       .in_offset = 0x10,
> +       .out_offset = 0x20,
> +       .support_irq = true,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls7a_data = {
> +       .label = "ls7a_gpio",
> +       .mode = BYTE_CTRL_MODE,
> +       .conf_offset = 0x800,
> +       .in_offset = 0x900,
> +       .out_offset = 0xa00,
> +       .support_irq = false,
> +};
> +
> +static const struct of_device_id loongson_gpio_of_match[] = {
> +       {
> +               .compatible = "loongson,ls2k-gpio",
> +               .data = &loongson_gpio_ls2k_data,
> +       },
> +       {
> +               .compatible = "loongson,ls7a-gpio",
> +               .data = &loongson_gpio_ls7a_data,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_gpio_of_match);
> +
> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
> +       {
> +               .id = "LOON0002",
> +               .driver_data = (kernel_ulong_t)&loongson_gpio_ls7a_data,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
> +
> +static struct platform_driver loongson_gpio_driver = {
> +       .driver = {
> +               .name = "loongson-gpio",
> +               .owner = THIS_MODULE,
> +               .of_match_table = loongson_gpio_of_match,
> +               .acpi_match_table = loongson_gpio_acpi_match,
> +       },
> +       .probe = loongson_gpio_probe,
> +};
> +
> +static int __init loongson_gpio_setup(void)
> +{
> +       return platform_driver_register(&loongson_gpio_driver);
> +}
> +postcore_initcall(loongson_gpio_setup);
> +
> +MODULE_DESCRIPTION("Loongson gpio driver");
> +MODULE_LICENSE("GPL");
> --
> 2.31.1
>

With the above I think it'll be ready to go in so if you can send it
today or tomorrow, it'll make the merge window.

Bart
