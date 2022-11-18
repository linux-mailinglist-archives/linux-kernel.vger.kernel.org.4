Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17C62FC12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiKRR4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiKRR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:56:07 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86672096
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:56:00 -0800 (PST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDDA23F336
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668794158;
        bh=0Yx4LwoxGO4gELBT8j84eKvAZSVRQJCcfAAZoOkW6xo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=j+GiyBsTSATY7xfWcWAW9gpYqlcCrKzLUWrwDdoIQJ4Jtb6W/Tvtl71sl1hJ/Sg4s
         7OpKSJod/CAbAgoNWO6ddIlOS5l92aF3Ljm6HR9o4Snyn0BzeHcqvPE2NMmxpjQ1DP
         8sKX8p4DxVN0gNnQTNKwtYYjV/VahccJQAd6PHaIoUNlWcIsnXjbzrhz7evWHGBLPq
         /xac+bOLfRm/LZaT/sMrriIRNzfE6yUKJkmIJc1Mb2iMDx4AKPZuTUpnAhzQvj6rtT
         Z0cYyslILF6842sMea1Ii1lRow6ShXx8jLp7etbAw5/GjiC9oAZiiK8t8zpHgPLRUf
         FOFHK5NCGNt0g==
Received: by mail-yb1-f197.google.com with SMTP id y82-20020a253255000000b006e7a04f3824so4294210yby.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Yx4LwoxGO4gELBT8j84eKvAZSVRQJCcfAAZoOkW6xo=;
        b=uwZWIAq2Z/FYdJqQhG68/K/c2hFGcOSR9PsVKkK9hnI2FEy4JncYvOjXgG7tUmU185
         1MGt0NEwWJn29peAh+eOSAMFUwyNsCnYTrCjiA25Ih3tloCSa0/14/ViuiGs2G96jkOy
         qn6aa8+i7tpsdGif5XIph7cSNEa387dGI+bR/zImcDY/AsFgz9pqWjU7ZumA1yKfrj0+
         4SvUQOpFh5u+8Btq7U+qb2lHmbepmErT3dJIxVEgxpPEQ7aOBHLYQu36M42PeZ1hGEvh
         p24TSOLRcLFn1ic0913RNHDbVOqTjPRDsr9tHVtYNe5p+wYEIdMH8AhNFpi65rkBlejv
         uTXg==
X-Gm-Message-State: ANoB5pnN/BKu0Q1sSMgErrdCz18fB90Hteztlxf3PygDRZ10tX50OGiW
        jXT7nInSIlddZjKcrsyBAJ9dXBnZsryU4izcvhgGh2C3W7I6deVTbc7y58mcFQKfV4/AUFgPl0Y
        QTGbGpvoJYWcp5xdkCzUgOrNvv6HrRYvc04auTXrcYgT7MVwwWE0+S9vI+g==
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id r11-20020a819a0b000000b0037002d3c361mr7429929ywg.251.1668794157275;
        Fri, 18 Nov 2022 09:55:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4X/I6qvXUaj8j659xYAf6Xh78fhOeaJMLEVRA7IEhZ0OhKSxtwJeWXI961OdXwiSzv2eekCAOkOn6eBdnAOrs=
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id
 r11-20020a819a0b000000b0037002d3c361mr7429904ywg.251.1668794157042; Fri, 18
 Nov 2022 09:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com> <20221118011714.70877-8-hal.feng@starfivetech.com>
In-Reply-To: <20221118011714.70877-8-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 18:55:40 +0100
Message-ID: <CAJM55Z-rdicV69otq=YFsTSUNsg==Svf18b+3w-cMfb_BYcbGg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] riscv: dts: starfive: Add StarFive JH7110
 VisionFive2 board device tree
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add a minimal device tree for StarFive JH7110 VisionFive2 board.
Missing space between VisionFive and 2.

> Support booting and basic clock/reset/pinctrl/uart drivers.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  .../jh7110-starfive-visionfive-v2.dts         | 116 ++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 0ea1bc15ab30..e1237dbc6aac 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-v2.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> new file mode 100644
> index 000000000000..c8946cf3a268
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +/ {
> +       model = "StarFive VisionFive V2";
> +       compatible = "starfive,visionfive-v2", "starfive,jh7110";

Again, please consult your colleagues if you're calling the board
"VisionFive 2" or "VisionFive V2" and name the file, model and board
accordingly.

> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               linux,initrd-start = <0x46100000>;
> +               linux,initrd-end = <0x4c000000>;

These two lines don't belong here. They're added by the bootloader dynamically.

> +               stdout-path = "serial0:115200";

You're missing a n8.

> +       };
> +
> +       cpus {
> +               timebase-frequency = <4000000>;
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x40000000 0x1 0x0>;
> +       };
> +
> +       gpio-restart {
> +               compatible = "gpio-restart";
> +               gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
> +               priority = <224>;
> +       };
> +};
> +
> +&osc {
> +       clock-frequency = <24000000>;
> +};
> +
> +&clk_rtc {
> +       clock-frequency = <32768>;
> +};
> +
> +&gmac0_rmii_refin {
> +       clock-frequency = <50000000>;
> +};
> +
> +&gmac0_rgmii_rxin {
> +       clock-frequency = <125000000>;
> +};
> +
> +&gmac1_rmii_refin {
> +       clock-frequency = <50000000>;
> +};
> +
> +&gmac1_rgmii_rxin {
> +       clock-frequency = <125000000>;
> +};
> +
> +&i2stx_bclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&i2stx_lrck_ext {
> +       clock-frequency = <192000>;
> +};
> +
> +&i2srx_bclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&i2srx_lrck_ext {
> +       clock-frequency = <192000>;
> +};
> +
> +&tdm_ext {
> +       clock-frequency = <49152000>;
> +};
> +
> +&mclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&gpio {
> +       uart0_pins: uart0-0 {
> +               tx-pins {
> +                       pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;
> +                       bias-disable;
> +                       drive-strength = <12>;
> +                       input-disable;
> +                       input-schmitt-disable;
> +                       slew-rate = <0>;
> +               };
> +
> +               rx-pins {
> +                       pinmux = <GPIOMUX(6, GPOUT_LOW, GPOEN_DISABLE, GPI_SYS_UART0_RX)>;
> +                       bias-pull-up;

There are external pull-ups, so maybe change this line to

bias-disable; /* external pull-up */

> +                       drive-strength = <2>;
> +                       input-enable;
> +                       input-schmitt-enable;
> +                       slew-rate = <0>;
> +               };
> +       };
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins>;
> +       status = "okay";
> +};
> --
> 2.38.1
>
