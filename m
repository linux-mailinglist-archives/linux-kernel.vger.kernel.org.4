Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33F66798D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjALPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjALPis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD7F71
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m3so13475706wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QQJhQTvWiPr9ySZtlJAJmZ7yaiH8RE0d51kxRCXOJE=;
        b=UxompglSyH+QvEIlm5ZP/6IP6s/tpCs6DgkoLYD0u9PacNQMNULMI+i/ZjWqE9HoDT
         sEyWwjMAAiB3lH96geHYqYModKKu43ori8b1/0uYFBAgFezIl61+KZbc1G5LiFL3ZUMl
         nztSxAnV3FqIYMEpYSoARP+5AOD4/2sQFO6cL21Yl26L/cmLX4Kz3G8F1KvZqBcTjr+B
         qeU+Xif0CjVQPbDEtewQaq0sQEHz+yOvT2g8GNRSoyT1GuTxOvI6sBPyHSWZZr4MMUL8
         JHEl9SE969bygf+zMzgNAjNAf85aD2C0mP6bO0hB3q6Qa/9Mcz7a4UX6Jf8/DTxItW9j
         fnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QQJhQTvWiPr9ySZtlJAJmZ7yaiH8RE0d51kxRCXOJE=;
        b=RCVhVyyk2YBE/JJ2hRkifkbd2/c/wzEJruVO4Q3h2RVajzf8skQeJQu8ByDWg/u/tE
         XsAgZzgdJnGl8WI5UB5q+ApIJ14y+cov/l4cdh0kd6N1yu2dgZUAZ6tHNDHamEG+S534
         qpNWmEg/0TCTjBj6YNp2xKiT3yyagwKSTuL6urGRoiRmI4eFnO3j2iYH4JvU45kwDHN4
         6HsgD2gcNv/cTZ1YUeb9n5djlMiiAdkgMGtCgomnwNjMP4tz03ZD2Ti7nsu4/GV+SSAj
         IccFknRN6i9jau59UWlO9Dq1m+6Z3vgsRJZFFIt5ZzLsTF3POjLozTpVQqeqxmNmPifk
         JISg==
X-Gm-Message-State: AFqh2krZbm1cYTMzsu+nnK4bT0D7088Uz9ophbJqOgTZs0mEZyEphSBw
        g63/VlNePO31vOda0X5xqtJvdvF+lSuetaFC
X-Google-Smtp-Source: AMrXdXsXDrab2+i2WxxH6TGfNt5hv1F/al/3N+fX7+lLUjnAGIEXBMulggAI+kjrlcmjW28EM3yExw==
X-Received: by 2002:a05:600c:3509:b0:3c6:e60f:3f6f with SMTP id h9-20020a05600c350900b003c6e60f3f6fmr54885253wmq.38.1673537394730;
        Thu, 12 Jan 2023 07:29:54 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm26395909wmh.46.2023.01.12.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:29:54 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v10 2/6] dt-bindings/thermal/mediatek: Add dt-binding document for LVTS thermal controllers
Date:   Thu, 12 Jan 2023 16:28:51 +0100
Message-Id: <20230112152855.216072-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112152855.216072-1-bchihi@baylibre.com>
References: <20230112152855.216072-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..43b8777fc1b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
+
+maintainers:
+  - Balsam CHIHI <bchihi@baylibre.com>
+
+description: |
+  LVTS is a thermal management architecture composed of three subsystems,
+  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
+  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
+  a Digital controller (LVTS_CTRL).
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8192-lvts-mcu
+      - mediatek,mt8192-lvts-ap
+      - mediatek,mt8195-lvts-mcu
+      - mediatek,mt8195-lvts-ap
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+    description: LVTS reset for clearing temporary data on AP/MCU.
+
+  nvmem-cells:
+    minItems: 1
+    items:
+      - description: Calibration eFuse data 1 for LVTS
+      - description: Calibration eFuse data 2 for LVTS
+
+  nvmem-cell-names:
+    minItems: 1
+    items:
+      - const: lvts-calib-data-1
+      - const: lvts-calib-data-2
+
+  "#thermal-sensor-cells":
+    const: 1
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8192-lvts-mcu
+              - mediatek,mt8192-lvts-ap
+    then:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+
+        nvmem-cell-names:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-lvts-mcu
+              - mediatek,mt8195-lvts-ap
+    then:
+      properties:
+        nvmem-cells:
+          maxItems: 2
+
+        nvmem-cell-names:
+          maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - nvmem-cells
+  - nvmem-cell-names
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/reset/mt8195-resets.h>
+    #include <dt-bindings/thermal/mediatek-lvts.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      lvts_mcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8195-lvts-mcu";
+        reg = <0 0x11278000 0 0x1000>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+        nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+        #thermal-sensor-cells = <1>;
+      };
+    };
+
+    thermal_zones: thermal-zones {
+      cpu0-thermal {
+        polling-delay = <1000>;
+        polling-delay-passive = <250>;
+        thermal-sensors = <&lvts_mcu MT819x_MCU_LITTLE_CPU0>;
+        trips {
+          cpu0_alert: trip-alert {
+            temperature = <85000>;
+            hysteresis = <2000>;
+            type = "passive";
+          };
+          cpu0_crit: trip-crit {
+            temperature = <100000>;
+            hysteresis = <2000>;
+            type = "critical";
+          };
+        };
+      };
+    };
-- 
2.34.1

