Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED45FB92B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJKR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:26:10 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0D11146
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:05 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so9369696qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sT4AqRAWASoX6ZgH8nYBolMpdFX1XCQaQY8kPd1JKO0=;
        b=GKvd6HUFgR3TXrkq/cFvYNYP0bVqtDrH3w9bl5n9MWU464GYeYMs0HmQCs6Jb/j2u7
         OPaoShcQHGX0KB6/tpgXoqc3+avcqHpFcv8QZB0C97ovzsm1DOuHWfN7DVJWdY3Hw2q0
         GC4gZ50EtvPfZuclKSm8h+JvDU5H4YeyvRXqc+6hjfI6cXd9RCqgSFNb89qasU9bkLdW
         CPIlNlk9FzNM5j4MLfJvJ7dDCgMH+El86aBDIIX4MvUt8NTx9DTjCcp3fKHsXODgAra5
         sIzxWQjLYeJPE9umzRNT8uWnV/G78HkypQRM/hpfjMdPbMTubobafStV8a9F+oyN/sBZ
         gXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT4AqRAWASoX6ZgH8nYBolMpdFX1XCQaQY8kPd1JKO0=;
        b=3AQee+62ISvnQGFyowezQ7buUXf4aaA1BiXU9wikI3ezPqozSAzRHz3VDjzzUkiqJC
         VHf0KmhPNbRlR+UalNJgSvDPbMYzg6AVe6N9ggF4P4dIai2QD/ZxoyD0/yvIod1Ik3im
         Kk8KlzWmnuv1HNNKUKqRe8X22pSgU2D5Ayh4b5K41B3HdgjHIE7qpMUe32P0U2ZeXivq
         eOt8J2s6Z5sa8HYVcbTSsgKrqIvHzQacsJIpneUXk1RBk7VeSBD+kBinjPtYFaihiK9q
         349pZ425n8ElpuNV/harrJWGX7sH+kEWEdYmx1uG9nzSgy3HIY10pOemhL8l3FYWDR/s
         1KBg==
X-Gm-Message-State: ACrzQf1vifCiOklGYR4yH6arivMs7OFf/SaZxiSKo0gHyQvdrYrXAtPY
        REFDwNi97qE9hq+14PIZfHfnpw==
X-Google-Smtp-Source: AMsMyM466WD0TDH7EIGB2VENiKEbgepbvG9xFJNtMPPY759XPJJjgx+758oWOSYi6Ai1JbhnCCzdSw==
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id eq11-20020ad4596b000000b004b1ee661cb8mr20088644qvb.3.1665509164701;
        Tue, 11 Oct 2022 10:26:04 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:03 -0700 (PDT)
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
Subject: [PATCH v2 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (5th set)
Date:   Tue, 11 Oct 2022 13:23:24 -0400
Message-Id: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

Patches are organized not by file, but rather type of change
1. First patches is for common TLMM schema and dropping unneeded refs.
2. Last patches are pure cleanups without functional impact.

Changes since v1
================
1. Rename several files to match compatible (Stephan).
2. Add tags.

Overview
========
This is the *fifth* patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes:
   https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/
3. ARMv7 TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20221006124659.217540-1-krzysztof.kozlowski@linaro.org/
4. ARMv8 remaining TLMM fixes:
   https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
5. Fifth clean - styles and using common TLMM schema: *THIS PATCHSET*

Dependencies
============
1. Almost no dependencies - logically the bindings patch "dt-bindings: pinctrl:
   qcom,sm8250: drop checks used in common TLMM" depends on patchset #3 above.
   This is not a hard-dependency, everything will compile nicely, no warnings.

2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (34):
  dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
  dt-bindings: pinctrl: qcom,sc7280: drop checks used in common TLMM
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
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 16 +----
 ...0x-pinctrl.yaml => qcom,sc8180x-tlmm.yaml} | 29 +++-----
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 13 ++--
 ...p-pinctrl.yaml => qcom,sc8280xp-tlmm.yaml} | 24 ++-----
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  |  5 +-
 ...dx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} | 12 ++--
 ...115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} | 55 +++------------
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
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} (96%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} (79%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} (87%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6350-pinctrl.yaml => qcom,sm6350-tlmm.yaml} (90%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} (89%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8450-pinctrl.yaml => qcom,sm8450-tlmm.yaml} (89%)

-- 
2.34.1

