Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173905EC7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiI0Peq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiI0Pej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:34:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530761F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a10so11417278ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KnfQ5MVXuQS4uTeBoXkARvioMVeeBYYaCbZ+4fW2hjI=;
        b=FemK9rcHKM1AtE1IhtiZEszA4xYBbnG064EUkEwRnGTy1O2T6oraaVI+XPBYGAPgj7
         k1aUpumffBe4/L73oEmIUFP//eSJlzljHg2UcLHQ/rcZbkOi+S0GKfNSiiFG+kpUfLJQ
         WXM1wZBt/0WrzeESwOJI9MOVihc5QucR2iI5KHyuToGobIhmRDrreMS1n+eF8hS6kAv+
         IjG5zv3rhZj6R/s1HT0lQEXvlltWOJQOw3cuPOlehxDZ5ZfkaFLWHBQs+hT1q4e9HzWZ
         7+hizkokLu8F32Sigks05kvo3nkTXEkk7DueOQWv1feVKaQ9Vi4xRN6B0AOUErbOOGNe
         3zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KnfQ5MVXuQS4uTeBoXkARvioMVeeBYYaCbZ+4fW2hjI=;
        b=wGErZ07plQ0nH/VAF1m0SLYVFJMbQ32YiNoNUP2xkFTV0ZDB9R/OQjCsl4yKr4Ar61
         cJECFgQEdt0CmBMcrWZJh9kQ+Z4PBH8gbSXoagQ9MGE9gn8v0vY2m4KkmA5jKUxaMUaA
         F6HSdEq4O5XASJU0Gq5v3y88SLc3HcFJW/Y+T5sE4106E0C+VsJB1Ll5yPwXGeQEqg4A
         QxUtDCegkNhG39LrgUDSq+zoy76TOnkyTZa5CyR8uk0QWTt39NMbEo35+BMCeFCeiEoj
         0/HDHfcj5JrY+jhO5WMS8ah1vZlc8hzo3WgI9XWQkpCypdHnupNyV5Pxiu3w4Yo/tTFJ
         Ob4g==
X-Gm-Message-State: ACrzQf1LwtzgFdCm9tGWwjlRnmJ/1xJcLLoT1Jv0S94duZhkVQEV8VCf
        cQqhOdz7YSgBN2qa8hPoDp6Otw==
X-Google-Smtp-Source: AMsMyM5TMJj/Z6yeEablaKxnBT3O75W7AzgFt1GS4+TXeXhNRqz4ejTeUS+DmMjMxXhm/eyjG9fblg==
X-Received: by 2002:a05:651c:4ca:b0:26c:50e6:a9d3 with SMTP id e10-20020a05651c04ca00b0026c50e6a9d3mr10518216lji.318.1664292874704;
        Tue, 27 Sep 2022 08:34:34 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b00268bc2c1ed0sm191592ljc.22.2022.09.27.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:34:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/12] pinctrl/arm64: qcom: continued - fix Qualcomm LPASS pinctrl schema warnings
Date:   Tue, 27 Sep 2022 17:34:17 +0200
Message-Id: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
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
1. Reorder patches - DTS first.
2. Correct commit msg in two binding patches, as suggested by Rob.
3. Add tags.

Overview
========
This is the *second*, independent patchset around Qualcomm pinctrl in recent days:
1. First round of TLMM fixes: merged
2. LPASS fixes: *this patchset*
3. ARMv7 TLMM fixes: https://lore.kernel.org/all/20220926074415.53100-1-krzysztof.kozlowski@linaro.org/
4. ARMv8 remaining TLMM fixes: https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#t

Dependencies
============
1. No dependencies.
2. dt-bindings are independent of DTS patches.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  arm64: dts: qcom: sc7280: drop clock-cells from LPASS TLMM
  arm64: dts: qcom: sc7280: align LPASS pin configuration with DT schema
  arm64: dts: qcom: sm8250: correct LPASS pin pull down
  arm64: dts: qcom: sm8250: align LPASS pin configuration with DT schema
  dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix gpio pattern
  dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix gpio pattern
  dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
  dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: fix matching pin config
  dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix matching pin config
  dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: add bias-bus-hold
  dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add bias-bus-hold and
    input-enable

 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 34 +++++++++++---
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 31 +++++++++++--
 .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 42 ++++++++++++++---
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 38 +++++++++++++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 34 +++++++-------
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 46 +++++++++----------
 6 files changed, 166 insertions(+), 59 deletions(-)

-- 
2.34.1

