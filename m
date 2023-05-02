Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E16F3FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjEBI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:57:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073611701;
        Tue,  2 May 2023 01:57:18 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ptlot-0006V9-Ob; Tue, 02 May 2023 10:57:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 8/8] arm64: dts: rockchip: Add rk3588 OTP node
Date:   Tue, 02 May 2023 10:57:10 +0200
Message-ID: <5059282.72vocr9iq0@diego>
In-Reply-To: <20230501084401.765169-9-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-9-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. Mai 2023, 10:44:00 CEST schrieb Cristian Ciocaltea:
> Add DT node for Rockchip RK3588/RK3588S OTP memory.
> 
> Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

looks good and I'll pick this up once the code and binding parts land.

Thanks
Heiko


> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 54 +++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 767084a1ec43..0abcd51d7d66 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1822,6 +1822,60 @@ spi4: spi@fecb0000 {
>  		status = "disabled";
>  	};
>  
> +	otp: efuse@fecc0000 {
> +		compatible = "rockchip,rk3588-otp";
> +		reg = <0x0 0xfecc0000 0x0 0x400>;
> +		clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
> +			 <&cru CLK_OTPC_ARB>, <&cru CLK_OTP_PHY_G>;
> +		clock-names = "otpc", "apb", "arb", "phy";
> +		resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>,
> +			 <&cru SRST_OTPC_ARB>;
> +		reset-names = "otpc", "apb", "arb";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		cpu_code: cpu-code@2 {
> +			reg = <0x02 0x2>;
> +		};
> +
> +		otp_id: id@7 {
> +			reg = <0x07 0x10>;
> +		};
> +
> +		otp_cpu_version: cpu-version@1c {
> +			reg = <0x1c 0x1>;
> +			bits = <3 3>;
> +		};
> +
> +		cpub0_leakage: cpu-leakage@17 {
> +			reg = <0x17 0x1>;
> +		};
> +
> +		cpub1_leakage: cpu-leakage@18 {
> +			reg = <0x18 0x1>;
> +		};
> +
> +		cpul_leakage: cpu-leakage@19 {
> +			reg = <0x19 0x1>;
> +		};
> +
> +		log_leakage: log-leakage@1a {
> +			reg = <0x1a 0x1>;
> +		};
> +
> +		gpu_leakage: gpu-leakage@1b {
> +			reg = <0x1b 0x1>;
> +		};
> +
> +		npu_leakage: npu-leakage@28 {
> +			reg = <0x28 0x1>;
> +		};
> +
> +		codec_leakage: codec-leakage@29 {
> +			reg = <0x29 0x1>;
> +		};
> +	};
> +
>  	dmac2: dma-controller@fed10000 {
>  		compatible = "arm,pl330", "arm,primecell";
>  		reg = <0x0 0xfed10000 0x0 0x4000>;
> 




