Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6D624182
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiKJLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiKJLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:35:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9C716DC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:35:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 140so307292pfz.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=czhmg8w6fCMkXUIfJozgJqRjYjP3QZdO8mkjxxSqqg0=;
        b=L34nsiKJho8HIN+dXht0sd19S/QtDAa/+T6+Sw+6OWNMJAtDXxS41Ujw15PQEwPMcb
         /EjLTqGA8mWnL4NLPamcwr8UMIQV9Ny59VFkJ1iAJwp181hBXyl8ZPdfALs6lLNMQl33
         yNP5RlK6Uk7Bh7H3zAX8oXNfWKveGKLAJ/j5doz9cD9cQZEbOO5Vzx8oyx7/8JxxztmP
         /pEd4Bsul0YD/tFG3jJG1WMupni6WtB3JdlWiEwLE1paBoD1GB3N64KOYLordIK7H+pa
         ogTShjdYNszYkUjhWBsFpYo1duTSmsALtRa0PDyu7kMv55i+M2Hhm8MJ04NYNp8i8AwZ
         U4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czhmg8w6fCMkXUIfJozgJqRjYjP3QZdO8mkjxxSqqg0=;
        b=JnZAyRjT5HJTbGWapk8Sn+h7Wj10Pm7BSQHx+CWyU8zDpaB85tOHIe5OnIBVgjNTcn
         5/NfMezycUDoFANBRnRfr4gc9LdXOHA69IhTu7Q6P7QsBx64j9ey20Xxn1jNHew4XeIF
         GaJ+23wNWlo022Ou60czZVX30khnyF1bzXrEqGJa4qJA/nDfSp55JdvzmKbHTfpRGwT1
         7FNgEFKRYmtlKOmt0l361LkaLfzOQa+/lkOjKFOa0t3z8jIuediKsFAeMO6wNp4xg5+H
         XnCug7s0Ht7BOaBCILeY1/oOoMCFTkGbeI6MS3mZh0LUv/WoJzuuR4NDnqSi9wSEQ1QK
         LIvg==
X-Gm-Message-State: ACrzQf2LeNS2Og+8DXrlI1LdPzTEpbte/7XRG0/h0bSRNRaPH8iMBUWY
        3xp0cUN/F7qs5+KkRMyLnIdn
X-Google-Smtp-Source: AMsMyM57AqT08jdCpsdF+MMkrOn2eIKJCwPLOpWN0N7vaxof6c0c5wHe7jTPTNPijNKQPM+L1HFCeg==
X-Received: by 2002:a63:2c90:0:b0:439:ee2c:ab2f with SMTP id s138-20020a632c90000000b00439ee2cab2fmr57202235pgs.2.1668080121097;
        Thu, 10 Nov 2022 03:35:21 -0800 (PST)
Received: from thinkpad ([59.92.98.170])
        by smtp.gmail.com with ESMTPSA id a19-20020aa794b3000000b0056c2e497ad6sm10287605pfl.93.2022.11.10.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:35:20 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:05:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi
 controller
Message-ID: <20221110113513.GA18247@thinkpad>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110103558.12690-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:35:55AM +0100, Johan Hovold wrote:
> Enable the Qualcomm QCNFA765 Wireless Network Adapter connected to
> PCIe4.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 5b9e37a16f9f..ab5b0aadeead 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -81,6 +81,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
>  		regulator-always-on;
>  	};
>  
> +	vreg_wlan: regulator-wlan {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VCC_WLAN_3R9";
> +		regulator-min-microvolt = <3900000>;
> +		regulator-max-microvolt = <3900000>;
> +
> +		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hastings_reg_en>;

Hastings is the family name of QCA639x WLAN chipsets. I don't think it would be
applicable here. Please use "wlan_reg_en" as that matches the convention used
throughout this file.

Thanks,
Mani

> +
> +		regulator-boot-on;
> +	};
> +
>  	vreg_wwan: regulator-wwan {
>  		compatible = "regulator-fixed";
>  
> @@ -246,6 +262,25 @@ &pcie3a_phy {
>  	status = "okay";
>  };
>  
> +&pcie4 {
> +	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
> +
> +	vddpe-3v3-supply = <&vreg_wlan>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie4_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie4_phy {
> +	vdda-phy-supply = <&vreg_l6d>;
> +	vdda-pll-supply = <&vreg_l4d>;
> +
> +	status = "okay";
> +};
> +
>  &pmc8280c_lpg {
>  	status = "okay";
>  };
> @@ -445,6 +480,13 @@ edp_bl_pwm: edp-bl-pwm-state {
>  	};
>  };
>  
> +&pmr735a_gpios {
> +	hastings_reg_en: hastings-reg-en-state {
> +		pins = "gpio1";
> +		function = "normal";
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> @@ -521,6 +563,29 @@ wake-n-pins {
>  		};
>  	};
>  
> +	pcie4_default: pcie4-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio140";
> +			function = "pcie4_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio141";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio139";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	qup0_i2c4_default: qup0-i2c4-default-state {
>  		pins = "gpio171", "gpio172";
>  		function = "qup4";
> -- 
> 2.37.4
> 

-- 
மணிவண்ணன் சதாசிவம்
