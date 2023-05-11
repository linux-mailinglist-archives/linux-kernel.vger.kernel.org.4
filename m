Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2136FE8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEKAmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjEKAmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:42:37 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E15E42;
        Wed, 10 May 2023 17:42:36 -0700 (PDT)
Date:   Thu, 11 May 2023 08:42:31 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] riscv: dts: thead: add sipeed Lichee Pi 4A board
 device tree
Message-ID: <ZFw59xlxoCSyb--J@ofant>
References: <20230510204456.57202-1-frank.li@vivo.com>
 <20230510204456.57202-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510204456.57202-3-frank.li@vivo.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao:

On 04:44 Thu 11 May     , Yangtao Li wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
> minimal device tree files for the core module and the development
> board.
> 
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
> 
> Cc: Icenowy Zheng <uwu@icenowy.me>
> Cc: Wei Fu <wefu@redhat.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -cleanup `light`
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/thead/Makefile            |  2 +
>  .../dts/thead/th1520-lichee-module-4a.dtsi    | 39 +++++++++++++++++++
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 33 ++++++++++++++++
>  4 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f0d9f89054f8..1e884868ccba 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,6 +2,7 @@
>  subdir-y += allwinner
>  subdir-y += sifive
>  subdir-y += starfive
> +subdir-y += thead
>  subdir-y += canaan
>  subdir-y += microchip
>  subdir-y += renesas
> diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/thead/Makefile
> new file mode 100644
> index 000000000000..e311fc9a5939
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> new file mode 100644
> index 000000000000..bc5f8677d546
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "th1520.dtsi"
> +
> +/ {
> +	model = "Sipeed Lichee Module 4A";
> +	compatible = "sipeed,lichee-module-4a", "thead,th1520";
we should have these compatibles documented, so a DT-Binding should go first

> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x2 0x00000000>;
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <24000000>;
> +};
> +
> +&osc_32k {
> +	clock-frequency = <32768>;
> +};
> +
> +&apb_clk {
> +	clock-frequency = <62500000>;
> +};
> +
> +&uart_sclk {
> +	clock-frequency = <100000000>;
> +};
for all the above clock-frequency, if it's a real fixed one - so should all hardware
be the same? then probably moving them to th1520.dtsi would be better?

> +
> +&dmac0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> new file mode 100644
> index 000000000000..86d677175feb
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
> + */
> +
> +#include "th1520-lichee-module-4a.dtsi"
> +
> +/ {
> +	model = "Sipeed Lichee Pi 4A";
> +	compatible = "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead,th1520";
ditto

> +
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
