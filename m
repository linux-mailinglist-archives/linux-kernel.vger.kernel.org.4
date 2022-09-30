Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5B5F1364
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiI3UOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiI3UOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:14:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA2C13C218
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:13:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u21so3187386edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ha+dKpSD18b7SEyJFVqme7qsmksxsxZGbH3m9OgZDbM=;
        b=byuuoeNvEGfA9DoTk0fRGAN94y0fhLTVYJo2TFIx/jnQ6NdwKJ83dTGNZMGDC2MjEB
         Xn8L4huWtJDnhB3D2NJv4ROqmXWaJLs2lbfyBrM/oklu1cHT/NKPsKqDpDiE0bRDleP1
         ljEtIWDc8Lhw/job9967nDVhUOhHhXgPXYwnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ha+dKpSD18b7SEyJFVqme7qsmksxsxZGbH3m9OgZDbM=;
        b=j1H7cu5GcVe9/0CzNje9Ot3uXpx81jSOzKR44wykVmt5OGj+QUEezTM2oBR977NJau
         5dMZDqk1oJLBrs/q2WHD2eY9IQ9XmSfY5WESa5pJVYKaenPPXjDEsJGwPGpUPetZ/B6J
         n/KS8on5sXqn/3YzQljiBK2+z+W6olOhsPQ4WK/9gskWLZL8yOnni/BO7IZTdtRcy4+C
         o5Ji2MwZUjK55H5DrxQkdSx6Wy8gj0nD/kjLBiFS0YQ/oqLILI9oaSrKO+i99mcywK+D
         p9NcdtyUrOrkMkztHD1biOVSbbHBnV2XDAqaw6i7pzN583NPGsYphyr6fWzsl1xBRR1l
         iShA==
X-Gm-Message-State: ACrzQf21DtOzeW9Is8+dpm/w65lYZN0ClylFPgpCYOIDdfFcmsQL8YwA
        9pD5Ir2gsXv36pK3XZ6UsImX1wKjlCuNPXXw
X-Google-Smtp-Source: AMsMyM5xFQDf2fNbXxBc7Rsgpq0BQxOp2dWY5yaLDVKLnXpJNBpss3zJYU6bQYb5wMSJcu4xBdxWiQ==
X-Received: by 2002:a05:6402:5162:b0:457:6ef2:df3 with SMTP id d2-20020a056402516200b004576ef20df3mr9021517ede.128.1664568792059;
        Fri, 30 Sep 2022 13:13:12 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906318e00b0073d6093ac93sm1673450ejy.16.2022.09.30.13.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:13:11 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id f11so5767229wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:13:11 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr6823437wrr.583.1664568790844; Fri, 30
 Sep 2022 13:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220930182212.209804-1-krzysztof.kozlowski@linaro.org> <20220930182212.209804-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930182212.209804-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Sep 2022 13:12:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSbpV4aqyHgSX6rwanQmZYG1hdNourjP5DEmsfdq6aDA@mail.gmail.com>
Message-ID: <CAD=FV=WSbpV4aqyHgSX6rwanQmZYG1hdNourjP5DEmsfdq6aDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-db845c: correct SPI2 pins
 drive strength
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 30, 2022 at 11:22 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The pin configuration (done with generic pin controller helpers and
> as expressed by bindings) requires children nodes with either:
> 1. "pins" property and the actual configuration,
> 2. another set of nodes with above point.
>
> The qup_spi2_default pin configuration used second method - with a
> "pinmux" child.
>
> Fixes: 8d23a0040475 ("arm64: dts: qcom: db845c: add Low speed expansion i2c and spi nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 132417e2d11e..a157eab66dee 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1123,7 +1123,9 @@ &wifi {
>
>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>  &qup_spi2_default {
> -       drive-strength = <16>;
> +       pinmux {
> +               drive-strength = <16>;
> +       };

The convention on Qualcomm boards of this era is that muxing (setting
the function) is done under a "pinmux" node and, unless some of the
pins need to be treated differently like for the UARTs, configuration
(bias, drive strength, etc) is done under a "pinconf" subnode. I
believe that the "pinconf" subnode also needs to replicate the list of
pins, or at least that's what we did everywhere else on sdm845 /
sc7180.

Thus to match conventions, I assume you'd do:

&qup_spi2_default {
  pinconf {
    pins = "gpio27", "gpio28", "gpio29", "gpio30";
    drive-strength = <16>;
  };
};

We've since moved away from this to a less cumbersome approach, but
for "older" boards like db845c we should probably match the existing
convention, or have a flag day and change all sdm845 boards over to
the new convention.

-Doug
