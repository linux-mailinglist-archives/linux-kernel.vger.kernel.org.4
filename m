Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567C610F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJ1K6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJ1K5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:57:50 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACF197F83;
        Fri, 28 Oct 2022 03:57:47 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 5A38F5FF91;
        Fri, 28 Oct 2022 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666954665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45U4JNMPzdhCKxqPyu/vblXV0uvneI0UY12mqqikmNY=;
        b=qYKXa4p1a/mfedbUiCOoRY73YxiNLK5k2wUfxc/gMihZXF2P++EOfXckS6Ipr35feNZ3hU
        GCOHd1S3ehvX9Ks26/zkTp4PlqcxFhlBl+qejn5h3FeLxM8pkgY3qsE9hfh1k8X/8fdDvy
        jbKwxXbjVEv5iEuvI9DrfJgxs3qI5g8=
Received: from webmail.hosting.de (unknown [134.0.26.148])
        by mxbox1.masterlogin.de (Postfix) with ESMTPA id D10C3403ED;
        Fri, 28 Oct 2022 10:57:44 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 28 Oct 2022 12:57:44 +0200
From:   "Frank Wunderlich (linux)" <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 7/7] arm64: dts: mt7986: add Bananapi R3
In-Reply-To: <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
References: <20221026093650.110290-1-linux@fw-web.de>
 <20221026093650.110290-8-linux@fw-web.de>
 <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a97aa98a6230e7f33a6b5f5e2c9e54ce@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: a0790789-d43a-4d9d-b1a0-321851b4552d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-28 11:19, schrieb AngeloGioacchino Del Regno:
> Il 26/10/22 11:36, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Add support for Bananapi R3 SBC.
>> 
>> - SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
>> - all rj45 ports and both SFP working (eth1/lan4)
>> - all USB-Ports + SIM-Slot tested
>> - i2c and all uarts tested
>> - wifi tested
>> 
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> ---
>> SPI-NAND/NOR switched (CS by sw5/C) not yet included
>>    this is done with DT-Overlays in my tree, but i have no idea yet,
>>    how to upstream
>> 
>> break some lines in wifi-eeprom-data because of checkpatch warnings.
>> originally there were 8 x int32 per line
>> 
>> changes:
>> 
>> v2:
>> - remove pcie to be added later (discussion about clocks)
>> - some fixes based on suggestions on ML
>>    - add key suffix like it's done in mt7622-bpi-r64 devicetree
>>    - add dash in sfp node names
>>    - use reg as unit for switch-node
>>    - drop "-3-4" suffix from i2c-pins node name
>>    - fix order in Makefile
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>>   .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
>>   .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
>>   .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 593 
>> ++++++++++++++++++
>>   4 files changed, 658 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
>>   create mode 100644 
>> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
>>   create mode 100644 
>> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>> b/arch/arm64/boot/dts/mediatek/Makefile
>> index 0ec90cb3ef28..e8902f2cc58f 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -7,6 +7,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
>> diff --git 
>> a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
>> new file mode 100644
>> index 000000000000..859b4180ca11
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2021 MediaTek Inc.
>> + * Author: Sam.Shih <sam.shih@mediatek.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +#include "mt7986a-bananapi-bpi-r3.dtsi"
>> +
>> +/ {
>> +	model = "Bananapi BPI-R3 (emmc)";
>> +};
>> +
>> +&mmc0 {
>> +	pinctrl-names = "default", "state_uhs";
>> +	pinctrl-0 = <&mmc0_pins_default>;
>> +	pinctrl-1 = <&mmc0_pins_uhs>;
> 
> pinctrl properties and power supply properties can go to the shared
> mt7986a-bananapi-bpi-r3.dtsi file.

OK

> Also, I have a question here... so your hardware can take either eMMC
> or MicroSD... and... is there really no way to build in both 
> devicetrees
> and having the bootloader to select the right one based on hardware 
> version
> or on machine compatible?

as i wrote in description the board has both, an emmc-chip and 
microsd-slot, but they cannot be used simultanously as mt7986 has only 1 
mmc-controller. BPI-R3 has a switch that changes the first 4 data-lines 
either to emmc or microsd-slot. You have only 1 mmc-node that has to be 
configured to which mmc-device you have connected, so i have to use 2 
different devicetrees here.

> I can see, on the wiki, that both bootloader and ATF can be customized 
> (so,
> can be compiled and flashed just fine), so I would say that even if the
> "original" U-Boot doesn't distinguish devicetrees, you can definitely 
> easily
> implement that.

i already boot a fit-image with 2 dts (and 2 overlays for spi-nand/nor) 
and my uboot can check with "mmc partconf" if emmc is available and if 
not choose the sd-dts.

> If you have no idea how to recognize the boards, from a fast look at 
> the
> board schematics, I can see that there's a bootstrap setting based on 
> the
> state of GPIO0 and GPIO1... you can perhaps use that somehow?
> Otherwise, remember that, most of the times, there are other ways to 
> determine
> the board version, like Board ID resistors...

but how should this effect the dts files here? originally i had the 
sd-card dts as base and the emmc had overridden/deleted some properties 
there (so only 2 dts-files). Had talked to Matthias and he suggested 
having a base dtsi and 2 dts for the 2 mmc-configs.

> Also, still on the wiki, I can't see any no-eMMC version of this board: 
> is
> the sd-only a pre-production version or..?

no sd/emmc-only version...1 board with 1 mmc-controller, but 2 
"storages" connected (only 1 functional based on hw switch setting)

>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
>> +	cap-mmc-highspeed;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
>> +	hs400-ds-delay = <0x14014>;
>> +	vmmc-supply = <&reg_3p3v>;
>> +	vqmmc-supply = <&reg_1p8v>;
>> +	non-removable;
>> +	no-sd;
>> +	no-sdio;
>> +	status = "okay";
>> +};
>> +
>> diff --git 
>> a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
>> new file mode 100644
>> index 000000000000..57200407ab86
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2021 MediaTek Inc.
>> + * Author: Sam.Shih <sam.shih@mediatek.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +#include "mt7986a-bananapi-bpi-r3.dtsi"
>> +
>> +/ {
>> +	model = "Bananapi BPI-R3 (sdmmc)";
>> +};
>> +
>> +&mmc0 {
>> +	//sdcard
> 
> C-style comments please

ok

>> +	pinctrl-names = "default", "state_uhs";
>> +	pinctrl-0 = <&mmc0_pins_default>;
>> +	pinctrl-1 = <&mmc0_pins_uhs>;
>> +	bus-width = <4>;
>> +	max-frequency = <52000000>;
>> +	cap-sd-highspeed;
>> +	vmmc-supply = <&reg_3p3v>;
>> +	vqmmc-supply = <&reg_1p8v>;
>> +	status = "okay";
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
>> new file mode 100644
>> index 000000000000..fc100c3a6415
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
>> @@ -0,0 +1,593 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2021 MediaTek Inc.
>> + * Authors: Sam.Shih <sam.shih@mediatek.com>
>> + *          Frank Wunderlich <frank-w@public-files.de>
>> + *          Daniel Golle <daniel@makrotopia.org>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +#include "mt7986a.dtsi"
>> +
>> +/ {
>> +	model = "Bananapi BPI-R3";
>> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		ethernet0 = &gmac0;
>> +		ethernet1 = &gmac1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		factory-key {
> 
> I'd say that this is not "factory-key" but "reset-key"?

okay i rename it.

>> +			label = "reset";
>> +			linux,code = <KEY_RESTART>;
>> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		wps-key {
>> +			label = "wps";
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
> 
> ..snip..
> 
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0 0x40000000 0 0x40000000>;
> 
> Doesn't your bootloader fill-in the memory size automatically?

have not tried yet.

>> +	};
>> +
>> +	reg_1p8v: regulator-1p8v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-1.8V";
> 
> This is "avdd18", isn't it?

need to check

>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> All these regulators have a vin-supply: please fill it in.
> Moreover, in the schematics, I can also see other LDOs: 0.9VD (input 
> +12VD),
> AVDD12 (input 1.8VD), DDRV_VPP (input 3.3VD)...

ok

> Of course, this means that you have one more 1.8V regulator, called 
> 1.8vd.
> 
>> +	};
>> +
>> +	reg_3p3v: regulator-3p3v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-3.3V";
> 
> regulator-name = "3.3vd";
> 
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> vin-supply = <&dcin>; (dcin: regulator-12vd { ... })
> 
>> +	};
>> +
>> +	reg_5v: regulator-5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-5V";
> 
> regulator-name  = "fixed-5p1";
> 
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
> 
> Schematics say "+5V: 5.1V/3A", so this is not 5000000.
> 
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> 
> vin-supply = <&dcin>;
> 
>> +	};
>> +
> 
> ..snip..
> 
>> +
>> +&pio {
>> +	i2c_pins: i2c-pins {
>> +		mux {
>> +			function = "i2c";
>> +			groups = "i2c";
>> +		};
>> +	};
>> +
>> +	mmc0_pins_default: mmc0-pins {
>> +		mux {
>> +			function = "emmc";
>> +			groups = "emmc_51";
>> +		};
>> +		conf-cmd-dat {
>> +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
>> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
>> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
>> +			input-enable;
>> +			drive-strength = <4>;
>> +			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
> 
> Can we please stop using these custom pull-{up,down}-adv properties?
> Check what was done on pinctrl-mt8192.c (and dt schema) for more 
> information
> and examples.

need to check these with MTK.

>> +		};
>> +		conf-clk {
> 
> ..snip..
> 
>> +
>> +&wifi {
>> +	status = "okay";
>> +	pinctrl-names = "default", "dbdc";
>> +	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
>> +	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
>> +
>> +	mediatek,eeprom-data = <0x86790900 0xc4326 0x60000000 0x00 0x00 0x00 
>> 0x00 0x00
> 
> Ouch! This looks like firmware unrolled in a devicetree property - that 
> can't
> be right.
> 
> Please dump that in a binary file and load it as firmware from 
> userspace.

it uses the mt76 driver and here eeprom can only be loaded from 
mtd-partition or from device tree. Previous attempts loading eeprom data 
from userspace file (like it's done for "normal" firmware) were 
rejected.

regards Frank
