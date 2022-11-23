Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA79634C55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiKWBKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiKWBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:09:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D899DEACB;
        Tue, 22 Nov 2022 17:09:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v7so12085343wmn.0;
        Tue, 22 Nov 2022 17:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvj2R6KDrLSW8jhucqXrzwRTkqv9VapN8uDIIzo94jE=;
        b=Buh0hhKLLhI7MkbBA1MlcuACA5Y4jXyiMw/b7UXwwm7Orh69y8ti+17bjFN35uJTMR
         9YkYpWk+R6U1GdLWwVchPZ8BbA+YQh/mLsJJsBDAUMfm1d76Gmm+hmguPWwbdOZKxCfs
         xdqzL7Fl536AOhp9x36q3PKi88iQOlnHlTdxV5LXOhdAlnbQtTf98u4jnGrCgQF+v5N5
         ox4Rtqzr1fPf8mbsVfO32Xois6utqBUE4mOIEIRKoktEG88OldEHyWFsAsjdVGhp3BTx
         adZAdf2dzKdLHivXjliM8+RVEq2zrN/d6bxeXFfm9kmXdTxyjXJ536SE4sGpHwJVA0b2
         EYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvj2R6KDrLSW8jhucqXrzwRTkqv9VapN8uDIIzo94jE=;
        b=pg7cetcAgJ40C4NtGUo5QrAqNFL0QKL28hEXky6jUDzLwvOm9+1nYcw6A7YfpUfsw0
         kPg0lu0a1ErYRmB/Zj61k4K4onO5aJCJo/ZxyuQQyUm0Rf1m279+r0Wsg/vGLLVfB5WM
         O41cfpf2qWVW/ToI4MjQfMwCfHQG0HPyyGO/51HDpkNscbA3gP5KiglXOwsfZEcZ8nDo
         ZOUAKSmf0phW919oW230hV33cbnXeiQxKi7PbRdfYQaPpUGtTE+BwH78MsJNOK4Q6BAx
         OG7nw1oaKJT9IJeK+9JgDd7ehbA4SBjGnpaB+kt50YWNnroxc8XS3TPawwFzsItSQC8B
         Rj7g==
X-Gm-Message-State: ANoB5pnpBtFydWF1iR3blY7fBJuv10Hlm9rb25TETYafwqri7uqxNh9Z
        rx5Vg36e8g7+Su6f6hWDO1U=
X-Google-Smtp-Source: AA0mqf6ENfwGZJMckMxYw1kEV+iweSFVTprAlFjpj5XQlbfywVVZkojLDzurLyo8036i2jFaRbhLCQ==
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr7630668wmp.63.1669165791034;
        Tue, 22 Nov 2022 17:09:51 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:3178:d8a1:a393:6d85])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm421345wmo.24.2022.11.22.17.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:09:50 -0800 (PST)
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
Subject: [PATCH v6 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU block
Date:   Wed, 23 Nov 2022 01:09:41 +0000
Message-Id: <20221123010943.324689-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123010943.324689-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221123010943.324689-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v5 -> v6
* No change

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

