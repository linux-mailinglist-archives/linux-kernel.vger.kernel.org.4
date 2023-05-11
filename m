Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21366FF6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjEKQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjEKQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:03:23 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB7E82683;
        Thu, 11 May 2023 09:03:20 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id F2CB441D13BF;
        Thu, 11 May 2023 17:03:18 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 11 May 2023 17:03:18 +0100
Date:   Thu, 11 May 2023 17:03:18 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mips: dts: ralink: Add support for TP-Link HC220 G5 v1
 board.
Message-ID: <ZF0RxoLRyl78s8sf@bart.dudau.co.uk>
References: <20230509200125.309026-1-liviu@dudau.co.uk>
 <43301707-8763-2a9f-956d-1ea0ae004a56@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43301707-8763-2a9f-956d-1ea0ae004a56@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 03:41:30PM +0200, Arınç ÜNAL wrote:
> On 9.05.2023 22:01, Liviu Dudau wrote:
> > This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> > a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
> > connected to the main SoC over PCIe.
> > 
> > The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
> > improve routing bandwidth.
> > 
> > The device uses NMBM over NAND, which is not currently supported in the
> > mainline, so NAND node is skipped in this revision.
> > 
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> 
> This is great to see. I'm going to mainline all the MT7621 devicetrees on
> OpenWrt at some point, this is a good step for this.

AFAIK this board is not supported by OpenWrt at all. So the flow will be
the other way this time :)

> 
> > ---
> >   arch/mips/boot/dts/ralink/Makefile            |   3 +-
> >   .../dts/ralink/mt7621-tplink-hc220_g5.dts     | 126 ++++++++++++++++++
> >   2 files changed, 128 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> > 
> > diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> > index 11732b8c8163a..c57a2b40876b4 100644
> > --- a/arch/mips/boot/dts/ralink/Makefile
> > +++ b/arch/mips/boot/dts/ralink/Makefile
> > @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
> >   dtb-$(CONFIG_SOC_MT7621) += \
> >   	mt7621-gnubee-gb-pc1.dtb \
> > -	mt7621-gnubee-gb-pc2.dtb
> > +	mt7621-gnubee-gb-pc2.dtb \
> > +	mt7621-tplink-hc220_g5.dtb
> >   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> > diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> > new file mode 100644
> > index 0000000000000..83d15711907d0
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/dts-v1/;
> > +
> > +#include "mt7621.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +	compatible = "tplink,hc220-g5", "mediatek,mt7621-soc";
> 
> tplink,hc220-g5-v1 should fit better. Also please make another patch to add
> the compatible string under Boards with Mediatek/Ralink MT7621 SoC on
> Documentation/devicetree/bindings/mips/ralink.yaml.

Will do another patch with the documentation update. I will also send a v2
incorporating all your review comments, thanks for taking the time!

Regarding the full name: I'm quite tempted to drop the v1(.0) entirely as I'm
not really sure that TP-Link will release another board. Doing a search now
I fail to find on any TP-Link results the mention of the version.

> 
> > +	model = "TP-Link HC220 G5 v1.0";
> 
> "TP-Link HC220 G5 v1" should be enough.
> 
> > +
> > +	memory@0 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x0 0x0 0x8000000>;
> > +	};
> > +
> > +	chosen {
> > +		/* bootargs = "earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0 kgdboc=ttyS0,115200 ip=192.168.88.1:192.168.88.2:::hc220:eth1:none kgdbcon console=ttyS0,115200"; */
> > +		/* bootargs = "console=ttyS0,115200 earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0"; */
> > +		bootargs = "console=ttyS0,115200 root=/dev/nfs ip=192.168.88.2:192.168.88.5::255.255.255.0:hc220_g5:eth1:none nfsroot=192.168.88.5:/mips,vers=4,sec=sys ro rootwait";
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +
> > +		key-reset {
> > +			label = "reset";
> > +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_RESTART>;
> > +		};
> > +
> > +		key-wps {
> > +			label = "wps";
> > +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_WPS_BUTTON>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		red {
> > +			color = <LED_COLOR_ID_RED>;
> > +			function = LED_FUNCTION_FAULT;
> > +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		green {
> > +			color = <LED_COLOR_ID_GREEN>;
> > +			function = LED_FUNCTION_POWER;
> > +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "default-on";
> > +		};
> > +
> > +		blue {
> > +			color = <LED_COLOR_ID_BLUE>;
> > +			function = LED_FUNCTION_WPS;
> > +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> > +		};
> > +	};
> > +
> > +	resetc: reset-controller {
> > +		compatible = "ralink,rt2880-reset";
> > +		#reset-cells = <1>;
> > +	};
> > +
> > +	mtd {
> > +		compatible = "mediatek,mt7622-nfc";
> > +	};
> > +};
> > +
> > +&i2c {
> > +	status = "okay";
> > +};
> > +
> > +&pcie {
> > +	status = "okay";
> > +};
> > +
> > +&spi0 {
> > +	status = "okay";
> > +
> > +	flash@0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <50000000>;
> > +	};
> > +};
> > +
> > +/* gmac1 connected to MT7530's phy0 */
> > +&gmac1 {
> > +	status = "okay";
> > +	phy-handle = <&ethphy0>;
> > +};
> > +
> > +&mdio {
> > +	/* MT7530's phy0 */
> > +	ethphy0: ethernet-phy@0 {
> > +		reg = <0>;
> > +		phy-mode = "rgmii";
> > +	};
> > +};
> 
> These are partially wrong, check the mt7621.dtsi on mainline. Or better,
> don't do it. I'm very close to adding support for changing the DSA conduit
> for user ports. I suggest you just add port@0 to the DSA switch node below.
>

I don't claim to be an expert on DSA or how MT7530 connects to MT7621, however
I do remember trying various combinations and failing to make all the ports
work. I blame TP-Link on having a weird setup, but to be sure I will try your
suggestion if I manage to understand exactly where I'm "partially wrong" :)

I will also try to remove the node to see what I get and report back here.

Best regards,
Liviu


> > +
> > +&switch0 {
> > +	/* #gpio-cells = <2>;
> > +	gpio-controller; */
> > +
> > +	ports {
> > +		/* phy0 is muxed to gmac1 */
> > +		/delete-node/ port@0;
> > +
> > +		port@1 {
> > +			status = "okay";
> > +			label = "lan1";
> > +		};
> > +
> > +		port@2 {
> > +			status = "okay";
> > +			label = "wan";
> > +		};
> > +	};
> > +};
> 
> Arınç

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
