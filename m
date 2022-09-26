Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857D5E9AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiIZHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiIZHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:44:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73932A430
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d42so9580471lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vUExKf8KWqjbGh/mdk6ctZRIxTZ/1o6Zypm7c6EDOBM=;
        b=B3fAwidX+AucDd5l1XECebY0hxjAdWTJaCAozYeSvxxEvqCF/M2g/o/TZxs8ZoZONc
         pbGirrL1yiK1eFstzIvABLDj4gcqS+xF1hBI28TzblmAtnaU60Qc6Gv6KYZuWSW4lwZx
         lf0Vh9JUe0BoMJr4DQzHGbv0qaOiv2axzozwGR9swExtohk2V+3xP5KDcrtYt4GFq2vp
         pw1CcvrRSE7ri+sJJecY3zpOBwX8LvHKGdjSmNoauXT21/0Z8d08BF0j0NGtGiPS499R
         BPzwoUPDrjFfYOvKwnY6tv3O7xRlxwQj2sLfrNdS7TpNY36eH1ZhYmEPtM5rNuzOnae6
         avhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vUExKf8KWqjbGh/mdk6ctZRIxTZ/1o6Zypm7c6EDOBM=;
        b=hF2+NBf6lmmVJJN6mQb3eQlLlhpYtInSyCLI60WKWdzEIbb3sfdwTsc/xRitevvilK
         UutEDZk/dBMOSkKiIkliOXxh54o8kbhpIjBFg1GZkmwhJEI6Te5vOPvMQ9r2cIm9Bt04
         2YJimWxs6N/Ry2E00ycOCg1T9WIPjXlOKbOCQCx2yk/EBqV954HQYk+93Qgg3U4HbWXp
         owGL1Sr0/WbXyjiHSJ5S+hHVTs20Yt1WsOuwlHD2+qaMIllEAxoU+2ih/CcBcggYrZBJ
         zU5c7mQN/87FSRsQ0axf6BhgkDZSg28Z5FRnfmBISs1P1wuBTg2VeWsfiP5EqDC79Vtg
         LEaA==
X-Gm-Message-State: ACrzQf2pUQNSmRGtr2yq/GZeSO2Fuz0jZaGqCglpL+Zl4CJE1Os0h3op
        hUyhwOOI0Ds+V6uB2f3I1SFQ2Q==
X-Google-Smtp-Source: AMsMyM4IsHSulfNu1TKObJjoD4Rl4J6v569jAY105yoTy9+m+Ldw8YyI9ltdhmJa89mGwY0aRJHQ6w==
X-Received: by 2002:a19:654d:0:b0:49f:5309:1cb6 with SMTP id c13-20020a19654d000000b0049f53091cb6mr8045380lfj.522.1664178265274;
        Mon, 26 Sep 2022 00:44:25 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:44:24 -0700 (PDT)
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
Subject: [PATCH v2 00/33] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings
Date:   Mon, 26 Sep 2022 09:43:42 +0200
Message-Id: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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
   https://lore.kernel.org/linux-devicetree/20220922195651.345369-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes: *THIS PATCHSET*
4. ARMv8 remaining TLMM fixes: v1 send:
   https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#t

Dependencies
============
1. No dependencies.
2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (33):
  arm64: dts: qcom: ipq6018-cp01-c1: correct blspi1 pins
  arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT schema
  ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
  ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
  ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
  ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
  dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
  dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
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

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 60 +++++++++--------
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 23 ++++---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 63 +++++++++---------
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 64 +++++++++----------
 .../pinctrl/qcom,msm8953-pinctrl.yaml         | 51 ++++++++-------
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 11 ++--
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 14 +++-
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  4 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 51 ++++++++-------
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 12 ++--
 .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 ++++--
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   |  6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 +++----
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 ++++-----
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++++--------
 arch/arm/boot/dts/qcom-sdx55.dtsi             |  1 +
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts  |  8 ++-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  4 +-
 18 files changed, 264 insertions(+), 227 deletions(-)

-- 
2.34.1

