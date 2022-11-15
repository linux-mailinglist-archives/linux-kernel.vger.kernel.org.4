Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDD62A434
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiKOVe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiKOVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:34:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD62638;
        Tue, 15 Nov 2022 13:34:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t25so39402127ejb.8;
        Tue, 15 Nov 2022 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3Pc4/CGHXBcfmuh5FACk8LjqEpCsIp7QK20YDRp6Ig=;
        b=pwPBFAJ/G+NdDy9a3omf/kBM+Par445yEoUwOtNAjeMFD5VS8ujz9yAIPWN2/I2+9b
         Q89MbE1+lVNzyMDgsndLDDCxmJnKH4g2LQfbdI+LerBjLUh4az8OE9mm0JhJWY7VFkF/
         thekg59Rmvzy2/nro1jujpWL2zIp0HKZcVGbd3Uwnh3Vj6uchs7gLNrNaYajtKnfeAUl
         MXLnrAcd9zy5GJ70gKARubAEnQW+LvmaWAXrfxkh7P26x8rmW9QrShn1DKijmPfeheDR
         mP11FiOL1/rWt2BlpVV1FhyP5cdh/JVeUdv8iW4MMPizW5Vq92c2lOA9MewF5f4GvIRC
         E06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3Pc4/CGHXBcfmuh5FACk8LjqEpCsIp7QK20YDRp6Ig=;
        b=076SYSJHCEQe87rFRAZlBp00IAWWM2YMEXzSelrYqCwqENWmjoJdOJL5HxlmhVPrgJ
         siNLQ8CGTBU/AZF+v5z5ljw+oiRli06T9GrZU6ke6WdGojPgwNY/AYW/E8o5sfEEpYaj
         s+pk6FJLLc121KSV0fb4LXg6q7EuSXlPRRCywDEUQHIzhfwy7objFMLUR0vNmG/kV26I
         LOnVPWyW5K1tuUlf3kWdg+L8ofV2KOA/wfFeedAy/VvvqjS6KJQ7hFlpMMTX7Fn6YLw6
         yfq2OrvIqiJk4LU+1OVvvCs95/9LWYtkf55I7aSLyxG3AeRYZ/oocvztUjGhSSC+QWIv
         ZPUA==
X-Gm-Message-State: ANoB5plwf84/xBccSqV4BeXjdUjomzo6wGaU2FKdzIe8Ic1geXd1lEpP
        A3ir5OaaHqX6r+Ss59bk7A4=
X-Google-Smtp-Source: AA0mqf706j4etLneKjArZoBC50zKKSkCqofGi54tofA6K+QwQStFBfyr4cZ7LKDk8cgdPgxZsOyE3g==
X-Received: by 2002:a17:906:1186:b0:7ae:5dd6:e62d with SMTP id n6-20020a170906118600b007ae5dd6e62dmr14928967eja.518.1668548091822;
        Tue, 15 Nov 2022 13:34:51 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id e1-20020aa7d7c1000000b00463c367024bsm6582301eds.63.2022.11.15.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:34:51 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: Add basic support for BIQU CB1
Date:   Tue, 15 Nov 2022 22:34:49 +0100
Message-ID: <8140265.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <AZ0DLR.RINPITJM904E2@somainline.org>
References: <20221114214452.1993744-1-martin.botka@somainline.org> <4534857.CvnuH1ECHv@jernej-laptop> <AZ0DLR.RINPITJM904E2@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. november 2022 ob 23:54:46 CET je Martin Botka napisal(a=
):
> On Mon, Nov 14 2022 at 11:30:17 PM +01:00:00, Jernej =C5=A0krabec
>=20
> <jernej.skrabec@gmail.com> wrote:
> > Hi Martin,
> >=20
> > I was just writing new e-mail as response to v2. You should wait at
> > least a
> > day or two, usually more, before sending new version. Others will
> > likely have
> > some more comments. And there is also no rush. Until PMIC series is
> > merged,
> > this will not go anywhere. Since there is only this week until cut
> > off date for
> > DT updates for kernel 6.2, it's most likely that this will land in
> > 6.3. And
> > that gives as a few weeks (month) more.
>=20
> Yep. Was hoping for 5.2 thus the frequent updates. Will take it slow
> then since 5.3 :)

You're way too late for 5.x series :) Anyway, 6.2 would be possible if you=
=20
would have almost flawless patch with no additional dependencies, but that =
is=20
not the case here. I'll send DT pull requests for 6.2 at the end of this we=
ek.

Best regards,
Jernej

>=20
> > See comments below.
> >=20
> > Dne ponedeljek, 14. november 2022 ob 22:44:49 CET je Martin Botka
> >=20
> > napisal(a):
> >>  CB1 is Compute Module style board that plugs into Rpi board style
> >>=20
> >> adapter or
> >>=20
> >>  Manta 3D printer boards (M4P/M8P).
> >> =20
> >>  The board has:
> >>  	H616 SoC
> >>  	1GB of RAM
> >>  	AXP313A PMIC
> >> =20
> >>  And the actual boards that CB1 plugs in are just extension to it
> >>=20
> >> with ports
> >>=20
> >>  and thus are not split in DT.
> >> =20
> >>  Boards have:
> >>  	4x (3x for Manta boards) USB and 1 USB OTG.
> >>  	SDcard slot for loading images.
> >>  	Ethernet port wired to the internal PHY.
> >>  	2x HDMI 2.0.
> >=20
> > H616 has only one HDMI output. Unless there is some additional chip
> > for some
> > conversion, only one HDMI port can work.
>=20
> Yes correct. But the Rpi adapter and Manta boards also support
> Rpi Compute Module 4 which has 2 HDMI outputs.
> The chip itself ofc doesnt support this on CB1. Same goes for DSI/CSI
> ports
> on the boards and the 4x USB on Rpi adapter.
>=20
> It is indeed a bit of a mess.
>=20
> >>  	Power and Status LEDs.
> >> =20
> >>  Currently working:
> >>  	Booting
> >>  	USB
> >>  	UART
> >> =20
> >>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>  ---
> >>  Changes in V2:
> >>  Add proper board compatible
> >>  Add regulator prefix for vcc5v
> >>  Drop okay status from PMIC
> >>  Drop standby_param
> >>  Changes in V3:
> >>  Change copyright to me
> >>  regulator_vcc5v to regulator-vcc5v
> >>  Drop ehci0 and ohci0
> >> =20
> >>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>   .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 178
> >>=20
> >> ++++++++++++++++++
> >>=20
> >>   2 files changed, 179 insertions(+)
> >>   create mode 100644
> >>=20
> >> arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> >>=20
> >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >>  b/arch/arm64/boot/dts/allwinner/Makefile index
> >>=20
> >> 6a96494a2e0a..223f1be73541
> >>=20
> >>  100644
> >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>  @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-b.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >> =20
> >>  +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-biqu-cb1.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >> =20
> >>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts new file
> >>=20
> >> mode
> >>=20
> >>  100644
> >>  index 000000000000..86b5aca9b53e
> >>  --- /dev/null
> >>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> >>  @@ -0,0 +1,178 @@
> >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>  +/*
> >>  + * Copyright (C) 2022 Martin Botka <martin.botka@somainline.org>.
> >>  + */
> >>  +
> >>  +/dts-v1/;
> >>  +
> >>  +#include "sun50i-h616.dtsi"
> >>  +
> >>  +#include <dt-bindings/gpio/gpio.h>
> >>  +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  +#include <dt-bindings/leds/common.h>
> >>  +
> >>  +/ {
> >>  +	model =3D "BIQU CB1";
> >>  +	compatible =3D "biqu,cb1", "allwinner,sun50i-h616";
> >>  +
> >>  +	aliases {
> >>  +		serial0 =3D &uart0;
> >>  +	};
> >>  +
> >>  +	chosen {
> >>  +		stdout-path =3D "serial0:115200n8";
> >>  +	};
> >>  +
> >>  +	leds {
> >>  +		compatible =3D "gpio-leds";
> >>  +
> >>  +		led-0 {
> >>  +			function =3D LED_FUNCTION_POWER;
> >>  +			color =3D <LED_COLOR_ID_RED>;
> >>  +			gpios =3D <&pio 2 12 GPIO_ACTIVE_HIGH>; /*
> >=20
> > PC12 */
> >=20
> >>  +			default-state =3D "on";
> >>  +		};
> >>  +
> >>  +		led-1 {
> >>  +			function =3D LED_FUNCTION_STATUS;
> >>  +			color =3D <LED_COLOR_ID_GREEN>;
> >>  +			gpios =3D <&pio 2 13 GPIO_ACTIVE_HIGH>; /*
> >=20
> > PC13 */
> >=20
> >>  +		};
> >>  +	};
> >>  +
> >>  +	reg_vcc5v: regulator-vcc5v {
> >>  +		/* board wide 5V supply directly from the USB-C socket
> >=20
> > */
> >=20
> >>  +		compatible =3D "regulator-fixed";
> >>  +		regulator-name =3D "vcc-5v";
> >>  +		regulator-min-microvolt =3D <5000000>;
> >>  +		regulator-max-microvolt =3D <5000000>;
> >>  +		regulator-always-on;
> >>  +	};
> >>  +
> >>  +	reg_usb1_vbus: regulator-usb1-vbus {
> >>  +		compatible =3D "regulator-fixed";
> >>  +		regulator-name =3D "usb1-vbus";
> >>  +		regulator-min-microvolt =3D <5000000>;
> >>  +		regulator-max-microvolt =3D <5000000>;
> >>  +		vin-supply =3D <&reg_vcc5v>;
> >>  +		enable-active-high;
> >>  +		gpio =3D <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> >>  +	};
> >>  +};
> >>  +
> >>  +&ehci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ehci2 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ehci3 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&mmc0 {
> >>  +	vmmc-supply =3D <&reg_dldo1>;
> >>  +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> >>  +	no-1-8-v;
> >=20
> > Above property is not needed. If you don't provide vqmmc-supply with
> > 1.8 V
> > regulator, it won't be used.
> >=20
> >>  +	bus-width =3D <4>;
> >>  +	status =3D "disabled";
> >=20
> > Why is set to disabled? If it's not a typo, remove whole node. It
> > could be
> > added later when it works.
>=20
> Would not removing it also make PMIC node useless as the regulators
> wont be used and thus
> should be technically removed ?
>=20
> >>  +};
> >>  +
> >>  +&ohci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci2 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci3 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&r_i2c {
> >>  +	status =3D "okay";
> >>  +
> >>  +	axp1530: pmic@36 {
> >>  +		compatible =3D "x-powers,axp1530";
> >=20
> > I just checked datasheet and it really seems that it supports only
> > I2C.
> > Anyway, rather than using axp1530 compatible, introduce axp313a
> > compatible
> > instead.
>=20
> Will do in V2 for drivers later.
>=20
> >>  +		reg =3D <0x36>;
> >>  +		wakeup-source;
> >>  +
> >>  +		regulators{
> >>  +			reg_dcdc1: dcdc1 {
> >>  +				regulator-name =3D "axp1530-
dcdc1";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <500000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <3400000>;
> >=20
> > This one is most likely used by CPU. If so, you should set
> > appropriate range
> > according to CPU needs, which are 810 - 1100 mV.
> >=20
> >>  +				regulator-step-delay-us =3D <25>;
> >>  +				regulator-final-delay-us =3D <50>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dcdc2: dcdc2 {
> >>  +				regulator-name =3D "axp1530-
dcdc2";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <500000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1540000>;
> >=20
> > This one is most likely used by GPU. Its range must also be adjusted
> > to GPU
> > needs.
> >=20
> >>  +				regulator-step-delay-us =3D <25>;
> >>  +				regulator-final-delay-us =3D <50>;
> >>  +				regulator-ramp-delay =3D <200>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dcdc3: dcdc3 {
> >>  +				regulator-name =3D "axp1530-
dcdc3";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <500000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1840000>;
> >=20
> > This one looks like it supplies DRAM. You should set both min and max
> > to
> > actual DRAM needs.
> >=20
> >>  +				regulator-step-delay-us =3D <25>;
> >>  +				regulator-final-delay-us =3D <50>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_aldo1: ldo1 {
> >=20
> > ldo1 -> aldo1
> >=20
> >>  +				regulator-name =3D "axp1530-
aldo1";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <1800000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1800000>;
> >=20
> >>  +				regulator-step-delay-us =3D <25>;
> >>  +				regulator-final-delay-us =3D <50>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dldo1: ldo2 {
> >=20
> > ldo2 -> dldo1
> >=20
> > Another issue I see is that you marked all regulators with
> > regulator-always-
> > on; While this works, I don't think this faithfully represent HW. For
> > example,
> > GPU regulator will be enabled by GPU driver when needed, so it
> > shouldn't be
> > marked with always on.
> >=20
> > There is also RTCLDO, but without schematic it's impossible to say if
> > it is
> > used or not.
> >=20
> > There are at least a few clues in AXP313A datasheet about which
> > regulator is
> > used for what. See chapter 7.5 in
> > https://github.com/bigtreetech/CB1-Kernel/
> > blob/kernel-5.16/docs/AXP313A%20datasheet%20V0.1%20-
> > %2020201105_draft%20version.pdf
>=20
> As for regulators themselves. I have kept them as what downstream
> kernel specifies.
> But until I have schematic in hand and can confirm that they actually
> used the correct regulators in
> the correct place i will stick to stock values. If they in the end
> decide to not supply schematic or etc
> to the public i can test with adjusted values.
>=20
> > Best regards,
> > Jernej
> >=20
> >>  +				regulator-name =3D "axp1530-
dldo1";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <3300000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <3300000>;
> >=20
> >>  +				regulator-step-delay-us =3D <25>;
> >>  +				regulator-final-delay-us =3D <50>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +		};
> >>  +	};
> >>  +};
> >>  +
> >>  +&uart0 {
> >>  +	pinctrl-names =3D "default";
> >>  +	pinctrl-0 =3D <&uart0_ph_pins>;
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&usbotg {
> >>  +	/*
> >>  +	 * PHY0 pins are connected to a USB-C socket, but a role switch
> >>  +	 * is not implemented: both CC pins are pulled to GND.
> >>  +	 * The VBUS pins power the device, so a fixed peripheral mode
> >>  +	 * is the best choice.
> >>  +	 * The board can be powered via GPIOs, in this case port0 *can*
> >>  +	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> >>  +	 * then provided by the GPIOs. Any user of this setup would
> >>  +	 * need to adjust the DT accordingly: dr_mode set to "host",
> >>  +	 * enabling OHCI0 and EHCI0.
> >>  +	 */
> >>  +	dr_mode =3D "peripheral";
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&usbphy {
> >>  +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> >>  +	status =3D "okay";
> >>  +};
>=20
> Best Regards,
> Martin




