Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC66B402F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCJNWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCJNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224CEF92FF;
        Fri, 10 Mar 2023 05:21:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso5182781pju.0;
        Fri, 10 Mar 2023 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678454514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfHCteNV7q+dsb4Bbdwo2yP63fJ16IUesnNAhcskNRU=;
        b=KzoY5clJwBNute/PoW2MQ6oouocVxaydnQP7158oMa776/X3aRPhiTNkSB8lMxnzj4
         DtVmyK9GibAPj9fImIEinHv4LbGohSYZgkq/WnghAlkhZfpMv/Vv/1bVQStzwiKFNgIC
         MdkJyaT8KcQ8P1UtvNaXwxulnHN5afDecv3Zi0r7xFYlVfI/Eo9sRGlTWSK7x9zGOXuy
         SCT7TwjU+oXvUjPwytDrRJjvB5rRsmiOQAZirKb6jAEHhwEYuXQditq6LB2emrxMw/D3
         S1dkW1nt2jUC4+/Lc1/1qT4NCdnZ1fmO3nYQaWF6/4dlN3xYneRBZG+y6ixARyyMEVim
         a2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfHCteNV7q+dsb4Bbdwo2yP63fJ16IUesnNAhcskNRU=;
        b=P0UEYNeJ2zCW85ZPwmmjBNdsfoadolxEXm/Q9Wngqe7A2RShua/3l2YrCGhH97OnbM
         NgqgsFr4kb8h2DBYq239f8hQDzRod5npBmCfF2jZkM9SpdBywkMnMrZ+ORPOnyaJeEzA
         fi6IzV22CNeDmgEojPAWYzjYZxyeV9Avc8fiNvnlKLQoTnqULIM2syzbev8/cJoEiXWf
         FKDvgW38/0yCpueYUcN1xyTiBKFO8vBd0XK0Xh5AWHCfOa43MbRo06ZRbNc7Bok20AW7
         X3fF7kEW7KS0SGSKEgpB/APZ1lDDaCTFNQgvPFXkuxV762NAzikZa5JZiArPcbbhGDB0
         KoZw==
X-Gm-Message-State: AO0yUKUe/MrrGaVI8w+WIfm68ZSV0droITBqcgSp0yVqh2IScJP+1aeM
        /LDNXXGpmJ5oCMbDqjaYv1M=
X-Google-Smtp-Source: AK7set98iPwBwFkq5myreeZkbP0DGiyTHoZ2q34nC3mEd9GMRiAi+I6LYrXirgJ0+rMnqa8ClZTqWg==
X-Received: by 2002:a17:902:c40d:b0:19e:6760:3a5d with SMTP id k13-20020a170902c40d00b0019e67603a5dmr30054230plk.18.1678454514624;
        Fri, 10 Mar 2023 05:21:54 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b0019a95baaaa6sm1421711pls.222.2023.03.10.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:21:54 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Fri, 10 Mar 2023 21:21:43 +0800
Message-Id: <20230310132144.2241-1-lujianhua000@gmail.com>
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

