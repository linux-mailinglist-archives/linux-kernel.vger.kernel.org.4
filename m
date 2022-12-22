Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78396544B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiLVP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLVP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:58:13 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F013F87
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:58:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z26so3335128lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMjFvAc355kr48zmdBVbKSbyLovJA0hSlBO5w8VD+S8=;
        b=HG5eqalLgDkaCc0fZtvWDUddmZ+nLVCqcAJXmlbrMBigRLuhIM6tYSE8sTXqCAVNI1
         YTylL3DWllE94OxUCkJlPBpxnMewKIKMt2JC2eiMyKrWUi3u4mQkOYYfsfHLS7ha49yL
         r5GeLQxwD6wT9Dq6dDOs9ikwX3BVp21KHbjH+tcdK/+C0BqWnJUPCwQAZ8ujd8v9YabX
         Fd1P07YhGGLIBrz96jADsvN3061KF46vloyr+KyI3h9AEUbEPgyvgkJUOjnxLJVV7rlE
         VvxBcIPWHvReq6iuDYY5wV4rVCJ8UOLfkDoHsiq5p1pT557lW6ilvqndNxkFBF9k+0gM
         sOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMjFvAc355kr48zmdBVbKSbyLovJA0hSlBO5w8VD+S8=;
        b=DvZaoB9fFyhCPZbvJSRycfp2iZAb0xALwGFkh/vqQobCproYWZlon6LhVYPPK1D5yA
         596QVcul4MQRAu4KwMuglOc3HKzTLPldlaVDJO92IUA5kjGl7gga5UJfhVcvU3T01evj
         2msQmUMK1BpmoIIDbT6y37Zqv0WqtNelx53rLy5aPcwzvKhM9MSLvP38axmVP0CoeOXn
         pOWXcvCLMzbWePvm4DA5IUn47rOKAAPDNvEE0c5f1In2wyV89FxuB8juj0ceXF+pF8Ps
         q6i4rbfKhrpfey4D3nU6p00qn1KuNH7pXzf0CWAAzfCKjw497Cdf2JDlnWhoqeE9wznG
         h0+A==
X-Gm-Message-State: AFqh2kr7H5NOsLosveWs+lO+wUea8ow1S1//P9BY+I8BJRpHTlGpUE1F
        PtF2y54lzgtsPiFv2SKBrb4a+A==
X-Google-Smtp-Source: AMrXdXsKWoi5bmee8dep2HkIc4gTHnKVltaqGKZSUEav8C4bDfZ8MSgNavKWZnRcR82HGcwi1tlk0A==
X-Received: by 2002:a05:6512:3410:b0:4a4:68b8:f4db with SMTP id i16-20020a056512341000b004a468b8f4dbmr1840355lfr.33.1671724689795;
        Thu, 22 Dec 2022 07:58:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512390e00b004b5872a7003sm111390lfu.98.2022.12.22.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:58:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@oss.nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: phy: qcom,usb-hsic-phy: convert to DT schema
Date:   Thu, 22 Dec 2022 16:58:05 +0100
Message-Id: <20221222155805.139284-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert Qualcomm USB HSIC PHY bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/qcom,usb-hsic-phy.txt        | 65 ------------------
 .../bindings/phy/qcom,usb-hsic-phy.yaml       | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
deleted file mode 100644
index 3c7cb2be4b12..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Qualcomm's USB HSIC PHY
-
-PROPERTIES
-
-- compatible:
-    Usage: required
-    Value type: <string>
-    Definition: Should contain "qcom,usb-hsic-phy" and more specifically one of the
-		following:
-
-			"qcom,usb-hsic-phy-mdm9615"
-			"qcom,usb-hsic-phy-msm8974"
-
-- #phy-cells:
-    Usage: required
-    Value type: <u32>
-    Definition: Should contain 0
-
-- clocks:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: Should contain clock specifier for phy, calibration and
-                a calibration sleep clock
-
-- clock-names:
-    Usage: required
-    Value type: <stringlist>
-    Definition: Should contain "phy, "cal" and "cal_sleep"
-
-- pinctrl-names:
-    Usage: required
-    Value type: <stringlist>
-    Definition: Should contain "init" and "default" in that order
-
-- pinctrl-0:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: List of pinctrl settings to apply to keep HSIC pins in a glitch
-                free state
-
-- pinctrl-1:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: List of pinctrl settings to apply to mux out the HSIC pins
-
-EXAMPLE
-
-usb-controller {
-	ulpi {
-		phy {
-			compatible = "qcom,usb-hsic-phy-msm8974",
-				     "qcom,usb-hsic-phy";
-			#phy-cells = <0>;
-			pinctrl-names = "init", "default";
-			pinctrl-0 = <&hsic_sleep>;
-			pinctrl-1 = <&hsic_default>;
-			clocks = <&gcc GCC_USB_HSIC_CLK>,
-				 <&gcc GCC_USB_HSIC_IO_CAL_CLK>,
-				 <&gcc GCC_USB_HSIC_IO_CAL_SLEEP_CLK>;
-			clock-names = "phy", "cal", "cal_sleep";
-			assigned-clocks = <&gcc GCC_USB_HSIC_IO_CAL_CLK>;
-			assigned-clock-rates = <960000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.yaml
new file mode 100644
index 000000000000..077e13a94448
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,usb-hsic-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm USB HSIC PHY Controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Vinod Koul <vkoul@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,usb-hsic-phy-mdm9615
+          - qcom,usb-hsic-phy-msm8974
+      - const: qcom,usb-hsic-phy
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: phy
+      - const: cal
+      - const: cal_sleep
+
+  "#phy-cells":
+    const: 0
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    items:
+      - const: init
+      - const: default
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - pinctrl-0
+  - pinctrl-1
+  - pinctrl-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+
+    phy {
+        compatible = "qcom,usb-hsic-phy-msm8974",
+                     "qcom,usb-hsic-phy";
+        clocks = <&gcc GCC_USB_HSIC_CLK>,
+                 <&gcc GCC_USB_HSIC_IO_CAL_CLK>,
+                 <&gcc GCC_USB_HSIC_IO_CAL_SLEEP_CLK>;
+        clock-names = "phy", "cal", "cal_sleep";
+        #phy-cells = <0>;
+        pinctrl-names = "init", "default";
+        pinctrl-0 = <&hsic_sleep>;
+        pinctrl-1 = <&hsic_default>;
+    };
-- 
2.34.1

