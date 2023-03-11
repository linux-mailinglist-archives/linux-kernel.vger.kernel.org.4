Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDCF6B5BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCKMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCKMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:32:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B765212FD05;
        Sat, 11 Mar 2023 04:32:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ix20so1788550plb.3;
        Sat, 11 Mar 2023 04:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678537964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeBGEGBy3GzypDRtMJAMW7+H/dC0tKTZg1B8rKisPPg=;
        b=ozYBtX+oLCLwTDq0vgGPi/UV5U3VCNOx0hgd8raVBdxqET0UET+vr6lFr+Sj5DulQv
         yy6p1/GTWJD+/1j5mD9CPQHQs0dTjysHRI5EGelYq+hUSr39ExzUZ2iBdtdCjvPqGGM/
         I0lB7mJzQCzIVpGLR6jbcxIAxpDavqedDI3ITFMQQXstOo/1fmcCQVwxTUPidbkTyyBw
         i2RTCskqTCZO6LccgnhQ66HUzUgKyxZUbuBBUo5hsPEMAwSfxvlHsp3g6KtkCKfYUQc8
         mom00/wjigb4i1JOD0fo3Y1j1TUZ8W+wtnvnmXXAimdhsINpzeeHPndz7Jed8pAu+163
         PdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeBGEGBy3GzypDRtMJAMW7+H/dC0tKTZg1B8rKisPPg=;
        b=xd7J27TnBdpFWvWe+KVrL+Ky29jY88eLLVBVXOSZJjvZVdPhCasAarEj1UgnnGQdpz
         5ZrQ9WEeZC+HVJenN+eKujpRX2oztNtcNNzx5ag60T6wesmLRoUvmZYOQD2oCs7ST/IJ
         3pM8loQyR6GmbuhohRk2xwUa6Tgb/CbGb3lDoIGYqPH5n6T6wl/qMe5N0/4SFqGWpsUN
         JJXA55PGjWbxDHmZpaLMtuuXEkd0r3uzQtMllozyOpe9Hj910WbJxA33g+6a7YoKatSt
         Y+uXegjOQboCd6zXjcmcKJl3HrY6+IhKwHi9umP9hHgMokD61zZ62rCQmIOfltRFrrnC
         t+Vw==
X-Gm-Message-State: AO0yUKXtHzAGrV0FCN0fye18S4CqsRNezqScUe+Mg6luUUYzxO9uQ/w8
        XGs9X7PZe0afWl+BsCrc8H0=
X-Google-Smtp-Source: AK7set9M6K7Ck2qJ+kyt/yPQ4Vwm1QYaDduE/QAC7LceldmLdWyR9N7INxoglPg3eg/bykJOjTe6Pw==
X-Received: by 2002:a05:6a20:440c:b0:ce:5c14:2838 with SMTP id ce12-20020a056a20440c00b000ce5c142838mr39315872pzb.54.1678537964189;
        Sat, 11 Mar 2023 04:32:44 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id g4-20020a62e304000000b005a8173829d5sm1406754pfh.66.2023.03.11.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:32:43 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Sat, 11 Mar 2023 20:32:30 +0800
Message-Id: <20230311123231.20771-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT36523 is a display driver IC used to drive DSI panels.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
No changes in v5

No changes in v4

Changes in v3:
  - pick up Krzysztof's R-b
  - remove vddpos and vddneg supply

Changes in v2:
  - Drop unnecessary description
  - dsi0 -> dsi
  - Correct indentation

 .../display/panel/novatek,nt36523.yaml        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
new file mode 100644
index 000000000000..0039561ef04c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -0,0 +1,85 @@
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
+  The Novatek NT36523 is a generic DSI Panel IC used to drive dsi
+  panels. Support video mode panels from China Star Optoelectronics
+  Technology (CSOT) and BOE Technology.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xiaomi,elish-boe-nt36523
+          - xiaomi,elish-csot-nt36523
+      - const: novatek,nt36523
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA
+
+  vddio-supply:
+    description: regulator that supplies the I/O voltage
+
+  reg: true
+  ports: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
+            reg = <0>;
+
+            vddio-supply = <&vreg_l14a_1p88>;
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1{
+                    reg = <1>;
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...
-- 
2.39.2

