Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2635F1160
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiI3SJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiI3SIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:43 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72F1D7BFC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:08:34 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 300D53F342;
        Fri, 30 Sep 2022 20:08:30 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: display/panel: Add Sony Tama TD4353 JDI display panel
Date:   Fri, 30 Sep 2022 20:08:10 +0200
Message-Id: <20220930180812.32210-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
Compact smartphones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v2:
- preset -> panel-reset
- treset -> touch-reset
 .../display/panel/sony,td4353-jdi.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
new file mode 100644
index 000000000000..b6b885b4c22d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sony,td4353-jdi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
+  MIPI-DSI panel, used in Xperia XZ2 and XZ2 Compact smartphones.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sony,td4353-jdi-tama
+
+  reg: true
+
+  backlight: true
+
+  vddio-supply:
+    description: VDDIO 1.8V supply
+
+  vsp-supply:
+    description: Positive 5.5V supply
+
+  vsn-supply:
+    description: Negative 5.5V supply
+
+  panel-reset-gpios:
+    description: Display panel reset pin
+
+  touch-reset-gpios:
+    description: Touch panel reset pin
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - panel-reset-gpios
+  - touch-reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "sony,td4353-jdi-tama";
+            reg = <0>;
+
+            backlight = <&pmi8998_wled>;
+            vddio-supply = <&vreg_l14a_1p8>;
+            vsp-supply = <&lab>;
+            vsn-supply = <&ibb>;
+            panel-reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+            touch-reset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.37.3

