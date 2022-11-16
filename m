Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07562CCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiKPVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiKPVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87F12AC5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a14so32249965wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXBfYsOqYyi9DKVQGkMLwQ+xTrxC76f34l8uPcGALOo=;
        b=eiQbC6iHeXf5Xfg/Q269SQ1ztubRIN/H3QkCewoUo/3ya5CJA6JsU9uD/8uzlAjuOb
         0tE0+TxRv4/J/noCDni/4id4fZJ6nt1/zgduLscE9NBDJONySDUJ+O02J0muh/kjvUAT
         IVflkNnETAHiEZX+Bsidlb1MLJThs+DEarvwIsCwN3yd63b7CFw9MyQ1Hf+tAuQWaByx
         i4xuyJUPVxLWInNm+8kDS+ep3uUuJkEcBgT84dQjNTp1ytJQJxtUzMZxi36Thlhgspy6
         dhjX4kj/MeTRLXihoYQfVeAPYe6NemsqHub3iXKmXWj1fMBbjhE71ZB5P29oP8dnUsh5
         F0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXBfYsOqYyi9DKVQGkMLwQ+xTrxC76f34l8uPcGALOo=;
        b=wBir0VLA+8hZ2aWoHxX0NbjsfzqPPr1YBiGD+Ir85Pq+HbFMRaQk22KcFsbHfn+HWm
         UINmGWGHBE9Uqq3bDif4N7G/+7RZS5h8NpF2yeWYbmFyLGegXW0EWT312Wstke13+1L/
         ZOO2iK08aS4nPRmV2sU0qCGRxUKqC6iyhH7uGz42yPNaU4SjfqzNwjhPPABlGf73t+8R
         FFTcspIpy3F5wpu0aYeaiWcSFOEi8bPY4IwT9NlSMnvpLm1iGypmginkvYwUvLsjgAmh
         gMS5OMS4I/t3xB2Ilh9cjvDzbVjGacCIRTIx+u1znbN7sHsVv7624WE6PzM/e5FP+nEx
         QtKQ==
X-Gm-Message-State: ANoB5pnl2GSGsZIhHRSKyIylCDxzNpHnxlvzEzg65wX3uM7AGRes2qQ9
        Bnn5w3Cnt4hPFGinyd+rFEaH3Q==
X-Google-Smtp-Source: AA0mqf78cAxaZbPsm+4fk/nmj7g0AofRhKfQCRZd15qxzJmqtMiho6IdJhwudQuHghLARqH06m2/cA==
X-Received: by 2002:a5d:40d1:0:b0:235:8867:50bf with SMTP id b17-20020a5d40d1000000b00235886750bfmr14919596wrq.193.1668634583032;
        Wed, 16 Nov 2022 13:36:23 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fn15-20020a05600c688f00b003b47ff307e1sm3133045wmb.31.2022.11.16.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:36:22 -0800 (PST)
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
Subject: [PATCH v6 2/3] dt-bindings: hwmon: Add binding for max6639
Date:   Wed, 16 Nov 2022 22:36:14 +0100
Message-Id: <20221116213615.1256297-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
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

