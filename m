Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39063BE14
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiK2Kf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2KfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:35:21 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E11715A18;
        Tue, 29 Nov 2022 02:35:20 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Nov 2022 19:35:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 971D0205D901;
        Tue, 29 Nov 2022 19:35:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Nov 2022 19:35:17 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3E9BEA8556;
        Tue, 29 Nov 2022 19:35:17 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 6/8] dt-bindings: soc: socionext: Add UniPhier ADAMV block
Date:   Tue, 29 Nov 2022 19:35:07 +0900
Message-Id: <20221129103509.9958-7-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding schema for the ADAMV block implemented on Socionext
Uniphier SoCs.

The ADAMV block is analog signal amplifier that is a part of the external
video and audio I/O system. This block is implemented on LD11 and LD20,
and this is defined for controlling audio I/O reset only.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext/socionext,uniphier-adamv.yaml   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
new file mode 100644
index 000000000000..ae806960b3f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-adamv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier ADAMV block
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  ADAMV block implemented on Socionext UniPhier SoCs is an analog signal
+  amplifier that is a part of the external video and audio I/O system.
+
+  This block is defined for controlling audio I/O reset only.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld11-adamv
+          - socionext,uniphier-ld20-adamv
+          - socionext,uniphier-adamv
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+patternProperties:
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
+    syscon@57920000 {
+        compatible = "socionext,uniphier-ld20-adamv",
+                     "simple-mfd", "syscon";
+        reg = <0x57920000 0x1000>;
+
+        reset-controller {
+            compatible = "socionext,uniphier-ld20-adamv-reset";
+            #reset-cells = <1>;
+        };
+    };
-- 
2.25.1

