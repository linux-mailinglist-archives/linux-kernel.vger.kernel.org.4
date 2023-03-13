Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E76B7AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjCMOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCMOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCB5BD93
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn21so19571550edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678718971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrLO0KWJlaMlC+CZ+FE9fXZZ5oPhA3AfMaYdpj7Fkb4=;
        b=JcS4GRaAiVv8Wz5FVAfmXy73Tujw5zGhxeb8ORlloR/9TPe1OLjh3PnvvovsDis3Yj
         wsaQ0M6VPr0Jsug2YGkGuaqtRin8IEuF2pge/vA4g/t1va8rc68rOQ0qw9YgDWLoKN/0
         juuljsHCGySdYXXUwOTRuV1oExe+WXK9pkKj9fdGojZx8N8CnOJDpnVCeQGBECbEj/Xt
         zv5+qRHW357JlAVY2ECLPp3VxmNNZX9xIdFuIzrfqKtXTrCx2vQZIoTam60mLlpnepzy
         AdmnKCYMhurrS0Kmh/jF4DKi7xH9COvZvuXQwG9twD26tGefRjDZQFnNESgOQvmbjoFF
         tXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrLO0KWJlaMlC+CZ+FE9fXZZ5oPhA3AfMaYdpj7Fkb4=;
        b=naW7piI1J+WrIDdkcR2QiP2OTmWkoKL05GY9+qykZv6uKeKdGTLu08e9XV95brjzPM
         1PvOW+TQOqmnyyELXNeJnn94i5nqdg0DuKb2amLhP2FBW5Dcf70gTvmEvXb8ruOeRxCL
         es6f8fy5dF33FoSR/xIy+8MLC45i44RE7ylrRCX7amH3/08H4qhbQdPcCfWBwTGTY+8m
         bahBWvWyUzWW0rgcdDeLcFlvobFcnZRQRawWFa0L/Nay7b1NIUcl3tNz+evdQFjgk7n4
         DeYGM5kzNyaWWJ12bzd/+XPIYhP/4LyuQxf1SEi+yv5N6a4Gh5LVPvJet4myLyB30Utr
         POSw==
X-Gm-Message-State: AO0yUKWOtz+ta0FaqwvMQq9t6ykh1A0/pDuw1gOBW5PqzueToY+yR4v7
        cK8+C9iHRK24o1Gcq+m8+rjR4w==
X-Google-Smtp-Source: AK7set8wmnPWxRvVWGzxFlfb7HUdieCBP1yA0YSGdRxA2z8d+Q/UAZzTMA1d4M6gGvfSN/lMNCNSDg==
X-Received: by 2002:a17:906:c301:b0:878:5372:a34b with SMTP id s1-20020a170906c30100b008785372a34bmr32368968ejz.45.1678718971242;
        Mon, 13 Mar 2023 07:49:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b0092153c6b549sm3030164ejc.22.2023.03.13.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:49:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 06/10] media: dt-bindings: samsung,exynos4210-csis: convert to dtschema
Date:   Mon, 13 Mar 2023 15:49:12 +0100
Message-Id: <20230313144916.511884-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
References: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5P/Exynos SoC series MIPI CSI-2 receiver (MIPI
CSIS) bindings to DT schema.  Changes during conversion - adjust to
existing DTS and Linux driver:
1. Add phys and power-domains.
2. Move samsung,csis-wclk property to the endpoint node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Add Rb tag.
2. Move size-cells next to address-cells.
---
 .../media/samsung,exynos4210-csis.yaml        | 170 ++++++++++++++++++
 .../bindings/media/samsung-mipi-csis.txt      |  81 ---------
 MAINTAINERS                                   |   1 +
 3 files changed, 171 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-mipi-csis.txt

diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
new file mode 100644
index 000000000000..dd6cc7ac1f7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos4210-csis.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC series MIPI CSI-2 receiver (MIPI CSIS)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s5pv210-csis
+      - samsung,exynos4210-csis
+      - samsung,exynos4212-csis
+      - samsung,exynos5250-csis
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2, 4]
+    description:
+      Number of data lines supported.
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: csis
+      - const: sclk_csis
+
+  clock-frequency:
+    default: 166000000
+    description:
+      The IP's main (system bus) clock frequency in Hz.
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: csis
+
+  power-domains:
+    maxItems: 1
+
+  vddio-supply:
+    description: MIPI CSIS I/O and PLL voltage supply (e.g. 1.8V).
+
+  vddcore-supply:
+    description: MIPI CSIS Core voltage supply (e.g. 1.1V).
+
+patternProperties:
+  "^port@[34]$":
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description:
+      Camera input port.
+
+    properties:
+      reg:
+        enum: [3, 4]
+
+      endpoint:
+        $ref: video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            minItems: 1
+            maxItems: 4
+
+          samsung,csis-hs-settle:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Differential receiver (HS-RX) settle time.
+
+          samsung,csis-wclk:
+            type: boolean
+            description:
+              CSI-2 wrapper clock selection. If this property is present external clock
+              from CMU will be used, or the bus clock if it's not specified.
+
+        required:
+          - data-lanes
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - bus-width
+  - clocks
+  - clock-names
+  - interrupts
+  - vddio-supply
+  - vddcore-supply
+
+anyOf:
+  - required:
+      - port@3
+  - required:
+      - port@4
+
+allOf:
+  - if:
+      required:
+        - samsung,isp-wb
+    then:
+      required:
+        - samsung,sysreg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    csis@11890000 {
+        compatible = "samsung,exynos4210-csis";
+        reg = <0x11890000 0x4000>;
+        clocks = <&clock CLK_CSIS1>,
+                 <&clock CLK_SCLK_CSIS1>;
+        clock-names = "csis", "sclk_csis";
+        assigned-clocks = <&clock CLK_MOUT_CSIS1>,
+                          <&clock CLK_SCLK_CSIS1>;
+        assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+        assigned-clock-rates = <0>, <176000000>;
+
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+
+        bus-width = <2>;
+        power-domains = <&pd_cam>;
+        phys = <&mipi_phy 2>;
+        phy-names = "csis";
+
+        vddcore-supply = <&ldo8_reg>;
+        vddio-supply = <&ldo10_reg>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Camera D (4) MIPI CSI-2 (CSIS1) */
+        port@4 {
+            reg = <4>;
+
+            endpoint {
+                remote-endpoint = <&is_s5k6a3_ep>;
+                data-lanes = <1>;
+                samsung,csis-hs-settle = <18>;
+                samsung,csis-wclk;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-mipi-csis.txt b/Documentation/devicetree/bindings/media/samsung-mipi-csis.txt
deleted file mode 100644
index a4149c9434ea..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-mipi-csis.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Samsung S5P/Exynos SoC series MIPI CSI-2 receiver (MIPI CSIS)
--------------------------------------------------------------
-
-Required properties:
-
-- compatible	  : "samsung,s5pv210-csis" for S5PV210 (S5PC110),
-		    "samsung,exynos4210-csis" for Exynos4210 (S5PC210),
-		    "samsung,exynos4212-csis" for Exynos4212/Exynos4412,
-		    "samsung,exynos5250-csis" for Exynos5250;
-- reg		  : offset and length of the register set for the device;
-- interrupts      : should contain MIPI CSIS interrupt; the format of the
-		    interrupt specifier depends on the interrupt controller;
-- bus-width	  : maximum number of data lanes supported (SoC specific);
-- vddio-supply    : MIPI CSIS I/O and PLL voltage supply (e.g. 1.8V);
-- vddcore-supply  : MIPI CSIS Core voltage supply (e.g. 1.1V);
-- clocks	  : list of clock specifiers, corresponding to entries in
-		    clock-names property;
-- clock-names	  : must contain "csis", "sclk_csis" entries, matching entries
-		    in the clocks property.
-
-Optional properties:
-
-- clock-frequency : The IP's main (system bus) clock frequency in Hz, default
-		    value when this property is not specified is 166 MHz;
-- samsung,csis-wclk : CSI-2 wrapper clock selection. If this property is present
-		    external clock from CMU will be used, or the bus clock if
-		    if it's not specified.
-
-The device node should contain one 'port' child node with one child 'endpoint'
-node, according to the bindings defined in Documentation/devicetree/bindings/
-media/video-interfaces.txt. The following are properties specific to those nodes.
-
-port node
----------
-
-- reg		  : (required) must be 3 for camera C input (CSIS0) or 4 for
-		    camera D input (CSIS1);
-
-endpoint node
--------------
-
-- data-lanes	  : (required) an array specifying active physical MIPI-CSI2
-		    data input lanes and their mapping to logical lanes; the
-		    array's content is unused, only its length is meaningful;
-
-- samsung,csis-hs-settle : (optional) differential receiver (HS-RX) settle time;
-
-
-Example:
-
-	reg0: regulator@0 {
-	};
-
-	reg1: regulator@1 {
-	};
-
-/* SoC properties */
-
-	csis_0: csis@11880000 {
-		compatible = "samsung,exynos4210-csis";
-		reg = <0x11880000 0x1000>;
-		interrupts = <0 78 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-/* Board properties */
-
-	csis_0: csis@11880000 {
-		clock-frequency = <166000000>;
-		vddio-supply = <&reg0>;
-		vddcore-supply = <&reg1>;
-		port {
-			reg = <3>; /* 3 - CSIS0, 4 - CSIS1 */
-			csis0_ep: endpoint {
-				remote-endpoint = <...>;
-				data-lanes = <1>, <2>;
-				samsung,csis-hs-settle = <12>;
-			};
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2892858cb040..19d0e5fb913e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18556,6 +18556,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
+F:	Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
 F:	drivers/media/platform/samsung/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
-- 
2.34.1

