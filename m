Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5C5ECAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiI0RhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiI0RhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:37:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A591D2D2C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b24so11710217ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LdvvpBBJKqwlPh85SPg32lzmnREPbi1MuzmpiN6FRrQ=;
        b=T8zpqiFdBNC2jAYQyUHHIQUDWtISUVmzewjUVMOJmLaXTJl4ePLuZyw3CVmtMyP3Di
         Xuy4OfNO2OkjS1I3nguauwx41bId4skuoD5jLz0a+1Nn9zurZbhSOGLu0mZi0H79+pDR
         xW33E2PdPcFxJTetuDy/5zv23kfHTJpXUbSYYR+/PuicmTxjJ4OsqWth12o1eS6Cpw4q
         Igk5DtsjnoajKXNdgbArFyFA6GUTZPazLt++S85gVO+KGoRJI4JsoLeDqwnJ9kU9LGyC
         57skjd3UBn77ryZDovGFtLoMezN9h+A6WhAhRFz1zTH5MH7L7WpoQDMeF1s2d+2OHHcS
         nHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LdvvpBBJKqwlPh85SPg32lzmnREPbi1MuzmpiN6FRrQ=;
        b=LfVZa7bSdsheXjrSznR7u4AWS6cANz0+WhA/T0D/chufYCTTpS/WBDSY0n5wCY2dGF
         PdBhYBy1S1XnHUtlXWMTcR75WIVxLRL1r/E+YI7J9EsPaGDNHMuzwpFyTv33I0pXi4hG
         8QuxVNHFjNOZ85CedwpFOm207vnQxniEqJmOfIHqxch0eo4tdN7gtiDEIBGsR1P76QCE
         jo/iWRQScPf0ZgwCHyl7Bcg9PYWrfi9ZcFE+4VIpdIcyilLdiUM6/BFCyNJUwuevOcH0
         Cti6q/oO2pJizlIWjVvRs2DNbp4swcNLmgFZmdz1gWiDgbSd2Okf3ElaFzeFPK8Cbras
         utrw==
X-Gm-Message-State: ACrzQf3gBmvZStuiobEG2wB52ZMURCRNM/H2bO/CaRcgmYWmQqPWmxo5
        1BReTNnmzz37ye+tiVIvrv4LRA==
X-Google-Smtp-Source: AMsMyM60bmempmzbjQqL2NOHahtUnKRSkAFoWY56r42QApl+XN6ZUtHEQzNY1ach936mXEFZ+p/h6g==
X-Received: by 2002:a2e:a544:0:b0:26c:6abb:866d with SMTP id e4-20020a2ea544000000b0026c6abb866dmr10281044ljn.9.1664300231651;
        Tue, 27 Sep 2022 10:37:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:09 -0700 (PDT)
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
Subject: [PATCH v3 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings
Date:   Tue, 27 Sep 2022 19:36:28 +0200
Message-Id: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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
4. ARMv8 remaining TLMM fixes: v1 send:
   https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#t

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

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 66 ++++++++++---------
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 23 ++++---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 63 ++++++++++--------
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 64 +++++++++---------
 .../pinctrl/qcom,msm8953-pinctrl.yaml         | 51 +++++++-------
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 11 ++--
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 14 +++-
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  4 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 51 +++++++-------
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 12 ++--
 .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 ++++--
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   |  6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 +++----
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 ++++-----
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++++--------
 arch/arm/boot/dts/qcom-sdx55.dtsi             |  1 +
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts  |  6 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  4 +-
 18 files changed, 266 insertions(+), 229 deletions(-)

-- 
2.34.1

