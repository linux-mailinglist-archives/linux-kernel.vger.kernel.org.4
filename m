Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CE600185
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJPRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJPRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:01:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88832EED
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c23so6521529qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKWTzuIQ+UY7Vl2aQL/YutH5RFr6mmoFL47bEWvwb5E=;
        b=TrvYmb1rvRW3Zcbp3ShULpfNM4Z8vU9dzlqLH58nTvu1nLSXFTMLxwbrS4LyYaJjFM
         B40lkW0rhAaZJjfm82OWQ9h7VniqIRkbb08RbRMKBrYak8tN+QoBiBad3MZzfW5cWlIZ
         kW3klK6Xmq3GE/dJql/pxnoyaG//eBGJP4ClJvifdaMKyjY2vL6Quwi5eevC1KOR5ojx
         5vACME6fywo3d0H2qbej6bQGrEHAxH9S2rCYdQ4D2VZpvpY/RWX8k3wKjsNSeiAVVWa3
         jSDPO1uWasXQdWmSeftEEOz5Cxr6jh7LrJChQOIsOO3shqnch8xHFarShUA+3e4yelIm
         IIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKWTzuIQ+UY7Vl2aQL/YutH5RFr6mmoFL47bEWvwb5E=;
        b=l1o2WUbIapDjuObxs1ZUri1LGQbIwA0ClCxkSPtMlTXvbGu9mwsA399MEf/+ufkWrf
         5zisRZ+qFJaK6l2Oag+9vYv9hpktHncgxU0V/sb5YFKwnelNq5L7ovV/Zfw+HxGbqNZ/
         lynwPWC9XqgBTsMsIGFT326eR9r/Fjfch/ai1owDUfgUuRmcCgtigCJMvk8wCtCUBDv1
         8ksCW8hViS+za4/Uw1+RhQGWNS5vNUVgU4v3Yvbj9DT0hIFtkVjhtSOqHIOVQFGrZazc
         xU5E7ZQe5NnHZJEcDwZ4wNc5aG3bvGg3DigX3nzS525CzF4SluMFifnGIDEXrolmpT/a
         XDSQ==
X-Gm-Message-State: ACrzQf0F1LCNlFgbE+v7jnhcAXy9PzaYPE7u/UAzoTc5dwRNLeVJeJHl
        HnfipdZZVKlmApeUL7FDNgL2JQ==
X-Google-Smtp-Source: AMsMyM6w8w/mwUZmNLo6F7MwrJthXFsOG4ohNvdOIFZo+F7hNq5BOjJTakGx+dvaMpw0KoicpDAsIQ==
X-Received: by 2002:ac8:5908:0:b0:39c:d7dd:14e9 with SMTP id 8-20020ac85908000000b0039cd7dd14e9mr5848176qty.623.1665939673837;
        Sun, 16 Oct 2022 10:01:13 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (third set)
Date:   Sun, 16 Oct 2022 13:00:01 -0400
Message-Id: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

Changes since v4
================
1. Drop drive-strength (included by common TLMM node).

Changes since v3
================
1. All patches with subject: "use common TLMM schema":
   Drop properties and required items which are already provided by common TLMM
   schema.
   The change against v3 is non-trivial, however I retained reviewed-by tags.
2. Add Rb tags.

Changes since v2
================
1. ipq6018-cp01-c1: do not switch to blsp1 (Robert).
2. pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions: new patch.
3. Drop quotes from $ref when not needed (Rob).
4. Add Rb tags. Few patches from v1 got review from Rob, but I changed them in
   v2 significantly, so I did not keep these Rb tags.

Changes since v1
================
v1: https://lore.kernel.org/linux-devicetree/20220924080459.13084-1-krzysztof.kozlowski@linaro.org/T/#t
1. As Stephan suggested, move check for function on non-GPIO pins to common
   TLMM schema.  This affects few commits in the set named:
   "use common TLMM schema"
   "do not require function on non-GPIOs"

Overview
========
This is the third, independent patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes: *THIS PATCHSET*
4. ARMv8 remaining TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
5. Fifth clean - styles and using common TLMM schema:
   https://lore.kernel.org/linux-arm-msm/20221011172358.69043-1-krzysztof.kozlowski@linaro.org/T/#m277d25a5f3e9d10ca8221a7fba62ca468a67a60b

Dependencies
============
1. No dependencies.
2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (34):
  arm64: dts: qcom: ipq6018-cp01-c1: use BLSPI1 pins
  arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT schema
  ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
  ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
  ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
  ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
  dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
  dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
  dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
  dt-bindings: pinctrl: qcom,ipq6018: increase number of pins in pinmux
  dt-bindings: pinctrl: qcom,ipq6018: fix matching pin config
  dt-bindings: pinctrl: qcom,ipq6018: use common TLMM schema
  dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
  dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
  dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
  dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
  dt-bindings: pinctrl: qcom,msm8226: fix indentation in example
  dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
  dt-bindings: pinctrl: qcom,msm8909-tlmm: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
  dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
  dt-bindings: pinctrl: qcom,msm8953: use common TLMM schema
  dt-bindings: pinctrl: qcom,msm8953: fix indentation in example
  dt-bindings: pinctrl: qcom,mdm9607: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
  dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
  dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
  dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
  dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
  dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
  dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
  dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
  dt-bindings: pinctrl: qcom,sc7280: fix matching pin config
  dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example
    (remaining piece)

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 106 +++++++-----------
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         |  23 ++--
 .../pinctrl/qcom,msm8226-pinctrl.yaml         |  98 +++++++---------
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   |  64 +++++------
 .../pinctrl/qcom,msm8953-pinctrl.yaml         |  92 ++++++---------
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         |  52 ++-------
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  14 ++-
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |   4 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  |  90 ++++++---------
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  |  50 +++------
 .../bindings/pinctrl/qcom,tlmm-common.yaml    |  20 +++-
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   |   6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           |  24 ++--
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  30 ++---
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |  45 +++-----
 arch/arm/boot/dts/qcom-sdx55.dtsi             |   1 +
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts  |   6 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   4 +-
 18 files changed, 296 insertions(+), 433 deletions(-)

-- 
2.34.1

