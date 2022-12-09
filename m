Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895C5648786
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLIRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLIRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:16:34 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58B45EE4;
        Fri,  9 Dec 2022 09:16:27 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id k189so5094521oif.7;
        Fri, 09 Dec 2022 09:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN7a2U3mP8Yzw7PGpnN4K9XOjRgKV4cZBsjjvOGf8hc=;
        b=qby6yrnonrMtj53Z0laDgk7BPazKLYuo3rN3QkhGDltRUv+tPYOy6mcgNOEnpOzl7w
         EBW7PCu8UXIKzAQ7nLfHHail4uE88Snc8Tcd/CPHPOYSDKfVacV9akjVGvb/1WAB2+sd
         N9xaWkjoohs03p2bnnD1gTxeS5TOscuaisyvnyi+ZoUqdF8oXNF9HfpI4it2ympNZdF7
         vChBjTIYNfaQSmXePB+o3K5XRO6noNDdCs0m3Sr1h1YbykDdGebvUI6ACUusjw1L8mAE
         mQkSVzth/OZBybUbJZsHufBVhFoKhkCZjyC/lD7OxbS0p6Bv0PIdou9WDGCoiAxU97jV
         Vevg==
X-Gm-Message-State: ANoB5pmNvHYagB2m4xEvjEo19h0JlvoRjqLcpox2hf77VccpynJY8O12
        v9UQBTzov8dy5fO+fz3tEg==
X-Google-Smtp-Source: AA0mqf5xEiTgvWdhcmihWNanSXd90w2tH05SA/9hCOzJQTAJUBmBSr/sRJkLKOPQIdsdNPyk/s+cSw==
X-Received: by 2002:aca:d745:0:b0:35a:d192:9a53 with SMTP id o66-20020acad745000000b0035ad1929a53mr2562546oig.41.1670606186740;
        Fri, 09 Dec 2022 09:16:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v19-20020a056808005300b00359ad661d3csm703986oic.30.2022.12.09.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:16:26 -0800 (PST)
Received: (nullmailer pid 3351352 invoked by uid 1000);
        Fri, 09 Dec 2022 17:16:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Convert Fujitsu SDHCI to DT schema
Date:   Fri,  9 Dec 2022 11:16:21 -0600
Message-Id: <20221209171621.3351220-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Fujitsu SDHCI binding to DT schema format.

The interrupts were not documented. The driver only uses the first
interrupt, but the DT and example have 2 interrupts. The 2nd one is
unknown. "dma-coherent" was also not documented, but is used.

The "socionext,synquacer-sdhci" compatible was not documented, but it is
compatible with "fujitsu,mb86s70-sdhci-3.0.yaml" and is in use (in
u-boot Synquacer dts).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mmc/fujitsu,mb86s70-sdhci-3.0.yaml        | 67 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 ---------
 2 files changed, 67 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt

diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
new file mode 100644
index 000000000000..0218a6ce4b2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fujitsu,mb86s70-sdhci-3.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fujitsu SDHCI controller
+
+maintainers:
+  - Vincent Yang <Vincent.Yang@tw.fujitsu.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: socionext,synquacer-sdhci
+          - const: fujitsu,mb86s70-sdhci-3.0
+      - const: fujitsu,mb86s70-sdhci-3.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Interface clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 2
+
+  fujitsu,cmd-dat-delay-select:
+    type: boolean
+    description: Indicating that the host requires the CMD_DAT_DELAY control
+      to be enabled.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@36600000 {
+        compatible = "fujitsu,mb86s70-sdhci-3.0";
+        reg = <0x36600000 0x1000>;
+        interrupts = <0 172 0x4>,
+               <0 173 0x4>;
+        bus-width = <4>;
+        vqmmc-supply = <&vccq_sdhci1>;
+        clocks = <&clock 2 2 0>, <&clock 2 3 0>;
+        clock-names = "core", "iface";
+    };
+...
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
2.35.1

