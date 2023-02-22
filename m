Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3B69F883
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjBVP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBVP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:59:19 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1FF21950;
        Wed, 22 Feb 2023 07:59:17 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Feb 2023 00:59:16 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id C853A2058B4F;
        Thu, 23 Feb 2023 00:59:16 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 23 Feb 2023 00:59:16 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 03D6DC34A;
        Thu, 23 Feb 2023 00:59:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Date:   Thu, 23 Feb 2023 00:59:06 +0900
Message-Id: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UniPhier SATA controller compatible string to the platform binding.
This controller needs three reset controls for Pro4 SoC, or two reset
controls for PXs2 and PXs3 SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/ata/ahci-platform.yaml           | 49 +++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

Changes since v3:
- Fix the position of resets and allOf properties
- Add reset descriptions
- Separate if conditions for two resets, three resets, and others

Changes since v2:
- Add compatible strings to select property
- Add minItems and change maxItems for resets
- Move condition schema under allOf property
- Change resets to "required" for uniphier-*-ahci

Changes since v1:
- Restrict resets property changes with compatible strings
- Fix maxItems from two to three

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 7dc2a2e8f598..358617115bb8 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,12 +30,12 @@ select:
           - marvell,armada-3700-ahci
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
+          - socionext,uniphier-pro4-ahci
+          - socionext,uniphier-pxs2-ahci
+          - socionext,uniphier-pxs3-ahci
   required:
     - compatible
 
-allOf:
-  - $ref: "ahci-common.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -45,6 +45,9 @@ properties:
               - marvell,armada-8k-ahci
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
+              - socionext,uniphier-pro4-ahci
+              - socionext,uniphier-pxs2-ahci
+              - socionext,uniphier-pxs3-ahci
           - const: generic-ahci
       - enum:
           - cavium,octeon-7130-ahci
@@ -74,7 +77,8 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
 patternProperties:
   "^sata-port@[0-9a-f]+$":
@@ -91,6 +95,43 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: ahci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pro4-ahci
+    then:
+      properties:
+        resets:
+          items:
+            - description: reset line for the parent
+            - description: reset line for the glue logic
+            - description: reset line for the controller
+      required:
+        - resets
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - socionext,uniphier-pxs2-ahci
+                - socionext,uniphier-pxs3-ahci
+      then:
+        properties:
+          resets:
+            items:
+              - description: reset for the glue logic
+              - description: reset for the controller
+        required:
+          - resets
+      else:
+        properties:
+          resets:
+            maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

