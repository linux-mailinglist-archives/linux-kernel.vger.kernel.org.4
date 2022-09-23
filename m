Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B25E7DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiIWO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiIWO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE4F2749
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:56:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a26so1264662ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4+lbMVqBe5DEhzCC92dvorqle54/FtFt59bo4nLc+Pw=;
        b=d3nTrMzvf2hjKN7X81+lQ6pEMXtwyt5wUV6uTqIPZ2SMjn8ftZE8yGDPRP9k/RX50c
         I2Pe5FqCVYGgkmdBCGJ9SuAbiavdgSYDrtXzsy678IJ9E8rfbr1HR9lUgMmxCiUV5R3v
         SBZuojYgzGl5QlNJVlD1x3Cajp/+4X08GQJ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4+lbMVqBe5DEhzCC92dvorqle54/FtFt59bo4nLc+Pw=;
        b=udYNr22kQ/3XCLoJhqwTcDSoOBeCriyHyHy2MZHFrotoMKGkDb8+ESx+UQpmUAZkJu
         sVzqFJx90aOzGV96xEnjo/NNHWxvfD1yTp4xKNNmJJISUeSTioSfKYal9dQry3B04dV8
         1MTM+v2kFTJK1XacCCJ79rmZikAqjktTcOV4NBovK8lcDyYit9UDYknzL+I210On4KoS
         rLf35i8nojFzD9ueSm4hLM5U6KLmt8lmpVElpBYDbIiQv5mskTOVG75PMCbD9fmrphoJ
         sFgxsTZu8BSLrYwrU6/jHFCzN+vvL5UkdITY8uQtkA/D1Pjt0BjREBBRq3twoaqrLcbq
         5ukQ==
X-Gm-Message-State: ACrzQf1yqwvmKnuwaX2+LMlR4J4ZyRVs99RMZ/tXRIGoNH0PWNeeouZO
        pNVlXOVRGGn4He2620SUya0a78TylV3KOMug
X-Google-Smtp-Source: AMsMyM7qOBW0X3y2DEtBXmDJCU9G5OL/BSpprmfUV9+TIlr8hOEcIavbVApV4FdJN5C1OiNHY1H34g==
X-Received: by 2002:a17:907:6e27:b0:782:9f5f:fb5a with SMTP id sd39-20020a1709076e2700b007829f5ffb5amr3021791ejc.75.1663944992118;
        Fri, 23 Sep 2022 07:56:32 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fe8e000000b0043bbb3535d6sm5592257edt.66.2022.09.23.07.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:56:31 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so5359324wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:56:31 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr6047824wmr.57.1663944990895; Fri, 23
 Sep 2022 07:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220923083657.v5.3.Iea2d2918adfff2825b87d428b5732717425c196f@changeid>
In-Reply-To: <20220923083657.v5.3.Iea2d2918adfff2825b87d428b5732717425c196f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:56:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VjeX_9VsZo7OiC0U6iNqn1o_WOsTGWOfhG7B3sp37New@mail.gmail.com>
Message-ID: <CAD=FV=VjeX_9VsZo7OiC0U6iNqn1o_WOsTGWOfhG7B3sp37New@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add sc7180-pazquel360
To:     Yunlong Jia <ecs.beijing2022@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Fri, Sep 23, 2022 at 1:47 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> Create first version device tree for pazquel360
> pazquel360 is convertible and the pazquel it is based on is clamshell.
> sku 20 for lte & wifi
> sku 21 for wifi only
> sku 22 for lte w/o esim & wifi
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> (no changes since v4)
>
> Changes in v4:
>  1. Adjust the 'Signed-off-by'.
>  2. Add touchscreen setting in dtsi.
>
> Changes in v2:
>  1. Remove the touchscreen setting, as a follow-up patch
>
>  arch/arm64/boot/dts/qcom/Makefile             |  2 +
>  .../qcom/sc7180-trogdor-pazquel360-lte.dts    | 22 ++++++
>  .../qcom/sc7180-trogdor-pazquel360-wifi.dts   | 17 +++++
>  .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 71 +++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi

If you're planning on a second pull request this cycle, it'd be great
if patch #1 and #3 from this series could be included. Thanks!

-Doug
