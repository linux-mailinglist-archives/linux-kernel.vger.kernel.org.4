Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF069CA88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjBTMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBTMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:13:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8232F7EC6;
        Mon, 20 Feb 2023 04:13:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id bh1so1140867plb.11;
        Mon, 20 Feb 2023 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxAFz2rVLxj2kv0iP8aQ04yRu+OY9bVx6kbZibMveqI=;
        b=UZBGmoL/hq/IHXODoVnESRITuITuEb3YU7ByNcwDfgcWNHM4CtHLDo6qx/rDuX8tPV
         FZfIQS5vNFojlVjKFQ9aes2UlgnNkoTHu5qLm6jxujlaTsrX4UGRsltriHTg7sTP7uSQ
         64dvYgfbU/8c3yml6lVGzvtPQD27jqV4DSgSxS3Q7aTKt2NhAaXFhmB6e0dXZmDnMlXb
         oDzN1O0BQSFjrOZ+8rYOu/oXCRWuZhn70/Q6HNx+CV3TgiXoSeJKbO9t/tjQWNXgjMO7
         mhzfQcfDgvwz9lfPG3H2CkInD5/t+JgyZtC5HVyizN8IJDqkWJtLH7rmU+W1Jg9CH8Gh
         vmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxAFz2rVLxj2kv0iP8aQ04yRu+OY9bVx6kbZibMveqI=;
        b=aj42yWSMX81njOkQ9VdHspYqSFfKdBndbBcDZLZ+7EjgjWzI81MhnBRDLKfIVd1DM5
         ND/EOKLdUAOG0x2cmQkJKeEMDVj13I0tcU+BjPfLN06VevilwCgNwBrwP81PI2YC7lVH
         p7eb8jvmWnpq+UNvTXIbEyujxzZjIUMS8U8aOJOBnM37t59RUmsx6BIq43DF0/wmPMKQ
         Uf8x7RWlBAjO1ls6iiPtebIliviOpC2vX3IY5uSgJjZGr5CZIy9GE5MJgmHP9eFVLjX0
         kK9KLpIuyz1f3nYoIpAdDVJmm6xtFdbhZk/gSOoZvZYQc2wbleRx2pHYbA6ERSTZo30w
         LMaw==
X-Gm-Message-State: AO0yUKW/gl1t5oKkBlHkfQBaOVS67L9n9JZRSyD6npu8lMAw166DxwQA
        KmeHfGeIbbHguXM362wsLkg=
X-Google-Smtp-Source: AK7set8JlZ9xeDW8rXHdBvDt22y0ZTlD8dNdfbAv9PKB6i/MR6N9zGfnENMmtZ343qaZOWXOirUeQw==
X-Received: by 2002:a17:90a:1da:b0:233:fa78:7c9e with SMTP id 26-20020a17090a01da00b00233fa787c9emr2790288pjd.12.1676895186906;
        Mon, 20 Feb 2023 04:13:06 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a498e00b00233790759cesm207799pjh.47.2023.02.20.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:13:06 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Mon, 20 Feb 2023 20:12:57 +0800
Message-Id: <20230220121258.10727-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Novatek NT36523 is a display driver IC used to drive DSI panels.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Drop unnecessary description
  - dsi0 -> dsi
  - Correct indentation

 .../display/panel/novatek,nt36523.yaml        | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
new file mode 100644
index 000000000000..544c3c6e568b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -0,0 +1,95 @@
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
+            vddio-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lcd_vddpos_5p5>;
+            vddneg-supply = <&lcd_vddneg_5p5>;
+
+            backlight = <&backlight>;
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
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

