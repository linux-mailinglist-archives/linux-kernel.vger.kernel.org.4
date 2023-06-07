Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1C726116
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbjFGNUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbjFGNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:20:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269919BF;
        Wed,  7 Jun 2023 06:20:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso1289590a12.3;
        Wed, 07 Jun 2023 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144014; x=1688736014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ih3+4bsXANDBgDK6G+g4s7QhjYyFihjN9IGktwpehA=;
        b=hdLlP7TUkCIrewirbCnomdPJIDFcJK/LqMlRtV/hfA1H0GcmBtLGzX0qhU5ZP1Df2C
         P2N2VTq/v+QNgJBhkExGNbEX1vAgOIVjTOi4lSNChvxYslWg3GgahexTbiRb/CmIWrCr
         /SeumPOD2KETRCybXqFOLBvmwRplgN5G5qIudilb6rsiCQ0XYTlhqXSaVoMQqa7fa3Za
         AOFnvoLdcRq4O6V077W3zsDIRD+HkQKbwrzOsMP9tyoX9JlBoo1ryvjl33yxxdCpVnvC
         HjEaNZCclmxmbVSlsiQHTVrz2Pm5NQLEs0GCh4Oz6L8vvnvOJFRQZcO7qm0uM+ITM0SX
         O1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144014; x=1688736014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ih3+4bsXANDBgDK6G+g4s7QhjYyFihjN9IGktwpehA=;
        b=KL7hDUI+XW3F2eyFTZjkJ96sDsLIZqq/FsV8MNqVElCwj6uuZFzs4XJ7xwPNQeJrMH
         FSFCjKjvzIN6kG1oxOmR2mLaFwO+aXXskv574NBWBKPojB1sLR4ZqEtTRLU7+Wie/VRS
         witxI8w0Ylket+P/hjSJSBrGlrMLWLDhmuUM8ZXFKYdifY0uEuoMS9wemAStrbBckpqt
         Sbyfzf0k+igk1mGn0sCX2hBtsKRHdQx/JSh7WZkbsvIk3Q79zhn2SbyGiVMml/HQeFdt
         xU59cOhW+JOkfAkxuLqo9bVCbPCwgkZZZiun6n5PYcnpcgwZPpeqBHOIJERbAhj53gFr
         A38Q==
X-Gm-Message-State: AC+VfDwe+2I7AX+U9wWarWw3LsdtuTQekpZkFRlAIobJV1dJ5JMRriFn
        Ac3LyR51LExJn54l0qgy7zw=
X-Google-Smtp-Source: ACHHUZ4/PK8fjzUlm01MZV/UXjLan199IAmXNka0O///rVX/Z0PUO+uWdtRu1QCTZFCspsiY0dPnzw==
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr4431861edu.0.1686144013901;
        Wed, 07 Jun 2023 06:20:13 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7d8cc000000b005169ffc81absm493353eds.51.2023.06.07.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:20:13 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML binding
Date:   Wed,  7 Jun 2023 15:19:24 +0200
Message-Id: <20230607131936.382406-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607131936.382406-1-tomm.merciai@gmail.com>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:
 - Fixed build error as suggested by RHerring bot

Changes since v2:
 - Fixed License as suggested by KKozlowski/CDooley
 - Removed rotation property as suggested by CDooley/LPinchart
 - Fixed example node name as suggested by CDooley
 - Fixed title as suggested by LPinchart
 - Fixed compatible name as suggested by LPinchart
 - Removed clock as suggested by LPinchart
 - Removed gpios not as suggested by LPinchart
 - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
 - Fixed vendor prefix, unit append as suggested by KKozlowski
 - Fixed data-lanes
 - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
 - Dropped status into example  as suggested by KKozlowski
 - Added vcc-ext-in supply as suggested by LPinchart
 - Dropped pinctrl into example as suggested by LPinchart

Changes since v3:
 - Fixed vcc-ext-in-supply description as suggested by LPinchart
 - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
 - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
 - Collected Reviewed-by tag from LPinchart

 .../media/i2c/alliedvision,alvium-csi2.yaml   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
new file mode 100644
index 000000000000..4726d0068229
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allied Vision Alvium Camera
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
+    const: alliedvision,alvium-csi2
+
+  reg:
+    maxItems: 1
+
+  vcc-ext-in-supply:
+    description: |
+      The regulator that supplies power to the VCC_EXT_IN pins.
+
+  alliedvision,lp2hs-delay-us:
+    maximum: 150000
+    description: |
+      Low power to high speed delay time.
+
+      If the value is larger than 0, the camera forces a reset of all
+      D-PHY lanes for the duration specified by this property. All lanes
+      will transition to the low-power state and back to the high-speed
+      state after the delay. Otherwise the lanes will transition to and
+      remain in the high-speed state immediately after power on.
+
+      This is meant to help CSI-2 receivers synchronizing their D-PHY
+      RX.
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
+          link-frequencies: true
+
+          data-lanes:
+            minItems: 1
+            items:
+              - const: 1
+              - const: 2
+              - const: 3
+              - const: 4
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - vcc-ext-in-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        alvium: camera@3c {
+            compatible = "alliedvision,alvium-csi2";
+            reg = <0x3c>;
+            vcc-ext-in-supply = <&reg_vcc_ext_in>;
+            alliedvision,lp2hs-delay-us = <20>;
+
+            port {
+                alvium_out: endpoint {
+                    remote-endpoint = <&mipi_csi_0_in>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <681250000>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.34.1

