Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B010360B5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJXSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiJXSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02E6144089;
        Mon, 24 Oct 2022 10:25:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBAC4D6E;
        Mon, 24 Oct 2022 07:56:49 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75B83F792;
        Mon, 24 Oct 2022 07:56:41 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:56:39 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 10/10] ARM: dts: suniv: add device tree for PopStick
 v1.1
Message-ID: <20221024155639.5e97d205@donnerap.cambridge.arm.com>
In-Reply-To: <20221012055602.1544944-11-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
        <20221012055602.1544944-11-uwu@icenowy.me>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 13:56:02 +0800
Icenowy Zheng <uwu@icenowy.me> wrote:

Hi,

> PopStick is a minimal Allwinner F1C200s dongle, with its USB controller
> wired to a USB Type-A port, a SD slot and a SPI NAND flash on board, and
> an on-board CH340 USB-UART converted connected to F1C200s's UART0.
> 
> Add a device tree for it. As F1C200s is just F1C100s with a different
> DRAM chip co-packaged, directly use F1C100s DTSI here.
> 
> This commit covers the v1.1 version of this board, which is now shipped.
> v1.0 is some internal sample that have not been shipped at all.

As mentioned in the other patch, if that is the case, I don't think we
need to bother about the version number in the filename and compatible
strings, especially if a v1.0 will never be upstreamed. If there are users
of the internal version still, they can use an explicit "v1.0" in their
downstream versions.

So apart from what Krzysztof and Clement already mentioned, the DT itself
looks fine to me otherwise. I also ran dt-validate on it, and used it as a
base for another F1C200s board.

Cheers,
Andre

> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> New patch introduced in v2.
> 
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  .../boot/dts/suniv-f1c200s-popstick-v1.1.dts  | 101 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6aa7dc4db2fc..0249c07bd8a6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1391,7 +1391,8 @@ dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
>  dtb-$(CONFIG_MACH_SUNIV) += \
> -	suniv-f1c100s-licheepi-nano.dtb
> +	suniv-f1c100s-licheepi-nano.dtb \
> +	suniv-f1c200s-popstick-v1.1.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>  	tegra20-acer-a500-picasso.dtb \
>  	tegra20-asus-tf101.dtb \
> diff --git a/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts b/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
> new file mode 100644
> index 000000000000..121dfc6f609d
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
> + */
> +
> +/dts-v1/;
> +#include "suniv-f1c100s.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Popcorn Computer PopStick v1.1";
> +	compatible = "sourceparts,popstick-v1.1", "sourceparts,popstick",
> +		     "allwinner,suniv-f1c200s", "allwinner,suniv-f1c100s";
> +
> +	aliases {
> +		mmc0 = &mmc0;
> +		serial0 = &uart0;
> +		spi0 = &spi0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 4 6 GPIO_ACTIVE_HIGH>; /* PE6 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&mmc0 {
> +	cd-gpios = <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
> +	bus-width = <4>;
> +	disable-wp;
> +	status = "okay";
> +	vmmc-supply = <&reg_vcc3v3>;
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pc_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "u-boot-with-spl";
> +				reg = <0x0 0x100000>;
> +			};
> +
> +			ubi@100000 {
> +				label = "ubi";
> +				reg = <0x100000 0x7f00000>;
> +			};
> +		};
> +	};
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pe_pins>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	status = "okay";
> +};

