Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919655F665F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJFMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJFMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:47:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683BA2846
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b2so2527734lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AOO6GYk3DX7qTzUnwkLMT8us6fRJlkOK0kAXoivsFXI=;
        b=rHG0eJgyM1OzClUuLqKyKMCZUj2QIwQ3sseD/i/bNJVIn5BqTP2LMUsAz8Q/TQdlHW
         yUCcnYmTOBTAMeqiBEEyu+aL884MgOLoOvF0j74A2k0pkGSZj6v/SQHohtMjW2BAK04v
         vZ9pF0qmvEjf7DSJhkYFd0SzLPq+AF3aidpUFgkrJj6CgA4YXmDjLkZ17JFcUm18J1g8
         tDkozKRubtnJHClFs7uaICkKQAwl2x04G95UdJSSLZamIlc0CkWCLrV5trcFH32Z/Ofl
         55iSnw1xREjgokHCnftaQhxBwnNJNNVm1Jz52VN0He6lc3otF8CQ+0TheQkKc8a3VH+T
         nwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AOO6GYk3DX7qTzUnwkLMT8us6fRJlkOK0kAXoivsFXI=;
        b=38xkx00QNZGciGsraZbuidYocC2IleMxF4q6jWfv0aukFj3J0u/4KKidxfZsDlVpYS
         mmayBpWXCzJiT4B7lD5EEX5dP4R+ZWUoeIRo/jgLs6sfNF/VhIW43JRQ52TOmzCf6uUP
         NrMOS/SGrz7UFD84rvzdGWT2ndod/yuVzRJ6Q1ro7FwCiFgFGYodj4xfFD3Obf8q6oVd
         vUrQ3w5ehhUqTeDC5Bv9rtHMxWjiohMVHsVYZlxj8/QCjYqTYM8t/ylH5HoFKFew/gNb
         iphmSw/Bq5U6/GGUSr+O5bmUYyxGd+fD0jFohnE2Gl5as7nFufeulZKZmXjA4qIXC73a
         sDhw==
X-Gm-Message-State: ACrzQf0UWY/y9oGGwntIWyUQyY60Rq7XTLPookTTOe5C/sbs7F6iPISd
        qke/leoU9bsii9lX8BI7/f8v8A==
X-Google-Smtp-Source: AMsMyM42mVXhCBo/Hg17pPXtXjcxlvnOO7hiRbUw0wmxXnDWgMtyqLCUeJTwq/oQldfdnhcKbgMRVQ==
X-Received: by 2002:a05:6512:3f8c:b0:4a1:8d5:d75b with SMTP id x12-20020a0565123f8c00b004a108d5d75bmr1933372lfa.670.1665060422022;
        Thu, 06 Oct 2022 05:47:02 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:01 -0700 (PDT)
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
Subject: [PATCH v4 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (third set)
Date:   Thu,  6 Oct 2022 14:46:25 +0200
Message-Id: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
4. ARMv8 remaining TLMM fixes: v2 send:
   https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/

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

 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 95 ++++++++-----------
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 23 +++--
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 91 ++++++++----------
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 64 ++++++-------
 .../pinctrl/qcom,msm8953-pinctrl.yaml         | 81 +++++++---------
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 41 ++------
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 14 ++-
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  4 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 79 +++++++--------
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 39 +++-----
 .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 +++-
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts   |  6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 ++---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 +++---
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++------
 arch/arm/boot/dts/qcom-sdx55.dtsi             |  1 +
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts  |  6 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  4 +-
 18 files changed, 290 insertions(+), 377 deletions(-)

-- 
2.34.1

