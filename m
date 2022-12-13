Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCAD64BF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiLMWnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiLMWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:43:32 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5D022291;
        Tue, 13 Dec 2022 14:43:30 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146060125"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 07:43:29 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D32DC40F4527;
        Wed, 14 Dec 2022 07:43:24 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/5] dt-bindings: power: reset: Add RZ/V2M PWC Power OFF bindings
Date:   Tue, 13 Dec 2022 22:43:07 +0000
Message-Id: <20221213224310.543243-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for the RZ/V2M PWC Power OFF driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../reset/renesas,rzv2m-pwc-poweroff.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
new file mode 100644
index 000000000000..12456e3e93e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M External Power Sequence Controller (PWC) Power OFF
+
+description: |+
+  The PWC IP found in the RZ/V2M family of chips comes with the below
+  capabilities
+    - external power supply on/off sequence generation
+    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
+    - key input signals processing
+    - general-purpose output pins
+  This node uses syscon to map the registers relevant to Power OFF (the
+  register map is retrieved from the parent dt-node), and the node should be
+  represented as a sub node of a "syscon", "simple-mfd" node.
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwc-poweroff # RZ/V2M
+          - renesas,r9a09g055-pwc-poweroff # RZ/V2MA
+      - const: renesas,rzv2m-pwc-poweroff
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the register map node.
+
+required:
+  - compatible
+  - regmap
+
+additionalProperties: false
+
+examples:
+  - |
+    poweroff {
+            compatible = "renesas,r9a09g011-pwc-poweroff",
+                         "renesas,rzv2m-pwc-poweroff";
+            regmap = <&regmapnode>;
+    };
-- 
2.34.1

