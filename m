Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D215BB93B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIQP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:57:46 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F32EF28;
        Sat, 17 Sep 2022 08:57:46 -0700 (PDT)
Received: from g550jk.fritz.box (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BB0A3C7077;
        Sat, 17 Sep 2022 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1663430234; bh=Q90aA1AKKYZDDkkzaHwQIaLHhrdPXOZzAV5knNGK7Jc=;
        h=From:To:Cc:Subject:Date;
        b=mGXAZpTlXg+XhikM1/90ixBebnjRCxoqL866paNid0lTKF4qV08lNm8tcNcET8t2i
         cnj9fSxxMgguX4mqQN9NWVOHAnt4YlrMLXdlszdD5eJtX9FPhH9BuuRuBgMn3QUCoK
         FM9eDjxkXhtLAlC60qxHYSBg2ScqulFBeZgT1o/k=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: qcom,pm8xxx-vib: convert to yaml
Date:   Sat, 17 Sep 2022 17:57:00 +0200
Message-Id: <20220917155705.2284-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PM8xxx PMIC Vibrator bindings to dt-schema.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../bindings/input/qcom,pm8xxx-vib.txt        | 23 -----------
 .../bindings/input/qcom,pm8xxx-vib.yaml       | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
deleted file mode 100644
index 64bb990075c3..000000000000
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Qualcomm PM8xxx PMIC Vibrator
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,pm8058-vib"
-		    "qcom,pm8916-vib"
-		    "qcom,pm8921-vib"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: address of vibration control register
-
-EXAMPLE
-
-	vibrator@4a {
-		compatible = "qcom,pm8058-vib";
-		reg = <0x4a>;
-	};
diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
new file mode 100644
index 000000000000..c8832cd0d7da
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,pm8xxx-vib.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8xxx PMIC Vibrator
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8058-vib
+      - qcom,pm8916-vib
+      - qcom,pm8921-vib
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vibrator@4a {
+            compatible = "qcom,pm8058-vib";
+            reg = <0x4a>;
+        };
+    };
-- 
2.37.3

