Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7753A699743
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBPOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjBPOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:22:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442E55E4E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:22:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id dz21so3334354edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vofOKr89WQWgQYydCSIMjfXgGgk845dtqwimPGv+pU=;
        b=h3NAS0smjq49PjAkMdhrb7mAnuWKZs1MH7FtG0kFWvPrvtNRhjwFBRLylz0SoBIwbM
         zhmz8AkctuEuc3sS3UkQvac0fyEk1vEp6H+DvROVMeCPmMXjoJmUrjiQxqAkb0XIGHM5
         KB9JpuH5Hj/bd0xZWGDGtoDUygtQHfp8OMU6GnIgdcn+HLuwp7VQvHLZoZiCbpSRea0u
         iskJHUzGRQCGJObnv6BAmGK+/vHtP9Vyirz6FlniEPTrB5WcYDHqHdN0A+efSN/KOnJw
         r6vDrXopp4JqjVvGA+q1Z8BGvmuglvPXGyTUTpgGw2DFP4ZMErerZKrY8LVCpTng1ml3
         Z0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vofOKr89WQWgQYydCSIMjfXgGgk845dtqwimPGv+pU=;
        b=eEBFwZ5YnDFKPnb+HXQk3/F+qWxzkj+uiYCk1m2aLfYBQRPGQP3du8IKDW4v+e3v2I
         mtgI5wb2pz4CEPZnE6I9VmItly9iqhp8NrFnQXfHTkrv8pPNOEWZUp79BaybGFZ9255I
         i+v6GlLCIlV6BnB1pQKpjPvauHe6fI7iTuA2uFu/hAb8PvF+bWNXxKQ/nci+BYynoSKV
         zU0QJQiXJuvAHjlYkRPixGjlmvFuspav3Ow95vG2ab6z3agc2OLJeSgozcIG6Zpj/wpb
         Bm0oOJh7bEH8L/H+tRAe1riuCsnA4WcXUyeRnGt1YwaP0GaXWvVlLjEeTRSGn3S5DgAF
         kWaw==
X-Gm-Message-State: AO0yUKVTahBi5eZqD7oUBuQ1sC2NTw6k3WXiDAWM5JXRDry7mLGkOCkh
        4pgirI0eC0nXnKkffRCV23KAHw==
X-Google-Smtp-Source: AK7set9Haf961d+ezlhJXBk3RdTSY2CtYdhzAz6vTO3Fw2mlQJuhzmwVWt150x7nuc2V2uEnEutrTw==
X-Received: by 2002:a17:906:f1d4:b0:895:58be:94d with SMTP id gx20-20020a170906f1d400b0089558be094dmr8065354ejb.3.1676557338371;
        Thu, 16 Feb 2023 06:22:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ad24-20020a170907259800b0087bdac06a3bsm884757ejc.2.2023.02.16.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:22:17 -0800 (PST)
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
Subject: [PATCH v3 6/7] media: dt-bindings: samsung,fimc: convert to dtschema
Date:   Thu, 16 Feb 2023 15:22:03 +0100
Message-Id: <20230216142204.48394-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5P/Exynos Camera Subsystem (FIMC) bindings to DT
schema.  Changes during conversion - adjust to existing DTS and Linux
driver: add iommus and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Add Rb tag.
2. Move size-cells next to address-cells.

The patch depends on:
https://lore.kernel.org/all/20230207205834.673163-1-krzysztof.kozlowski@linaro.org/
---
 .../media/samsung,exynos4210-fimc.yaml        | 152 ++++++++++
 .../bindings/media/samsung,fimc.yaml          | 279 ++++++++++++++++++
 .../bindings/media/samsung-fimc.txt           | 210 -------------
 MAINTAINERS                                   |   2 +
 4 files changed, 433 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,fimc.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-fimc.txt

diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
new file mode 100644
index 000000000000..271d0577a83c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos4210-fimc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC Fully Integrated Mobile Camera
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description:
+  Each FIMC device should have an alias in the aliases node, in the form of
+  fimc<n>, where <n> is an integer specifying the IP block instance.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-fimc
+      - samsung,exynos4212-fimc
+      - samsung,s5pv210-fimc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: fimc
+      - const: sclk_fimc
+
+  clock-frequency:
+    description:
+      Maximum FIMC local clock (LCLK) frequency.
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  samsung,cam-if:
+    type: boolean
+    description:
+      The FIMC IP block includes the camera input interface.
+
+  samsung,isp-wb:
+    type: boolean
+    description: |
+      The FIMC IP block has the ISP writeback input.
+
+  samsung,lcd-wb:
+    type: boolean
+    description: |
+      The FIMC IP block has the LCD writeback input.
+
+  samsung,mainscaler-ext:
+    type: boolean
+    description:
+      FIMC IP supports extended image size and has CIEXTEN register.
+
+  samsung,min-pix-alignment:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: Minimum supported image height alignment.
+      - description: Horizontal image offset.
+    description:
+      The values are in pixels and default is <2 1>.
+
+  samsung,min-pix-sizes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    description: |
+      An array specyfing minimum image size in pixels at the FIMC input and
+      output DMA, in the first and second cell respectively.  Default value
+      is <16 16>.
+
+  samsung,pix-limits:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 4
+    description: |
+      An array of maximum supported image sizes in pixels, for details refer to
+      Table 2-1 in the S5PV210 SoC User Manual. The meaning of each cell is as
+      follows:
+       0 - scaler input horizontal size
+       1 - input horizontal size for the scaler bypassed
+       2 - REAL_WIDTH without input rotation
+       3 - REAL_HEIGHT with input rotation
+
+  samsung,rotators:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x11
+    description: |
+      A bitmask specifying whether this IP has the input and the output
+      rotator. Bits 4 and 0 correspond to input and output rotator
+      respectively. If a rotator is present its corresponding bit should be
+      set.
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      System Registers (SYSREG) node.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - samsung,pix-limits
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
+    fimc@11800000 {
+        compatible = "samsung,exynos4212-fimc";
+        reg = <0x11800000 0x1000>;
+        clocks = <&clock CLK_FIMC0>,
+                 <&clock CLK_SCLK_FIMC0>;
+        clock-names = "fimc", "sclk_fimc";
+        interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&sysmmu_fimc0>;
+        power-domains = <&pd_cam>;
+        samsung,sysreg = <&sys_reg>;
+
+        samsung,pix-limits = <4224 8192 1920 4224>;
+        samsung,mainscaler-ext;
+        samsung,isp-wb;
+        samsung,cam-if;
+
+        assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+                          <&clock CLK_SCLK_FIMC0>;
+        assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+        assigned-clock-rates = <0>, <176000000>;
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
new file mode 100644
index 000000000000..79ff6d83a9fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
@@ -0,0 +1,279 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,fimc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC Camera Subsystem (FIMC)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description: |
+  The S5P/Exynos SoC Camera subsystem comprises of multiple sub-devices
+  represented by separate device tree nodes. Currently this includes: Fully
+  Integrated Mobile Camera (FIMC, in the S5P SoCs series known as CAMIF), MIPI
+  CSIS, FIMC-LITE and FIMC-IS (ISP).
+
+properties:
+  compatible:
+    const: samsung,fimc
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 1
+    description: |
+      The clock specifier cell stores an index of a clock: 0, 1 for
+      CAM_A_CLKOUT, CAM_B_CLKOUT clocks respectively.
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: sclk_cam0
+      - const: sclk_cam1
+      - const: pxl_async0
+      - const: pxl_async1
+
+  clock-output-names:
+    maxItems: 2
+
+  parallel-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Active parallel video input ports.
+
+    patternProperties:
+      "^port@[01]$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description:
+          Camera A and camera B inputs.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: idle
+      - const: active_a
+      - const: active_b
+
+patternProperties:
+  "^csis@[0-9a-f]+$":
+    type: object
+    $ref: samsung,exynos4210-csis.yaml#
+    description: MIPI CSI-2 receiver.
+
+  "^fimc@[0-9a-f]+$":
+    type: object
+    $ref: samsung,exynos4210-fimc.yaml#
+    description: Fully Integrated Mobile Camera.
+
+  "^fimc-is@[0-9a-f]+$":
+    type: object
+    $ref: samsung,exynos4212-fimc-is.yaml#
+    description: Imaging Subsystem (FIMC-IS).
+
+  "^fimc-lite@[0-9a-f]+$":
+    type: object
+    $ref: samsung,exynos4212-fimc-lite.yaml#
+    description: Camera host interface (FIMC-LITE).
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#clock-cells'
+  - clocks
+  - clock-names
+  - clock-output-names
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
+    camera@11800000 {
+        compatible = "samsung,fimc";
+        #clock-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x0 0x18000000>;
+
+        clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
+                 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
+        clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
+        clock-output-names = "cam_a_clkout", "cam_b_clkout";
+
+        assigned-clocks = <&clock CLK_MOUT_CAM0>,
+                          <&clock CLK_MOUT_CAM1>;
+        assigned-clock-parents = <&clock CLK_XUSBXTI>,
+                                 <&clock CLK_XUSBXTI>;
+
+        pinctrl-0 = <&cam_port_a_clk_active &cam_port_b_clk_active>;
+        pinctrl-names = "default";
+
+        fimc@11800000 {
+            compatible = "samsung,exynos4212-fimc";
+            reg = <0x11800000 0x1000>;
+            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clock CLK_FIMC0>,
+                     <&clock CLK_SCLK_FIMC0>;
+            clock-names = "fimc", "sclk_fimc";
+            power-domains = <&pd_cam>;
+            samsung,sysreg = <&sys_reg>;
+            iommus = <&sysmmu_fimc0>;
+
+            samsung,pix-limits = <4224 8192 1920 4224>;
+            samsung,mainscaler-ext;
+            samsung,isp-wb;
+            samsung,cam-if;
+        };
+
+        /* ... FIMC 1-3 */
+
+        csis@11880000 {
+            compatible = "samsung,exynos4210-csis";
+            reg = <0x11880000 0x4000>;
+            interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clock CLK_CSIS0>,
+                     <&clock CLK_SCLK_CSIS0>;
+            clock-names = "csis", "sclk_csis";
+            assigned-clocks = <&clock CLK_MOUT_CSIS0>,
+                              <&clock CLK_SCLK_CSIS0>;
+            assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+            assigned-clock-rates = <0>, <176000000>;
+
+            bus-width = <4>;
+            power-domains = <&pd_cam>;
+            phys = <&mipi_phy 0>;
+            phy-names = "csis";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vddcore-supply = <&ldo8_reg>;
+            vddio-supply = <&ldo10_reg>;
+
+            /* Camera C (3) MIPI CSI-2 (CSIS0) */
+            port@3 {
+                reg = <3>;
+                endpoint {
+                    remote-endpoint = <&s5c73m3_ep>;
+                    data-lanes = <1 2 3 4>;
+                    samsung,csis-hs-settle = <12>;
+                };
+            };
+        };
+
+        /* ... CSIS 1 */
+
+        fimc-lite@12390000 {
+              compatible = "samsung,exynos4212-fimc-lite";
+              reg = <0x12390000 0x1000>;
+              interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+              power-domains = <&pd_isp>;
+              clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
+              clock-names = "flite";
+              iommus = <&sysmmu_fimc_lite0>;
+        };
+
+        /* ... FIMC-LITE 1 */
+
+        fimc-is@12000000 {
+            compatible = "samsung,exynos4212-fimc-is";
+            reg = <0x12000000 0x260000>;
+            interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&isp_clock CLK_ISP_FIMC_LITE0>,
+                     <&isp_clock CLK_ISP_FIMC_LITE1>,
+                     <&isp_clock CLK_ISP_PPMUISPX>,
+                     <&isp_clock CLK_ISP_PPMUISPMX>,
+                     <&isp_clock CLK_ISP_FIMC_ISP>,
+                     <&isp_clock CLK_ISP_FIMC_DRC>,
+                     <&isp_clock CLK_ISP_FIMC_FD>,
+                     <&isp_clock CLK_ISP_MCUISP>,
+                     <&isp_clock CLK_ISP_GICISP>,
+                     <&isp_clock CLK_ISP_MCUCTL_ISP>,
+                     <&isp_clock CLK_ISP_PWM_ISP>,
+                     <&isp_clock CLK_ISP_DIV_ISP0>,
+                     <&isp_clock CLK_ISP_DIV_ISP1>,
+                     <&isp_clock CLK_ISP_DIV_MCUISP0>,
+                     <&isp_clock CLK_ISP_DIV_MCUISP1>,
+                     <&clock CLK_MOUT_MPLL_USER_T>,
+                     <&clock CLK_ACLK200>,
+                     <&clock CLK_ACLK400_MCUISP>,
+                     <&clock CLK_DIV_ACLK200>,
+                     <&clock CLK_DIV_ACLK400_MCUISP>,
+                     <&clock CLK_UART_ISP_SCLK>;
+            clock-names = "lite0", "lite1", "ppmuispx",
+                          "ppmuispmx", "isp",
+                          "drc", "fd", "mcuisp",
+                          "gicisp", "mcuctl_isp", "pwm_isp",
+                          "ispdiv0", "ispdiv1", "mcuispdiv0",
+                          "mcuispdiv1", "mpll", "aclk200",
+                          "aclk400mcuisp", "div_aclk200",
+                          "div_aclk400mcuisp", "uart";
+            iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+                     <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+            iommu-names = "isp", "drc", "fd", "mcuctl";
+            power-domains = <&pd_isp>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            pmu@10020000 {
+                reg = <0x10020000 0x3000>;
+            };
+
+            i2c-isp@12140000 {
+                compatible = "samsung,exynos4212-i2c-isp";
+                reg = <0x12140000 0x100>;
+                clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
+                clock-names = "i2c_isp";
+                pinctrl-0 = <&fimc_is_i2c1>;
+                pinctrl-names = "default";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                image-sensor@10 {
+                    compatible = "samsung,s5k6a3";
+                    reg = <0x10>;
+                    svdda-supply = <&cam_io_reg>;
+                    svddio-supply = <&ldo19_reg>;
+                    afvdd-supply = <&ldo19_reg>;
+                    clock-frequency = <24000000>;
+                    /* CAM_B_CLKOUT */
+                    clocks = <&camera 1>;
+                    clock-names = "extclk";
+                    gpios = <&gpm1 6 GPIO_ACTIVE_LOW>;
+
+                    port {
+                        endpoint {
+                            remote-endpoint = <&csis1_ep>;
+                            data-lanes = <1>;
+                        };
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-fimc.txt b/Documentation/devicetree/bindings/media/samsung-fimc.txt
deleted file mode 100644
index f90267f1180e..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-fimc.txt
+++ /dev/null
@@ -1,210 +0,0 @@
-Samsung S5P/Exynos SoC Camera Subsystem (FIMC)
-----------------------------------------------
-
-The S5P/Exynos SoC Camera subsystem comprises of multiple sub-devices
-represented by separate device tree nodes. Currently this includes: FIMC (in
-the S5P SoCs series known as CAMIF), MIPI CSIS, FIMC-LITE and FIMC-IS (ISP).
-
-The sub-subdevices are defined as child nodes of the common 'camera' node which
-also includes common properties of the whole subsystem not really specific to
-any single sub-device, like common camera port pins or the CAMCLK clock outputs
-for external image sensors attached to an SoC.
-
-Common 'camera' node
---------------------
-
-Required properties:
-
-- compatible: must be "samsung,fimc"
-- clocks: list of clock specifiers, corresponding to entries in
-  the clock-names property;
-- clock-names : must contain "sclk_cam0", "sclk_cam1", "pxl_async0",
-  "pxl_async1" entries, matching entries in the clocks property.
-
-- #clock-cells: from the common clock bindings (../clock/clock-bindings.txt),
-  must be 1. A clock provider is associated with the 'camera' node and it should
-  be referenced by external sensors that use clocks provided by the SoC on
-  CAM_*_CLKOUT pins. The clock specifier cell stores an index of a clock.
-  The indices are 0, 1 for CAM_A_CLKOUT, CAM_B_CLKOUT clocks respectively.
-
-- clock-output-names: from the common clock bindings, should contain names of
-  clocks registered by the camera subsystem corresponding to CAM_A_CLKOUT,
-  CAM_B_CLKOUT output clocks respectively.
-
-The pinctrl bindings defined in ../pinctrl/pinctrl-bindings.txt must be used
-to define a required pinctrl state named "default" and optional pinctrl states:
-"idle", "active-a", active-b". These optional states can be used to switch the
-camera port pinmux at runtime. The "idle" state should configure both the camera
-ports A and B into high impedance state, especially the CAMCLK clock output
-should be inactive. For the "active-a" state the camera port A must be activated
-and the port B deactivated and for the state "active-b" it should be the other
-way around.
-
-The 'camera' node must include at least one 'fimc' child node.
-
-
-'fimc' device nodes
--------------------
-
-Required properties:
-
-- compatible: "samsung,s5pv210-fimc" for S5PV210, "samsung,exynos4210-fimc"
-  for Exynos4210 and "samsung,exynos4212-fimc" for Exynos4x12 SoCs;
-- reg: physical base address and length of the registers set for the device;
-- interrupts: should contain FIMC interrupt;
-- clocks: list of clock specifiers, must contain an entry for each required
-  entry in clock-names;
-- clock-names: must contain "fimc", "sclk_fimc" entries.
-- samsung,pix-limits: an array of maximum supported image sizes in pixels, for
-  details refer to Table 2-1 in the S5PV210 SoC User Manual; The meaning of
-  each cell is as follows:
-  0 - scaler input horizontal size,
-  1 - input horizontal size for the scaler bypassed,
-  2 - REAL_WIDTH without input rotation,
-  3 - REAL_HEIGHT with input rotation,
-- samsung,sysreg: a phandle to the SYSREG node.
-
-Each FIMC device should have an alias in the aliases node, in the form of
-fimc<n>, where <n> is an integer specifying the IP block instance.
-
-Optional properties:
-
-- clock-frequency: maximum FIMC local clock (LCLK) frequency;
-- samsung,min-pix-sizes: an array specyfing minimum image size in pixels at
-  the FIMC input and output DMA, in the first and second cell respectively.
-  Default value when this property is not present is <16 16>;
-- samsung,min-pix-alignment: minimum supported image height alignment (first
-  cell) and the horizontal image offset (second cell). The values are in pixels
-  and default to <2 1> when this property is not present;
-- samsung,mainscaler-ext: a boolean property indicating whether the FIMC IP
-  supports extended image size and has CIEXTEN register;
-- samsung,rotators: a bitmask specifying whether this IP has the input and
-  the output rotator. Bits 4 and 0 correspond to input and output rotator
-  respectively. If a rotator is present its corresponding bit should be set.
-  Default value when this property is not specified is 0x11.
-- samsung,cam-if: a bolean property indicating whether the IP block includes
-  the camera input interface.
-- samsung,isp-wb: this property must be present if the IP block has the ISP
-  writeback input.
-- samsung,lcd-wb: this property must be present if the IP block has the LCD
-  writeback input.
-
-
-'parallel-ports' node
----------------------
-
-This node should contain child 'port' nodes specifying active parallel video
-input ports. It includes camera A and camera B inputs. 'reg' property in the
-port nodes specifies data input - 1, 2 indicates input A, B respectively.
-
-Optional properties
-
-- samsung,camclk-out (deprecated) : specifies clock output for remote sensor,
-  0 - CAM_A_CLKOUT, 1 - CAM_B_CLKOUT;
-
-Image sensor nodes
-------------------
-
-The sensor device nodes should be added to their control bus controller (e.g.
-I2C0) nodes and linked to a port node in the csis or the parallel-ports node,
-using the common video interfaces bindings, defined in video-interfaces.txt.
-
-Example:
-
-	aliases {
-		fimc0 = &fimc_0;
-	};
-
-	/* Parallel bus IF sensor */
-	i2c_0: i2c@13860000 {
-		s5k6aa: sensor@3c {
-			compatible = "samsung,s5k6aafx";
-			reg = <0x3c>;
-			vddio-supply = <...>;
-
-			clock-frequency = <24000000>;
-			clocks = <&camera 1>;
-			clock-names = "mclk";
-
-			port {
-				s5k6aa_ep: endpoint {
-					remote-endpoint = <&fimc0_ep>;
-					bus-width = <8>;
-					hsync-active = <0>;
-					vsync-active = <1>;
-					pclk-sample = <1>;
-				};
-			};
-		};
-
-		/* MIPI CSI-2 bus IF sensor */
-		s5c73m3: sensor@1a {
-			compatible = "samsung,s5c73m3";
-			reg = <0x1a>;
-			vddio-supply = <...>;
-
-			clock-frequency = <24000000>;
-			clocks = <&camera 0>;
-			clock-names = "mclk";
-
-			port {
-				s5c73m3_1: endpoint {
-					data-lanes = <1 2 3 4>;
-					remote-endpoint = <&csis0_ep>;
-				};
-			};
-		};
-	};
-
-	camera@11800000 {
-		compatible = "samsung,fimc";
-		clocks = <&clock 132>, <&clock 133>, <&clock 351>,
-			 <&clock 352>;
-		clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0",
-			      "pxl_async1";
-		#clock-cells = <1>;
-		clock-output-names = "cam_a_clkout", "cam_b_clkout";
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam_port_a_clk_active>;
-		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* parallel camera ports */
-		parallel-ports {
-			/* camera A input */
-			port@1 {
-				reg = <1>;
-				fimc0_ep: endpoint {
-					remote-endpoint = <&s5k6aa_ep>;
-					bus-width = <8>;
-					hsync-active = <0>;
-					vsync-active = <1>;
-					pclk-sample = <1>;
-				};
-			};
-		};
-
-		fimc_0: fimc@11800000 {
-			compatible = "samsung,exynos4210-fimc";
-			reg = <0x11800000 0x1000>;
-			interrupts = <0 85 0>;
-		};
-
-		csis_0: csis@11880000 {
-			compatible = "samsung,exynos4210-csis";
-			reg = <0x11880000 0x1000>;
-			interrupts = <0 78 0>;
-			/* camera C input */
-			port@3 {
-				reg = <3>;
-				csis0_ep: endpoint {
-					remote-endpoint = <&s5c73m3_ep>;
-					data-lanes = <1 2 3 4>;
-					samsung,csis-hs-settle = <12>;
-				};
-			};
-		};
-	};
-
-The MIPI-CSIS device binding is defined in samsung-mipi-csis.txt.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f22dc1c95ae..87140ebb9a40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18466,8 +18466,10 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
+F:	Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
 F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
 F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
+F:	Documentation/devicetree/bindings/media/samsung,fimc.yaml
 F:	drivers/media/platform/samsung/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
-- 
2.34.1

