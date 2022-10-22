Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9D608E72
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJVQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJVQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:21:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F98E7AF;
        Sat, 22 Oct 2022 09:21:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d3so1089621ljl.1;
        Sat, 22 Oct 2022 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaEQ0M0fZlRFVHAX8fCXjxVYyr4/o5N/nyaUHVzFBPw=;
        b=HxRn/Imp+bc7ASkd+fjqGxD2alyAZeD8Bxzaa19AQ1d1ABXQLXLQnALl/acc+tFpOh
         Cu50x7fn34V8pYpnI8sLHzCygs9ON9AJ0U16+UN1KZhnZbfhAP+mtsLBujon1T1i11YI
         RZtWuowcoOSdxu3vVog9LRZsx1bMpAp65cKrlbOpuqNErMr9vjtUaJhYjju9Q5tZ7Nz0
         VoKT7Zb5IRurpisGJGXJiwdyUn6eJYhXsPHqYPjVfg77OYfm87I8zM7b5H0mPnyRTMqJ
         4pnpPEcGLcxZCp9mRLROfoo8N2NmJL5kJ693Bdlz1aKjKWptKs5aOyIOcI1sAvOhdOtj
         wzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaEQ0M0fZlRFVHAX8fCXjxVYyr4/o5N/nyaUHVzFBPw=;
        b=fEmtdrx+Zgd5YPiwfNc+MFbt5gtmf0noJHwgqQZXCKjSPhw3uvqCiBirnT1kMsJjV6
         1atPYmeM+uzAZUtJSf72q2i+LBCGxxcDTqt/lny7V7dTsu78lNdYCk29Z7Ni2REoUeH/
         /0MD481rNoLKsrc6EyLAmdve/JXjcbudod6e4THK/us94q9P50DZyyhcg3PMYM9/tIek
         ik/o/w5On4TrP8cmyxERXz+s7iNMYMDKRBN8g+jCn7CM9BBoIzaUB1GqE5qfB+rguF0w
         /eNjSo4MUXLLxtzwPVN850dB25MW/3bTmkB4f1XSM0Zh66JC6SFnFYINGkXw0/55Domw
         v2Gg==
X-Gm-Message-State: ACrzQf3hGY/JGZy0ZXCfjkIMw2P+HDdjuoCQ0rC/Rg1Sl/O2GX8O8+mK
        iWfhOi+EWAjVeUEtZyHtfn4=
X-Google-Smtp-Source: AMsMyM5n/MHnpAfhPpHXwcv4jdZ89AXmsxnn04NLq0vACCs56MaUOJOClmSvD0R4vMFTcQwQxGRquA==
X-Received: by 2002:a05:651c:1950:b0:26f:ec78:6178 with SMTP id bs16-20020a05651c195000b0026fec786178mr8336684ljb.98.1666455694707;
        Sat, 22 Oct 2022 09:21:34 -0700 (PDT)
Received: from localhost (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id c36-20020a2ebf24000000b00277005136f0sm377035ljr.4.2022.10.22.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:21:34 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, Jimmy Su <jimmy.su@intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] media: dt-bindings: i2c: document OV4689
Date:   Sat, 22 Oct 2022 19:20:06 +0300
Message-Id: <20221022162042.14113-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221022162042.14113-1-mike.rudenko@gmail.com>
References: <20221022162042.14113-1-mike.rudenko@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index cf0f18502372..4d6d86a9f704 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15204,6 +15204,13 @@ S:	Maintained
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
2.38.1

