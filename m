Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0460E485
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiJZPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiJZPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:33:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1504F9737
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:33:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so8155273edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mBX4bT2qc6/G5xqtzpd0iJ6M1TPlZmSU/EpcMpqcNzM=;
        b=U51/v2w0f9bh4CquGhgtUghzC0aS52L9CRVebJ48950nhz00QgYxl2FErs8/XE6tG2
         OBjdfDhfhgAkSHEAyO1ezFmEzBbkUizjIm6roRJhDFr0OA8wAHd5rTI7kJab2X70ansT
         Bsq1CJ9EzVqc/g0itDGIwsR57YVOY6EcurqyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBX4bT2qc6/G5xqtzpd0iJ6M1TPlZmSU/EpcMpqcNzM=;
        b=AyGsDm6XoXTGA/bpq1nIS/cG0B+B4kBtFyG+gcYID0NfK3n875TkvLuJd77SakhWyo
         W2wJ5QjdD9OVoNy/Q6tSOuvXuK/aNyjw8Exl3LnSgaf3QDLAS7WvcttOlZnjBve1ZY8X
         Rr7l8kvEi+VvpWf4ZV4XwcYXKmwSW+lPMkhACnTLnD/ezic7GYpUdUB2FKsyirVXDLly
         2dGNx5PqWlrbmZB6L8NQHnpfjCnq0Yq/0DwRQEqbxCJnIC3uz0PGQXfQ8jIyUYY4epqo
         Oc6TRgThGGnIvJ75YU/QVzka+X1YRZj3TTK2NDf76AHAcpCt100Ug3AFNZRjlx76ygbS
         4psQ==
X-Gm-Message-State: ACrzQf3D6NMsHSuUmXZAc4Ivtxf0axPPPg8UisgH1Lj+aoYUQbDfUUOz
        Uqavp+lJI4GA3dXjBqQb+N2WbpzcYu4lURfx
X-Google-Smtp-Source: AMsMyM6Q4gexF0GJk8ZpTsuqgw+HxnwfMSnjQxrRwvMkFTX1VvqSPaoJS5MONMATvjlEgnz9L1YRVg==
X-Received: by 2002:a05:6402:11c7:b0:462:549d:fbbe with SMTP id j7-20020a05640211c700b00462549dfbbemr4799956edw.199.1666798423949;
        Wed, 26 Oct 2022 08:33:43 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 27-20020a508e1b000000b00456c6b4b777sm3663920edw.69.2022.10.26.08.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 08:33:41 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id z14so13480450wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:33:40 -0700 (PDT)
X-Received: by 2002:a05:6000:3c1:b0:236:5779:546d with SMTP id
 b1-20020a05600003c100b002365779546dmr18412470wrg.405.1666798420614; Wed, 26
 Oct 2022 08:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Oct 2022 08:33:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRgEF=bADEKttmtGqrQ6mDqipGZFRh7JKa5mf4ovF2iA@mail.gmail.com>
Message-ID: <CAD=FV=VRgEF=bADEKttmtGqrQ6mDqipGZFRh7JKa5mf4ovF2iA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] arm64/pinctrl: dt-bindings: qcom: sc7180: convert
 to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Thu, Oct 20, 2022 at 3:51 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> Changes since v3
> ================
> 1. Drop bindings patch: applied.
> 2. Rebase.
> 3. Add tags.
>
> Changes since v2
> ================
> 1. New patch: revert of glitch SPI CS workaround
> 2. dt-bindings: Drop entire drive-strength (not needed, brought by common TLMM
>    schema).
> 3. Add tags.
> v2: https://lore.kernel.org/all/20221013184700.87260-1-krzysztof.kozlowski@linaro.org/
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (3):
>   arm64: dts: qcom: sc7180-trogdor-homestar: fully configure secondary
>     I2S pins
>   arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid
>     glitching SPI CS at bootup on trogdor"
>   arm64: dts: qcom: sc7180: align TLMM pin configuration with DT schema
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 236 +++----
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  41 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
>  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 650 +++++++-----------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 597 ++++++++--------
>  18 files changed, 776 insertions(+), 1152 deletions(-)

I'd love to see this series land sooner rather than later. It'll cause
conflicts with pretty much any other patch to a sc7180 device tree
file, so it'd be nice to get it in the tree. ;-)


-Doug
