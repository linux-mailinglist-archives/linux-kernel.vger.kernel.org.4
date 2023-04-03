Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8534F6D3DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDCHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjDCHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:19:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A95FFA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:19:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so13667942wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680506397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVU4RWnnyUxN/4R/aQctGtgga+2F97ZjMTd4w/vQJpk=;
        b=4UU7G4p85jYpbaznDqsi6k/mDKHAj8qWT5nGe+5FtXHC6uM3e+A3ES3ck75BH8EEdA
         cfmNs4gqmcFKLXj3Ox9b20prhVLC8qkyx7JXK2b3WIaUncdlThZMSwDDA4kxibFeLVnH
         XkaXjAvFUm/ar+eOmHPB8Wv3emiVJniLVfjCMPnDAhzSOitBKgJuKf2apIlIvL2w5cIb
         l9+GLsw1c8Zw7hg20aSh+SIjFCMqN1ZoHMjD58Bja3iAiu8NMFX0eyt2z6Wz7cB8ioIH
         exuB9Rn4WDQYSv4GKK2vXpgBg5zkozurLXhpRm60zKWQ8iOpumrar0QK7xOPMOKXuNSV
         LCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680506397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVU4RWnnyUxN/4R/aQctGtgga+2F97ZjMTd4w/vQJpk=;
        b=pTXRgDitYpkfRQi3ipeYR7mbXRsRxVOyCO9+epH9Nj9Lt/rZXU8IJBsLLH7A8CsTpo
         j66m4cUxcbZeDCU/CVvtZQ7vHUpkueL1KKKzHZ8RRsy/tctYw3as6C3yHK23nebfpfpW
         BSo7IbPbfnH3tpuq++jmeTuC2MvI43VD/cER0I707ILSAm6Og+Kloj5rGOdE5QPRQEpA
         0DLrJBNdEHkajImmidvb5k6PQRLKbwgIzS8S5n0vL/DqpJSMfQU35avpcTPnFuwGRoNT
         IR0fWC/uS4Xsg+4ePx/OCdNqzieCNWJzIvbgU8gugR799tOOoM/Be5fR9yXwEIDk09QT
         jeVg==
X-Gm-Message-State: AO0yUKUBogt3smTK53Lo2Y5A8ukkCjYqplrvzDtw2pBlxyYzwzKpL7Td
        FBSsF2DZQEKaTKhT7Peno80Ttg==
X-Google-Smtp-Source: AK7set9JfS6EkdNxsvq8m3JaM4HWW8unwj4xfBqnQFM5v1P4Yau30M6jCRGb3xcdcBySIEnH0yG3pg==
X-Received: by 2002:a1c:4b13:0:b0:3ed:33a1:ba8e with SMTP id y19-20020a1c4b13000000b003ed33a1ba8emr24618383wma.1.1680506396912;
        Mon, 03 Apr 2023 00:19:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm19060418wmp.5.2023.04.03.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:19:56 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Florian Sylvestre <fsylvestre@baylibre.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek USB3
        PHY DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek USB3
        PHY DRIVER),
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: phy: add mtk-mipi-csi driver
Date:   Mon,  3 Apr 2023 09:19:28 +0200
Message-Id: <20230403071929.360911-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403071929.360911-1-jstephan@baylibre.com>
References: <20230403071929.360911-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Sylvestre <fsylvestre@baylibre.com>

Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bindings/phy/mediatek,csi-phy.yaml        | 41 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
new file mode 100644
index 000000000000..c026e43f35fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,csi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Sensor Interface MIPI CSI CD-PHY
+
+maintainers:
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description: |
+  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
+  receivers. The number of PHYs depends on the SoC model.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-mipi-csi
+
+  reg:
+    minItems: 1
+
+  '#phy-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@10011800 {
+        compatible = "mediatek,mt8365-mipi-csi";
+        reg = <0 0x10011800 0 0x60>;
+        #phy-cells = <1>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d54f3193075..9308b4bb88bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13098,6 +13098,12 @@ F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mediatek/vcodec/
 F:	drivers/media/platform/mediatek/vpu/
 
+MEDIATEK MIPI-CSI CDPHY DRIVER
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
+
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-- 
2.40.0

