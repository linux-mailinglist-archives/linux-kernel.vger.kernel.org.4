Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F495F1AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJAIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJAIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 04:54:05 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054BD12263F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 01:54:02 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 370E83F265;
        Sat,  1 Oct 2022 10:54:00 +0200 (CEST)
Date:   Sat, 1 Oct 2022 10:53:58 +0200
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
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdm845-akatsuki: Configure
 maXTouch touchscreen
Message-ID: <20221001085358.6f4qmzlb4gfuxhbw@SoMainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
 <20220930191049.123256-9-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930191049.123256-9-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 21:10:49, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Configure the maXTouch touchscreen found on Xperia XZ3 devices.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> [Konrad: clean up unused props, use generic node name]

We should make a note though to check if our touch controller supports
any of the possible values for atmel,wakeup-method, which is why this
patch wasn't sent yet.

- Marijn

> ---
>  .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> index 5c5949a51184..1668ae99dd47 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> @@ -25,6 +25,29 @@ ts_vddio_supply: ts-vddio-regulator {
>  		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		regulator-boot-on;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_vddio_en>;
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	touchscreen: touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4a>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> +		vdda-supply = <&vreg_l28a_2p8>;
> +		vdd-supply = <&ts_vddio_supply>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ts_default>;
> +		pinctrl-1 = <&ts_sleep>;
>  	};
>  };
>  
> -- 
> 2.37.3
> 
