Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9762859C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiKNQjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiKNQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:39:23 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B842F64D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:37:02 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 871CD40124;
        Mon, 14 Nov 2022 17:36:59 +0100 (CET)
Date:   Mon, 14 Nov 2022 17:36:53 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH] arm64: dts: Add basic support for BIQU CB1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <HHJCLR.858WB1ISGFT32@somainline.org>
In-Reply-To: <4ce3199e-1c9c-2fca-804e-dadc87a85704@linaro.org>
References: <20221114162547.1802689-1-martin.botka@somainline.org>
        <4ce3199e-1c9c-2fca-804e-dadc87a85704@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yea my bad this was not supposed to be sent this soon.
Well either way V2 will come soon

On Mon, Nov 14 2022 at 05:29:31 PM +01:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/11/2022 17:25, Martin Botka wrote:
>>  CB1 is Compute Module style board that plugs into Rpi board style 
>> adapter or
>>  Manta 3D printer boards (M4P/M8P).
>> 
>>  The board has:
>>  	H616 SoC
>>  	1GB of RAM
>>  	AXP313A PMIC
>> 
>>  And the actual boards that CB1 plugs in are just extension to it 
>> with ports and
>>  thus are not split in DT.
>> 
>>  Boards have:
>>  	4x (3x for Manta boards) USB and 1 USB OTG.
>>  	SDcard slot for loading images.
>>  	Ethernet port wired to the internal PHY.
>>  	2x HDMI 2.0.
>>  	Power and Status LEDs.
>> 
>>  Currently working:
>>  	Booting
>>  	USB
>>  	UART
>> 
>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>  ---
>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>   .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 191 
>> ++++++++++++++++++
>>   2 files changed, 192 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>> 
>>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile 
>> b/arch/arm64/boot/dts/allwinner/Makefile
>>  index 6a96494a2e0a..223f1be73541 100644
>>  --- a/arch/arm64/boot/dts/allwinner/Makefile
>>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>  @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>>  +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>>  new file mode 100644
>>  index 000000000000..2225a965dddc
>>  --- /dev/null
>>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
>>  @@ -0,0 +1,191 @@
>>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>  +/*
>>  + * Copyright (C) 2022 Arm Ltd.
>>  + */
>>  +
>>  +/dts-v1/;
>>  +
>>  +#include "sun50i-h616.dtsi"
>>  +
>>  +#include <dt-bindings/gpio/gpio.h>
>>  +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>  +#include <dt-bindings/leds/common.h>
>>  +
>>  +/ {
>>  +	model = "BIQU CB1";
>>  +	compatible = "allwinner,sun50i-h616";
> 
> That's not a proper board compatible.
> 
>>  +
>>  +	aliases {
>>  +		serial0 = &uart0;
>>  +	};
>>  +
>>  +	chosen {
>>  +		stdout-path = "serial0:115200n8";
>>  +	};
>>  +
>>  +	leds {
>>  +		compatible = "gpio-leds";
>>  +
>>  +		led-0 {
>>  +			function = LED_FUNCTION_POWER;
>>  +			color = <LED_COLOR_ID_RED>;
>>  +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
>>  +			default-state = "on";
>>  +		};
>>  +
>>  +		led-1 {
>>  +			function = LED_FUNCTION_STATUS;
>>  +			color = <LED_COLOR_ID_GREEN>;
>>  +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
>>  +		};
>>  +	};
>>  +
>>  +	reg_vcc5v: vcc5v {
> 
> regulator prefix. Keep it consistent.
> 
>>  +		/* board wide 5V supply directly from the USB-C socket */
>>  +		compatible = "regulator-fixed";
>>  +		regulator-name = "vcc-5v";
>>  +		regulator-min-microvolt = <5000000>;
>>  +		regulator-max-microvolt = <5000000>;
>>  +		regulator-always-on;
>>  +	};
>>  +
>>  +	reg_usb1_vbus: regulator-usb1-vbus {
>>  +		compatible = "regulator-fixed";
>>  +		regulator-name = "usb1-vbus";
>>  +		regulator-min-microvolt = <5000000>;
>>  +		regulator-max-microvolt = <5000000>;
>>  +		vin-supply = <&reg_vcc5v>;
>>  +		enable-active-high;
>>  +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
>>  +	};
>>  +};
>>  +
>>  +&ehci0 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci1 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci2 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ehci3 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&mmc0 {
>>  +	vmmc-supply = <&reg_dldo1>;
>>  +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
>>  +	no-1-8-v;
>>  +	bus-width = <4>;
>>  +	status = "disabled";
>>  +};
>>  +
>>  +&ohci0 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci1 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci2 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&ohci3 {
>>  +	status = "okay";
>>  +};
>>  +
>>  +&r_i2c {
>>  +	status = "okay";
>>  +
>>  +	axp1530: pmic@36 {
>>  +		compatible = "x-powers,axp1530";
>>  +		status = "okay";
> 
> Drop.
> 
>>  +		reg = <0x36>;
>>  +		wakeup-source;
>>  +
>>  +		standby_param: standby_param {
> 
> Does not look like supported/documented/valid property. Test your DTS
> with `make dtbs_check`.
> 
> 
> Best regards,
> Krzysztof
> 


