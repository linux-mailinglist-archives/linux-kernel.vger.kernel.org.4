Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23BE67990C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjAXNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:17:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6A3FF3C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so9353256wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1Mx7/fdaOZTAyQvhijx+hcsNa4waknDOv8lEc+khP4=;
        b=EoOqRR3T6Ta4E3QxcuRnYWEzz9pMRdDke6GJsf9uSUye/17W+z/erW46IPFzuqZYuP
         eGSDTx5DtbH+WWN/oIA0PxT5tdLr0vqsPy8IY0PpUa8k805JHSSThupwcGZ+JeJHm/sL
         XIgmbvaXh7ij9K7UmTT+/rIL3F7YVVX+ihx7lokVc1Fw3tQmb9tSPpT54Y1nrq4xm/Nq
         6oqISFQkYzEqACyezZsst9jXJV1cEw8TkXY4tsyHToXvpqvT82te0GC+u1NvuFLO0Hpe
         ciydRTszvegrhGQfN39GFV1goqQkQgXes2b2mm5gy4CORr8TycrqZvqr54h4uBA90sCY
         JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1Mx7/fdaOZTAyQvhijx+hcsNa4waknDOv8lEc+khP4=;
        b=kmBdkOyIOjGAUFJNHQhVyl5nhs2d2OE0gg2Z+/7auQ+oImHxUEm6duYQWo8Wq+OPej
         SbcUBBFkKQ1Tfuj4dKbvzK/N3dcQ4fkorzOsycomKCVdiPNjo1xm3GEx45DeJ23GJwt3
         03fv/ZOGBQSjE2AUbfbK9OsxtizLhXNeXlKK3j8inhiFaf36pRvh3kDLWwXWokBVNJHl
         QbwWck4NB25y2KPMTUgCdu/PNhwV0PDhaG7ns51KrJ6py32qIykszLfJ16usSms0hNvA
         DaZW8f3SJC2a3zzprM/kl3VusyQZNiP18HHgkcr8WznB4FE99wQOfdhLrQ2lsgD48vGY
         BgJA==
X-Gm-Message-State: AO0yUKUR1+u7bZxO04EvfmfNbEU21tS20/oZBK1B/K5nHWQXtO3UyXay
        Ruom2e99c8bp+GcrM/qqgmNp2Q==
X-Google-Smtp-Source: AK7set+Mg41hXPJ0l3tt4EGAf6QzluqgF8PoERLSORY4izIzfw6NeNTevB2exR9qCTgplKpgwwPKJA==
X-Received: by 2002:adf:b351:0:b0:2bf:ae4b:4cbf with SMTP id k17-20020adfb351000000b002bfae4b4cbfmr2331594wrd.55.1674566239580;
        Tue, 24 Jan 2023 05:17:19 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfb5ebf8cfsm49427wrp.21.2023.01.24.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:17:19 -0800 (PST)
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
Subject: [PATCH v11 2/6] dt-bindings/thermal/mediatek: Add LVTS thermal controllers dt-binding definition
Date:   Tue, 24 Jan 2023 14:17:13 +0100
Message-Id: <20230124131717.128660-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124131717.128660-1-bchihi@baylibre.com>
References: <20230124131717.128660-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS thermal controllers dt-binding definition for mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 107 ++++++++++++++++++
 include/dt-bindings/thermal/mediatek-lvts.h   |  19 ++++
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..12bfbdd8ff89
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,107 @@
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
diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
new file mode 100644
index 000000000000..428a95c18509
--- /dev/null
+++ b/include/dt-bindings/thermal/mediatek-lvts.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Balsam CHIHI <bchihi@baylibre.com>
+ */
+
+#ifndef __MEDIATEK_LVTS_DT_H
+#define __MEDIATEK_LVTS_DT_H
+
+#define MT8195_MCU_BIG_CPU0	0
+#define MT8195_MCU_BIG_CPU1	1
+#define MT8195_MCU_BIG_CPU2	2
+#define MT8195_MCU_BIG_CPU3	3
+#define MT8195_MCU_LITTLE_CPU0	4
+#define MT8195_MCU_LITTLE_CPU1	5
+#define MT8195_MCU_LITTLE_CPU2	6
+#define MT8195_MCU_LITTLE_CPU3	7
+
+#endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.34.1

