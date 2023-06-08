Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7CC727A03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjFHIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjFHIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:32:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39972D42;
        Thu,  8 Jun 2023 01:32:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9788554a8c9so66677766b.2;
        Thu, 08 Jun 2023 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686213128; x=1688805128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnDbumXka4ctInd9Hl9OqVmaAI1v3DUSZibzrGc2udw=;
        b=Af5G+fIBYhDRWjCBK0nNda7nMyQdW1Z5MzjahHkO0VuhvPK80WLU+VSg0k9B8sx1JU
         DZ9xzDMzigBcKZJCMh7zj7gURP0Y094MgbyWmj+ao4MXrPJhWdV+Hyz9hjcq16PUy5p2
         +0S2tvofeVyI8s2rpE3RJ85exxjRu/E2da0cpnwrHqwQ0siK8woOXxw2nWbx4v6/5rFK
         0KWA58dtks7GJpN3qYZdnw03Ls/2e3USQJDUGcO1UUFPGDSQ0lYR5tO9vbePvBN1sQJW
         1THF54q+vivn6PGnvbwqSpUjnTcIMHmWyh5U++24JoD3Ct1OFo/3RRRhtx2LHHTyxufD
         UdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213128; x=1688805128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnDbumXka4ctInd9Hl9OqVmaAI1v3DUSZibzrGc2udw=;
        b=gKNL+jhSyBeD7GSjNBvBXlKN48mbFKz4r1Z0kB6iQRZrrjL8qJs29uz3UY5i7lq+Q2
         XiIT6g+FYv1JP7A/RWS/upI31swC1amqnCrIJsS/zF6DrApy5FYiVhdKH0E2h0YJJiAZ
         d6PGuuglaRbXamjr4ePhHraswWGdXfYoEgdFUZaD3VtAvWGyJFDI9aSeiWSluHa6Vt6x
         2ng4GlItjlLcQzxsKw++mqzoxBCIkv1OpnIhs+moHxCqDiTHGMyror23X30XJq/13hSl
         ICEQ+Rz2yGNrk+iwbaamrrh0Ye8sheRqjfPtcPFNkGqH61Y/Ym9E3aT/jN8x0vZgVg6k
         QTkw==
X-Gm-Message-State: AC+VfDyXjSU87JBSdiuMOWMCwVxe2dMUtRp2NkPm3Y0bhYOrSk0gxK+F
        KkWduuF133W/oKIYO1dx9TM=
X-Google-Smtp-Source: ACHHUZ4p14ksdA+aUfHvetsHU9WGZ9cyWHwDjfNY3iC/LDrYdcOpGWLU7g109PLv2qqPkQ6sQuabQg==
X-Received: by 2002:a17:906:9b96:b0:953:8249:1834 with SMTP id dd22-20020a1709069b9600b0095382491834mr9924403ejc.16.1686213127847;
        Thu, 08 Jun 2023 01:32:07 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906558800b00974c32c9a75sm373690ejp.216.2023.06.08.01.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:32:07 -0700 (PDT)
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
        Shawn Tu <shawnx.tu@intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] media: dt-bindings: alvium: add document YAML binding
Date:   Thu,  8 Jun 2023 10:31:15 +0200
Message-Id: <20230608083127.545750-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608083127.545750-1-tomm.merciai@gmail.com>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v4:
 - Fixed id as reported by RHerring bot and LPinchart
 - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
 - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml

 .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
new file mode 100644
index 000000000000..c771e5039641
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

