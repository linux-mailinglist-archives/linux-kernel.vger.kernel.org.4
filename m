Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B375ED037
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiI0WWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiI0WWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:22:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3AE1D6D14;
        Tue, 27 Sep 2022 15:22:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l12so12434212ljg.9;
        Tue, 27 Sep 2022 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P83+LYZ6oCMFcaq2X5lcAkn3XPHBb8SkpwqeCWUYvhM=;
        b=LuP37JcQfcP1oiBqQSCzTk5shuRoWIgdZRUi05dUkmzzbQwYDL/TA/YeKSN4G6S5cD
         wpHa/aE/E4UNOQnDTkJ5e0AMUhiYln5KxsUqfUwXiAWXiZA95q1bGjd9Uw5QOXg+AFRc
         77SFk7xCLAc717OKymVlM+2N9dXx0sF0lZBunUsTUxDsRY8FP1dg1VVCo/nYzowA0dZy
         9WuEfdubFSyIA259SbbwmMyUOU/dAS/NumOHRAVJEwwquzKw2qQILQ3frcvY/Bc9hmp0
         WQgWew+ZCDZlot6aRwRpd6dP7w3PpVmwrS6t0o8/5lAbBWbgoEUqGLE3xiB8HUS+74Gc
         oAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P83+LYZ6oCMFcaq2X5lcAkn3XPHBb8SkpwqeCWUYvhM=;
        b=IjUN4JcDLNPclmMeLjHt0rwdqBuDShpQ88iDUehaxXFhfv5i0Ji5d76MnrIM1CPeeG
         +3+PNBF63bT+pEilEAz777AyQVyav0qmgnPsuCnPmyVqFONThfIhoXyjuMDLxVEe0fbn
         j93EOtyAi/IL/DqwUBAKx3HloKkxYUZLrnq7//nlv5ZfkomUo7XNzOR2Gbzd+erqEyOP
         Dn1H6hHs8e8RuaBkEiuggItkCnJm+tt03wlf30wDsKQOo5Ke+0oimi5CTlT3RTn7QRIB
         9XpxUdfd5NLyN+D/w6129bmNeBUzcsiq03IO1dFPaxAh1wk7zFoGgpGUl945zJZxTNWu
         +RaA==
X-Gm-Message-State: ACrzQf2AcUQqglLQ6UpegO0gfthzlbZEFryvGY6NJ4TOG3VqMTVBu7TG
        4xyDedctM/6IVpFN3GnnCL/3xcKpNMyXCg==
X-Google-Smtp-Source: AMsMyM5qDziwT/GDOeQJACZ0HCajX5C8WoVdmXTBf8BI/aXO+mhs1FMEfyjGbebzfW4nCcXsttxSkA==
X-Received: by 2002:a2e:8014:0:b0:26a:d12c:3719 with SMTP id j20-20020a2e8014000000b0026ad12c3719mr10549188ljg.472.1664317341038;
        Tue, 27 Sep 2022 15:22:21 -0700 (PDT)
Received: from localhost ([37.1.42.233])
        by smtp.gmail.com with ESMTPSA id j16-20020ac253b0000000b00492e6642937sm277584lfh.200.2022.09.27.15.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:22:20 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shawn Tu <shawnx.tu@intel.com>, Arec Kao <arec.kao@intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] media: dt-bindings: i2c: document OV4689
Date:   Wed, 28 Sep 2022 01:21:33 +0300
Message-Id: <20220927222152.132951-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927222152.132951-1-mike.rudenko@gmail.com>
References: <20220927222152.132951-1-mike.rudenko@gmail.com>
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

Add device-tree binding documentation for OV4689 image sensor driver,
and the relevant MAINTAINERS entries.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 .../bindings/media/i2c/ovti,ov4689.yaml       | 134 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
new file mode 100644
index 000000000000..50579c947f3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV4689 CMOS
+
+maintainers:
+  - Mikhail Rudenko <mike.rudenko@gmail.com>
+
+description: |
+  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
+  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
+  at 2688x1520 resolution. It is programmable through an I2C
+  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
+  connection.
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov4689
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      External clock (XVCLK) for the sensor, 6-64 MHz
+    maxItems: 1
+
+  dovdd-supply:
+    description:
+      Digital I/O voltage supply, 1.7-3.0 V
+
+  avdd-supply:
+    description:
+      Analog voltage supply, 2.6-3.0 V
+
+  dvdd-supply:
+    description:
+      Digital core voltage supply, 1.1-1.3 V
+
+  powerdown-gpios:
+    description:
+      GPIO connected to the powerdown pin (active low)
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the reset pin (active low)
+
+  orientation: true
+
+  rotation: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description:
+      Output port node, single endpoint describing the CSI-2 transmitter
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov4689: camera@36 {
+            compatible = "ovti,ov4689";
+            reg = <0x36>;
+
+            clocks = <&ov4689_clk>;
+
+            avdd-supply = <&ov4689_avdd>;
+            dovdd-supply = <&ov4689_dovdd>;
+            dvdd-supply = <&ov4689_dvdd>;
+
+            powerdown-gpios = <&pio 107 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&pio 109 GPIO_ACTIVE_LOW>;
+
+            orientation = <2>;
+            rotation = <0>;
+
+            port {
+                wcam_out: endpoint {
+                    remote-endpoint = <&mipi_in_wcam>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <504000000>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a58f1fc6dd47..aed316c5c1ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15028,6 +15028,13 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov2740.c
 
+OMNIVISION OV4689 SENSOR DRIVER
+M:	Mikhail Rudenko <mike.rudenko@gmail.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
+
 OMNIVISION OV5640 SENSOR DRIVER
 M:	Steve Longerbeam <slongerbeam@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.37.3

