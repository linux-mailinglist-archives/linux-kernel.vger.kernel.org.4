Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4372FE97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbjFNM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbjFNM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:27:07 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DD19BC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:27:05 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 015143F21C;
        Wed, 14 Jun 2023 14:27:03 +0200 (CEST)
Date:   Wed, 14 Jun 2023 14:27:02 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
Message-ID: <i6rvfbq4dl2qqjgm2k6ofkbbj5gugpj6jxpgacxawgcmhg2vp3@xux66b3lqfvb>
References: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
 <20230614-topic-edo_pinsgpiopmic-v1-4-cf88a0bac26c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v1-4-cf88a0bac26c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 14:11:49, Konrad Dybcio wrote:
> Set up the corresponding GPIOs properly and add the leftover hardware
> buttons to mark this piece of the puzzle complete.
> 
> Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")

This commit did not add any keys, did you mean:

Fixes: 46e14907c716 ("arm64: dts: qcom: sm8250-edo: Add hardware keys")

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

The patch itself has been working fine on both devices for a very long
time:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 10 ++++
>  .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      | 54 +++++++++++++++++++---
>  2 files changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> index ea4571bf4fbf..58a521046f5f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
> @@ -20,6 +20,8 @@ &framebuffer {
>  };
>  
>  &gpio_keys {
> +	pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
> +
>  	g-assist-key {
>  		label = "Google Assistant Key";
>  		linux,code = <KEY_LEFTMETA>;
> @@ -48,6 +50,14 @@ &pm8150_gpios {
>  			  "SP_ARI_PWR_ALARM",
>  			  "NC",
>  			  "NC"; /* GPIO_10 */
> +
> +	g_assist_n: g-assist-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
>  };
>  
>  &pm8150b_gpios {
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> index 9f9e7e9784fe..e55a94e5ff08 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> @@ -50,12 +50,26 @@ framebuffer: framebuffer@9c000000 {
>  	gpio_keys: gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		/*
> -		 * Camera focus (light press) and camera snapshot (full press)
> -		 * seem not to work properly.. Adding the former one stalls the CPU
> -		 * and the latter kills the volume down key for whatever reason. In any
> -		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
> -		 */
> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
> +		pinctrl-names = "default";
> +
> +		key-camera-focus {
> +			label = "Camera Focus";
> +			linux,code = <KEY_CAMERA_FOCUS>;
> +			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +
> +		key-camera-snapshot {
> +			label = "Camera Snapshot";
> +			linux,code = <KEY_CAMERA>;
> +			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
>  
>  		key-vol-down {
>  			label = "Volume Down";
> @@ -543,6 +557,34 @@ &pcie2_phy {
>  	vdda-pll-supply = <&vreg_l9a_1p2>;
>  };
>  
> +&pm8150_gpios {
> +	vol_down_n: vol-down-n-state {
> +		pins = "gpio1";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&pm8150b_gpios {
> +	snapshot_n: snapshot-n-state {
> +		pins = "gpio1";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	focus_n: focus-n-state {
> +		pins = "gpio2";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> 
> -- 
> 2.41.0
> 
