Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8875B50FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIKUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIKUCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 16:02:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62E25594;
        Sun, 11 Sep 2022 13:02:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p5so8285028ljc.13;
        Sun, 11 Sep 2022 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hac/Kdjm2o7byGAJT2L497Jmi790dhJOakC2FH9d140=;
        b=dLIFr2usPO/R82hmSP+AHrEFXMheVJ6VOciLKZ4cCwEOdnxwszcUTDIEAeUrl9sCwu
         Qgemur7xMjS36MTg/nAvpKrZKhta9eT0FxUmtUrurEjnjrS6P+VN98h24PlKZG0AVjZZ
         +xKI1/2s9wg6axc46Xew7yYNjstMij9YjO1zNMwuNuDGUlNNbUZiqoSeg6ujUF2LTKwq
         TCz0lg8ITFUvB+tKrAL/H6ceTulfWJl0CGVXHxbT/IKOgOlqC0HxDSujRwkRvrqYB7sY
         isnqD8TYekrm+bnZEOVf44iXbwMehldrUbZvlCVDzeDmpaTl3g3o2dgcckQLK77DDg7g
         GpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hac/Kdjm2o7byGAJT2L497Jmi790dhJOakC2FH9d140=;
        b=bzqRQndHH0m+g1C065JtMqDh2XYhO6qZtdiYKAQouIhe+wnAESOu6EqyUqvrKV8mfn
         U08CWMy3NJ4psKUi62moZaFpX+6o1ZE29fRzA8mKPT2gjzpRGYGtWItiMihV1K6d5k9h
         1DZQzquvvsuDqBZbpd/9g2aw/0r3zmij+WA5IbwluQj3QLXW1FMNWfnzHa0NSvkSrgZV
         Kq1YE4z3wfUA5sITj2MeXyU86vm68rjsPq9OG0LzGUUNrH/w8GaTQLer6qHq0izF0EY6
         fvQ0bhW0wTSGAYamCXWwUp79ZX/4LPhnOOZK7fmFfpsnFi3T0TMbfeT9xhlT6rvjqhDy
         HfYA==
X-Gm-Message-State: ACgBeo0p2X6ruMugDPjbX0Fa/dE2h9eHy6GuHcBHhLejeHgM7lVuFjfR
        C1i+Xty8edCjfYRuQM6kd44=
X-Google-Smtp-Source: AA6agR4yDbPvGjQcErOl1V9z2vyuK2AdexXomvXNl4qfKzGWx81eIIK3sPqoM16L+W8Q0Aq9wVwmpw==
X-Received: by 2002:a2e:6d02:0:b0:26a:cf02:40c4 with SMTP id i2-20020a2e6d02000000b0026acf0240c4mr7059592ljc.513.1662926536727;
        Sun, 11 Sep 2022 13:02:16 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm715569lfg.40.2022.09.11.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:02:16 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689 DT bindings
Date:   Sun, 11 Sep 2022 23:01:34 +0300
Message-Id: <20220911200147.375198-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911200147.375198-1-mike.rudenko@gmail.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for OV4689 image sensor driver,
and the relevant MAINTAINERS entries.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
new file mode 100644
index 000000000000..376330b5572a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
@@ -0,0 +1,141 @@
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
+  clock-names: true
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
+    maxItems: 1
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
+  - clock-names
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - powerdown-gpios
+  - reset-gpios
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
+            clock-names = "xvclk";
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
+                    link-frequencies = /bits/ 64 <500000000>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f468864fd268..63c4844f26e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14523,6 +14523,13 @@ S:	Maintained
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

