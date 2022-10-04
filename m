Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041775F4CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJDXoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDXoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:44:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61D2FC1C;
        Tue,  4 Oct 2022 16:43:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so174920wmb.0;
        Tue, 04 Oct 2022 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PF7E73KQ1n1awp93A4zRltZY54I7cVFO2GfXjBhFNkc=;
        b=m6Yc1MsFCLGMHsjB44xY0/Gsns41ardIzKcPyprdX7GmqqFr6MDFw1Bx+xkJyl6kvw
         jeKXdug9NhgvWPc+ZbDqsa+Tken3OVf7y7To3zFsYAJTfMUzeo1s4gdjGOwoEDS7xlRc
         F0WwIGhBJQ6WpDe4xW7RZWOBWuUpdCvFmC799JXyVzTmMxE/112uvpg5bwcABBXezsu4
         GQmjayAWQ9N7kg9y1LtCSqQW6ZLagd0ah3fZFMK8r1wqHUHmbGdg0zFDZMLK/wqYBR/H
         xGt5FcEKsp+db2W0LM08CRfPEQyJnRNtL6KhERtxKPsFsUQdWXi4Qs3BK7gUZLF2Jh5r
         XY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PF7E73KQ1n1awp93A4zRltZY54I7cVFO2GfXjBhFNkc=;
        b=Dp+BlPwPu56BE2kpB2hODTC8HRZtUgtdlAWKkuT80qM2g1JXY16s9GkkToqnWTeVse
         qmhHlLD0Wk4zl/ieUgVnDpDwqz6uA3rlbCfajT+gz1RRgRKzYoIwv8T/38l25xIdjVEy
         s7Rz4v33RPzxZY6wa+imkqAH5796EBxkH0ybXVUc/McpvYldc9S2lPqrtrBfi6RI0+kt
         Nvyic/ghdOBPhbhd5SVAk36j02p98eWuuxQzJCT2phuD2m82FpqowfKWadaZfz7no/SZ
         yIKBENtM75H3tK3C0n28lF2Ig4G3ctsqEifXFVxJAz3NkElR7/iYBfN4Yh/5Wh2fBx5K
         lL7w==
X-Gm-Message-State: ACrzQf0I/AZhzBh4QyyisVCuw1JaI6D4dqPe0MkDFb7dOZ9LkGOhsAUQ
        Y7czf2d6cDbWVhQhBmN48bA=
X-Google-Smtp-Source: AMsMyM52JdH3g041V2hF90NquIfgzzDQoOk1+yK8kfpPtAoRLUm6NvofWj56nN8qypoSjWsg4uho1g==
X-Received: by 2002:a05:600c:3b9e:b0:3b4:4cf1:9531 with SMTP id n30-20020a05600c3b9e00b003b44cf19531mr1398519wms.64.1664927030034;
        Tue, 04 Oct 2022 16:43:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a47e:e9a:dd40:f694])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c2d0500b003b56be51313sm202461wmf.44.2022.10.04.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 16:43:49 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
Date:   Wed,  5 Oct 2022 00:43:40 +0100
Message-Id: <20221004234343.54777-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004234343.54777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221004234343.54777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the CSI-2 block which is part of CRU found in Renesas
RZ/G2L (and alike) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2 -> v3
* Updated clock names
* Included presetn reset signal and added reset-names in CSI binding
* Renamed csi20 -> csi for example node
* Included RB tag from Krzysztof for patch#1

v1 -> v2
* Dropped media prefix from subject
* Renamed node name csi20 -> csi
* Used 4 spaces for indentation in example node
* Dropped reset-names and interrupt-names properties
* Dropped oneOf from compatible
* Included RB tag from Laurent

RFC v2 -> v1
* Fixed review comments pointed by Rob and Jacopo.

RFC v1 -> RFC v2
* New patch
---
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
new file mode 100644
index 000000000000..67eea2ac1d22
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
+  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
+  with the Image Processing module, which provides the video capture capabilities.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
+          - renesas,r9a07g054-csi2       # RZ/V2L
+      - const: renesas,rzg2l-csi2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Internal clock for connecting CRU and MIPI
+      - description: CRU Main clock
+      - description: CRU Register access clock
+
+  clock-names:
+    items:
+      - const: system
+      - const: video
+      - const: apb
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_PRESETN reset terminal
+      - description: CRU_CMN_RSTB reset terminal
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: cmn-rstb
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing the CSI-2 transmitter.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
+
+            required:
+              - clock-lanes
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Output port node, Image Processing block connected to the CSI-2 receiver.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    csi: csi@10830400 {
+        compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
+        reg = <0x10830400 0xfc00>;
+        interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
+        clock-names = "system", "video", "apb";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_CRU_PRESETN>,
+                 <&cpg R9A07G044_CRU_CMN_RSTB>;
+        reset-names = "presetn", "cmn-rstb";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                csi2_in: endpoint {
+                    clock-lanes = <0>;
+                    data-lanes = <1 2>;
+                    remote-endpoint = <&ov5645_ep>;
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reg = <1>;
+
+                csi2cru: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&crucsi2>;
+                };
+            };
+        };
+    };
-- 
2.25.1

