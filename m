Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF887263CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjFGPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjFGPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:11:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85C1734;
        Wed,  7 Jun 2023 08:11:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-974638ed5c5so149950766b.1;
        Wed, 07 Jun 2023 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150698; x=1688742698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1kHe4gVXBqajHPBTl5XQ07Jzv99NPkxU1757NK5EN4=;
        b=g8fTadPK2O0D0sWFvziWEQDWaQdxR/8PCaFYuoKqnEBemcKiHm0syXyzJGB4r4eElt
         htj1K1xMAsSsghfB1GwxinAv8snIwE3yMAzGE4NvrN1Rm3XtH4o59VzA5EOMGsMT1Tda
         lHKAtpgHMVAKyRrgJnKZP/qKYgj5bCd+d1Dg+loOiz9RJabYZ8YA4dx7oIcEchHYtJbc
         MzkZ28ezRO1hCXk31DoO67o3u4fzPoq5aYaEjl0f4v7D7X1cPwmqPQXTowivvAy5bZGQ
         zV6RhTGMbnEwivp7IBeuXpp5NJFdwUpfIBUFE2WzgHC0vgqyWsXent7lf8o9kDV3piDp
         Wlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150698; x=1688742698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1kHe4gVXBqajHPBTl5XQ07Jzv99NPkxU1757NK5EN4=;
        b=aIJCGQI2gD4KkmsOc2L5dGF9HDTKkYrwDfTixhDDJCdQYTbHHHEf8ikCK77iRXNJPY
         W2m7dWtLMNrpuhwVRvd8HLPeqUGIXZq9g99Bj0oRxvhoFBdb3IO8B+xhwhLZSmGsG2iL
         zUf2D5gFZaGk6tOcJFxrwqlIP9Kh1CZewvCOLRB9DNYB9Lx3mxXRiRYZJnuzqeB7JqL5
         j6VT6y56FLYoBIi3b4lFWwHFICj0nSSz+2WoBEm7TNk7hRWC+LyNbjVHGU+hxG3bmMaK
         niL810O6LBKP8lzB9wAV1GaWIdj46LW0GuCmx6DpMOJSrrzntr+L840HiPIUnAbwIxcO
         KI3Q==
X-Gm-Message-State: AC+VfDz253eghAZ1xM3Y3ogSNdBErjs5DGZqpUOEjYUJqJ5gvTPtrA/8
        ctwDXrYFZti7OkCXFY1mDYY=
X-Google-Smtp-Source: ACHHUZ5UPYpu9sGDVFhicKu7bLEp42EIktjqb4Ct83fOQx5UHFTzXH06G3na8tzijwqlE5MyLtGQbw==
X-Received: by 2002:a17:907:7e9e:b0:96f:ddaa:c30d with SMTP id qb30-20020a1709077e9e00b0096fddaac30dmr6197472ejc.26.1686150698035;
        Wed, 07 Jun 2023 08:11:38 -0700 (PDT)
Received: from fedora.. ([46.188.160.176])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906235300b00967a18df1easm7006222eja.117.2023.06.07.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:11:37 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: display: panel: add fannal,c3004
Date:   Wed,  7 Jun 2023 17:11:26 +0200
Message-Id: <20230607151127.1542024-3-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607151127.1542024-1-pavacic.p@gmail.com>
References: <20230607151127.1542024-1-pavacic.p@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4 changelog:
  - removed driver's community from MAINTAINERS file
v2 changelog:
  - added empty lines between properties in yml
  - renamed yml file
  - refactored yml file to describe fannal,c3004
  - added matrix URI to MAINTAINERS
v1 changelog:
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
 MAINTAINERS                                   |  5 ++
 2 files changed, 83 insertions(+)
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
index 5c22c828ab46..978133f87c5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6427,6 +6427,11 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
 F:	drivers/gpu/drm/panel/panel-ebbg-ft8719.c
 
+DRM DRIVER FOR FANNAL C3004373132019A
+M:	Paulo Pavacic <pavacic.p@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.yaml
+
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
2.40.1

