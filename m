Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3C750C71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGLP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGLP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:28:07 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56D1BD5;
        Wed, 12 Jul 2023 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689175686;
  x=1720711686;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=HV2jebiOT6mQ2HdkOPhLHt3aK1bDvbiJCC1sTblJH5M=;
  b=dkNrtssclX51nFDUdqZgyelD1J0g5QUPFBm0Cl6Kxepd72WGhCOZFfVb
   x0tC4au7lzk77Z0D1AO5YJQ3pVn4SQFpq9UM8wcCCLQmQHEkPlG192adu
   +dItZADjgAa96CTDkxNl+UHMfmtWI9XYDtg0z5FxRFYmh78/aZ7NbUQi5
   0JNqyO5NnN/fmyRxyEbNBb0kg8OI1x6OQVCc/DKUNq6KVA5OFy+Dl3jmq
   cVXUhbyvLq+d52CCdgz3pppaiDhP9l60rrKBJHCAyp6X6Iy/9iJCorQtm
   l1S6Jh0Qbm86a7cedpkBCHmxJGMAsnlewq5B2301mK5r+r/iRxIEmHVh9
   w==;
References: <cover.1689174736.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iio: proximity: Add Murata IRS-D200
In-Reply-To: <cover.1689174736.git.waqar.hameed@axis.com>
Date:   Wed, 12 Jul 2023 17:12:16 +0200
Message-ID: <3b9b284effa7d63c5c3c022f0d51312052bbe62c.1689174736.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
for communication with interrupt support. Add devicetree bindings
requiring the compatible string, I2C slave address (reg), power supply
and interrupts.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/murata,irsd200.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
new file mode 100644
index 000000000000..67f5389ece67
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/murata,irsd200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Murata IRS-D200 PIR sensor
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description:
+  PIR sensor for human detection.
+
+properties:
+  compatible:
+    const: murata,irsd200
+
+  reg:
+    items:
+      - enum:
+          - 0x48
+          - 0x49
+        description: |
+          When the AD pin is connected to GND, the slave address is 0x48.
+          When the AD pin is connected to VDD, the slave address is 0x49.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Type should be IRQ_TYPE_EDGE_RISING.
+
+  vdd-supply:
+    description:
+      3.3 V supply voltage.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@48 {
+            compatible = "murata,irsd200";
+            reg = <0x48>;
+            interrupts = <24 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&regulator_3v3>;
+        };
+    };
+...
-- 
2.30.2

