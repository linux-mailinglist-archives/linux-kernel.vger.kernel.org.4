Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E009363FD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiLBAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiLBAuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571ACD7AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:50:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fc4so1227549ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7pFB+ZvlcrA8R79s7DUy7BFXLwcQol/AYjTA4sACPo=;
        b=L9GHDfR84Id1CY6HR4mg5KxP96kN0GT3UaBgmyWCgrj+17Kj66luUSBTwgx+QJANfU
         ZNWC4ILSyeqj48kxKnBUQ+aN1bUUmji4fvyf/IljruXwv4pDdYOmZCB7zzmNMtXgueIX
         6vd19tOOrS+jBOQKfR1Pa3GlU7MXJlliRINiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7pFB+ZvlcrA8R79s7DUy7BFXLwcQol/AYjTA4sACPo=;
        b=MxEHxPoedw68z94LX7lATorlUL1LkPiZRRVjHcTjuiCWQB6qa8HQ9xwPTJQigfiteK
         cSE3eG8+LWojZtTcPcXIu1phSpUv4+lDE1HBe51WTLBzdSSfiVPiO3I5keDPxRFv71oE
         c+beQy7qW8wGeE1mmL0w9DMzI7H5/Tr63qTx2zr30pFxbUl3TLoj9Q6eYOU5oqh9CLxr
         N2F8I3PtbaHzOxHIcbsKa8q+jv/mIFG0b0L7QQIIH5VHiS5xfh4it75DUDF2wKa5A0J8
         KNBy8UizfzP+UIUyS3gAxw3o2Q86uHnnX+U2Q5vstcau9pqsuXyFoelxxpu+bofHmPCL
         kmug==
X-Gm-Message-State: ANoB5plsEJMeOmCmC7RQAJDsfK2Zi32baL75OCWl619/cGZHyEYF0S1K
        rilcJ4g3f5ri771tnyBRL8q4ZYy9FAaMOl+k
X-Google-Smtp-Source: AA0mqf5RwY2JlWJqPrbZPIaUpQnY1orQwRsJ2f24ejzPiWwxjZaoZPuFMAHrlWm/A5F25IFWolBehw==
X-Received: by 2002:a17:906:14c2:b0:78d:554f:fb16 with SMTP id y2-20020a17090614c200b0078d554ffb16mr58293705ejc.151.1669942237503;
        Thu, 01 Dec 2022 16:50:37 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b004615f7495e0sm2307776edw.8.2022.12.01.16.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 16:50:36 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3109190wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:50:36 -0800 (PST)
X-Received: by 2002:a7b:c4d8:0:b0:3cf:b0ed:de9d with SMTP id
 g24-20020a7bc4d8000000b003cfb0edde9dmr36726708wmk.188.1669942236049; Thu, 01
 Dec 2022 16:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org> <20221118164201.321147-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118164201.321147-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Dec 2022 16:50:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
Message-ID: <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 2/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Fritz Koenig <frkoenig@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 18, 2022 at 8:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
> This should not have an functional impact.

Added Rob Clark and Fritz who are the only people I know that still do
anything with cheza.


> -       wcd_intr_default: wcd_intr_default {
> +       wcd_intr_default: wcd-intr-default-state {
>                 pins = <54>;

Not new to your patch, but I'm surprised it truly works to use an
integer for a pin? How does it know that 54 is an integer and not a
string???


>  &qup_uart3_default {
> -       pinmux {
> -               pins = "gpio41", "gpio42", "gpio43", "gpio44";
> +       cts-rts-pins {
> +               pins = "gpio41", "gpio42";
>                 function = "qup3";
>         };
>  };

FWIW, I would have expected that the SoC dtsi file would get a "4-pin"
definition (similar to what you did with qup_uart6_4pin) and then we'd
use that here.


>                         qup_uart6_4pin: qup-uart6-4pin-state {
> -
> -                               cts-pins {
> +                               qup_uart6_4pin_cts: cts-pins {
>                                         pins = "gpio45";
>                                         function = "qup6";
> -                                       bias-pull-down;

After your patch, where is the above bias set for cheza, db845c,
oneplus, shift-axolotl, ...?


>                                 };
>
> -                               rts-tx-pins {
> +                               qup_uart6_4pin_rts_tx: rts-tx-pins {
>                                         pins = "gpio46", "gpio47";
>                                         function = "qup6";
> -                                       drive-strength = <2>;
> -                                       bias-disable;

After your patch, where is the above bias / drive-strength set?


>                                 };
>
> -                               rx-pins {
> +                               qup_uart6_4pin_rx: rx-pins {
>                                         pins = "gpio48";
>                                         function = "qup6";
> -                                       bias-pull-up;

After your patch, where is the above bias set?
