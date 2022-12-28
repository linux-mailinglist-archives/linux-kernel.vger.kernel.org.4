Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C91658657
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiL1TVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiL1TVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:21:41 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB0B7FA;
        Wed, 28 Dec 2022 11:21:39 -0800 (PST)
Received: from [80.120.31.194] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pAbzZ-000631-1G; Wed, 28 Dec 2022 20:21:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzysztof.kozlowski+dt@linaro.org, piotr.oniszczuk@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>
Cc:     Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Enable wifi module AP6398s for rk3566 box demo
Date:   Wed, 28 Dec 2022 20:21:32 +0100
Message-ID: <17226287.uLZWGnKmhe@phil>
In-Reply-To: <20221225114953.3518595-1-andyshrk@163.com>
References: <20221225114915.3518502-1-andyshrk@163.com> <20221225114953.3518595-1-andyshrk@163.com>
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

Hi Andy,

Am Sonntag, 25. Dezember 2022, 12:49:53 CET schrieb Andy Yan:
> There is a AP6398s wifi/bt module on this board.
> Fix the sdmmc1 dt node to make wifi work.
> 
> Fixes: 2e0537b16b25 ("arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board")
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  .../boot/dts/rockchip/rk3566-box-demo.dts     | 26 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> index d956496d5221..6c0c24226b52 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> @@ -324,8 +324,12 @@ wifi_enable_h: wifi-enable-h {
>  			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  
> +		wifi_host_wake_h: wifi-host-wake-l {
> +			rockchip,pins = <2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
>  		wifi_32k: wifi-32k {
> -			rockchip,pins = <0 RK_PB0 2 &pcfg_pull_none>;
> +			rockchip,pins = <2 RK_PC6 1 &pcfg_pull_none>;
>  		};
>  	};
>  
> @@ -391,16 +395,30 @@ &sdmmc0 {
>  };
>  
>  &sdmmc1 {
> +	/* WiFi & BT combo module AMPAK AP6398S */
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	bus-width = <4>;
> +	clock-frequency = <150000000>;
> +	cap-sdio-irq;
>  	cap-sd-highspeed;
> -	disable-wp;
> +	sd-uhs-sdr104;
> +	keep-power-in-suspend;
>  	mmc-pwrseq = <&sdio_pwrseq>;
>  	non-removable;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&vcca_1v8>;

why are you removing the mmc-supplies here?
The supplies needed for mmc to work should very much be present
I think, especially to also make sure something else doesn't
turn them off.

Heiko

>  	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <RK_PB2 GPIO_ACTIVE_HIGH>;
> +		interrupt-names = "host-wake";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_host_wake_h>;
> +	};
>  };
>  
>  &spdif {
> 




