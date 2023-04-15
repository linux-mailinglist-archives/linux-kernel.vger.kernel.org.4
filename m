Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B776E32D2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDOROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDOROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA21BC3;
        Sat, 15 Apr 2023 10:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE606168E;
        Sat, 15 Apr 2023 17:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D82DC433A1;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681578846;
        bh=saJKbak66zJFATPAuanJ62qAZcL+5qkk0XwGqdYHsb4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dVB7EcOVecE63YwXtEf4eKs4cjEkcn90iSk2KMpBWvqp1qRFzTVTqGH+rY71ufFyK
         5OoG/dkbCJAelnl1z2uLglMf9zIXWYj8bOuPQchAZmx548V71UI0Sq+xd+EYMVvKKI
         18LVqansUl165uVV4+/ZMsedVRgQtjQeq5glB4YLF6A9vXH/ea9GyTQ2HqqxsD1JHu
         I4s3gFkjdSCVPdMtisMsB7ZR3YUO2KU0GwGpWY+eYUEzaUqR7n70FvodAI0NWXiQQP
         wyNEx6pewKvwcd/0eROYAcGMS1TP4leaIya3SHWUGZfFOGpZ2KsAfOnlwLQkni0wX6
         Cp48zE7BpB0Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 54DFEC77B78;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 01:13:18 +0800
Subject: [PATCH RFC v2 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v2-3-1d274f9b71da@outlook.com>
References: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681578841; l=4832;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=JIt1WKO/E/jF6bqUj7ql5V34Mtu9RTATejU7vIuUpXk=;
 b=u+DeFJqw2haCSzMfeqhvP2+DgCHXLB0jvJLFSB40eogHx+N9bppnzPPJx/MzKvlvlMTaaDB6y
 OKF8RVoe8f1AkohL1hka/dk8TBQtRha+8gG7Ln7nWYAvebbeBgIxA+B
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 0000000000000..ea377bd5ea4bf
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
+  Hisilicon HiSTB SoC specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+description:
+  The Synopsys designware mobile storage host controller is used to interface a
+  SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+  differences between the core Synopsys dw mshc controller properties described
+  by synopsys-dw-mshc.txt and the properties used by the Hisilicon HiSTB SoC
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

