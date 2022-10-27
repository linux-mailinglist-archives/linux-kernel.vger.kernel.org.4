Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FC61024E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiJ0UDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiJ0UDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:03:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8A25EB9;
        Thu, 27 Oct 2022 13:03:04 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oo95T-0002xa-Eb; Thu, 27 Oct 2022 22:02:47 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 3/4] ARM: dts: rockchip: add rk3128.dtsi
Date:   Thu, 27 Oct 2022 22:02:46 +0200
Message-ID: <22076018.EfDdHjke4D@diego>
In-Reply-To: <6fbb01f0-d0d2-bb06-a160-2f8f91ac68ca@linaro.org>
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com> <2dc46681-894d-4521-bfa7-3e9209691e0a@gmail.com> <6fbb01f0-d0d2-bb06-a160-2f8f91ac68ca@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. Oktober 2022, 21:43:43 CEST schrieb Krzysztof Kozlowski:
> On 27/10/2022 13:53, Johan Jonker wrote:
> > Hi Krzysztof, Kever, Heiko and others,
> > 
> > On 10/27/22 16:58, Krzysztof Kozlowski wrote:
> >> On 26/10/2022 20:53, Johan Jonker wrote:
> >>> Add basic rk3128 support.
> >>>
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> > 
> > Thank you for your review.
> > 
> > Some more questions/comments below.
> > 
> >>
> >>> +#include <dt-bindings/clock/rk3128-cru.h>
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>> +#include <dt-bindings/pinctrl/rockchip.h>
> >>> +
> >>> +/ {
> >>> +	compatible = "rockchip,rk3128";
> >>> +	interrupt-parent = <&gic>;
> >>> +	#address-cells = <1>;
> >>> +	#size-cells = <1>;
> >>> +
> >>> +	aliases {
> >>> +		gpio0 = &gpio0;
> >>> +		gpio1 = &gpio1;
> >>> +		gpio2 = &gpio2;
> >>> +		gpio3 = &gpio3;
> > 
> > Is gpio OK here?
> 
> Could be, but let me rephrase it - why do you need aliases in DTSI? What
> do these aliases represent?
> 
> The SoC pieces (nodes in DTSI) do not rely on aliases.

Subsystems use the aliases for numbering their instances.
So the i2c0 alias causes the i2c bus getting the number 0 in the operating
system as well - making it i2c0 there too.


> >>> +		i2c0 = &i2c0;
> >>> +		i2c1 = &i2c1;
> >>> +		i2c2 = &i2c2;
> >>> +		i2c3 = &i2c3;
> >>> +		spi0 = &spi0;
> >>> +		serial0 = &uart0;
> >>> +		serial1 = &uart1;
> >>> +		serial2 = &uart2;
> >>
> >> Bus aliases are board specific and represent what is actually available
> >> on headers/pins etc. These do not belong to SoC DTSI.
> > 
> > I just follow current Rockchip DT common practice.
> > 
> > Do we need to change all Rockchip boards?
> > Would like to hear from Heiko what's the plan here?
> > Syncing to U-boot is already a mess...
> 
> Heiko might have his own preference which then over-rules my
> recommendation here. But in general this applies to all boards, so other
> boards could be fixed as well. Different point is whether it is actually
> worth fixing them...

I remember only parts of the discussion for the previous socs. Back then
Arnd was advocating mainly for moving the mmc aliases to boards.

As the aliases in general also determine the naming of the bus instance,
I'm very much in favor of having the hardware-i2c5 being named i2c5
in all cases ;-) . Having these hardware busses getting random numbers
really calls for chaos.

So I'd really like us to continue the way we arrived at with the previous
socs now :-)

Heiko


> > So far only instructions/changes and discussion about mmc nodes.
> > 
> > Can Rockchip specific rules be publicized in a central place? 
> > 
> > ===
> > mmc aliases on reg order, availability and without number gap.
> > ===
> > 
> > Heiko's sort rules:
> > 
> > compatible
> > reg
> > interrupts
> > [alphabetical]
> > status [if needed]
> 
> I don't know what does it mean. Do you discuss with my comment? Wasn't
> my comment exactly like this?
> 
> > 
> > ===
> > My incomplete list:
> > 
> > For nodes:
> > If exists on top: model, compatible and chosen.
> > Sort things without reg alphabetical first,
> > then sort the rest by reg address.
> > 
> > Inside nodes:
> > If exists on top: compatible, reg and interrupts.
> > In alphabetical order the required properties.
> > Then in alphabetical order the other properties.
> > And as last things that start with '#' in alphabetical order.
> > Add status below all other properties for soc internal components with
> > any board-specifics.
> > Keep an empty line between properties and nodes.
> > 
> > Exceptions:
> > Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
> > and dma-names.
> > Sort simple-audio-card,name above other simple-audio-card properties.
> > Sort regulator-name above other regulator properties.
> > Sort regulator-min-microvolt above regulator-max-microvolt.
> 
> Is there a question to me?
> 
> > 
> >>
> >>> +	};
> >>> +
> >>> +	arm-pmu {
> >>> +		compatible = "arm,cortex-a7-pmu";
> >>> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> >>> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> >>> +			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> >>> +			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> >>> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> >>> +	};
> >>> +
> >>> +	cpus {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		cpu0: cpu@f00 {
> >>> +			device_type = "cpu";
> >>> +			compatible = "arm,cortex-a7";
> >>> +			reg = <0xf00>;
> >>> +			clock-latency = <40000>;
> >>> +			clocks = <&cru ARMCLK>;
> > 
> >>> +			operating-points = <
> >>> +				/* KHz    uV */
> >>> +				 816000 1000000
> >>> +			>;
> >>
> >> Why not operating-points-v2?
> > 
> > rk3128 doesn't have a tsadc.
> 
> And this is related to operating-points-v2?
> 
> > As long as this thermal stuff is not implemented with drivers and regulators I would prefer to keep it basic in the DT for now.
> > Just keep things simple for now till someone with hardware can fix that.
> > 
> > https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm/boot/dts/rk312x.dtsi#L315
> > 
> > 	tsadc: tsadc {
> > 		compatible = "rockchip,rk3126-tsadc-virtual";
> > 		nvmem-cells = <&cpu_leakage>;
> > 		nvmem-cell-names = "cpu_leakage";
> > 		#thermal-sensor-cells = <1>;
> > 		status = "disabled";
> > 	};
> 
> >>
> >>> +			#cooling-cells = <2>; /* min followed by max */
> >>> +		};
> >>> +
> >>> +		cpu1: cpu@f01 {
> >>> +			device_type = "cpu";
> >>> +			compatible = "arm,cortex-a7";
> >>> +			reg = <0xf01>;
> >>> +		};
> >>> +
> >>> +		cpu2: cpu@f02 {
> >>> +			device_type = "cpu";
> >>> +			compatible = "arm,cortex-a7";
> >>> +			reg = <0xf02>;
> >>> +		};
> >>> +
> >>> +		cpu3: cpu@f03 {
> >>> +			device_type = "cpu";
> >>> +			compatible = "arm,cortex-a7";
> >>> +			reg = <0xf03>;
> >>> +		};
> >>> +	};
> >>> +
> >>> +	timer {
> > 
> >>> +		compatible = "arm,armv7-timer";
> > 
> > Original 2 interrupts:
> 
> I have no clue what do you refer now.
> 
> I did not comment here, so I guess nothing more to me?
> 
> >>> +		usb2phy: usb2phy@17c {
> >>
> > 
> >> Node names should be generic.
> >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> > 
> > You are absolutely correct. Except for Rockchip usb2phy nodes ....
> > #phy-cells is located in a sub node, so we keep as it is... ;)
> 
> How phy-cells are related?
> 
> > 
> > dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml 
> > https://lore.kernel.org/all/20210601164800.7670-2-jbx6244@gmail.com/
> 
> You mean parent device bindings expect usb2phy? If so, then it's fine.
> 
> Best regards,
> Krzysztof
> 
> 




