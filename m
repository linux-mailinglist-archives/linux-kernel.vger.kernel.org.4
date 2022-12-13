Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32664B10A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiLMIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiLMIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:06 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1E9B4B4;
        Tue, 13 Dec 2022 00:25:05 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 072252058B4F;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 832031CDE;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 03/17] dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl example
Date:   Tue, 13 Dec 2022 17:24:35 +0900
Message-Id: <20221213082449.2721-4-hayashi.kunihiko@socionext.com>
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

Drop parent node of the pinctrl as it is not directly necessary, and
add more examples, that is "groups", "function", and a child node to set
pin attributes, to express this pinctrl node in detail.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../pinctrl/socionext,uniphier-pinctrl.yaml     | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
index 14a8c0215cc6..bc34e2c872bc 100644
--- a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
@@ -69,11 +70,17 @@ examples:
   - |
     // The UniPhier pinctrl should be a subnode of a "syscon" compatible node.
 
-    soc-glue@5f800000 {
-        compatible = "socionext,uniphier-pro4-soc-glue", "simple-mfd", "syscon";
-        reg = <0x5f800000 0x2000>;
+    pinctrl {
+        compatible = "socionext,uniphier-ld20-pinctrl";
+
+        pinctrl_ether_rgmii: ether-rgmii {
+            groups = "ether_rgmii";
+            function = "ether_rgmii";
 
-        pinctrl: pinctrl {
-            compatible = "socionext,uniphier-pro4-pinctrl";
+            tx {
+                pins = "RGMII_TXCLK", "RGMII_TXD0", "RGMII_TXD1",
+                       "RGMII_TXD2", "RGMII_TXD3", "RGMII_TXCTL";
+                drive-strength = <9>;
+            };
         };
     };
-- 
2.25.1

