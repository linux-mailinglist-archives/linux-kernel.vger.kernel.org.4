Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1B6193BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKDJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:41:52 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53326578;
        Fri,  4 Nov 2022 02:41:51 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CC786401FC;
        Fri,  4 Nov 2022 10:41:48 +0100 (CET)
Message-ID: <a7489c04-4aa6-5ec5-315b-fcdf93f1ea7b@somainline.org>
Date:   Fri, 4 Nov 2022 10:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104092045.17410-1-johan+linaro@kernel.org>
 <20221104092045.17410-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104092045.17410-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 10:20, Johan Hovold wrote:
> Update the UFS PHY nodes to match the new binding.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 49 +++++++++-----------------
>   1 file changed, 17 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index e0d0fb6994b5..1b309fa93484 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -896,7 +896,7 @@ ufs_mem_hc: ufs@1d84000 {
>   				     "jedec,ufs-2.0";
>   			reg = <0 0x01d84000 0 0x3000>;
>   			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> -			phys = <&ufs_mem_phy_lanes>;
> +			phys = <&ufs_mem_phy>;
>   			phy-names = "ufsphy";
>   			lanes-per-direction = <2>;
>   			#reset-cells = <1>;
> @@ -937,27 +937,20 @@ ufs_mem_hc: ufs@1d84000 {
>   
>   		ufs_mem_phy: phy@1d87000 {
>   			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> -			reg = <0 0x01d87000 0 0x1c8>;
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> -			clock-names = "ref",
> -				      "ref_aux";
> +			reg = <0 0x01d87000 0 0x1000>;
> +
>   			clocks = <&gcc GCC_UFS_CARD_CLKREF_CLK>,
>   				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +			clock-names = "ref", "ref_aux";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
>   
>   			resets = <&ufs_mem_hc 0>;
>   			reset-names = "ufsphy";
> -			status = "disabled";
>   
> -			ufs_mem_phy_lanes: phy@1d87400 {
> -				reg = <0 0x01d87400 0 0x108>,
> -				      <0 0x01d87600 0 0x1e0>,
> -				      <0 0x01d87c00 0 0x1dc>,
> -				      <0 0x01d87800 0 0x108>,
> -				      <0 0x01d87a00 0 0x1e0>;
> -				#phy-cells = <0>;
> -			};
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
>   		};
>   
>   		ufs_card_hc: ufs@1da4000 {
> @@ -965,7 +958,7 @@ ufs_card_hc: ufs@1da4000 {
>   				     "jedec,ufs-2.0";
>   			reg = <0 0x01da4000 0 0x3000>;
>   			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> -			phys = <&ufs_card_phy_lanes>;
> +			phys = <&ufs_card_phy>;
>   			phy-names = "ufsphy";
>   			lanes-per-direction = <2>;
>   			#reset-cells = <1>;
> @@ -1005,28 +998,20 @@ ufs_card_hc: ufs@1da4000 {
>   
>   		ufs_card_phy: phy@1da7000 {
>   			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> -			reg = <0 0x01da7000 0 0x1c8>;
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> -			clock-names = "ref",
> -				      "ref_aux";
> +			reg = <0 0x01da7000 0 0x1000>;
> +
>   			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
>   				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
> +			clock-names = "ref", "ref_aux";
> +
> +			power-domains = <&gcc UFS_CARD_GDSC>;
>   
>   			resets = <&ufs_card_hc 0>;
>   			reset-names = "ufsphy";
>   
> -			status = "disabled";
> +			#phy-cells = <0>;
>   
> -			ufs_card_phy_lanes: phy@1da7400 {
> -				reg = <0 0x01da7400 0 0x108>,
> -				      <0 0x01da7600 0 0x1e0>,
> -				      <0 0x01da7c00 0 0x1dc>,
> -				      <0 0x01da7800 0 0x108>,
> -				      <0 0x01da7a00 0 0x1e0>;
> -				#phy-cells = <0>;
> -			};
> +			status = "disabled";
>   		};
>   
>   		tcsr_mutex: hwlock@1f40000 {
