Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E80724567
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjFFOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFFOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B219A6;
        Tue,  6 Jun 2023 07:12:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so51671665e9.1;
        Tue, 06 Jun 2023 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686060734; x=1688652734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGY9TCQS8TEAFvSGwYEA7aVQSCRdWtRRVueHUxdsl0A=;
        b=CC0rLczqRuSN9jOQdI9c11sNEzlv4hGHuQjE4KH+0qlYApeaIHZQVKsN27GA90Fi2l
         HfMcL8RNG3SvdhgiTAtU0k5khGeqAhwUk2xoZiPmt2+azjIoiH05lV3uZL9dvp0wCtyX
         ME6WfA76iaZ0AQtKvSBa9ClEjQCGaE2+kagDGMgziCuXwn2ntHDiXwBt7PjwnrCpUxxL
         pjLjxzHUb8gpcMMLSnXaazKflizahnd1jpg6jX8NqUczWwVxyeNhD3BDTaAOW+uIbRau
         I4sTQ4KVlpKznilRhvuWYl4r4HCc1tLei8DrMVvi8/VBhabGmRMP6xjx8t5H89qER9J3
         UH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060734; x=1688652734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGY9TCQS8TEAFvSGwYEA7aVQSCRdWtRRVueHUxdsl0A=;
        b=OBUE1Sj3e88gC0Ya3TA0w29JyADzFqr3oZs8xzHtEqYG89Nzm0PDpv3LsA2nqwOXnz
         NxVTMxFo7175T2qlEc4/pK/sE0mFWx4ZpY97aO/4b4Yj+ch69tC6mAjvkdGH/LxRtEru
         bux7C7h4cHircW7Zdw441ZPC6fPhWeOpp2zOOLnMWwkbhwD9VXkXrhW5gqbk8K4oC5OZ
         5cUp5R+9FxsX38DR0uNsPZaCaLcvkxoEoHV7uC+7MZ4YBiuKBUdenko1JaABU9jxeYJz
         ZEMBwPddeZSMO1e5aK8DDho/ANM/d7doYc0QIHFTN9PPkWl99hiPZnLr+nCWzrHum8EM
         8jjw==
X-Gm-Message-State: AC+VfDx+UAD4jnLdvbCD8OcwHl8xVSJd0qwrq67msam5YWlE9FGbR3H3
        MnzAZdUj1r0ysM+FWY2JjiE=
X-Google-Smtp-Source: ACHHUZ4YM9OS0oZ2YgCyoHeXx+qk6i3GZi17h3730ytUvjaoEe3PRNJ/g9WR8oUiOw7Ce6nxqLoWhw==
X-Received: by 2002:a05:600c:230f:b0:3f7:e497:aa03 with SMTP id 15-20020a05600c230f00b003f7e497aa03mr1855187wmo.28.1686060733499;
        Tue, 06 Jun 2023 07:12:13 -0700 (PDT)
Received: from fedora.. ([212.15.177.3])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b0030903371ef9sm12694315wrv.22.2023.06.06.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:12:13 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: display: panel: add fannal,c3004
Date:   Tue,  6 Jun 2023 16:07:56 +0200
Message-Id: <20230606140757.818705-3-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606140757.818705-1-pavacic.p@gmail.com>
References: <20230606140757.818705-1-pavacic.p@gmail.com>
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
index 5c22c828ab46..4f4492d0f6c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6427,6 +6427,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
 F:	drivers/gpu/drm/panel/panel-ebbg-ft8719.c
 
+DRM DRIVER FOR FANNAL C3004373132019A
+M:	Paulo Pavacic <pavacic.p@gmail.com>
+S:	Maintained
+C:	matrix:r/linux-drm:matrix.org
+F:	Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.yaml
+
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
2.40.1

