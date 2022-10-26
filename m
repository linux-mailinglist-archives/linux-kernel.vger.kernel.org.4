Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80E60E59A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiJZQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiJZQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:43:30 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC072EC3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bb5so10312734qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap86oaX2me6LTIfHjN4MG9KcHVBwjDqudIZuJpAwdCI=;
        b=UmtCcKD4KAPnaB2ke6wYCS13xUHB24tXh8DiLOfjGIFkhzqDAiYkLoijyVH6bvtsdN
         G+paNpE9WfDbFaws+qf/yo2UJPMDAxKjYrwVQ67FdnOeBJqEcI3utIBJFUT50PMx7eSI
         424VVhMC81YL2Xnp2MPXuwVdsD/y/ece7QA08tA+udUlutE70e0DnnNaRobtHeEZIkMi
         T0gEqEEqH0u5fpi91wRFOBv2966MuC58YThD/u8PeEi06+xoOb7qE1DLvRLxlLp70piQ
         Dch1+VBt7Qjmd9rvckF8fM7lNZCf2qXLY+Kco8xAKGTD5HB349qhEcPOpk8fsQKtf9l1
         o55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap86oaX2me6LTIfHjN4MG9KcHVBwjDqudIZuJpAwdCI=;
        b=Jsvfxxzf8P7UBGTafVS5qn9okUxLs5FALmuVy5i4xXHS8SG7qTg1vvf8DIbeTsZyxL
         Q6zGLhdMoKQrSBmsbNm/y/iR9GS0CjOxW0joZNoUeJcL/tobvHMxdSBcbwAlv7DLLLZG
         /GjvoyeMAzJtorzYfQAfz2NiRTg1NYIlNy9ZWFj5BSBogsv7l+b6gZygMwYn3QAFGLjj
         zTwOcd6YdjHEUDCsDiiYJvWewG8xmeKY2C05cGxLM19fqv7oZb4T9K8/b1CMWGf4DEhO
         Kd9oZmm1GhzUB7yB1e15YhPRtuR8/yBR3xxRUG4CeVX5q66daEPyUTlqQi3kGUTt1S1y
         JVUw==
X-Gm-Message-State: ACrzQf0eaQ/X/GmCXEe1umzDsUY+HAyf+VLe9HVhRTlnbDOso0nH8i7x
        E/0lhyiarxrII72tc0KpZHZwGQ==
X-Google-Smtp-Source: AMsMyM7mzANluI1ojMSrgWhKzF9ZFo0jBVVdvaI8FpeHTJXfky9mEFQ+e/VN2xn18XU2F2Hsu9kJAg==
X-Received: by 2002:a05:622a:178e:b0:39c:c9ac:b4ad with SMTP id s14-20020a05622a178e00b0039cc9acb4admr38620979qtk.82.1666802606807;
        Wed, 26 Oct 2022 09:43:26 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j6-20020a37c246000000b006eed47a1a1esm3989938qkm.134.2022.10.26.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:43:26 -0700 (PDT)
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
Subject: [PATCH v3 3/3] dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema
Date:   Wed, 26 Oct 2022 12:43:15 -0400
Message-Id: <20221026164315.39038-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026164315.39038-1-krzysztof.kozlowski@linaro.org>
References: <20221026164315.39038-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

