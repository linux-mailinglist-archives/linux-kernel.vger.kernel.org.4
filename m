Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4E625026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKKC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:29:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07599101CF;
        Thu, 10 Nov 2022 18:29:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9215D61E64;
        Fri, 11 Nov 2022 02:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F344C433C1;
        Fri, 11 Nov 2022 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668133760;
        bh=vYIHNd0LLF5q0Hnjxkc0hp3WrnEuBycva2XaWrIrDuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtUqLF5MXRsJx3lyExUx21dXbRa/UTWY5oHU9Q3f1tCxAsmFiullpVaA3Ram5nt0L
         S8ishdYkKhTgnqEjF7bJXafOZRFhA13Gu0vLGBAyrja/DY3xNA7spo1zxKhYEPM1Ko
         7uvivvZE9QtKfCU+MX8hCYOZoKtlxXvwamSECEEg/b9FP6qCloIkMK/ixlTyLEsD4P
         nQZ8vQ7Un+RplU87AxxIH2U3S1Yz67n+3YY6tdDWVezoziucMZhO8UK2USWuIdD6qz
         0JIiWqPFBLPttvV1rbUv0Hn4x/bjXrik4ylcWMGCYZAGNIsQRpQrxLQbuX9TsJPaLS
         WhR965MHIEKHw==
Date:   Fri, 11 Nov 2022 10:29:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info
Subject: Re: [PATCH v10 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Message-ID: <20221111022908.GE125525@dragon>
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-5-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026114908.191472-5-alistair@alistair23.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:49:08PM +1000, Alistair Francis wrote:
> Add support for the cyttsp5 touchscreen controller for the reMarkable 2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 100 ++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index a2a91bfdd98e..fea480af8e48 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  #include "imx7d.dtsi"
> +#include <dt-bindings/input/linux-event-codes.h>
>  
>  / {
>  	model = "reMarkable 2.0";
> @@ -47,6 +48,18 @@ reg_digitizer: regulator-digitizer {
>  		startup-delay-us = <100000>; /* 100 ms */
>  	};
>  
> +	reg_touch: regulator-touch {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_3V3_TOUCH";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pinctrl_touch_reg>;
> +		pinctrl-1 = <&pinctrl_touch_reg>;
> +		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> @@ -84,6 +97,70 @@ wacom_digitizer: digitizer@9 {
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	tsc@24 {

`touchscreen` for node name?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

Unnecessary newline.

> +		compatible = "cypress,tt21000";

We idiomatically begin property list with compatible.

> +		reg = <0x24>;
> +

Unnecessary newline.

Shawn

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&reg_touch>;
> +		touchscreen-size-x = <880>;
> +		touchscreen-size-y = <1280>;
> +
> +		button@0 {
> +			reg = <0>;
> +			linux,keycodes = <KEY_HOMEPAGE>;
> +		};
> +
> +		button@1 {
> +			reg = <1>;
> +			linux,keycodes = <KEY_MENU>;
> +		};
> +
> +		button@2 {
> +			reg = <2>;
> +			linux,keycodes = <KEY_BACK>;
> +		};
> +
> +		button@3 {
> +			reg = <3>;
> +			linux,keycodes = <KEY_SEARCH>;
> +		};
> +
> +		button@4 {
> +			reg = <4>;
> +			linux,keycodes = <KEY_VOLUMEDOWN>;
> +		};
> +
> +		button@5 {
> +			reg = <5>;
> +			linux,keycodes = <KEY_VOLUMEUP>;
> +		};
> +
> +		button@6 {
> +			reg = <6>;
> +			linux,keycodes = <KEY_CAMERA>;
> +		};
> +
> +		button@7 {
> +			reg = <7>;
> +			linux,keycodes = <KEY_POWER>;
> +		};
> +	};
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -177,6 +254,15 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
>  		>;
>  	};
>  
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			/* CYTTSP interrupt */
> +			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x54
> +			/* CYTTSP reset */
> +			MX7D_PAD_GPIO1_IO13__GPIO1_IO13		0x04
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> @@ -184,6 +270,20 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
> +			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_touch_reg: touchreggrp {
> +		fsl,pins = <
> +			/* TOUCH_PWR_EN */
> +			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x14
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> -- 
> 2.37.3
> 
