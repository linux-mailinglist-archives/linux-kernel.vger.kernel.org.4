Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E896E741456
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjF1Oyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjF1Oye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:54:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F4C1FDC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so42127165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687964070; x=1690556070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEgxoRXHCYnAiJIbhMHjOlgduw+1IxrXr8TMEGswNJ4=;
        b=VILT3tN8Rf/UhGbOS6g3zTrc738+2NLNbysJepU9NbAt9n0jDJfu/LP/exx+YzDDx3
         9VJ6ce+ZfOlFZPQQWu3OZH8+JY/+bnevGmgqGo0h4gHJO7XNjNKH47pfNc0vKCYDhG6W
         k4MBD5BPYXaLnFZrJ7o3gl6waPWaLKHZk2ZlK8sjRaAgg9sNpb1KmnCBmFrga28UdS3M
         hnbz155h31HDUGsjoqV6vtZftBI/0qpjQO6KDwhUBeX99guIqIit6QEz4rGO4xRK8pm8
         naPM5gpUO0h7YTN6JNhUKXasSbTmq3th3RaUUirHrVxWn/VfzoyOxfKgZbQ5Ct8pQIsn
         Jeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964070; x=1690556070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEgxoRXHCYnAiJIbhMHjOlgduw+1IxrXr8TMEGswNJ4=;
        b=NZ0kXOu3hh7ZiGD6eBNl+A/QAcj9UoBTzQBApWeCro9J3/AMX9CnWEy5FKp6FE0Gmr
         MbItVNJ9nEYQDMxu+DaFYmDJi9KGouzlOjR9jkWk0flgO0pJy21q5/H54NJOXrXcVxqn
         f73C4jXz8ndcUj7OSs6o/Ia/EBTqQz0Z+M8BxJ3oT/FqJFwj2Y7WqITlehW81dtX2ExK
         ak7xKtZsHtDHvVUbJWau4mfxqHXDx/yUVGBp2gizIaz/qSgZ5pUghXuehuxW14ut/1Mu
         fCfqzBg6bXIO+9yZUakulJ+v0U67fU4ie3PAgh2DEgI8xBcH9V5WlPSbN27wUhv32/0S
         iQhA==
X-Gm-Message-State: AC+VfDz78I8mvxRjX/dqOXXR30p+SxliuxEMqr6S2ctQZd0RiRIyCBtF
        MwYiiaw8xKSoxQypqtYmpBRAxA==
X-Google-Smtp-Source: ACHHUZ5DiucMXBerTVahmb/3h+PogO4gaolctdwJUm5s9TA6Q/+nM6inLg9eJViZFaCmR95HNvz4HA==
X-Received: by 2002:a05:600c:21d8:b0:3fb:410b:f073 with SMTP id x24-20020a05600c21d800b003fb410bf073mr5296534wmj.30.1687964069997;
        Wed, 28 Jun 2023 07:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm4846278wmr.47.2023.06.28.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:54:29 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-Bang Nguyen <pnguyen@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 1/4] dt-bindings: media: add mediatek ISP3.0 sensor interface
Date:   Wed, 28 Jun 2023 16:52:52 +0200
Message-ID: <20230628145412.1610260-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628145412.1610260-1-jstephan@baylibre.com>
References: <20230628145412.1610260-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Louis Kuo <louis.kuo@mediatek.com>

This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../media/mediatek,mt8365-seninf.yaml         | 299 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
new file mode 100644
index 000000000000..a54f785bb252
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
@@ -0,0 +1,299 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Sensor Interface 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
+  multiple MediaTek SoCs. It can support up to three physical CSI-2
+  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the soc.
+  On the output side, SENINF can be connected either to CAMSV instance or
+  to the internal ISP. CAMSV is used to bypass the internal ISP processing
+  in order to connect either an external ISP, or a sensor (RAW, YUV).
+
+properties:
+  compatible:
+    const: mediatek,mt8365-seninf
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Seninf camsys clock
+      - description: Seninf top mux clock
+
+  clock-names:
+    items:
+      - const: cam_seninf
+      - const: top_mux_seninf
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0 or CSI0A port
+
+        properties:
+          phys:
+            maxItems: 1
+            description: phandle to the PHY connected to CSI0/CSI0A
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI1 port
+
+        properties:
+          phys:
+            maxItems: 1
+            description: phandle to the PHY connected to CSI1
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI2 port
+
+        properties:
+          phys:
+            maxItems: 1
+            description: phandle to the PHY connected to CSI2
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@3:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0B port
+
+        properties:
+          phys:
+            maxItems: 1
+            description: phandle to the PHY connected to CSI0B
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 2
+
+      port@4:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for cam0
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@5:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for cam1
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@6:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for camsv0
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@7:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for camsv1
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@8:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for camsv2
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@9:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: connection point for camsv3
+
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+    required:
+      - port@0
+      - port@1
+      - port@2
+      - port@3
+      - port@4
+      - port@5
+      - port@6
+      - port@7
+      - port@8
+      - port@9
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+          #address-cells = <2>;
+          #size-cells = <2>;
+
+          seninf: seninf@15040000 {
+                compatible = "mediatek,mt8365-seninf";
+                reg = <0 0x15040000 0 0x6000>;
+                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
+                clocks = <&camsys CLK_CAM_SENIF>,
+                         <&topckgen CLK_TOP_SENIF_SEL>;
+                clock-names = "cam_seninf", "top_mux_seninf";
+
+                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+                ports {
+                      #address-cells = <1>;
+                      #size-cells = <0>;
+
+                      port@0 {
+                            reg = <0>;
+                            phys = <&mipi_csi0 PHY_TYPE_DPHY>;
+                            seninf_in1: endpoint {
+                              clock-lanes = <2>;
+                              data-lanes = <1 3 0 4>;
+                              remote-endpoint = <&isp1_out>;
+                            };
+                      };
+
+                      port@1 {
+                          reg = <1>;
+                      };
+
+                      port@2 {
+                            reg = <2>;
+                      };
+
+                      port@3 {
+                            reg = <3>;
+                      };
+
+                      port@4 {
+                            reg = <4>;
+                            seninf_camsv1_endpoint: endpoint {
+                                remote-endpoint = <&camsv1_endpoint>;
+                            };
+                      };
+
+                      port@5 {
+                            reg = <5>;
+                      };
+
+                      port@6 {
+                            reg = <6>;
+                      };
+
+                      port@7 {
+                            reg = <7>;
+                      };
+
+                      port@8 {
+                            reg = <8>;
+                      };
+
+                      port@9 {
+                            reg = <9>;
+                      };
+
+                };
+          };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e505023ffda1..1248a915a72f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13256,6 +13256,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK ISP3.0 DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+
 MEDIATEK SMI DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
-- 
2.41.0

