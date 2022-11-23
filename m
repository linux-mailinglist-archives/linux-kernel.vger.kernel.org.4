Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8473E635A69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiKWKlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiKWKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:41:13 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F77150470
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:25:17 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 125so719621vsi.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMErEw1suU1MT0P6/rMfRL5I1kRlC+tSYXA7ait891w=;
        b=CCX0hAVZ9Vu7nh/i8kLk5vfwMdholAjuN1BtN/t+fu2KBUcRtoi9nOgtX1lOKJwRAd
         2n8Pcm58dxnwFw7KTeIHGD+uTS52v9LWPKXSKJ03hxP3tb4eTA9VmLb9tLmwXjZpfQln
         aYlgYKav/S3ozCLllNKcvscTNFgRktsIqEpv+zMFl6fs0dG7mIPZvUgsULP8joxgFrrS
         X08e1a/zq1oI2RdZDuizc0upp2dddVn1k6Tgs2DsHAdBLTJBA6QmHyGvkKG8a9YElJRV
         7HvUIMPyXCtsq1DGs0DJwZBsvneLMmp8T9qMVtr/wbUogXb1X/Syt6Ce3KRo0fQzMq7t
         E3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMErEw1suU1MT0P6/rMfRL5I1kRlC+tSYXA7ait891w=;
        b=rj6cEopFvwdkTRyUsJmQM9Ira/ue7AMwJxE0TIuP7gOnw5SQM/z9iJlCj7CGPiljK9
         8H9Ydsv/VWCUI5AuuUaTFWmyI93IclU83fnVmaBSjZGOJiMlv4WatWS4ukwRDVAtdNz7
         /JiUMMUSl1rnJCr4mBp1YnffHlZN4tIUjL9nzZB76n/Qq7tM3ywpLQrpe87ky/VqAWRu
         Mohz1ReqCNSV7DRf07WAt1LTpNN7Oxa/3qOXQPRV8/f+J+WmrqMxbyutRAys4iLlQoZ+
         tG3QbLgw3S01JUNPFAPyMU0Lak1+ZpupczVzYwOfdxKE3PwleIyj2tOV8tbZJ1NmljbC
         6CQg==
X-Gm-Message-State: ANoB5pkiuYOvN7WufJ2eCK7pvz5Fx47CLORJRLe6K83imEm5rcrhtarg
        L1oyGa6NQ6nKbhQSbLf+V59GPm6rstN1u9z77rQEWg==
X-Google-Smtp-Source: AA0mqf5aDTc6a2KFe1GqCik0+hMjUl1Hs2e6BIYmbgRpq00JBCst36XYPmn8YZyE41EgP/LI6p5NIPdVhOsE27fOgFo=
X-Received: by 2002:a67:fbd6:0:b0:3ac:38c7:1bdd with SMTP id
 o22-20020a67fbd6000000b003ac38c71bddmr6198959vsr.9.1669199116260; Wed, 23 Nov
 2022 02:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20221123080414.14005-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221123080414.14005-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 23 Nov 2022 11:25:05 +0100
Message-ID: <CAMRc=MeyaQdmQxxuOag8a1zYo-4-5Qxvc4dX2pee7k37OD4GFQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: loongson: add gpio driver support
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

On Wed, Nov 23, 2022 at 9:04 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
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
> ---
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
>  drivers/gpio/Kconfig               |  11 +
>  drivers/gpio/Makefile              |   1 +
>  drivers/gpio/gpio-loongson-64bit.c | 315 +++++++++++++++++++++++++++++
>  4 files changed, 333 insertions(+)
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
> index a01af1180616..840e8a80af2b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -381,6 +381,17 @@ config GPIO_LOONGSON
>         help
>           Driver for GPIO functionality on Loongson-2F/3A/3B processors.
>
> +config GPIO_LOONGSON_64BIT
> +       tristate "Loongson 64 bit GPIO support"
> +       depends on LOONGARCH || COMPILE_TEST
> +       select GPIO_GENERIC
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
> index 000000000000..e0528a8768a0
> --- /dev/null
> +++ b/drivers/gpio/gpio-loongson-64bit.c
> @@ -0,0 +1,315 @@
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
> +struct loongson_gpio_platform_data {
> +       const char              *label;
> +       enum loongson_gpio_mode mode;
> +       int                     conf_offset;
> +       int                     out_offset;
> +       int                     in_offset;
> +};

Calling this platform_data is confusing as platform data is typically
used for structures associated with device instances, not device
types. There is no hard convention but normally it would be called
chip_data.

> +
> +struct loongson_gpio_chip {
> +       struct gpio_chip        chip;
> +       spinlock_t              lock;
> +       void __iomem            *reg_base;
> +       u16                     *gsi_idx_map;
> +       u16                     mapsize;
> +       const struct loongson_gpio_platform_data *p_data;
> +};
> +
> +static int loongson_gpio_request(
> +                       struct gpio_chip *chip, unsigned int pin)
> +{
> +       if (pin >= chip->ngpio)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
> +                       unsigned int pin, int input)
> +{
> +       u8  bval;
> +
> +       bval = input ? 1 : 0;
> +       writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
> +}
> +
> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
> +                       int high)
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
> +
> +       spin_lock_irqsave(&lgpio->lock, flags);
> +       __set_direction(lgpio, pin, 1);
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
> +       __set_level(lgpio, pin, value);
> +       __set_direction(lgpio, pin, 0);
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
> +       __set_level(lgpio, pin, value);
> +       spin_unlock_irqrestore(&lgpio->lock, flags);
> +}
> +
> +static int loongson_gpio_to_irq(
> +                       struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct platform_device *pdev =
> +               container_of(chip->parent, struct platform_device, dev);
> +       struct loongson_gpio_chip *lgpio =
> +               container_of(chip, struct loongson_gpio_chip, chip);
> +
> +       if (offset >= chip->ngpio)
> +               return -EINVAL;
> +
> +       if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
> +               offset = lgpio->gsi_idx_map[offset];
> +       else
> +               return -EINVAL;
> +
> +       return platform_get_irq(pdev, offset);
> +}
> +
> +static int loongson_gpio_init(
> +                       struct device *dev, struct loongson_gpio_chip *lgpio,
> +                       struct device_node *np, void __iomem *reg_base)
> +{
> +       int ret;
> +       u32 ngpios = lgpio->chip.ngpio;
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
> +               lgpio->chip.ngpio = ngpios;
> +               lgpio->chip.base = 0;
> +       } else {
> +               lgpio->chip.request = loongson_gpio_request;
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
> +       lgpio->chip.label = lgpio->p_data->label;
> +
> +       lgpio->chip.to_irq = loongson_gpio_to_irq;
> +
> +       devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
> +
> +       return 0;

You can return the above function directly.

> +}
> +
> +static void loongson_gpio_get_props(struct platform_device *pdev,
> +                                 struct loongson_gpio_chip *lgpio)
> +{
> +       int rval;
> +       u32 ngpios;
> +       struct device *dev = &pdev->dev;
> +
> +       device_property_read_u32(dev, "ngpios", &ngpios);
> +       lgpio->chip.ngpio = ngpios;
> +
> +       rval = device_property_read_u16_array(dev, "gsi_idx_map", NULL, 0);
> +       if (rval > 0) {
> +               lgpio->gsi_idx_map =
> +                       devm_kmalloc_array(dev, rval, sizeof(*lgpio->gsi_idx_map),
> +                                       GFP_KERNEL);
> +               if (lgpio->gsi_idx_map) {
> +                       lgpio->mapsize = rval;
> +                       device_property_read_u16_array(dev, "gsi_idx_map",
> +                                       lgpio->gsi_idx_map, lgpio->mapsize);
> +               }
> +       }
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
> +       loongson_gpio_get_props(pdev, lgpio);
> +
> +       lgpio->p_data = device_get_match_data(&pdev->dev);
> +
> +       reg_base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       loongson_gpio_init(dev, lgpio, np, reg_base);
> +
> +       return 0;
> +}
> +
> +static const struct loongson_gpio_platform_data loongson_gpio_pdata0 = {
> +       .label = "ls2k_gpio",
> +       .mode = BIT_CTRL_MODE,
> +       .conf_offset = 0x0,
> +       .in_offset = 0x10,
> +       .out_offset = 0x20,
> +};
> +
> +static const struct loongson_gpio_platform_data loongson_gpio_pdata1 = {
> +       .label = "ls7a_gpio",
> +       .mode = BYTE_CTRL_MODE,
> +       .conf_offset = 0x800,
> +       .in_offset = 0x900,
> +       .out_offset = 0xa00,
> +};
> +
> +static const struct of_device_id loongson_gpio_of_match[] = {
> +       {
> +               .compatible = "loongson,ls2k-gpio",
> +               .data = &loongson_gpio_pdata0,
> +       },
> +       {
> +               .compatible = "loongson,ls7a-gpio",
> +               .data = &loongson_gpio_pdata1,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_gpio_of_match);
> +
> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
> +       {
> +               .id = "LOON0002",
> +               .driver_data = (kernel_ulong_t)&loongson_gpio_pdata1,
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
