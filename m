Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9E6001C7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJPRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJPRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BD37FB3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a18so5466936qko.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93fHpqQry3w6w4PjZtIBjSSgl8RY3lBIxWKZ7PfIO28=;
        b=s7AiJ4MFrq0ncWxzUa5u0LlAimySXyP3I93ooVvi0i0iqu8UbM9orA7nAf61jmNbmo
         wTvfPn2NEbgQE5B0pR5MqdgPPE+Z2YNPXdn5xTaJLL48rX5Y2rStS0vnMF0nvqFxiOcC
         X0rjCIZWywDOo27Dbks/49BF7t4/F0522hDJIerTUwg47REl0ddntF6Q8zRiUVz0xwON
         bYBE8Mus6jIoLv5X85HNvrjiYwx0vfKnI7hi3TaWjs720maSBLNYxtEDalytQccWfwhJ
         RWP3PGrgOOBdAHnaE3CLDbYPjC/NJsOkZR3kJtuj0WkJHF8YS8HTLxj3uGYxmJmEpCLE
         6WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93fHpqQry3w6w4PjZtIBjSSgl8RY3lBIxWKZ7PfIO28=;
        b=2iP+yip+EkHsRv7A8WHUFslsMYZqjnWYTi1kb9kSj5CNu9OZbyGthX6giPS+GuUUKE
         GApYAc/YrPFyYQKrGwna9fdOxXEPKxUHEz9KUt0ixO8GqxrmcZT5ikaqlTgRMPThOmXj
         otd+XmFChMi55h1eL6OVjXuFjjQNjiCX5Uwun93vqYsVjQuElARQoF+Uc62nXCzxnljX
         IMWd+v5TD+9VsgBADByzFuumRQTZZ56HYPXWRK0cL/Vz+ydbhvdTlSWQZXE/iL0qttfb
         S0UKc8h7Co84tqPOsfpLzpKmRFkrsmIAzg0sdlBDj52nzQ7Mgmw77Jzlvl07mOQ3jlgH
         ecAQ==
X-Gm-Message-State: ACrzQf0O6CTQElTy+zB/3bGEdeTiLxWfd9XLpaqyIFqA73z93PEQ58u4
        wyGHuF2LLNfO5c73O+/pg/6fcg==
X-Google-Smtp-Source: AMsMyM5DsLiObRqiAiPfwYRERFynaDLfvwxaUBpacsG0fxkJKchy0MhJh8HUeopMJjhauVsKf2HKZQ==
X-Received: by 2002:a05:620a:4111:b0:6ed:ddf9:6955 with SMTP id j17-20020a05620a411100b006edddf96955mr5032200qko.19.1665939721782;
        Sun, 16 Oct 2022 10:02:01 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:00 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 15/34] dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
Date:   Sun, 16 Oct 2022 13:00:16 -0400
Message-Id: <20221016170035.35014-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring common
properties, other pinctrl schemas and additional checks, like function
required only for GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v4:
1. Drop drive-strength (included by common TLMM node).

Changes since v3:
1. Drop properties and required items which are already provided by
   common TLMM schema.
---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 40 ++++---------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index ecb90c77f666..8e634d07eb67 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -21,26 +21,12 @@ properties:
     description: Specifies the base address and size of the TLMM register space
     maxItems: 1
 
-  interrupts:
-    description: Specifies the TLMM summary IRQ
-    maxItems: 1
-
+  interrupts: true
   interrupt-controller: true
-
-  '#interrupt-cells':
-    description: Specifies the PIN numbers and Flags, as defined in
-      include/dt-bindings/interrupt-controller/irq.h
-    const: 2
-
+  "#interrupt-cells": true
   gpio-controller: true
-
-  '#gpio-cells':
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
+  "#gpio-cells": true
+  gpio-ranges: true
 
   gpio-reserved-ranges:
     maxItems: 1
@@ -60,7 +46,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -83,17 +69,12 @@ $defs:
                 blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
                 blsp_uart3, blsp_uart5, cam_mclk0, cam_mclk1, wlan ]
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
       bias-pull-down: true
 
       bias-pull-up: true
 
       bias-disable: true
+      drive-strength: true
 
       output-high: true
 
@@ -101,22 +82,15 @@ $defs:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
 
 additionalProperties: false
 
-- 
2.34.1

