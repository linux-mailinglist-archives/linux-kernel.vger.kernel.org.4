Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55862EAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiKRBAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiKRBAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:00:18 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEBE73055C;
        Thu, 17 Nov 2022 17:00:16 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Nov 2022 09:59:11 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DC56420584CE;
        Fri, 18 Nov 2022 09:59:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 18 Nov 2022 09:59:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A165FB62A4;
        Fri, 18 Nov 2022 09:59:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: spi: Add Socionext F_OSPI controller bindings
Date:   Fri, 18 Nov 2022 09:59:03 +0900
Message-Id: <20221118005904.23557-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
References: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for Socionext F_OSPI SPI flash
controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/spi/socionext,f-ospi.yaml        | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml

diff --git a/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
new file mode 100644
index 000000000000..f52cac9ee9f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/socionext,f-ospi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Socionext F_OSPI controller
+
+description: |
+  The Socionext F_OSPI is a controller used to interface with flash
+  memories using the SPI communication interface.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: socionext,f-ospi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  num-cs:
+    minimum: 1
+    maximum: 4
+
+  socionext,cs-start-cycle:
+    description:
+      Specifies the number of SPI_CLK cycles between CS assertion and
+      command transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+
+  socionext,cs-end-cycle:
+    description:
+      Specify the number of SPI_CLK cycles between data transfer and
+      CS deassertion.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+
+  socionext,cs-deassert-clk-cycle:
+    description:
+      Specify the number of SPI_CLK cycles to output while CS is deasserted.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+
+  socionext,alternative-byte:
+    description:
+      Specify the extra bytes to transfer after address transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: the number of bytes to transfer
+        maximum: 4
+      - description: value to transfer
+        default: 0
+      - description: bit-width to transfer
+        enum: [0, 1, 2, 4, 8]
+
+  socionext,data-swap-2byte:
+    description:
+      Indicates swap byte order per 2-bytes.
+    type: boolean
+
+  socionext,data-swap-4byte:
+    description:
+      Indicates swap byte order per 4-bytes.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ospi0: spi@80000000 {
+        compatible = "socionext,f-ospi";
+        reg = <0x80000000 0x1000>;
+        clocks = <&clks 0>;
+        num-cs = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "spansion,s25fl128s", "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <50000000>;
+        };
+    };
-- 
2.25.1

