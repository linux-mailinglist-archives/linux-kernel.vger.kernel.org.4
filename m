Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515EF5FF95C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJOJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJOJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:10:28 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B765C7;
        Sat, 15 Oct 2022 02:10:27 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 71151C9D52;
        Sat, 15 Oct 2022 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665825023; bh=6JCUCll7KO+Z8XkfLAf6x6nD8Nh28IVWwpklTXnuBvQ=;
        h=From:To:Cc:Subject:Date;
        b=xL2TEOfrWgC9oD2frtEPnEsWPK6BfI/fewj2w9WtEv/nSjtJUgzVEDdZs+qWl6MLi
         Dwdx56ybv7akkYHyMk8Y/NWtMI/pLWcbgGav+YYcxETaYjMKumcAvBa4ooPi2lvtDD
         +BN58acoOof/6ktNA2+N7v2Xf5Gk2TY3+NSWrweo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert qcom,lcc to DT schema
Date:   Sat, 15 Oct 2022 11:09:44 +0200
Message-Id: <20221015090946.448820-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the text bindings for the lcc to yaml format. Doing this showed
that clocks and clock-names were not documented, so fix that now.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/clock/qcom,lcc.txt    | 22 -----
 .../devicetree/bindings/clock/qcom,lcc.yaml   | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,lcc.txt b/Documentation/devicetree/bindings/clock/qcom,lcc.txt
deleted file mode 100644
index a3c78aa88038..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,lcc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Qualcomm LPASS Clock & Reset Controller Binding
-------------------------------------------------
-
-Required properties :
-- compatible : shall contain only one of the following:
-
-			"qcom,lcc-msm8960"
-			"qcom,lcc-apq8064"
-			"qcom,lcc-ipq8064"
-			"qcom,lcc-mdm9615"
-
-- reg : shall contain base register location and length
-- #clock-cells : shall contain 1
-- #reset-cells : shall contain 1
-
-Example:
-	clock-controller@28000000 {
-		compatible = "qcom,lcc-ipq8064";
-		reg = <0x28000000 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,lcc.yaml b/Documentation/devicetree/bindings/clock/qcom,lcc.yaml
new file mode 100644
index 000000000000..03c99435d342
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lcc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,lcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS Clock & Reset Controller Binding
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,lcc-apq8064
+      - qcom,lcc-ipq8064
+      - qcom,lcc-mdm9615
+      - qcom,lcc-msm8960
+
+  clocks:
+    minItems: 8
+    maxItems: 8
+
+  clock-names:
+    minItems: 8
+    maxItems: 8
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,lcc-apq8064
+              - qcom,lcc-msm8960
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board PXO source
+            - description: PLL 4 Vote clock
+            - description: MI2S codec clock
+            - description: Mic I2S codec clock
+            - description: Mic I2S spare clock
+            - description: Speaker I2S codec clock
+            - description: Speaker I2S spare clock
+            - description: PCM codec clock
+
+        clock-names:
+          items:
+            - const: pxo
+            - const: pll4_vote
+            - const: mi2s_codec_clk
+            - const: codec_i2s_mic_codec_clk
+            - const: spare_i2s_mic_codec_clk
+            - const: codec_i2s_spkr_codec_clk
+            - const: spare_i2s_spkr_codec_clk
+            - const: pcm_codec_clk
+
+      required:
+        - clocks
+        - clock-names
+
+examples:
+  - |
+    clock-controller@28000000 {
+        compatible = "qcom,lcc-ipq8064";
+        reg = <0x28000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.38.0

