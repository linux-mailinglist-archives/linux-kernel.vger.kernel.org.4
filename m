Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0F7028EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbjEOJiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbjEOJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:38:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84622D67
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:35:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42c865534so66586105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684143355; x=1686735355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1U5d4MLxOVRGxYrIG94ORc3atBG6AwDIhORaNjU7E8=;
        b=0I7No2h2vVPxZmELHElkO+DCMmo/7h06fCuFCt9VWkpo8/xiz0U4nvQr+oP9mcYZtf
         FX4pXi+9qn6fWaFgnuy9ee8GlUrAvc8uOIPfMUmMy7ACNpBV4nfERAdFfCntOoJ20RN9
         zoQsNqlbnxRL3Gg+Kxjq+LQr44RsWRr1z+XR6KwIl47cS1kUp2xFQg0lQLdiHdPsWGRR
         eAA0GQQjkW/1ExWten9k75ga4J8zLaqeB3zjT9+EgCjfS4qgaI50Zsg4keJHUZPEA3V1
         XL1tbgpzyYuCd+brFvK8S14n9y8WsypZnjmYhBHTwpgto1VIDsbN7OmbxQm3QCNaUEas
         mfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143355; x=1686735355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1U5d4MLxOVRGxYrIG94ORc3atBG6AwDIhORaNjU7E8=;
        b=fMaCS1rGdqtkZ3n5f99EEcPuCMrwFjsW0nbj2Cjacn8EFQpuEI86uLMLljkUfg5UuB
         yQG1yliYpZ4o4nVnhQdBK0GY1gvZPseqmBCdq98giy6EW+8QIYI0tDRsv1UkIOZm6SaI
         Cj1zqB8EmpbENHHHu07rJw/P0D3ER2rFuOclnrAnRlRhDYbOi9Icd9QHl9Mp8U5UqU1S
         v1EEyICGkXfHZ0k3e0VyOo1F0odt3v2LHCTL6h+hFauvSW+rcKx6805LTO0st1hqApW/
         lmNH37DSIXI9L9jXH5XDFULRlW0Rk7MT4iUeicNa9gdWHtkGYFeJ/9gAuKQS69xYpujo
         guMQ==
X-Gm-Message-State: AC+VfDzGl5NiBwer33vLyu40H2ZXe7EPfi1Sc4rHzsJbwrVAnLi1DMC2
        gk9mkf1B8n/RZdHub0UptIwAdA==
X-Google-Smtp-Source: ACHHUZ7+Cb+vH+WpGUTIuorFy/U4TAkpqUMxuly4awYN+dmnigKVjCrRjrsxKfKFu1bnpDBzyacmPA==
X-Received: by 2002:a1c:cc0e:0:b0:3ef:622c:26d3 with SMTP id h14-20020a1ccc0e000000b003ef622c26d3mr26682092wmb.35.1684143354910;
        Mon, 15 May 2023 02:35:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003f42813b315sm21035451wmk.32.2023.05.15.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:35:54 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
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
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] dt-bindings: phy: add  mediatek mipi csi driver v 0.5
Date:   Mon, 15 May 2023 11:05:50 +0200
Message-Id: <20230515090551.1251389-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230515090551.1251389-1-jstephan@baylibre.com>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
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

This adds the bindings, for the MIPI CD-PHY module v 0.5 embedded in
some Mediatek soc, such as the mt8365

Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../phy/mediatek,phy-mipi-csi-0-5.yaml        | 62 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
new file mode 100644
index 000000000000..5aa8c0b41cdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,phy-mipi-csi-0-5.yaml#
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
+  Depending on the soc model, each PHYs can support CDPHY or DPHY only
+
+properties:
+  compatible:
+    enum:
+      - mediatek,phy-mipi-csi-0-5
+
+  reg:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+  mediatek,is_cdphy:
+    description:
+      Specify if the current phy support CDPHY configuration
+    type: boolean
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
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      mipi_rx_csi0: mipi_rx_csi0@11c10000 {
+        compatible = "mediatek,phy-mipi-csi-0-5";
+        reg = <0 0x11C10000 0 0x2000>;
+        status = "okay";
+        mediatek,is_cdphy;
+        #phy-cells = <0>;
+      };
+
+      mipi_rx_csi1: mipi-rx-csi1@11c12000 {
+        compatible = "mediatek,phy-mipi-csi-0-5";
+        reg = <0 0x11C12000 0 0x2000>;
+        status = "disabled";
+        #phy-cells = <0>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d54f3193075..44f0ff11e984 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13098,6 +13098,12 @@ F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mediatek/vcodec/
 F:	drivers/media/platform/mediatek/vpu/
 
+MEDIATEK MIPI-CSI CDPHY DRIVER
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
+
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-- 
2.40.0

