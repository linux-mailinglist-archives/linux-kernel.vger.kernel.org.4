Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1093D6BE9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCQMzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCQMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:54:58 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43B457F5;
        Fri, 17 Mar 2023 05:54:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id qh28so3338473qvb.7;
        Fri, 17 Mar 2023 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679057691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zMBAE4pq1Ef3AkTHVavFAi9picZzZQoMWV5WLBVAX8=;
        b=RKosEANw26NYnguJtkZEMsQt/Lke9+gAxpVRg/M1+vhatD1J75LV9+M5xRswCFBZpL
         y5cZuNPUg5fX17I9IwTbC9y/3Z0sLw/NUvIVnFi+KbF9y4wjZO9fCLhWK3YUPFf+GpPn
         JUfSC6YxqGnKPNu9l7rxcgXUjkR6a+Lgue9LVku7elNG3ZYgMQpgnUXoQOekijHweSti
         8n4o4TPeS5K+nvwGVaKOZWu+gReGcjkuySfLpn4qYKZu3i4PpPje6tI7qf6IEldWFZ8v
         BaZbi2bsYLQxp5i80pgo6kaQvxO4eTOZ29S/+omhgbxE6f+wt95rfH399aLP4OHV2AAx
         FWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zMBAE4pq1Ef3AkTHVavFAi9picZzZQoMWV5WLBVAX8=;
        b=3Tq7cDtSLPKJOBY6bAayz0Bea5uV5UCSCUhR4ocjG3ZbYAAiVSfzDkVLXFLzJGsQ1a
         z6S4PvQED1mgA4CAmJCrmTsoB/01mCFCM5HM2uUls2X0Ioz0i4mQ9vEh5kRJWNxoBN1g
         B6sAQIpJ7TPB3BI32I+ye+9qORwbfiWa1TwLWLjzori0KvkmIfHGw4BR9xfDp9e1aFYA
         y5zHPbsrWC1ZBmzU6EaRcVQosW7IHEbDDpz9axvZJ1M4dkjYTnU3H0CJhlFN1W4Ygj+i
         kbbopFPgIQmjAcZD8iCy1UVt7BOGkJq3ECP1H6Pwfsqe2mygt1OmTYSGeEAzA41OXjtT
         /Slw==
X-Gm-Message-State: AO0yUKXObY4KICo7vZFnZbrGRcKtxMUbYn2XkZg5M2Q0nEjElDcwKaee
        kkaEejGg8r5fwK5ytxu+EyqDeMSsj0NWmGhPETE=
X-Google-Smtp-Source: AK7set/c7NHqemWXNIckmpW5HoBd4CU/t+gILrDxZCI1x3uyoNUZRlGutN6LGCuHsI+/gRG2R71cM9Qb8YRpGmTZNhg=
X-Received: by 2002:ad4:5505:0:b0:56f:6925:eb2c with SMTP id
 pz5-20020ad45505000000b0056f6925eb2cmr4871942qvb.10.1679057691386; Fri, 17
 Mar 2023 05:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-2-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-2-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 14:54:15 +0200
Message-ID: <CAHp75VfnNOsfcyLM-UP61CMAF9sLOwMbRkAe5Ljhs2p8F=4Pgw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Wed, Mar 15, 2023 at 11:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a use=
r
> to manipulate certain GPIO pins via libgpiod tools or other kernel driver=
s.
> The usables pins are defined via the "gpio-reserved-ranges" property.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/gpio/Kconfig       |  13 ++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-mlxbf3.c | 248 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf3.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index ec7cfd4f52b1..beec1f6c34ff 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1534,6 +1534,19 @@ config GPIO_MLXBF2
>         help
>           Say Y here if you want GPIO support on Mellanox BlueField 2 SoC=
.
>
> +config GPIO_MLXBF3
> +       tristate "Mellanox BlueField 3 SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y if you want GPIO support on Mellanox BlueField 3 SoC.
> +         This GPIO controller supports interrupt handling and enables th=
e
> +         manipulation of certain GPIO pins.
> +         This controller should be used in parallel with pinctrl-mlxbf3 =
to
> +         control the desired GPIOs.
> +         This driver can also be built as a module called mlxbf3-gpio.
> +
>  config GPIO_ML_IOH
>         tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
>         depends on X86 || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 010587025fc8..76545ca31457 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_GPIO_MERRIFIELD)               +=3D gpio=
-merrifield.o
>  obj-$(CONFIG_GPIO_ML_IOH)              +=3D gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MLXBF)               +=3D gpio-mlxbf.o
>  obj-$(CONFIG_GPIO_MLXBF2)              +=3D gpio-mlxbf2.o
> +obj-$(CONFIG_GPIO_MLXBF3)              +=3D gpio-mlxbf3.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)           +=3D gpio-mm-lantiq.o
>  obj-$(CONFIG_GPIO_MOCKUP)              +=3D gpio-mockup.o
>  obj-$(CONFIG_GPIO_MOXTET)              +=3D gpio-moxtet.o
> diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
> new file mode 100644
> index 000000000000..e30cee108986
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf3.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +/*
> + * There are 2 YU GPIO blocks:
> + * gpio[0]: HOST_GPIO0->HOST_GPIO31
> + * gpio[1]: HOST_GPIO32->HOST_GPIO55
> + */
> +#define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
> +
> +/*
> + * fw_gpio[x] block registers and their offset
> + */
> +#define MLXBF_GPIO_FW_OUTPUT_ENABLE_SET          0x00
> +#define MLXBF_GPIO_FW_DATA_OUT_SET        0x04
> +
> +#define MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR 0x00
> +#define MLXBF_GPIO_FW_DATA_OUT_CLEAR      0x04
> +
> +#define MLXBF_GPIO_CAUSE_RISE_EN          0x00
> +#define MLXBF_GPIO_CAUSE_FALL_EN          0x04
> +#define MLXBF_GPIO_READ_DATA_IN           0x08
> +
> +#define MLXBF_GPIO_CAUSE_OR_CAUSE_EVTEN0  0x00
> +#define MLXBF_GPIO_CAUSE_OR_EVTEN0        0x14
> +#define MLXBF_GPIO_CAUSE_OR_CLRCAUSE      0x18
> +
> +struct mlxbf3_gpio_context {
> +       struct gpio_chip gc;
> +
> +       /* YU GPIO block address */
> +       void __iomem *gpio_set_io;
> +       void __iomem *gpio_clr_io;
> +       void __iomem *gpio_io;
> +
> +       /* YU GPIO cause block address */
> +       void __iomem *gpio_cause_io;
> +};
> +
> +static void mlxbf3_gpio_irq_enable(struct irq_data *irqd)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
> +       struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
> +       irq_hw_number_t offset =3D irqd_to_hwirq(irqd);
> +       unsigned long flags;
> +       u32 val;
> +
> +       gpiochip_enable_irq(gc, offset);
> +
> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +       writel(BIT(offset), gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CLRCA=
USE);
> +
> +       val =3D readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       val |=3D BIT(offset);
> +       writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +}
> +
> +static void mlxbf3_gpio_irq_disable(struct irq_data *irqd)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
> +       struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
> +       irq_hw_number_t offset =3D irqd_to_hwirq(irqd);
> +       unsigned long flags;
> +       u32 val;
> +
> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +       val =3D readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       val &=3D ~BIT(offset);
> +       writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +
> +       gpiochip_disable_irq(gc, offset);
> +}
> +
> +static irqreturn_t mlxbf3_gpio_irq_handler(int irq, void *ptr)
> +{
> +       struct mlxbf3_gpio_context *gs =3D ptr;
> +       struct gpio_chip *gc =3D &gs->gc;
> +       unsigned long pending;
> +       u32 level;
> +
> +       pending =3D readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CAUSE_E=
VTEN0);
> +       writel(pending, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CLRCAUSE)=
;
> +
> +       for_each_set_bit(level, &pending, gc->ngpio)
> +               generic_handle_domain_irq(gc->irq.domain, level);
> +
> +       return IRQ_RETVAL(pending);
> +}
> +
> +static int
> +mlxbf3_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
> +       struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
> +       irq_hw_number_t offset =3D irqd_to_hwirq(irqd);
> +       unsigned long flags;
> +       u32 val;
> +
> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +               val =3D readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val |=3D BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val =3D readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               val |=3D BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               val =3D readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               val |=3D BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               val =3D readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val |=3D BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               break;
> +       default:
> +               raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +               return -EINVAL;
> +       }
> +
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +
> +       irq_set_handler_locked(irqd, handle_edge_irq);
> +
> +       return 0;
> +}
> +
> +/* This function needs to be defined for handle_edge_irq() */
> +static void mlxbf3_gpio_irq_ack(struct irq_data *data)
> +{
> +}
> +
> +static const struct irq_chip gpio_mlxbf3_irqchip =3D {
> +       .name =3D "MLNXBF33",
> +       .irq_ack =3D mlxbf3_gpio_irq_ack,
> +       .irq_set_type =3D mlxbf3_gpio_irq_set_type,
> +       .irq_enable =3D mlxbf3_gpio_irq_enable,
> +       .irq_disable =3D mlxbf3_gpio_irq_disable,
> +       .flags =3D IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static int mlxbf3_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mlxbf3_gpio_context *gs;
> +       struct gpio_irq_chip *girq;
> +       struct gpio_chip *gc;
> +       int ret, irq;
> +
> +       gs =3D devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
> +       if (!gs)
> +               return -ENOMEM;
> +
> +       gs->gpio_io =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(gs->gpio_io))
> +               return PTR_ERR(gs->gpio_io);
> +
> +       gs->gpio_cause_io =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(gs->gpio_cause_io))
> +               return PTR_ERR(gs->gpio_cause_io);
> +
> +       gs->gpio_set_io =3D devm_platform_ioremap_resource(pdev, 2);
> +       if (IS_ERR(gs->gpio_set_io))
> +               return PTR_ERR(gs->gpio_set_io);
> +
> +       gs->gpio_clr_io =3D devm_platform_ioremap_resource(pdev, 3);
> +       if (IS_ERR(gs->gpio_clr_io))
> +               return PTR_ERR(gs->gpio_clr_io);
> +       gc =3D &gs->gc;
> +
> +       ret =3D bgpio_init(gc, dev, 4,
> +                       gs->gpio_io + MLXBF_GPIO_READ_DATA_IN,
> +                       gs->gpio_set_io + MLXBF_GPIO_FW_DATA_OUT_SET,
> +                       gs->gpio_clr_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
> +                       gs->gpio_set_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET=
,
> +                       gs->gpio_clr_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLE=
AR, 0);
> +
> +       gc->request =3D gpiochip_generic_request;
> +       gc->free =3D gpiochip_generic_free;
> +       gc->owner =3D THIS_MODULE;
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq >=3D 0) {
> +               girq =3D &gs->gc.irq;
> +               gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
> +               girq->default_type =3D IRQ_TYPE_NONE;
> +               /* This will let us handle the parent IRQ in the driver *=
/
> +               girq->num_parents =3D 0;
> +               girq->parents =3D NULL;
> +               girq->parent_handler =3D NULL;
> +               girq->handler =3D handle_bad_irq;
> +
> +               /*
> +                * Directly request the irq here instead of passing
> +                * a flow-handler because the irq is shared.
> +                */
> +               ret =3D devm_request_irq(dev, irq, mlxbf3_gpio_irq_handle=
r,
> +                                      IRQF_SHARED, dev_name(dev), gs);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "failed to request=
 IRQ");
> +       }
> +
> +       platform_set_drvdata(pdev, gs);
> +
> +       ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
> +       if (ret)
> +               dev_err_probe(dev, ret, "Failed adding memory mapped gpio=
chip\n");
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id mlxbf3_gpio_acpi_match[] =3D {
> +       { "MLNXBF33", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf3_gpio_acpi_match);
> +
> +static struct platform_driver mlxbf3_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "mlxbf3_gpio",
> +               .acpi_match_table =3D mlxbf3_gpio_acpi_match,
> +       },
> +       .probe    =3D mlxbf3_gpio_probe,
> +};
> +module_platform_driver(mlxbf3_gpio_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
> +MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.30.1
>


--=20
With Best Regards,
Andy Shevchenko
