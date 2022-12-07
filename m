Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC46453A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLGFyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLGFyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:33 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D977558BE5;
        Tue,  6 Dec 2022 21:54:30 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 44CCF2059054;
        Wed,  7 Dec 2022 14:54:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0FC4FA6B9C;
        Wed,  7 Dec 2022 14:54:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 02/16] dt-bindings: reset: Fix node descriptions in uniphier-reset example
Date:   Wed,  7 Dec 2022 14:53:51 +0900
Message-Id: <20221207055405.30940-3-hayashi.kunihiko@socionext.com>
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

Prior to adding dt-bindings for SoC-dependent controllers, rename the
reset nodes and their parent nodes to the generic names in the example.

And also add the missing compatible string.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../reset/socionext,uniphier-glue-reset.yaml  |  7 +++--
 .../reset/socionext,uniphier-reset.yaml       | 28 +++++++++++--------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
index 0a2c13e1e230..e6c6cb2ab8b8 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
@@ -95,13 +95,14 @@ required:
 
 examples:
   - |
-    usb-glue@65b00000 {
-        compatible = "simple-mfd";
+    usb@65b00000 {
+        compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
+        reg = <0x65b00000 0x400>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0 0x65b00000 0x400>;
 
-        usb_rst: reset@0 {
+        usb_rst: reset-controller@0 {
             compatible = "socionext,uniphier-ld20-usb3-reset";
             reg = <0x0 0x4>;
             #reset-cells = <1>;
diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
index 6566804ec567..c8abc44582a7 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -66,11 +66,12 @@ required:
 
 examples:
   - |
-    sysctrl@61840000 {
-        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
+    syscon@61840000 {
+        compatible = "socionext,uniphier-ld11-sysctrl",
+                     "simple-mfd", "syscon";
         reg = <0x61840000 0x4000>;
 
-        reset {
+        reset-controller {
             compatible = "socionext,uniphier-ld11-reset";
             #reset-cells = <1>;
         };
@@ -79,11 +80,12 @@ examples:
     };
 
   - |
-    mioctrl@59810000 {
-        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
+    syscon@59810000 {
+        compatible = "socionext,uniphier-ld11-mioctrl",
+                     "simple-mfd", "syscon";
         reg = <0x59810000 0x800>;
 
-        reset {
+        reset-controller {
             compatible = "socionext,uniphier-ld11-mio-reset";
             #reset-cells = <1>;
         };
@@ -92,11 +94,12 @@ examples:
     };
 
   - |
-    perictrl@59820000 {
-        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
+    syscon@59820000 {
+        compatible = "socionext,uniphier-ld11-perictrl",
+                     "simple-mfd", "syscon";
         reg = <0x59820000 0x200>;
 
-        reset {
+        reset-controller {
             compatible = "socionext,uniphier-ld11-peri-reset";
             #reset-cells = <1>;
         };
@@ -105,11 +108,12 @@ examples:
     };
 
   - |
-    adamv@57920000 {
-        compatible = "socionext,uniphier-ld11-adamv", "simple-mfd", "syscon";
+    syscon@57920000 {
+        compatible = "socionext,uniphier-ld11-adamv",
+                     "simple-mfd", "syscon";
         reg = <0x57920000 0x1000>;
 
-        reset {
+        reset-controller {
             compatible = "socionext,uniphier-ld11-adamv-reset";
             #reset-cells = <1>;
         };
-- 
2.25.1

