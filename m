Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A583645B42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLGNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLGNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:47:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DC5AE03
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:47:28 -0800 (PST)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52C264433E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670420846;
        bh=rpnOR3c3qJfn5RKpQBXkrtuL7/j6+h3fqJAFlN9ya4k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ULYBlGOMdOJwHivhIkTJlp2NRbIy8A5fAAapdRgnLrdJZgeW/OPGmd1Lz/heeazuZ
         ihfwRSIk+ZAm+CeFhR0byP/2RlYeksdJwyKXa4v4RTYQMs1EZED2pL8TLp5CUuGx1Z
         n9rjDsCJjmsIMAvYNeuqldfeQUGRjwIHGclOBJQGjYNA61ElgQHLSr0vxUmk7RETxJ
         q4gzxbHGZG0D2wmbPOvBhJDAu+hL6iyMkr1giQqSy0hGfp5j4zbGDCa4fnJJWPxgAm
         uEuPc+YfswxDoZf97uBThc5PkOUJQuA64KG9X03S9C1e+FSR3+VwnzYV8TtAZ3JGq9
         nx5m+0oBiPcMA==
Received: by mail-il1-f200.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso6047590ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpnOR3c3qJfn5RKpQBXkrtuL7/j6+h3fqJAFlN9ya4k=;
        b=53VmfyZmqeLBe6o8C3QZOig60+cFkfidN/p7jv3zHsrW/kV7EA8nTuqGrxbsUulq4k
         pEmtzeq9pLZQrdZ3OhNb/tIFMFCT7SZ6Ilarhf820YCvGHsQzrP9Yz0REbBR2/b1DWL/
         Hw54wvVwGF8loSCqIrJFLBryFd5DyQkCarBdQvkn60E1lfcyFKOBGBm7cOFSFg33JpXf
         v+y3qnuxszn4fKl+ybNsC3ZyhGtj1/4l17B+YdXnCtr25x+fISvjk8hWyZQY1WKYLcrO
         by4tqtTbUyBOOgsgrbWAMQU0j3K2iVG/mfPrJ6+wAlu3YJO3gobhhyJhCcxvkExB1SRz
         C2nQ==
X-Gm-Message-State: ANoB5pneos/f6YU9hdlbWkafgqDGJW9CD4IOoRZ1b88PdO/euVyU9lt/
        r5qVR/vWEo4nBrsTJetfuOHpcdaa55VRNwpPzRUtfY/kG2M73p4rQNIR4lEEF2NGz4lwMVKXbD6
        hyxaj03bJgrkn9IKjle0zpdqZUfYgO9oKwSGaUI99b3XhwhfWrPH0ZxafQw==
X-Received: by 2002:a05:6e02:3489:b0:303:2529:b4dd with SMTP id bp9-20020a056e02348900b003032529b4ddmr17546333ilb.175.1670420843874;
        Wed, 07 Dec 2022 05:47:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7i+ax+DL0D3rNbDG/A5clqihGGp4NSHOdG2Qy8D6ypIODJpcyBNwqjZb2Uxkh6iyCLt8I4XYLbdEk/k0o6A+k=
X-Received: by 2002:a05:6e02:3489:b0:303:2529:b4dd with SMTP id
 bp9-20020a056e02348900b003032529b4ddmr17546311ilb.175.1670420843253; Wed, 07
 Dec 2022 05:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20221118011108.70715-1-hal.feng@starfivetech.com> <20221118011108.70715-5-hal.feng@starfivetech.com>
In-Reply-To: <20221118011108.70715-5-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 14:47:06 +0100
Message-ID: <CAJM55Z-0tkp31HWm=15AwZS3428JhOysXZgBOA54XE2fynaq-A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: starfive: Add StarFive JH7110 sys
 controller driver
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
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

On Fri, 18 Nov 2022 at 02:11, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>
> Add pinctrl driver for StarFive JH7110 SoC sys pinctrl controller.
>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                   |   7 +-
>  drivers/pinctrl/starfive/Kconfig              |  21 +
>  drivers/pinctrl/starfive/Makefile             |   5 +
>  drivers/pinctrl/starfive/pinctrl-jh7110-sys.c | 464 +++++++++
>  drivers/pinctrl/starfive/pinctrl-starfive.c   | 972 ++++++++++++++++++
>  drivers/pinctrl/starfive/pinctrl-starfive.h   |  72 ++
>  6 files changed, 1538 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
>  create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive.c
>  create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec6647e2772f..a70c1d0f303e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19606,13 +19606,14 @@ F:    Documentation/devicetree/bindings/clock/starfive*
>  F:     drivers/clk/starfive/
>  F:     include/dt-bindings/clock/starfive*
>
> -STARFIVE JH7100 PINCTRL DRIVER
> +STARFIVE PINCTRL DRIVER

There are now more than 1 driver, so please use DRIVERS

>  M:     Emil Renner Berthing <kernel@esmil.dk>
> +M:     Jianlong Huang <jianlong.huang@starfivetech.com>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
> +F:     Documentation/devicetree/bindings/pinctrl/starfive*
>  F:     drivers/pinctrl/starfive/
> -F:     include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
> +F:     include/dt-bindings/pinctrl/pinctrl-starfive*
>
>  STARFIVE RESET CONTROLLER DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
> diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
> index 55c514e622f9..c7896a1f7d5a 100644
> --- a/drivers/pinctrl/starfive/Kconfig
> +++ b/drivers/pinctrl/starfive/Kconfig
> @@ -16,3 +16,24 @@ config PINCTRL_STARFIVE_JH7100
>           This also provides an interface to the GPIO pins not used by other
>           peripherals supporting inputs, outputs, configuring pull-up/pull-down
>           and interrupts on input changes.
> +
> +config PINCTRL_STARFIVE
> +       bool

Using PINCTRL_STARFIVE here is confusing, since it doesn't apply to the JH7100.
Please call this PINCTRL_STARFIVE_JH7110.

Also is there a reason this can't be tristate and the driver compiled
as a module?

> +       select GENERIC_PINCTRL_GROUPS
> +       select GENERIC_PINMUX_FUNCTIONS
> +       select GENERIC_PINCONF
> +       select GPIOLIB
> +       select GPIOLIB_IRQCHIP
> +       select OF_GPIO
> +
> +config PINCTRL_STARFIVE_JH7110
> +       bool "Pinctrl and GPIO driver for the StarFive JH7110 SoC"

Here you seem to have 1 Kconfig option for 2 separate drivers:
pinctrl-jh7110-aon and pinctrl-jh7110-sys.

I'd have individual Kconfig options for each module,
PINCTRL_STARFIVE_JH7110_SYS and PINCTRL_STARFIVE_JH7110_AON.

> +       depends on SOC_STARFIVE  || COMPILE_TEST
> +       depends on OF
> +       select PINCTRL_STARFIVE
> +       default SOC_STARFIVE
> +       help
> +         Say yes here to support pin control on the StarFive JH7110 SoC.
> +         This also provides an interface to the GPIO pins not used by other
> +         peripherals supporting inputs, outputs, configuring pull-up/pull-down
> +         and interrupts on input changes.
> diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
> index 0293f26a0a99..404929f760e8 100644
> --- a/drivers/pinctrl/starfive/Makefile
> +++ b/drivers/pinctrl/starfive/Makefile
> @@ -1,3 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +# Core
> +obj-$(CONFIG_PINCTRL_STARFIVE) += pinctrl-starfive.o

This is confusing since it gives the impression that
pinctrl-starfive.o is used by all starfive drivers, but in reality
it's only used by the jh7110 drivers. Please group the lines by SoC.

> +# SoC Drivers
>  obj-$(CONFIG_PINCTRL_STARFIVE_JH7100)  += pinctrl-starfive-jh7100.o
> +obj-$(CONFIG_PINCTRL_STARFIVE_JH7110)  += pinctrl-jh7110-sys.o

For consistency please call the module pinctrl-starfive-jh7110-sys.

> diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> new file mode 100644
> index 000000000000..942e0b6e5ac6
> --- /dev/null
> +++ b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pinctrl / GPIO driver for StarFive JH7110 SoC sys controller
> + *
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +#include "../core.h"
> +#include "../pinctrl-utils.h"
> +#include "../pinmux.h"
> +#include "../pinconf.h"
> +#include "pinctrl-starfive.h"
> +
> +#define JH7110_SYS_NGPIO               64
> +#define JH7110_SYS_GC_BASE             0
> +
> +/* registers */
> +#define JH7110_SYS_DOEN                        0x000
> +#define JH7110_SYS_DOUT                        0x040
> +#define JH7110_SYS_GPI                 0x080
> +#define JH7110_SYS_GPIOIN              0x118
> +
> +#define JH7110_SYS_GPIOEN              0x0dc
> +#define JH7110_SYS_GPIOIS0             0x0e0
> +#define JH7110_SYS_GPIOIS1             0x0e4
> +#define JH7110_SYS_GPIOIC0             0x0e8
> +#define JH7110_SYS_GPIOIC1             0x0ec
> +#define JH7110_SYS_GPIOIBE0            0x0f0
> +#define JH7110_SYS_GPIOIBE1            0x0f4
> +#define JH7110_SYS_GPIOIEV0            0x0f8
> +#define JH7110_SYS_GPIOIEV1            0x0fc
> +#define JH7110_SYS_GPIOIE0             0x100
> +#define JH7110_SYS_GPIOIE1             0x104
> +#define JH7110_SYS_GPIORIS0            0x108
> +#define JH7110_SYS_GPIORIS1            0x10c
> +#define JH7110_SYS_GPIOMIS0            0x110
> +#define JH7110_SYS_GPIOMIS1            0x114
> +
> +#define SYS_GPO_PDA_0_74_CFG           0x120
> +#define SYS_GPO_PDA_89_94_CFG          0x284

These macros suddenly drop the JH7110_ prefix. Why?

> +static const struct pinctrl_pin_desc jh7110_sys_pins[] = {
> +       PINCTRL_PIN(PAD_GPIO0,          "GPIO0"),
> +       PINCTRL_PIN(PAD_GPIO1,          "GPIO1"),
> +       PINCTRL_PIN(PAD_GPIO2,          "GPIO2"),
> +       PINCTRL_PIN(PAD_GPIO3,          "GPIO3"),
> +       PINCTRL_PIN(PAD_GPIO4,          "GPIO4"),
> +       PINCTRL_PIN(PAD_GPIO5,          "GPIO5"),
> +       PINCTRL_PIN(PAD_GPIO6,          "GPIO6"),
> +       PINCTRL_PIN(PAD_GPIO7,          "GPIO7"),
> +       PINCTRL_PIN(PAD_GPIO8,          "GPIO8"),
> +       PINCTRL_PIN(PAD_GPIO9,          "GPIO9"),
> +       PINCTRL_PIN(PAD_GPIO10,         "GPIO10"),
> +       PINCTRL_PIN(PAD_GPIO11,         "GPIO11"),
> +       PINCTRL_PIN(PAD_GPIO12,         "GPIO12"),
> +       PINCTRL_PIN(PAD_GPIO13,         "GPIO13"),
> +       PINCTRL_PIN(PAD_GPIO14,         "GPIO14"),
> +       PINCTRL_PIN(PAD_GPIO15,         "GPIO15"),
> +       PINCTRL_PIN(PAD_GPIO16,         "GPIO16"),
> +       PINCTRL_PIN(PAD_GPIO17,         "GPIO17"),
> +       PINCTRL_PIN(PAD_GPIO18,         "GPIO18"),
> +       PINCTRL_PIN(PAD_GPIO19,         "GPIO19"),
> +       PINCTRL_PIN(PAD_GPIO20,         "GPIO20"),
> +       PINCTRL_PIN(PAD_GPIO21,         "GPIO21"),
> +       PINCTRL_PIN(PAD_GPIO22,         "GPIO22"),
> +       PINCTRL_PIN(PAD_GPIO23,         "GPIO23"),
> +       PINCTRL_PIN(PAD_GPIO24,         "GPIO24"),
> +       PINCTRL_PIN(PAD_GPIO25,         "GPIO25"),
> +       PINCTRL_PIN(PAD_GPIO26,         "GPIO26"),
> +       PINCTRL_PIN(PAD_GPIO27,         "GPIO27"),
> +       PINCTRL_PIN(PAD_GPIO28,         "GPIO28"),
> +       PINCTRL_PIN(PAD_GPIO29,         "GPIO29"),
> +       PINCTRL_PIN(PAD_GPIO30,         "GPIO30"),
> +       PINCTRL_PIN(PAD_GPIO31,         "GPIO31"),
> +       PINCTRL_PIN(PAD_GPIO32,         "GPIO32"),
> +       PINCTRL_PIN(PAD_GPIO33,         "GPIO33"),
> +       PINCTRL_PIN(PAD_GPIO34,         "GPIO34"),
> +       PINCTRL_PIN(PAD_GPIO35,         "GPIO35"),
> +       PINCTRL_PIN(PAD_GPIO36,         "GPIO36"),
> +       PINCTRL_PIN(PAD_GPIO37,         "GPIO37"),
> +       PINCTRL_PIN(PAD_GPIO38,         "GPIO38"),
> +       PINCTRL_PIN(PAD_GPIO39,         "GPIO39"),
> +       PINCTRL_PIN(PAD_GPIO40,         "GPIO40"),
> +       PINCTRL_PIN(PAD_GPIO41,         "GPIO41"),
> +       PINCTRL_PIN(PAD_GPIO42,         "GPIO42"),
> +       PINCTRL_PIN(PAD_GPIO43,         "GPIO43"),
> +       PINCTRL_PIN(PAD_GPIO44,         "GPIO44"),
> +       PINCTRL_PIN(PAD_GPIO45,         "GPIO45"),
> +       PINCTRL_PIN(PAD_GPIO46,         "GPIO46"),
> +       PINCTRL_PIN(PAD_GPIO47,         "GPIO47"),
> +       PINCTRL_PIN(PAD_GPIO48,         "GPIO48"),
> +       PINCTRL_PIN(PAD_GPIO49,         "GPIO49"),
> +       PINCTRL_PIN(PAD_GPIO50,         "GPIO50"),
> +       PINCTRL_PIN(PAD_GPIO51,         "GPIO51"),
> +       PINCTRL_PIN(PAD_GPIO52,         "GPIO52"),
> +       PINCTRL_PIN(PAD_GPIO53,         "GPIO53"),
> +       PINCTRL_PIN(PAD_GPIO54,         "GPIO54"),
> +       PINCTRL_PIN(PAD_GPIO55,         "GPIO55"),
> +       PINCTRL_PIN(PAD_GPIO56,         "GPIO56"),
> +       PINCTRL_PIN(PAD_GPIO57,         "GPIO57"),
> +       PINCTRL_PIN(PAD_GPIO58,         "GPIO58"),
> +       PINCTRL_PIN(PAD_GPIO59,         "GPIO59"),
> +       PINCTRL_PIN(PAD_GPIO60,         "GPIO60"),
> +       PINCTRL_PIN(PAD_GPIO61,         "GPIO61"),
> +       PINCTRL_PIN(PAD_GPIO62,         "GPIO62"),
> +       PINCTRL_PIN(PAD_GPIO63,         "GPIO63"),
> +       PINCTRL_PIN(PAD_SD0_CLK,        "SD0_CLK"),
> +       PINCTRL_PIN(PAD_SD0_CMD,        "SD0_CMD"),
> +       PINCTRL_PIN(PAD_SD0_DATA0,      "SD0_DATA0"),
> +       PINCTRL_PIN(PAD_SD0_DATA1,      "SD0_DATA1"),
> +       PINCTRL_PIN(PAD_SD0_DATA2,      "SD0_DATA2"),
> +       PINCTRL_PIN(PAD_SD0_DATA3,      "SD0_DATA3"),
> +       PINCTRL_PIN(PAD_SD0_DATA4,      "SD0_DATA4"),
> +       PINCTRL_PIN(PAD_SD0_DATA5,      "SD0_DATA5"),
> +       PINCTRL_PIN(PAD_SD0_DATA6,      "SD0_DATA6"),
> +       PINCTRL_PIN(PAD_SD0_DATA7,      "SD0_DATA7"),
> +       PINCTRL_PIN(PAD_SD0_STRB,       "SD0_STRB"),
> +       PINCTRL_PIN(PAD_GMAC1_MDC,      "GMAC1_MDC"),
> +       PINCTRL_PIN(PAD_GMAC1_MDIO,     "GMAC1_MDIO"),
> +       PINCTRL_PIN(PAD_GMAC1_RXD0,     "GMAC1_RXD0"),
> +       PINCTRL_PIN(PAD_GMAC1_RXD1,     "GMAC1_RXD1"),
> +       PINCTRL_PIN(PAD_GMAC1_RXD2,     "GMAC1_RXD2"),
> +       PINCTRL_PIN(PAD_GMAC1_RXD3,     "GMAC1_RXD3"),
> +       PINCTRL_PIN(PAD_GMAC1_RXDV,     "GMAC1_RXDV"),
> +       PINCTRL_PIN(PAD_GMAC1_RXC,      "GMAC1_RXC"),
> +       PINCTRL_PIN(PAD_GMAC1_TXD0,     "GMAC1_TXD0"),
> +       PINCTRL_PIN(PAD_GMAC1_TXD1,     "GMAC1_TXD1"),
> +       PINCTRL_PIN(PAD_GMAC1_TXD2,     "GMAC1_TXD2"),
> +       PINCTRL_PIN(PAD_GMAC1_TXD3,     "GMAC1_TXD3"),
> +       PINCTRL_PIN(PAD_GMAC1_TXEN,     "GMAC1_TXEN"),
> +       PINCTRL_PIN(PAD_GMAC1_TXC,      "GMAC1_TXC"),
> +       PINCTRL_PIN(PAD_QSPI_SCLK,      "QSPI_SCLK"),
> +       PINCTRL_PIN(PAD_QSPI_CS0,       "QSPI_CS0"),
> +       PINCTRL_PIN(PAD_QSPI_DATA0,     "QSPI_DATA0"),
> +       PINCTRL_PIN(PAD_QSPI_DATA1,     "QSPI_DATA1"),
> +       PINCTRL_PIN(PAD_QSPI_DATA2,     "QSPI_DATA2"),
> +       PINCTRL_PIN(PAD_QSPI_DATA3,     "QSPI_DATA3"),
> +};
> +
> +struct jh7110_func_sel {
> +       u16 offset;
> +       u8 shift;
> +       u8 max;
> +};
> +
> +static const struct jh7110_func_sel
> +       jh7110_sys_func_sel[ARRAY_SIZE(jh7110_sys_pins)] = {
> +       [PAD_GMAC1_RXC] = { 0x29c,  0, 1 },
> +       [PAD_GPIO10]    = { 0x29c,  2, 3 },
> +       [PAD_GPIO11]    = { 0x29c,  5, 3 },
> +       [PAD_GPIO12]    = { 0x29c,  8, 3 },
> +       [PAD_GPIO13]    = { 0x29c, 11, 3 },
> +       [PAD_GPIO14]    = { 0x29c, 14, 3 },
> +       [PAD_GPIO15]    = { 0x29c, 17, 3 },
> +       [PAD_GPIO16]    = { 0x29c, 20, 3 },
> +       [PAD_GPIO17]    = { 0x29c, 23, 3 },
> +       [PAD_GPIO18]    = { 0x29c, 26, 3 },
> +       [PAD_GPIO19]    = { 0x29c, 29, 3 },
> +
> +       [PAD_GPIO20]    = { 0x2a0,  0, 3 },
> +       [PAD_GPIO21]    = { 0x2a0,  3, 3 },
> +       [PAD_GPIO22]    = { 0x2a0,  6, 3 },
> +       [PAD_GPIO23]    = { 0x2a0,  9, 3 },
> +       [PAD_GPIO24]    = { 0x2a0, 12, 3 },
> +       [PAD_GPIO25]    = { 0x2a0, 15, 3 },
> +       [PAD_GPIO26]    = { 0x2a0, 18, 3 },
> +       [PAD_GPIO27]    = { 0x2a0, 21, 3 },
> +       [PAD_GPIO28]    = { 0x2a0, 24, 3 },
> +       [PAD_GPIO29]    = { 0x2a0, 27, 3 },
> +
> +       [PAD_GPIO30]    = { 0x2a4,  0, 3 },
> +       [PAD_GPIO31]    = { 0x2a4,  3, 3 },
> +       [PAD_GPIO32]    = { 0x2a4,  6, 3 },
> +       [PAD_GPIO33]    = { 0x2a4,  9, 3 },
> +       [PAD_GPIO34]    = { 0x2a4, 12, 3 },
> +       [PAD_GPIO35]    = { 0x2a4, 15, 3 },
> +       [PAD_GPIO36]    = { 0x2a4, 17, 3 },
> +       [PAD_GPIO37]    = { 0x2a4, 20, 3 },
> +       [PAD_GPIO38]    = { 0x2a4, 23, 3 },
> +       [PAD_GPIO39]    = { 0x2a4, 26, 3 },
> +       [PAD_GPIO40]    = { 0x2a4, 29, 3 },
> +
> +       [PAD_GPIO41]    = { 0x2a8,  0, 3 },
> +       [PAD_GPIO42]    = { 0x2a8,  3, 3 },
> +       [PAD_GPIO43]    = { 0x2a8,  6, 3 },
> +       [PAD_GPIO44]    = { 0x2a8,  9, 3 },
> +       [PAD_GPIO45]    = { 0x2a8, 12, 3 },
> +       [PAD_GPIO46]    = { 0x2a8, 15, 3 },
> +       [PAD_GPIO47]    = { 0x2a8, 18, 3 },
> +       [PAD_GPIO48]    = { 0x2a8, 21, 3 },
> +       [PAD_GPIO49]    = { 0x2a8, 24, 3 },
> +       [PAD_GPIO50]    = { 0x2a8, 27, 3 },
> +       [PAD_GPIO51]    = { 0x2a8, 30, 3 },
> +
> +       [PAD_GPIO52]    = { 0x2ac,  0, 3 },
> +       [PAD_GPIO53]    = { 0x2ac,  2, 3 },
> +       [PAD_GPIO54]    = { 0x2ac,  4, 3 },
> +       [PAD_GPIO55]    = { 0x2ac,  6, 3 },
> +       [PAD_GPIO56]    = { 0x2ac,  9, 3 },
> +       [PAD_GPIO57]    = { 0x2ac, 12, 3 },
> +       [PAD_GPIO58]    = { 0x2ac, 15, 3 },
> +       [PAD_GPIO59]    = { 0x2ac, 18, 3 },
> +       [PAD_GPIO60]    = { 0x2ac, 21, 3 },
> +       [PAD_GPIO61]    = { 0x2ac, 24, 3 },
> +       [PAD_GPIO62]    = { 0x2ac, 27, 3 },
> +       [PAD_GPIO63]    = { 0x2ac, 30, 3 },
> +
> +       [PAD_GPIO6]     = { 0x2b0,  0, 3 },
> +       [PAD_GPIO7]     = { 0x2b0,  2, 3 },
> +       [PAD_GPIO8]     = { 0x2b0,  5, 3 },
> +       [PAD_GPIO9]     = { 0x2b0,  8, 3 },
> +};
> +
> +struct jh7110_vin_group_sel {
> +       u16 offset;
> +       u8 shift;
> +       u8 group;
> +};
> +
> +static const struct jh7110_vin_group_sel
> +       jh7110_sys_vin_group_sel[ARRAY_SIZE(jh7110_sys_pins)] = {
> +       [PAD_GPIO6]     = { 0x2b4, 21, 0 },
> +       [PAD_GPIO7]     = { 0x2b4, 18, 0 },
> +       [PAD_GPIO8]     = { 0x2b4, 15, 0 },
> +       [PAD_GPIO9]     = { 0x2b0, 11, 0 },
> +       [PAD_GPIO10]    = { 0x2b0, 20, 0 },
> +       [PAD_GPIO11]    = { 0x2b0, 23, 0 },
> +       [PAD_GPIO12]    = { 0x2b0, 26, 0 },
> +       [PAD_GPIO13]    = { 0x2b0, 29, 0 },
> +       [PAD_GPIO14]    = { 0x2b4,  0, 0 },
> +       [PAD_GPIO15]    = { 0x2b4,  3, 0 },
> +       [PAD_GPIO16]    = { 0x2b4,  6, 0 },
> +       [PAD_GPIO17]    = { 0x2b4,  9, 0 },
> +       [PAD_GPIO18]    = { 0x2b4, 12, 0 },
> +       [PAD_GPIO19]    = { 0x2b0, 14, 0 },
> +       [PAD_GPIO20]    = { 0x2b0, 17, 0 },
> +
> +       [PAD_GPIO21]    = { 0x2b4, 21, 1 },
> +       [PAD_GPIO22]    = { 0x2b4, 18, 1 },
> +       [PAD_GPIO23]    = { 0x2b4, 15, 1 },
> +       [PAD_GPIO24]    = { 0x2b0, 11, 1 },
> +       [PAD_GPIO25]    = { 0x2b0, 20, 1 },
> +       [PAD_GPIO26]    = { 0x2b0, 23, 1 },
> +       [PAD_GPIO27]    = { 0x2b0, 26, 1 },
> +       [PAD_GPIO28]    = { 0x2b0, 29, 1 },
> +       [PAD_GPIO29]    = { 0x2b4,  0, 1 },
> +       [PAD_GPIO30]    = { 0x2b4,  3, 1 },
> +       [PAD_GPIO31]    = { 0x2b4,  6, 1 },
> +       [PAD_GPIO32]    = { 0x2b4,  9, 1 },
> +       [PAD_GPIO33]    = { 0x2b4, 12, 1 },
> +       [PAD_GPIO34]    = { 0x2b0, 14, 1 },
> +       [PAD_GPIO35]    = { 0x2b0, 17, 1 },
> +
> +       [PAD_GPIO36]    = { 0x2b4, 21, 2 },
> +       [PAD_GPIO37]    = { 0x2b4, 18, 2 },
> +       [PAD_GPIO38]    = { 0x2b4, 15, 2 },
> +       [PAD_GPIO39]    = { 0x2b0, 11, 2 },
> +       [PAD_GPIO40]    = { 0x2b0, 20, 2 },
> +       [PAD_GPIO41]    = { 0x2b0, 23, 2 },
> +       [PAD_GPIO42]    = { 0x2b0, 26, 2 },
> +       [PAD_GPIO43]    = { 0x2b0, 29, 2 },
> +       [PAD_GPIO44]    = { 0x2b4,  0, 2 },
> +       [PAD_GPIO45]    = { 0x2b4,  3, 2 },
> +       [PAD_GPIO46]    = { 0x2b4,  6, 2 },
> +       [PAD_GPIO47]    = { 0x2b4,  9, 2 },
> +       [PAD_GPIO48]    = { 0x2b4, 12, 2 },
> +       [PAD_GPIO49]    = { 0x2b0, 14, 2 },
> +       [PAD_GPIO50]    = { 0x2b0, 17, 2 },
> +};
> +
> +static void jh7110_set_function(struct starfive_pinctrl *sfp,
> +                               unsigned int pin, u32 func)
> +{
> +       const struct jh7110_func_sel *fs = &jh7110_sys_func_sel[pin];
> +       unsigned long flags;
> +       void __iomem *reg;
> +       u32 mask;
> +
> +       if (!fs->offset)
> +               return;
> +
> +       if (func > fs->max)
> +               return;
> +
> +       reg = sfp->base + fs->offset;
> +       func = func << fs->shift;
> +       mask = 0x3U << fs->shift;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       func |= readl_relaxed(reg) & ~mask;
> +       writel_relaxed(func, reg);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static void jh7110_set_vin_group(struct starfive_pinctrl *sfp,
> +                                unsigned int pin)
> +{
> +       const struct jh7110_vin_group_sel *gs = &jh7110_sys_vin_group_sel[pin];
> +       unsigned long flags;
> +       void __iomem *reg;
> +       u32 mask;
> +       u32 grp;
> +
> +       if (!gs->offset)
> +               return;
> +
> +       reg = sfp->base + gs->offset;
> +       grp = gs->group << gs->shift;
> +       mask = 0x3U << gs->shift;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       grp |= readl_relaxed(reg) & ~mask;
> +       writel_relaxed(grp, reg);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static int jh7110_sys_set_one_pin_mux(struct starfive_pinctrl *sfp,
> +                                     unsigned int pin,
> +                                     unsigned int din, u32 dout,
> +                                     u32 doen, u32 func)
> +{
> +       if (pin < sfp->gc.ngpio && func == 0)
> +               starfive_set_gpiomux(sfp, pin, din, dout, doen);
> +
> +       jh7110_set_function(sfp, pin, func);
> +
> +       if (pin < sfp->gc.ngpio && func == 2)
> +               jh7110_set_vin_group(sfp, pin);
> +
> +       return 0;
> +}
> +
> +static int jh7110_sys_get_padcfg_base(struct starfive_pinctrl *sfp,
> +                                     unsigned int pin)
> +{
> +       if (pin < PAD_GMAC1_MDC)
> +               return SYS_GPO_PDA_0_74_CFG;
> +       else if (pin > PAD_GMAC1_TXC && pin <= PAD_QSPI_DATA3)
> +               return SYS_GPO_PDA_89_94_CFG;
> +       else
> +               return -1;
> +}
> +
> +static void jh7110_sys_irq_handler(struct irq_desc *desc)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_desc(desc);
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       unsigned long mis;
> +       unsigned int pin;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       mis = readl_relaxed(sfp->base + JH7110_SYS_GPIOMIS0);
> +       for_each_set_bit(pin, &mis, 32)
> +               generic_handle_domain_irq(sfp->gc.irq.domain, pin);
> +
> +       mis = readl_relaxed(sfp->base + JH7110_SYS_GPIOMIS1);
> +       for_each_set_bit(pin, &mis, 32)
> +               generic_handle_domain_irq(sfp->gc.irq.domain, pin + 32);
> +
> +       chained_irq_exit(chip, desc);
> +}
> +
> +static int jh7110_sys_init_hw(struct gpio_chip *gc)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +
> +       /* mask all GPIO interrupts */
> +       writel(0U, sfp->base + JH7110_SYS_GPIOIE0);
> +       writel(0U, sfp->base + JH7110_SYS_GPIOIE1);
> +       /* clear edge interrupt flags */
> +       writel(~0U, sfp->base + JH7110_SYS_GPIOIC0);
> +       writel(~0U, sfp->base + JH7110_SYS_GPIOIC1);
> +       /* enable GPIO interrupts */
> +       writel(1U, sfp->base + JH7110_SYS_GPIOEN);
> +       return 0;
> +}
> +
> +static const struct starfive_gpio_irq_reg jh7110_sys_irq_reg = {
> +       .is_reg_base    = JH7110_SYS_GPIOIS0,
> +       .ic_reg_base    = JH7110_SYS_GPIOIC0,
> +       .ibe_reg_base   = JH7110_SYS_GPIOIBE0,
> +       .iev_reg_base   = JH7110_SYS_GPIOIEV0,
> +       .ie_reg_base    = JH7110_SYS_GPIOIE0,
> +       .ris_reg_base   = JH7110_SYS_GPIORIS0,
> +       .mis_reg_base   = JH7110_SYS_GPIOMIS0,
> +};
> +
> +static const struct starfive_pinctrl_soc_info jh7110_sys_pinctrl_info = {
> +       .pins           = jh7110_sys_pins,
> +       .npins          = ARRAY_SIZE(jh7110_sys_pins),
> +       .ngpios         = JH7110_SYS_NGPIO,
> +       .gc_base        = JH7110_SYS_GC_BASE,
> +       .flags          = 1,
> +       .dout_reg_base  = JH7110_SYS_DOUT,
> +       .dout_mask      = GENMASK(6, 0),
> +       .doen_reg_base  = JH7110_SYS_DOEN,
> +       .doen_mask      = GENMASK(5, 0),
> +       .gpi_reg_base   = JH7110_SYS_GPI,
> +       .gpi_mask       = GENMASK(6, 0),
> +       .gpioin_reg_base           = JH7110_SYS_GPIOIN,
> +       .irq_reg                   = &jh7110_sys_irq_reg,
> +       .starfive_set_one_pin_mux  = jh7110_sys_set_one_pin_mux,
> +       .starfive_get_padcfg_base  = jh7110_sys_get_padcfg_base,
> +       .starfive_gpio_irq_handler = jh7110_sys_irq_handler,
> +       .starfive_gpio_init_hw     = jh7110_sys_init_hw,
> +};
> +
> +static const struct of_device_id jh7110_sys_pinctrl_of_match[] = {
> +       {
> +               .compatible = "starfive,jh7110-sys-pinctrl",
> +               .data = &jh7110_sys_pinctrl_info,
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static int jh7110_sys_pinctrl_probe(struct platform_device *pdev)
> +{
> +       const struct starfive_pinctrl_soc_info *pinctrl_info;
> +
> +       pinctrl_info = of_device_get_match_data(&pdev->dev);
> +       if (!pinctrl_info)
> +               return -ENODEV;
> +
> +       return starfive_pinctrl_probe(pdev, pinctrl_info);
> +}

This wrapper is identical to the wrapper in the -aon driver, so you
can get the match data in the common probe function and drop these
wrappers.

> +
> +static struct platform_driver jh7110_sys_pinctrl_driver = {
> +       .driver = {
> +               .name = "starfive-jh7110-sys-pinctrl",
> +               .of_match_table = of_match_ptr(jh7110_sys_pinctrl_of_match),

Please drop the of_match_ptr macro. This driver already depends on CONFIG_OF.

> +       },
> +       .probe = jh7110_sys_pinctrl_probe,
> +};
> +
> +static int __init jh7110_sys_pinctrl_init(void)
> +{
> +       return platform_driver_register(&jh7110_sys_pinctrl_driver);
> +}
> +arch_initcall(jh7110_sys_pinctrl_init);

Why can't this just be module_platform_driver(jh7110_sys_pinctrl_driver); ?
That works for me, so what problems did you run into that means you
need to load this driver earlier?

> +MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH7110 SoC sys controller");
> +MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
> +MODULE_AUTHOR("Jianlong Huang <jianlong.huang@starfivetech.com>");

I still think this driver should be fine as a module, but if not then
these lines should be removed.

> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive.c
> new file mode 100644
> index 000000000000..944caa599460
> --- /dev/null
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive.c

Please call the file pinctrl-starfive-jh7110.c since it only applies
to the JH7110.

> @@ -0,0 +1,972 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pinctrl / GPIO driver for StarFive JH7110 SoC
> + *
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +#include "../core.h"
> +#include "../pinctrl-utils.h"
> +#include "../pinmux.h"
> +#include "../pinconf.h"
> +#include "pinctrl-starfive.h"
> +
> +/* pad control bits */
> +#define STARFIVE_PADCFG_POS    BIT(7)
> +#define STARFIVE_PADCFG_SMT    BIT(6)
> +#define STARFIVE_PADCFG_SLEW   BIT(5)
> +#define STARFIVE_PADCFG_PD     BIT(4)
> +#define STARFIVE_PADCFG_PU     BIT(3)
> +#define STARFIVE_PADCFG_BIAS   (STARFIVE_PADCFG_PD | STARFIVE_PADCFG_PU)
> +#define STARFIVE_PADCFG_DS_MASK        GENMASK(2, 1)
> +#define STARFIVE_PADCFG_DS_2MA (0U << 1)
> +#define STARFIVE_PADCFG_DS_4MA BIT(1)
> +#define STARFIVE_PADCFG_DS_8MA (2U << 1)
> +#define STARFIVE_PADCFG_DS_12MA        (3U << 1)
> +#define STARFIVE_PADCFG_IE     BIT(0)

Above you use the JH7110_ prefix for macros, so please be consistent
and use the same prefix here.

> +#define GPIO_NUM_PER_WORD      32

I don't really see the value in this macro, but if you really want it
then it should be named something less generic.

> +/*
> + * The packed pinmux values from the device tree look like this:
> + *
> + *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   | 7 - 0 |
> + *  |   din   |  dout   |  doen   | function |  pin  |
> + */
> +static unsigned int starfive_pinmux_din(u32 v)
> +{
> +       return (v & GENMASK(31, 24)) >> 24;
> +}
> +
> +static u32 starfive_pinmux_dout(u32 v)
> +{
> +       return (v & GENMASK(23, 16)) >> 16;
> +}
> +
> +static u32 starfive_pinmux_doen(u32 v)
> +{
> +       return (v & GENMASK(15, 10)) >> 10;
> +}
> +
> +static u32 starfive_pinmux_function(u32 v)
> +{
> +       return (v & GENMASK(9, 8)) >> 8;
> +}
> +
> +static unsigned int starfive_pinmux_pin(u32 v)
> +{
> +       return v & GENMASK(7, 0);
> +}
> +
> +static struct starfive_pinctrl *starfive_from_irq_data(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +       return container_of(gc, struct starfive_pinctrl, gc);
> +}
> +
> +struct starfive_pinctrl *starfive_from_irq_desc(struct irq_desc *desc)
> +{
> +       struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> +
> +       return container_of(gc, struct starfive_pinctrl, gc);
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void starfive_pin_dbg_show(struct pinctrl_dev *pctldev,
> +                                 struct seq_file *s, unsigned int pin)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +
> +       seq_printf(s, "%s", dev_name(pctldev->dev));
> +
> +       if (pin < sfp->gc.ngpio) {
> +               unsigned int offset = 4 * (pin / 4);
> +               unsigned int shift  = 8 * (pin % 4);
> +               u32 dout = readl_relaxed(sfp->base + info->dout_reg_base + offset);
> +               u32 doen = readl_relaxed(sfp->base + info->doen_reg_base + offset);
> +               u32 gpi = readl_relaxed(sfp->base + info->gpi_reg_base + offset);
> +
> +               dout = (dout >> shift) & info->dout_mask;
> +               doen = (doen >> shift) & info->doen_mask;
> +               gpi = ((gpi >> shift) - 2) & info->gpi_mask;
> +
> +               seq_printf(s, " dout=%u doen=%u din=%u", dout, doen, gpi);
> +       }
> +}
> +#else
> +#define starfive_pin_dbg_show NULL
> +#endif
> +
> +static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                  struct device_node *np,
> +                                  struct pinctrl_map **maps,
> +                                  unsigned int *num_maps)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       struct device *dev = sfp->gc.parent;
> +       struct device_node *child;
> +       struct pinctrl_map *map;
> +       const char **pgnames;
> +       const char *grpname;
> +       int ngroups;
> +       int nmaps;
> +       int ret;
> +
> +       ngroups = 0;
> +       for_each_child_of_node(np, child)
> +               ngroups += 1;
> +       nmaps = 2 * ngroups;
> +
> +       pgnames = devm_kcalloc(dev, ngroups, sizeof(*pgnames), GFP_KERNEL);
> +       if (!pgnames)
> +               return -ENOMEM;
> +
> +       map = kcalloc(nmaps, sizeof(*map), GFP_KERNEL);
> +       if (!map)
> +               return -ENOMEM;
> +
> +       nmaps = 0;
> +       ngroups = 0;
> +       mutex_lock(&sfp->mutex);
> +       for_each_child_of_node(np, child) {
> +               int npins = of_property_count_u32_elems(child, "pinmux");
> +               int *pins;
> +               u32 *pinmux;
> +               int i;
> +
> +               if (npins < 1) {
> +                       dev_err(dev,
> +                               "invalid pinctrl group %pOFn.%pOFn: pinmux not set\n",
> +                               np, child);
> +                       ret = -EINVAL;
> +                       goto put_child;
> +               }
> +
> +               grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
> +               if (!grpname) {
> +                       ret = -ENOMEM;
> +                       goto put_child;
> +               }
> +
> +               pgnames[ngroups++] = grpname;
> +
> +               pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
> +               if (!pins) {
> +                       ret = -ENOMEM;
> +                       goto put_child;
> +               }
> +
> +               pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
> +               if (!pinmux) {
> +                       ret = -ENOMEM;
> +                       goto put_child;
> +               }
> +
> +               ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
> +               if (ret)
> +                       goto put_child;
> +
> +               for (i = 0; i < npins; i++)
> +                       pins[i] = starfive_pinmux_pin(pinmux[i]);
> +
> +               map[nmaps].type = PIN_MAP_TYPE_MUX_GROUP;
> +               map[nmaps].data.mux.function = np->name;
> +               map[nmaps].data.mux.group = grpname;
> +               nmaps += 1;
> +
> +               ret = pinctrl_generic_add_group(pctldev, grpname,
> +                                               pins, npins, pinmux);
> +               if (ret < 0) {
> +                       dev_err(dev, "error adding group %s: %d\n", grpname, ret);
> +                       goto put_child;
> +               }
> +
> +               ret = pinconf_generic_parse_dt_config(child, pctldev,
> +                                                     &map[nmaps].data.configs.configs,
> +                                                     &map[nmaps].data.configs.num_configs);
> +               if (ret) {
> +                       dev_err(dev, "error parsing pin config of group %s: %d\n",
> +                               grpname, ret);
> +                       goto put_child;
> +               }
> +
> +               /* don't create a map if there are no pinconf settings */
> +               if (map[nmaps].data.configs.num_configs == 0)
> +                       continue;
> +
> +               map[nmaps].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> +               map[nmaps].data.configs.group_or_pin = grpname;
> +               nmaps += 1;
> +       }
> +
> +       ret = pinmux_generic_add_function(pctldev, np->name,
> +                                         pgnames, ngroups, NULL);
> +       if (ret < 0) {
> +               dev_err(dev, "error adding function %s: %d\n", np->name, ret);
> +               goto free_map;
> +       }
> +       mutex_unlock(&sfp->mutex);
> +
> +       *maps = map;
> +       *num_maps = nmaps;
> +       return 0;
> +
> +put_child:
> +       of_node_put(child);
> +free_map:
> +       pinctrl_utils_free_map(pctldev, map, nmaps);
> +       mutex_unlock(&sfp->mutex);
> +       return ret;
> +}
> +
> +static const struct pinctrl_ops starfive_pinctrl_ops = {
> +       .get_groups_count = pinctrl_generic_get_group_count,
> +       .get_group_name   = pinctrl_generic_get_group_name,
> +       .get_group_pins   = pinctrl_generic_get_group_pins,
> +       .pin_dbg_show     = starfive_pin_dbg_show,
> +       .dt_node_to_map   = starfive_dt_node_to_map,
> +       .dt_free_map      = pinctrl_utils_free_map,
> +};

Again this file only applies to the JH7110, so please be consistent
and prefix everything jh7110_ and not the generic starfive_ which
gives the impression works on all StarFive SoCs.

> +
> +void starfive_set_gpiomux(struct starfive_pinctrl *sfp, unsigned int pin,
> +                         unsigned int din, u32 dout, u32 doen)
> +{
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +
> +       unsigned int offset = 4 * (pin / 4);
> +       unsigned int shift  = 8 * (pin % 4);
> +       u32 dout_mask = info->dout_mask << shift;
> +       u32 done_mask = info->doen_mask << shift;
> +       u32 ival, imask;
> +       void __iomem *reg_dout;
> +       void __iomem *reg_doen;
> +       void __iomem *reg_din;
> +       unsigned long flags;
> +
> +       reg_dout = sfp->base + info->dout_reg_base + offset;
> +       reg_doen = sfp->base + info->doen_reg_base + offset;
> +       dout <<= shift;
> +       doen <<= shift;
> +       if (din != GPI_NONE) {
> +               unsigned int ioffset = 4 * (din / 4);
> +               unsigned int ishift  = 8 * (din % 4);
> +
> +               reg_din = sfp->base + info->gpi_reg_base + ioffset;
> +               ival = (pin + 2) << ishift;
> +               imask = info->gpi_mask << ishift;
> +       } else {
> +               reg_din = NULL;
> +       }
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       dout |= readl_relaxed(reg_dout) & ~dout_mask;
> +       writel_relaxed(dout, reg_dout);
> +       doen |= readl_relaxed(reg_doen) & ~done_mask;
> +       writel_relaxed(doen, reg_doen);
> +       if (reg_din) {
> +               ival |= readl_relaxed(reg_din) & ~imask;
> +               writel_relaxed(ival, reg_din);
> +       }
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static int starfive_set_mux(struct pinctrl_dev *pctldev,
> +                           unsigned int fsel, unsigned int gsel)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       const struct group_desc *group;
> +       const u32 *pinmux;
> +       unsigned int i;
> +
> +       group = pinctrl_generic_get_group(pctldev, gsel);
> +       if (!group)
> +               return -EINVAL;
> +
> +       pinmux = group->data;
> +       for (i = 0; i < group->num_pins; i++) {
> +               u32 v = pinmux[i];
> +
> +               if (info->starfive_set_one_pin_mux)
> +                       info->starfive_set_one_pin_mux(sfp,
> +                                       starfive_pinmux_pin(v),
> +                                       starfive_pinmux_din(v),
> +                                       starfive_pinmux_dout(v),
> +                                       starfive_pinmux_doen(v),
> +                                       starfive_pinmux_function(v));
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct pinmux_ops starfive_pinmux_ops = {
> +       .get_functions_count = pinmux_generic_get_function_count,
> +       .get_function_name   = pinmux_generic_get_function_name,
> +       .get_function_groups = pinmux_generic_get_function_groups,
> +       .set_mux             = starfive_set_mux,
> +       .strict              = true,
> +};
> +
> +static const u8 starfive_drive_strength_mA[4] = { 2, 4, 8, 12 };
> +
> +static u32 starfive_padcfg_ds_to_mA(u32 padcfg)
> +{
> +       return starfive_drive_strength_mA[(padcfg >> 1) & 3U];
> +}
> +
> +static u32 starfive_padcfg_ds_from_mA(u32 v)
> +{
> +       int i;
> +
> +       for (i = 0; i < 3; i++) {
> +               if (v <= starfive_drive_strength_mA[i])
> +                       break;
> +       }
> +       return i << 1;
> +}
> +
> +static void starfive_padcfg_rmw(struct starfive_pinctrl *sfp,
> +                               unsigned int pin, u32 mask, u32 value)
> +{
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       void __iomem *reg;
> +       unsigned long flags;
> +       int padcfg_base;
> +
> +       if (!info->starfive_get_padcfg_base)
> +               return;
> +
> +       padcfg_base = info->starfive_get_padcfg_base(sfp, pin);
> +       if (padcfg_base < 0)
> +               return;
> +
> +       reg = sfp->base + padcfg_base + 4 * pin;
> +       value &= mask;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       value |= readl_relaxed(reg) & ~mask;
> +       writel_relaxed(value, reg);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static int starfive_pinconf_get(struct pinctrl_dev *pctldev,
> +                               unsigned int pin, unsigned long *config)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       int param = pinconf_to_config_param(*config);
> +       u32 padcfg, arg;
> +       bool enabled;
> +       int padcfg_base;
> +
> +       if (!info->starfive_get_padcfg_base)
> +               return 0;
> +
> +       padcfg_base = info->starfive_get_padcfg_base(sfp, pin);
> +       if (padcfg_base < 0)
> +               return 0;
> +
> +       padcfg = readl_relaxed(sfp->base + padcfg_base + 4 * pin);
> +       switch (param) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +               enabled = !(padcfg & STARFIVE_PADCFG_BIAS);
> +               arg = 0;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               enabled = padcfg & STARFIVE_PADCFG_PD;
> +               arg = 1;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +               enabled = padcfg & STARFIVE_PADCFG_PU;
> +               arg = 1;
> +               break;
> +       case PIN_CONFIG_DRIVE_STRENGTH:
> +               enabled = true;
> +               arg = starfive_padcfg_ds_to_mA(padcfg);
> +               break;
> +       case PIN_CONFIG_INPUT_ENABLE:
> +               enabled = padcfg & STARFIVE_PADCFG_IE;
> +               arg = enabled;
> +               break;
> +       case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +               enabled = padcfg & STARFIVE_PADCFG_SMT;
> +               arg = enabled;
> +               break;
> +       case PIN_CONFIG_SLEW_RATE:
> +               enabled = true;
> +               arg = !!(padcfg & STARFIVE_PADCFG_SLEW);
> +               break;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +
> +       *config = pinconf_to_config_packed(param, arg);
> +       return enabled ? 0 : -EINVAL;
> +}
> +
> +static int starfive_pinconf_group_get(struct pinctrl_dev *pctldev,
> +                                     unsigned int gsel,
> +                                     unsigned long *config)
> +{
> +       const struct group_desc *group;
> +
> +       group = pinctrl_generic_get_group(pctldev, gsel);
> +       if (!group)
> +               return -EINVAL;
> +
> +       return starfive_pinconf_get(pctldev, group->pins[0], config);
> +}
> +
> +static int starfive_pinconf_group_set(struct pinctrl_dev *pctldev,
> +                                     unsigned int gsel,
> +                                     unsigned long *configs,
> +                                     unsigned int num_configs)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       const struct group_desc *group;
> +       u16 mask, value;
> +       int i;
> +
> +       group = pinctrl_generic_get_group(pctldev, gsel);
> +       if (!group)
> +               return -EINVAL;
> +
> +       mask = 0;
> +       value = 0;
> +       for (i = 0; i < num_configs; i++) {
> +               int param = pinconf_to_config_param(configs[i]);
> +               u32 arg = pinconf_to_config_argument(configs[i]);
> +
> +               switch (param) {
> +               case PIN_CONFIG_BIAS_DISABLE:
> +                       mask |= STARFIVE_PADCFG_BIAS;
> +                       value &= ~STARFIVE_PADCFG_BIAS;
> +                       break;
> +               case PIN_CONFIG_BIAS_PULL_DOWN:
> +                       if (arg == 0)
> +                               return -ENOTSUPP;
> +                       mask |= STARFIVE_PADCFG_BIAS;
> +                       value = (value & ~STARFIVE_PADCFG_BIAS) | STARFIVE_PADCFG_PD;
> +                       break;
> +               case PIN_CONFIG_BIAS_PULL_UP:
> +                       if (arg == 0)
> +                               return -ENOTSUPP;
> +                       mask |= STARFIVE_PADCFG_BIAS;
> +                       value = (value & ~STARFIVE_PADCFG_BIAS) | STARFIVE_PADCFG_PU;
> +                       break;
> +               case PIN_CONFIG_DRIVE_STRENGTH:
> +                       mask |= STARFIVE_PADCFG_DS_MASK;
> +                       value = (value & ~STARFIVE_PADCFG_DS_MASK) |
> +                               starfive_padcfg_ds_from_mA(arg);
> +                       break;
> +               case PIN_CONFIG_INPUT_ENABLE:
> +                       mask |= STARFIVE_PADCFG_IE;
> +                       if (arg)
> +                               value |= STARFIVE_PADCFG_IE;
> +                       else
> +                               value &= ~STARFIVE_PADCFG_IE;
> +                       break;
> +               case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +                       mask |= STARFIVE_PADCFG_SMT;
> +                       if (arg)
> +                               value |= STARFIVE_PADCFG_SMT;
> +                       else
> +                               value &= ~STARFIVE_PADCFG_SMT;
> +                       break;
> +               case PIN_CONFIG_SLEW_RATE:
> +                       mask |= STARFIVE_PADCFG_SLEW;
> +                       if (arg)
> +                               value |= STARFIVE_PADCFG_SLEW;
> +                       else
> +                               value &= ~STARFIVE_PADCFG_SLEW;
> +                       break;
> +               default:
> +                       return -ENOTSUPP;
> +               }
> +       }
> +
> +       for (i = 0; i < group->num_pins; i++)
> +               starfive_padcfg_rmw(sfp, group->pins[i], mask, value);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void starfive_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +                                     struct seq_file *s, unsigned int pin)
> +{
> +       struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       u32 value;
> +       int padcfg_base;
> +
> +       if (!info->starfive_get_padcfg_base)
> +               return;
> +
> +       padcfg_base = info->starfive_get_padcfg_base(sfp, pin);
> +       if (padcfg_base < 0)
> +               return;
> +
> +       value = readl_relaxed(sfp->base + padcfg_base + 4 * pin);
> +       seq_printf(s, " (0x%02x)", value);
> +}
> +#else
> +#define starfive_pinconf_dbg_show NULL
> +#endif
> +
> +static const struct pinconf_ops starfive_pinconf_ops = {
> +       .pin_config_get         = starfive_pinconf_get,
> +       .pin_config_group_get   = starfive_pinconf_group_get,
> +       .pin_config_group_set   = starfive_pinconf_group_set,
> +       .pin_config_dbg_show    = starfive_pinconf_dbg_show,
> +       .is_generic             = true,
> +};
> +
> +static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       return pinctrl_gpio_request(gc->base + gpio);
> +}
> +
> +static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       pinctrl_gpio_free(gc->base + gpio);
> +}
> +
> +static int starfive_gpio_get_direction(struct gpio_chip *gc,
> +                                      unsigned int gpio)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       unsigned int offset = 4 * (gpio / 4);
> +       unsigned int shift  = 8 * (gpio % 4);
> +       u32 doen = readl_relaxed(sfp->base + info->doen_reg_base + offset);
> +
> +       doen = (doen >> shift) & info->doen_mask;
> +
> +       return doen == GPOEN_ENABLE ?
> +               GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int starfive_gpio_direction_input(struct gpio_chip *gc,
> +                                        unsigned int gpio)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +
> +       /* enable input and schmitt trigger */
> +       starfive_padcfg_rmw(sfp, gpio,
> +                           STARFIVE_PADCFG_IE | STARFIVE_PADCFG_SMT,
> +                           STARFIVE_PADCFG_IE | STARFIVE_PADCFG_SMT);
> +
> +       if (info->starfive_set_one_pin_mux)
> +               info->starfive_set_one_pin_mux(sfp, gpio,
> +                               GPI_NONE, GPOUT_LOW, GPOEN_DISABLE, 0);
> +
> +       return 0;
> +}
> +
> +static int starfive_gpio_direction_output(struct gpio_chip *gc,
> +                                         unsigned int gpio, int value)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +
> +       if (info->starfive_set_one_pin_mux)
> +               info->starfive_set_one_pin_mux(sfp, gpio,
> +                               GPI_NONE, value ? GPOUT_HIGH : GPOUT_LOW,
> +                               GPOEN_ENABLE, 0);
> +
> +       /* disable input, schmitt trigger and bias */
> +       starfive_padcfg_rmw(sfp, gpio,
> +                           STARFIVE_PADCFG_IE | STARFIVE_PADCFG_SMT
> +                           | STARFIVE_PADCFG_BIAS, 0);
> +       return 0;
> +}
> +
> +static int starfive_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       void __iomem *reg = sfp->base + info->gpioin_reg_base
> +                       + 4 * (gpio / GPIO_NUM_PER_WORD);
> +
> +       return !!(readl_relaxed(reg) & BIT(gpio % GPIO_NUM_PER_WORD));
> +}
> +
> +static void starfive_gpio_set(struct gpio_chip *gc,
> +                             unsigned int gpio, int value)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       const struct starfive_pinctrl_soc_info *info = sfp->info;
> +       unsigned int offset = 4 * (gpio / 4);
> +       unsigned int shift  = 8 * (gpio % 4);
> +       void __iomem *reg_dout = sfp->base + info->dout_reg_base + offset;
> +       u32 dout = (value ? GPOUT_HIGH : GPOUT_LOW) << shift;
> +       u32 mask = info->dout_mask << shift;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       dout |= readl_relaxed(reg_dout) & ~mask;
> +       writel_relaxed(dout, reg_dout);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static int starfive_gpio_set_config(struct gpio_chip *gc,
> +                                   unsigned int gpio, unsigned long config)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +       u32 arg = pinconf_to_config_argument(config);
> +       u32 value;
> +       u32 mask;
> +
> +       switch (pinconf_to_config_param(config)) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +               mask  = STARFIVE_PADCFG_BIAS;
> +               value = 0;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               if (arg == 0)
> +                       return -ENOTSUPP;
> +               mask  = STARFIVE_PADCFG_BIAS;
> +               value = STARFIVE_PADCFG_PD;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +               if (arg == 0)
> +                       return -ENOTSUPP;
> +               mask  = STARFIVE_PADCFG_BIAS;
> +               value = STARFIVE_PADCFG_PU;
> +               break;
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +               return 0;
> +       case PIN_CONFIG_INPUT_ENABLE:
> +               mask  = STARFIVE_PADCFG_IE;
> +               value = arg ? STARFIVE_PADCFG_IE : 0;
> +               break;
> +       case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +               mask  = STARFIVE_PADCFG_SMT;
> +               value = arg ? STARFIVE_PADCFG_SMT : 0;
> +               break;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +
> +       starfive_padcfg_rmw(sfp, gpio, mask, value);
> +       return 0;
> +}
> +
> +static int starfive_gpio_add_pin_ranges(struct gpio_chip *gc)
> +{
> +       struct starfive_pinctrl *sfp = container_of(gc,
> +                       struct starfive_pinctrl, gc);
> +
> +       sfp->gpios.name = sfp->gc.label;
> +       sfp->gpios.base = sfp->gc.base;
> +       sfp->gpios.pin_base = 0;
> +       sfp->gpios.npins = sfp->gc.ngpio;
> +       sfp->gpios.gc = &sfp->gc;
> +       pinctrl_add_gpio_range(sfp->pctl, &sfp->gpios);
> +       return 0;
> +}
> +
> +static void starfive_irq_ack(struct irq_data *d)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +       const struct starfive_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
> +       irq_hw_number_t gpio = irqd_to_hwirq(d);
> +       void __iomem *ic = sfp->base + irq_reg->ic_reg_base
> +               + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       u32 mask = BIT(gpio % GPIO_NUM_PER_WORD);
> +       unsigned long flags;
> +       u32 value;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       value = readl_relaxed(ic) & ~mask;
> +       writel_relaxed(value, ic);
> +       writel_relaxed(value | mask, ic);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static void starfive_irq_mask(struct irq_data *d)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +       const struct starfive_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
> +       irq_hw_number_t gpio = irqd_to_hwirq(d);
> +       void __iomem *ie = sfp->base + irq_reg->ie_reg_base
> +               + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       u32 mask = BIT(gpio % GPIO_NUM_PER_WORD);
> +       unsigned long flags;
> +       u32 value;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       value = readl_relaxed(ie) & ~mask;
> +       writel_relaxed(value, ie);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +
> +       gpiochip_disable_irq(&sfp->gc, d->hwirq);
> +}
> +
> +static void starfive_irq_mask_ack(struct irq_data *d)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +       const struct starfive_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
> +       irq_hw_number_t gpio = irqd_to_hwirq(d);
> +       void __iomem *ie = sfp->base + irq_reg->ie_reg_base
> +               + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       void __iomem *ic = sfp->base + irq_reg->ic_reg_base
> +               + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       u32 mask = BIT(gpio % GPIO_NUM_PER_WORD);
> +       unsigned long flags;
> +       u32 value;
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       value = readl_relaxed(ie) & ~mask;
> +       writel_relaxed(value, ie);
> +
> +       value = readl_relaxed(ic) & ~mask;
> +       writel_relaxed(value, ic);
> +       writel_relaxed(value | mask, ic);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static void starfive_irq_unmask(struct irq_data *d)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +       const struct starfive_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
> +       irq_hw_number_t gpio = irqd_to_hwirq(d);
> +       void __iomem *ie = sfp->base + irq_reg->ie_reg_base
> +               + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       u32 mask = BIT(gpio % GPIO_NUM_PER_WORD);
> +       unsigned long flags;
> +       u32 value;
> +
> +       gpiochip_enable_irq(&sfp->gc, d->hwirq);
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       value = readl_relaxed(ie) | mask;
> +       writel_relaxed(value, ie);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +}
> +
> +static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +       const struct starfive_gpio_irq_reg *irq_reg = sfp->info->irq_reg;
> +       irq_hw_number_t gpio = irqd_to_hwirq(d);
> +       void __iomem *base = sfp->base + 4 * (gpio / GPIO_NUM_PER_WORD);
> +       u32 mask = BIT(gpio % GPIO_NUM_PER_WORD);
> +       u32 irq_type, edge_both, polarity;
> +       unsigned long flags;
> +
> +       switch (trigger) {
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_type  = mask; /* 1: edge triggered */
> +               edge_both = 0;    /* 0: single edge */
> +               polarity  = mask; /* 1: rising edge */
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               irq_type  = mask; /* 1: edge triggered */
> +               edge_both = 0;    /* 0: single edge */
> +               polarity  = 0;    /* 0: falling edge */
> +               break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               irq_type  = mask; /* 1: edge triggered */
> +               edge_both = mask; /* 1: both edges */
> +               polarity  = 0;    /* 0: ignored */
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               irq_type  = 0;    /* 0: level triggered */
> +               edge_both = 0;    /* 0: ignored */
> +               polarity  = mask; /* 1: high level */
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               irq_type  = 0;    /* 0: level triggered */
> +               edge_both = 0;    /* 0: ignored */
> +               polarity  = 0;    /* 0: low level */
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (trigger & IRQ_TYPE_EDGE_BOTH)
> +               irq_set_handler_locked(d, handle_edge_irq);
> +       else
> +               irq_set_handler_locked(d, handle_level_irq);
> +
> +       raw_spin_lock_irqsave(&sfp->lock, flags);
> +       irq_type |= readl_relaxed(base + irq_reg->is_reg_base) & ~mask;
> +       writel_relaxed(irq_type, base + irq_reg->is_reg_base);
> +
> +       edge_both |= readl_relaxed(base + irq_reg->ibe_reg_base) & ~mask;
> +       writel_relaxed(edge_both, base + irq_reg->ibe_reg_base);
> +
> +       polarity |= readl_relaxed(base + irq_reg->iev_reg_base) & ~mask;
> +       writel_relaxed(polarity, base + irq_reg->iev_reg_base);
> +       raw_spin_unlock_irqrestore(&sfp->lock, flags);
> +       return 0;
> +}
> +
> +static struct irq_chip starfive_irq_chip = {
> +       .irq_ack      = starfive_irq_ack,
> +       .irq_mask     = starfive_irq_mask,
> +       .irq_mask_ack = starfive_irq_mask_ack,
> +       .irq_unmask   = starfive_irq_unmask,
> +       .irq_set_type = starfive_irq_set_type,
> +       .flags        = IRQCHIP_IMMUTABLE | IRQCHIP_SET_TYPE_MASKED,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static void starfive_disable_clock(void *data)
> +{
> +       clk_disable_unprepare(data);
> +}
> +
> +int starfive_pinctrl_probe(struct platform_device *pdev,
> +                          const struct starfive_pinctrl_soc_info *info)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct starfive_pinctrl *sfp;
> +       struct pinctrl_desc *starfive_pinctrl_desc;
> +       struct reset_control *rst;
> +       struct clk *clk;
> +       int ret;
> +
> +       if (!info || !info->pins || !info->npins) {
> +               dev_err(dev, "wrong pinctrl info\n");
> +               return -EINVAL;
> +       }
> +
> +       sfp = devm_kzalloc(dev, sizeof(*sfp), GFP_KERNEL);
> +       if (!sfp)
> +               return -ENOMEM;
> +
> +       sfp->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(sfp->base))
> +               return PTR_ERR(sfp->base);
> +
> +       clk = devm_clk_get_optional(dev, NULL);
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk), "could not get clock\n");
> +
> +       rst = devm_reset_control_get_exclusive(dev, NULL);
> +       if (IS_ERR(rst))
> +               return dev_err_probe(dev, PTR_ERR(rst), "could not get reset\n");
> +
> +       /*
> +        * we don't want to assert reset and risk undoing pin muxing for the
> +        * early boot serial console, but let's make sure the reset line is
> +        * deasserted in case someone runs a really minimal bootloader.
> +        */
> +       ret = reset_control_deassert(rst);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "could not deassert reset\n");
> +
> +       if (clk) {
> +               ret = clk_prepare_enable(clk);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "could not enable clock\n");
> +
> +               ret = devm_add_action_or_reset(dev, starfive_disable_clock, clk);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       starfive_pinctrl_desc = devm_kzalloc(&pdev->dev,
> +                                            sizeof(*starfive_pinctrl_desc),
> +                                                   GFP_KERNEL);
> +       if (!starfive_pinctrl_desc)
> +               return -ENOMEM;
> +
> +       starfive_pinctrl_desc->name = dev_name(dev);
> +       starfive_pinctrl_desc->pins = info->pins;
> +       starfive_pinctrl_desc->npins = info->npins;
> +       starfive_pinctrl_desc->pctlops = &starfive_pinctrl_ops;
> +       starfive_pinctrl_desc->pmxops = &starfive_pinmux_ops;
> +       starfive_pinctrl_desc->confops = &starfive_pinconf_ops;
> +       starfive_pinctrl_desc->owner = THIS_MODULE;
> +
> +       sfp->info = info;
> +       sfp->dev = dev;
> +       platform_set_drvdata(pdev, sfp);
> +       sfp->gc.parent = dev;
> +       raw_spin_lock_init(&sfp->lock);
> +       mutex_init(&sfp->mutex);
> +
> +       ret = devm_pinctrl_register_and_init(dev,
> +                                            starfive_pinctrl_desc,
> +                                            sfp, &sfp->pctl);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                               "could not register pinctrl driver\n");
> +
> +       sfp->gc.label = dev_name(dev);
> +       sfp->gc.owner = THIS_MODULE;
> +       sfp->gc.request = starfive_gpio_request;
> +       sfp->gc.free = starfive_gpio_free;
> +       sfp->gc.get_direction = starfive_gpio_get_direction;
> +       sfp->gc.direction_input = starfive_gpio_direction_input;
> +       sfp->gc.direction_output = starfive_gpio_direction_output;
> +       sfp->gc.get = starfive_gpio_get;
> +       sfp->gc.set = starfive_gpio_set;
> +       sfp->gc.set_config = starfive_gpio_set_config;
> +       sfp->gc.add_pin_ranges = starfive_gpio_add_pin_ranges;
> +       sfp->gc.base = info->gc_base;
> +       sfp->gc.ngpio = info->ngpios;
> +
> +       starfive_irq_chip.name = sfp->gc.label;
> +       gpio_irq_chip_set_chip(&sfp->gc.irq, &starfive_irq_chip);
> +       sfp->gc.irq.parent_handler = info->starfive_gpio_irq_handler;
> +       sfp->gc.irq.num_parents = 1;
> +       sfp->gc.irq.parents = devm_kcalloc(dev, sfp->gc.irq.num_parents,
> +                                          sizeof(*sfp->gc.irq.parents),
> +                                          GFP_KERNEL);
> +       if (!sfp->gc.irq.parents)
> +               return -ENOMEM;
> +       sfp->gc.irq.default_type = IRQ_TYPE_NONE;
> +       sfp->gc.irq.handler = handle_bad_irq;
> +       sfp->gc.irq.init_hw = info->starfive_gpio_init_hw;
> +
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return ret;
> +       sfp->gc.irq.parents[0] = ret;
> +
> +       ret = devm_gpiochip_add_data(dev, &sfp->gc, sfp);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "could not register gpiochip\n");
> +
> +       irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
> +
> +       dev_info(dev, "StarFive GPIO chip registered %d GPIOs\n", sfp->gc.ngpio);
> +
> +       return pinctrl_enable(sfp->pctl);
> +}
> +
> +MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH7110 SoC");
> +MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
> +MODULE_AUTHOR("Jianlong Huang <jianlong.huang@starfivetech.com>");
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.h b/drivers/pinctrl/starfive/pinctrl-starfive.h
> new file mode 100644
> index 000000000000..54ffdb6412f1
> --- /dev/null
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Pinctrl / GPIO driver for StarFive JH7110 SoC
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef __DRIVERS_PINCTRL_STARFIVE_H__
> +#define __DRIVERS_PINCTRL_STARFIVE_H__
> +
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +struct starfive_pinctrl {
> +       struct device *dev;
> +       struct gpio_chip gc;
> +       struct pinctrl_gpio_range gpios;
> +       raw_spinlock_t lock;
> +       void __iomem *base;
> +       struct pinctrl_dev *pctl;
> +       /* register read/write mutex */
> +       struct mutex mutex;
> +       const struct starfive_pinctrl_soc_info *info;
> +};
> +
> +struct starfive_gpio_irq_reg {
> +       unsigned int is_reg_base;
> +       unsigned int ic_reg_base;
> +       unsigned int ibe_reg_base;
> +       unsigned int iev_reg_base;
> +       unsigned int ie_reg_base;
> +       unsigned int ris_reg_base;
> +       unsigned int mis_reg_base;
> +};
> +
> +struct starfive_pinctrl_soc_info {
> +       const struct pinctrl_pin_desc *pins;
> +       unsigned int npins;
> +       unsigned int ngpios;
> +       unsigned int gc_base;
> +       unsigned int flags;

The flag member seems unused. Please drop.

> +       /* gpio dout/doen/din/gpioinput register */
> +       unsigned int dout_reg_base;
> +       unsigned int dout_mask;
> +       unsigned int doen_reg_base;
> +       unsigned int doen_mask;
> +       unsigned int gpi_reg_base;
> +       unsigned int gpi_mask;
> +       unsigned int gpioin_reg_base;
> +
> +       const struct starfive_gpio_irq_reg *irq_reg;
> +
> +       /* generic pinmux */
> +       int (*starfive_set_one_pin_mux)(struct starfive_pinctrl *sfp,
> +                                       unsigned int pin,
> +                                       unsigned int din, u32 dout,
> +                                       u32 doen, u32 func);
> +       /* gpio chip */
> +       int (*starfive_get_padcfg_base)(struct starfive_pinctrl *sfp,
> +                                       unsigned int pin);
> +       void (*starfive_gpio_irq_handler)(struct irq_desc *desc);
> +       int (*starfive_gpio_init_hw)(struct gpio_chip *gc);
> +};
> +
> +void starfive_set_gpiomux(struct starfive_pinctrl *sfp, unsigned int pin,
> +                         unsigned int din, u32 dout, u32 doen);
> +int starfive_pinctrl_probe(struct platform_device *pdev,
> +                          const struct starfive_pinctrl_soc_info *info);
> +struct starfive_pinctrl *starfive_from_irq_desc(struct irq_desc *desc);
> +
> +#endif /* __DRIVERS_PINCTRL_STARFIVE_H__ */
> --
> 2.38.1
>
