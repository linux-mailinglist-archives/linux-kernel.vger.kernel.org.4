Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171806453B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLGFzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLGFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:37 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0313D58BE4;
        Tue,  6 Dec 2022 21:54:34 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:32 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 53C352058B4F;
        Wed,  7 Dec 2022 14:54:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:32 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C7B821DA5;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 13/16] dt-bindings: soc: socionext: Add UniPhier SD interface block
Date:   Wed,  7 Dec 2022 14:54:02 +0900
Message-Id: <20221207055405.30940-14-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
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
 .../socionext/socionext,uniphier-sdctrl.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
new file mode 100644
index 000000000000..af73f7f3f8d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
@@ -0,0 +1,62 @@
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
+patternProperties:
+  "^clock-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
+
+  "^reset-controller(@[0-9a-f]+)?$":
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

