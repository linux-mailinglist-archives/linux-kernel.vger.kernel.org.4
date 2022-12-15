Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B264E3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLOWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLOWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:37:02 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2449B73;
        Thu, 15 Dec 2022 14:36:58 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 92FD41F676;
        Thu, 15 Dec 2022 23:36:55 +0100 (CET)
Date:   Thu, 15 Dec 2022 23:36:54 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8250: Add GPU speedbin support
Message-ID: <20221215223654.y4j4s3uei57pergj@SoMainline.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-8-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213002423.259039-8-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 01:24:23, Konrad Dybcio wrote:
> SM8250 has (at least) four GPU speed bins. With the support added on the
> driver side, wire up bin detection in the DTS to restrict lower-quality
> SKUs from running at frequencies they were not validated at.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 II (speed bin 0x7)
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index c008f49b5852..0c4ecdab1244 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -955,6 +955,18 @@ ipcc: mailbox@408000 {
>  			#mbox-cells = <2>;
>  		};
>  
> +		qfprom: efuse@784000 {
> +			compatible = "qcom,sm8250-qfprom", "qcom,qfprom";
> +			reg = <0 0x00784000 0 0x8ff>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			gpu_speed_bin: gpu_speed_bin@19b {
> +				reg = <0x19b 0x1>;
> +				bits = <5 3>;
> +			};
> +		};
> +
>  		rng: rng@793000 {
>  			compatible = "qcom,prng-ee";
>  			reg = <0 0x00793000 0 0x1000>;
> @@ -2563,49 +2575,58 @@ gpu: gpu@3d00000 {
>  
>  			qcom,gmu = <&gmu>;
>  
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
>  			status = "disabled";
>  
>  			zap-shader {
>  				memory-region = <&gpu_mem>;
>  			};
>  
> -			/* note: downstream checks gpu binning for 670 Mhz */
>  			gpu_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-670000000 {
>  					opp-hz = /bits/ 64 <670000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-supported-hw = <0x6>;
>  				};
>  
>  				opp-587000000 {
>  					opp-hz = /bits/ 64 <587000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-supported-hw = <0x7>;
>  				};
>  
>  				opp-525000000 {
>  					opp-hz = /bits/ 64 <525000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-supported-hw = <0xf>;
>  				};
>  
>  				opp-490000000 {
>  					opp-hz = /bits/ 64 <490000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-supported-hw = <0xf>;
>  				};
>  
>  				opp-441600000 {
>  					opp-hz = /bits/ 64 <441600000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +					opp-supported-hw = <0xf>;
>  				};
>  
>  				opp-400000000 {
>  					opp-hz = /bits/ 64 <400000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-supported-hw = <0xf>;
>  				};
>  
>  				opp-305000000 {
>  					opp-hz = /bits/ 64 <305000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-supported-hw = <0xf>;
>  				};
>  			};
>  		};
> -- 
> 2.39.0
> 
