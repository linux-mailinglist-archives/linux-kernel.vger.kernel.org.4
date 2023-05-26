Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6ED712BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjEZRkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbjEZRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:40:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532E1BF;
        Fri, 26 May 2023 10:40:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96fdc081cb3so148648066b.2;
        Fri, 26 May 2023 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122812; x=1687714812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYe7XFcsN7P4IISHtfY7TK64+2c++idDy6uCthqs0d4=;
        b=b5clFHIpFN6AOxog0y+pOhfNdJ6dYF9YBUWffs5fWvUiFS0/m6qzp41FIZC2omFHhl
         MQWoUdNOVxxfnyUWmKwINBo56p2ci7d86p8myMP4sYPVdA9qIYwNbsKC+kBO52P+5K5t
         VwIYtoJb24vZqIaBWqJUyLZZ+rPyL+UX9sEvHTr12mOQGJ9FcAnmHo2n+EbsPFgy4m2v
         J5b5GODcVmrcaqkh2a2jV/q76d/5hApFXoXS3f+9ZzeXZghIrek98D+X5bcSe2dXOyUt
         amDO+1BDOxoBS+3CNdrYfrzDdt0eShP9yVS2l6YXOr1ogaGLKLHnTB9RUnmdTmQ8Gk7Z
         q86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122812; x=1687714812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYe7XFcsN7P4IISHtfY7TK64+2c++idDy6uCthqs0d4=;
        b=Y0ku4CBSNOyaAUJLfYlrRgxywqqU/m2KaVZZ5bsHgi4iQKMtMQyLNrlYgTKW2kwpmM
         GIgtFzuIUUs5PtJvWKtiOqbeaGSNOAZVDMNMZHbvVf/cp21Cx0t1PQVJwKW2WYzt23zq
         RijMZTYxr792NYYqQrjEBoLQHPXlJDgVfWaZiUHLkgfkGvHaPcApceCZwh8aXsVbvj4W
         Ie2LkOww5nL8TTfQN2p374rMucqR+WN4t3JyKmS6wabpvI6jXt+GCFWbn+Qz6r9jF1n3
         i0TZzRQkq+ZWzBDqReJUE1K7/MGDA/bNngagQx7PgxifDQEAKPuU/gg9EAuNXYgJZqvF
         2Itg==
X-Gm-Message-State: AC+VfDxIxJvzguDiUdR/1h9a6PrBFSqxufOOHowvHoKwS/OTnO2pezXq
        9JmdRnCQZXHH9o/5yFEZzpI=
X-Google-Smtp-Source: ACHHUZ6TmBpMcuoB5RjB1V5KMfvUQ0tt2gRCVig9grw9hwlCWnqUwHy2KFCEnyDei2UOzq6oORqwxA==
X-Received: by 2002:a17:907:6e8e:b0:94f:356d:cd0 with SMTP id sh14-20020a1709076e8e00b0094f356d0cd0mr3895814ejc.33.1685122812029;
        Fri, 26 May 2023 10:40:12 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170906f0c500b00965b2d3968csm2367723ejb.84.2023.05.26.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:40:11 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML binding
Date:   Fri, 26 May 2023 19:39:43 +0200
Message-Id: <20230526173955.797226-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526173955.797226-1-tomm.merciai@gmail.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of device tree in YAML schema for the ALVIUM
Camera from Allied Vision Inc.

References:
 - https://www.alliedvision.com/en/products/embedded-vision-solutions

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v1:
 - Fixed build error as suggested by RHerring bot

 .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
new file mode 100644
index 000000000000..81e9e560c99d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
@@ -0,0 +1,115 @@
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
+      #include <dt-bindings/gpio/gpio.h>
+      #include <dt-bindings/clock/imx8mp-clock.h>
+
+      i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          camera: alvium@3c {
+              compatible = "alliedvision,alvium";
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&pinctrl_csi_mclk>;
+              reg = <0x3c>;
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

