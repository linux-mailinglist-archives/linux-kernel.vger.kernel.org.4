Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB6692325
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjBJQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBJQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:19:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32E6A7D;
        Fri, 10 Feb 2023 08:19:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id o8so4605184pls.11;
        Fri, 10 Feb 2023 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNaBmfoTQLz7ZNBG3JB0nk6HTNfGIUhugluN7LKHX0s=;
        b=DLLnIBtuljVisyTCGaZTIzjn+WmCfhgit/hpuV7WbyJi1rRiLIkfzovDE1EWmzrgfz
         Y5QPVYECtBBgnA+XrGeAnAJXIp8Ru0pUaRkxe4AP9Wifdfk59O1amKjRVkePy7ciFLP0
         INZc+4p2KGsuTkYwK0p3hrUcTEz09ZIGoiN3JsufbPpi+vUnGbzTIqd18uOXsHijLi3h
         cnbmYXUhQm/p5OyvJGcUfWr6WpZbLLblDrrFwnw9r8L6Jw2pLgJuKeGq9sB577Y3nQ8L
         GVvyqQw4h0hLvJwjvQijb4WkJGMmGt34FefyPMiQFU1rosYE2dYLgWqxhlmLT79xVmUO
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNaBmfoTQLz7ZNBG3JB0nk6HTNfGIUhugluN7LKHX0s=;
        b=5vWVA62T+YjFAd8y8mFeznHRwo78HR2XuACuZU2zCLaODUIUE2V4Wq+pQmAZbNCieh
         OYXDOPLPBsBCmWL+0+Jt2XbeuJObHSK12B4XNCb7ssuPrYXNor3nBrw40VUXKyAVHIX9
         qjIizvZlVktDnCjHoy++V7cN8JkZRPtbGHXxKoCYpa6KYL9LVNWQ3iNbqlCxEBs/KtL9
         mSS3Cm1DVALf2O7h3ZRV+83kY7tgoUII/vFyVXyprfRzuZf6Ewn8s3lNzTSX8KrP3Cqx
         WZaQCNZrzg+wslHQdX/gi8Atkzu3jzwaRpeoeBsP5MUYgs1HaXfpsuD7Y/ARZ1ioVpkZ
         XYgw==
X-Gm-Message-State: AO0yUKUW4D1zW+sCNMwYh1a+NpBmteuJgC+9/9/9yjjYdvDWXswE266K
        aYobNP31zJ4+w+a2fN8buXUJor+SelQ=
X-Google-Smtp-Source: AK7set9qN+dgeUakpHaxIOaPDx6OKlk/K+d3hQAC4St+5FG1av7zKEJsQ7wnQLgC+iINiEWalko7Rg==
X-Received: by 2002:a17:902:ec89:b0:194:5c63:364c with SMTP id x9-20020a170902ec8900b001945c63364cmr16945581plg.62.1676045974892;
        Fri, 10 Feb 2023 08:19:34 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0018099c9618esm3564425pls.231.2023.02.10.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:19:34 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Sat, 11 Feb 2023 00:19:24 +0800
Message-Id: <20230210161925.32343-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT36523 is a display driver IC that can drive DSI panel. It
is also present in the csot and boe video mode panels. It is found
in Xiaomi Mi Pad 5 series.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../display/panel/novatek,nt36523.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
new file mode 100644
index 000000000000..a7098d0ce7e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36523.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36523 based DSI display Panels
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The nt36523 IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels.
+  Right now, only support cost and boe LCD display panels with the
+  resolution of 1600x2560. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xiaomi,elish-csot-nt36523
+          - xiaomi,elish-boe-nt36523
+      - const: novatek,nt36523
+    description: This indicates the panel manufacturer of the panel that is
+      in turn using the NT36523 panel driver. This compatible string
+      determines how the NT36523 panel driver is configured for the indicated
+      panel. The novatek,nt36523 compatible shall always be provided as a fallback.
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active high)
+
+  vddio-supply:
+    description: regulator that supplies the I/O voltage
+
+  vddpos-supply:
+    description: positive boost supply regulator
+
+  vddneg-supply:
+    description: negative boost supply regulator
+
+  reg: true
+  ports: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
+            reg = <0>;
+            vddio-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lcd_vddpos_5p5>;
+            vddneg-supply = <&lcd_vddneg_5p5>;
+
+            backlight = <&backlight>;
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                panel_in_0: endpoint {
+                  remote-endpoint = <&dsi0_out>;
+                };
+              };
+
+              port@1{
+                reg = <1>;
+                panel_in_1: endpoint {
+                  remote-endpoint = <&dsi1_out>;
+                };
+              };
+            };
+        };
+    };
+
+...
-- 
2.39.1

