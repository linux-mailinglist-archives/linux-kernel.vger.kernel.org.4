Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA89709998
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjESOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjESOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:25:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8A13D;
        Fri, 19 May 2023 07:25:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f42711865eso21311715e9.0;
        Fri, 19 May 2023 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684506335; x=1687098335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXL/sILoWENE3XBFz1jyrq42x+BgMkEmVV3BRtYQa0Q=;
        b=YcB1o1a36BNLAprjM6dWjokGpYysOeAU42OoeY4hhjvq+oZJ/O6ahscJvJJ+CLczDz
         sL5iYNswIapoQeBwm/FlDrHrTZ2j08UZ6wzgvGryd2MARBlmwMH0PeJL7rIztafeJwag
         Vub7GL3cKL6lCfTioP2cODsWWwkz6uwEZ2WFTRG0RQGNmKD3DbM28DUFhUrz6ctNXu5H
         eyk6oN0Wi6HmF2ts02vujMj+mK0+xHRN1zezCWjh/NcezmO9ZI28M33vrR0IZBNE4yjo
         HDJ38MberoUJbmx3l6bp+p+qjY42fkZhsIrClpyyHvn8ODIzGGyjmEhe27zsRudB3fQd
         VsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506335; x=1687098335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXL/sILoWENE3XBFz1jyrq42x+BgMkEmVV3BRtYQa0Q=;
        b=GnY2/Q+BCJTZuNwxTK1+922bng0da64xvB5KXIz0Wj299oUyu+WFbNWsc3bLOdNyft
         URMb4JGx573hVrcmaGWERvuPNGSksbHTFaA2VX6urrPBzrjUMUQv90p1pku2mINU5Pr6
         JKov5FnZoVK3iTn1ON+RQcGduiMK+V7Qjht3jMp6vTxHzgDwIxfrUep+/a0J0pWjYY5b
         EGWrhCo6ceZT146VXRFx9onSqDW5xjOQhIlVhiacTUXoI8//DAL0EPbtcBjYSK2zhm2p
         6LYQGhYd65Lt/TbupLbU/K7MSmRs9tCh4EI7mZgWEgAnHSv8G092926sf1sT8GgAj2GK
         p3rA==
X-Gm-Message-State: AC+VfDyZJ30eb7kLaC5/5qeUoXNUBcUOYV5JqUBlULWYOEl/XJKh5jko
        UR0hQ6mInnDd07eFKdMQb/Y=
X-Google-Smtp-Source: ACHHUZ6DEEtxI4PqKANjVq7Q/b0VWEQq6K+AFaI3Nf8PB6N/OnFiCs10kk/8RYmpJIt9yL4yV3/qgw==
X-Received: by 2002:a7b:ce96:0:b0:3f4:1a97:ab07 with SMTP id q22-20020a7bce96000000b003f41a97ab07mr1562669wmj.8.1684506334498;
        Fri, 19 May 2023 07:25:34 -0700 (PDT)
Received: from fedora.. ([95.168.116.22])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b003062b2c5255sm5451748wrw.40.2023.05.19.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:25:34 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: add fannal,c3004
Date:   Fri, 19 May 2023 16:24:55 +0200
Message-Id: <20230519142456.2588145-2-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519142456.2588145-1-pavacic.p@gmail.com>
References: <20230519142456.2588145-1-pavacic.p@gmail.com>
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


Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
Fannal C3004 is a 480x800 MIPI DSI Panel which requires
DCS initialization sequences with certain delays between certain
commands.

Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
---
v3 changelog:
  - renamed yml file
  - refactored yml file to describe fannal,c3004
  - added matrix URI to MAINTAINERS
v2 changelog:
  - revised driver title, now describes purpose
  - revised description, now describes hw
  - revised maintainers, now has only 1 mail
  - removed diacritics from commit/commit author
  - properties/compatible is now enum
  - compatible using only lowercase
  - revised dts example
  - modified MAINTAINERS in this commit (instead of driver commit)
  - dt_bindings_check checked yml
  - checkpatch warning fixed
---
 .../bindings/display/panel/fannal,c3004.yaml  | 75 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
new file mode 100644
index 000000000000..a86b5ce02aa2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/fannal,c3004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fannal C3004 MIPI-DSI
+
+maintainers:
+  - Paulo Pavacic <pavacic.p@gmail.com>
+
+description: |
+  Fannal C3004 is a 480x800 panel which requires DSI DCS
+  initialization sequences.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fannal,c3004
+
+  reg: true
+  reset-gpios: true
+
+  vdd-supply:
+    description: power supply voltage
+  vddio-supply:
+    description: power supply voltage for IO
+
+  width-mm:
+    description: physical panel width [mm]
+  height-mm:
+    description: physical panel height [mm]
+
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "fannal,c3004";
+            reg = <0>;
+            pinctrl-0 = <&pinctrl_mipi_dsi_rst>;
+            pinctrl-names = "default";
+            reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg1>;
+            vddio-supply = <&reg2>;
+            width-mm = <93>;
+            height-mm = <56>;
+            panel-timing {
+                clock-frequency = <27000000>;
+                hactive = <480>;
+                vactive = <800>;
+                hfront-porch = <30>;
+                hback-porch = <30>;
+                hsync-len = <8>;
+                vback-porch = <30>;
+                vfront-porch = <30>;
+                vsync-len = <8>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..f962750f630a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -462,6 +462,8 @@ patternProperties:
     description: Facebook
   "^fairphone,.*":
     description: Fairphone B.V.
+  "^fannal,.*":
+    description: Fannal Electronics Co., Ltd
   "^faraday,.*":
     description: Faraday Technology Corporation
   "^fastrax,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c22c828ab46..62374c8424b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6427,6 +6427,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
 F:	drivers/gpu/drm/panel/panel-ebbg-ft8719.c
 
+DRM DRIVER FOR FANNAL C3004373132019A
+M:	Paulo Pavacic <pavacic.p@gmail.com>
+S:	Maintained
+C:	matrix:r/mipi-dsi-bringup:matrix.org
+F:	Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.yaml
+
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
2.40.1

