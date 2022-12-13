Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACC64B119
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiLMI0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiLMIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:10 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3ACB13E8B;
        Tue, 13 Dec 2022 00:25:08 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:06 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 156A72058B4F;
        Tue, 13 Dec 2022 17:25:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:06 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6832EA855C;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 14/17] dt-bindings: soc: socionext: Add UniPhier SD interface block
Date:   Tue, 13 Dec 2022 17:24:46 +0900
Message-Id: <20221213082449.2721-15-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding schema for the SD interface block implemented on
Socionext Uniphier SoCs.

This SD interface block is attached outside SDHC, and has some SD related
functions such as clock control, reset control, mode switch, and so on.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext/socionext,uniphier-sdctrl.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
new file mode 100644
index 000000000000..cb3b0d42739f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sdctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SD interface logic
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  SD interface logic implemented on Socionext UniPhier SoCs is
+  attached outside SDHC, and has some SD related functions such as
+  clock control, reset control, mode switch, and so on.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-pro5-sdctrl
+          - socionext,uniphier-pxs2-sdctrl
+          - socionext,uniphier-ld11-sdctrl
+          - socionext,uniphier-ld20-sdctrl
+          - socionext,uniphier-pxs3-sdctrl
+          - socionext,uniphier-nx1-sdctrl
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
+
+  reset-controller:
+    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@59810000 {
+        compatible = "socionext,uniphier-ld20-sdctrl",
+                     "simple-mfd", "syscon";
+        reg = <0x59810000 0x400>;
+
+        clock-controller {
+            compatible = "socionext,uniphier-ld20-sd-clock";
+            #clock-cells = <1>;
+        };
+
+        reset-controller {
+            compatible = "socionext,uniphier-ld20-sd-reset";
+            #reset-cells = <1>;
+        };
+    };
-- 
2.25.1

