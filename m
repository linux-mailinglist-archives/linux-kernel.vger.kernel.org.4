Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4862EDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiKRGyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiKRGxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC37A61B89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so7775903wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW2ImcSmUChSV3E/dSBztf3dQvk9hKElDF9ihvQ4jx0=;
        b=itZ1US1sgMxbbhce6J4e2hwPivP1WnvfRpMLKVq2QXxGzkXaIKQP4gcBtePsP0G8DD
         IBRLOM8Y7NRE1gFuyTa71mz1lqjg3sDaKM/C5NVCeCvKkDDRbvBaHSJnaVL7Rz8lg3oQ
         6kX93knnemeWV6wne1ZfucQuu+5bDrhwMyXMDrZDE+xkpfB5oRQro5GO0XOcUr+qVm7y
         IjQKC4vJL92TpG6bxTWJcYrt1rwZK/mrArKmpg+M2Ln2SWJhAFN7FPYsQiiicrkqat8b
         dbgcRedwzIuxbndBXq7Yp4pthAFj71BIJirvu3pQ72B2tdWf3jsYVCMK9ROeFi/IUNtk
         GO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW2ImcSmUChSV3E/dSBztf3dQvk9hKElDF9ihvQ4jx0=;
        b=LCrJa/trHULROMjAakwWGaQMZ0H0SUeUQJy1PBI9zDg62K0LEC295sxECF5vBF4kd4
         Bd+2GBjfcxoryo6jjQ4LiV4LA59Q9BuPfxif1SEzxhVZQ43E3O+QxvT2ugTgVRvmkRzc
         aFKEDva3iKKCZ2yseUzTHmgQgZF6yabEvTCWPX9/sxdv4uTL7Y/Gi9NFvp/dMfwJ5u5M
         4MdlyD87BeIRdSRbupp0N8DoxAMruocNL6LzNbWf+F2jCXM+M7EvB0J4vxU0ewENclOq
         QvQAgrbbYsGaH4gDTQmAF+aOf4xrTh7+y+c2ZMbXGsooLriZpEJXMqxKBwISe9XQM2O5
         VZuQ==
X-Gm-Message-State: ANoB5pmBEQvhBnhrdIRd+W4g9RkSK1vSeW/maCTCFdzbPMJmiS/FRiYR
        wojlOC3jlesqdbUeXhNgSnT072TXEWV7ag==
X-Google-Smtp-Source: AA0mqf4AQ4kEK71t9B0+3hYT83Jk/sjYK6IyElfS22ymku2Hl3ybB3LKqHXI4GiVvq5Xt2N99mc6MQ==
X-Received: by 2002:adf:f644:0:b0:241:a8a5:bc03 with SMTP id x4-20020adff644000000b00241a8a5bc03mr3456754wrp.464.1668754390265;
        Thu, 17 Nov 2022 22:53:10 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/12] dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema
Date:   Fri, 18 Nov 2022 06:52:46 +0000
Message-Id: <20221118065246.6835-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Convert the Qualcomm SoC SLIMBus Non Generic Device (NGD) controller
bindings to DT Schema.

During conversion add iommus already present in DTS and extend the
example based on SDM845.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

