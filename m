Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFD6001F5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJPREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJPRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:03:50 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41438458
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l19so6249920qvu.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEKjCuD1JH7JdjhuaALknErak/xWiN7RBOQ/qoS9q9o=;
        b=NCpPPXy63NmxjlBKSENPAyjLHiAxjufZCYr0E8yykcxmY+CpLNoGaZ0n5VqM32MC84
         jrFWotBuiuo1+0d/cHhFgMWSz6dzbUdk++AUriMf56yDQ3H6syub2Bkfyiv4iWkfzrOm
         YsDloZ2heH6Thdk+KBD4ySJwtBw4w6QAgqeKBKZ3ez+3RIKWUBi0m6GKNJSQpMLTzGka
         baGj0cDWmP3WUNXALpNSIaOdbLgtfncrWWfs6ZJs/MpE0KK2QOaFmi1A0rznRjG3SmC6
         xXWDvtkDnCeKQyqYKz1n0M2EHYr3Z9yK+7lFCCCkbUfE/5hUUlYCHKd0gGLcMdhKJITZ
         C1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEKjCuD1JH7JdjhuaALknErak/xWiN7RBOQ/qoS9q9o=;
        b=Po+SbxJlhTSI4cwuOTz3WDA5f/gYeXQTcduxWtGfym7pZ9oTRnhc+ylaolSBXlf1JA
         AXkW0On7H+N20cRyzXLw9LBO87tHAJISoA/q4mHCwXLzbqlo2gnCdHIPL6qGnASQjMhi
         WFpDLgx7iHXsY4cdcJQ1gru+IrpTa3M/j3x+3Xq5y5Xfak8oTXuBMsWArYVaYp//oeEo
         /AYEfvJTaUF8BVebrJKBB0vFXsAAy3caNiEkIfg5fQk+Grt+DtgQ5dKk+Qcfs27Ll+/H
         +LZSYNzL1vEM6L6fH1wD3BA1cRBGiKLAZPkK+epaEJK+FZ+nTbtisZDkvldeKwgnbLZZ
         tztQ==
X-Gm-Message-State: ACrzQf2oksaHs5AO6aKOWJhADHIBQr5Ko8/jm0bJPEH1gOyvU9DIRIaG
        FzMV+ZoNtbu4mV6JSQMK7bWgKw==
X-Google-Smtp-Source: AMsMyM7lIyJoR1jVoBX5rckgaMZX4J1Gs3s5xAsNkyXYp25kzHxBmOZ9Fr6bLIyLRRKxi1NrJLSJXw==
X-Received: by 2002:a05:6214:1d0e:b0:4b1:7c94:5e46 with SMTP id e14-20020a0562141d0e00b004b17c945e46mr5498623qvd.38.1665939752970;
        Sun, 16 Oct 2022 10:02:32 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:31 -0700 (PDT)
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
Subject: [PATCH v5 27/34] dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
Date:   Sun, 16 Oct 2022 13:00:28 -0400
Message-Id: <20221016170035.35014-28-krzysztof.kozlowski@linaro.org>
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
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 43 +++----------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 5324b61eb4f7..ae73e3d45bbe 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -20,28 +20,12 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    description: Specifies the TLMM summary IRQ
-    maxItems: 1
-
+  interrupts: true
   interrupt-controller: true
-
-  '#interrupt-cells':
-    description:
-      Specifies the PIN numbers and Flags, as defined in defined in
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
-
+  "#gpio-cells": true
+  gpio-ranges: true
   wakeup-parent: true
 
 #PIN CONFIGURATION NODES
@@ -97,20 +81,11 @@ patternProperties:
                 uim2_data, uim2_present, uim2_reset, usb_phy, vfr_1,
                 vsense_trigger, wlan1_adc0, wlan1_adc1 ]
 
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
@@ -119,17 +94,11 @@ patternProperties:
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

