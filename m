Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04A85B53DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILGR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILGR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:17:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC926136
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so13098952lff.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2Irm+03uhKOe8J1NFtHyiJKs5L7CSgbnyfN7vSggVVc=;
        b=nQiZpj3w7cKDOPwUM7AsGzko5yPxX9BtuLDI/XcTS+uSiHNuc4ynG/iQ26hvDPi5Tr
         69Wjki+ofu8R94Hr4uE0SM3yuW2GGnbkJnUhvOazGL2mvnSnn9+mEPwyc9No8nqFZFnI
         jixLr6engymS7yAXuiSWR2WApEcJbei+I9UbP8RZCL/xe9lv6+p5uVeB3BzcAeUU7zUu
         oLlRsNEn6SAN5nezaZAW3S6Bl6T+nrr3s09jJ+cGhA6RTchu2nbfyZ4C1IbVS9+lAoRD
         SctUyMsxyduqjMictD/+PIOsN2LcR2JQQt6lzBHrXwtyq4e5z/BNUY05Jh/ruzPgJ5fO
         lh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2Irm+03uhKOe8J1NFtHyiJKs5L7CSgbnyfN7vSggVVc=;
        b=oy5ZJrTAgIm9ggZSNqupTuCUB0qfO30mIuWIMsevcedUs00ZlyWK87Ltm8ReIHIc7I
         WfFqs1iaJsz0MtScYZtESdW2D+x5bwCG3rpNWDeCoDSAkW+RIzb5ZCaE7Hj94Q0JSgEl
         LMiEyz3zvz+Q1jRK6PDA+hhX8hGg4+/fh3OqQzM5VPAs05OmpRbIBxME9AChBpHEh6z2
         5F+Y+LJLOyrPnyYudgAU6Tq9fkgw7S+y1ivinWyl5HI7gSHZdIwYlNz8BP+6t/NiS6z0
         WcLUtDnGcFUe58+N6DC31BChrisovDH9pMj66Mm1NepIq8JBnVKEm1y3sJ7sIhXkilKk
         vnEg==
X-Gm-Message-State: ACgBeo3CPDBNTo6yDCcjg8nfeQon9KABRl0wvBqhNDfaBiNv+msXFm1z
        YT1T6+O8BJa+MMK5X5lhKF0xoQ==
X-Google-Smtp-Source: AA6agR7qJ1X/6P3NkfO19vsTT12nuDAiH0l9Ei1o2OBikOqXOcAtxU3Ukwy6/MAOK+ms83abcb+U2w==
X-Received: by 2002:a05:6512:10cd:b0:498:fe5b:8ab3 with SMTP id k13-20020a05651210cd00b00498fe5b8ab3mr4970209lfg.613.1662963472311;
        Sun, 11 Sep 2022 23:17:52 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:17:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/40] pinctrl/arm64: qcom: fix some of Qualcomm pinctrl schema warnings
Date:   Mon, 12 Sep 2022 08:17:06 +0200
Message-Id: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

That's a set for some of arm64 pinctrl bindings fixing most common warnings.  I
have a plan to continue this for remaining arm64 (sm8250 needs updates) and for
arm.

Changes since v1
================
1. Correct commit msg in commits "fix matching pin config".
2. Correct commit msg in commit #2 .
3. Add Rb tags.

Dependencies
============
1. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (40):
  dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm6115-pinctrl: require function on GPIOs
  dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm6125-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm6125-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm6125-pinctrl: extend example
  dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm6350-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm6375-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm8250-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm8250-pinctrl: reference tlmm common pins
  dt-bindings: pinctrl: qcom,sm8250-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm8350-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sm8450-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sm8450-pinctrl: add gpio-line-names
  dt-bindings: pinctrl: qcom,sc7280-pinctrl: correct number of GPIOs
  dt-bindings: pinctrl: qcom,sc7280-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sc7280-pinctrl: add gpio-line-names
  dt-bindings: pinctrl: qcom,sc7280-pinctrl: reference tlmm schema
  dt-bindings: pinctrl: qcom,sc7280-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sc8180x-pinctrl: do not require function on
    non-GPIOs
  dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix indentation in example
  dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix matching pin config
  dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: do not require function
    on non-GPIOs
  dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix indentation in
    example
  arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm6350: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm8350-sagami: correct TS pin property
  arm64: dts: qcom: sm8350: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sm8450: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
  arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names

 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  55 +--
 .../pinctrl/qcom,sc8180x-pinctrl.yaml         |  79 +++--
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  73 ++--
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml |  94 +++---
 .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml |  61 +++-
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml |  73 ++--
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    |  73 ++--
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml |  41 ++-
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml |  73 ++--
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml |  82 +++--
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   2 -
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +--
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |   8 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  20 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  14 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++++++---------
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |   4 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  10 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  14 +-
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |   4 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  44 +--
 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts |  12 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 152 ++++-----
 23 files changed, 733 insertions(+), 615 deletions(-)

-- 
2.34.1

