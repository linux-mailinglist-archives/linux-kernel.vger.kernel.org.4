Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0477D619A71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKDOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:47:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A474D7F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:47:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i21so7911572edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0XMZxLpKp6sM5ddBmHApVnUcrmXcDrT4/Dd2XyiDnI=;
        b=ASWIaotkEY5BZkz9DRyfH4Oumf8URlC5euMiy2gao+zTN47+0MTBibXGTE3Yj5LONw
         m4ysUoDpNNlOp/dqX+t8BHu4AL4gqhA7BVDxOk8pCVzNi4jWf37GQcWnzmq0kPxVtxAe
         Nbpep3/lkscyzgI4i5WMBa1kwpVfX1vtu8vBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0XMZxLpKp6sM5ddBmHApVnUcrmXcDrT4/Dd2XyiDnI=;
        b=UVMK+9sS+5DtExZD4Q9tIOWr3mwwNiwPBz1ZDb0XMbgJs+a31r1MnmU+oZDOVuJzVd
         R/Iu7++aGbD7qnDs5RgmqEAEfYC/69k9uEw64fHvz2zv4W66rlGb4NE6fW0m1eyCBg53
         zjmKMECjbz4trDO/poYWVGUrZwVJOaibJSUUm4xWz/3I2qG+gs3BrfG2dqT2ABOPqGYU
         lFFOhWCwrLzT6MlbCuXPPLlPWLOVlSko2VmgzbjTsZs4402E7g+6j74PkvsO9JIRQdJI
         HlSVzVaZJhgPpK5W0X7iRjqdXA0FdDvCM81886T/PuV3saHKjHwCvVZjt5nAmQv6bUXC
         i7nw==
X-Gm-Message-State: ACrzQf11pr7EYupl2csTWJnezBHUyIXBOv99NmbzhlAlzi0qqDXTz1GE
        kydDW8bfCGeEIddWSKHR4lc9emhLLsT9fTJe
X-Google-Smtp-Source: AMsMyM4QA4EUR0ZgLsLjxLifjZoHTQTeEjGFJ/+fvuA2omev2s8fVmAdbApvxqHmEuAyEt6UXIG8tA==
X-Received: by 2002:aa7:cb09:0:b0:461:e6b6:4bad with SMTP id s9-20020aa7cb09000000b00461e6b64badmr12924607edt.27.1667573225001;
        Fri, 04 Nov 2022 07:47:05 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b0073dbaeb50f6sm1861150ejy.169.2022.11.04.07.47.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:47:04 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso3310614wmp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:47:03 -0700 (PDT)
X-Received: by 2002:a1c:4c16:0:b0:3cf:6f1a:9038 with SMTP id
 z22-20020a1c4c16000000b003cf6f1a9038mr20783641wmf.151.1667573223504; Fri, 04
 Nov 2022 07:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
In-Reply-To: <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Nov 2022 07:46:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8DyZq4o9J-NOzt9QzG1EM+E3_nv2t5Wdt__ard3t7Yw@mail.gmail.com>
Message-ID: <CAD=FV=V8DyZq4o9J-NOzt9QzG1EM+E3_nv2t5Wdt__ard3t7Yw@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.dtsi
 for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 3, 2022 at 11:29 PM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> add specific 3mic setting as sc7280-herobrine-audio-rt5682-3mic.dtsi,
> so we can include sc7280-herobrine-audio-rt5682-3mic.dtsi for evoker
> as it uses rt5682 with 3 mics.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v10:
> - add evoker include specific sc7280-herobrine-audio-rt5682-3mic.dtsi setting
>
>  .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 194 ++++++++++++++++++
>  .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   2 +
>  2 files changed, 196 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> new file mode 100644
> index 0000000000000..01bc8ee93b19a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + * This file defines the common audio settings for the child boards
> + * using rt5682 codec and having 3 dmics connected to sc7280.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/ {
> +       /* BOARD-SPECIFIC TOP LEVEL NODES */
> +       sound: sound {
> +               compatible = "google,sc7280-herobrine";
> +               model = "sc7280-rt5682-max98360a-3mic";
> +
> +               status = "okay";

As others have mentioned, you don't need the status "okay" here. You
only need that if you're overriding a parent dtsi file's "disabled"
status.


> +               audio-routing =
> +                       "VA DMIC0", "vdd-micb",
> +                       "VA DMIC1", "vdd-micb",
> +                       "VA DMIC2", "vdd-micb",
> +                       "VA DMIC3", "vdd-micb",
> +
> +                       "Headphone Jack", "HPOL",
> +                       "Headphone Jack", "HPOR";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               dai-link@0 {
> +                       link-name = "MAX98360";
> +                       reg = <0>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&max98360a>;
> +                       };
> +               };
> +
> +               dai-link@1 {
> +                       link-name = "DisplayPort";
> +                       reg = <1>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&mdss_dp>;
> +                       };
> +               };
> +
> +               dai-link@2 {
> +                       link-name = "ALC5682";
> +                       reg = <2>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_PRIMARY>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&alc5682 0 /* aif1 */>;
> +                       };
> +               };
> +
> +               dai-link@4 {
> +                       link-name = "DMIC";
> +                       reg = <4>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&lpass_va_macro 0>;
> +                       };
> +               };
> +       };
> +};
> +
> +hp_i2c: &i2c2 {
> +       status = "okay";

As others have mentioned, the new convention is for status to be the
last property so you should update this.

...ideally you could add a patch to your series that makes similar
cleanups to the 1-mic version to keep diffs clean.


> +       clock-frequency = <400000>;
> +
> +       alc5682: codec@1a {
> +               compatible = "realtek,rt5682s";
> +               reg = <0x1a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hp_irq>;
> +
> +               #sound-dai-cells = <1>;
> +
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
> +
> +               AVDD-supply = <&pp1800_alc5682>;
> +               MICVDD-supply = <&pp3300_codec>;
> +
> +               realtek,dmic1-data-pin = <1>;
> +               realtek,dmic1-clk-pin = <2>;
> +               realtek,jd-src = <1>;
> +               realtek,dmic-clk-rate-hz = <2048000>;
> +       };
> +};
> +
> +&lpass_cpu {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
> +                       <&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       dai-link@0 {
> +               reg = <MI2S_PRIMARY>;
> +               qcom,playback-sd-lines = <1>;
> +               qcom,capture-sd-lines = <0>;
> +       };
> +
> +       dai-link@1 {
> +               reg = <MI2S_SECONDARY>;
> +               qcom,playback-sd-lines = <0>;
> +       };
> +
> +       dai-link@5 {
> +               reg = <LPASS_DP_RX>;
> +       };
> +
> +       dai-link@25 {
> +               reg = <LPASS_CDC_DMA_VA_TX0>;
> +       };
> +};
> +
> +&lpass_va_macro {
> +       status = "okay";
> +       vdd-micb-supply = <&pp1800_l2c>;
> +       pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
> +                       <&lpass_dmic23_data>;
> +};

Can you add here:

/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */

...which will make it obvious that the sort order resets. Our current
convention is that pinctrl stuff is at the bottom of the file and
sorted separately from the non-pinctrl stuff.


> +&mi2s0_data0 {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_data1 {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_mclk {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_sclk {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_ws {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&lpass_dmic01_clk {
> +       drive-strength = <8>;
> +       bias-disable;
> +};

As others have mentioned, "&lpass" sorts before "&mi2s" so these
should be listed above.


> +&lpass_dmic01_clk_sleep {
> +       drive-strength = <2>;
> +};
> +
> +&lpass_dmic01_data {
> +       bias-pull-down;
> +};
> +
> +&lpass_dmic23_clk {
> +       drive-strength = <8>;
> +       bias-disable;
> +};
> +
> +&lpass_dmic23_clk_sleep {
> +       drive-strength = <2>;
> +};
> +
> +&lpass_dmic23_data {
> +       bias-pull-down;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> index dcdd4eecfe670..d608682f9742b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> @@ -8,6 +8,8 @@
>  /dts-v1/;
>
>  #include "sc7280-herobrine-evoker.dtsi"
> +#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
> +

Get rid of extra blank line you added here.


>  / {
>         model = "Google Evoker";
> --
> 2.34.1
>
