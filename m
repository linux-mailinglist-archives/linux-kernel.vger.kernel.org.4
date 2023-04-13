Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED76E1828
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDMXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:19:23 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07158449B;
        Thu, 13 Apr 2023 16:18:57 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1630FD07B4;
        Thu, 13 Apr 2023 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427893; bh=CRTWj+yIkiq12Ol3HBaiMX1cMs/LluSumeZfXP8P+4U=;
        h=From:Subject:Date:To:Cc;
        b=rdrGTDB8DvBZ2oSC07ZXnZqn+HjTQ3DwwUEZq2hsxarn2LFcC92daygpQEVw8H9mO
         VFb06Cc6zd5pnPB92fKXwKXqUXf2UL4ubAyzzJtOwqoHXlVI8rofiv+Qw5M3hwni+V
         9/BdLoVbrx2CCa++9Qhhn3gEZrBoVICWrOeS9QbY=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/8] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
Date:   Fri, 14 Apr 2023 01:17:44 +0200
Message-Id: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiNOGQC/x3NwQqDMAyA4VeRnBetSVXYq4wdoouag7W0IAPx3
 Vd3/OGD/4SsyTTDszoh6WHZ9lCifVQwrRIWRfuUBnLEzrce42Y9E3pRx0Sd6NBBwaNkxTFJmNa
 b9zXXrtnEAs6RbxCTzvb9n17v6/oBWepSi3kAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CRTWj+yIkiq12Ol3HBaiMX1cMs/LluSumeZfXP8P+4U=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2bAIaCCSnfYMwzpW9XoiSE5rpK0s1oysYuy
 NLpWHjEBhiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNmwAKCRBy2EO4nU3X
 VofBD/9sWBHdLNm2RZU2Onpy9t9Gd6jZy7oYSBwsMTJc5u1mfsWrmQjHU/5Ny8NHPyLC6m1wv1v
 GyAvAEd/YQlmAPOJZMdxxEIdU3g00Ti+RQEVQTEBlACBJxLYB2aBB5QSkftFz5wzc2akSaXY2bm
 GBU7OIoW8fTyZiySOdWhSFsmTU+nt2vhrUqmX9rw57LE3DqK72WdsWkStXDbKw69UIABuF4F5t8
 ZFe8O7vJYaEMsh3azORJivjJdMt5I34qQ+WnsKTZI0MFd5y1uGD5RY/T8Ol5q18sPHjwhvIfzKQ
 9IM0yvEMx64BOcIWXx2WoZFKO4E/XZnv7JtbPAZmnj24Al75ZHjQBdykB4a5hqn6LgVpyqWyvq3
 c6YVkGeuQiEHROSnHrVvPCwmw8Ibc54jy40RNyDVKr6M+hGkXG493W+Y+4O8jAe7al81sOTuaEM
 FnydnkQIixfqDlYQFJ1qf6KkoAhz78zGhNAJjg2Ed/ooM5qi+A1dzOli6DnYGTBKVNeenhBu7Eb
 3EmwwQOQNitifGincr1m7zhmlfoly2in1dwE59Sq08Ps5TskG0lWYGIjREq6PTxEM4V1yPfPpDU
 iyBde1Y5HGTsta9lZnqGC0pKBKf+IXK6GM8tU0YEImgDUWYqNsV4rEjiFn3CKtTScwz2L+2kxia
 tgfIB/g15aYipsg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
the dtsi for the PMIC and enable the notification LED on fairphone-fp3.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (8):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
      pinctrl: qcom: spmi-gpio: Add PMI632 support
      dt-bindings: leds: qcom-lpg: Add compatible for PMI632 LPG block
      leds: qcom-lpg: Add support for PMI632 LPG
      dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling
      dt-bindings: mfd: qcom-spmi-pmic: Add PMI632 compatible
      arm64: dts: qcom: Add PMI632 PMIC
      arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED

 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |   2 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   1 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |   2 +
 arch/arm64/boot/dts/qcom/pmi632.dtsi               | 165 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts  |  29 ++++
 drivers/leds/rgb/leds-qcom-lpg.c                   |  15 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   1 +
 8 files changed, 215 insertions(+), 1 deletion(-)
---
base-commit: c83fb1e4acf528c29b0729525cf23544f8121b3d
change-id: 20230414-pmi632-4ae03225ae75

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

