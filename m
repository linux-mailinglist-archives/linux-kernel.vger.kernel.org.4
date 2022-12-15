Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC264E3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLOWhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLOWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:37:35 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA005EDC0;
        Thu, 15 Dec 2022 14:37:34 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1D61E1F676;
        Thu, 15 Dec 2022 23:37:32 +0100 (CET)
Date:   Thu, 15 Dec 2022 23:37:30 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8150: Add GPU speedbin support
Message-ID: <20221215223730.4bijpy3qyplruksi@SoMainline.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-7-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213002423.259039-7-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 01:24:22, Konrad Dybcio wrote:
> SM8150 has (at least) two GPU speed bins. With the support added on the
> driver side, wire up bin detection in the DTS to restrict lower-quality
> SKUs from running at frequencies they were not validated at.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index e160acb47cd9..3f940cc3f32b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -936,6 +936,17 @@ ethernet: ethernet@20000 {
>  			status = "disabled";
>  		};
>  
> +		qfprom: efuse@784000 {
> +			compatible = "qcom,sm8150-qfprom", "qcom,qfprom";
> +			reg = <0 0x00784000 0 0x8ff>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			gpu_speed_bin: gpu_speed_bin@133 {
> +				reg = <0x133 0x1>;
> +				bits = <5 3>;
> +			};
> +		};
>  
>  		qupv3_id_0: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
> @@ -2137,6 +2148,9 @@ gpu: gpu@2c00000 {
>  
>  			qcom,gmu = <&gmu>;
>  
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
>  			status = "disabled";
>  
>  			zap-shader {
> @@ -2150,31 +2164,37 @@ gpu_opp_table: opp-table {

Just like sm8250, you can probably delete the:

    /* note: downstream checks gpu binning for 675 Mhz */

comment right above this node.

- Marijn

>  				opp-675000000 {
>  					opp-hz = /bits/ 64 <675000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-supported-hw = <0x2>;
>  				};
>  
>  				opp-585000000 {
>  					opp-hz = /bits/ 64 <585000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-supported-hw = <0x3>;
>  				};
>  
>  				opp-499200000 {
>  					opp-hz = /bits/ 64 <499200000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-supported-hw = <0x3>;
>  				};
>  
>  				opp-427000000 {
>  					opp-hz = /bits/ 64 <427000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-supported-hw = <0x3>;
>  				};
>  
>  				opp-345000000 {
>  					opp-hz = /bits/ 64 <345000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-supported-hw = <0x3>;
>  				};
>  
>  				opp-257000000 {
>  					opp-hz = /bits/ 64 <257000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-supported-hw = <0x3>;
>  				};
>  			};
>  		};
> -- 
> 2.39.0
> 
