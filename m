Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A9673EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjASQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjASQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:32:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF555E3BB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:32:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z11so3584633ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE4kxjCoA8g22WKPVKZXkJ+ZWFhCgt4Gpj2pAo7Vofg=;
        b=pINpCCbJuokFvEfsZ52A6K7wsjl18I2oknNeiQJ3ynhH3vOP35dZ86H2EQk+jZLamm
         uSi0+B4zjimfQTbOUGOrr1sxlCrj7SdzFa90u0J3qz6kdV0yN0iCk27WhipVl7S66LW4
         qQl+HvzQTcG4DcML//YwR1b0nW1FyOggmPkYm9uqtQ7u+HLE5N/4rI1rZkCk92OgPSTi
         ncIl89IWWMOoizVO/b7W8dH1YqoW5H231eow9nIOEthNHwM1W6ftRUfT2N+228kpfHrb
         4L+oeUVMx4nv9PGaDpZyJZg3ARr4a3y0tKOUOTTGE1YRyqM3mOoxo1MbaXVlqhQ4CXIj
         YImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE4kxjCoA8g22WKPVKZXkJ+ZWFhCgt4Gpj2pAo7Vofg=;
        b=tS1m2AI0oSugtWwFHHpzqk4mQHRveyQn1GnmK3x4PD0J5fASy6tyKc8cTjRP7SY/0Z
         u5pSnF3YJCg3v5HfFL9jPvEz3Puht2GKqnq4/lCclFBSPe5Gd99yo6NBmSfDbRN+RX8k
         0JEKfa2CZzeKGvwPnbKpXfWZyYrL76035WRopz30dTo8aExQMy268722KwO18Bkd312G
         9Y1f0WHZwcKfG5FfBPTLGzyq/OgJgtNxu3guMYvG5okddJvgA6uv1CbCbbSUT3G1YDvu
         gmm/87D78S4/J7f9qHEh5ef1ahT169kAmNaIJLWPVnPS/LizVIkLQsMdYXkxDUNdpN3d
         zqAw==
X-Gm-Message-State: AFqh2koEGSlj4gc5eFTkyJumHWKzmBfKVsHj89Xqoo87UCEONIsXNNtq
        iTzM0plkVj5tiQPAnBFqvdNTeg==
X-Google-Smtp-Source: AMrXdXv0JD7ArwgvLKwUjKMA3A7LLoYNY+CcCHNC2j9dwsvXlVKHekCHCKeXSxiUkSXs/UeW80N1lQ==
X-Received: by 2002:a05:6402:1ad1:b0:460:5706:d1fa with SMTP id ba17-20020a0564021ad100b004605706d1famr12010299edb.18.1674145926252;
        Thu, 19 Jan 2023 08:32:06 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id fg11-20020a056402548b00b004873927780bsm15669466edb.20.2023.01.19.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:32:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: display/panel: Add Sony Tama TD4353 JDI display panel
Date:   Thu, 19 Jan 2023 17:31:59 +0100
Message-Id: <20230119163201.580858-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
Compact smartphones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3 -> v4:
- Pick up rb

Link to v3:
https://lore.kernel.org/lkml/20220930180812.32210-1-konrad.dybcio@somainline.org/

 .../display/panel/sony,td4353-jdi.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
new file mode 100644
index 000000000000..b6b885b4c22d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sony,td4353-jdi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
+  MIPI-DSI panel, used in Xperia XZ2 and XZ2 Compact smartphones.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sony,td4353-jdi-tama
+
+  reg: true
+
+  backlight: true
+
+  vddio-supply:
+    description: VDDIO 1.8V supply
+
+  vsp-supply:
+    description: Positive 5.5V supply
+
+  vsn-supply:
+    description: Negative 5.5V supply
+
+  panel-reset-gpios:
+    description: Display panel reset pin
+
+  touch-reset-gpios:
+    description: Touch panel reset pin
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - panel-reset-gpios
+  - touch-reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "sony,td4353-jdi-tama";
+            reg = <0>;
+
+            backlight = <&pmi8998_wled>;
+            vddio-supply = <&vreg_l14a_1p8>;
+            vsp-supply = <&lab>;
+            vsn-supply = <&ibb>;
+            panel-reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+            touch-reset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.39.1

