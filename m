Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0460C6156AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKBAoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKBAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:43:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86627BDA;
        Tue,  1 Nov 2022 17:43:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so22383163wrq.6;
        Tue, 01 Nov 2022 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QphUskXB5Q4FOtuPKsXeFyRlW21b9sfIILkgdQVK38E=;
        b=jellIiKXzPwU4pdQrit6k3tJp9St6UTu/yOtIPu8qBYzfgoyl+SDWLxqTnFNOqAv65
         vQFCLqlG7od5eqEkcVAQf123t2oaM6CPoy1LayCWVR/zwXH/NSJu+LGBnCyzLjxvRvWq
         cRv7DIxVYWaOxA/CwpaF5NXfaroDT6YhCEFTLmx4rzLAkrZWs4ZPD7sf28QjOIidHXHo
         4Hih4huJFB+eQdzbq030AQ1IzTrS3Sj61fdYC2uccTYX8hUC3xSq+1PQdfkMuqin/gN0
         V/QCmR85U8HFmUGHFQgTvATfUnn8vbDXqM2I23zFEsBWcR5jTOLxV6ga4icTgBMnhow2
         ZyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QphUskXB5Q4FOtuPKsXeFyRlW21b9sfIILkgdQVK38E=;
        b=S8cU/ZMJ1tjCNo80sIDj112rG4dOkm+ZdIQYGuAFEt1TDfJydFDZHVW9oQlpgfs05c
         sfRnJkKi1POWtXjOg8OhEHq05ocM4+PJSTIJ24Bzh8ejtkRfkjgHDvUOMEa7VTMj+fLG
         X4siHx8l7dJ9JYvns40yo8z4CKmPd3VIqOu0SK3xjEu1/xbw+kaq0HgLiUZKv0j5+iN3
         uk2WeQdrEOETxvH3w14XlCSsW6Srm9ea/UsMhEzBnJ+cxlvk45WLg+WNDlByQl4wtf0Z
         WrNcR6ZArbcBrW5Z7D6E0OE3ulrFAU7oWimomjCipKcw/92Y70VmxvnGbcp0LdLvNDCW
         y5+Q==
X-Gm-Message-State: ACrzQf1YWzHZf5SRrHt0RSWxN5tezX2Yh1r/JeGeSGPdWFo/ag+V7+b4
        azeMv2z37F6LhVTW65kRp44=
X-Google-Smtp-Source: AMsMyM7OmAXAJw/3ej9FaR6Oi+nv75doNuwmPcz3VWXDE90u4Pp/5b87e78cUF1q4iWIV2bhV9ysbg==
X-Received: by 2002:a5d:66ca:0:b0:236:6d69:e1a0 with SMTP id k10-20020a5d66ca000000b002366d69e1a0mr13293510wrw.558.1667349830046;
        Tue, 01 Nov 2022 17:43:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:edc5:36d1:26b:8ee9])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003c6f8d30e40sm250737wmq.31.2022.11.01.17.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:43:49 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU block
Date:   Wed,  2 Nov 2022 00:43:27 +0000
Message-Id: <20221102004329.5410-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4 -> v5
* No change

v3 -> v4
* Included RB tag from Rob

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

