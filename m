Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9227124C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbjEZKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbjEZKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:34:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444561A6;
        Fri, 26 May 2023 03:34:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so98813966b.1;
        Fri, 26 May 2023 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685097284; x=1687689284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwvCmAwTurzjTiiqP1IFpbM1jF6MSZrc+uB41mGDHHc=;
        b=RB4sBOkNH2P7mla1jya0Zg/9Qkzn0Fpfjw8kMtJWLD5S90tRHBwEyOHowllRCBAkzj
         DRo/cmwuBAKbHEGDzeSItExUHS+W76GRnqTzkmIvshMEAnPxfqr/6tCDGkgdSoISsZlW
         +r+bmEsX9wn2QuIqlbWQEuTg9lyReRyTC8hmJc9+b6Ae0AYNaUEUIrnCQcYzK3OMxVT1
         XEQ2WYdY9VUI/KTdKO8DzG/sW9f/3vibLdXQMkcl+JQN5GT8NxEI9bPZqrG/FbxDm0tF
         4/wioSZqsczOFhJl/hXmzc41OyiN7cBgWnJSXEGlCjoy/P8dzCfsNaYFmu1kXH5tpcaW
         iC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097284; x=1687689284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwvCmAwTurzjTiiqP1IFpbM1jF6MSZrc+uB41mGDHHc=;
        b=KQf92VeFve8Q1treSrJ4Mu2/dTMksRMDKEQxinEvMbA+Gi31oR8dqqsgi+NATCMBrB
         dNFai0maSBOwxv47ggZdibNl2nOiuiXuXgNUpKZQBkGneqp70+CP3vyQ/2mhzg32ItIH
         LHrwxacHmjx49PBZ4bAvygtzgV50Yo3XauEtZJ0wDVS1Pqj8nsfxhaD7aft+w5O9NnJK
         ZKN3cZA3T7gIhAxQLvJAmouE/VS6kw6O7kI83gWg/co/6yzhXsz1kzfkgHI2W5oH7PW+
         ds3rtmKOElxD+yIWn5DbdPFF4kg3moeLv4yN3TFy5WzzyVW1WImo7pYLnDvu3sQiV3ac
         NCrw==
X-Gm-Message-State: AC+VfDyljbK9T0QpU2gKPVY6eFsbTVJM4V9cuN3azWr5TE6brKpWyBDa
        3uYOieN+PDTfO7KIgQ1T+pY=
X-Google-Smtp-Source: ACHHUZ5mMdiZhf8eOxycRUNvCYjv4OZFGJARBOkobN8iHD3+w1E6Sg3qtgCy+f97Lusn/2RwCaccow==
X-Received: by 2002:a17:907:d8c:b0:94e:d951:d4e7 with SMTP id go12-20020a1709070d8c00b0094ed951d4e7mr1730223ejc.59.1685097284295;
        Fri, 26 May 2023 03:34:44 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id fi13-20020a170906da0d00b0096fbc516a93sm1984243ejb.211.2023.05.26.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:34:43 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     tomm.merciai@gmail.com
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: dt-bindings: alvium: add document YAML binding
Date:   Fri, 26 May 2023 12:34:15 +0200
Message-Id: <20230526103427.774226-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526103427.774226-1-tomm.merciai@gmail.com>
References: <20230526103427.774226-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of device tree in YAML schema for the ALVIUM
Camera from Allied Vision Inc.

References:
 - https://www.alliedvision.com/en/products/embedded-vision-solutions

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 .../media/i2c/alliedvision,alvium.yaml        | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
new file mode 100644
index 000000000000..5385fe849ffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Alliedvision Alvium Camera
+
+maintainers:
+  - Tommaso Merciai <tomm.merciai@gmail.com>
+  - Martin Hecht <martin.hecht@avnet.eu>
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: alliedvision,alvium
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: XCLK Input Clock
+
+  clock-names:
+    const: xclk
+
+  powerdown-gpios:
+    maxItems: 1
+    description: >
+      Reference to the GPIO connected to the powerdown pin, if any.
+
+  reset-gpios:
+    maxItems: 1
+    description: >
+      Reference to the GPIO connected to the reset pin, if any.
+
+  streamon-delay:
+    maxItems: 1
+    description: >
+      Delay before camera start capturing frames in us.
+
+  rotation:
+    enum:
+      - 0
+      - 180
+
+  port:
+    description: Digital Output Port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          clock-lanes:
+            const: 0
+          data-lanes:
+            minItems: 1
+            maxItems: 4
+            items:
+              enum: [1, 4]
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
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/imx6qdl-clock.h>
+      #include <dt-bindings/gpio/gpio.h>
+
+      i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          camera: alvium@3c {
+              compatible = "alliedvision,alvium";
+              reg = <0x3c>;
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
+              clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
+              clock-names = "xclk";
+              assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
+              assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+              assigned-clock-rates = <24000000>;
+              streamon-delay = <20>;
+              powerdown-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+              reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+              status = "okay";
+
+              port {
+                  alvium_out: endpoint {
+                      remote-endpoint = <&mipi_csi_0_in>;
+                      data-lanes = <1 2 3 4>;
+                      link-frequencies = /bits/ 64 <681250000>;
+                      clock-lanes = <0>;
+                  };
+              };
+          };
+      };
+
+...
-- 
2.34.1

