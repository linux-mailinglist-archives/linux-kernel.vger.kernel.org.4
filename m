Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59A7448A8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGALEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGALE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:04:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88F3C02;
        Sat,  1 Jul 2023 04:04:26 -0700 (PDT)
Received: from i53875a33.versanet.de ([83.135.90.51] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qFYOo-0000lG-Ek; Sat, 01 Jul 2023 13:04:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ocfox <i@ocfox.me>
Cc:     ocfox <i@ocfox.me>
Subject: Re: [PATCH] arm64: dts: rockchip: add support for Rongpin king3399 board
Date:   Sat, 01 Jul 2023 13:04:16 +0200
Message-ID: <4811978.GXAFRqVoOG@diego>
In-Reply-To: <20230630173010.272469-1-i@ocfox.me>
References: <20230630173010.272469-1-i@ocfox.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

all of what Krzysztof said in his mail + the stuff below please:

Am Freitag, 30. Juni 2023, 19:27:52 CEST schrieb ocfox:
> king3399 is a bord from Rongpin, you can find detail about
> it here:
> (http://www.rpdzkj.com/copy_2_1703937_175104_2536441.html)
> 
> This patch add basic node for the board and make it able to bring
> up.
> 
> Works:
> - USB, type-C port
> - Ethernet
> - WiFi/BT
> - HDMI
> - eMMC
> - PCIe
> - sd-card
> 
> Not test for other peripheral:
> - AUDIO
> - MIC
> - SIM
> - MIPI
> 
> Signed-off-by: ocfox <i@ocfox.me>

I think we request a full name here and as patch author.

[...]

> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	// 4G Module

please use a consistent comment style ... in the "/* foobar */" style

> +	vcc3v3_gsm: vcc3v3-gsm {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>; // bsp
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_gsm_en>;
> +		regulator-name = "vcc3v3_gsm";
> +		// regulator-always-on;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	// vdd 5v: USB 2&3, USB Hub, Type-C, HDMI, MIPI, IR

so this regulator controls all of those?

In that case maybe do it similarly to vcc1v8-s3 and use multiple labels
for the node - i.e. the line name leading to the consumer from the
schematics.

That way comparing schematics against the dts gets easier.

See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts#n40
for an example


> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>; // bsp
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +		regulator-name = "vcc5v0_host";
> +		// regulator-always-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_typec0: vbus-typec-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>; // bsp
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_typec_en>;
> +		regulator-name = "vcc5v0_typec0";
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_sys: vcc5v0_sys: vcc5v0-sys { // bsp
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +

double empty line

Thanks
Heiko


