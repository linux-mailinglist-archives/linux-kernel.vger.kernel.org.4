Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC775F4CC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJDXoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJDXoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:44:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FF3481CA;
        Tue,  4 Oct 2022 16:43:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l8so9825289wmi.2;
        Tue, 04 Oct 2022 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/YoPlSUwIFj2VbxWVzc7A1HtubY4b0w59ZpSRLZodWs=;
        b=d4jtqINLFpGzLtUyKU23Ah7fpBELi03R3lgptTx3Niq5g49Q08R4LSAn041NkmVUqC
         IKth1NtuU+YeeOno9SgrkuYwKSoNkUphafVuC+4SIq9pkqEPtoUzWH+Fkdgj3LLbYMvw
         oyEKa9G0hSHDgvMpuN6p/aHX+y4Kv+boCPkYlpFmrAwV02paewgcfzE75OuGNsoObfB6
         lL0yvF1txbwpCXMrxGe02YvjOVII93Zg3HVcyPWtnhyvzd9GKWCFFq47McB5Ifz/gbYu
         OD9/bN0v9rxs7Wih5pKNMns7PRFiF2jDEhNfKGZo7WSNtCwhdoLqFg+K0wkjawwLGc6i
         qnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/YoPlSUwIFj2VbxWVzc7A1HtubY4b0w59ZpSRLZodWs=;
        b=tea0OxRjmJCLCd/P6v7xtqcNjvCswtushuRaQnFgwlR3N/vjgnnVh5HAbeycW484zG
         Kg5m0XG9eGMri8dnDu7faAko4FBa03Ljl4HwhWQmf2DRsj7EUUGZ8wpW6vbjW3BMNjY7
         AXdDrLCaFWBl+LbaYV2GdGGYm9Yun1RKlf/jxJph+dTeUg+5ejFcjPmE0qZuyuzz2Gfh
         9Eyt8CvI9xw/3LsnqoxC9YvTtGaxw8JQCpi2v4wk/xbm3s9YHpDv1LTU0jU+AhP3VKjq
         6sOxgYEOwlrTlybdkV6hOMpae+H73y9CKSiLVVrmN07UUZI84UN75YdFaA1PFgC/crtN
         9DjQ==
X-Gm-Message-State: ACrzQf18K2Y8K/zRCUtb6yEK0EXtqh5aJgOkV+p+/aJi7mvDVn2XxXIB
        W/xOXpTm3Qv50DzG1VMS1c0=
X-Google-Smtp-Source: AMsMyM7LPAT9fOZfab/lPJMqQw66Z5EsoL0LaWBMl4kGZDKu65gI8WBvSeFOprCJS/Q/yu+nUhxtcw==
X-Received: by 2002:a05:600c:2050:b0:3b4:a51a:a1f5 with SMTP id p16-20020a05600c205000b003b4a51aa1f5mr1339536wmg.177.1664927031193;
        Tue, 04 Oct 2022 16:43:51 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a47e:e9a:dd40:f694])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c2d0500b003b56be51313sm202461wmf.44.2022.10.04.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 16:43:50 -0700 (PDT)
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
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU block
Date:   Wed,  5 Oct 2022 00:43:41 +0100
Message-Id: <20221004234343.54777-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2 -> v3
* Updated clock names

v1 -> v2
* Dropped media prefix from subject
* Dropped oneOf from compatible
* Used 4 spaces for indentation in example node
* Marked port0/1 as required
* Updated example node
* Included RB tag from Laurent

RFC v2 -> v1
* Dropped endpoint stuff from port1 as suggested by Rob
* Updated description for endpoint

RFC v1 -> RFC v2
* Dropped CSI
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
new file mode 100644
index 000000000000..7dde7967c886
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The CRU image processing module is a data conversion module equipped with pixel
+  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
+  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-cru       # RZ/G2{L,LC}
+          - renesas,r9a07g054-cru       # RZ/V2L
+      - const: renesas,rzg2l-cru
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: image_conv
+      - const: image_conv_err
+      - const: axi_mst_err
+
+  clocks:
+    items:
+      - description: CRU Main clock
+      - description: CRU Register access clock
+      - description: CRU image transfer clock
+
+  clock-names:
+    items:
+      - const: video
+      - const: apb
+      - const: axi
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_PRESETN reset terminal
+      - description: CRU_ARESETN reset terminal
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: aresetn
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing a parallel input source.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              hsync-active: true
+              vsync-active: true
+              bus-width: true
+              data-shift: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input port node, describing the Image Processing module connected to the
+          CSI-2 receiver.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  # Device node example with CSI-2
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cru: video@10830000 {
+        compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+        reg = <0x10830000 0x400>;
+        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+        clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+        clock-names = "video", "apb", "axi";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_CRU_PRESETN>,
+                 <&cpg R9A07G044_CRU_ARESETN>;
+        reset-names = "presetn", "aresetn";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+
+                cru_parallel_in: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint= <&ov5642>;
+                    hsync-active = <1>;
+                    vsync-active = <1>;
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+
+                cru_csi_in: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint= <&csi_cru_in>;
+                };
+            };
+        };
+    };
-- 
2.25.1

