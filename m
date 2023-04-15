Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1C6E31C7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDOOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDOOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEB49E1;
        Sat, 15 Apr 2023 07:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B78960B21;
        Sat, 15 Apr 2023 14:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F73C433A4;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681568336;
        bh=jS0bpY0B94N3teaYRFeuB4DDITFUe3GUayl2qqATw4Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=LNEqNroCC6vOajujZb9dIYQ0z7DDXijLtYKlOQPj+KDUEcUYap53J74dT7yIz60cp
         Ytug0jO05So/92ZxfIULe35wdlW/v9bZu/OFg0us/r9S4PywKUc1XB7+05z3cfSy5t
         eh7YbQD8VWwrBQ5q2N4223Sp84faioecgDyZ7C5iP9Woao+vuNpt3a1/hrAYDQD2ZG
         8fxX59JOAqvj78iIPAGMU1XmuYp/brjRAqSAuS3SkwRm8D2zYNGd8QXagbL8Tybolg
         VLTpTegO6kN0lbhJVd9ZGzFF+zRKwsCLYEQGTc5NVk+2D1SJZ+AKaPYh13TJ8V9VU2
         hgkMN7FpPe8CA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B1032C77B70;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sat, 15 Apr 2023 22:18:46 +0800
Subject: [PATCH RFC 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to YAML
 and rename to histb-dw-mshc, add compatible of hi3798mv200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v1-3-db5b91d939d4@outlook.com>
References: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681568331; l=4836;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=2D/pBZCGAgmdlkmpqO4z/Qn0KjP4597p33+qioc0CGI=;
 b=KJ2kN9GGQjGE1Zfp9lP0qd6w9VrxShZz6xATYcFOjN9efHslM8Fg/Mvmb1tQm4GOpEK4gXWdF
 B7gusXCo1hKCdPU17hO8GB1o3Egx09cZ0kYKmLCJqEc8lB9VlzONOft
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV200 has an extra clock, also document it here.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ----------
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     | 90 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
deleted file mode 100644
index a0693b7145f2a..0000000000000
--- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
-specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-- compatible: Should contain "hisilicon,hi3798cv200-dw-mshc".
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed
-  in clock-names.
-- clock-names: Should contain the following:
-	"ciu" - The ciu clock described in synopsys-dw-mshc.txt.
-	"biu" - The biu clock described in synopsys-dw-mshc.txt.
-	"ciu-sample" - Hi3798CV200 extended phase clock for ciu sampling.
-	"ciu-drive"  - Hi3798CV200 extended phase clock for ciu driving.
-
-Example:
-
-	emmc: mmc@9830000 {
-		compatible = "hisilicon,hi3798cv200-dw-mshc";
-		reg = <0x9830000 0x10000>;
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&crg HISTB_MMC_CIU_CLK>,
-			 <&crg HISTB_MMC_BIU_CLK>,
-			 <&crg HISTB_MMC_SAMPLE_CLK>,
-			 <&crg HISTB_MMC_DRV_CLK>;
-		clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
-		fifo-depth = <256>;
-		clock-frequency = <200000000>;
-		cap-mmc-highspeed;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		non-removable;
-		bus-width = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
new file mode 100644
index 0000000000000..05a435185e9da
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+description:
+  The Synopsys designware mobile storage host controller is used to interface
+  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+  differences between the core Synopsys dw mshc controller properties described
+  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
+  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 5
+    description: A list of phandles for the clocks listed in clock-names
+
+  clock-names:
+    minItems: 4
+    items:
+      - const: ciu
+      - const: biu
+      - const: ciu-sample
+      - const: ciu-drive
+      - const: sap-dll-mode
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    emmc: mmc@9830000 {
+            compatible = "hisilicon,hi3798cv200-dw-mshc";
+            reg = <0x9830000 0x10000>;
+            interrupts = <35>;
+            clocks = <&crg 1>,
+                     <&crg 2>,
+                     <&crg 3>,
+                     <&crg 4>;
+            clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+            fifo-depth = <256>;
+            clock-frequency = <200000000>;
+            cap-mmc-highspeed;
+            mmc-ddr-1_8v;
+            mmc-hs200-1_8v;
+            non-removable;
+            bus-width = <8>;
+    };
+

-- 
2.39.2

