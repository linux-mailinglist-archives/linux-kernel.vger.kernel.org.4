Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9B61399C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiJaPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJaPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:02:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F711178
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:02:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n12so30023339eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uL4PrDj5gli4X0a8PdtqmurG3bEAKsPydYX1NP0DejI=;
        b=jiVRAH5CfODtEh+cnTJ2FqjRdB4Wns6asedhARHD/mxNwvo2nG6lZTs9D8B4QVhsY6
         Asc92/Ale0tmV3oBah6znoIPArTchbPdgHsUaBOZWklyQ6oHjRYSqdB2pVgMw9IuJzqB
         M3XO20sfrgg4XypxBix5+2zvxzlt653lztXIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uL4PrDj5gli4X0a8PdtqmurG3bEAKsPydYX1NP0DejI=;
        b=L3iupo5W9EHHsCOb+PU159ipBY+KUlmnoY8rk39ozbHclLeJlBCH8S76G0IWuyPIF5
         NNRKXpECZjb6O1KianUM0R+u45aZP8FZbOSjzQAFqe/zcYrQzWUadZgLG3S0/0RFhMMJ
         1ixo3kz5aMFZKSSQJBztaOV01DWjawQzKlmeZAcLd6zD+fnAAF9Rg4+CPKZypMO/I8NR
         clqHPayloEpv/lc8Ay0OHT7ND+iwwrFUsBHLndoqj2YIy2ctVQwfGXRfsPqJpUWodoNH
         685AHrw6OAMcNWGzq+pjnWUypNyOpDtHZo2nM1wS6TsAlSe9trU9Uwjf6K/8NmmjGtqE
         AjbQ==
X-Gm-Message-State: ACrzQf2JurDDbKhSunbwNMajcDqzoJ5a8Xei0PIkH47zNgzAsIkVAp6n
        IABxWzD/iOkE/23OY8RBcMPFCb/rH72k1w==
X-Google-Smtp-Source: AMsMyM6hmWs9Ed27iEmnrhsh2KQGzK1+Nm3SpNPqnz5HOoEmSZMmE0JVdZtVuQSaD9rB8cMuEPIXag==
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e3 with SMTP id xc10-20020a170907074a00b0077e9455b4e3mr13604976ejb.471.1667228540074;
        Mon, 31 Oct 2022 08:02:20 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id u25-20020a056402065900b00461cdda400esm3371127edx.4.2022.10.31.08.02.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:02:19 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so8196680wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:02:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3c7:8eb:fb28 with SMTP id
 o20-20020a05600c511400b003c708ebfb28mr8224980wms.93.1667228538568; Mon, 31
 Oct 2022 08:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221031102011.136945-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221031181735.v9.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
In-Reply-To: <20221031181735.v9.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Oct 2022 08:02:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xy70nvzSmBxGB7iffo5F2jtp6WuUhNBeWo7rE70jewBQ@mail.gmail.com>
Message-ID: <CAD=FV=Xy70nvzSmBxGB7iffo5F2jtp6WuUhNBeWo7rE70jewBQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] arm64: dts: qcom: sc7280: include
 sc7280-herobrine-audio-rt5682.dtsi in evoker
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

On Mon, Oct 31, 2022 at 3:20 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Include sc7280-herobrine-audio-rt5682.dtsi in evoker
> as it uses rt5682 codec.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v9:
> - new patch for evoker include rt5682.dtsi
>
>  .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> index dcdd4eecfe670..d54c07ff35f4f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts

Why are you modifying the "evoker.dts" file and not the "evoker.dtsi"
file? Does the LTE SKU not have rt5682 audio?


> @@ -8,8 +8,140 @@
>  /dts-v1/;
>
>  #include "sc7280-herobrine-evoker.dtsi"
> +#include "sc7280-herobrine-audio-rt5682.dtsi"
> +
>
>  / {
>         model = "Google Evoker";
>         compatible = "google,evoker", "qcom,sc7280";
>  };
> +
> +&sound {

This is sorted incorrectly. "&sound" sorts under "&lpass".

...though looking closer at everything, I suspect that you're going to
need to reorganize things anyway. See below.


> +       model = "sc7280-rt5682-max98360a-3mic";
> +
> +       audio-routing =
> +               "VA DMIC0", "vdd-micb",
> +               "VA DMIC1", "vdd-micb",
> +               "VA DMIC2", "vdd-micb",
> +               "VA DMIC3", "vdd-micb",
> +
> +               "Headphone Jack", "HPOL",
> +               "Headphone Jack", "HPOR";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +       dai-link@0 {
> +               link-name = "MAX98360";
> +               reg = <0>;
> +
> +               cpu {
> +                       sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +               };
> +
> +               codec {
> +                       sound-dai = <&max98360a>;
> +               };
> +       };

The way you have things organized right now, technically the entire
"dai-link@0" here should be removed. Why? You're already getting it
from "sc7280-herobrine-audio-rt5682.dtsi". ...so I would say just to
remove it, but... (see below for more).


> +       dai-link@1 {
> +               link-name = "DisplayPort";
> +               reg = <1>;
> +
> +               cpu {
> +                       sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +               };
> +
> +               codec {
> +                       sound-dai = <&mdss_dp>;
> +               };
> +       };

So dai-link@1 is confusing. You're fully overriding all of the
properties that you inherited by including
"sc7280-herobrine-audio-rt5682.dtsi". It happens to work because you
override _all_ of the properties, but it's a sign that something isn't
quite right. It feels like you are diverging _too much_ from
"sc7280-herobrine-audio-rt5682.dtsi"

My suggestion is that, instead of doing it this way, you:

1. Fully copy "sc7280-herobrine-audio-rt5682.dtsi" to a new file
called "sc7280-herobrine-audio-rt5682-3mic.dtsi".

2. Accept that there will be some duplication between the normal and
the 3mic version. I think there are enough differences that the
duplication is better than the spaghetti of overrides.

3. Try to make it so that diffs between the normal and "3mic" version
are as clean as possible so someone comparing the files can see the
exact differences.


> +       dai-link@2 {
> +               link-name = "ALC5682";
> +               reg = <1>;

Something is wrong with the above node. Your unit address (dai-link@2)
doesn't match your reg (reg = <1>;).
