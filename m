Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB089736BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFTMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjFTMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:20:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519A128
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:20:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso49979275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687263602; x=1689855602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXmcS/2oGuecncHurBHCDvbohS0tejnBEtI7u/YX0AI=;
        b=wKB3l+lEX1/Z9vBIXHTZgagfJ354S2rdf9kwVBTuhiZx43ftmPdmHcEYiZS5IKnJ9c
         Lc9NyLJHKYQ22KfUqsxbP3mrfAJybli5wZ4AugqSYz0CpzkgUK3TrRFQG+YuYvet4CU9
         Kg7c61zibcQnm6WGypl99+rpdx++8kZe3mRPbpFa3Gw17sLnZiZ/8D7yLpaDyxbs4SvK
         pj4K04nzsaJGLFNUmNaz0tcHIQIRnNVYZAYAOSn/zJ59UPiQbq/EVgJ9l7jTeQ9sQkNZ
         +fNyk/q+J4djq7JMD5ULCvPR21quwxhfvW74UYppQCbxDoB9XhPPMpswiC72rgn3icq1
         AuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263602; x=1689855602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXmcS/2oGuecncHurBHCDvbohS0tejnBEtI7u/YX0AI=;
        b=a2ZSyzKApNdvEuZyXmYhuOm6VSzGetvbE3/Wk3eN2pdZAbzTPi3F7z8dbfk3/LkYQP
         X2APo9ER3d//dQGbQI6UQwDaPYJl8AfKgT/P3Ls8PgEdSM4PRBmj/IegwxgMgGpYkkpC
         kAhrl6Y0ZNdqU5hzVm2grPK8Mqj6fP4htwqY4Ovmz8+o123n/6DN5xULqGuEm7aZeedT
         4jJsgs+/WXrDe2wLl2XZXI/KeDw1K7UEdsLiGqkrEDlDHd6Nx7hqrqPAUHBSXaxwhQ9U
         2w3onIgzIZvfXNwRU944VOW34umPq4zBoomg2jUyMlUxyW8PMOTh4WTvLJ9dwKHwdwh1
         yIEg==
X-Gm-Message-State: AC+VfDwcuH4EvHV1zG87vDExdwgRwBASLpa8BTtAfM0CJvZzV/DEFyDw
        soGhWFKWYiq+5Pn3pXFKkEgUHw==
X-Google-Smtp-Source: ACHHUZ6Mdas/N0VFI0B+z8neuKplKhLqK8MFi7ecgPSeIHTj3Y0/v3za8BLHZFriATu3xAZkw2u6+g==
X-Received: by 2002:a1c:ed0b:0:b0:3f7:948f:ad1c with SMTP id l11-20020a1ced0b000000b003f7948fad1cmr10661593wmh.6.1687263602421;
        Tue, 20 Jun 2023 05:20:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f18b942338sm2242513wml.3.2023.06.20.05.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:20:02 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     pnguyen@baylibre.com, louis.kuo@mediatek.com,
        fsylvestre@baylibre.com, Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5
Date:   Tue, 20 Jun 2023 14:18:46 +0200
Message-ID: <20230620121928.1231745-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620121928.1231745-1-jstephan@baylibre.com>
References: <20230620121928.1231745-1-jstephan@baylibre.com>
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

From: Florian Sylvestre <fsylvestre@baylibre.com>

This adds the bindings, for the MIPI CD-PHY module v0.5 embedded in
some Mediatek soc, such as the mt8365

Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 79 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
new file mode 100644
index 000000000000..2127a5732f73
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt8365-csi-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Sensor Interface MIPI CSI CD-PHY
+
+maintainers:
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
+  receivers. The number of PHYs depends on the SoC model.
+  Depending on the SoC model, each PHYs can be either CD-PHY or D-PHY only
+  capable.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8365-csi-rx
+
+  reg:
+    maxItems: 1
+
+  num-lanes:
+    enum: [2, 3, 4]
+
+  '#phy-cells':
+    enum: [0, 1]
+    description: |
+      If the PHY doesn't support mode selection then #phy-cells must be 0 and
+      PHY mode is described using phy-type property.
+      If the PHY supports mode selection, then #phy-cells must be 1 and mode
+      is set in the PHY cells. Supported modes are:
+        - PHY_TYPE_DPHY
+        - PHY_TYPE_CPHY
+      See include/dt-bindings/phy/phy.h for constants.
+
+  phy-type:
+    description:
+      If the PHY doesn't support mode selection then this set the operating mode.
+      See include/dt-bindings/phy/phy.h for constants.
+    const: 10
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - num-lanes
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      csi0_rx: phy@11c10000 {
+        compatible = "mediatek,mt8365-csi-rx";
+        reg = <0 0x11c10000 0 0x2000>;
+        num-lanes = <2>;
+        #phy-cells = <1>;
+      };
+
+      csi1_rx: phy@11c12000 {
+        compatible = "mediatek,mt8365-csi-rx";
+        reg = <0 0x11c12000 0 0x2000>;
+        phy-type = <PHY_TYPE_DPHY>;
+        num-lanes = <2>;
+        #phy-cells = <0>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 45fc831f1654..024d67eb7a94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13184,6 +13184,12 @@ F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mediatek/vcodec/
 F:	drivers/media/platform/mediatek/vpu/
 
+MEDIATEK MIPI-CSI CDPHY DRIVER
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
+
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-- 
2.41.0

