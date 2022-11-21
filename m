Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57CA63220D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKUMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiKUM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:29:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E82B4835
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso10504291wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXBfYsOqYyi9DKVQGkMLwQ+xTrxC76f34l8uPcGALOo=;
        b=JELAQz9MAi4uoy37dZHiOh6XxDEGeav/bvF7KWRnDdXtW3YYxBvyM9i4stLeQf29oa
         D7CT7JDQHuOP64oZeTGLhI3wSeUEA1P1CMbCFZw2/ciE9n08k1ihXvrOXlpAY+rPDAuf
         4SF+73wlTsCY1GjT2ss5727qzCo0oG6RPZFVk+BAu4xnCL9LrWafZZtMd+oazhnMOuRm
         gTsxDhUqh7BBrTafnsAEWNASSH+kPWPNhUatZ4TzKbbI4Dy0yOv6a2T4/lKAYBrlogJm
         W5zcwt3yuI9HLfohrG5vLj011t5rud8Zu/34Op6+Sbnwx1cRjRZIyvCul03eJtpUYwke
         cWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXBfYsOqYyi9DKVQGkMLwQ+xTrxC76f34l8uPcGALOo=;
        b=uqj/Rum2N/jHQa50k2z2oNuoB8fuiir3cPz52P72X7ZUO2qDeSNZQE+ThEKL2iimj2
         M/GabZ9ihgF1a1PZnx4r5cHH/nhfzDadRpnnDvPsALnjofrqE7rNtYsxYWqmF0An6nZ0
         KHObE8sgMvWiu8dqVZ8JCaxOcAEqXh34z17nzpPWuwnsBGQTOzmAYg7W3WAL9AF54mQi
         SENahHrL2NQCw4zesKT29PUQToRrhlfWBxWGoLkDmOO/j3luVQ+jvodySNPa24zjuIoe
         f8vvTHVSz+JYl/DGsYN0ON7lGBvQALurBxOLPggDuLhLVdY2Vl4+9RbSwkodmuGIjjU3
         Calw==
X-Gm-Message-State: ANoB5pmsNFTe5oUMT/7h9i9TOy95vlYGCWc7XPkktZRs3x1BXHMrAWPz
        eLlY618bt6XV4BJiNQkOZvl/xg==
X-Google-Smtp-Source: AA0mqf4XH9V8sdbo3Wa5OxqUSsLCHo9lUAp0ePH4OE0pdFtgYDPPw5MOEdUKBT6JpVe1Xk080uZ2pQ==
X-Received: by 2002:a05:600c:3b0c:b0:3cf:8df2:63b7 with SMTP id m12-20020a05600c3b0c00b003cf8df263b7mr15705649wms.11.1669033784349;
        Mon, 21 Nov 2022 04:29:44 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05600c654c00b003cf6c2f9513sm13929015wmb.2.2022.11.21.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:29:43 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v7 2/4] dt-bindings: hwmon: Add binding for max6639
Date:   Mon, 21 Nov 2022 13:29:30 +0100
Message-Id: <20221121122932.2493174-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

Add Devicetree binding documentation for Maxim MAX6639 temperature
monitor with PWM fan-speed controller.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/hwmon/maxim,max6639.yaml         | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..da040b11d2ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max6639
+
+maintainers:
+  - Roland Stigge <stigge@antcom.de>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#pwm-cells':
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^fan@[0-1]$":
+    type: object
+    description: |
+      Represents the two fans and their specific configuration.
+
+    $ref: fan-common.yaml#
+
+    properties:
+      reg:
+        description: |
+          The fan number.
+        items:
+          minimum: 0
+          maximum: 1
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fan1: fan-controller@10 {
+            compatible = "maxim,max6639";
+            reg = <0x10>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #pwm-cells = <3>;
+
+            fan@0 {
+                reg = <0x0>;
+                pulses-per-revolution = <2>;
+                max-rpm = <4000>;
+                target-rpm = <1000>;
+                pwms = <&fan1 0 25000 0>;
+            };
+
+            fan@1 {
+                reg = <0x1>;
+                pulses-per-revolution = <2>;
+                max-rpm = <8000>;
+                pwms = <&fan1 1 25000 0>;
+            };
+            };
+    };
+...
-- 
2.37.3

