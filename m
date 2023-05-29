Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC1714D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjE2Pzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjE2Pzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:55:41 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48CBD9;
        Mon, 29 May 2023 08:55:39 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 1161241D13A7;
        Mon, 29 May 2023 16:55:38 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Mon, 29 May 2023 16:55:38 +0100
Date:   Mon, 29 May 2023 16:55:38 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Message-ID: <ZHTK+qG0xBWfn9gt@bart.dudau.co.uk>
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-2-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529150833.526084-2-liviu@dudau.co.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 04:08:32PM +0100, Liviu Dudau wrote:
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
> connected to the main SoC over PCIe.
> 
> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
> improve routing bandwidth.
> 
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>  arch/mips/boot/dts/ralink/Makefile            |   3 +-
>  .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 129 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> 
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> index 11732b8c8163a..d27d7e8c700fe 100644
> --- a/arch/mips/boot/dts/ralink/Makefile
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>  
>  dtb-$(CONFIG_SOC_MT7621) += \
>  	mt7621-gnubee-gb-pc1.dtb \
> -	mt7621-gnubee-gb-pc2.dtb
> +	mt7621-gnubee-gb-pc2.dtb \
> +	mt7621-tplink-hc220-g5-v1.dtb
>  
>  obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> new file mode 100644
> index 0000000000000..f003ae615a58e
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/dts-v1/;
> +
> +#include "mt7621.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
> +	model = "TP-Link HC220 G5 v1";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x8000000>;
> +	};
> +
> +	chosen {
> +		/* add 'earlycon=uart8260,mmio32,0x1e000c00' to
> +		 * bootargs for early boot messages
> +		 */
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-reset {
> +			label = "reset";
> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RESTART>;
> +		};
> +
> +		key-wps {
> +			label = "wps";
> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WPS_BUTTON>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WPS;
> +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	resetc: reset-controller {
> +		compatible = "ralink,rt2880-reset";
> +		#reset-cells = <1>;
> +	};
> +
> +	mtd {
> +		compatible = "mediatek,mt7622-nfc";
> +	};
> +};
> +
> +&i2c {
> +	status = "okay";
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +/* gmac1 connected to MT7530's phy0 */
> +&gmac1 {
> +	phy-handle = <&ethphy0>;
> +
> +	fixed-link {
> +		status = "disabled";
> +	};
> +};
> +
> +&mdio {
> +	/* MT7530's phy0 */
> +	ethphy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&switch0 {
> +	ports {
> +		/* phy0 is muxed to gmac1 */
> +		port@0 {
> +			status = "okay";
> +			label = "lan2";
> +		};

I've made the changes to look similar to the gnubee-gb-pc2, and things mostly
work, with the exception that I can mount an NFS root filesystem only on "lan2"
interface at boot time. All other interfaces (ports) hang forever waiting for
an DHCP response from my server. The only difference is where I plug in the
ethernet cable, no other change (not even a restart) on the server.

Best regards,
Liviu

> +
> +		port@1 {
> +			status = "okay";
> +			label = "lan1";
> +		};
> +
> +		port@2 {
> +			status = "okay";
> +			label = "wan";
> +		};
> +	};
> +};
> -- 
> 2.40.1
> 

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
