Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F817438EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjF3KF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjF3KFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:05:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E63A90
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:05:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2031995f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688119545; x=1690711545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzj7Am8v4sZKcg6oYAmAbL82yLixQgxMAE5EK9pmGUE=;
        b=ekSSAvTlH34GW44/04/BA4CRpWDR0LXvvZaNYIK20v6VsXywPrE3zEL2jml/xM+6x0
         PNWwJ7XayPWkcfKRmastUp3jVDqYQMhMtdeWRvqY732q0EKWRJhjOiYegnwEgQAp+HzO
         rTPaSA94hHV6/RUum5+abNHP6zrTAybSE8zNbdX41I4vBpv1k4a3aML2Yfhd0xkylZuy
         eJX9brYcPYG8V2BltMBLAL3WCO074ZijbxsGacm3oaNocSXtwqituFo+YX3FcQg7q/ik
         ephs0L0t9o03MnRaDcVsZbGiFAjum0R3J3JCQLTFBsdC3wMpn3nusVwilIdPzCIT3fn0
         GDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688119545; x=1690711545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzj7Am8v4sZKcg6oYAmAbL82yLixQgxMAE5EK9pmGUE=;
        b=LLTjeFlkLSlEnCLx+2kGDk157dsqiys7pblB2YKARFSMfegFbwjipyOoPREePu0Vm6
         eNzkGp4JXta3XBZQtKnPUNV/o5ZWVeaJtIwdf+kegx+xO7Rgtpc4vRBBlslhOoFV4wc+
         tS+UtshhxveCOjc6zxYY/LX6ovKbDsQUg3HK4/aLz6Q4Bz7thF2P8xmEueijCIglne68
         8TEU366eB56KyglWvZTiTm5MDZMwKIqsDdKbTG50rcgNsRNIdBPOE+d4lyGnVUSSd0oO
         CO5QkzCuZHmQUGlZ8afVyskSvk+TRtkp+fSK66uyVqNQnkp2frYSnjTloi2bPFj0p2VQ
         b8+w==
X-Gm-Message-State: ABy/qLYTp5YWCoE7ica3zuG8ezYpmUuZMG+y2HXYwdE0lajLUBPfog3u
        EqCt3NY3h6gtPOwT0SMJgKH/zA==
X-Google-Smtp-Source: APBJJlGCTtGhTaneaRHfpnSSBpufd80KQLhpdGgirs5GF9QNXCoE0tA/fwfVE/z7C7u35GwNkjGYAw==
X-Received: by 2002:a5d:49d1:0:b0:314:172b:a75a with SMTP id t17-20020a5d49d1000000b00314172ba75amr2033659wrs.26.1688119545073;
        Fri, 30 Jun 2023 03:05:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0031424f4ef1dsm743280wro.19.2023.06.30.03.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:05:44 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v2 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Date:   Fri, 30 Jun 2023 12:01:52 +0200
Message-ID: <20230630100321.1951138-4-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100321.1951138-1-jstephan@baylibre.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
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

From: Phi-bang Nguyen <pnguyen@baylibre.com>

This adds the bindings, for the ISP3.0 camsv module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bindings/media/mediatek,mt8365-camsv.yaml | 113 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
new file mode 100644
index 000000000000..d81fa5d6db74
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-camsv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek CAMSV 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
+  receivers. The number of CAMSVs depend on the SoC model.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-camsv
+
+  reg:
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: cam clock
+      - description: camtg clock
+      - description: camsv clock
+
+  clock-names:
+    items:
+      - const: camsys_cam_cgpdn
+      - const: camsys_camtg_cgpdn
+      - const: camsys_camsv
+
+  iommus:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: connection point for camsv0
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - iommus
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        camsv1: camsv@15050000 {
+            compatible = "mediatek,mt8365-camsv";
+            reg = <0 0x15050000 0 0x0040>,
+            <0 0x15050208 0 0x0020>,
+            <0 0x15050400 0 0x0100>;
+            interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&camsys CLK_CAM>,
+            <&camsys CLK_CAMTG>,
+            <&camsys CLK_CAMSV0>;
+            clock-names = "camsys_cam_cgpdn", "camsys_camtg_cgpdn",
+            "camsys_camsv";
+            iommus = <&iommu M4U_PORT_CAM_IMGO>;
+            power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    camsv1_endpoint: endpoint {
+                        remote-endpoint = <&seninf_camsv1_endpoint>;
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fda342ad331..60b2bceca584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13355,6 +13355,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
 F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
 
-- 
2.41.0

