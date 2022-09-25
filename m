Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB565E9251
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiIYLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiIYLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36831DE9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so4576836ljr.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aSKpEll+WjUReck0aTlKSCNK8n90vq02tlc2QaFeH9E=;
        b=DdPaKq6P73V5IFE1aEmY12xDQlZwE2GJlQN7GJHaoTO4Z5hlVSisVhSpolTYnYVQIR
         Im/9mDEeowyCYAkOgVgDtPg+mZhyOImj6R/jCG5jXuIWt0rYceRo7V3QWUHAksxSAre5
         gQ94Q6Na62YagnTGEXIh0/UInT/MkIJ4ZXfGRvQ4aSV2TyXkQTHxW9y5iVvhVx76ibW7
         BTWeZL+yL2nSkjZZDScvbjVDPPPIPGjS4c8EGudMyaL21/asjkc34DDT6ndI1L+j79gQ
         rpoi0qlimF9UcpJH0vjxiqFGaSq73bs4Z6u4Nx9SR5/fYyRFARxB9gKgrlq9t/3gClLr
         LyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aSKpEll+WjUReck0aTlKSCNK8n90vq02tlc2QaFeH9E=;
        b=KunKNyfVW8+04Ij/Ri1hnv4ptwrupstJmxy9lMwO/EiXvuH5r5EKvLOWq1drQ9XPv1
         ENw828FyWdyHf78ZZIwqZW3evHYqoeEYWs8cDWWGcGYT8fmLva2dxjo7k8aOxCrUudni
         FGD7biyH54m5mkHuVmzRwiVkMjYclTrI6haLrhBloAFIBB9nS+lsh2JHNZEE7GoJv5Uf
         6raLCFln2axjIxOgjUXn4ihFeEETwiLCWdoiuhQI7m5JG7BAKwDk6uZRISpbAY3jjxhj
         XQ4Ssy9t0YyzkkOqBvwCxVVOO4plm0L4pjB7D1LcMjT/LxtCWZbyet+el3pcaUEJXZpO
         C4Kg==
X-Gm-Message-State: ACrzQf1tT0JWCmrpRl56+HxJX9DNeWLYBitaAQuqvMJf5Da9v1VPB4iH
        Nd+S9YiDxEPI2f/5o4hoYSObHQ==
X-Google-Smtp-Source: AMsMyM7EU7P+BmogcjTKxRpcWmFWNoy3x0Ta5NB6zUFWXZ81UQg5Qv8LsPBpHi+7qqk/Jq+ix31DZw==
X-Received: by 2002:a2e:3010:0:b0:261:bc8f:81e9 with SMTP id w16-20020a2e3010000000b00261bc8f81e9mr5591494ljw.61.1664103973515;
        Sun, 25 Sep 2022 04:06:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:13 -0700 (PDT)
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
Subject: [PATCH 00/15] pinctrl/arm64: qcom: 4th set of Qualcomm TLMM pinctrl schema warnings
Date:   Sun, 25 Sep 2022 13:05:53 +0200
Message-Id: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
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

Overview
========
This is the *fourth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes: https://lore.kernel.org/linux-devicetree/20220922195651.345369-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes: https://lore.kernel.org/linux-devicetree/20220924080459.13084-1-krzysztof.kozlowski@linaro.org/T/#t
4. ARMv8 remaining TLMM fixes: THIS PATCHSET

Dependencies
============
1. No dependencies.
2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (15):
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
  dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8250: add input-enable
  dt-bindings: pinctrl: qcom,sc7280: add bias-bus-hold and input-enable
  dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs

 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  12 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 153 ++---
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
 22 files changed, 594 insertions(+), 725 deletions(-)

-- 
2.34.1

