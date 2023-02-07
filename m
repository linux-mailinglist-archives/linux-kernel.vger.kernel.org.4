Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8A68D893
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjBGNKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBGNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:10:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C548CDDE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:10:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so13116958wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ6pbAnd6KUfBPVU8XG7d9F1oBy/3NmTR8rpxj6QiAw=;
        b=fA8qKRBYP4Wj3zcF0shqTlrZAkcNb/63xhQrCNJjy13QZVh6sHI1ej6zCutJcDuLsk
         LjzSjEFyJa7x5FeHjdHZL31iIQVmBG3WGdCXdmMw/wZRe2Y6FJ3sudkHF4VYggVDcKEg
         gS9xEc+gOR6JIDsZ+0oLUjJI1iPzYJp0pixkftRTnBwzjDNN5YVAusH6ZKJKXVzsOOZ3
         CyyU4MNRyDNfuX+pavqf5qfyOmjRyX42chL6IqyHUiAWJws9OXHcujXMB0I3FvcFoRdq
         sS11Fh3fwPdwoV/+LqYCc9Z2j0bCZmd0OrakFcYPNjcFjTwyItn9pMl9mC6rRk7YP+R3
         VhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ6pbAnd6KUfBPVU8XG7d9F1oBy/3NmTR8rpxj6QiAw=;
        b=wiTWSKPoXq0N+5JJH2ZdtFBvO4iIUxdR1/R4qYiycr8EtCTVYzp2MPGUg7zeeLBCor
         cthx3lYycCm1inQeii/bjbMm9f3lSr7BntybtdfyDVp93KugfMQFq4Yc4fAdBGfBJI3+
         byyYk/bSai9nyY9qiTQLOIGsNg6Fnl/qvwDLJbnXDzgFd1DFqt3f9rHUnPqphDSDuEvW
         sdcjXdYU+NHcuD8a8ZsRyeNoaA0DeiwTyWNDUBsdVoLRRzgElWG4Ls6v2H+2gu7yGw3a
         s/xNk1A5fdMEFQ0CEDnX+1XD5u8jKDdYa+WE9GRiZfjmXMRmzU9Twn5Qrtcn9cjvAbdS
         qPLg==
X-Gm-Message-State: AO0yUKVkBE5IDjSD3sy7LfCFs7QjtvFLYUE6PjmPahCLGM52DxIzOuoT
        MbMo6yBzUdvBEtQHabirkSyEfQ==
X-Google-Smtp-Source: AK7set+Ephy2qpY4FFIbN2cmOMz5O2Hm3GdQCvAhoDvB6jO4BDXjRyKtB+EBHhzAjiTt7F9Ff7NUMQ==
X-Received: by 2002:a05:600c:3420:b0:3dc:4548:abe6 with SMTP id y32-20020a05600c342000b003dc4548abe6mr3033635wmp.12.1675775402681;
        Tue, 07 Feb 2023 05:10:02 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm17987385wmk.25.2023.02.07.05.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:10:02 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v13 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
Date:   Tue,  7 Feb 2023 14:09:54 +0100
Message-Id: <20230207130958.608305-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207130958.608305-1-bchihi@baylibre.com>
References: <20230207130958.608305-1-bchihi@baylibre.com>
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

Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 142 ++++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |  19 +++
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..3265d480749b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,142 @@
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
+      - mediatek,mt8192-lvts-ap
+      - mediatek,mt8192-lvts-mcu
+      - mediatek,mt8195-lvts-ap
+      - mediatek,mt8195-lvts-mcu
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
+              - mediatek,mt8192-lvts-ap
+              - mediatek,mt8192-lvts-mcu
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
+              - mediatek,mt8195-lvts-ap
+              - mediatek,mt8195-lvts-mcu
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
+    #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
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
+        thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+
+        trips {
+          cpu0_alert: trip-alert {
+            temperature = <85000>;
+            hysteresis = <2000>;
+            type = "passive";
+          };
+
+          cpu0_crit: trip-crit {
+            temperature = <100000>;
+            hysteresis = <2000>;
+            type = "critical";
+          };
+        };
+      };
+    };
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
new file mode 100644
index 000000000000..4f2082065a31
--- /dev/null
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Balsam CHIHI <bchihi@baylibre.com>
+ */
+
+#ifndef __MEDIATEK_LVTS_DT_H
+#define __MEDIATEK_LVTS_DT_H
+
+#define MT8195_MCU_BIG_CPU0		0
+#define MT8195_MCU_BIG_CPU1		1
+#define MT8195_MCU_BIG_CPU2		2
+#define MT8195_MCU_BIG_CPU3		3
+#define MT8195_MCU_LITTLE_CPU0	4
+#define MT8195_MCU_LITTLE_CPU1	5
+#define MT8195_MCU_LITTLE_CPU2	6
+#define MT8195_MCU_LITTLE_CPU3	7
+
+#endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.34.1

