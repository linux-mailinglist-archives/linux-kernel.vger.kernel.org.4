Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7806A6254F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiKKIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKKIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:10:39 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B0EC65875;
        Fri, 11 Nov 2022 00:10:38 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:10:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4B25C2059027;
        Fri, 11 Nov 2022 17:10:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:10:37 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BDE32B62A4;
        Fri, 11 Nov 2022 17:10:36 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/6] dt-bindings: mmc: Convert sdhci-fujitsu to JSON schema
Date:   Fri, 11 Nov 2022 17:10:28 +0900
Message-Id: <20221111081033.3813-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Fujitsu SDHCI controller IP binding to DT schema format,
and add resets property as optional to support reset control.

Cc: devicetree@vger.kernel.org
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml   | 55 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 -----------
 2 files changed, 55 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt

diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
new file mode 100644
index 000000000000..85bfaadb0479
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fujitsu,sdhci-fujitsu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fujitsu SDHCI controller (F_SDH30)
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: fujitsu,mb86s70-sdhci-3.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+
+  resets:
+    maxItems: 1
+
+  fujitsu,cmd-dat-delay-select:
+    type: boolean
+    description: |
+      Indicating that this host requires the CMD_DAT_DELAY control to be enabled
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    sdhci1: mmc@36600000 {
+        compatible = "fujitsu,mb86s70-sdhci-3.0";
+        reg = <0x36600000 0x1000>;
+        bus-width = <4>;
+        vqmmc-supply = <&vccq_sdhci1>;
+        clocks = <&clock 2 2 0>, <&clock 2 3 0>;
+        clock-names = "iface", "core";
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
deleted file mode 100644
index 3ee9263adf73..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Fujitsu SDHCI controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci_f_sdh30 driver.
-
-Required properties:
-- compatible: "fujitsu,mb86s70-sdhci-3.0"
-- clocks: Must contain an entry for each entry in clock-names. It is a
-  list of phandles and clock-specifier pairs.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Should contain the following two entries:
-	"iface" - clock used for sdhci interface
-	"core"  - core clock for sdhci controller
-
-Optional properties:
-- vqmmc-supply: phandle to the regulator device tree node, mentioned
-  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
-- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
-  requires the CMD_DAT_DELAY control to be enabled.
-
-Example:
-
-	sdhci1: mmc@36600000 {
-		compatible = "fujitsu,mb86s70-sdhci-3.0";
-		reg = <0 0x36600000 0x1000>;
-		interrupts = <0 172 0x4>,
-			     <0 173 0x4>;
-		bus-width = <4>;
-		vqmmc-supply = <&vccq_sdhci1>;
-		clocks = <&clock 2 2 0>, <&clock 2 3 0>;
-		clock-names = "iface", "core";
-	};
-- 
2.25.1

