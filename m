Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C624637F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKXSoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKXSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:43:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D6112C44
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a29so3680029lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wulctTHUCxRqRkL1rWXHEt6+euBiukO8eehnFPmEuM=;
        b=Ym5GQn1CxCoHDqglOJInnff9oXZKE1/E4vJ9ckFNX9uvwvepm7jOxti0Gn6TBhyoBJ
         tHv4eGlK2PrYSOdx3mcykIdFjFCfh9MWk2ZvW6SrnVAPoNH9U4w0JDTYn4HrGxYKCxfA
         CP0eRSxrLz2fBWjzFiO9Pj3JNVe23j2qR9XTGRPwuryM109hYRb9xMfrz3FrAipUqLla
         d+CgpPf0T65y7bg31zWKfrPdebPt4ejlx4/7IpAbVrhbNBRWcY4gl8xFB8nCxI7TDGcO
         ZfamC7UYMpLlD2K7VmMwbNDBU1VBpNGTM0L61buge+/5MzTj/tXV60tQkJncgrhAw6mC
         SnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wulctTHUCxRqRkL1rWXHEt6+euBiukO8eehnFPmEuM=;
        b=PuB8EbHuN/4ViY5wvb0GHqqrObv9DZTVMuwP6YfeRbF+wcek2QCr1TdWDsAGOVKm1H
         M0urxQqURHl/rvgwXVHAL8StqH1VSKV/r3kdgd4vFxlAdhQuz+osLeBjq94bpFHQiuc9
         MzwlPOwyq8YZbUfJ3n81ZZnUqXly+pynaMYWpwB+jpq6H6hbtdL3LupfZf8ENnOl2rid
         lqxw4sxydvYt1MKsnb7JEwTqOuSR1sHYZVxNezpUivgVn6W4mMa6HeL0BQ/HzgrKPOLq
         FRtams7CrBhDSUNIGw0SK7qSuUzRmmfBh912DUkln0zc20MOmQZ/g6trH7AWvHSjiHsB
         49tg==
X-Gm-Message-State: ANoB5pmAiUVqqDV6FYtttB414nrsqBWZ5xv60/4IX/p+tMAULdvarRp8
        wlS4OVCWamhovDorrvj5kQoP+Q==
X-Google-Smtp-Source: AA0mqf6E/cRXQkVjvYIadHXCKFehxRphTLb4X3FB7P4rWFW7VBxF8iheH16lqmH/NEVxPyOkFMoNyw==
X-Received: by 2002:ac2:5289:0:b0:4b4:faae:2c7c with SMTP id q9-20020ac25289000000b004b4faae2c7cmr410171lfm.382.1669315430095;
        Thu, 24 Nov 2022 10:43:50 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:49 -0800 (PST)
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
Subject: [PATCH v3 06/15] dt-bindings: remoteproc: qcom,adsp: split common part
Date:   Thu, 24 Nov 2022 19:43:24 +0100
Message-Id: <20221124184333.133911-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

Split common part of Qualcomm SoC Peripheral Authentication Service
bindings into a re-usable schema file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Allow only one or two clocks, after dropping clocks related to PIL binding.

Changes since v1:
1. Keep resets, reset-names, qcom,qmp and qcom,halt-regs in qcom,adsp,
   because they are not shared with most of PAS bindings.
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 81 +---------------
 .../bindings/remoteproc/qcom,pas-common.yaml  | 97 +++++++++++++++++++
 2 files changed, 99 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index e3e617315aef..596149f71485 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -59,100 +59,23 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    minItems: 1
-    maxItems: 2
-
-  clock-names:
-    minItems: 1
-    maxItems: 2
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
   qcom,qmp:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
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
index 000000000000..1d5e01c8d8bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Peripheral Authentication Service Common Properties
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Common properties of Qualcomm SoCs Peripheral Authentication Service.
+
+properties:
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
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

