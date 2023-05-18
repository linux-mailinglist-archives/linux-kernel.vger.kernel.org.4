Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0370842C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjEROrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjEROrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:47:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C2E0;
        Thu, 18 May 2023 07:47:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52caed90d17so1429709a12.0;
        Thu, 18 May 2023 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684421239; x=1687013239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvgIf19oHXt3jG+3jnSR39KiE1Z6F2UkisVQ+IwSMYQ=;
        b=j1PvAr4axI0UqISuZ0Di29AFnw9d80uWfBvFU81dpydJKPVEjEPNvKfouneurMTsOj
         EFh0o3+LLv8rYZFJ8Omr5QxB761b1aPTk9bTMBU9fbflGXTsJGwVP8PQ8eCYZFYtWKC5
         m+JHbnQnBSTi/v2JVIMNK9DHoRc68dzb/xTAF5gXAVQJfAZxahGLlIB9FFLUi/yOuiHJ
         HJuFVgnwCkzdeQRZUw9U8JbymaVopkDdoeU02qRbVmcJ8lIfOeNYSv9OVtM+AUVOikHP
         zEqfsIQSkCFUINUceUjzGMgnArkKBjY09DZmREAFWe+5h59oyMt40QVrWbn4TXhiOOAM
         I3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684421239; x=1687013239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvgIf19oHXt3jG+3jnSR39KiE1Z6F2UkisVQ+IwSMYQ=;
        b=XrKpeZMT9KhfC2bV3VoYeVHS9i3a0wdKhZyO0vTjsqBkwMzCfTqaoTICNagIH/HBY8
         ZwFdjFw0GwpAtmqi7yRG9LAM0kF8JJWKhVUmsx/82AE9L+m6A9fjZOoO3B2Zj8eGa6yt
         mh/JVjVBOhvrnM0DvI3kN5EoKgqWmNmEY4c8p798nB6fBR8wQ20y3rCLIka5lv3obakq
         lzFauJwC3eFQ/3tShVXgJ9g+xPXuOrTn4lCva3YfjBNlv/IqmM/j8/YTzI6zPmKiTLad
         eR6aoBmVMNp2MCn4w8aWhM/IGX3+KPh22t4g4cGMu8UFeyrLi47eWCOAkIk+k+DDFATj
         jAbA==
X-Gm-Message-State: AC+VfDxSiD22S5XF4dQUGZ35TLqgG/FIEkBRILr7UHqnE2KPUKzkodkC
        zP58FWrFHyYPTse5Rmi3fNupfOr+dSQXXRNants=
X-Google-Smtp-Source: ACHHUZ5eJZWIT/VXRww7Kgr3iXlHofukzD/zJJvJphi9c7Y+8ZZhIEJKgunM/dMHUuHP42LtXRhdjUPUux89MlBU9Lc=
X-Received: by 2002:a17:903:487:b0:1ab:107b:c127 with SMTP id
 jj7-20020a170903048700b001ab107bc127mr2665116plb.59.1684421239254; Thu, 18
 May 2023 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org> <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
 <CAMty3ZCAP6CRsJWMUZZ6+hd5igX3NgyNfhdEv2FwuDtqj4iaaA@mail.gmail.com>
 <HB0TUR.1IPEEV2C5LMB1@gmail.com> <CAMty3ZCSUx-81m4SQcJZvUq3NyhzZbe8ow+LiV7iyUmVLCmNYQ@mail.gmail.com>
In-Reply-To: <CAMty3ZCSUx-81m4SQcJZvUq3NyhzZbe8ow+LiV7iyUmVLCmNYQ@mail.gmail.com>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Thu, 18 May 2023 16:47:08 +0200
Message-ID: <CAO9szn2A22KTzrCTX+24Y3goSberHpcGf-O-Czv3+_dX+pL+vQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: panel: add panel-mipi-dsi-bringup
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, the driver has to be panel-fannal-c3004.c and binding to be fannal,c3004.yaml.

I believe I have covered this and all the other problems in following
patch which I will submit as a V3 of the conversation in a patchset
together with a driver:

Add dt-bindings documentation for panel-mipi-dsi-bringup which currently
supports fannal,c3004 panel. Also added fannal to vendor-prefixes.

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
 .../bindings/display/panel/fannal,c3004.yaml  | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 82 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
new file mode 100644
index 000000000000..c2eea0fa8418
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/fannal,c3004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fannal C3004373132019A MIPI-DSI
+
+maintainers:
+  - Paulo Pavacic <pavacic.p@gmail.com>
+
+description: |
+  Fannal C3004373132019A is a 480x800 panel which requires DSI DCS
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
+  port: true
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
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
b/Documentation/devicetree/bindings/vendor-prefixes.yaml
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
index e0ad886d3163..75879341dd0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6566,6 +6566,12 @@ T:    git git://anongit.freedesktop.org/drm/drm-misc
 F:    Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
 F:    drivers/gpu/drm/tiny/panel-mipi-dbi.c

+DRM DRIVER FOR MIPI DSI BRINGUP
+M:    Paulo Pavacic <pavacic.p@gmail.com>
+S:    Maintained
+C:    matrix:r/mipi-dsi-bringup:matrix.org
+F:    Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.yaml
+
 DRM DRIVER FOR MSM ADRENO GPU
 M:    Rob Clark <robdclark@gmail.com>
 M:    Abhinav Kumar <quic_abhinavk@quicinc.com>
-- 
2.40.1

Best regards,
Paulo
