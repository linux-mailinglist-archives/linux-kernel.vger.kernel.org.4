Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5D5F1CFB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJAOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:55:08 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67CA30F61
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:55:02 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 29A3C3F4CB;
        Sat,  1 Oct 2022 16:54:59 +0200 (CEST)
Date:   Sat, 1 Oct 2022 16:54:57 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] arm64: dts: qcom: sdm845-tama: Add display nodes
Message-ID: <20221001145457.yvy5swfqmzothhy7@SoMainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
 <20220930191049.123256-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930191049.123256-2-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 21:10:42, Konrad Dybcio wrote:
> Add required nodes to support display on XZ2/XZ2c. XZ3 has a
> different power rail setup and needs to be handled separately.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../qcom/sdm845-sony-xperia-tama-akari.dts    |  4 +
>  .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 44 ++++++++-
>  .../qcom/sdm845-sony-xperia-tama-apollo.dts   |  6 ++
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 96 +++++++++++++++++++
>  4 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> index 34f84f1f1eb4..d97b7f1e7140 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
> @@ -11,3 +11,7 @@ / {
>  	model = "Sony Xperia XZ2";
>  	compatible = "sony,akari-row", "qcom,sdm845";
>  };
> +
> +&panel {
> +	compatible = "sony,td4353-jdi-tama";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> index 2f5e12deaada..2a16305ac5da 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> @@ -10,9 +10,51 @@
>  / {
>  	model = "Sony Xperia XZ3";
>  	compatible = "sony,akatsuki-row", "qcom,sdm845";
> +
> +	/* Fixed DCDC for the OLED panel */
> +	ts_vddio_supply: ts-vddio-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ts_vddio";
> +
> +		regulator-min-microvolt = <1840000>;
> +		regulator-max-microvolt = <1840000>;
> +
> +		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&ibb {
> +	status = "disabled";
> +};
> +
> +&lab {
> +	status = "disabled";
> +};
> +
> +&panel {
> +	/* Akatsuki uses an OLED panel. */
> +	/delete-property/ backlight;
> +	/delete-property/ vsp-supply;
> +	/delete-property/ vsn-supply;
> +	/delete-property/ treset-gpios;

This looks to have been a last-minute rename to

    touch-reset-gpios

> +};
> +
> +&pmi8998_wled {
> +	status = "disabled";
> +};
> +
> +&tlmm {
> +	ts_vddio_en: ts-vddio-en {
> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};
>  };
>  
> -/* For the future: WLED + LAB/IBB/OLEDB are not used on Akatsuki */
>  &vreg_l14a_1p8 {
>  	regulator-min-microvolt = <1840000>;
>  	regulator-max-microvolt = <1840000>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
> index c9e62c72f60e..cd056f78070f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
> @@ -11,3 +11,9 @@ / {
>  	model = "Sony Xperia XZ2 Compact";
>  	compatible = "sony,apollo-row", "qcom,sdm845";
>  };
> +
> +&panel {
> +	compatible = "sony,td4353-jdi-tama";
> +	height-mm = <112>;
> +	width-mm = <56>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 51ee42e3c995..ac8eb59ed010 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -326,6 +326,46 @@ vreg_s3c_0p6: smps3 {
>  	};
>  };
>  
> +&dsi0 {
> +	vdda-supply = <&vreg_l26a_1p2>;
> +	status = "okay";
> +
> +	panel: panel@0 {
> +		/* The compatible is assigned in device DTs. */
> +		reg = <0>;
> +
> +		backlight = <&pmi8998_wled>;
> +		vddio-supply = <&vreg_l14a_1p8>;
> +		vsp-supply = <&lab>;
> +		vsn-supply = <&ibb>;
> +		panel-reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		touch-reset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;

Here.

- Marijn
