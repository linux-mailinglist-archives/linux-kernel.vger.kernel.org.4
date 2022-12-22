Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499F65464F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLVTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiLVTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:03:06 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896325F4;
        Thu, 22 Dec 2022 11:03:03 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9FBEC20188;
        Thu, 22 Dec 2022 20:03:00 +0100 (CET)
Date:   Thu, 22 Dec 2022 20:02:59 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Message-ID: <20221222190259.hdo7sqtucvip67i7@SoMainline.org>
References: <20221213120943.165452-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213120943.165452-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 13:09:43, Konrad Dybcio wrote:
> With enough pins set properly, the hardware buttons now also work
> like a charm.
> 
> Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Look at the 1 III again, realize there's a recessed button, add it
> to the common DT to make it work on both devices.. (Marijn)
> 
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 64 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index d73e1f3fa501..2f727e4f2e57 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -49,7 +49,35 @@ framebuffer: framebuffer@e1000000 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		/* For reasons still unknown, GAssist key and Camera Focus/Shutter don't work.. */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
> +
> +		key-camera-focus {
> +			label = "Camera Focus";
> +			linux,code = <KEY_CAMERA_FOCUS>;
> +			gpios = <&pm8350b_gpios 8 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;

I just found out that this property is deprecated in favour of
wakeup-source.  The one you use doesn't pass bindings validation anyway.

After fixing that:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

- Marijn

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
> +
> +		key-google-assist {
> +			label = "Google Assistant Key";
> +			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_LEFTMETA>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
>  
>  		key-vol-down {
>  			label = "Volume Down";
> @@ -545,6 +573,32 @@ &pm8350_gpios {
>  			  "NC",
>  			  "G_ASSIST_N",
>  			  "PM8350_OPTION"; /* GPIO_10 */
> +
> +	g_assist_n: g-assist-n-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
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
>  };
>  
>  &pmk8350_gpios {
> @@ -552,6 +606,14 @@ &pmk8350_gpios {
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
> 2.39.0
> 
