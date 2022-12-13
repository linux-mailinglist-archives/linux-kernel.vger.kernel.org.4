Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8916864B10E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiLMIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiLMIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:07 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D960E13D60;
        Tue, 13 Dec 2022 00:25:05 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 06B052059054;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:04 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5E9ECA855C;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 02/17] dt-bindings: reset: Fix node descriptions in uniphier-reset example
Date:   Tue, 13 Dec 2022 17:24:34 +0900
Message-Id: <20221213082449.2721-3-hayashi.kunihiko@socionext.com>
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
reset nodes to the generic names in the example.

And drop redundant examples and a parent node of the reset as it is not
directly necessary.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../reset/socionext,uniphier-glue-reset.yaml  | 23 +++-----
 .../reset/socionext,uniphier-reset.yaml       | 52 ++-----------------
 2 files changed, 11 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
index 0a2c13e1e230..fa253c518d79 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
@@ -95,19 +95,12 @@ required:
 
 examples:
   - |
-    usb-glue@65b00000 {
-        compatible = "simple-mfd";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0x65b00000 0x400>;
-
-        usb_rst: reset@0 {
-            compatible = "socionext,uniphier-ld20-usb3-reset";
-            reg = <0x0 0x4>;
-            #reset-cells = <1>;
-            clock-names = "link";
-            clocks = <&sys_clk 14>;
-            reset-names = "link";
-            resets = <&sys_rst 14>;
-        };
+    usb_rst: reset-controller@0 {
+        compatible = "socionext,uniphier-ld20-usb3-reset";
+        reg = <0x0 0x4>;
+        #reset-cells = <1>;
+        clock-names = "link";
+        clocks = <&sys_clk 14>;
+        reset-names = "link";
+        resets = <&sys_rst 14>;
     };
diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
index 6566804ec567..033b252a3dfe 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -66,53 +66,7 @@ required:
 
 examples:
   - |
-    sysctrl@61840000 {
-        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
-        reg = <0x61840000 0x4000>;
-
-        reset {
-            compatible = "socionext,uniphier-ld11-reset";
-            #reset-cells = <1>;
-        };
-
-        // other nodes ...
-    };
-
-  - |
-    mioctrl@59810000 {
-        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
-        reg = <0x59810000 0x800>;
-
-        reset {
-            compatible = "socionext,uniphier-ld11-mio-reset";
-            #reset-cells = <1>;
-        };
-
-        // other nodes ...
-    };
-
-  - |
-    perictrl@59820000 {
-        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
-        reg = <0x59820000 0x200>;
-
-        reset {
-            compatible = "socionext,uniphier-ld11-peri-reset";
-            #reset-cells = <1>;
-        };
-
-        // other nodes ...
-    };
-
-  - |
-    adamv@57920000 {
-        compatible = "socionext,uniphier-ld11-adamv", "simple-mfd", "syscon";
-        reg = <0x57920000 0x1000>;
-
-        reset {
-            compatible = "socionext,uniphier-ld11-adamv-reset";
-            #reset-cells = <1>;
-        };
-
-        // other nodes ...
+    reset-controller {
+        compatible = "socionext,uniphier-ld11-reset";
+        #reset-cells = <1>;
     };
-- 
2.25.1

