Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8F64B1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiLMJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiLMJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:07:03 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B491C939;
        Tue, 13 Dec 2022 01:04:02 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1F3FE201E6;
        Tue, 13 Dec 2022 10:03:51 +0100 (CET)
Date:   Tue, 13 Dec 2022 10:03:49 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Message-ID: <20221213090349.bvatkmozbf5tjsxc@SoMainline.org>
References: <20221210133850.3664-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210133850.3664-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-10 14:38:50, Konrad Dybcio wrote:
> With enough pins set properly, the hardware buttons now also work
> like a charm.
> 
> Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III

However I also tested this on Xperia 1 III, and...

> ---
>  .../qcom/sm8350-sony-xperia-sagami-pdx214.dts | 24 ++++++++++
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 47 ++++++++++++++++++-
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> index e6824c8c2774..6fa830bdc6bd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> @@ -10,6 +10,20 @@
>  / {
>  	model = "Sony Xperia 5 III";
>  	compatible = "sony,pdx214-generic", "qcom,sm8350";
> +
> +	gpio-keys {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
> +
> +		key-google-assist {
> +			label = "Google Assistant Key";
> +			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_LEFTMETA>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};

... please move this to board DTS.  Xperia 1 III would also like to have
it mapped.  Downstream DT indicates, and my local testing confirms, that
it is identical to Xperia 5 III (i.e. common to the Sagami board).

The other buttons work great on both devices!

>  };
>  
>  &framebuffer {
> @@ -18,6 +32,16 @@ &framebuffer {
>  	stride = <(1080 * 4)>;
>  };
>  
> +&pm8350_gpios {
> +	g_assist_n: g-assist-n-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +

(And this too, of course)

- Marijn

>  &pm8350b_gpios {
>  	gpio-line-names = "NC", /* GPIO_1 */
>  			  "NC",
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index d73e1f3fa501..557b4538a031 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -49,7 +49,26 @@ framebuffer: framebuffer@e1000000 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		/* For reasons still unknown, GAssist key and Camera Focus/Shutter don't work.. */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
> +
> +		key-camera-focus {
> +			label = "Camera Focus";
> +			linux,code = <KEY_CAMERA_FOCUS>;
> +			gpios = <&pm8350b_gpios 8 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +
> +		key-camera-snapshot {
> +			label = "Camera Snapshot";
> +			linux,code = <KEY_CAMERA>;
> +			gpios = <&pm8350b_gpios 5 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
>  
>  		key-vol-down {
>  			label = "Volume Down";
> @@ -547,11 +566,37 @@ &pm8350_gpios {
>  			  "PM8350_OPTION"; /* GPIO_10 */
>  };
>  
> +&pm8350b_gpios {
> +	snapshot_n: snapshot-n-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	focus_n: focus-n-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		power-source = <0>;
> +		input-enable;
> +		bias-pull-up;
> +	};
> +};
> +
>  &pmk8350_gpios {
>  	gpio-line-names = "NC", /* GPIO_1 */
>  			  "NC",
>  			  "VOL_DOWN_N",
>  			  "PMK8350_OPTION";
> +
> +	vol_down_n: vol-down-n-state {
> +		pins = "gpio3";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
>  };
>  
>  &pmk8350_rtc {
> -- 
> 2.38.1
> 
