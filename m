Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61A16001FE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJPREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJPREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:04:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392314455F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z18so6247240qvn.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd0fX1T1QKoq+RXISpZKgdvgGMFZi6bW6L5gzG3/E+8=;
        b=raalnqyp0gtciH7nS+WiAJ6DBpu9YwlzEJvmoapxXt8kM5br2Nqg3WltH2htxJPxFB
         LqNtu/3aC0mo7xmBPMsuiV5XICLfejTMsPvjPev9hM/afvnXH4dDKICn4XgQQ50IAT46
         y99EG4D41oxwKqsnaSxvQg31DdbXufTiG7rYDTrk65AjUgioUiJnt6+0P5AavptHazQ4
         5RGfe1xiL6KqKJB+ZpZkA141RihgLtXwaYgGhgXhA2rTVIb5R0lL1BkPuqTgWaAKpPsH
         MnwfvrjgIEiWXWCFVolK0hcMJ+W4WPubhS+Trm425pO8J0HjJqOzFzl8NzZtN6t9FFVp
         YODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd0fX1T1QKoq+RXISpZKgdvgGMFZi6bW6L5gzG3/E+8=;
        b=jAlBHHW0QmDgYJbCSzl9PwfEBXb7CAVHHdE2KG/V3ewHeZXCeSa99iJ2LakUBW1QsI
         NAcr+2/vhbxGASxesxRfsJg61qDMoTJ48tkBjySalfjcwDqqVZ8vFh6yWC/oPRVNk03s
         opedG/+T1Wm6X2kzM70FVSeVh1YtfojP1kS4+1/ZBWkVWxtuGc4Thfgd+6gW53L4SvyF
         QF42do8K9LLF5mB1+R9zGO/Qh/aq4Pa7Ra0rVL1+XN2I2wCv6oBIvZmpD57hibTWbVUr
         AxC/7+uCYs948Z6U9fotslCw16XmX3htxS4yEs8aWF9iSUzX9S7+fKqsTRIPRoUaaeF7
         niRQ==
X-Gm-Message-State: ACrzQf349f13uHWFPgGoWJiUwELWXZUWu7z9Q2ljlKaMAczUgWzr+0uu
        0/nArHgbp/d1Nlj5+3bqSe87Ew==
X-Google-Smtp-Source: AMsMyM5Hr/0at3JgySZXdeFD5PUK2O6fuNBoKqZzvCby+jztwJDLxx0mmVNWYTymdXu9dy/2KRuB0A==
X-Received: by 2002:ad4:5763:0:b0:4af:b800:be6b with SMTP id r3-20020ad45763000000b004afb800be6bmr5670021qvx.70.1665939759321;
        Sun, 16 Oct 2022 10:02:39 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:37 -0700 (PDT)
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
Subject: [PATCH v5 29/34] dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
Date:   Sun, 16 Oct 2022 13:00:30 -0400
Message-Id: <20221016170035.35014-30-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 44 +++----------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index fff57abf4fbc..8ef3dce33db2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
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
@@ -104,40 +90,24 @@ $defs:
                 uim1_present, uim1_reset, uim2_clk, uim2_data, uim2_present,
                 uim2_reset, usb2phy_ac, vsense_trigger ]
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
       bias-pull-down: true
-
       bias-pull-up: true
-
       bias-disable: true
-
+      drive-strength: true
       output-high: true
-
       output-low: true
 
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

