Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36C634C50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiKWBKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiKWBJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:09:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A920DDFB9;
        Tue, 22 Nov 2022 17:09:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s5so10117338wru.1;
        Tue, 22 Nov 2022 17:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfVcyLpgKLpa2boWuEy/gdN5iBlu9Wk4barU/qvQAx0=;
        b=jt/ktURq0NhB+LNkru0UO9jI0lCmgZhWsk0SJEW01gvAKVj72gkAn58etBlwes8qBU
         AaRHpcc/3emSqYxJmypZItLL8OSLlza/LwWY73qMNrqEkLZofO1kwccQCiOq26TSxa3c
         0kTt8i2fXC9fpuq6zlVDtxHZgShqwzv6YXUPhvKHOeENIikNJSEsmM6K00YxTnLBedGC
         ukbFHCmtwt/oi5qP1AKd+1W01UejRRSGN9CfywJUECUOWi/ut/Ryhj6sF/JFhD3AGCvP
         S0n2MZrMm69RD5BfXyfQtr9V0/FolwPN+io39LkwvUSkmKZNSuaFaM7zUN66wLb9p1ks
         u8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfVcyLpgKLpa2boWuEy/gdN5iBlu9Wk4barU/qvQAx0=;
        b=RDXfXApaaFhaoJbZbBmY1XlBM2ctU50FIpSyl60/sXqkCuwAkZzfnNNAIvhrWtye4V
         kNstBVAMWuCF7SxQNdW3yByUJ/75wCu5dLZfXIOgm+ySLJrsQHtjXxK23aiCYzz3wTGx
         uZkAWJs8zSO+D53gEjBLfKJ0XYk+pDNIx6hkfJ8rBjdehFh9Z5jtBHcmHqdbbI8kwA9E
         Z9rUZUG1UXxDswXoBt0fs1dzH1DpYpOk3v1unWBOY8kd+9J/5rs1V1qUGwYilQU3MfzM
         OUhsXHXhuAVsBaOo9t+/+imvQ9SJHJYWphJ6nH1JJ9pVG113QYxsu5H8nkq32cx71cS0
         b6wA==
X-Gm-Message-State: ANoB5pklgvDJZRKaRr8EzEkyoC0PAl2jBPIKe/hA+spZ5g7uNVALfoVu
        h4RYyEnHR/6u3D4FhquhQ7g=
X-Google-Smtp-Source: AA0mqf7MLVhL6TeoPa98a2XGBMhS3WA9r2Fk3srhneaLqWqUz5G29m0GdSRh16vb0sJI1quGEHggMA==
X-Received: by 2002:a05:6000:1f91:b0:241:ba9b:b47e with SMTP id bw17-20020a0560001f9100b00241ba9bb47emr14899093wrb.96.1669165789793;
        Tue, 22 Nov 2022 17:09:49 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:3178:d8a1:a393:6d85])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm421345wmo.24.2022.11.22.17.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:09:49 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
Date:   Wed, 23 Nov 2022 01:09:40 +0000
Message-Id: <20221123010943.324689-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document the CSI-2 block which is part of CRU found in Renesas
RZ/G2L (and alike) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v5 -> v6
* No change

v4 -> v5
* No change

v3 -> v4
* No change

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

