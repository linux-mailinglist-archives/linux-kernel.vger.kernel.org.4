Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1D733475
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjFPPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjFPPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:13:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD33581;
        Fri, 16 Jun 2023 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686928409;
  x=1718464409;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=BuJWD6MDEmgPeXDb5794LN9Pv82aJsMiwAk15GVPLck=;
  b=fEeHnF6roftz+0JFxpjLDFMyAFMGISh+UdGR+xlsPVsOgT/Zuq9ZKSGu
   4aKP+FGQCXcN03q1ohT7hx0LbitjAxhvBpqgGd3UpjFc/T/hhRYcjjFpa
   +GCcK25eyrVAvBk7H4O1VKZC0vNRifARtCPqj4lFgHXeIgBBESZrJtv4h
   7Rq/A96xkW71HUFR9c66Cr445384BH+q8LcZ8uqkfVWw+2OIItL11qEHI
   TT7/mCWXmVJg3tLvgAwPHULVLFjkLLsyAKJUZkKa2heJZtEb3z9zOgQ46
   0P1BYLMDFb5H3apdSVoA4ZBIHE2xbNumrkkRWUkyc0c3EDRbbUqpJHtGb
   g==;
References: <cover.1686926857.git.waqarh@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH 1/2] dt-bindings: iio: proximity: Add bindings for Murata
 IRS-D200
In-Reply-To: <cover.1686926857.git.waqarh@axis.com>
Date:   Fri, 16 Jun 2023 17:10:42 +0200
Message-ID: <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
for communication with interrupt support. Add devicetree bindings
requiring the compatible string, I2C slave address (reg) and interrupts.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/murata,irsd200.yaml         | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
new file mode 100644
index 000000000000..d317fbe7bd50
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
@@ -0,0 +1,54 @@
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
+description: |
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
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        pir@48 {
+            compatible = "murata,irsd200";
+            reg = <0x48>;
+            interrupts = <24 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
-- 
2.30.2

