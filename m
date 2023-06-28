Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9606474145D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjF1OzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjF1OzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:55:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D119B4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so68675535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687964097; x=1690556097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpxKkOH7gRTDC4QodDjR2wwv58iUFQUpm2dZjJmE7Cs=;
        b=Sc2VKBypeamq/KpzUYYqaXbpP8+zkQyaEAE+49/cvje7GbP404GZiQ/kSLDIib3AM4
         H/iwv23if4IkDjbxUN53YrJKApEusUQclUtgy5uiw/+XtKjxb7RXVaL2Bp2tidBWePZa
         KKPbiWvs7Yi/WL/abPgdhLHdLqlJoUz7zkPHqP9ynGF++2xysI65eAPLLV1cDmhkcfqw
         pKOokruMWryIeg/lZQ0lIeO+XGQ7GKlGePrGnm3Ei9xYTBDPNUOoKUfHg/Il9VhpdC+1
         /GdVbYdgXbqF/qGntRgRKK2NlpJ9Wnl3ncFidOM2v8sAfYywOXMgcvZ+NsxcNwuN3TZm
         3h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964097; x=1690556097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpxKkOH7gRTDC4QodDjR2wwv58iUFQUpm2dZjJmE7Cs=;
        b=DqKgzJO0jnhJNws8NceBNZ2gL+/3y7s3JWlHxBKnLZQ3sBiRYlrfL+agqsCn+pdNHc
         8LxX24AX5Jd7JMd997dRJ7RJ6Swdciwn7ct2z98fKGWVpzAFszsMWpRbH0P/WeDHjpuy
         XISr4oEtXxk7tz0KAx0uN7xEkKl4kJF+5RtmSO7UaIb35t6kfL14pnqhNIxDl60VOjO6
         fyYVC+xlq7ol06LxTyxQUZNVsEntrL6MmCv7RXxW+rthg+JL7WHw+5aQSX7RNQLQHJiL
         FIrdzatCLGkgtgFWSqxbhR3KSrs4RmRQujASHm1e7BszK3m8AJgwMR/VuJFwjvTHo5fu
         4/CQ==
X-Gm-Message-State: AC+VfDzfIM30tSInC/A5Vd3YNOE5lndBgMDWkWb4cVBW+kLaVoYzcemF
        S0WhuspsTYEtKVG74IfCSmVTbg==
X-Google-Smtp-Source: ACHHUZ6YpTtwVp8ACUoY4uDm9mxJgfRSQalAzH7hr8F5SqjU+Do45aNRMWAHUJ84pt7tZydoecseVg==
X-Received: by 2002:a7b:ce94:0:b0:3fa:99d6:4798 with SMTP id q20-20020a7bce94000000b003fa99d64798mr6450489wmj.37.1687964097784;
        Wed, 28 Jun 2023 07:54:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm4846278wmr.47.2023.06.28.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:54:57 -0700 (PDT)
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
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
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
Subject: [PATCH 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Date:   Wed, 28 Jun 2023 16:52:54 +0200
Message-ID: <20230628145412.1610260-4-jstephan@baylibre.com>
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
index 000000000000..e8ef6e0fd4bf
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
+        patternProperties:
+          endpoint:
+            $ref: video-interfaces.yaml#
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
index 4f83682732e6..2256ddcc4ca6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13261,6 +13261,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
 F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
 
-- 
2.41.0

