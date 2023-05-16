Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E485B70540B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjEPQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjEPQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:36:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBAA9012
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:36:01 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561a41db2c0so9310397b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254959; x=1686846959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nUqoo5bjeKJlYi2oGD1rSQMIBmkcsF3eXC4Lmw5WR0s=;
        b=tmc2DdGZ5r6gRx4okAnJUowOGY2CLCp37vwDqsCXEk3bQk4NVA3a6YlY3gSaJhH31V
         mD0h4MjO8U+8JHe4yxwpKCHOrp9HduqfrDVspvG5NQZxZo2G/xB1bibkcbNOP/4BuD2q
         1DcKISbYNa8AL+Y2YYdPaRWiDjpzrBezMWnXWA51sqirs7TU86TKaVakVLTMBzdXuS9n
         vi5Ve+OtMFtaOn8S3dFVkxA4E8Q+O2r+ygYAM48krbdySTeJseFf5koak1N0V1/al1eQ
         Z2d0hOtZ7/NkNNnnSMOPq2vbR4+Irmht3aftJ4f4bnClAIYHleGc50nUx+vyBcAej5gR
         YNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254959; x=1686846959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUqoo5bjeKJlYi2oGD1rSQMIBmkcsF3eXC4Lmw5WR0s=;
        b=RW2D7vG86qnmlnitAXOhA3WIzpdkDph0DKP20nsCFp31ak6P8QFQm9SJ66BvXugzEb
         lCIwa6k1qG0q9/sqs2UW0I907OEJ48mvzFgwkadqhxKHW0kbaqcSooSQrRx05W149GUq
         B9kPZiqCDniFA+hXVxtobfxJjwFKxTIk4DdKp69tPZpqu75+cXZsqRHqugNllw3h3f0e
         rkNbNP+5w01iHz8bf93AvPSSGmDH2hXDlfXpJTlAGwILVdW8WbXO86jOlNbYKuuoTZxJ
         Fv0R+Ja4E3LhEGTSlTrp6dpcxak/EEVfaNrFwkZHF/7KKmr9Ag80SgG6fAEwXW7wgxEu
         al+Q==
X-Gm-Message-State: AC+VfDzcF/XhirTdBV3dgsUwwVysaSvJwAecQ75+LehpFDyhGO7Ge5Ku
        mS9ALk2WUzWZciia7n5Wp0OENCTXADeR9FQ2VUw2pg==
X-Google-Smtp-Source: ACHHUZ6nLiOUFrgZPvTxj8H8fMwSWbbPUhw8KejfU95u7EUG7Y3tlcIKRYWg1Otz3aP8vvO/C6WyVY+Bz/EEJ8uFd/o=
X-Received: by 2002:a81:c312:0:b0:559:d103:d5c8 with SMTP id
 r18-20020a81c312000000b00559d103d5c8mr33917480ywk.31.1684254959496; Tue, 16
 May 2023 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org> <20230516154539.238655-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516154539.238655-3-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 19:35:48 +0300
Message-ID: <CAA8EJpoTd4avVHK4kjJTpq91UvNLS1tdA_s4=nX_gtkWAY_Jvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8550-qrd: add display and panel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 18:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
> MTP8550).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Context in the patch depends on:
> 1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
> 2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/
>
> Changes in v2:
> 1. dispcc is enabled in DTSI.
> 2. Re-order pinctrl and regulators.
> 3. Drop mdp.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

A small question below.

> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 68 +++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 30b36a149125..ade6ba53ae6b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -431,6 +431,46 @@ &gcc {
>                  <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>  };
>
> +&mdss {
> +       status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +       vdda-supply = <&vreg_l3e_1p2>;
> +       status = "okay";
> +
> +       panel@0 {
> +               compatible = "visionox,vtdr6130";
> +               reg = <0>;
> +
> +               pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
> +               pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
> +               pinctrl-names = "default", "sleep";
> +
> +               vci-supply = <&vreg_l13b_3p0>;
> +               vdd-supply = <&vreg_l11b_1p2>;
> +               vddio-supply = <&vreg_l12b_1p8>;
> +
> +               reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +               port {
> +                       panel0_in: endpoint {
> +                               remote-endpoint = <&mdss_dsi0_out>;
> +                       };
> +               };
> +       };
> +};
> +
> +&mdss_dsi0_out {
> +       remote-endpoint = <&panel0_in>;
> +       data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +       vdds-supply = <&vreg_l1e_0p88>;
> +       status = "okay";
> +};
> +
>  &pcie_1_phy_aux_clk {
>         status = "disabled";
>  };
> @@ -532,6 +572,34 @@ wcd_tx: codec@0,3 {
>  &tlmm {
>         gpio-reserved-ranges = <32 8>;
>
> +       sde_dsi_active: sde-dsi-active-state {
> +               pins = "gpio133";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-disable;
> +       };
> +
> +       sde_dsi_suspend: sde-dsi-suspend-state {
> +               pins = "gpio133";
> +               function = "gpio";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };
> +
> +       sde_te_active: sde-te-active-state {
> +               pins = "gpio86";
> +               function = "mdp_vsync";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };
> +
> +       sde_te_suspend: sde-te-suspend-state {
> +               pins = "gpio86";
> +               function = "mdp_vsync";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };

Do we really need the suspend states for reset and TE pins? Especially
for the TE pin, where the only difference is the drive strength.

> +
>         wcd_default: wcd-reset-n-active-state {
>                 pins = "gpio108";
>                 function = "gpio";
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
