Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C296601CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJQXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJQXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:00:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3E7A746
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so7647897qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrBtAVtOOkIr+g6GdU9njTuYmxU1zlLdCvIG5mEVif8=;
        b=darP5vMdfgHi+tAYeXjdJPBekpKnDw1GtDqRlSzpDElHzTxbzSWz0st/WjL9fwAm66
         1mP5M4xu3O2Z09CSy9XvNFkHTRkBWKu30UTsLM+bubO+gZYJMMKpOI6d2+2xpTvFV9R9
         zC93q6pHpKSYRiKGh/by45UsJYZd1DWsSxCYM/TU54wmN7A/mYhcyn/LwyiKmf1UFR2T
         DHtM+gZkkPDnefZ6pMJcCxa/NvHXg8FZfD2jH4gORxhFYTWxtzzAVs5UtgU6eYDGXZ3/
         xYYfVYB2/IiOsAgCsdS1v/fSNC6uH2992+lE3a+8UabOlkkNs6j3j9C4FZXAY/ukflYp
         aKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrBtAVtOOkIr+g6GdU9njTuYmxU1zlLdCvIG5mEVif8=;
        b=r4fBvUKRlk4qqnj9cMPHNGmQjf5JVSt9HsXYXPabUhh8QYlf3lpIVmkjcD5IFl7cOi
         6Mhg55/j2ex80fhnmYMgR3YSXhmgiVKciHqJpUzfRnRQ7AlomDTuXNvjWsMNU/n7Oalq
         /BUUfFHiniwdOEVGwX4zje0jbuu5Cv6XBAHyHq5df2nHhb4WsCjA4XRkU/qVVWh63HTy
         vB2dAzQbs2n130bhd5zo+NsP4/xQjYsSNh+gq+u659QJza1TXuGZ7NXTLI2lAkUAHMcX
         IrTA4mZMzsWke7WNH0q9KcwkPWAUyg+hbc6T/0s4iQct+myjAc7yjDdX16LWGHSBBCH9
         a5xA==
X-Gm-Message-State: ACrzQf1JShTwDCSP6Q7YtT6i23+NNdeLrQB9+DnQ96mJkgGrqi2L/SWT
        OQ4cQwiyDIXAtHydn1mpZ82v4g==
X-Google-Smtp-Source: AMsMyM5Vh+xoX9i1Sv4SYu0QHc2YAdDlpW4PPBZAL/OT408HDELkGoggWXkQ64KfCfq3oYc3Pw3OKQ==
X-Received: by 2002:a05:620a:2293:b0:6ee:94a6:5cd4 with SMTP id o19-20020a05620a229300b006ee94a65cd4mr9039939qkh.537.1666047635314;
        Mon, 17 Oct 2022 16:00:35 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:00:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/33] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (5th set)
Date:   Mon, 17 Oct 2022 18:59:39 -0400
Message-Id: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

Patches are organized not by file, but rather type of change
1. First patches is for common TLMM schema and dropping unneeded refs.
2. Last patches are pure cleanups without functional impact.

Changes since v2
================
1. Patch #6 "dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema":
   Drop drive-strength.
2. Move "qcom,sc7280: drop checks used in common TLMM" to previous series
   (patchset #4 from list below).

Changes since v1
================
1. Rename several files to match compatible (Stephan).
2. Add tags.

Overview
========
This is the *fifth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/T/#t
3. ARMv7 TLMM fixes:
   https://lore.kernel.org/linux-arm-msm/20221016172212.49105-1-krzysztof.kozlowski@linaro.org/T/#t
4. ARMv8 remaining TLMM fixes:
   https://lore.kernel.org/linux-arm-msm/20221016172212.49105-1-krzysztof.kozlowski@linaro.org/
5. Fifth clean - styles and using common TLMM schema: *THIS PATCHSET*

Dependencies
============
1. Almost no dependencies - logically the bindings patch "dt-bindings: pinctrl:
   qcom,sm8250: drop checks used in common TLMM" depends on patchset #3 above.
   This is not a hard-dependency, everything will compile nicely, no warnings.

2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (33):
  dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
  dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common
    TLMM
  dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
  dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
  dt-bindings: pinctrl: qcom,mdm9607-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,qcm2290-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sdx65-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8180x-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8280xp-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6115-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6125-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6350-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm6375-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8350-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8450-tlmm: minor style cleanups
  dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
  dt-bindings: pinctrl: qcom: adjust description

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         |  5 +-
 ...07-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} | 18 +++--
 .../pinctrl/qcom,msm8226-pinctrl.yaml         |  5 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 11 ++-
 .../pinctrl/qcom,msm8953-pinctrl.yaml         |  5 +-
 ...90-pinctrl.yaml => qcom,qcm2290-tlmm.yaml} | 12 ++--
 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 13 ++--
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  5 +-
 ...0x-pinctrl.yaml => qcom,sc8180x-tlmm.yaml} | 29 +++-----
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 13 ++--
 ...p-pinctrl.yaml => qcom,sc8280xp-tlmm.yaml} | 24 ++-----
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  |  5 +-
 ...dx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} | 12 ++--
 ...115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} | 66 ++++-------------
 ...125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} | 32 +++------
 ...350-pinctrl.yaml => qcom,sm6350-tlmm.yaml} | 25 ++-----
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 23 ++----
 .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 16 ++---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 70 ++++++-------------
 ...350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} | 25 ++-----
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 13 ++--
 ...450-pinctrl.yaml => qcom,sm8450-tlmm.yaml} | 24 ++-----
 22 files changed, 146 insertions(+), 305 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,mdm9607-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} (92%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,qcm2290-pinctrl.yaml => qcom,qcm2290-tlmm.yaml} (93%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8180x-pinctrl.yaml => qcom,sc8180x-tlmm.yaml} (88%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8280xp-pinctrl.yaml => qcom,sc8280xp-tlmm.yaml} (90%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} (95%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} (75%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} (87%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6350-pinctrl.yaml => qcom,sm6350-tlmm.yaml} (90%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} (89%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8450-pinctrl.yaml => qcom,sm8450-tlmm.yaml} (89%)

-- 
2.34.1

