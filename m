Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC255EF97E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiI2Pu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiI2Puw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:50:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C7B2A945;
        Thu, 29 Sep 2022 08:50:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCBFE15BF;
        Thu, 29 Sep 2022 08:50:54 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE953F792;
        Thu, 29 Sep 2022 08:50:44 -0700 (PDT)
Message-ID: <7ae39c9c-8424-8b65-ac09-c0e87f3b0f01@arm.com>
Date:   Thu, 29 Sep 2022 16:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v1 2/2] ARM: dts: rk3288: add the interrupts property
 for PWM
Content-Language: en-GB
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 15:04, Johan Jonker wrote:
> The Rockchip rk3288 SoC has 4-built-in PWM channels.
> 
> Configurable to operate in capture mode.
> Measures the high/low polarity effective cycles of this input waveform
> Generates a single interrupt at the transition of input waveform polarity
> 
> Configurable to operate in continuous mode or one-shot mode.
> One-shot operation will produce N + 1 periods of the waveform,
> where N is the repeat counter value, and generates a single interrupt at
> the end of operation.
> Continuous mode generates the waveform continuously and
> do not generates any interrupts.
> 
> Add interrupts property to rk3288 PWM nodes.

As far as I can make out from the TRM, these are only valid when 
GRF_SOC_CON2[0] = 0, otherwise it's in "new" RK_PWM mode using SPI 78 
for all channels. Which apparently will be the case for anyone using 
upstream U-Boot:

https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-rockchip/rk3288/rk3288.c#L83

Thanks,
Robin.

> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> ---
> 
> Original patch location:
>    ARM: dts: rk3288: add the interrupts property for PWM
>    https://github.com/rockchip-linux/kernel/commit/16b7b284618d1652e694f6286f575ce82f5f03e5
> 
> ---
> 
> "rockchip,rk3288-pwm" is in use as fall back string for Rockchip SoCs with combined
> PWM interrupt.
> ---
>   arch/arm/boot/dts/rk3288.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 487b0e03d..1223aa369 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -675,6 +675,7 @@
>   	pwm0: pwm@ff680000 {
>   		compatible = "rockchip,rk3288-pwm";
>   		reg = <0x0 0xff680000 0x0 0x10>;
> +		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>   		#pwm-cells = <3>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwm0_pin>;
> @@ -685,6 +686,7 @@
>   	pwm1: pwm@ff680010 {
>   		compatible = "rockchip,rk3288-pwm";
>   		reg = <0x0 0xff680010 0x0 0x10>;
> +		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>   		#pwm-cells = <3>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwm1_pin>;
> @@ -695,6 +697,7 @@
>   	pwm2: pwm@ff680020 {
>   		compatible = "rockchip,rk3288-pwm";
>   		reg = <0x0 0xff680020 0x0 0x10>;
> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>   		#pwm-cells = <3>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwm2_pin>;
> @@ -705,6 +708,7 @@
>   	pwm3: pwm@ff680030 {
>   		compatible = "rockchip,rk3288-pwm";
>   		reg = <0x0 0xff680030 0x0 0x10>;
> +		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>   		#pwm-cells = <3>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwm3_pin>;
