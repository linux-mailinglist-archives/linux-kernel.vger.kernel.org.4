Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18015F127C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiI3TaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiI3TaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B022BE00
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:29:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j16so8349699lfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=c6dBz51PeAfFzfu1dvrW09Y82wCfJytVz4BgKjYBGXM=;
        b=XE5dj86zMuEJqxUQ2W75AzzSTm6hVvsRhZXK56mi7t2Gjmyr7TL9swJK1q8cOb3ycT
         fU6NrckzoSAMoBmThWa0ZNvOytLNGbq5tLcht9JbXXO1L0BppVb31RL6HQ7FtWMVyraW
         paDNw1hr59L8Zh9Rf9nd3sgeVMxDPWWUy7nFBZlqpBaiT/OJtCWYKwE1p6PAQ8N9MiM0
         A4BCV84SQwUhyqFtZmcsCXjoPqiU8YoCsq6F2u8QuSLPIBA2ToL//nIeu2oEl1XW96PI
         2lIYDhDakheP5VIgqYmid9FnplrwSqlq6W/52hfzS5FAyPGsi1Rvc0rq3WrPhkg/FZ5p
         loBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c6dBz51PeAfFzfu1dvrW09Y82wCfJytVz4BgKjYBGXM=;
        b=oLN1wQ7VnOtGvaJQeAk+CdVNHGHB1T3iIQ6RwXJvcc6jQIadH1meVLpC1WyTJBgfyu
         mA4kSKwWLo7tknaFEDQKRzxtO3EdKkUaTq4OFogceu0IldlfiPpEjTAufd9QazXTiECP
         ByA2Zq0kRHhFbHjCohjuAYavAobM9HyLVRJsiJx63Rho0whb9LSo3XIt2y03CZOz2DD1
         oNTHNJJ4jHWvYkmWVP0Zk16LRcCdfwoZi37QIPeX7sv7J3I2Bn4rL8GCFDU+EkXdBsCE
         ceFP5AYn4NlxSnW7G+cXR2Ax3HybAFqlXy2wlrOQc+tixsNbBUxTBw0Z1EIhKCaQKeBw
         zY8Q==
X-Gm-Message-State: ACrzQf0+P9g5HApg9O3PvHqY+aYpHudJOoWcXu1Y+gYfX26YODcItDmU
        guUSAwWVRy5BwF89JNYikivuGQ==
X-Google-Smtp-Source: AMsMyM7xeIeYcumct5MiBRor7ByAVu27zUMdanAGXLjSv31cgyDNJu5U2phpoU5uy1L/wXwN2oASnA==
X-Received: by 2002:a05:6512:3e1e:b0:499:34:e8a7 with SMTP id i30-20020a0565123e1e00b004990034e8a7mr3638751lfv.655.1664566197348;
        Fri, 30 Sep 2022 12:29:57 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:29:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/16] pinctrl/arm64: qcom: 4th set of Qualcomm TLMM pinctrl schema warnings
Date:   Fri, 30 Sep 2022 21:29:38 +0200
Message-Id: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1
================
1. Check for function on non-GPIO pins was moved to common TLMM schema, thus
   new patch #12: dt-bindings: pinctrl: qcom,sm8250: drop checks used in common
   TLMM

2. Above also makes minor context changes in patch #13 "dt-bindings: pinctrl:
   qcom,sm8250: fix matching pin config"

3. Add tags (I am using `b4 trailers` so they might appear in odd order).

Overview
========
This is the *fourth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20220927173702.5200-1-krzysztof.kozlowski@linaro.org/T/#t
4. ARMv8 remaining TLMM fixes: *THIS PATCHSET*

Dependencies
============
1. Almost no dependencies - logically the bindings patch "dt-bindings: pinctrl:
   qcom,sm8250: drop checks used in common TLMM" depends on patchset #3 above.
   This is not a hard-dependency, everything will compile nicely, no warnings.

2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (16):
  arm64: dts: qcom: sm8250: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm8250-sony-xperia-edo: fix touchscreen bias-disable
  arm64: dts: qcom: sc8280xp: align TLMM pin configuration with DT
    schema
  arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
    (really)
  arm64: dts: qcom: sc7280-herobrine: correct number of gpio-line-names
  arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
  arm64: dts: qcom: msm8953: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm6125-sony-xperia: add missing SD CD GPIO functions
  arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
  dt-bindings: pinctrl: qcom,sm8250: add gpio-reserved-ranges and
    gpio-line-names
  dt-bindings: pinctrl: qcom,sm8250: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8250: add input-enable
  dt-bindings: pinctrl: qcom,sc7280: add bias-bus-hold and input-enable
  dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs

 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  12 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 145 ++---
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  70 +--
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  12 +-
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts    |   8 +-
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   |   1 -
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 -
 .../dts/qcom/sc7280-herobrine-villager.dtsi   |   1 -
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  26 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  20 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++-----
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  12 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  12 +-
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |   2 +-
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |   2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       |  38 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  18 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 556 +++++++-----------
 22 files changed, 586 insertions(+), 725 deletions(-)

-- 
2.34.1

