Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CF6B314E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCIWu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCIWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684BE841B;
        Thu,  9 Mar 2023 14:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A7B61D0E;
        Thu,  9 Mar 2023 22:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00744C4339B;
        Thu,  9 Mar 2023 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402246;
        bh=T2m9FARCQakjOu5gGr8+fVrNfdOmvCfKaWsccO+YD5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gb6Gm1T2ILsdxCDVZETBEkU1XPniS+tw2i2tNvRHqWSHCtpDASlciuF7JlasIYztt
         KvMj1iQqzSILJeO2NLlftJyev3Z5qJsYTw07/Ioe6l+SYLP9+g333TZs9cnQkZn7xu
         IXPeRG0FM/ROcBW2+kKjJuBL+qXNPtXzCHMlo7+QMD+GySgKM4uO5ReEOCbE0cPSh5
         OHSO38dbRsxYWThikticoYf6zSAxZO8sU116XvsOHayXMfwhz1RkNGC2cG1MgsOjie
         lzqpGaz/Cuo5sayivfXpNa7GOuSm9mXqq34nbmtPrLVx6Y2XozqJ/IMr4uKdcG7xtx
         0RffqHMV4Rm0Q==
Received: by mercury (Postfix, from userid 1000)
        id 6151C106069D; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 01/11] dt-bindings: power: supply: adc-battery: add binding
Date:   Thu,  9 Mar 2023 23:50:31 +0100
Message-Id: <20230309225041.477440-2-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for a battery that is only monitored via ADC
channels and simple status GPIOs.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/power/supply/adc-battery.yaml    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adc-battery.yaml b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
new file mode 100644
index 000000000000..9d478bf9d2ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/adc-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC battery
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Basic Battery, which only reports (in circuit) voltage and optionally
+  current via an ADC channel.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: adc-battery
+
+  charged-gpios:
+    description:
+      GPIO which signals that the battery is fully charged.
+    maxItems: 1
+
+  io-channels:
+    minItems: 1
+    maxItems: 3
+
+  io-channel-names:
+    oneOf:
+      - const: voltage
+      - items:
+          - const: voltage
+          - enum:
+              - current
+              - power
+      - items:
+          - const: voltage
+          - const: current
+          - const: power
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    fuel-gauge {
+        compatible = "adc-battery";
+        charged-gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
+        io-channels = <&adc 13>, <&adc 37>;
+        io-channel-names = "voltage", "current";
+
+        power-supplies = <&charger>;
+        monitored-battery = <&battery>;
+    };
-- 
2.39.2

