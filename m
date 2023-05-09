Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296086FBF42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjEIGcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjEIGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:32:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8E5FC9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:32:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643557840e4so5909171b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683613931; x=1686205931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVlG1bw+1j4LbTAdqRY6la7nACuyIs7ic3d+S0maLdg=;
        b=l7+WVNEonbYGyuPQDe/2dnITBG4anKFJRqf64Umq3x0dxscO0wKEVtuzRsHGSWJuGq
         xPhKmFHHICfUBkwhFnHJsIeU7PlQ6TrlDbea3vDI4/g9SZQfhkwUhcjStemQZSaK/0tW
         v1VmVo+yv50Fhhugioc1tC4FcoMd74sr6GVaE0987oIqY3k6jPK81jHG3lHSslLgLG+i
         wQKttgHVW2iekTPzdBPSn/0hc35lZEiRked0B68F/FNV0vYilgvruzQ1+dLH+yrCQ05e
         N2x5KrXcY/ISfaYI7GiDvrvEl9ukyKvRQT32Cgbfi1iZ2DQEpc8h9TN+YMu8jQYIgeEZ
         wAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613931; x=1686205931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVlG1bw+1j4LbTAdqRY6la7nACuyIs7ic3d+S0maLdg=;
        b=R3U5ntaQlcGmMAu5uG/yjBXoKGNBBicBsvY5HZT/XdX2GkKtxnnX6vqGGw5n5sR1Ob
         f/vKPPUqkKpQuEYQWUNw3clP/nvsxae8eRQ+ctAokLBr/s8eUFTGTyIHxASFR+G3O71N
         gG+dkyAEzYuEim+ZCXc2o+eW5dP4KdHQaViJcUQFL6qWZTMaFP9aG2gNE6/VzTJRXJUm
         b//7MiRm7HYlpcP9UMbRqdks/fTNj1FHmX5KDimYqsJ5Pv8Y7I5ANRKGQUd3xTlTrU7p
         xsU3MRTMDo6aJZ8pQTvfzRFMcNei2b06ge6JbG1RM6STvT0X/ehuZxdBWDs7IJiHPJj9
         pK9w==
X-Gm-Message-State: AC+VfDwmMS0LjW55GnXWauXVlCGEmIbYaEmCH9fkSeetpmdyDwUqzO2q
        TGva//aXGFd2hALI8CJ+fYseeG0o5cdC4eZdWw==
X-Google-Smtp-Source: ACHHUZ7cHBR3qQ4g8ZtG7OyT0so7AZGcqCSAkYCTmhwEKpvWlJ/wf91fb7UXkMd7EQGX9nOLDJy6hw==
X-Received: by 2002:a05:6a00:2442:b0:63b:854c:e0f6 with SMTP id d2-20020a056a00244200b0063b854ce0f6mr17159451pfj.21.1683613931265;
        Mon, 08 May 2023 23:32:11 -0700 (PDT)
Received: from thinkpad ([59.92.97.45])
        by smtp.gmail.com with ESMTPSA id a17-20020aa780d1000000b006372791d708sm974123pfn.104.2023.05.08.23.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:32:10 -0700 (PDT)
Date:   Tue, 9 May 2023 12:02:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on
 CRD
Message-ID: <20230509063205.GB4823@thinkpad>
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
 <20230509030136.1524860-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509030136.1524860-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 08:01:36PM -0700, Bjorn Andersson wrote:
> The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
> enabling this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 80 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 39 +++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 5b25d54b9591..f83411e0e7f8 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -308,6 +308,13 @@ vreg_l1c: ldo1 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l7c: ldo7 {
>  			regulator-name = "vreg_l7c";
>  			regulator-min-microvolt = <2504000>;
> @@ -318,6 +325,13 @@ vreg_l7c: ldo7 {
>  						   RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l9c: ldo9 {
> +			regulator-name = "vreg_l9c";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l13c: ldo13 {
>  			regulator-name = "vreg_l13c";
>  			regulator-min-microvolt = <3072000>;
> @@ -600,6 +614,18 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
>  
> +&sdc2 {
> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
> +	vmmc-supply = <&vreg_l9c>;
> +	vqmmc-supply = <&vreg_l6c>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
>  &uart17 {
>  	compatible = "qcom,geni-debug-uart";
>  
> @@ -842,6 +868,60 @@ wake-n-pins {
>  		};
>  	};
>  
> +	sdc2_default_state: sdc2-default-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;

Since the card detect is active low, shouldn't the pin be pulled high to avoid
floating? Or is there an external pull up available on the board?

- Mani

> +		};
> +	};
> +
> +	sdc2_sleep_state: sdc2-sleep-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
>  	tpad_default: tpad-default-state {
>  		int-n-pins {
>  			pins = "gpio182";
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..21dfb48d923c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2815,6 +2815,45 @@ data-pins {
>  			};
>  		};
>  
> +		sdc2: mmc@8804000 {
> +			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC4_BCR>;
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			iommus = <&apps_smmu 0x4e0 0x0>;
> +			power-domains = <&rpmhpd SC8280XP_CX>;
> +			operating-points-v2 = <&sdc2_opp_table>;
> +			bus-width = <4>;
> +			dma-coherent;
> +
> +			status = "disabled";
> +
> +			sdc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
>  		usb_0_qmpphy: phy@88eb000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088eb000 0 0x4000>;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
