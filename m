Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572E6B1F18
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCII6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCII5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:57:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E34E4862
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:56:25 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3DF163F191
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678352158;
        bh=lyHNkU+74iZVhh0g6bAgy+EddcVdkvXnBgAIlIkQKVE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hp/tTZq46xBysuoUy34VVy96YynWYC3OeT263nKwylr96hulr+lKeb7JE56W+XXNe
         QlYwaUHrVzp5bSmpbL2abJjeg1VTtjctsc9oy0KO2bzW8UHZ31fnjA1wkX3Gpj54wr
         yF8cteXLM8ZldGzOB56hfZ/Y9hyx62BlXD5Y8lb4SAtt90zgG5whCzSLVQyyebw345
         7h9IFZgWGEo+XlCStn+rNzTpjFreaIM28sm64JDspzN2BabrSthjHrdOD0upWw11xj
         9V586czbaM1FTO6ujpJnmP5ejypGkHlOj0Sn00IVVQCVU1sLBFkVZNT1kejnPY5wrK
         PRfSGKNewUmXg==
Received: by mail-qv1-f72.google.com with SMTP id e9-20020a0cf749000000b00571f1377451so892469qvo.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyHNkU+74iZVhh0g6bAgy+EddcVdkvXnBgAIlIkQKVE=;
        b=MZLllZ2MJMjp9GLNqWuoYVsdHXudoWU0mTN4NGG+z4oIiMXJps0C3j7eKojT/l04lw
         bcrs04PpB431WwebZV9pp/MAjsMNt8AuaxQhbWvueiTojfdUQm6a+5Br8Y8ez59wmamJ
         XFWcoF2dEGSC3oGWZ6rhxEmBGDRxUV6Tw9N2WEByEiK4/fdTWQBgaFHM4fEYHP5oBbc8
         9AdcEJjnshlussTh89czLX2IsqpRf7i+X/WkBGhpjegOYbxOPlsrquRiEVR/vdaHUfbY
         DCiXkr7SlvWm1L/tqIDLdh858n2yQTDCICdFF4YmUj7LTWAQT3D+z6o4iBs2j4roUOdA
         A94A==
X-Gm-Message-State: AO0yUKWiUeURzenHsr7eectb/02lHAesUsKfwwizqilUYxBJpSWPMHqX
        eGbXo4KNOULNbkwcGFpOffoO+rjEpmUli4O7NUPEncEJaKkqmFO4I+kbIQ2Dp/637sblO6M5itV
        qdNpJUPSzMg3zzJJZQfVZja1/NXfwyb8b8EfMCKfU3Z9ZmVisih+qCPcdgg==
X-Received: by 2002:a37:44f:0:b0:742:39cb:f742 with SMTP id 76-20020a37044f000000b0074239cbf742mr4667146qke.13.1678352157040;
        Thu, 09 Mar 2023 00:55:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+jgNhrlD8pYMXdLdT//n+rW2+egtmCg4Kq8jc4Lb12Iw0QETu4LqfSFEPQtvDlCPfSSLL7B+IW8RVBN6T7NXE=
X-Received: by 2002:a37:44f:0:b0:742:39cb:f742 with SMTP id
 76-20020a37044f000000b0074239cbf742mr4667142qke.13.1678352156628; Thu, 09 Mar
 2023 00:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-3-xingyu.wu@starfivetech.com> <CAJM55Z9LvQZjeEY92bZETBYhp9sSavTNkKT4T-gpsHPTQ2_LAA@mail.gmail.com>
 <7f2cc3bf-d3a8-8854-e814-49067969e6e4@starfivetech.com>
In-Reply-To: <7f2cc3bf-d3a8-8854-e814-49067969e6e4@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 9 Mar 2023 09:55:39 +0100
Message-ID: <CAJM55Z8q6UMJfCt0H+UZSS+V-WJZwuN5cn7BiJFCrGAwzo3X+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drivers: watchdog: Add StarFive Watchdog driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 08:08, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> On 2023/3/8 23:07, Emil Renner Berthing wrote:
> > On Wed, 8 Mar 2023 at 04:43, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>
> >> Add watchdog driver for the StarFive JH7100 and JH7110 SoC.
> >>
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >
> > Hi Xingyu,
> >
> > Thanks for adding the JH7100 support. I tried it on my Starlight board
> > and it seems to work fine except systemd complains about not being
> > able to set a 10min timeout on reboot:
> > systemd-shutdown[1]: Using hardware watchdog 'StarFive Watchdog',
> > version 0, device /dev/watchdog0
> > systemd-shutdown[1]: Failed to set timeout to 10min: Invalid argument
> > systemd-shutdown[1]: Syncing filesystems and block devices.
> > systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> >
> > The systemd runtime watchdog seems to work, so I guess this is just
> > because 10min is too long a timeout for the StarFive watchdog.
> >
> > More comments below.
>
> Will fix.
>
> >
> >> ---
> >>  MAINTAINERS                     |   7 +
> >>  drivers/watchdog/Kconfig        |   9 +
> >>  drivers/watchdog/Makefile       |   2 +
> >>  drivers/watchdog/starfive-wdt.c | 675 ++++++++++++++++++++++++++++++++
> >>  4 files changed, 693 insertions(+)
> >>  create mode 100644 drivers/watchdog/starfive-wdt.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 8d5bc223f305..721d0e4e8a0d 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19962,6 +19962,13 @@ S:     Supported
> >>  F:     Documentation/devicetree/bindings/rng/starfive*
> >>  F:     drivers/char/hw_random/jh7110-trng.c
> >>
> >> +STARFIVE WATCHDOG DRIVER
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
> >> index f0872970daf9..9d825ffaf292 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -2090,6 +2090,15 @@ config UML_WATCHDOG
> >>         tristate "UML watchdog"
> >>         depends on UML || COMPILE_TEST
> >>
> >> +config STARFIVE_WATCHDOG
> >> +       tristate "StarFive Watchdog support"
> >> +       depends on ARCH_STARFIVE || COMPILE_TEST
> >> +       select WATCHDOG_CORE
> >> +       default ARCH_STARFIVE
> >> +       help
> >> +         Say Y here to support the watchdog of StarFive JH7100 and JH7110
> >> +         SoC. This driver can also be built as a module if choose M.
> >
> > This file seems to be sorted by architecture, so you probably want to
> > add something like this at the appropriate place
> >
> > # RISC-V Architecture
> >
> > config STARFIVE_WATCHDOG
> > ...
> >
>
> Will add.
>
> >
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
> >
> > Again please follow the layout of the file. Eg. something like this at
> > the appropriate place
> >
> > # RISC-V Architecture
> > obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
> >
>
> Will add.
>
> >>  # Architecture Independent
> >>  obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
> >>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> >> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> >> new file mode 100644
> >> index 000000000000..8ce9f985f068
> >> --- /dev/null
> >> +++ b/drivers/watchdog/starfive-wdt.c
> >> @@ -0,0 +1,675 @@
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
> >> +/* JH7100 Watchdog register define */
> >> +#define STARFIVE_WDT_JH7100_INTSTAUS   0x000   /* RO: [4]: Watchdog Interrupt status */
> >> +#define STARFIVE_WDT_JH7100_CONTROL    0x104   /* RW: reset enable */
> >> +#define STARFIVE_WDT_JH7100_LOAD       0x108   /* RW: Watchdog Load register */
> >> +#define STARFIVE_WDT_JH7100_EN         0x110   /* RW: Watchdog Enable Register */
> >> +#define STARFIVE_WDT_JH7100_RELOAD     0x114   /* RW: Write 0 or 1 to reload preset value */
> >> +#define STARFIVE_WDT_JH7100_VALUE      0x118   /* RO: The current value for watchdog counter */
> >> +#define STARFIVE_WDT_JH7100_INTCLR     0x120   /*
> >> +                                                * RW: Watchdog Clear Interrupt Register
> >> +                                                * [0]: Write 1 to clear interrupt
> >> +                                                * [1]: 1 mean clearing and 0 mean complete
> >> +                                                */
> >> +#define STARFIVE_WDT_JH7100_LOCK       0x13c   /* RW: Lock Register, write 0x378f0765 to unlock */
> >> +
> >> +/* JH7110 Watchdog register define */
> >> +#define STARFIVE_WDT_JH7110_LOAD       0x000   /* RW: Watchdog Load register */
> >> +#define STARFIVE_WDT_JH7110_VALUE      0x004   /* RO: The current value for watchdog counter */
> >> +#define STARFIVE_WDT_JH7110_CONTROL    0x008   /*
> >> +                                                * RW:
> >> +                                                * [0]: reset enable;
> >> +                                                * [1]: int enable/wdt enable/reload counter;
> >> +                                                * [31:2]: reserved.
> >> +                                                */
> >> +#define STARFIVE_WDT_JH7110_INTCLR     0x00c   /* WO: clear intterupt && reload the counter */
> >> +#define STARFIVE_WDT_JH7110_IMS                0x014   /* RO: Enabled interrupt status from the counter */
> >> +#define STARFIVE_WDT_JH7110_LOCK       0xc00   /* RW: Lock Register, write 0x1ACCE551 to unlock */
> >
> > Since these register offsets are only used to fill in the
> > starfive_wdt_variant structures, consider just adding them directly
> > there with the comments.
> >
> >> +/* WDOGCONTROL */
> >> +#define STARFIVE_WDT_ENABLE                    0x1
> >> +#define STARFIVE_WDT_EN_SHIFT                  0
> >> +#define STARFIVE_WDT_RESET_EN                  0x1
> >> +#define STARFIVE_WDT_JH7100_RESEN_SHIFT                0
> >> +#define STARFIVE_WDT_JH7110_RESEN_SHIFT                1
> >> +
> >> +/* WDOGLOCK */
> >> +#define STARFIVE_WDT_LOCKED                    BIT(0)
> >> +#define STARFIVE_WDT_JH7100_UNLOCK_KEY         0x378f0765
> >> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY         0x1acce551
> >> +
> >> +/* WDOGINTCLR */
> >> +#define STARFIVE_WDT_INTCLR                    0x1
> >> +#define STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT   1       /* Watchdog can clear interrupt when 0 */
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
> >> +static bool early_enable = STARFIVE_WDT_EARLY_ENA;
> >> +
> >> +module_param(heartbeat, int, 0);
> >> +module_param(early_enable, bool, 0);
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
> >> +       /* resgister */
> >> +       unsigned int control;
> >> +       unsigned int load;
> >> +       unsigned int reload;
> >> +       unsigned int enable;
> >> +       unsigned int value;
> >> +       unsigned int int_clr;
> >> +       unsigned int unlock;
> >> +       unsigned int int_status;
> >> +
> >> +       u32 unlock_key;
> >> +       u8 enrst_shift;
> >> +       u8 en_shift;
> >> +       bool intclr_check;      /*  whether need to check it before clearing interrupt */
> >> +       u8 intclr_ava_shift;
> >
> > The shifts here could just be char.
>
> Will fix.
>
> >
> >> +       bool double_timeout;    /* The watchdog need twice timeout to reboot */
> >> +};
> >> +
> >> +struct starfive_wdt {
> >> +       unsigned long freq;
> >> +       struct device *dev;
> >
> > This device pointer is also stored in the parent field of struct
> > watchdog_device below, so not really needed.
>
> Will drop.
>
> >
> >> +       struct watchdog_device wdt_device;
> >
> > From looking at the other watchdog drivers a common name for this is just "wdd".
>
> Will modify it.
>
> >
> >> +       struct clk *core_clk;
> >> +       struct clk *apb_clk;
> >> +       struct reset_control *rsts;
> >
> > This pointer seems to be only used just after being obtained in the
> > starfive_wdt_reset_init function, but never needed after that, so why
> > store it here?
>
> Will modify it to be local variables.
>
> >
> >> +       u32 count;      /*count of timeout*/
> >> +       u32 reload;     /*restore the count*/
> >
> > Missing spaces between /*,*/ and text. Also please align with the comment below.
>
> Will fix.
>
> >
> >> +       void __iomem *base;
> >> +       spinlock_t lock;        /* spinlock for register handling */
> >> +       const struct starfive_wdt_variant *drv_data;
> >
> > Hmm.. to me "driver data" is this struct, whereas this field points to
> > SoC data. You already call the struct "variant", so why not just
>
> Will modify it.
>
> >
> > const struct starfive_wdt_variant *variant;
> >
> >> +};
> >
> > Consider sorting fields by size to avoid too many alignment induced
> > holes in the struct. Eg. something like
> >
> > struct starfive_wdt {
> >   struct watchdog_device wdd;
> >   spinlock_t lock;
> >   void __iomem *base;
> >   /* clock and reset pointers */
> >   const struct starfive_wdt_variant *variant;
> >   unsigned long freq;
> >   u32 count;
> >   u32 reload;
> > };
> >
> >  > +/* Register layout and configuration for the JH7100 */
> >> +static const struct starfive_wdt_variant drv_data_jh7100 = {
> >
> > Please keep using the starfive_wdt_ prefix here. Eg. something like
> >
> > starfive_wdt_jh7100_variant and
> > starfive_wdt_jh7110_variant
>
> Will modify it.
>
> >
> >> +       .control = STARFIVE_WDT_JH7100_CONTROL,
> >> +       .load = STARFIVE_WDT_JH7100_LOAD,
> >> +       .reload = STARFIVE_WDT_JH7100_RELOAD,
> >> +       .enable = STARFIVE_WDT_JH7100_EN,
> >> +       .value = STARFIVE_WDT_JH7100_VALUE,
> >> +       .int_clr = STARFIVE_WDT_JH7100_INTCLR,
> >> +       .unlock = STARFIVE_WDT_JH7100_LOCK,
> >> +       .unlock_key = STARFIVE_WDT_JH7100_UNLOCK_KEY,
> >> +       .int_status = STARFIVE_WDT_JH7100_INTSTAUS,
> >> +       .enrst_shift = STARFIVE_WDT_JH7100_RESEN_SHIFT,
> >> +       .en_shift = STARFIVE_WDT_EN_SHIFT,
> >> +       .intclr_check = true,
> >> +       .intclr_ava_shift = STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT,
> >> +       .double_timeout = false,
> >> +};
> >> +
> >> +/* Register layout and configuration for the JH7110 */
> >> +static const struct starfive_wdt_variant drv_data_jh7110 = {
> >> +       .control = STARFIVE_WDT_JH7110_CONTROL,
> >> +       .load = STARFIVE_WDT_JH7110_LOAD,
> >> +       .enable = STARFIVE_WDT_JH7110_CONTROL,
> >> +       .value = STARFIVE_WDT_JH7110_VALUE,
> >> +       .int_clr = STARFIVE_WDT_JH7110_INTCLR,
> >> +       .unlock = STARFIVE_WDT_JH7110_LOCK,
> >> +       .unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
> >> +       .int_status = STARFIVE_WDT_JH7110_IMS,
> >> +       .enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
> >> +       .en_shift = STARFIVE_WDT_EN_SHIFT,
> >> +       .intclr_check = false,
> >> +       .double_timeout = true,
> >> +};
> >> +
> >> +static const struct of_device_id starfive_wdt_match[] = {
> >> +       { .compatible = "starfive,jh7100-wdt", .data = &drv_data_jh7100 },
> >> +       { .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
> >> +       { /* sentinel */ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, starfive_wdt_match);
> >
> > Please move this struct just above struct platform_driver like most
> > other drivers. It's nice to be able to open a driver, scroll to the
> > bottom and immediately find the compatibles it matches on.
>
> Will move it.
>
> >
> >> +static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
> >> +{
> >> +       wdt->freq = clk_get_rate(wdt->core_clk);
> >> +       if (!wdt->freq) {
> >> +               dev_err(wdt->dev, "get clock rate failed.\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >
> > This function seems a bit pointless since it's only used once in the
> > probe function. Just inline it there. Consider doing the same for the
> > functions getting clocks and resets.
>
> Will modify it.
>
> >
> >> +static int starfive_wdt_enable_clock(struct starfive_wdt *wdt)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret = clk_prepare_enable(wdt->apb_clk);
> >> +       if (ret)
> >> +               return dev_err_probe(wdt->dev, ret, "failed to enable apb_clk.\n");
> >> +
> >> +       ret = clk_prepare_enable(wdt->core_clk);
> >> +       if (ret)
> >> +               return dev_err_probe(wdt->dev, ret, "failed to enable core_clk.\n");
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void starfive_wdt_disable_clock(struct starfive_wdt *wdt)
> >> +{
> >> +       clk_disable_unprepare(wdt->core_clk);
> >> +       clk_disable_unprepare(wdt->apb_clk);
> >> +}
> >> +
> >> +static int starfive_wdt_get_clock(struct starfive_wdt *wdt)
> >> +{
> >> +       wdt->apb_clk = devm_clk_get(wdt->dev, "apb");
> >> +       if (IS_ERR(wdt->apb_clk))
> >> +               return dev_err_probe(wdt->dev, PTR_ERR(wdt->apb_clk),
> >> +                                    "failed to get apb clock.\n");
> >> +
> >> +       wdt->core_clk = devm_clk_get(wdt->dev, "core");
> >> +       if (IS_ERR(wdt->core_clk))
> >> +               return dev_err_probe(wdt->dev, PTR_ERR(wdt->core_clk),
> >> +                                    "failed to get core clock.\n");
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
> >> +{
> >> +       int ret;
> >> +
> >> +       wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
> >> +       if (IS_ERR(wdt->rsts))
> >> +               return dev_err_probe(wdt->dev, PTR_ERR(wdt->rsts),
> >> +                                    "failed to get resets.\n");
> >> +
> >> +       ret = reset_control_deassert(wdt->rsts);
> >> +       if (ret)
> >> +               return dev_err_probe(wdt->dev, ret,
> >> +                                    "failed to deassert resets.\n");
> >> +
> >> +       return 0;
> >> +}
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
> >
> > u32 val = readl(...);
> >
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
> >
> > This looks suspicious. Is there really a situation where you
> > legitimately need to operate on the registers in parallel or is this
> > just glossing over programming errors? Shouldn't this
> > locking/unlocking basically happen between taking the spinlock? If
> > not, then doesn't this risk locking the registers while some other
> > thread is still using them and expects them to be unlocked?
>
> This lock register enable write access to all other registers by writing
> the unlock key. So if write registers should unlock this first. And I
> usually unlock register with the spinlock first to confirm it not be used
> repeatedly.

Right, so if there is only one simultaneous user and you always lock
the registers after use, there should be no need for the "if
(starfive_wdt_is_locked(wdt))" checks. In fact you might even be able
to fold the spinlock into these functions to make sure you always take
the spinlock and unlock in the right order. Eg.:

static void starfive_wdt_unlock(struct starfive_wdt *wdt)
{
  spin_lock(&wdt->lock);
  writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
}

static void starfive_wdt_lock(struct starfive_wdt *wdt)
{
  writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
  spin_unlock(&wdt->lock);
}

> >
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
> >> +/* interrupt status whether has been raised from the counter */
> >> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
> >> +{
> >> +       return !!readl(wdt->base + wdt->drv_data->int_status);
> >> +}
> >> +
> >> +/* waiting interrupt can be free to clear */
> >> +static int starfive_wdt_wait_int_free(struct starfive_wdt *wdt)
> >> +{
> >> +       u32 value;
> >> +
> >> +       value = readl(wdt->base + wdt->drv_data->int_clr);
> >
> > Doesn't readl_poll_timeout_atomic below read the value before using
> > it, so this line is redundant?
>
> Will drop it.
>
> >
> >> +       return readl_poll_timeout_atomic(wdt->base + wdt->drv_data->int_clr, value,
> >> +                                        !(value & BIT(wdt->drv_data->intclr_ava_shift)),
> >> +                                        STARFIVE_WDT_DELAY_US, STARFIVE_WDT_TIMEOUT_US);
> >> +}
> >> +
> >> +/* clear interrupt signal before initialization or reload */
> >> +static int starfive_wdt_int_clr(struct starfive_wdt *wdt)
> >> +{
> >> +       int ret;
> >> +
> >> +       if (wdt->drv_data->intclr_check) {
> >> +               ret = starfive_wdt_wait_int_free(wdt);
> >> +               if (ret)
> >> +                       return dev_err_probe(wdt->dev, ret,
> >> +                                            "watchdog is not ready to clear interrupt.\n");
> >> +       }
> >> +       writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
> >> +
> >> +       return 0;
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
> >> +
> >> +       /* 7100 need set any value to reload register and could reload value to counter */
> >> +       if (wdt->drv_data->reload)
> >> +               writel(0x1, wdt->base + wdt->drv_data->reload);
> >> +}
> >> +
> >> +static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
> >> +{
> >> +       unsigned int timeout_num = wdt->drv_data->double_timeout ? 2 : 1;
> >> +
> >> +       return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, (wdt->freq / timeout_num)) - 1;
> >> +}
> >> +
> >> +static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
> >> +{
> >> +       struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> >> +       u32 count;
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       /*
> >> +        * If the watchdog takes twice timeout and set half count value,
> >> +        * timeleft value should add the count value before first timeout.
> >> +        */
> >> +       count = starfive_wdt_get_count(wdt);
> >> +       if (wdt->drv_data->double_timeout && !starfive_wdt_raise_irq_status(wdt))
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
> >> +       int ret;
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +
> >> +       starfive_wdt_unlock(wdt);
> >> +       ret = starfive_wdt_int_clr(wdt);
> >> +       if (ret)
> >> +               return ret;
> >> +
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
> >> +       int ret;
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +       starfive_wdt_unlock(wdt);
> >> +       /* disable watchdog, to be safe */
> >> +       starfive_wdt_disable(wdt);
> >> +
> >> +       starfive_wdt_enable_reset(wdt);
> >> +       ret = starfive_wdt_int_clr(wdt);
> >> +       if (ret)
> >> +               return ret;
> >> +
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
> >> +       unsigned int timeout_num = wdt->drv_data->double_timeout ? 2 : 1;
> >> +
> >> +       spin_lock(&wdt->lock);
> >> +
> >> +       /*
> >> +        * This watchdog takes twice timeouts to reset.
> >> +        * In order to reduce time to reset, should set half count value.
> >> +        */
> >> +       wdt->count = timeout * freq / timeout_num;
> >> +       wdd->timeout = timeout;
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
> >
> > This macro needs a much less generic name but it's only used below, so
> > just set the .options directly there.
>
> Will use STARFIVE_OPTIONS instead.

If you insist on defining this macro please keep the STARFIVE_WDT_
prefix for consistency.

> >
> >> +static const struct watchdog_info starfive_wdt_ident = {
> >
> > Why invent a new name for this struct and not just follow the watchdog
> > framework and call it starfive_wdt_info?
>
> Will fix.
>
> >
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
> >
> > This is a very elaborate way of setting 2 pointers and a timeout. Maybe just
> >
> > wdt->wdd.info = &starfive_wdt_info;
> > wdt->wdd.ops = &starfive_wdt_ops;
> >
> > ..and drop the static const copy above. You already set the default
> > timeout again below.
>
> Oh, got it. Will fix.
>
> >
> >> +       wdt->drv_data = of_device_get_match_data(&pdev->dev);
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
> >> +               ret = starfive_wdt_enable_clock(wdt);
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >> +
> >> +       ret = starfive_wdt_get_clock_rate(wdt);
> >> +       if (ret)
> >> +               goto err_exit;
> >> +
> >> +       ret = starfive_wdt_reset_init(wdt);
> >> +       if (ret)
> >> +               goto err_exit;
> >> +
> >> +       wdt->wdt_device.min_timeout = 1;
> >> +       wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
> >> +
> >> +       watchdog_set_drvdata(&wdt->wdt_device, wdt);
> >> +
> >> +       wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> >> +       watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
> >> +       starfive_wdt_set_timeout(&wdt->wdt_device, wdt->wdt_device.timeout);
> >> +
> >> +       watchdog_set_nowayout(&wdt->wdt_device, nowayout);
> >> +       watchdog_stop_on_reboot(&wdt->wdt_device);
> >> +       watchdog_stop_on_unregister(&wdt->wdt_device);
> >> +
> >> +       wdt->wdt_device.parent = dev;
> >
> > This can be set when you first initialise wdt->wdd.
>
> Will move.
>
> >
> >> +       if (early_enable) {
> >> +               starfive_wdt_start(&wdt->wdt_device);
> >> +               set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> >> +       } else {
> >> +               starfive_wdt_stop(&wdt->wdt_device);
> >> +       }
> >> +
> >> +       ret = watchdog_register_device(&wdt->wdt_device);
> >> +       if (ret)
> >> +               goto err_exit;
> >> +
> >> +       if (!early_enable)
> >> +               pm_runtime_put_sync(wdt->dev);
> >> +
> >> +       return 0;
> >> +
> >> +err_exit:
> >> +       starfive_wdt_disable_clock(wdt);
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
> >> +       if (pm_runtime_enabled(wdt->dev))
> >> +               pm_runtime_disable(wdt->dev);
> >> +       else
> >> +               /* disable clock without PM */
> >> +               starfive_wdt_disable_clock(wdt);
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
> >
> > Please swap these around so initialised local variables come first.
> > Also other places.
>
> Will fix.
>
> >
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
> >> +       starfive_wdt_disable_clock(wdt);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int starfive_wdt_runtime_resume(struct device *dev)
> >> +{
> >> +       struct starfive_wdt *wdt = dev_get_drvdata(dev);
> >> +
> >> +       return starfive_wdt_enable_clock(wdt);
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
> >> +       .driver         = {
> >> +               .name   = "starfive-wdt",
> >> +               .pm     = &starfive_wdt_pm_ops,
> >> +               .of_match_table = of_match_ptr(starfive_wdt_match),
> >> +       },
> >> +};
> >> +
> > This empty line not needed.
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
