Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B456E6AFDF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCHEhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCHEhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:37:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3534617140;
        Tue,  7 Mar 2023 20:37:16 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id y19so8937533pgk.5;
        Tue, 07 Mar 2023 20:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678250235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnMf/i3TlL6S5YVPOH4S4B14wxLlA4nM+QSKzTGWPAc=;
        b=ayqm8K+BoGBFmvsnebMCxbZl+hPHhT7YsAFaFMUX4RPDqP/K0LQvXyY0VuowAEqPXC
         07acv1biOJZvz+C/fH6lj7zZRHU2lUtsErNhedvjP8Jp3sDkus64lJMiuDFePunMiLOw
         TKLRZ99q8Kd96VZ23rYCCkfsRu8uCQwtIThVpruAuBHjmsMw3wmRzsia/TCuvqmh2jrw
         4jFp1VcY+ufsRitT1pe5RlY9guhfzot3UqsUveATl+h70aIjEgxWw448OF8ZV6Iirurx
         556kKakv50u5CVrjZrpTAfQpZp3evooyhMDnzYq5hqpfcO2qJUhDZIuGhAP/BiQ8uA4+
         45EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678250235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnMf/i3TlL6S5YVPOH4S4B14wxLlA4nM+QSKzTGWPAc=;
        b=0CQlo6TH8tP190Ze3/hmSPFKmsfv8qROUbgfdfjyBDYQX8utM0cYZadp/Swv54jzP6
         t7MzstnNRUJWEYgsFoWOJC7hlVwPWAwLM5qcAw3QH9Esb5F3FVLRXm2dkLheI7P5/OAL
         7UolDihU5pKXuH7ZTq/ITy6lkeuQsg1U9P/CpoE6YLvvXnQ89cT5VqYCpbkHUWO/C/v9
         GG0nekXa35CtxoEouIcS2YdjE1TFNuxeH38AOFkzdWM479vWsYH239drPr9oTOMNL6hW
         6u9idLsGMAvUqKC/G565or7GqQtICfq3yNoYHFk6qfLMP0PDa9nyayrJKonePlaisHdd
         Pa3g==
X-Gm-Message-State: AO0yUKWbODNQhh9efBvMK7//agD+Q58/xaRyyD+rKpvSiAWdqkEhuJau
        VyHSBqCd0vZ3wvnhFwM4byQ=
X-Google-Smtp-Source: AK7set8Lyowx9lwv0uq5oer8od4eZgTfTRFSr3qVMtH2tfCe4aLbTMeclyt/nSKkGIe+J/sn+d+Lsw==
X-Received: by 2002:aa7:9434:0:b0:5aa:9ef7:4f7f with SMTP id y20-20020aa79434000000b005aa9ef74f7fmr14256423pfo.9.1678250235690;
        Tue, 07 Mar 2023 20:37:15 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b005a8de0f4c76sm8909257pfh.17.2023.03.07.20.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 20:37:15 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Wed,  8 Mar 2023 12:37:05 +0800
Message-Id: <20230308043706.16318-1-lujianhua000@gmail.com>
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
Changes in v3:
  - pick up Krzysztof's R-b

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

