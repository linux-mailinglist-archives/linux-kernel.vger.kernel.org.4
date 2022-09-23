Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675675E7F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiIWQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiIWQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:16:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE55E133CB2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o2so1024708lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y26y447ZUu1UA/YFiP/jpdxnrW5X4XPXwhMFolSfH4Q=;
        b=heAO9fXaSqpqsZJ4/K+Dhrm3dxAAVAzQlV4VH3vD+EPJr7Dm8ESjs7YuGccLjJ2dLM
         yzxuZXUrFmwl1cmYsLhudRifz3fXsfyL/No8toH7oqYxG4BbAtBKuutdXE/s+VzOmJY2
         mTjauiRTtqfNweqnVXj30KGjwaobTfJArG+qXusNoZ/iQwnAwmOJLPGxXpUsooYdMuWx
         9Cd71uR0vDnfq/lTZrfVx6usFqQiUqxKGQFPWh/LEAKVwmNCYslBhrGe/HisKyjHV7Xq
         IMtuGi85ySyta5BAtqJ8Opu4iXAukxihtvhFKLHx4pLAu3d5FjeKOs32jk6Naqj101j5
         hHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y26y447ZUu1UA/YFiP/jpdxnrW5X4XPXwhMFolSfH4Q=;
        b=UY9On0kLBMLDGf9cA3CNjhK18PrRE/D3jwVV0kKnh8GQkVOptyrmR7o7Xb07oFPc3J
         slTdFHch9p5E+RbaFu3TGV6ou7LOHwWDY6UpvteQBKk7oV72XZaSBRCVnkDnd22kCYSr
         xYK6OBqPlLDNIuCIXLK+Tx8GY5ZroF/AuDA2uup80SIDxKsmHiu9IFq0D3ZE3wlwshp4
         yvDtVHd73y5oCsbPS3fjHjvIknB2Cjqll8SUXN6PLQ9sCOLK1sMyBaE0/YCedmI1lrzq
         bPr7es0ZTRIZFX4opoccALAhp7YJcAS8aChCaMg+DVG3K7L/T1Z2TUPnKJR5Il1NVN6R
         Xx/w==
X-Gm-Message-State: ACrzQf3d2e0Yj+pGIqKcS7reKqJakMBVy66GZoFSnl7WvKl2kXaPw3w4
        oujW6VJxvrRaDL2WSWdbBA4dZQ==
X-Google-Smtp-Source: AMsMyM4hfaeYiggwtqqGuXTfoAmqbc4jHyycxViHXY6ewrvXRtS20UC3Vfid1Q13cxaxsAGxBxczxQ==
X-Received: by 2002:a05:6512:2294:b0:49e:f3d0:4cef with SMTP id f20-20020a056512229400b0049ef3d04cefmr3426470lfu.183.1663949776984;
        Fri, 23 Sep 2022 09:16:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25cc9000000b00492f45cbbfcsm1493491lfq.302.2022.09.23.09.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:16:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/11] dt-bindings: slimbus: qcom,slim: convert to DT schema
Date:   Fri, 23 Sep 2022 18:14:52 +0200
Message-Id: <20220923161453.469179-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm SoC SLIMbus controller bindings to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/slimbus/qcom,slim.yaml           | 86 +++++++++++++++++++
 .../bindings/slimbus/slim-qcom-ctrl.txt       | 36 --------
 2 files changed, 86 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml b/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
new file mode 100644
index 000000000000..883bda58ca97
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/slimbus/qcom,slim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC SLIMbus controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  SLIMbus controller used when applications processor controls SLIMbus master
+  component.
+
+allOf:
+  - $ref: slimbus.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,apq8064-slim
+      - const: qcom,slim
+
+  reg:
+    items:
+      - description: Physical address of controller register blocks
+      - description: SLEW RATE register
+
+  reg-names:
+    items:
+      - const: ctrl
+      - const: slew
+
+  clocks:
+    items:
+      - description: Interface clock for this controller
+      - description: Interrupt for controller core's BAM
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+    #include <dt-bindings/clock/qcom,lcc-msm8960.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        slim@28080000 {
+            compatible = "qcom,apq8064-slim", "qcom,slim";
+            reg = <0x28080000 0x2000>, <0x80207c 4>;
+            reg-names = "ctrl", "slew";
+            interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+            clock-names = "iface", "core";
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            audio-codec@1,0 {
+                compatible = "slim217,60";
+                reg = <1 0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
deleted file mode 100644
index 6d955e129f90..000000000000
--- a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Qualcomm SLIMbus controller
-This controller is used if applications processor driver controls SLIMbus
-master component.
-
-Required properties:
-
- - reg : Offset and length of the register region(s) for the device
- - reg-names : Register region name(s) referenced in reg above
-	 Required register resource entries are:
-	 "ctrl": Physical address of controller register blocks
- 	 "slew": required for "qcom,apq8064-slim" SOC.
- - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible
- 		followed by "qcom,slim" for fallback.
- - interrupts : Interrupt number used by this controller
- - clocks : Interface and core clocks used by this SLIMbus controller
- - clock-names : Required clock-name entries are:
-	"iface" : Interface clock for this controller
-	"core" : Interrupt for controller core's BAM
-
-Example:
-
-	slim@28080000 {
-		compatible = "qcom,apq8064-slim", "qcom,slim";
-		reg = <0x28080000 0x2000>, <0x80207C 4>;
-		reg-names = "ctrl", "slew";
-		interrupts = <0 33 0>;
-		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
-		clock-names = "iface", "core";
-		#address-cells = <2>;
-		#size-cell = <0>;
-
-		wcd9310: audio-codec@1,0{
-			compatible = "slim217,60";
-			reg = <1 0>;
-		};
-	};
-- 
2.34.1

