Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF86CA50B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0NB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjC0NBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:01:53 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C6180;
        Mon, 27 Mar 2023 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1679922108; bh=2SpnPqLtqpbyoU5Mu8W45/agko8KO5tTBt51+r5cEmo=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=CfDBixKKV2R5qLtooYFYmZ7OZXnQ2AMahYvXUkc/9rYTExJ/r1dZRur4e/aXg0vv2
         U1iTqeuI+ANRGRBeGEd0saXlyFdl5ul5AfmB+CKVZLYACk9wFctzijvmaMGqsRaRVg
         yabYjyhKXnLbUWi3X+3SG4PVgOL5ZOHjKv/wL0iQ=
Date:   Mon, 27 Mar 2023 15:01:47 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
Message-ID: <20230327130147.wgxl2qayhzsi2xak@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230327074136.1459212-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327074136.1459212-1-javierm@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I've tried the patch on top of linus/master and it works as expected. My
DRM test app shows 16.669ms between frames. The display output is ok on
developer batch pinephone pro, and is corrupted on production version.
Display also doesn't come back after blanking. All as expected.

Tested-by: Ondrej Jirman <megi@xff.cz>

A few more comments below.

On Mon, Mar 27, 2023 at 09:41:35AM +0200, Javier Martinez Canillas wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The phone's display is using a Hannstar LCD panel. Support it by adding a
> panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v2:
> - Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
> - Fix assigned-clock-parents in vopb node (Ondrej Jirman).
> - Add vopl and vopl nodes.
> 
>  .../dts/rockchip/rk3399-pinephone-pro.dts     | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index a0795a2b1cb1..5116f156d548 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -29,6 +29,12 @@ chosen {
>  		stdout-path = "serial2:115200n8";
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 1000000 0>;

This (1 kHz) seems to be outside of the range of recommended dimming frequency
of SY7203: https://megous.com/dl/tmp/fb79af4023a5f102.png It's too low.

The consequence is that there's a large ripple on the positive input of the
feedback comparator https://megous.com/dl/tmp/e155900fecb0323f.png which
will cause similar instability in backlight brightness.

I've hooked up a photoresistor to a scope, and the display is indeed varying the
brightness at 1 kHz https://megous.com/dl/tmp/09cb95c7b4b2892b.png

There are two variants of SY7203 which differ by ouput regulation technique.
One with this internal integrator, and other with direct PWM control of the
output. My guess is that PPP uses the integrator variant.

I switched PWM period to 50000 (20 kHz recommended by the datasheet and the
flicker is gone https://megous.com/dl/tmp/31b6bfc51badde3b.png

So I think higher PWM frequency will be better suited here, and this may really
be the LED driver variant with the integrator.

(Photoresistors are not that fast, but I've hooked a LED to signal generator,
to simulate 20kHz blinking backlight, and I was still able to catch the pattern
on the scope via a photoresistor, so it looks like this verifies that it
would still be possible to measure some flicker at 20 kHz using this technique.
I guess I should buy a PIN diode for the next time. :))

> +		pwm-delay-us = <10000>;
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -102,6 +108,32 @@ wifi_pwrseq: sdio-wifi-pwrseq {
>  		/* WL_REG_ON on module */
>  		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	/* MIPI DSI panel 1.8v supply */
> +	vcc1v8_lcd: vcc1v8-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		regulator-name = "vcc1v8_lcd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		gpio = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&display_pwren1>;
> +	};
> +
> +	/* MIPI DSI panel 2.8v supply */
> +	vcc2v8_lcd: vcc2v8-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		regulator-name = "vcc2v8_lcd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&display_pwren>;
> +	};
>  };
>  
>  &cpu_alert0 {
> @@ -139,6 +171,11 @@ &emmc_phy {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	clock-frequency = <400000>;
>  	i2c-scl-rising-time-ns = <168>;
> @@ -362,6 +399,40 @@ &io_domains {
>  	status = "okay";
>  };
>  
> +&mipi_dsi {
> +	status = "okay";
> +	clock-master;
> +
> +	ports {
> +		mipi_out: port@1 {
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			mipi_out_panel: endpoint {
> +				remote-endpoint = <&mipi_in_panel>;
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "hannstar,hsd060bhw4";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		reset-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
> +		vcc-supply = <&vcc2v8_lcd>; // 2v8
> +		iovcc-supply = <&vcc1v8_lcd>; // 1v8

The comments here are a bit useless.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&display_rst_l>;
> +
> +		port {
> +			mipi_in_panel: endpoint {
> +				remote-endpoint = <&mipi_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
>  &pmu_io_domains {
>  	pmu1830-supply = <&vcc_1v8>;
>  	status = "okay";
> @@ -374,6 +445,20 @@ pwrbtn_pin: pwrbtn-pin {
>  		};
>  	};
>  
> +	dsi {
> +		display_rst_l: display-rst-l {
> +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};

This pin already has oboard pull-down resistor: https://megous.com/dl/tmp/ec7f9852bfaa46af.png
And it's named LCD_RST in the schematic.

> +		display_pwren: display-pwren {
> +			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		display_pwren1: display-pwren1 {
> +			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};

I wonder if there's any use in enabling pull-downs when the pin is always driven
by the SoC. Also these pins are name LCD_PWREN / LCD_PWREN1 in the schematic.

kind regards,
	o.

> +	};
> +
>  	pmic {
>  		pmic_int_l: pmic-int-l {
>  			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> @@ -429,6 +514,10 @@ &sdio0 {
>  	status = "okay";
>  };
>  
> +&pwm0 {
> +	status = "okay";
> +};
> +
>  &sdmmc {
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> @@ -479,3 +568,25 @@ bluetooth {
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&vopb {
> +	status = "okay";
> +	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>, <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> +	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> +	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP0_DIV>;
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +	assigned-clocks = <&cru DCLK_VOP1_DIV>, <&cru DCLK_VOP1>, <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> +	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP1_DIV>;
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> 
> base-commit: da8e7da11e4ba758caf4c149cc8d8cd555aefe5f
> -- 
> 2.39.2
> 
