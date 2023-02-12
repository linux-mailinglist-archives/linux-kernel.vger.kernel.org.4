Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7C693995
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBLTDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBLTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:03:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11DE113C1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:02:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so10153546wrv.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jp56sYQoHAokca/oYMLhoMcY9QYcJFk0U8rfiABjgw=;
        b=fSsgeFjfmEek35xvG9WBvp2mUWxvSgrON7WLQyD7dd34xS23GRHi1cHJyPFTHfBugT
         JkBPm4yOVIWOY19g8YU8dbdnJDRoMtT0/r4eB8arvdolZpUsyzt47hX5I1yGKS9eVDY/
         rjQO3ZCP7SUkHWd5M6RKlA+IyeyRCz89MgrlzuHgE7LIInwZymJiI3vpGNkkyctAENdl
         Ed0x0VCLpDAPoimgYrhR30RAefCRg1HPAKSn0GuchA5iluelqKRfq9fPoua12Q6m0ZmF
         JFh0VJqgglEoRVl5ufOT/oUO3Gu9K7/S+YXeHOS5TEIzyxNyeiaF66qNWm9qHC0Q9wt1
         IfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jp56sYQoHAokca/oYMLhoMcY9QYcJFk0U8rfiABjgw=;
        b=jmVuSFhAQw95ifWfyZKjuZe0A7A+OZkrrgfa6DNiJgvFoz9k/jytymXGuZt4Uzf7BK
         QXV/3nNFsQoSNBdy21xp6C0HG1j7gsfHg8lFHBsEaI6kemRMf0ZHJlbDlxnWqGA+gQbf
         ORa7D09/W2DmIlrAOcoF4STecJOtKpqPBbl76lp16vF72eBjZn/JCKTJjNuQYigGY+K3
         yXJUuy5s/MDtbBbgR2xzyrMtIQw11KCux+R9+ri9PQDzqQcUXG4q42LfYOGhIfvf+Jqn
         CN3PbUt8aHamYoSNpeivpQtqSYfx4uRHjoxN/r5l/ZbeqJ0RRuEANIDng9vomtuSi0jM
         hyig==
X-Gm-Message-State: AO0yUKXOTldCM1XFXA+CtKd0nyiK2ImT3wkPnxHQjlkLoPLbLPBWYpl5
        bC00I21IGgh1Wg00s8/5swoGiw==
X-Google-Smtp-Source: AK7set+QsMVkr3bJyVoMPxWbJO0BLC9oA38EG89M0djuh1aq7XJagzQ/jW0eY+f5AONcWwXgUuqMog==
X-Received: by 2002:adf:f9cc:0:b0:2c3:e308:7673 with SMTP id w12-20020adff9cc000000b002c3e3087673mr21544788wrr.35.1676228550032;
        Sun, 12 Feb 2023 11:02:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f15-20020adff98f000000b002c5583ab017sm1327884wrr.15.2023.02.12.11.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 11:02:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] media: dt-bindings: samsung,exynos4212-is: convert to dtschema
Date:   Sun, 12 Feb 2023 20:02:21 +0100
Message-Id: <20230212190222.44977-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230212190222.44977-1-krzysztof.kozlowski@linaro.org>
References: <20230212190222.44977-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
bindings to DT schema.  Changes during conversion - adjust to existing
DTS and Linux driver: add iommus and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/exynos4-fimc-is.txt        |  50 ----
 .../media/samsung,exynos4212-fimc-is.yaml     | 221 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 222 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml

diff --git a/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt b/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
deleted file mode 100644
index 32ced99d4244..000000000000
--- a/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Exynos4x12 SoC series Imaging Subsystem (FIMC-IS)
-
-The FIMC-IS is a subsystem for processing image signal from an image sensor.
-The Exynos4x12 SoC series FIMC-IS V1.5 comprises of a dedicated ARM Cortex-A5
-processor, ISP, DRC and FD IP blocks and peripheral devices such as UART, I2C
-and SPI bus controllers, PWM and ADC.
-
-fimc-is node
-------------
-
-Required properties:
-- compatible	: should be "samsung,exynos4212-fimc-is" for Exynos4212 and
-		  Exynos4412 SoCs;
-- reg		: physical base address and length of the registers set;
-- interrupts	: must contain two FIMC-IS interrupts, in order: ISP0, ISP1;
-- clocks	: list of clock specifiers, corresponding to entries in
-		  clock-names property;
-- clock-names	: must contain "ppmuispx", "ppmuispx", "lite0", "lite1"
-		  "mpll", "sysreg", "isp", "drc", "fd", "mcuisp", "gicisp",
-		  "pwm_isp", "mcuctl_isp", "uart", "ispdiv0", "ispdiv1",
-		  "mcuispdiv0", "mcuispdiv1", "aclk200", "div_aclk200",
-		  "aclk400mcuisp", "div_aclk400mcuisp" entries,
-		  matching entries in the clocks property.
-pmu subnode
------------
-
-Required properties:
- - reg : must contain PMU physical base address and size of the register set.
-
-The following are the FIMC-IS peripheral device nodes and can be specified
-either standalone or as the fimc-is node child nodes.
-
-i2c-isp (ISP I2C bus controller) nodes
-------------------------------------------
-
-Required properties:
-
-- compatible	: should be "samsung,exynos4212-i2c-isp" for Exynos4212 and
-		  Exynos4412 SoCs;
-- reg		: physical base address and length of the registers set;
-- clocks	: must contain gate clock specifier for this controller;
-- clock-names	: must contain "i2c_isp" entry.
-
-For the above nodes it is required to specify a pinctrl state named "default",
-according to the pinctrl bindings defined in ../pinctrl/pinctrl-bindings.txt.
-
-Device tree nodes of the image sensors' controlled directly by the FIMC-IS
-firmware must be child nodes of their corresponding ISP I2C bus controller node.
-The data link of these image sensors must be specified using the common video
-interfaces bindings, defined in video-interfaces.txt.
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
new file mode 100644
index 000000000000..288f4bf3d44d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos4212-fimc-is.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description:
+  The FIMC-IS is a subsystem for processing image signal from an image sensor.
+  The Exynos4x12 SoC series FIMC-IS V1.5 comprises of a dedicated ARM Cortex-A5
+  processor, ISP, DRC and FD IP blocks and peripheral devices such as UART, I2C
+  and SPI bus controllers, PWM and ADC.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4212-fimc-is
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    maxItems: 21
+
+  clock-names:
+    items:
+      - const: lite0
+      - const: lite1
+      - const: ppmuispx
+      - const: ppmuispmx
+      - const: isp
+      - const: drc
+      - const: fd
+      - const: mcuisp
+      - const: gicisp
+      - const: mcuctl_isp
+      - const: pwm_isp
+      - const: ispdiv0
+      - const: ispdiv1
+      - const: mcuispdiv0
+      - const: mcuispdiv1
+      - const: mpll
+      - const: aclk200
+      - const: aclk400mcuisp
+      - const: div_aclk200
+      - const: div_aclk400mcuisp
+      - const: uart
+
+  interrupts:
+    maxItems: 2
+
+  iommus:
+    maxItems: 4
+
+  iommu-names:
+    items:
+      - const: isp
+      - const: drc
+      - const: fd
+      - const: mcuctl
+
+  power-domains:
+    maxItems: 1
+
+  ranges: true
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^pmu@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description:
+      Node representing the SoC's Power Management Unit (duplicated with the
+      correct PMU node in the SoC).
+
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+  "^i2c-isp@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+      #additionalProperties: false
+    description:
+      ISP I2C bus controller
+
+    properties:
+      compatible:
+        const: samsung,exynos4212-i2c-isp
+
+      reg:
+        maxItems: 1
+
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: i2c_isp
+
+      pinctrl-0: true
+      pinctrl-names:
+        items:
+          - const: default
+
+    required:
+      - compatible
+      - reg
+      - clocks
+      - clock-names
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - clocks
+  - clock-names
+  - interrupts
+  - ranges
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    fimc-is@12000000 {
+        compatible = "samsung,exynos4212-fimc-is";
+        reg = <0x12000000 0x260000>;
+        interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&isp_clock CLK_ISP_FIMC_LITE0>,
+                 <&isp_clock CLK_ISP_FIMC_LITE1>,
+                 <&isp_clock CLK_ISP_PPMUISPX>,
+                 <&isp_clock CLK_ISP_PPMUISPMX>,
+                 <&isp_clock CLK_ISP_FIMC_ISP>,
+                 <&isp_clock CLK_ISP_FIMC_DRC>,
+                 <&isp_clock CLK_ISP_FIMC_FD>,
+                 <&isp_clock CLK_ISP_MCUISP>,
+                 <&isp_clock CLK_ISP_GICISP>,
+                 <&isp_clock CLK_ISP_MCUCTL_ISP>,
+                 <&isp_clock CLK_ISP_PWM_ISP>,
+                 <&isp_clock CLK_ISP_DIV_ISP0>,
+                 <&isp_clock CLK_ISP_DIV_ISP1>,
+                 <&isp_clock CLK_ISP_DIV_MCUISP0>,
+                 <&isp_clock CLK_ISP_DIV_MCUISP1>,
+                 <&clock CLK_MOUT_MPLL_USER_T>,
+                 <&clock CLK_ACLK200>,
+                 <&clock CLK_ACLK400_MCUISP>,
+                 <&clock CLK_DIV_ACLK200>,
+                 <&clock CLK_DIV_ACLK400_MCUISP>,
+                 <&clock CLK_UART_ISP_SCLK>;
+        clock-names = "lite0", "lite1", "ppmuispx",
+                      "ppmuispmx", "isp",
+                      "drc", "fd", "mcuisp",
+                      "gicisp", "mcuctl_isp", "pwm_isp",
+                      "ispdiv0", "ispdiv1", "mcuispdiv0",
+                      "mcuispdiv1", "mpll", "aclk200",
+                      "aclk400mcuisp", "div_aclk200",
+                      "div_aclk400mcuisp", "uart";
+        iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+                 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+        iommu-names = "isp", "drc", "fd", "mcuctl";
+        power-domains = <&pd_isp>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        pmu@10020000 {
+            reg = <0x10020000 0x3000>;
+        };
+
+        i2c-isp@12140000 {
+            compatible = "samsung,exynos4212-i2c-isp";
+            reg = <0x12140000 0x100>;
+            clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
+            clock-names = "i2c_isp";
+            pinctrl-0 = <&fimc_is_i2c1>;
+            pinctrl-names = "default";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            image-sensor@10 {
+                compatible = "samsung,s5k6a3";
+                reg = <0x10>;
+                svdda-supply = <&cam_io_reg>;
+                svddio-supply = <&ldo19_reg>;
+                afvdd-supply = <&ldo19_reg>;
+                clock-frequency = <24000000>;
+                clocks = <&camera 1>;
+                clock-names = "extclk";
+                gpios = <&gpm1 6 GPIO_ACTIVE_LOW>;
+
+                port {
+                    endpoint {
+                        remote-endpoint = <&csis1_ep>;
+                        data-lanes = <1>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b6db79458895..e74fd2d4b003 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18474,6 +18474,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
+F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
 F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
 F:	drivers/media/platform/samsung/exynos4-is/
 
-- 
2.34.1

