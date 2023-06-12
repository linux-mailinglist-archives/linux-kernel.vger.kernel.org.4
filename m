Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34172B6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjFLEiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjFLEhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B871997;
        Sun, 11 Jun 2023 21:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B7B61E39;
        Mon, 12 Jun 2023 04:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BCC4339E;
        Mon, 12 Jun 2023 04:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686544610;
        bh=RTLH6/qX0boVL/Mo3La5Q/cG0oTORPisOYKQg5/Tgak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AH8baJ68PHUJ1MJM3ToL7WT4K40ccvvbUHmyENAJBbwbtdCahBW5ycoWTj4WNu1Ka
         yTCqSqfd/lMGJqdgf5ARaK+wMXpox88Muir6fsy9YctM0mf59j5hBTd7mHC5tmdyMo
         LbDDxQdXF+4+KOX/LSBf/KrKzs4GnKxG4JNXjtpcoVB+zC6s5Yrk6Tvt8+Lcxs8W1Z
         wyZc0OPVuVPhJiVdCgDDHc7jIkvlxBVEF1hERvgDYTpHeuBSA4RAsqlzArfZtb0Tze
         Nf0gk8xmyjbyfmvqjJwK5+NmqbNtJE0hIE/OuILO6xQ6ih6V9eQj8FPoRqvoWfpSJs
         ktaQlLgbxgjjg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977c72b116fso586201566b.3;
        Sun, 11 Jun 2023 21:36:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDxrd6/65f+qWGZNRKn0ux54C+Y5J7xMTjuoUc2Gs3oWiwDOeXGs
        JX5rap1komeUaiAzf09ljSsGOyRini3zZQQyTK8=
X-Google-Smtp-Source: ACHHUZ7NIM2FiIJ2XP3QFmg0qUphmz2JgVSW6L6Dnb/GYYjr73vQ142pX930uqkPDVTjnBtZSfXUI8GWyOr1xeCkTYA=
X-Received: by 2002:a17:907:36ca:b0:978:6b18:e935 with SMTP id
 bj10-20020a17090736ca00b009786b18e935mr7379206ejc.23.1686544608138; Sun, 11
 Jun 2023 21:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230522093320.7176-1-zhuyinbo@loongson.cn>
In-Reply-To: <20230522093320.7176-1-zhuyinbo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 12 Jun 2023 12:36:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wF28E5k+uHvPP1xErr=v=icTSMWdygfd4pYdwiBk=LA@mail.gmail.com>
Message-ID: <CAAhV-H5wF28E5k+uHvPP1xErr=v=icTSMWdygfd4pYdwiBk=LA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] soc: loongson2_pm: add power management support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

On Mon, May 22, 2023 at 5:33=E2=80=AFPM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> The Loongson-2's Power Management Controller was ACPI, supports ACPI
> S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> (USB, GMAC, PWRBTN, etc.). This driver was to add Power Management
> Controller support that base on dts for Loongson-2 series SoCs.
>
> Signed-off-by: Liu Yun <liuyun@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/soc/loongson/Kconfig        |  10 ++
>  drivers/soc/loongson/Makefile       |   1 +
>  drivers/soc/loongson/loongson2_pm.c | 235 ++++++++++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 drivers/soc/loongson/loongson2_pm.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bcd05f1fa5c1..7c4ad0cbaeff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12195,6 +12195,7 @@ M:      Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:     linux-pm@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.=
yaml
> +F:     drivers/soc/loongson/loongson2_pm.c
>
>  LOONGSON-2 SOC SERIES PINCTRL DRIVER
>  M:     zhanghongchen <zhanghongchen@loongson.cn>
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 707f56358dc4..2431a0bcbd84 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -16,3 +16,13 @@ config LOONGSON2_GUTS
>          SoCs. Initially only reading SVR and registering soc device are
>          supported. Other guts accesses, such as reading firmware configu=
ration
>          by default, should eventually be added into this driver as well.
> +
> +config LOONGSON2_PM
> +       bool "Loongson-2 SoC Power Management Controller Driver"
> +       depends on LOONGARCH && OF
> +       help
> +        The Loongson-2's Power Management Controller was ACPI, supports =
ACPI
> +        S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Sus=
pend To
> +        Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up met=
hods
> +        (USB, GMAC, PWRBTN, etc.). This driver was to add Power Manageme=
nt
> +        Controller support that base on dts for Loongson-2 series SoCs.
> diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefil=
e
> index 263c486df638..4118f50f55e2 100644
> --- a/drivers/soc/loongson/Makefile
> +++ b/drivers/soc/loongson/Makefile
> @@ -4,3 +4,4 @@
>  #
>
>  obj-$(CONFIG_LOONGSON2_GUTS)           +=3D loongson2_guts.o
> +obj-$(CONFIG_LOONGSON2_PM)             +=3D loongson2_pm.o
> diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/l=
oongson2_pm.c
> new file mode 100644
> index 000000000000..cd96a1ebbb6c
> --- /dev/null
> +++ b/drivers/soc/loongson/loongson2_pm.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Loongson-2 PM Support
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/suspend.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/platform_device.h>
> +#include <asm/bootinfo.h>
> +#include <asm/suspend.h>
> +
> +#define LOONGSON2_PM1_CNT_REG          0x14
> +#define LOONGSON2_PM1_STS_REG          0x0c
> +#define LOONGSON2_PM1_ENA_REG          0x10
> +#define LOONGSON2_GPE0_STS_REG         0x28
> +#define LOONGSON2_GPE0_ENA_REG         0x2c
> +
> +#define LOONGSON2_PM1_PWRBTN_STS       BIT(8)
> +#define LOONGSON2_PM1_PCIEXP_WAKE_STS  BIT(14)
> +#define LOONGSON2_PM1_WAKE_STS         BIT(15)
> +#define LOONGSON2_PM1_CNT_INT_EN       BIT(0)
> +#define LOONGSON2_PM1_PWRBTN_EN                LOONGSON2_PM1_PWRBTN_STS
> +
> +static struct loongson2_pm {
> +       void __iomem                    *base;
> +       struct input_dev                *dev;
> +       bool                            suspended;
> +} loongson2_pm;
> +
> +#define loongson2_pm_readw(reg)                readw(loongson2_pm.base +=
 reg)
> +#define loongson2_pm_readl(reg)                readl(loongson2_pm.base +=
 reg)
> +#define loongson2_pm_writew(val, reg)  writew(val, loongson2_pm.base + r=
eg)
> +#define loongson2_pm_writel(val, reg)  writel(val, loongson2_pm.base + r=
eg)
> +
> +static void loongson2_pm_status_clear(void)
> +{
> +       u16 value;
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> +       value |=3D (LOONGSON2_PM1_PWRBTN_STS | LOONGSON2_PM1_PCIEXP_WAKE_=
STS |
> +                 LOONGSON2_PM1_WAKE_STS);
> +       loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
> +       loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG),
> +                           LOONGSON2_GPE0_STS_REG);
> +}
> +
> +static void loongson2_pm_irq_enable(void)
> +{
> +       u16 value;
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_CNT_REG);
> +       value |=3D LOONGSON2_PM1_CNT_INT_EN;
> +       loongson2_pm_writew(value, LOONGSON2_PM1_CNT_REG);
> +}
> +
> +static void loongson2_pm_pwrbtn_irq_enable(void)
> +{
> +       u16 value;
> +
> +       loongson2_pm_irq_enable();
> +
> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_ENA_REG);
> +       value |=3D LOONGSON2_PM1_PWRBTN_EN;
> +       loongson2_pm_writew(value, LOONGSON2_PM1_ENA_REG);
> +}
You can combine these two functions as loongson2_power_button_irq_enable().

> +
> +static void loongson2_pm_mach_resume(void)
> +{
> +       loongson_common_resume();
> +       loongson2_pm_irq_enable();
> +}
> +
> +static void loongson2_pm_mach_suspend(void)
> +{
> +       loongson2_pm_status_clear();
> +       loongson_common_suspend();
> +}
> +
> +static int loongson2_suspend_enter(suspend_state_t state)
> +{
> +       loongson2_pm_mach_suspend();
> +       loongson_suspend_enter();
> +       pm_set_resume_via_firmware();
> +       loongson2_pm_mach_resume();
> +
> +       return 0;
> +}
After some thinkings, I found these three simple function can be combined a=
s:
static int loongson2_suspend_enter(suspend_state_t state)
{
       loongson2_pm_status_clear();
       loongson_common_suspend();
       loongson_suspend_enter();
       loongson_common_resume();
       loongson2_pm_irq_enable();
       pm_set_resume_via_firmware();

       return 0;
}

After this combining,
loongson_common_suspend()/loongson_suspend_enter()/loongson_common_resume()
can be still use the old naming
loongarch_common_suspend()/loongarch_suspend_enter()/loongarch_common_resum=
e().

> +
> +static int loongson2_suspend_begin(suspend_state_t state)
> +{
> +       pm_set_suspend_via_firmware();
> +
> +       return 0;
> +}
> +
> +static int loongson2_suspend_valid_state(suspend_state_t state)
> +{
> +       if (state =3D=3D PM_SUSPEND_MEM)
> +               return !!loongson_sysconf.suspend_addr;
> +
> +       return 0;
> +}
> +
> +static const struct platform_suspend_ops loongson2_suspend_ops =3D {
> +       .valid  =3D loongson2_suspend_valid_state,
> +       .begin  =3D loongson2_suspend_begin,
> +       .enter  =3D loongson2_suspend_enter,
> +};
> +
> +static int loongson2_pm_pwrbtn_init(struct device *dev, int irq)
> +{
> +       int ret;
> +       struct input_dev *pwrbt;
Rename  loongson2_pm_pwrbtn_init() to  loongson2_power_button_init()
and rename 'pwrbt' to 'pwrbtn' or just 'button' is better.

Huacai
> +
> +       pwrbt =3D input_allocate_device();
> +       if (!dev)
> +               return -ENOMEM;
> +
> +       pwrbt->name =3D "Power Button";
> +       pwrbt->phys =3D "pm/button/input0";
> +       pwrbt->id.bustype =3D BUS_HOST;
> +       pwrbt->dev.parent =3D NULL;
> +       input_set_capability(pwrbt, EV_KEY, KEY_POWER);
> +
> +       ret =3D input_register_device(pwrbt);
> +       if (ret)
> +               goto free_dev;
> +
> +       dev_pm_set_wake_irq(&pwrbt->dev, irq);
> +       device_set_wakeup_capable(&pwrbt->dev, true);
> +       device_set_wakeup_enable(&pwrbt->dev, true);
> +
> +       loongson2_pm.dev =3D pwrbt;
> +       dev_info(dev, "Power Button: Init successful!\n");
> +
> +       return 0;
> +
> +free_dev:
> +       input_free_device(pwrbt);
> +
> +       return ret;
> +}
> +
> +static irqreturn_t loongson2_pm_irq_handler(int irq, void *dev_id)
> +{
> +       u16 status =3D loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> +
> +       if (!loongson2_pm.suspended && (status & LOONGSON2_PM1_PWRBTN_STS=
)) {
> +               pr_info("Power Button pressed...\n");
> +               input_report_key(loongson2_pm.dev, KEY_POWER, 1);
> +               input_sync(loongson2_pm.dev);
> +               input_report_key(loongson2_pm.dev, KEY_POWER, 0);
> +               input_sync(loongson2_pm.dev);
> +       }
> +
> +       loongson2_pm_status_clear();
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int __maybe_unused loongson2_pm_suspend(struct device *dev)
> +{
> +       loongson2_pm.suspended =3D true;
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused loongson2_pm_resume(struct device *dev)
> +{
> +       loongson2_pm.suspended =3D false;
> +
> +       return 0;
> +}
> +static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend, loongso=
n2_pm_resume);
> +
> +static int loongson2_pm_probe(struct platform_device *pdev)
> +{
> +       int irq, retval;
> +       u32 suspend_addr;
> +       struct device *dev =3D &pdev->dev;
> +
> +       loongson2_pm.base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(loongson2_pm.base))
> +               return PTR_ERR(loongson2_pm.base);
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       if (!device_property_read_u32(dev, "suspend-address", &suspend_ad=
dr))
> +               loongson_sysconf.suspend_addr =3D (u64)phys_to_virt(suspe=
nd_addr);
> +       else
> +               dev_err(dev, "No suspend-address, could not support S3!\n=
");
> +
> +       if (loongson2_pm_pwrbtn_init(dev, irq))
> +               return -EINVAL;
> +
> +       retval =3D devm_request_irq(&pdev->dev, irq, loongson2_pm_irq_han=
dler,
> +                                 IRQF_SHARED, "pm_irq", &loongson2_pm);
> +       if (retval)
> +               return retval;
> +
> +       loongson2_pm_pwrbtn_irq_enable();
> +       loongson2_pm_status_clear();
> +
> +       if (loongson_sysconf.suspend_addr)
> +               suspend_set_ops(&loongson2_suspend_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id loongson2_pm_match[] =3D {
> +       { .compatible =3D "loongson,ls2k-pmc", },
> +       {},
> +};
> +
> +static struct platform_driver loongson2_pm_driver =3D {
> +       .driver =3D {
> +               .name =3D "ls2k-pm",
> +               .pm =3D &loongson2_pm_ops,
> +               .of_match_table =3D loongson2_pm_match,
> +       },
> +       .probe =3D loongson2_pm_probe,
> +};
> +module_platform_driver(loongson2_pm_driver);
> +
> +MODULE_DESCRIPTION("Loongson-2 PM driver");
> +MODULE_LICENSE("GPL");
> --
> 2.20.1
>
>
