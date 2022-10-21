Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9155607D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJURGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJURGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:06:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FDB17A9D;
        Fri, 21 Oct 2022 10:06:41 -0700 (PDT)
Received: from jupiter.universe (dyndsl-037-138-189-087.ewe-ip-backbone.de [37.138.189.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3A8C6602379;
        Fri, 21 Oct 2022 18:06:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666371999;
        bh=sw1g18/yluc+d5C+pFtuJQ2w1P1wFFgeoQWxi4j7g18=;
        h=From:To:Cc:Subject:Date:From;
        b=JyJVvVvIxHtP5Mbeqt8SLO3+c+P9j7Qg0/sS8HVUMW+x0hZr48N01/w/kR70CRBzb
         gfbWHOKXsuL2vNFYu7ULTvqFq0RJm4xcBklA2pWpJfqbWQwhJSJWt5/qlhgIBWlQ5z
         L5+8ofW1UWUZB14XiCGzxM5jQ0D/ewq1xs8onqw2Tz0lN1iXFXFEP+dWc7kPERX1e7
         kOKrAgKzWO43thKIAYdC2F8j2bZuCLUOU6bNFvty+to2XJMbmMM89vAspVE674w9UH
         Q6Ii9eWefZ94tJvHpgVAsV9ALV4Q6fMZj96o5jLAOilzYlhmU/NVxYCLF/9nQeMLqW
         9vsAhouisNNTA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id AEECF48082E; Fri, 21 Oct 2022 19:06:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to json-schema
Date:   Fri, 21 Oct 2022 19:06:05 +0200
Message-Id: <20221021170605.85163-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
Schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
 .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml

diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
deleted file mode 100644
index a8934fe2ab4c..000000000000
--- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Haoyu Microelectronics HYM8563 Real Time Clock
-
-The HYM8563 provides basic rtc and alarm functionality
-as well as a clock output of up to 32kHz.
-
-Required properties:
-- compatible: should be: "haoyu,hym8563"
-- reg: i2c address
-- #clock-cells: the value should be 0
-
-Optional properties:
-- clock-output-names: From common clock binding
-- interrupts: rtc alarm/event interrupt
-
-Example:
-
-hym8563: hym8563@51 {
-	compatible = "haoyu,hym8563";
-	reg = <0x51>;
-
-	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
-
-	#clock-cells = <0>;
-};
-
-device {
-...
-	clocks = <&hym8563>;
-...
-};
diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
new file mode 100644
index 000000000000..b0b6126b12dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Haoyu Microelectronics HYM8563 RTC
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    const: haoyu,hym8563
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    description: From common clock binding to override the default output clock name.
+
+  wakeup-source:
+    description: Enables wake up of host system on alarm.
+
+allOf:
+  - $ref: rtc.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "haoyu,hym8563";
+            reg = <0x51>;
+            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+            #clock-cells = <0>;
+        };
+    };
-- 
2.35.1

