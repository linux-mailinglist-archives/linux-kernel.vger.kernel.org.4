Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773A95EE01D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiI1PVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiI1PVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:21:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2D5C362
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t16so10704318ljh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ap86oaX2me6LTIfHjN4MG9KcHVBwjDqudIZuJpAwdCI=;
        b=r0nknO9O4RLaj4hC2Y+XYYFZgnRhgnHvRdHYbBHhBMYvEHW3c7GIcYsIDH7b3XoE+O
         9eWnl61JVTAwK0VMgQPw9TXIgU8+w0Vt0qzMEIfPLLkZd7BkW8LOPmr+C5KpwuXknb7t
         tdws40dJtduiv7OCW8mACe0Mv/6HkuEvV4pcpw4kQcDofryBg8ND4gAIx3tXkgCgnz7C
         y4o4uIFCQgomvp6Ex2vx2kJ0fVL4BxY+ofuP+BGJBPJ0KmR7wVDJ1XU3PeYdUonwKrlK
         fKn4pIq1YdssWhJ0g4+jwFUr1wEGMEGotptptvY5hFMIA2N8HSPt8tJ7/sy6xsO7eXLc
         Kbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ap86oaX2me6LTIfHjN4MG9KcHVBwjDqudIZuJpAwdCI=;
        b=2GsezUEVDjB9HK6ubnCqy2Ajs4zNISXHuHdjGycKX1h/ryF7r6mQhnHvetu6Urb9hp
         bmi2gaknINnWOhbBwFibkX/aUq7a36aRAVsqpQBtdHIfqmNp3GCuC3G3v6G8YoH8M/sp
         lHEJRd4t1SeXm1SKDatQ94ZMaufZRuN86E+0nogoLusO2eW/Oe0P/i+aQUw9Ub7MKMZc
         I4yaizEDRVitVJX/LNkgj93h5gPeaRoskNq0TyB6/GxfD3RcWpPwN9dyGFreb67+Cw6Z
         xqm/W6f86nE+re37aDIOqV6sMYAO15cgBO7/21IgoeLjYbqEg8bwcbRb9yrb4ppSaJ39
         09XA==
X-Gm-Message-State: ACrzQf3/yO13V67sfvcnXxfwZldhhgNHd6DyIT8dsW3AldaiPj/41Q8Y
        gDkW8Hcu5qwSgA+yECMtbXv7YQ==
X-Google-Smtp-Source: AMsMyM7kw7pi094V6o9qurMVZ0dvLd2F1wG+kqjI0ZCAc2o0mrbyTly60r9u6BoNnfLe2Ce7XGhA/Q==
X-Received: by 2002:a2e:ba08:0:b0:26c:14d6:9b97 with SMTP id p8-20020a2eba08000000b0026c14d69b97mr11872009lja.222.1664378446051;
        Wed, 28 Sep 2022 08:20:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b00497a41b3a42sm503023lfq.88.2022.09.28.08.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 11/11] dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema
Date:   Wed, 28 Sep 2022 17:20:27 +0200
Message-Id: <20220928152027.489543-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm SoC SLIMBus Non Generic Device (NGD) controller
bindings to DT Schema.

During conversion add iommus already present in DTS and extend the
example based on SDM845.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/slimbus/qcom,slim-ngd.yaml       | 120 ++++++++++++++++++
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  82 ------------
 2 files changed, 120 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml b/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
new file mode 100644
index 000000000000..abf61c15246e
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC SLIMBus Non Generic Device (NGD) Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  SLIMBus NGD controller is a light-weight driver responsible for communicating
+  with SLIMBus slaves directly over the bus using messaging interface and
+  communicating with master component residing on ADSP for bandwidth and
+  data-channel management
+
+properties:
+  compatible:
+    enum:
+      - qcom,slim-ngd-v1.5.0        # for MSM8996
+      - qcom,slim-ngd-v2.1.0        # for SDM845
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+patternProperties:
+  "^slim@[0-9a-f]+$":
+    type: object
+    $ref: slimbus.yaml#
+    description:
+      Each subnode represents an instance of NGD
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - dmas
+  - dma-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    slim-ngd@171c0000 {
+        compatible = "qcom,slim-ngd-v2.1.0";
+        reg = <0x171c0000 0x2c000>;
+        interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+
+        dmas = <&slimbam 3>, <&slimbam 4>;
+        dma-names = "rx", "tx";
+        iommus = <&apps_smmu 0x1806 0x0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        slim@1 {
+            reg = <1>;
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            codec@1,0 {
+                compatible = "slim217,250";
+                reg = <1 0>;
+                slim-ifc-dev = <&wcd9340_ifd>;
+
+                #sound-dai-cells = <1>;
+
+                interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-controller;
+                #interrupt-cells = <1>;
+
+                #clock-cells = <0>;
+                clock-frequency = <9600000>;
+                clock-output-names = "mclk";
+                qcom,micbias1-microvolt = <1800000>;
+                qcom,micbias2-microvolt = <1800000>;
+                qcom,micbias3-microvolt = <1800000>;
+                qcom,micbias4-microvolt = <1800000>;
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+
+                /* Rest of the WCD9340 codec */
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
deleted file mode 100644
index 7c3d9eb6af5d..000000000000
--- a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
-
-SLIMBus NGD controller is a light-weight driver responsible for communicating
-with SLIMBus slaves directly over the bus using messaging interface and
-communicating with master component residing on ADSP for bandwidth and
-data-channel management
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,slim-ngd-v<MAJOR>.<MINOR>.<STEP>"
-	must be one of the following.
-	"qcom,slim-ngd-v1.5.0" for MSM8996
-	"qcom,slim-ngd-v2.1.0" for SDM845
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the controller
-		    register space.
-- dmas
-	Usage: required
-	Value type: <array of phandles>
-	Definition: List of rx and tx dma channels
-
-- dma-names
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "rx" and "tx".
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must list controller IRQ.
-
-#address-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 1, reflecting the instance id of ngd.
-
-#size-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 0
-
-= NGD Devices
-Each subnode represents an instance of NGD, must contain the following
-properties:
-
-- reg:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be instance id of ngd.
-
-#address-cells
-	Usage: required
-	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
-
-#size-cells
-	Usage: required
-	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
-
-= EXAMPLE
-
-slim@91c0000 {
-	compatible = "qcom,slim-ngd-v1.5.0";
-	reg = <0x91c0000 0x2c000>;
-	interrupts = <0 163 0>;
-	dmas =	<&slimbam 3>, <&slimbam 4>;
-	dma-names = "rx", "tx";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	ngd@1 {
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		codec@1 {
-			compatible = "slim217,1a0";
-			reg  = <1 0>;
-		};
-	};
-};
-- 
2.34.1

