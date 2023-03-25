Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9426C8E13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCYMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjCYMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C215166;
        Sat, 25 Mar 2023 05:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97FA3B80707;
        Sat, 25 Mar 2023 12:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55007C433D2;
        Sat, 25 Mar 2023 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747115;
        bh=7xUqAmJ8HSj2/hb/M/p5/jV57+kJbpWu0+glv9QlX/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMviEVP/Xf0ur7mqxmqR9WQ+gPEAqRHDQGGLy7qFK15RX2l8Ki3MzpuVkqnIKsRZ8
         CDUT3yPENbyF5Lq9f3V1A0Mc6+KmR8R4C+kM2eloe+pPOxkMgVQ7rM1+T/zjjvu/6j
         X5EV0QqYdCJZG105ebLyUmfI7vRG8Cu+TinqCCDKSCV6eocU9/B/f8rFbEH0qlhE+X
         +I67TxuoPNRD+j10OVOWwZoh4k6n1O1wMKnfPmXBV+NZU4GA3uIqZUJZDNDw/+jcX1
         feJtx7B0SkniPCR70doyZ7vdLvIsj/PXk+j6IIx2v3lkwP3MncDmixD0iHyfHwNCf+
         va4obFH5eahCw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] dt-bindings: interconnect: split SC8180x to own schema
Date:   Sat, 25 Mar 2023 17:54:37 +0530
Message-Id: <20230325122444.249507-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8180x comes with interconnects having and missing IO address space, and
variable number of clocks, so split it from common file for easier
maintenance and to fix warnings like:

sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      | 11 ---
 .../interconnect/qcom,sc8180x-rpmh.yaml       | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 4d93ad415e0b..5cbc3be49e99 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -39,17 +39,6 @@ properties:
       - qcom,sc7180-npu-noc
       - qcom,sc7180-qup-virt
       - qcom,sc7180-system-noc
-      - qcom,sc8180x-aggre1-noc
-      - qcom,sc8180x-aggre2-noc
-      - qcom,sc8180x-camnoc-virt
-      - qcom,sc8180x-compute-noc
-      - qcom,sc8180x-config-noc
-      - qcom,sc8180x-dc-noc
-      - qcom,sc8180x-gem-noc
-      - qcom,sc8180x-mc-virt
-      - qcom,sc8180x-mmss-noc
-      - qcom,sc8180x-qup-virt
-      - qcom,sc8180x-system-noc
       - qcom,sdm670-aggre1-noc
       - qcom,sdm670-aggre2-noc
       - qcom,sdm670-config-noc
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
new file mode 100644
index 000000000000..613af6caa71d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc8180x-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC8180X
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sc8180x.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8180x-aggre1-noc
+      - qcom,sc8180x-aggre1-noc
+      - qcom,sc8180x-aggre2-noc
+      - qcom,sc8180x-camnoc-virt
+      - qcom,sc8180x-compute-noc
+      - qcom,sc8180x-config-noc
+      - qcom,sc8180x-dc-noc
+      - qcom,sc8180x-gem-noc
+      - qcom,sc8180x-mc-virt
+      - qcom,sc8180x-mmss-noc
+      - qcom,sc8180x-qup-virt
+      - qcom,sc8180x-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8180x-camnoc-virt
+              - qcom,sc8180x-mc-virt
+              - qcom,sc8180x-qup-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    camnoc_virt: interconnect-0{
+        compatible = "qcom,sc8180x-camnoc-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+        compatible = "qcom,sc8180x-aggre1-noc";
+        reg = <0 0x016e0000 0 0xd080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
-- 
2.39.2

