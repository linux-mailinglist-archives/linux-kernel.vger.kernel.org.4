Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B17D69E300
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjBUPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjBUPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:03:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFFFD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:03:27 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 492B23F71C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676991806;
        bh=X/mzpDBLu5Cirwbxmvc9vBOwAaTmB1dijULzrWfVudE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eKIIEwY3KAvLalCz0nQxiO3P2KpoaKMARZhpyMhY353TDThyk7Y0VWljgXI/Az93n
         k5E/UO8CMNEZcWBgNGLaf8UTESrs7JZupWSUsjH2gLzOFmnjX4vHxNNON9Le2P81HB
         wh5sMrc9Z8ekfIPG8P0bYMYfwQ39+ifdGb0Gd3VSj17TfoEtWq8TNugTCn1KMgxqtL
         7UY43xZIi2vPLieNgskvpYfmIIriM1CxAXu0eZUe4jMAuUt37mo7fFS+F5HHUZAdQE
         MTH9XkMABjAB7/ifMwHDGUPYJ+Xu4ICWLTAJice19XkqSo7XJo20InPDb84Fy0IywJ
         ykZGeAklGeNtg==
Received: by mail-qt1-f198.google.com with SMTP id k17-20020ac84751000000b003b9b4ec27c4so1722077qtp.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/mzpDBLu5Cirwbxmvc9vBOwAaTmB1dijULzrWfVudE=;
        b=4Y0mKcRPMqEpEU5fIY2nuIfc4iKWqwNTDTC2tnTzZAkwhn+d7YuvTupH5ebH06/LrF
         RLM+QHoJKpunZPIrEeR9q5KW16bMlb9zXHQgmPzrNMTNuzM1deHdbtZGqL4eHuK87r6R
         bs3qEbGgABZ2hDLgFayjlDSVRuA810EEvP3DYDnT6iJ9NgNxVd9Ub/ZOb/5GAUEjsEpz
         MAj7Nv9Q4PYllQlACliiSo4JsYAT309nqyIT2HWRmmWsCjy1nxZmlSRq0nszjTEzh0zn
         GZ3GEtpaxga2EUsthjeFrV3cD70YKIvE/Ly5boOc/lJBBFhFMlwL+OmYqRqlT3asXrUu
         TCtA==
X-Gm-Message-State: AO0yUKUQERWpvFa0H+Mm796fy+8kmOkeEL0O0DnDFXghXsrycKiG7oum
        EiLJqdsPKOJfZ//d1MNTyrcqkDM7zOt9obhGz7ugsYZ89boViBbVuCzWSSGrebykk7mbpwyoyo0
        uCOWZs8zwkMFB5bVCrX+yt5t4Z+bbmigA3aQ2/ENgXDoR84A4VSxX5Z89Ew==
X-Received: by 2002:a05:6214:4c06:b0:537:7476:41f7 with SMTP id qh6-20020a0562144c0600b00537747641f7mr489815qvb.3.1676991805133;
        Tue, 21 Feb 2023 07:03:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8tdVC/CvHcq+B16ppA2OxmMPd0WLiKNwYp4nhRXa62HYo33dKV6a5JgCIulRThDvWu4redVfoA4NUjnXW3XJg=
X-Received: by 2002:a05:6214:4c06:b0:537:7476:41f7 with SMTP id
 qh6-20020a0562144c0600b00537747641f7mr489800qvb.3.1676991804577; Tue, 21 Feb
 2023 07:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20230221024645.127922-1-hal.feng@starfivetech.com> <20230221024645.127922-20-hal.feng@starfivetech.com>
In-Reply-To: <20230221024645.127922-20-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 21 Feb 2023 16:03:08 +0100
Message-ID: <CAJM55Z_QMtzKeRFN1iGf498z4+vga6RBgwybCQi6aOUYCr_P-Q@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
> which has version A and version B. Support booting and basic
> clock/reset/pinctrl/uart drivers.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   6 +-
>  .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 ++
>  .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 ++
>  .../jh7110-starfive-visionfive-2.dtsi         | 215 ++++++++++++++++++
>  4 files changed, 246 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 039c143cba33..cd73519b907b 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,2 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb jh7100-starfive-visionfive-v1.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
> +
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
> new file mode 100644
> index 000000000000..4af3300f3cf3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2.dtsi"
> +
> +/ {
> +       model = "StarFive VisionFive 2 v1.2A";
> +       compatible = "starfive,visionfive-2-v1.2a", "starfive,jh7110";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
> new file mode 100644
> index 000000000000..9230cc3d8946
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2.dtsi"
> +
> +/ {
> +       model = "StarFive VisionFive 2 v1.3B";
> +       compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> new file mode 100644
> index 000000000000..c2aa8946a0f1
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include "jh7110-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +               i2c0 = &i2c0;
> +               i2c2 = &i2c2;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;

Let's keep these sorted alphabetically.

> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
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
> +               gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> +               priority = <224>;
> +       };
> +};
> +
> +&osc {
> +       clock-frequency = <24000000>;
> +};
> +
> +&rtc_osc {
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
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins>;
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       clock-frequency = <100000>;
> +       i2c-sda-hold-time-ns = <300>;
> +       i2c-sda-falling-time-ns = <510>;
> +       i2c-scl-falling-time-ns = <510>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c0_pins>;
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       clock-frequency = <100000>;
> +       i2c-sda-hold-time-ns = <300>;
> +       i2c-sda-falling-time-ns = <510>;
> +       i2c-scl-falling-time-ns = <510>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c2_pins>;
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       clock-frequency = <100000>;
> +       i2c-sda-hold-time-ns = <300>;
> +       i2c-sda-falling-time-ns = <510>;
> +       i2c-scl-falling-time-ns = <510>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c5_pins>;
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       clock-frequency = <100000>;
> +       i2c-sda-hold-time-ns = <300>;
> +       i2c-sda-falling-time-ns = <510>;
> +       i2c-scl-falling-time-ns = <510>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c6_pins>;
> +       status = "okay";
> +};
> +
> +&sysgpio {
> +       uart0_pins: uart0-0 {
> +               tx-pins {
> +                       pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> +                                            GPOEN_ENABLE,
> +                                            GPI_NONE)>;
> +                       bias-disable;
> +                       drive-strength = <12>;
> +                       input-disable;
> +                       input-schmitt-disable;
> +                       slew-rate = <0>;
> +               };
> +
> +               rx-pins {
> +                       pinmux = <GPIOMUX(6, GPOUT_LOW,
> +                                            GPOEN_DISABLE,
> +                                            GPI_SYS_UART0_RX)>;
> +                       bias-disable; /* external pull-up */
> +                       drive-strength = <2>;
> +                       input-enable;
> +                       input-schmitt-enable;
> +                       slew-rate = <0>;
> +               };
> +       };
> +
> +       i2c0_pins: i2c0-0 {
> +               i2c-pins {
> +                       pinmux = <GPIOMUX(57, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C0_CLK,
> +                                             GPI_SYS_I2C0_CLK)>,
> +                                <GPIOMUX(58, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C0_DATA,
> +                                             GPI_SYS_I2C0_DATA)>;
> +                       bias-disable; /* external pull-up */
> +                       input-enable;
> +                       input-schmitt-enable;
> +               };
> +       };
> +
> +       i2c2_pins: i2c2-0 {
> +               i2c-pins {
> +                       pinmux = <GPIOMUX(3, GPOUT_LOW,
> +                                            GPOEN_SYS_I2C2_CLK,
> +                                            GPI_SYS_I2C2_CLK)>,
> +                                <GPIOMUX(2, GPOUT_LOW,
> +                                            GPOEN_SYS_I2C2_DATA,
> +                                            GPI_SYS_I2C2_DATA)>;
> +                       bias-disable; /* external pull-up */
> +                       input-enable;
> +                       input-schmitt-enable;
> +               };
> +       };
> +
> +       i2c5_pins: i2c5-0 {
> +               i2c-pins {
> +                       pinmux = <GPIOMUX(19, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C5_CLK,
> +                                             GPI_SYS_I2C5_CLK)>,
> +                                <GPIOMUX(20, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C5_DATA,
> +                                             GPI_SYS_I2C5_DATA)>;
> +                       bias-disable; /* external pull-up */
> +                       input-enable;
> +                       input-schmitt-enable;
> +               };
> +       };
> +
> +       i2c6_pins: i2c6-0 {
> +               i2c-pins {
> +                       pinmux = <GPIOMUX(16, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C6_CLK,
> +                                             GPI_SYS_I2C6_CLK)>,
> +                                <GPIOMUX(17, GPOUT_LOW,
> +                                             GPOEN_SYS_I2C6_DATA,
> +                                             GPI_SYS_I2C6_DATA)>;
> +                       bias-disable; /* external pull-up */
> +                       input-enable;
> +                       input-schmitt-enable;
> +               };
> +       };
> +};

It would be great to have some sort of order to this file so it's
obvious where to add new nodes. I suggest we do
- root node
- external clocks
- other node references in alphabetical order

You're almost there with this patch except the uart0 node is out of place.

/Emil

> 2.38.1
>
