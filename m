Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D552B722B34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjFEPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjFEPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:36:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613FD2;
        Mon,  5 Jun 2023 08:35:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f623adec61so51323345e9.0;
        Mon, 05 Jun 2023 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685979358; x=1688571358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVj4kVE9TbsZ+agDaiYT5QlaQEzr5UAUJl1IGAjEKRY=;
        b=PJPpGN0QP7kXyqycfoY/nA/iO6MJqgH/ZBQktqOte/JxHN5k1v2mNFMob2B3Yt4PoE
         yhL0ekw7pHW1iSOwApgbDCgPn/XCK2CWA2Yo9vuwxwHcIEj8tLQzsjNfWIR70iC13c2N
         lBZyaS7uL9WgrVCm33XSUlMTrCWFwtxoGARnhYcdNx+uo2Q8CzkgOIZZ5al9uy6F7DTF
         OhPKBdtuJZ5wQAVI7VUs7Ufl2S+0EOf6IZbG5jsL9cr6izOf2fkoEgGRzj464RiNkvz3
         GKWqQIpkpPI/Inmenantp9urdW0isctt/9VlQ8xXWNdjibgogzLZUf2RyADWgVT4S7hl
         ppww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979358; x=1688571358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVj4kVE9TbsZ+agDaiYT5QlaQEzr5UAUJl1IGAjEKRY=;
        b=eIceiknxJfzQE8ML8iNgPoIDfrzgGxSrnjaDaG3aFueLnDxsq0K9+LWqYiCtYO7+pK
         YSas1pze3syZn7SN2G1ZC9GMEpfNKrY0yIILg5TUjP69TiDGoLqxwb2TKSybrOXKMZY2
         U+iR4byag/kUan0c3kgciV6val5Io8pE/oKO113SFyaZdFwr0Si6Ix+9FNg2Sd4NNHuj
         FUkFlTF4jKLS+oGz9hCBW+3gSDqKZQn70+SzMHYYETB6cOEMH4MimxTGxbgN/EI8xrDE
         qMlkPTPaxNWDaCJIb0aWJRj77ytTvDAe6AhOZSAu2e1/lXvFSO2SA9xO0EWX3Np4PXG0
         g3qA==
X-Gm-Message-State: AC+VfDwoBAShzRO7pgkXpbP5kyQ7s84nrUXgPrRb2YBQC+fVSRaVCzGi
        Q0rY4SXpsQr7+tciNGLp0dg=
X-Google-Smtp-Source: ACHHUZ72rAgynjuOlwZuJ1i2hSdUBqp7RTT/hNr9SsxQEqtYWWaN1xVSlhsNaYu0e7sC1RZbUFcAuA==
X-Received: by 2002:a05:600c:b42:b0:3f1:7581:eaaf with SMTP id k2-20020a05600c0b4200b003f17581eaafmr7993968wmr.4.1685979358035;
        Mon, 05 Jun 2023 08:35:58 -0700 (PDT)
Received: from fedora.. ([95.168.107.36])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f7298a32ccsm9741165wma.41.2023.06.05.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:35:57 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: add fannal,c3004
Date:   Mon,  5 Jun 2023 17:35:38 +0200
Message-Id: <20230605153539.497602-3-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605153539.497602-1-pavacic.p@gmail.com>
References: <20230605153539.497602-1-pavacic.p@gmail.com>
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

Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
Fannal C3004 is a 480x800 MIPI DSI Panel which requires
DCS initialization sequences with certain delays between certain
commands.

Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
---
v4 changelog:
  - add spaces between properties
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
 .../bindings/display/panel/fannal,c3004.yaml  | 78 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
new file mode 100644
index 000000000000..bbddb036094b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
@@ -0,0 +1,78 @@
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
+
+  reset-gpios: true
+
+  vdd-supply:
+    description: power supply voltage
+
+  vddio-supply:
+    description: power supply voltage for IO
+
+  width-mm:
+    description: physical panel width [mm]
+
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

