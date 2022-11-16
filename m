Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563962C31F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiKPPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiKPPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:54:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142D15FE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so30243346lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7W7+79fmKJDqVxDiO6BhFe4cZI7vtEqmjmXIvhbW1g=;
        b=dJ/Y+wOgZJdvO7s+x1lBEaPL4WZEznUq7I45WBKtddqyLYKm84GJ4BjtYBXNfTjNx1
         jluVx8Lw23pyammep2NMm0Zhnt4wrtHDs6yFI8FnCvzkWVERQMSzYKyzhGggCndt8toN
         u6ZeZJunxSMpxd6y5nAC2fLTS7IxTyjIus1I2FpdVWAFIqLx3zQbZhIcyBpFruUQXpfd
         RgbcUl8ESj69IoEHV4qg1/OMmS/Csuk4sVrZGQv0rasMvhMXhjrjckeQG8mdDsRyCfMR
         jO0hUDfPK7V+XWbFuH2uj0uA5c2MgRFO8Y3n5QT7RuRaSwAC0SYaKjWtsowKPibRzghE
         Yw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7W7+79fmKJDqVxDiO6BhFe4cZI7vtEqmjmXIvhbW1g=;
        b=m38AD3ONVRDXAMLAQWreybFiYk48Z0ylxRNtDgCj4MVy0KHyc18zdr8QzR2GyHYMVN
         vuTbKDmbGXlRznoS6l2/kanmdWPHN8Ijrh9/pD6b4wEW0nGFbXZb6wNySEg+i4Y1k2Z8
         UwCS3fRNafTAflmrE0rgdMKwvVCvGfVki5Zb6uYPMrZdiG9e8T5jn/NtjoEpTrTbrbxf
         EY47xo3/eiwNXpOUR57bVBD1WeFbYi4Y5uh65czk1a/uRidJ6kA1HtwWK+Umflr0keby
         qVT31IP6nGfpDRrF/bWBuKRCRZgPB3Bg+3y3VZv39GqOf9Yy8CZ7W0L7mzeUMGgn2XN4
         32FA==
X-Gm-Message-State: ANoB5pmx4daXXAN27q4nyAumgC1nMPcj0tGYPVG+kLPO3qZFZZSGsONP
        8+8rNy4BQoVHmXPKIuuUhBZFts268QTuTGju
X-Google-Smtp-Source: AA0mqf6UUlvWl2N+Q+EKzSejAfSeAncimQGo6FnFl2cAEL34oxpLrrUMbaVRXT6RCT1L+NojoxNsiw==
X-Received: by 2002:ac2:4c95:0:b0:4a2:676e:cf5f with SMTP id d21-20020ac24c95000000b004a2676ecf5fmr6956485lfl.287.1668614060113;
        Wed, 16 Nov 2022 07:54:20 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm2655128lfr.145.2022.11.16.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:54:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] dt-bindings: remoteproc: qcom,adsp: split common part
Date:   Wed, 16 Nov 2022 16:54:12 +0100
Message-Id: <20221116155416.164239-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
References: <20221116155416.164239-1-krzysztof.kozlowski@linaro.org>
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

Split common part of Qualcomm SoC Peripheral Image Loader / Peripheral
Authentication Service bindings into a re-usable schema file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 105 +--------------
 .../bindings/remoteproc/qcom,pas-common.yaml  | 121 ++++++++++++++++++
 2 files changed, 123 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index db9e0f0c2bea..49b789f8ef0c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -59,120 +59,19 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    minItems: 1
-    maxItems: 8
-
-  clock-names:
-    minItems: 1
-    maxItems: 8
-
-  interconnects:
-    maxItems: 1
-
-  interrupts:
-    minItems: 5
-    items:
-      - description: Watchdog interrupt
-      - description: Fatal interrupt
-      - description: Ready interrupt
-      - description: Handover interrupt
-      - description: Stop acknowledge interrupt
-      - description: Shutdown acknowledge interrupt
-
-  interrupt-names:
-    minItems: 5
-    items:
-      - const: wdog
-      - const: fatal
-      - const: ready
-      - const: handover
-      - const: stop-ack
-      - const: shutdown-ack
-
-  resets:
-    minItems: 1
-    maxItems: 3
-
-  reset-names:
-    minItems: 1
-    maxItems: 3
-
   cx-supply:
     description: Phandle to the CX regulator
 
   px-supply:
     description: Phandle to the PX regulator
 
-  power-domains:
-    minItems: 1
-    maxItems: 3
-
-  power-domain-names:
-    minItems: 1
-    maxItems: 3
-
-  firmware-name:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: Firmware name for the Hexagon core
-
-  memory-region:
-    maxItems: 1
-    description: Reference to the reserved-memory for the Hexagon core
-
-  qcom,qmp:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: Reference to the AOSS side-channel message RAM.
-
-  qcom,smem-states:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: States used by the AP to signal the Hexagon core
-    items:
-      - description: Stop the modem
-
-  qcom,smem-state-names:
-    description: The names of the state bits used for SMP2P output
-    items:
-      - const: stop
-
-  qcom,halt-regs:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: Phandle reference to a syscon representing TCSR
-          - description: offsets within syscon for q6 halt registers
-          - description: offsets within syscon for modem halt registers
-          - description: offsets within syscon for nc halt registers
-    description:
-      Phandle reference to a syscon representing TCSR followed by the
-      three offsets within syscon for q6, modem and nc halt registers.
-
-  smd-edge:
-    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
-    description:
-      Qualcomm Shared Memory subnode which represents communication edge,
-      channels and devices related to the ADSP.
-    unevaluatedProperties: false
-
-  glink-edge:
-    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
-    description:
-      Qualcomm G-Link subnode which represents communication edge, channels
-      and devices related to the ADSP.
-
 required:
   - compatible
-  - clocks
-  - clock-names
-  - interrupts
-  - interrupt-names
-  - memory-region
-  - qcom,smem-states
-  - qcom,smem-state-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
new file mode 100644
index 000000000000..a1de17ca6b75
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Peripheral Authentication Service shared parts
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Shared parts of Qualcomm Peripheral Authentication Service.
+
+properties:
+  clocks:
+    minItems: 1
+    maxItems: 8
+
+  clock-names:
+    minItems: 1
+    maxItems: 8
+
+  interconnects:
+    maxItems: 1
+
+  interrupts:
+    minItems: 5
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+      - description: Shutdown acknowledge interrupt
+
+  interrupt-names:
+    minItems: 5
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+      - const: shutdown-ack
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
+
+  power-domains:
+    minItems: 1
+    maxItems: 3
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 3
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle reference to a syscon representing TCSR
+          - description: offsets within syscon for q6 halt registers
+          - description: offsets within syscon for modem halt registers
+          - description: offsets within syscon for nc halt registers
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      three offsets within syscon for q6, modem and nc halt registers.
+
+  smd-edge:
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the ADSP.
+    unevaluatedProperties: false
+
+  glink-edge:
+    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
+    description:
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the ADSP.
+    unevaluatedProperties: false
+
+required:
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - memory-region
+  - qcom,smem-states
+  - qcom,smem-state-names
+
+additionalProperties: true
-- 
2.34.1

