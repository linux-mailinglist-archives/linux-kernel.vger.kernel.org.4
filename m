Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC870F0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjEXIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjEXIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:30:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5818B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so467608f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684917051; x=1687509051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bgK81zYJJlKzJwC/YpUVSKkmte5LSImvMG9blyHL8w=;
        b=q3rlhiN1dqBA2GKz3Baz0KFqAEsTk9Qe+RSwPRNOe/jjZ3ukXTwBxzpVyKlxqS3oJk
         BikGg2jYUATGzhaIdGoeT/DrFEkG8IDjhW5p65ywpyai0QXsEH/hv9LzF2PVM4/bcUpG
         TTPCH9s57Yp/5jPz1TCf1SW3gnCEo7w06js9iutJCPnpdnSOnHnlFs+313+Apq9cJgtu
         7x8RzeXcP/ArERx4Vg6UdoEjNUjJRmhy7qgCR6GzK4SfoMuE23SG8pbo594k6H1c6JXs
         DCsfmjLYVxHZO73M52cFGNZJDtdjFM3Dh+RRbIpvlR4UfYU5xv0YmViBPjducNXwgp0U
         j8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917051; x=1687509051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bgK81zYJJlKzJwC/YpUVSKkmte5LSImvMG9blyHL8w=;
        b=cDuy2eTOPWKPzeRQq1V8R9RAZcxuceBbdpZHBZpd6T86sJh1CqwDYLlHirdr2g0VWW
         lF+pvJ6g/aKEJPdjuDTXt4mZzYsekxplmMgKzwixR3OwheMD+xH71mytZVsz4vEk2u6X
         PVNvUntjHoRFrWbDGg5v7PlrDY0RNiPGKMJKxhJ/E8KBqeKaD2PfOJtpQ7CMf+vwY3kJ
         EIWF5ClcjsbbCtUytyS5gGUzmdVnBvC5BEQr5LhX1cdTQ5ujfWIi1b3O0VeGfYO7j7dV
         tbp3BqKp4opvLgIbR55sYnJ9ll/TeSfL8rTayjtxq2+9jNKXz7I8si6DnxxZl75/h9fr
         xfAw==
X-Gm-Message-State: AC+VfDzQ2Sw9YhhtlEM3NfO5YsjxZjk9cziMb1p4vV/JLlugR1/HS6e0
        ClxqirblHZjLPKNGuDR5AlsQ8A==
X-Google-Smtp-Source: ACHHUZ4rg9xDTlc33OxE5pi3GZwUh53PWH0eMhBen5R9zYe/bMYwZfbseDecOPk9Jj73PjeMwBppWg==
X-Received: by 2002:adf:ef42:0:b0:301:8551:446a with SMTP id c2-20020adfef42000000b003018551446amr12446568wrp.2.1684917050983;
        Wed, 24 May 2023 01:30:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00307c0afc030sm13871832wrs.4.2023.05.24.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:30:50 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Julien Stephan <jstephan@baylibre.com>,
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
Subject: [PATCH v3 2/3] dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5
Date:   Wed, 24 May 2023 10:30:31 +0200
Message-Id: <20230524083033.486490-3-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524083033.486490-1-jstephan@baylibre.com>
References: <20230524083033.486490-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 67 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
new file mode 100644
index 000000000000..a1bd96a98051
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
@@ -0,0 +1,67 @@
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
+  '#phy-cells':
+    const: 0
+
+  mediatek,phy-type:
+    description:
+      Specify the phy type. Supported phy are D-PHY only or CD-PHY capable phys.
+      See include/dt-bindings/phy/phy.h for constants.
+    enum: [10, 13]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - mediatek,phy-type
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
+        mediatek,phy-type = <PHY_TYPE_CDPHY>;
+        #phy-cells = <0>;
+      };
+
+      csi1_rx: phy@11c12000 {
+        compatible = "mediatek,mt8365-csi-rx";
+        reg = <0 0x11c12000 0 0x2000>;
+        mediatek,phy-type = <PHY_TYPE_DPHY>;
+        #phy-cells = <0>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b81e9fcc66cb..5da594fbb761 100644
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
2.40.1

