Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1046B73B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCMKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCMKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:19:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1F2885A;
        Mon, 13 Mar 2023 03:19:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y2so11449072pjg.3;
        Mon, 13 Mar 2023 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678702756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgZncveY2O/txV/R7OP3ZoBdtRLxTenrDfGCPy6Jz1s=;
        b=av8QqSRHixcRjhUE79qpQGAhBtayUig4shkCBjrBNatklj1vswZy4RYKRj3HnJHWi/
         7oN276bUX5jLU+DHgCWSXpfH8l9ZSm+MfLsY4RmnsQgbUXAP8z57YdIKZbYBV5MKqB6E
         4I1T15vnrtfK5uZMfwRM3w9ZAMgd48TJeMMLAOu7s4GtlOlvGrkWdHGXcMI5l1jiP5SH
         sdSUpzWqOA1daG45IuqksT8q5kLfMcNS2oZ2u8qa8hFPm6ycrs2zoXPW4utjNA6xKpJV
         ZtnTrXS70BvGPv3YS7/cfAhTGbqt7HrTXYDAc1YJZ9j3KqYmgYsgpnDZ2gvbvT5bwGKh
         hM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgZncveY2O/txV/R7OP3ZoBdtRLxTenrDfGCPy6Jz1s=;
        b=JTjRy4+ob5xn28Q/YuowMEPqwTZcu6L6PJtfEViN9fZVy7B7Zp4KVs3AJ1Q0pyRD0X
         0iQouIe6oZIFZRXa5cMJwNehw0hnHGV7U/ne5pqDCf9xbU52wxUqZV8jhru1LP0CWWXX
         O2Sz0iUVIdY70rdH1Ni/qBVe2Py9BhiOMfDckMnCkJ9yzdgALK6QTRHUBIdOhXi6rNp4
         Sj7+XIN/53yDr4SLJEVO5pPLBWrKts5L5bm/FHdYJC9FlP2Nt+3CiExIcfOEgZc37FMb
         Gflh7BY5PEyHwZKYS2ioon/uQ+/eWfnibQIZDjxbVlnrvV35f890rWLl9x9meyCvy2ZN
         tZng==
X-Gm-Message-State: AO0yUKWWUfl/PH8XPIsixErQ0u5GiLOM/9+ZP0cceOzYkZqouWXY8ohe
        W0fr9DcJdXy1P6vCDp4ay68=
X-Google-Smtp-Source: AK7set+afB5U1j55sApwQnuVUKDwLFCeDjQ8c0UTiwdl5hDF5V5WHR9uiWmGdtLkeySb+DZVcWdr5w==
X-Received: by 2002:a17:902:e550:b0:1a0:42c0:b2a5 with SMTP id n16-20020a170902e55000b001a042c0b2a5mr4499185plf.24.1678702756602;
        Mon, 13 Mar 2023 03:19:16 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b0019a7c890c5asm1270652plo.263.2023.03.13.03.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 03:19:16 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
Date:   Mon, 13 Mar 2023 18:18:57 +0800
Message-Id: <20230313101858.14611-1-lujianhua000@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
No changes in v6

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

