Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD4672597
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjARRyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:54:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D94DE0A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:54:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1969578wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWpO1YbgA04yjZBzLFJGZr2Ux7J9tn5oLTa4Qr7uJbk=;
        b=yPqo3wCU1xKWJPTbuSCKCbqYu6Q+pewK3OQ1KwO4DvrbPw4kUHaYyutclqFtr8rniv
         rFB6x+jo6VQZ3dIlql4OO3K15gyVQVAKU3AYVC2LM+MZh6yPUdKhf9nv6PA2T845Jgx0
         7yms/WQF5TaY3zASjHlGhI5n4Bamh23pq1kXrtkbHWpAmcRoSyGmggfj3vgMv2XT0hVc
         ny3oYDCyascDlK2oamvzZXNSAKXv97QzBO8GY3CF9s0p+ggSH3VBEFKJ7FowVdowCM0s
         lOyVHWx9INpOjZ9m5zUjoUnY8HVAxBrvv6R0qQ9om98BW0nVvP1h4U8BW7Fog/yjGxf+
         Wzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWpO1YbgA04yjZBzLFJGZr2Ux7J9tn5oLTa4Qr7uJbk=;
        b=euuxl28ArOk9u0tfF93bWuHrj129BE/QtNA0CaRDpCiq4yioPlSjRCao4Qqxjim/GQ
         CNquwWT2YUDKtoAnfe32JvxQRIFAcH1bh2VElyimzlFApHdawpEMlQtoigCqGqCrhrsR
         8EONdw4EldkN9YDG7JhMjPdJLluQDXBqm0+f8ZaEVr3vibfjOqKmfWncBFJqjTK/3zly
         g/Cra8eG/t3F9p1qccEN9j7RbyWm4ft7dR3U8BFrQalmBWY3UllUZ7EUrvj6nBPOBtZG
         8wpdFUOCkxEXpJsMg9nLxD8z6x92feWWtrA+3e0VOsQBYfRw9oxL+3Xy4RI9kREeHmrR
         OXqQ==
X-Gm-Message-State: AFqh2kq6NQAE98wZ9v2Al7CNqOBuEEic1KyKaYnM/MQljfYdyhgtaPZ9
        Sh91ov3ZViBjw7owsyc2Gm5y0w==
X-Google-Smtp-Source: AMrXdXuVbyarxnAiepfXzbwTR1RHkFZszrKxbE5DGbOdnNgX139UqeLC5+bUZ7kndu3Jzieu7igTOQ==
X-Received: by 2002:a05:600c:4d93:b0:3d9:efd1:214d with SMTP id v19-20020a05600c4d9300b003d9efd1214dmr7568201wmp.25.1674064457145;
        Wed, 18 Jan 2023 09:54:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003cf894dbc4fsm2730015wmq.25.2023.01.18.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:54:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, de Goede <hdegoede@redhat.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ath11k@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: wireless: minor whitespace and name cleanups
Date:   Wed, 18 Jan 2023 18:54:13 +0100
Message-Id: <20230118175413.360153-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanups:
 - Drop redundant blank lines,
 - Correct indentaion in examples,
 - Correct node names in examples to drop underscore and use generic
   name.

No functional impact except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/wireless/esp,esp8089.yaml    | 20 +++---
 .../bindings/net/wireless/ieee80211.yaml      |  1 -
 .../bindings/net/wireless/mediatek,mt76.yaml  |  1 -
 .../bindings/net/wireless/qcom,ath11k.yaml    | 11 ++-
 .../bindings/net/wireless/silabs,wfx.yaml     |  1 -
 .../bindings/net/wireless/ti,wlcore.yaml      | 70 +++++++++----------
 6 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/esp,esp8089.yaml b/Documentation/devicetree/bindings/net/wireless/esp,esp8089.yaml
index 5557676e9d4b..0ea84d6fe73e 100644
--- a/Documentation/devicetree/bindings/net/wireless/esp,esp8089.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/esp,esp8089.yaml
@@ -29,15 +29,15 @@ additionalProperties: false
 
 examples:
   - |
-      mmc {
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          wifi@1 {
-              compatible = "esp,esp8089";
-              reg = <1>;
-              esp,crystal-26M-en = <2>;
-          };
-      };
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@1 {
+            compatible = "esp,esp8089";
+            reg = <1>;
+            esp,crystal-26M-en = <2>;
+        };
+    };
 
 ...
diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
index e68ed9423150..d89f7a3f88a7 100644
--- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
-
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/ieee80211.yaml#
diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index f0c78f994491..7d526ff53fb7 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
-
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/mediatek,mt76.yaml#
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 556eb523606a..5f4b141ba813 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
-
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k.yaml#
@@ -262,10 +261,10 @@ allOf:
 examples:
   - |
 
-    q6v5_wcss: q6v5_wcss@CD00000 {
+    q6v5_wcss: remoteproc@cd00000 {
         compatible = "qcom,ipq8074-wcss-pil";
-        reg = <0xCD00000 0x4040>,
-              <0x4AB000 0x20>;
+        reg = <0xcd00000 0x4040>,
+              <0x4ab000 0x20>;
         reg-names = "qdsp6",
                     "rmb";
     };
@@ -386,7 +385,7 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
-        qcn9074_0: qcn9074_0@51100000 {
+        qcn9074_0: wifi@51100000 {
             no-map;
             reg = <0x0 0x51100000 0x0 0x03500000>;
         };
@@ -463,6 +462,6 @@ examples:
         qcom,smem-states = <&wlan_smp2p_out 0>;
         qcom,smem-state-names = "wlan-smp2p-out";
         wifi-firmware {
-                iommus = <&apps_smmu 0x1c02 0x1>;
+            iommus = <&apps_smmu 0x1c02 0x1>;
         };
     };
diff --git a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
index 583db5d42226..84e5659e50ef 100644
--- a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
@@ -2,7 +2,6 @@
 # Copyright (c) 2020, Silicon Laboratories, Inc.
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/net/wireless/silabs,wfx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml
index e31456730e9f..f799a1e52173 100644
--- a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml
@@ -90,47 +90,47 @@ examples:
 
     // For wl12xx family:
     spi1 {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            wlcore1: wlcore@1 {
-                    compatible = "ti,wl1271";
-                    reg = <1>;
-                    spi-max-frequency = <48000000>;
-                    interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
-                    vwlan-supply = <&vwlan_fixed>;
-                    clock-xtal;
-                    ref-clock-frequency = <38400000>;
-            };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wlcore1: wlcore@1 {
+            compatible = "ti,wl1271";
+            reg = <1>;
+            spi-max-frequency = <48000000>;
+            interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+            vwlan-supply = <&vwlan_fixed>;
+            clock-xtal;
+            ref-clock-frequency = <38400000>;
+        };
     };
 
     // For wl18xx family:
     spi2 {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            wlcore2: wlcore@0 {
-                    compatible = "ti,wl1835";
-                    reg = <0>;
-                    spi-max-frequency = <48000000>;
-                    interrupts = <27 IRQ_TYPE_EDGE_RISING>;
-                    vwlan-supply = <&vwlan_fixed>;
-            };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wlcore2: wlcore@0 {
+            compatible = "ti,wl1835";
+            reg = <0>;
+            spi-max-frequency = <48000000>;
+            interrupts = <27 IRQ_TYPE_EDGE_RISING>;
+            vwlan-supply = <&vwlan_fixed>;
+        };
     };
 
     // SDIO example:
     mmc3 {
-            vmmc-supply = <&wlan_en_reg>;
-            bus-width = <4>;
-            cap-power-off-card;
-            keep-power-in-suspend;
-
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            wlcore3: wlcore@2 {
-                    compatible = "ti,wl1835";
-                    reg = <2>;
-                    interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
-            };
+        vmmc-supply = <&wlan_en_reg>;
+        bus-width = <4>;
+        cap-power-off-card;
+        keep-power-in-suspend;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wlcore3: wlcore@2 {
+            compatible = "ti,wl1835";
+            reg = <2>;
+            interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+        };
     };
-- 
2.34.1

