Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABD606B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJTWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJTWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:51:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3522C824
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x15so721999qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ2fnMwkzzcUrlt3Fw/NVeA9nUJ+nnr2Hha7CQJiOpk=;
        b=ZzAmKewB3lrlF+suASqb5cFqR/atkwrjJFQRxTN4nzItV+jc0Meo3S/6l75CXfFzmd
         FCQtLKuMiWgoQQRTFg8m5P5x+S2W+Wh2nLcRyY6CIRT7V2abqPuk6FMDox/dZOJJYyi5
         fa9ro91xjm6anHGz/ZvT/+D6TMc9HMmiFv6H2By0fj9fYjkvD0skvWmAKT+Q2tyYvqTa
         xiS0n7QOjWJuf0XujxGGmtAGtLJgRXdCEPDlIQ4uc9RgKoI30wcgFdgahNScWSEDrVCI
         LWq6RC8C21UogkntMcp1n7zM5K655+xJHYG6Ll2LgF03x84nGtzks2eGN3JCpKPD7wKB
         3sEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJ2fnMwkzzcUrlt3Fw/NVeA9nUJ+nnr2Hha7CQJiOpk=;
        b=cMoQNlj8rSCqLCEiDlB7x7Qmuw4fRk8CiJTPuPaCO6V5HNnZhCWcv1JMr+AXX3hT7Q
         kOm5KrKEmj9YZDRlLnwwgtBBcx3j0tOLiyGjeGAfanb+XXaOVe86fFHkFAbSh1Cww1fH
         l//ybVYHOcLXxbnxX84NC00tH5fVvuLLZHNDf6gjQ5x1FZ4PxkVIeUGdeuuGgZkFdzU0
         AxcbaVjJpGNHQx1RPkTEBVxw3lhIwXnlwmPMyLvvspTKUyPEi38oqd+fBq4Rl1TC7NMY
         qIbOoZE3mqRHEcLVmcjOl5wMxrndGMVQZpkZBW1JBsIdwikRefvL+C4mvhGHzeRwngZe
         nKXQ==
X-Gm-Message-State: ACrzQf1WHYIrRhOmbP3oCFTqz88JB+y4Hdt7GoTGywxA/R6hPLF1rGEc
        1PLUpfB7Fjw9iiLX56jM7apz6w==
X-Google-Smtp-Source: AMsMyM6ZYp4ANf+l94jK/CL+Z2C9Vn6alVFc/ybjhWwM7RIuQ96aJgsBD3Ry1CQBtcj56dvINeQfBw==
X-Received: by 2002:a05:6214:4015:b0:4b1:78f2:8dfd with SMTP id kd21-20020a056214401500b004b178f28dfdmr14120578qvb.81.1666306298222;
        Thu, 20 Oct 2022 15:51:38 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0039cc9d24843sm6903479qtb.66.2022.10.20.15.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:51:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/3] arm64/pinctrl: dt-bindings: qcom: sc7180: convert to dtschema
Date:   Thu, 20 Oct 2022 18:51:32 -0400
Message-Id: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v3
================
1. Drop bindings patch: applied.
2. Rebase.
3. Add tags.

Changes since v2
================
1. New patch: revert of glitch SPI CS workaround
2. dt-bindings: Drop entire drive-strength (not needed, brought by common TLMM
   schema).
3. Add tags.
v2: https://lore.kernel.org/all/20221013184700.87260-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  arm64: dts: qcom: sc7180-trogdor-homestar: fully configure secondary
    I2S pins
  arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid
    glitching SPI CS at bootup on trogdor"
  arm64: dts: qcom: sc7180: align TLMM pin configuration with DT schema

 arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 236 +++----
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  41 +-
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
 .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 650 +++++++-----------
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 597 ++++++++--------
 18 files changed, 776 insertions(+), 1152 deletions(-)

-- 
2.34.1

