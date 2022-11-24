Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691B2637F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKXSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B313395F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so3647605lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMI82BhiRMmxUe8PJNsOEzjk6w68RCfM4srJwtzf3Io=;
        b=A/pJjqaXriyV3t+NRhNnf1QWTWMBl9IobPVwNj6Z5c3QojKt1pT8J5GpLkosAPYg9E
         Tz7PEAFOrHUO4XXuyYqEC1PRkNkHQPjrOiuMXur6E2g6TZQMNPYpQLPJxWrBtPbhUWb2
         JzEN1R61V9PtoIUXzDwQ/0twEmgBPDK4jKgjltnwxY2n2U099pkAujXBtcdCWChRNd3k
         Vw0NC3MCCMmRPz6oXEBkbyVJ+udcWMssm15fpu+fCqcYg1dRpO4U3hR5rOzEP1WvWN2Y
         LA3WygIYyeJ0+OsKgGbKNuJJn0oMJZSETNsmSGG3bxrKhQaSPfj0wNLWXaRWZ9ci/GKY
         4Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMI82BhiRMmxUe8PJNsOEzjk6w68RCfM4srJwtzf3Io=;
        b=cZkONWyznvzaaSQkaj8rIZDwXxZ0jBXxYr86BxFltnDBTotmC3YPAkFL7e8fuEg/Rm
         6NbOzS8eEv7PMFXF+PxbMGrWRZGzmdUXY+c9QQF16OeaHDjuaPlZvTlIWRm4kPvnrhov
         gV20oIXd+bf+VnaTOU+BsSa0lFeaqAAx+jkfHmxJilMU4+GnhUuCnk3A75lyxzG/Zb3A
         MEacMRyjZjQ+ZuHEfwJs8s8/SGZHlONHHc5g0b7aIDtBqs/cRruYxghVF2k16/W1bna2
         BVaKgk8lKtmQisqV/m/brbsOaYv0brSCIpWWO731OfdL6Skqaa6O23guBARC5WxjE/Hn
         FnGQ==
X-Gm-Message-State: ANoB5pkuBZkJb2yp+4acDzTRJ6fknEwKyNyelipemzCCSpQSYgiFgdFr
        2VDIPcdT4kDmjTKT8yzSwQbauQ==
X-Google-Smtp-Source: AA0mqf6L4OyrVgqGkmxjCebTyV1vLgmPt0BG1zrTBUz9iolhq0kO0p8jCnI9pnLIyDpXDXDHScsPvg==
X-Received: by 2002:a05:6512:3d87:b0:4ad:5fbb:a5b0 with SMTP id k7-20020a0565123d8700b004ad5fbba5b0mr5374054lfv.466.1669315437716;
        Thu, 24 Nov 2022 10:43:57 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:43:57 -0800 (PST)
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
Subject: [PATCH v3 12/15] dt-bindings: remoteproc: qcom,sdx55-pas: split into separate file
Date:   Thu, 24 Nov 2022 19:43:30 +0100
Message-Id: <20221124184333.133911-13-krzysztof.kozlowski@linaro.org>
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

Split SDX55 remote processor Peripheral Authentication Service bindings
into their own file to reduce complexity and make maintenance easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch.
---
 .../bindings/remoteproc/qcom,adsp.yaml        |   4 -
 .../bindings/remoteproc/qcom,sdx55-pas.yaml   | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 7b93064fa0ae..10c96445da11 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -30,7 +30,6 @@ properties:
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
-      - qcom,sdx55-mpss-pas
 
   reg:
     maxItems: 1
@@ -125,7 +124,6 @@ allOf:
             enum:
               - qcom,sc7180-mpss-pas
               - qcom,sc7280-mpss-pas
-              - qcom,sdx55-mpss-pas
     then:
       properties:
         interrupts:
@@ -203,7 +201,6 @@ allOf:
           contains:
             enum:
               - qcom,sc7280-mpss-pas
-              - qcom,sdx55-mpss-pas
     then:
       properties:
         power-domains:
@@ -230,7 +227,6 @@ allOf:
               - qcom,qcs404-cdsp-pas
               - qcom,qcs404-wcss-pas
               - qcom,sdm660-adsp-pas
-              - qcom,sdx55-mpss-pas
     then:
       properties:
         qcom,qmp: false
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
new file mode 100644
index 000000000000..cbeaa00ca4d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sdx55-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDX55 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SDX55 SoC Peripheral Authentication Service loads and boots firmware
+  on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdx55-mpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  interrupts:
+    minItems: 6
+
+  interrupt-names:
+    minItems: 6
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MSS power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mss
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  smd-edge: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@4080000 {
+        compatible = "qcom,sdx55-mpss-pas";
+        reg = <0x04080000 0x4040>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover",
+                          "stop-ack", "shutdown-ack";
+
+        memory-region = <&mpss_adsp_mem>;
+
+        power-domains = <&rpmhpd SDX55_CX>, <&rpmhpd SDX55_MSS>;
+        power-domain-names = "cx", "mss";
+
+        qcom,smem-states = <&modem_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 114 IRQ_TYPE_EDGE_RISING>;
+            label = "mpss";
+            mboxes = <&apcs 15>;
+            qcom,remote-pid = <1>;
+
+            /* ... */
+        };
+    };
-- 
2.34.1

