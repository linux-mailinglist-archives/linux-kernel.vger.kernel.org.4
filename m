Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337E611394
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJ1NvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJ1Nus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:50:48 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3204AD59;
        Fri, 28 Oct 2022 06:50:01 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ooPk8-0000YI-IJ; Fri, 28 Oct 2022 15:49:52 +0200
Date:   Fri, 28 Oct 2022 14:49:43 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [RFC v2 7/7] arm64: dts: mt7986: add Bananapi R3
Message-ID: <Y1vd9+q2PzG5DIKa@makrotopia.org>
References: <20221026093650.110290-1-linux@fw-web.de>
 <20221026093650.110290-8-linux@fw-web.de>
 <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
 <a97aa98a6230e7f33a6b5f5e2c9e54ce@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97aa98a6230e7f33a6b5f5e2c9e54ce@fw-web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:57:44PM +0200, Frank Wunderlich (linux) wrote:
> Am 2022-10-28 11:19, schrieb AngeloGioacchino Del Regno:
> > Il 26/10/22 11:36, Frank Wunderlich ha scritto:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > > 
> > > Add support for Bananapi R3 SBC.
> > > 
> > > - SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
> > > - all rj45 ports and both SFP working (eth1/lan4)
> > > - all USB-Ports + SIM-Slot tested
> > > - i2c and all uarts tested
> > > - wifi tested
> > > 
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > > SPI-NAND/NOR switched (CS by sw5/C) not yet included
> > >    this is done with DT-Overlays in my tree, but i have no idea yet,
> > >    how to upstream
> > > 
> > > break some lines in wifi-eeprom-data because of checkpatch warnings.
> > > originally there were 8 x int32 per line
> > > 
> > > changes:
> > > 
> > > v2:
> > > - remove pcie to be added later (discussion about clocks)
> > > - some fixes based on suggestions on ML
> > >    - add key suffix like it's done in mt7622-bpi-r64 devicetree
> > >    - add dash in sfp node names
> > >    - use reg as unit for switch-node
> > >    - drop "-3-4" suffix from i2c-pins node name
> > >    - fix order in Makefile
> > > ---
> > >   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
> > >   .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
> > >   .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
> > >   .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 593
> > > ++++++++++++++++++
> > >   4 files changed, 658 insertions(+)
> > >   create mode 100644
> > > arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> > >   create mode 100644
> > > arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> > >   create mode 100644
> > > arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/Makefile
> > > b/arch/arm64/boot/dts/mediatek/Makefile
> > > index 0ec90cb3ef28..e8902f2cc58f 100644
> > > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > > @@ -7,6 +7,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> > > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
> > > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
> > >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
> > > diff --git
> > > a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> > > b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> > > new file mode 100644
> > > index 000000000000..859b4180ca11
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> > > @@ -0,0 +1,34 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2021 MediaTek Inc.
> > > + * Author: Sam.Shih <sam.shih@mediatek.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +
> > > +#include "mt7986a-bananapi-bpi-r3.dtsi"
> > > +
> > > +/ {
> > > +	model = "Bananapi BPI-R3 (emmc)";
> > > +};
> > > +
> > > +&mmc0 {
> > > +	pinctrl-names = "default", "state_uhs";
> > > +	pinctrl-0 = <&mmc0_pins_default>;
> > > +	pinctrl-1 = <&mmc0_pins_uhs>;
> > 
> > pinctrl properties and power supply properties can go to the shared
> > mt7986a-bananapi-bpi-r3.dtsi file.
> 
> OK
> 
> > Also, I have a question here... so your hardware can take either eMMC
> > or MicroSD... and... is there really no way to build in both devicetrees
> > and having the bootloader to select the right one based on hardware
> > version
> > or on machine compatible?
> 
> as i wrote in description the board has both, an emmc-chip and microsd-slot,
> but they cannot be used simultanously as mt7986 has only 1 mmc-controller.
> BPI-R3 has a switch that changes the first 4 data-lines either to emmc or
> microsd-slot. You have only 1 mmc-node that has to be configured to which
> mmc-device you have connected, so i have to use 2 different devicetrees
> here.

You could also use device tree overlays to select SDMMC or eMMC just
like for the NOR vs. NAND choice on this board.

> 
> > I can see, on the wiki, that both bootloader and ATF can be customized
> > (so,
> > can be compiled and flashed just fine), so I would say that even if the
> > "original" U-Boot doesn't distinguish devicetrees, you can definitely
> > easily
> > implement that.
> 
> i already boot a fit-image with 2 dts (and 2 overlays for spi-nand/nor) and
> my uboot can check with "mmc partconf" if emmc is available and if not
> choose the sd-dts.

Exactly. This is how it's done in OpenWrt as well.

> 
> > If you have no idea how to recognize the boards, from a fast look at the
> > board schematics, I can see that there's a bootstrap setting based on
> > the
> > state of GPIO0 and GPIO1... you can perhaps use that somehow?
> > Otherwise, remember that, most of the times, there are other ways to
> > determine
> > the board version, like Board ID resistors...
> 
> but how should this effect the dts files here? originally i had the sd-card
> dts as base and the emmc had overridden/deleted some properties there (so
> only 2 dts-files). Had talked to Matthias and he suggested having a base
> dtsi and 2 dts for the 2 mmc-configs.
> 
> > Also, still on the wiki, I can't see any no-eMMC version of this board:
> > is
> > the sd-only a pre-production version or..?
> 
> no sd/emmc-only version...1 board with 1 mmc-controller, but 2 "storages"
> connected (only 1 functional based on hw switch setting)
> 
> > > +	bus-width = <8>;
> > > +	max-frequency = <200000000>;
> > > +	cap-mmc-highspeed;
> > > +	mmc-hs200-1_8v;
> > > +	mmc-hs400-1_8v;
> > > +	hs400-ds-delay = <0x14014>;
> > > +	vmmc-supply = <&reg_3p3v>;
> > > +	vqmmc-supply = <&reg_1p8v>;
> > > +	non-removable;
> > > +	no-sd;
> > > +	no-sdio;
> > > +	status = "okay";
> > > +};
> > > +
> > > diff --git
> > > a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> > > b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> > > new file mode 100644
> > > index 000000000000..57200407ab86
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> > > @@ -0,0 +1,29 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2021 MediaTek Inc.
> > > + * Author: Sam.Shih <sam.shih@mediatek.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +
> > > +#include "mt7986a-bananapi-bpi-r3.dtsi"
> > > +
> > > +/ {
> > > +	model = "Bananapi BPI-R3 (sdmmc)";
> > > +};
> > > +
> > > +&mmc0 {
> > > +	//sdcard
> > 
> > C-style comments please
> 
> ok
> 
> > > +	pinctrl-names = "default", "state_uhs";
> > > +	pinctrl-0 = <&mmc0_pins_default>;
> > > +	pinctrl-1 = <&mmc0_pins_uhs>;
> > > +	bus-width = <4>;
> > > +	max-frequency = <52000000>;
> > > +	cap-sd-highspeed;
> > > +	vmmc-supply = <&reg_3p3v>;
> > > +	vqmmc-supply = <&reg_1p8v>;
> > > +	status = "okay";
> > > +};
> > > +
> > > diff --git
> > > a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> > > new file mode 100644
> > > index 000000000000..fc100c3a6415
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> > > @@ -0,0 +1,593 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2021 MediaTek Inc.
> > > + * Authors: Sam.Shih <sam.shih@mediatek.com>
> > > + *          Frank Wunderlich <frank-w@public-files.de>
> > > + *          Daniel Golle <daniel@makrotopia.org>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include <dt-bindings/input/input.h>
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/leds/common.h>
> > > +
> > > +#include "mt7986a.dtsi"
> > > +
> > > +/ {
> > > +	model = "Bananapi BPI-R3";
> > > +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +		ethernet0 = &gmac0;
> > > +		ethernet1 = &gmac1;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > > +
> > > +	gpio-keys {
> > > +		compatible = "gpio-keys";
> > > +
> > > +		factory-key {
> > 
> > I'd say that this is not "factory-key" but "reset-key"?
> 
> okay i rename it.
> 
> > > +			label = "reset";
> > > +			linux,code = <KEY_RESTART>;
> > > +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;

At least on my V1.0 board and reportedly also on V1.1 boards the RST
button doesn't work. As soon as a NVME/M.2 module is inserted this
also connects the GPIO just like if the button was pressed all the
time. This issue has also been discussed in BananaPi forums.


> > > +		};
> > > +
> > > +		wps-key {
> > > +			label = "wps";
> > > +			linux,code = <KEY_WPS_BUTTON>;
> > > +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
> > > +		};
> > > +	};
> > > +
> > 
> > ..snip..
> > 
> > > +
> > > +	memory@40000000 {
> > > +		device_type = "memory";
> > > +		reg = <0 0x40000000 0 0x40000000>;
> > 
> > Doesn't your bootloader fill-in the memory size automatically?
> 
> have not tried yet.
> 
> > > +	};
> > > +
> > > +	reg_1p8v: regulator-1p8v {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "fixed-1.8V";
> > 
> > This is "avdd18", isn't it?
> 
> need to check
> 
> > > +		regulator-min-microvolt = <1800000>;
> > > +		regulator-max-microvolt = <1800000>;
> > > +		regulator-boot-on;
> > > +		regulator-always-on;
> > 
> > All these regulators have a vin-supply: please fill it in.
> > Moreover, in the schematics, I can also see other LDOs: 0.9VD (input
> > +12VD),
> > AVDD12 (input 1.8VD), DDRV_VPP (input 3.3VD)...
> 
> ok
> 
> > Of course, this means that you have one more 1.8V regulator, called
> > 1.8vd.
> > 
> > > +	};
> > > +
> > > +	reg_3p3v: regulator-3p3v {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "fixed-3.3V";
> > 
> > regulator-name = "3.3vd";
> > 
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-boot-on;
> > > +		regulator-always-on;
> > 
> > vin-supply = <&dcin>; (dcin: regulator-12vd { ... })
> > 
> > > +	};
> > > +
> > > +	reg_5v: regulator-5v {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "fixed-5V";
> > 
> > regulator-name  = "fixed-5p1";
> > 
> > > +		regulator-min-microvolt = <5000000>;
> > > +		regulator-max-microvolt = <5000000>;
> > 
> > Schematics say "+5V: 5.1V/3A", so this is not 5000000.
> > 
> > > +		regulator-boot-on;
> > > +		regulator-always-on;
> > 
> > 
> > vin-supply = <&dcin>;
> > 
> > > +	};
> > > +
> > 
> > ..snip..
> > 
> > > +
> > > +&pio {
> > > +	i2c_pins: i2c-pins {
> > > +		mux {
> > > +			function = "i2c";
> > > +			groups = "i2c";
> > > +		};
> > > +	};
> > > +
> > > +	mmc0_pins_default: mmc0-pins {
> > > +		mux {
> > > +			function = "emmc";
> > > +			groups = "emmc_51";
> > > +		};
> > > +		conf-cmd-dat {
> > > +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> > > +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> > > +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> > > +			input-enable;
> > > +			drive-strength = <4>;
> > > +			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
> > 
> > Can we please stop using these custom pull-{up,down}-adv properties?
> > Check what was done on pinctrl-mt8192.c (and dt schema) for more
> > information
> > and examples.
> 
> need to check these with MTK.
> 
> > > +		};
> > > +		conf-clk {
> > 
> > ..snip..
> > 
> > > +
> > > +&wifi {
> > > +	status = "okay";
> > > +	pinctrl-names = "default", "dbdc";
> > > +	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
> > > +	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
> > > +
> > > +	mediatek,eeprom-data = <0x86790900 0xc4326 0x60000000 0x00 0x00
> > > 0x00 0x00 0x00
> > 
> > Ouch! This looks like firmware unrolled in a devicetree property - that
> > can't
> > be right.
> > 
> > Please dump that in a binary file and load it as firmware from
> > userspace.
> 
> it uses the mt76 driver and here eeprom can only be loaded from
> mtd-partition or from device tree. Previous attempts loading eeprom data
> from userspace file (like it's done for "normal" firmware) were rejected.

Note that strictly speaking this is not firmware but rather calibration
data (ie. board-specific configuration, not code).

In case you don't like the large amount of data in the DTS file, you
can use the /incbin/ statement to include it from a file instead.

As there is no physical EEPROM nor calibration data stored anywhere in
he flash there is no easy way the driver could request a board-specific
filename, unlike e.g. ath10k requesting BDF from userspace.
In the past (e.g. out-of-tree patches for rt2x00 driver allowing it's
use on Rt305x WiSoC) this lack of a board-specific filename has lead to
people treating the file just like a generic firmware file: ignoring
the board-specific nature of calibration data and just copying it from
another board... As a work-around to prevent that, we could at least
embed the filename in the dts or hack the driver to request a filename
based on the top level 'compatible' string of the board's device tree.

I've added Felix to Cc: as he suggested that solution back then.


Cheers


Daniel
