Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EA6712C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjAREp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAREp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA35828A;
        Tue, 17 Jan 2023 20:45:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so35692852pll.9;
        Tue, 17 Jan 2023 20:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9wEzdn/c8hs3xBU3OhkMlpPcDlGtL5RVLAepqVXl6k=;
        b=NoE/U94AsD+nnLqS+qyPulEfwZ6sTlpux/8dEzgM5sVE10YacMHwL/POKz6F744lNw
         E95VHpCINwOpN6j0fvHU2iqNSb8yO9WqbHeRVM/+LPnoAoPdWiydWTw+PfgBs/Hbf/vK
         IZoAl111CVJHa3nT+AoG/TWPuUSs/2buJRjrmYl355FjZadYJPRVwEAvxeWlGWIVhbcH
         6Vw5/MxSGpAbk0HxkDvOD+M2Fc660onxKYqGvuMJOL0PwgUXDlAxcsxyZWHVk6dj1zip
         c48JmGa8yjKifc2EGERR3GxkaYJj8gQAGliYo/SqTYcx7J7lbQY3xq4cnIF8TBJC/irw
         rl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9wEzdn/c8hs3xBU3OhkMlpPcDlGtL5RVLAepqVXl6k=;
        b=leo9QajN2c9uQlmV88rHBTbDJ3FkkhsAdvQJdetbXT7dr0N6cMceuFwVyBaSU4wmG4
         ZhdoTnXV7uqYO6kwvUPtodOWVA/0ZFcO20U9ISiSwMdsY9YQnnTJhWPdfd7e7TAzU8e/
         tefU/QvWSv6WnJ0wWqjJgtlxIs9Nh13ppvD8vCESULCnLsFkD+30eCNommSX2J1mRkqO
         5gawQqsYKWPq3kVHyoIx4rV2Vu+pirtEshvYEvZfBjXrOOwWBZrDEIgDDp2+kR+298cZ
         4kXgFZCtulyN1HejqMEvq9HBxzByLGtX3AYdJD3g9dBFTIwOuKhGde3FkczRgiI+A6k5
         gikA==
X-Gm-Message-State: AFqh2kpb6FW7ALuLfXTd1OHPGpsSpeNTFkoGzT7sHXghtSWufGuldD/Y
        4LVfQlxHlcJ8RYBB9RXtQKCaMKClE14=
X-Google-Smtp-Source: AMrXdXvKywVQxAnIW9BTyCOwR8hLsk1e+HSxDANbUVb82JskdxL3cpHUWELs3aDIuvWhv+HJOLhYag==
X-Received: by 2002:a05:6a20:1611:b0:b5:d50a:4aad with SMTP id l17-20020a056a20161100b000b5d50a4aadmr7989744pzj.39.1674017111729;
        Tue, 17 Jan 2023 20:45:11 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:45:11 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] dt-bindings: usb: Add binding for Via lab VL817 hub controller
Date:   Wed, 18 Jan 2023 04:44:14 +0000
Message-Id: <20230118044418.875-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIA Lab VL817 is a USB 3.1 Gen 1 hub and USB 2.0 hub
controller that features 4 downstream ports and 1 otg, with
an internal 5V regulator and has external reset pin.

Add a device tree binding for its USB protocol part.
The internal LDO is not covered by this and can just be modelled
as a fixed regulator.

Add combo of USB 2.0 and USB 3.0 root hub using peer-hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2 - fix the compatible string and fix the $id
   - update the commit message.
   - update the example for use peer-hub node because it
     combo of USB 2.0 and USB 3.0 hub.
   - rename the yaml file from vialab,vl817q7.yaml to vialab,vl817.yaml
     as q7 suffix is ued for USB 3.1 and q5 suffix is used for USB 2.0.
---
 .../devicetree/bindings/usb/vialab,vl817.yaml | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817.yaml

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
new file mode 100644
index 000000000000..5f9771e22058
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/vialab,vl817.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Via labs VL817 USB 3.1 hub controller
+
+maintainers:
+  - Anand Moon <linux.amoon@gmail.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - usb2109,2817
+          - usb2109,817
+
+  reg: true
+
+  reset-gpios:
+    description: GPIO controlling the RESET# pin.
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+  peer-hub:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      phandle to the peer hub on the controller.
+
+required:
+  - peer-hub
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb2109,2817";
+            reg = <1>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+        };
+
+        /* 3.1 hub on port 4 */
+        hub_3_0: hub@2 {
+            compatible = "usb2109,817";
+            reg = <2>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.38.1

