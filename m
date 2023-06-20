Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C25736BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjFTMXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjFTMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:22:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38271730;
        Tue, 20 Jun 2023 05:22:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-987a977f62aso378483866b.1;
        Tue, 20 Jun 2023 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687263769; x=1689855769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JqijGATevexodiqwpgWWh8neUeu+NISOC/UOfLz2IU=;
        b=Gidnfvi63amTHS30BFQfvQsOj4NopMPAYG3pYWcsBKQCP+E3TISeR3uH6WbJbqup+d
         QOvt81cPCX0Z86ECWJ8OojO34VIjyADtXNCp2V0bZhUVWMdEpCgFNdjbqXjtkkn4YcSB
         o5s1gqayXO9XF20HN/bGSQnIW5uRbE44YSFhf/+x91vfylIjlCCAXbMh9tvK1yah1hXO
         tyeLvO8xpgRbVQoRP1axpz1hvBzit+ruaq0c20Q83WWOwmgfE490sh0k5SYR8fYSWbGZ
         2c8sxQx+dxMewp0MladMlUQAjqW+/8Lw/P5dGoDfI0MNSX0khGvYDTLQrFQ6BegRzTsZ
         CXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263769; x=1689855769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JqijGATevexodiqwpgWWh8neUeu+NISOC/UOfLz2IU=;
        b=GQKzifPHa14Q6kh9oUWQJU5RbhazYt5WEglw4/+GrC5I6bQTlSX4WxbGGc0D05yVQR
         y14HUYCsx2mR8Jy4CU86ZVRr43IgWBZYaREsZyUtwJj8dY/TUtqzTFTeg5uVFOzmrK6s
         xmreBfKnEEk9BOoE3WAdVb8VIJQrDNd9GKz3GC+NpXR5Ib+SrCsMjaNyXSi8divpKsY+
         rpk3XqbpEKIxN2OBbkE6jPNcFNWP9/qS/npaB2eyuqGgpfS/vWmz8znSR8Dj2+cbGX/3
         8Uz55oUdX6R9b5ZanIuDNLCwLnuDvqYTtWyhHCIXeqisTVXOR7MGU725QyAhg6wtUHSb
         DRqg==
X-Gm-Message-State: AC+VfDyut/ikYFegMXzb5MYYKslbO983BwaPsxdZ4MdaQqWsoaCbQ0xU
        0VWqJ0qzGM+CF0yrYvq/MAA=
X-Google-Smtp-Source: ACHHUZ54o9SFLC3fcm81JGldXMiWrNjZ6SZk9Oi6A/qVzS+svy4kD6VcKgY064O6strtoz0XL6k4Ew==
X-Received: by 2002:a17:907:16a6:b0:974:5ef9:f4d4 with SMTP id hc38-20020a17090716a600b009745ef9f4d4mr10454221ejc.5.1687263769006;
        Tue, 20 Jun 2023 05:22:49 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-242.cust.vodafonedsl.it. [2.39.142.242])
        by smtp.gmail.com with ESMTPSA id me16-20020a170906aed000b0098669cc16b2sm1305200ejb.83.2023.06.20.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:22:48 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] media: dt-bindings: alvium: add document YAML binding
Date:   Tue, 20 Jun 2023 14:22:19 +0200
Message-Id: <20230620122225.58862-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620122225.58862-1-tomm.merciai@gmail.com>
References: <20230620122225.58862-1-tomm.merciai@gmail.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

Changes since v4:
 - Fixed id as reported by RHerring bot and LPinchart
 - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
 - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml

Changes since v5:
 - Fixed alliedvision,lp2hs-delay-us description as suggested by CDooley
 - Collected CDooley Reviewed-by tag

 .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
new file mode 100644
index 000000000000..327cd5421257
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
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
+    minimum: 1
+    maximum: 150000
+    description: |
+      Low power to high speed delay time.
+
+      If the value is present, the camera forces a reset of all
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

