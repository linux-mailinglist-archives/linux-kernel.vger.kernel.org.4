Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C483C6A56E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjB1KhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjB1KhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:37:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DC29153
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:37:13 -0800 (PST)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 424C63F72C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677580630;
        bh=9HF5+K9vFZgMFpQ6jYuapY7JsvhE7JNQpSgJ9usIl4k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZjjDNe/8cXPZ17tkTfU8cgDy41pgMjt4gUJ3wLSLvRdhXYdE2lVdmmCWYGpmhyoNc
         M06Q0wQflETSbklLRmIfJSLXkjWrVP58kA70rpdo54YvIgVf5YIxeLOHA8JYotcn2t
         TMns/HztHgNfoWhPOZi5ShAsBldGex/b40+6EZ/AzfLN6IrELGtkF0s76wmoMhx43P
         SEqwCLAI8LQrZxUJwPk99XW9YJWElMNAgSQ2Ohqp8oqq7OVK/0FM8GwMfGMpOniXFc
         rFMdUvWICOk7LTnxpED7RKgbG+gYFWpprih7jseY65OhKFbEOlqre60UGw2qYLORUB
         TwJJvVpYJjP4Q==
Received: by mail-qk1-f197.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so5727612qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HF5+K9vFZgMFpQ6jYuapY7JsvhE7JNQpSgJ9usIl4k=;
        b=15gGnrQGoAvs92WYBZqjk8WMBrXtEYLUI0itqwIudg+/kZq4C5UMmC5/hcXga0Asi3
         bE804W6zy2FD13Y8KtQ8GLF0dPRDAX+XWNzIPk/f5ur+HACm7BDwvLFdXfBEuFwdZXMX
         0yur5je3KWrR6KuaiQUg4i63BEU/Sx0z8FywdypLEgCWUS8gV5+f4ZPujhBQ7sPpOUkR
         CZCOe06ScBxM5N08AUNKVWrfPmSFPw1e7q+PjpsgS3+Wh8P3Z/s9XXfYhPuqkM2YY96r
         yQvx5az9t8qUYX0p75whJFS0o3lM6uq84Bvafp7H8bOXkEgFVmZIdLQShSy2L+46oYTa
         CsVg==
X-Gm-Message-State: AO0yUKXEcDbfto3FVmfkOy7BbTWOGkS6h+b0tLNVDXAuGahX2iben0s8
        VLMdfwjn/BZ46NDVpPR03GKhClQSnc4rlYkBkcJzwzy3ef3Q6eHI/n8kQGEG+k1DDatI/k6C96E
        zt920pdMnxHQXv7V0FNQ8xscXO9cmmVZvuIeeEfzzf4uFIFKXDwjpz6Cxpg==
X-Received: by 2002:ac8:208a:0:b0:3bf:ba7f:58f8 with SMTP id 10-20020ac8208a000000b003bfba7f58f8mr681817qtd.3.1677580627480;
        Tue, 28 Feb 2023 02:37:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9mqM5WRLNX1NY2pNrA6eE8iejpYHjU9wA2SeLLktkohlRSE8wtVHwIsS/ozgy6gOWiNwByi742RqqaaEnHDI4=
X-Received: by 2002:ac8:208a:0:b0:3bf:ba7f:58f8 with SMTP id
 10-20020ac8208a000000b003bfba7f58f8mr681813qtd.3.1677580627044; Tue, 28 Feb
 2023 02:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com> <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
In-Reply-To: <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 28 Feb 2023 11:36:49 +0100
Message-ID: <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> On 2023/2/26 22:14, Emil Renner Berthing wrote:
> > On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>
> >> Add watchdog driver for the StarFive JH7110 SoC.
> >>
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> ---
> >>  MAINTAINERS                     |   7 +
> >>  drivers/watchdog/Kconfig        |   9 +
> >>  drivers/watchdog/Makefile       |   2 +
> >>  drivers/watchdog/starfive-wdt.c | 651 ++++++++++++++++++++++++++++++++
> >>  4 files changed, 669 insertions(+)
> >>  create mode 100644 drivers/watchdog/starfive-wdt.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 135d93368d36..6cbcf08fa76a 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19933,6 +19933,13 @@ F:     Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> >>  F:     drivers/reset/reset-starfive-jh7100.c
> >>  F:     include/dt-bindings/reset/starfive-jh7100.h
> >>
> >> +STARFIVE JH7110 WATCHDOG DRIVER
> >> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
> >> +M:     Samin Guo <samin.guo@starfivetech.com>
> >> +S:     Supported
> >> +F:     Documentation/devicetree/bindings/watchdog/starfive*
> >> +F:     drivers/watchdog/starfive-wdt.c
> >> +
> >>  STATIC BRANCH/CALL
> >>  M:     Peter Zijlstra <peterz@infradead.org>
> >>  M:     Josh Poimboeuf <jpoimboe@kernel.org>
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index 0bc40b763b06..4608eb5c9501 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -2089,6 +2089,15 @@ config UML_WATCHDOG
> >>         tristate "UML watchdog"
> >>         depends on UML || COMPILE_TEST
> >>
> >> +config STARFIVE_WATCHDOG
> >> +       tristate "StarFive Watchdog support"
> >> +       depends on RISCV
> >
> > Let's do like the pinctrl and clock drivers and
> >
> >     depends SOC_STARFIVE || COMPILE_TEST
> >
>
> Yes, will use 'ARCH_STARFIVE' instead.
>
> >> +       select WATCHDOG_CORE
> >> +       default SOC_STARFIVE
> >> +       help
> >> +         Say Y here to support the watchdog of StarFive JH7110 SoC.
> >> +         This driver can also be built as a module if choose M.
> >> +
> >>  #
> >>  # ISA-based Watchdog Cards
> >>  #
> >> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >> index 9cbf6580f16c..4c0bd377e92a 100644
> >> --- a/drivers/watchdog/Makefile
> >> +++ b/drivers/watchdog/Makefile
> >> @@ -211,6 +211,8 @@ obj-$(CONFIG_WATCHDOG_SUN4V)                += sun4v_wdt.o
> >>  # Xen
> >>  obj-$(CONFIG_XEN_WDT) += xen_wdt.o
> >>
> >> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> >> +
> >>  # Architecture Independent
> >>  obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
> >>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> >> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> >> new file mode 100644
> >> index 000000000000..dfbb80406076
> >> --- /dev/null
> >> +++ b/drivers/watchdog/starfive-wdt.c
> >> @@ -0,0 +1,651 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Starfive Watchdog driver
> >> + *
> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/iopoll.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/watchdog.h>
> >> +
> >> +/* JH7110 WatchDog register define */
> >> +#define STARFIVE_WDT_JH7110_LOAD       0x000   /* RW: Watchdog load register */
> >> +#define STARFIVE_WDT_JH7110_VALUE      0x004   /* RO: The current value for the watchdog counter */
> >> +#define STARFIVE_WDT_JH7110_CONTROL    0x008   /*
> >> +                                                * RW:
> >> +                                                * [0]: reset enable;
> >> +                                                * [1]: int enable/wdt enable/reload counter;
> >> +                                                * [31:2]: reserve.
> >> +                                                */
> >> +#define STARFIVE_WDT_JH7110_INTCLR     0x00c   /* WO: clear intterupt && reload the counter */
> >> +#define STARFIVE_WDT_JH7110_RIS                0x010   /* RO: Raw interrupt status from the counter */
> >> +#define STARFIVE_WDT_JH7110_IMS                0x014   /* RO: Enabled interrupt status from the counter */
> >> +#define STARFIVE_WDT_JH7110_LOCK       0xc00   /*
> >> +                                                * RO: Enable write access to all other registers
> >> +                                                * by writing 0x1ACCE551.
> >> +                                                */
> >
> > This driver is clearly prepared to support multiple SoCs, so hopefully
> > you've tested that internally. It would be great if you could leave in
> > the support for the JH7100 in the next revision. This would also make
> > all the indirection make a lot more sense.
>
> The JH7100 watchdog is little different from the 7110 and this driver only
> needs to change and add some control register layout and mask to support the 7100.
> And the JH8100 watchdog is the same as the 7110 but the 8100 is still in the plan.

Great. Yes, that's why I suggested you leave in support for the
JH7100, since very basic support for that is already merged and this
driver doesn't depend on the non-coherent dma support that is missing.

> So the dt-bingdings need to rename, and which one could be better,
> 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?

Sure, starfive,jh71x0-wdt.yaml sounds good to me.

> >> +/* WDOGCONTROL */
> >> +#define STARFIVE_WDT_ENABLE                    0x1
> >> +#define STARFIVE_WDT_JH7110_EN_SHIFT           0
> >> +#define STARFIVE_WDT_RESET_EN                  0x1
> >> +#define STARFIVE_WDT_JH7110_RESEN_SHIFT                1
> >> +
> >> +/* WDOGLOCK */
> >> +#define STARFIVE_WDT_LOCKED                    BIT(0)
> >> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY         0x1acce551
> >> +
> >> +/* WDOGINTCLR */
> >> +#define STARFIVE_WDT_INTCLR                    0x1
> >> +
> >> +#define STARFIVE_WDT_MAXCNT                    0xffffffff
> >> +#define STARFIVE_WDT_DEFAULT_TIME              (15)
> >> +#define STARFIVE_WDT_DELAY_US                  0
> >> +#define STARFIVE_WDT_TIMEOUT_US                        10000
> >> +
> >> +/* module parameter */
> >> +#define STARFIVE_WDT_EARLY_ENA                 0
> >> +
> >> +static bool nowayout = WATCHDOG_NOWAYOUT;
> >> +static int heartbeat;
> >> +static int early_enable = STARFIVE_WDT_EARLY_ENA;
> >> +
> >> +module_param(heartbeat, int, 0);
> >> +module_param(early_enable, int, 0);
> >
> > This also looks like a bool parameter.
>
> Oh will modify it.
>
> >
> >> +module_param(nowayout, bool, 0);
> >> +
> >> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
> >> +                __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");
> >> +MODULE_PARM_DESC(early_enable,
> >> +                "Watchdog is started at boot time if set to 1, default="
> >> +                __MODULE_STRING(STARFIVE_WDT_EARLY_ENA));
> >> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> >> +                __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> >> +
> >> +struct starfive_wdt_variant {
> >> +       u32 control;
> >> +       u32 load;
> >> +       u32 enable;
> >> +       u32 value;
> >> +       u32 int_clr;
> >> +       u32 unlock;
> >
> > These are register offsets and not the values of registers, so could
> > be just unsigned int.
>
> Will modify it.

Great. Now that I look at it again the shifts below are also not
values written to a register, so could also be unsigned char.

> >
> >> +       u32 unlock_key;
> >> +       u32 irq_is_raise;
> >> +       u8 enrst_shift;
> >> +       u8 en_shift;
> >> +};
> >> +
> >> +struct starfive_wdt {
> >> +       unsigned long freq;
> >> +       struct device *dev;
> >> +       struct watchdog_device wdt_device;
> >> +       struct clk *core_clk;
> >> +       struct clk *apb_clk;
> >> +       struct reset_control *rsts;
> >> +       const struct starfive_wdt_variant *drv_data;
> >> +       u32 count;      /*count of timeout*/
> >> +       u32 reload;     /*restore the count*/
> >> +       void __iomem *base;
> >> +       spinlock_t lock;        /* spinlock for register handling */
> >> +};
> >> +
> >> +/* Register bias in JH7110 */
> >
> > bias? Maybe "register layout for the JH7110".
>
> Will use 'register layout' instead.
>
> >
> >> +static const struct starfive_wdt_variant drv_data_jh7110 = {
> >> +       .control = STARFIVE_WDT_JH7110_CONTROL,
> >> +       .load = STARFIVE_WDT_JH7110_LOAD,
> >> +       .enable = STARFIVE_WDT_JH7110_CONTROL,
> >> +       .value = STARFIVE_WDT_JH7110_VALUE,
> >> +       .int_clr = STARFIVE_WDT_JH7110_INTCLR,
> >> +       .unlock = STARFIVE_WDT_JH7110_LOCK,
> >> +       .unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
> >> +       .irq_is_raise = STARFIVE_WDT_JH7110_IMS,
> >> +       .enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
> >> +       .en_shift = STARFIVE_WDT_JH7110_EN_SHIFT,
> >> +};
> >> +
> >> +static const struct of_device_id starfive_wdt_match[] = {
> >> +       { .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
> >> +       {}
> >
> > I like the idiom of ending with { /* sentinel */ } here. Also it is
> > common to place this struct just above the platform_driver struct
> > which is the only user.
>
> Will add it.
>
> >
> >> +};
> >> +MODULE_DEVICE_TABLE(of, starfive_wdt_match);
> >> +
> >> +static const struct platform_device_id starfive_wdt_ids[] = {
> >> +       {
> >> +               .name = "starfive-jh7110-wdt",
> >> +               .driver_data = (unsigned long)&drv_data_jh7110,
> >> +       },
> >> +       {}
> >> +};
> >> +MODULE_DEVICE_TABLE(platform, starfive_wdt_ids);
> >
> > When is this struct used? So far I only know of device tree enabled users.
>
> The struct will be used when CONFIG_OF is disabled
> but I deleted CONFIG_OF by mistake.
> Should I add the CONFIG_OF back or remove this struct?

Yeah, as far as I know neither the JH7110 nor JH7100 boots without
CONFIG_OF, which leaves this struct unused. So please remove it.

> >
> >> +static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
> >> +{
> >> +       wdt->freq = clk_get_rate(wdt->core_clk);
> >> +       /* The clock rate should not be 0.*/
> >> +       if (wdt->freq)
> >> +               return 0;
> >> +
> >> +       dev_err(wdt->dev, "get clock rate failed.\n");
> >> +       return -ENOENT;
> >> +}
> >> +
> >> +static int starfive_wdt_get_clock(struct starfive_wdt *wdt)
> >> +{
> >> +       wdt->apb_clk = devm_clk_get(wdt->dev, "apb");
> >> +       if (IS_ERR(wdt->apb_clk)) {
> >> +               dev_err(wdt->dev, "failed to get apb clock.\n");
> >> +               return PTR_ERR(wdt->apb_clk);
> >> +       }
> >> +
> >> +       wdt->core_clk = devm_clk_get(wdt->dev, "core");
> >> +       if (IS_ERR(wdt->core_clk)) {
> >> +               dev_err(wdt->dev, "failed to get core clock.\n");
> >> +               return PTR_ERR(wdt->core_clk);
> >> +       }
> >
> > Here and above you can use dev_err_probe which will also not print
> > errors on -EPROBE_DEFER.
>
> Will modify it.
>
> >
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
> >> +       if (IS_ERR(wdt->rsts)) {
> >> +               dev_err(wdt->dev, "failed to get rsts error.\n");
> >> +               ret = PTR_ERR(wdt->rsts);
> >> +       } else {
> >> +               ret = reset_control_deassert(wdt->rsts);
> >> +               if (ret)
> >> +                       dev_err(wdt->dev, "failed to deassert rsts.\n");
> >> +       }
> >> +       return ret;
> >> +}
> >
> > How about something like
> > int ret;
> >
> > wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
> > if (IS_ERR(wdt->rsts))
> >     return dev_err_probe(wdt->dev, PTR_ERR(wdt->rsts), "failed to get
> > resets\n");
> >
> > ret = reset_control_deassert(wdt->rsts);
> > return dev_err_probe(wdt->dev, ret, "failed to deassert resets\n");
>
> It looks more concise. Thanks.
>
> >
> >> +
> >> +static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
> >> +{
> >> +       return DIV_ROUND_CLOSEST(ticks, wdt->freq);
> >> +}
> >> +
> >> +/*
> >> + * Write unlock-key to unlock. Write other value to lock. When lock bit is 1,
> >> + * external accesses to other watchdog registers are ignored.
> >> + */
> >> +static bool starfive_wdt_is_locked(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = readl(wdt->base + wdt->drv_data->unlock);
> >> +       return !!(val & STARFIVE_WDT_LOCKED);
> >> +}
> >> +
> >> +static void starfive_wdt_unlock(struct starfive_wdt *wdt)
> >> +{
> >> +       if (starfive_wdt_is_locked(wdt))
> >> +               writel(wdt->drv_data->unlock_key,
> >> +                      wdt->base + wdt->drv_data->unlock);
> >> +}
> >> +
> >> +static void starfive_wdt_lock(struct starfive_wdt *wdt)
> >> +{
> >> +       if (!starfive_wdt_is_locked(wdt))
> >> +               writel(~wdt->drv_data->unlock_key,
> >> +                      wdt->base + wdt->drv_data->unlock);
> >> +}
> >> +
> >> +/* enable watchdog interrupt to reset/reboot */
> >> +static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = readl(wdt->base + wdt->drv_data->control);
> >> +       val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift;
> >> +       writel(val, wdt->base + wdt->drv_data->control);
> >> +}
> >> +
> >> +/* disable watchdog interrupt to reset/reboot */
> >> +static void starfive_wdt_disable_reset(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = readl(wdt->base + wdt->drv_data->control);
> >> +       val &= ~(STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift);
> >> +       writel(val, wdt->base + wdt->drv_data->control);
> >> +}
> >> +
> >> +/* interrupt status whether has been raised from the counter */
> >> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
> >> +{
> >> +       return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
> >> +}
> >> +
> >> +/* clear interrupt signal before initialization or reload */
> >> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
> >> +{
> >> +       writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
> >> +}
> >> +
> >> +static inline void starfive_wdt_set_count(struct starfive_wdt *wdt, u32 val)
> >> +{
> >> +       writel(val, wdt->base + wdt->drv_data->load);
> >> +}
> >> +
> >> +static inline u32 starfive_wdt_get_count(struct starfive_wdt *wdt)
> >> +{
> >> +       return readl(wdt->base + wdt->drv_data->value);
> >> +}
> >> +
> >> +/* enable watchdog */
> >> +static inline void starfive_wdt_enable(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = readl(wdt->base + wdt->drv_data->enable);
> >> +       val |= STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift;
> >> +       writel(val, wdt->base + wdt->drv_data->enable);
> >> +}
> >> +
> >> +/* disable watchdog */
> >> +static inline void starfive_wdt_disable(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = readl(wdt->base + wdt->drv_data->enable);
> >> +       val &= ~(STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift);
> >> +       writel(val, wdt->base + wdt->drv_data->enable);
> >> +}
> >> +
> >> +static inline void starfive_wdt_set_reload_count(struct starfive_wdt *wdt, u32 count)
> >> +{
> >> +       starfive_wdt_set_count(wdt, count);
> >> +       /* need enable controller to reload counter */
> >> +       starfive_wdt_enable(wdt);
> >> +}
> >> +
> >> +static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
> >> +{
> >> +       return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, (wdt->freq / 2)) - 1;
> >> +}
> >> +
> >> +static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +       u32 count;
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       /*
> >> +        * Because set half count value,
> >> +        * timeleft value should add the count value before first timeout.
> >> +        */
> >> +       count = starfive_wdt_get_count(wdt);
> >> +       if (!starfive_wdt_raise_irq_status(wdt))
> >> +               count += wdt->count;
> >> +
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       return starfive_wdt_ticks_to_sec(wdt, count);
> >> +}
> >> +
> >> +static int starfive_wdt_keepalive(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       starfive_wdt_int_clr(wdt);
> >> +       starfive_wdt_set_reload_count(wdt, wdt->count);
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       spin_unlock(&wdt->lock);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_stop(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       starfive_wdt_disable_reset(wdt);
> >> +       starfive_wdt_int_clr(wdt);
> >> +       starfive_wdt_disable(wdt);
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       spin_unlock(&wdt->lock);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +
> >> +       starfive_wdt_stop(wdd);
> >> +       pm_runtime_put_sync(wdt->dev);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_start(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +       starfive_wdt_unlock(wdt);
> >> +       /* disable watchdog, to be safe */
> >> +       starfive_wdt_disable(wdt);
> >> +
> >> +       starfive_wdt_enable_reset(wdt);
> >> +       starfive_wdt_int_clr(wdt);
> >> +       starfive_wdt_set_count(wdt, wdt->count);
> >> +       starfive_wdt_enable(wdt);
> >> +
> >> +       starfive_wdt_lock(wdt);
> >> +       spin_unlock(&wdt->lock);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_pm_start(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +
> >> +       pm_runtime_get_sync(wdt->dev);
> >> +
> >> +       return starfive_wdt_start(wdd);
> >> +}
> >> +
> >> +static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
> >> +                                   unsigned int timeout)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +       unsigned long freq = wdt->freq;
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +
> >> +       /*
> >> +        * This watchdog takes twice timeouts to reset.
> >> +        * In order to reduce time to reset, should set half count value.
> >> +        */
> >> +       wdt->count = timeout * freq / 2;
> >> +       wdd->timeout = timeout;
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       starfive_wdt_disable(wdt);
> >> +       starfive_wdt_set_reload_count(wdt, wdt->count);
> >> +       starfive_wdt_enable(wdt);
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       spin_unlock(&wdt->lock);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> >> +
> >> +static const struct watchdog_info starfive_wdt_ident = {
> >> +       .options = OPTIONS,
> >> +       .identity = "StarFive Watchdog",
> >> +};
> >> +
> >> +static const struct watchdog_ops starfive_wdt_ops = {
> >> +       .owner = THIS_MODULE,
> >> +       .start = starfive_wdt_pm_start,
> >> +       .stop = starfive_wdt_pm_stop,
> >> +       .ping = starfive_wdt_keepalive,
> >> +       .set_timeout = starfive_wdt_set_timeout,
> >> +       .get_timeleft = starfive_wdt_get_timeleft,
> >> +};
> >> +
> >> +static const struct watchdog_device starfive_wdd = {
> >> +       .info = &starfive_wdt_ident,
> >> +       .ops = &starfive_wdt_ops,
> >> +       .timeout = STARFIVE_WDT_DEFAULT_TIME,
> >> +};
> >> +
> >> +static inline const struct starfive_wdt_variant *
> >> +starfive_wdt_get_drv_data(struct platform_device *pdev)
> >> +{
> >> +       const struct starfive_wdt_variant *variant;
> >> +
> >> +       variant = of_device_get_match_data(&pdev->dev);
> >> +       if (!variant) {
> >> +               /* Device matched by platform_device_id */
> >> +               variant = (struct starfive_wdt_variant *)
> >> +                          platform_get_device_id(pdev)->driver_data;
> >> +       }
> >> +
> >> +       return variant;
> >> +}
> >
> > If this driver is only used through the device tree this whole
> > function can just be a call to of_device_get_match_data()
>
> Well, if remove the platform_device_id struct, just use of_device_get_match_data().
>
> >
> >> +static int starfive_wdt_probe(struct platform_device *pdev)
> >> +{
> >> +       struct device *dev = &pdev->dev;
> >> +       struct starfive_wdt *wdt;
> >> +       int ret;
> >> +
> >> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> >> +       if (!wdt)
> >> +               return -ENOMEM;
> >> +
> >> +       wdt->dev = dev;
> >> +       spin_lock_init(&wdt->lock);
> >> +       wdt->wdt_device = starfive_wdd;
> >> +
> >> +       wdt->drv_data = starfive_wdt_get_drv_data(pdev);
> >> +
> >> +       /* get the memory region for the watchdog timer */
> >> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
> >> +       if (IS_ERR(wdt->base)) {
> >> +               ret = PTR_ERR(wdt->base);
> >> +               return ret;
> >> +       }
> >> +
> >> +       platform_set_drvdata(pdev, wdt);
> >> +       pm_runtime_enable(wdt->dev);
> >> +
> >> +       ret = starfive_wdt_get_clock(wdt);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (pm_runtime_enabled(wdt->dev)) {
> >> +               ret = pm_runtime_get_sync(wdt->dev);
> >> +               if (ret < 0)
> >> +                       return ret;
> >> +       } else {
> >> +               /* runtime PM is disabled but clocks need to be enabled */
> >> +               ret = clk_prepare_enable(wdt->apb_clk);
> >> +               if (ret) {
> >> +                       dev_err(wdt->dev, "failed to enable apb_clk.\n");
> >> +                       return ret;
> >> +               }
> >> +               ret = clk_prepare_enable(wdt->core_clk);
> >> +               if (ret) {
> >> +                       dev_err(wdt->dev, "failed to enable core_clk.\n");
> >> +                       goto err_apb_clk_disable;
> >> +               }
> >> +       }
> >
> > The else part is basically starfive_wdt_runtime_resume(). Maybe just call that.
>
> The starfive_wdt_runtime_resume() is defined under CONFIG_PM and it could not
> be used directly. I should use a new function that enable/disable clock and
> can be used in starfive_wdt_runtime_resume() and here.

Yes, either that or just define that function outside #ifdef CONFIG_PM.

> >> +
> >> +       watchdog_set_drvdata(&wdt->wdt_device, wdt);
> >> +
> >> +       /*
> >> +        * see if we can actually set the requested heartbeat,
> >> +        * and if not, try the default value.
> >> +        */
> >> +       watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
> >> +       if (wdt->wdt_device.timeout == 0 ||
> >> +           wdt->wdt_device.timeout > wdt->wdt_device.max_timeout) {
> >> +               dev_warn(dev, "heartbeat value out of range, default %d used\n",
> >> +                        STARFIVE_WDT_DEFAULT_TIME);
> >> +               wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> >> +       }
> >> +       starfive_wdt_set_timeout(&wdt->wdt_device, wdt->wdt_device.timeout);
> >> +
> >> +       watchdog_set_nowayout(&wdt->wdt_device, nowayout);
> >> +       watchdog_stop_on_reboot(&wdt->wdt_device);
> >> +       watchdog_stop_on_unregister(&wdt->wdt_device);
> >> +
> >> +       wdt->wdt_device.parent = dev;
> >> +
> >> +       ret = watchdog_register_device(&wdt->wdt_device);
> >> +       if (ret)
> >> +               goto err_clk_disable;
> >> +
> >> +       if (early_enable) {
> >> +               starfive_wdt_start(&wdt->wdt_device);
> >> +               set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> >> +       } else {
> >> +               starfive_wdt_stop(&wdt->wdt_device);
> >> +       }
> >> +
> >> +       pm_runtime_put_sync(wdt->dev);
> >> +
> >> +       return 0;
> >> +
> >> +err_clk_disable:
> >> +       clk_disable_unprepare(wdt->core_clk);
> >> +err_apb_clk_disable:
> >> +       clk_disable_unprepare(wdt->apb_clk);
> >> +       pm_runtime_disable(wdt->dev);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int starfive_wdt_remove(struct platform_device *dev)
> >> +{
> >> +       struct starfive_wdt *wdt = platform_get_drvdata(dev);
> >> +
> >> +       starfive_wdt_stop(&wdt->wdt_device);
> >> +       watchdog_unregister_device(&wdt->wdt_device);
> >> +
> >> +       if (pm_runtime_enabled(wdt->dev)) {
> >> +               pm_runtime_disable(wdt->dev);
> >> +       } else {
> >> +               /* disable clock without PM */
> >> +               clk_disable_unprepare(wdt->core_clk);
> >> +               clk_disable_unprepare(wdt->apb_clk);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void starfive_wdt_shutdown(struct platform_device *dev)
> >> +{
> >> +       struct starfive_wdt *wdt = platform_get_drvdata(dev);
> >> +
> >> +       starfive_wdt_pm_stop(&wdt->wdt_device);
> >> +}
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int starfive_wdt_suspend(struct device *dev)
> >> +{
> >> +       int ret;
> >> +       struct starfive_wdt *wdt = dev_get_drvdata(dev);
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +
> >> +       /* Save watchdog state, and turn it off. */
> >> +       wdt->reload = starfive_wdt_get_count(wdt);
> >> +
> >> +       /* Note that WTCNT doesn't need to be saved. */
> >> +       starfive_wdt_stop(&wdt->wdt_device);
> >> +       pm_runtime_force_suspend(dev);
> >> +
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_resume(struct device *dev)
> >> +{
> >> +       int ret;
> >> +       struct starfive_wdt *wdt = dev_get_drvdata(dev);
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +
> >> +       pm_runtime_force_resume(dev);
> >> +
> >> +       /* Restore watchdog state. */
> >> +       starfive_wdt_set_reload_count(wdt, wdt->reload);
> >> +
> >> +       starfive_wdt_start(&wdt->wdt_device);
> >> +
> >> +       starfive_wdt_lock(wdt);
> >> +
> >> +       return 0;
> >> +}
> >> +#endif /* CONFIG_PM_SLEEP */
> >> +
> >> +#ifdef CONFIG_PM
> >> +static int starfive_wdt_runtime_suspend(struct device *dev)
> >> +{
> >> +       struct starfive_wdt *wdt = dev_get_drvdata(dev);
> >> +
> >> +       clk_disable_unprepare(wdt->apb_clk);
> >> +       clk_disable_unprepare(wdt->core_clk);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_runtime_resume(struct device *dev)
> >> +{
> >> +       struct starfive_wdt *wdt = dev_get_drvdata(dev);
> >> +       int ret;
> >> +
> >> +       ret = clk_prepare_enable(wdt->apb_clk);
> >> +       if (ret) {
> >> +               dev_err(wdt->dev, "failed to enable apb_clk.\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       ret = clk_prepare_enable(wdt->core_clk);
> >> +       if (ret)
> >> +               dev_err(wdt->dev, "failed to enable core_clk.\n");
> >> +
> >> +       return ret;
> >> +}
> >> +#endif /* CONFIG_PM */
> >> +
> >> +static const struct dev_pm_ops starfive_wdt_pm_ops = {
> >> +       SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> >> +       SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
> >> +};
> >> +
> >> +static struct platform_driver starfive_wdt_driver = {
> >> +       .probe          = starfive_wdt_probe,
> >> +       .remove         = starfive_wdt_remove,
> >> +       .shutdown       = starfive_wdt_shutdown,
> >> +       .id_table       = starfive_wdt_ids,
> >> +       .driver         = {
> >> +               .name   = "starfive-wdt",
> >> +               .pm     = &starfive_wdt_pm_ops,
> >> +               .of_match_table = of_match_ptr(starfive_wdt_match),
> >> +       },
> >> +};
> >> +
> >> +module_platform_driver(starfive_wdt_driver);
> >> +
> >> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> >> +MODULE_AUTHOR("Samin Guo <samin.guo@starfivetech.com>");
> >> +MODULE_DESCRIPTION("StarFive Watchdog Device Driver");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.25.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Best regards,
> Xingyu Wu
>
