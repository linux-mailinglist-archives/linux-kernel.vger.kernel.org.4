Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC2F64B118
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLMIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiLMIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:08 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E508713D60;
        Tue, 13 Dec 2022 00:25:07 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EB1042059054;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5056CA855C;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 08/17] dt-bindings: nvmem: Fix node descriptions in uniphier-efuse example
Date:   Tue, 13 Dec 2022 17:24:40 +0900
Message-Id: <20221213082449.2721-9-hayashi.kunihiko@socionext.com>
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

Prior to adding dt-bindings for SoC-dependent controllers, rename the
parent node to the generic name in the example.

And drop a parent node of the nvmem as it is not directly necessary here.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../nvmem/socionext,uniphier-efuse.yaml       | 101 ++++++++----------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index 2578e39deda9..a1dea3d7669c 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -31,65 +31,56 @@ unevaluatedProperties: false
 
 examples:
   - |
-    // The UniPhier eFuse should be a subnode of a "soc-glue" node.
+    efuse@100 {
+        compatible = "socionext,uniphier-efuse";
+        reg = <0x100 0x28>;
+    };
 
-    soc-glue@5f900000 {
-        compatible = "simple-mfd";
+    efuse@200 {
+        compatible = "socionext,uniphier-efuse";
+        reg = <0x200 0x68>;
         #address-cells = <1>;
         #size-cells = <1>;
-        ranges = <0x0 0x5f900000 0x2000>;
 
-        efuse@100 {
-            compatible = "socionext,uniphier-efuse";
-            reg = <0x100 0x28>;
+        /* Data cells */
+        usb_rterm0: trim@54,4 {
+            reg = <0x54 1>;
+            bits = <4 2>;
         };
-
-        efuse@200 {
-            compatible = "socionext,uniphier-efuse";
-            reg = <0x200 0x68>;
-            #address-cells = <1>;
-            #size-cells = <1>;
-
-            /* Data cells */
-            usb_rterm0: trim@54,4 {
-                reg = <0x54 1>;
-                bits = <4 2>;
-            };
-            usb_rterm1: trim@55,4 {
-                reg = <0x55 1>;
-                bits = <4 2>;
-            };
-            usb_rterm2: trim@58,4 {
-                reg = <0x58 1>;
-                bits = <4 2>;
-            };
-            usb_rterm3: trim@59,4 {
-                reg = <0x59 1>;
-                bits = <4 2>;
-            };
-            usb_sel_t0: trim@54,0 {
-                reg = <0x54 1>;
-                bits = <0 4>;
-            };
-            usb_sel_t1: trim@55,0 {
-                reg = <0x55 1>;
-                bits = <0 4>;
-            };
-            usb_sel_t2: trim@58,0 {
-                reg = <0x58 1>;
-                bits = <0 4>;
-            };
-            usb_sel_t3: trim@59,0 {
-                reg = <0x59 1>;
-                bits = <0 4>;
-            };
-            usb_hs_i0: trim@56,0 {
-                reg = <0x56 1>;
-                bits = <0 4>;
-            };
-            usb_hs_i2: trim@5a,0 {
-                reg = <0x5a 1>;
-                bits = <0 4>;
-            };
+        usb_rterm1: trim@55,4 {
+            reg = <0x55 1>;
+            bits = <4 2>;
+        };
+        usb_rterm2: trim@58,4 {
+            reg = <0x58 1>;
+            bits = <4 2>;
+        };
+        usb_rterm3: trim@59,4 {
+            reg = <0x59 1>;
+            bits = <4 2>;
+        };
+        usb_sel_t0: trim@54,0 {
+            reg = <0x54 1>;
+            bits = <0 4>;
+        };
+        usb_sel_t1: trim@55,0 {
+            reg = <0x55 1>;
+            bits = <0 4>;
+        };
+        usb_sel_t2: trim@58,0 {
+            reg = <0x58 1>;
+            bits = <0 4>;
+        };
+        usb_sel_t3: trim@59,0 {
+            reg = <0x59 1>;
+            bits = <0 4>;
+        };
+        usb_hs_i0: trim@56,0 {
+            reg = <0x56 1>;
+            bits = <0 4>;
+        };
+        usb_hs_i2: trim@5a,0 {
+            reg = <0x5a 1>;
+            bits = <0 4>;
         };
     };
-- 
2.25.1

