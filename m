Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B36BA2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCNWz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCNWzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:55:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E439CC0;
        Tue, 14 Mar 2023 15:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 382E7B81BFF;
        Tue, 14 Mar 2023 22:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9900AC433D2;
        Tue, 14 Mar 2023 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834539;
        bh=w+RHxqT9n38mgW/95l4s9XF2bsYwf020rGPTQmbmzcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o09AGfXyvdqszwdCTVsMaIIPcjR9MQc0MNhPDsiMn2q2HEq4ZiqswaRkf+XdMqEgK
         1tW5EQVBifPZC82jujAzTqlTNB8ITmNSal2dBccbT5oSjkZPPHfzhNTvBhMxEhHUhz
         Ta/tfimJWP3XoMo4rdt7RYPBt0cmpFA/5W4B0r99oOjAEQinZ83LbWE6trm1s2alYc
         HDSHMWaDcXUNw3PcoYoDZkZ+C1gQ1xiMY+4DiPzyMV5WrUhjj6gO9lJGSPNiXL81wz
         TuWiRnFJQgfiniUeupWwNV92u1SRlGQvsVHWxBHLlhZEvzidc5OVmpMyfK9ILdlZtK
         y9gyIUxza0YbA==
Received: by mercury (Postfix, from userid 1000)
        id D35AA10605A2; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv2 01/12] dt-bindings: power: supply: adc-battery: add binding
Date:   Tue, 14 Mar 2023 23:55:24 +0100
Message-Id: <20230314225535.1321736-2-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314225535.1321736-1-sre@kernel.org>
References: <20230314225535.1321736-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for a battery that is only monitored via ADC
channels and simple status GPIOs.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/power/supply/adc-battery.yaml    | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adc-battery.yaml b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
new file mode 100644
index 000000000000..ed9702caedff
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
@@ -0,0 +1,70 @@
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
+description:
+  Basic battery capacity meter, which only reports basic battery data
+  via ADC channels and optionally indicate that the battery is full by
+  polling a GPIO line.
+
+  The voltage is expected to be measured between the battery terminals
+  and mandatory. The optional current/power channel is expected to
+  monitor the current/power flowing out of the battery. Last but not
+  least the temperature channel is supposed to measure the battery
+  temperature.
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
+      GPIO which signals that the battery is fully charged. The GPIO is
+      often provided by charger ICs, that are not software controllable.
+    maxItems: 1
+
+  io-channels:
+    minItems: 1
+    maxItems: 4
+
+  io-channel-names:
+    minItems: 1
+    items:
+      - const: voltage
+      - enum: [ current, power, temperature ]
+      - enum: [ power, temperature ]
+      - const: temperature
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

