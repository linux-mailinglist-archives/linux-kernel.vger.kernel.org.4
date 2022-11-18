Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F562F3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiKRLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiKRLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDBD8B126;
        Fri, 18 Nov 2022 03:32:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so8812135wrb.4;
        Fri, 18 Nov 2022 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAvy8c9gtUZy8nIKl3qnMpXIEQOhQbRLMkZCTIdFNcc=;
        b=aNhQxWuIWQUM3GCgOEFW2ZaDl4AyvbGzGmidBaLQC+ptKYUkJMc2y1N5bL5BtqJzxw
         tG8wHRSWcuOaP16tIMVDdNC3xcOongXTsakZi53NoIrWqwojxxQRR910c5rNJsGN0XxG
         poretQK9G6L9xOKuCmwTSz4hu4u23ssH6RiUglyhhwxmkJWaBs5mxW3hi0gSYEzK/2sv
         9P4C0fuDDKBKtSZSXiso47V3Lt7AImco8795s/Pv1mdBU3vvd4bioludYswbjBZ/mA/Q
         wRA/uEOvlmJzTvalcY3EX/Ijgvvl/WaPXnmDEgwaq/4wOnCPsshoad8PU3GJouj/bG4Z
         51Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAvy8c9gtUZy8nIKl3qnMpXIEQOhQbRLMkZCTIdFNcc=;
        b=rk9wrjYBTm+olV1nLbysIvLeBnQfYmicGyIjSCHurNS1SWCB3e6X1brhcpp+v4EtvD
         Pe4hsRyOvGjk8X6ZeR74tehWMnQnZbN9VPRQsTOSRMGg7dd0iIq/yb/je8m+FF7vyGIv
         RnVtpqrlvP0zq2GCv8aV0sS9lGo8Qr/beWrxPhncuWRC67lJm3aNytSKYSwpQpqzhVdn
         NUdhW6NbxnCHy9ojqqw4YsqLQp1wS3dcmS0ky6cpEHZuWsbKlcWa4IZegf7WaWAuG6Rg
         d5lkhU8qRoYcwVKvHrnSDf7+LTmQcdrZvwmiNsQAswfbKY6T7bnsCGtwB1bBMDCVZnyv
         oMjg==
X-Gm-Message-State: ANoB5plA3qZwWVzKpHlJYVUfwFd3jwr3gW1aMamRfTcq7QltMQ9snNFm
        nBDXCvG2za1TpTG1It274TE=
X-Google-Smtp-Source: AA0mqf4b9R5IXX/RtS2DBzFyEY8bsx3yi7235hc2wxNciic0J/Fvaap19LLqleaFiwRkkMUCKSOXCw==
X-Received: by 2002:a05:6000:1d94:b0:238:3d85:8e2c with SMTP id bk20-20020a0560001d9400b002383d858e2cmr4121275wrb.650.1668771131382;
        Fri, 18 Nov 2022 03:32:11 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm9894817wms.5.2022.11.18.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:32:11 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 6/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin controller
Date:   Fri, 18 Nov 2022 14:30:27 +0300
Message-Id: <20221118113028.145348-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118113028.145348-1-y.oudjana@protonmail.com>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add bindings for the pin controller found on MediaTek MT6735 and
MT6735M SoCs, including describing a method to manually specify
a pin and function in the pinmux property making defining bindings
for each pin/function combination unnecessary. The pin controllers
on those SoCs are generally identical, with the only difference
being the lack of MSDC2 pins (198-203) on MT6735M.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 55 ++++++++++++++++++-
 MAINTAINERS                                   |  6 ++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index c2238a86b7fe..4fe95b0107ba 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Andy Teng <andy.teng@mediatek.com>
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
+  - Yassine Oudjana <y.oudjana@protonmail.com>
 
 description:
   The MediaTek pin controller on MT6779 is used to control pin
@@ -18,6 +19,8 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6735-pinctrl
+      - mediatek,mt6735m-pinctrl
       - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
@@ -60,6 +63,42 @@ required:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt6735-pinctrl
+              - mediatek,mt6735m-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 8
+          maxItems: 8
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: eint
+
+        interrupts:
+          items:
+            - description: EINT interrupt
+
+      patternProperties:
+        '-pins$':
+          patternProperties:
+            '^pins':
+              properties:
+                drive-strength:
+                  enum: [1, 2, 4, 8, 16]
+
   - if:
       properties:
         compatible:
@@ -352,18 +391,32 @@ examples:
             };
 
             /* GPIO0 set as multifunction GPIO0 */
-            gpio-pins {
+            gpio0-pins {
                 pins {
                     pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
                 };
             };
 
+            /* GPIO1 set to function 0 (GPIO) */
+            gpio1-pins {
+                pins {
+                    pinmux = <(MTK_PIN_NO(1) | 0)>;
+                };
+            };
+
             /* GPIO52 set as multifunction SDA0 */
             i2c0-pins {
                 pins {
                   pinmux = <PINMUX_GPIO52__FUNC_SDA0>;
                 };
             };
+
+            /* GPIO62 set to function 1 (primary function) */
+            i2c1-pins {
+                pins {
+                    pinmux = <(MTK_PIN_NO(62) | 1)>;
+                };
+            };
         };
 
         mmc0 {
diff --git a/MAINTAINERS b/MAINTAINERS
index 1df62c469bd9..f9223c6cd5a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16462,6 +16462,12 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
 
+PIN CONTROLLER - MEDIATEK MT6735
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+
 PIN CONTROLLER - MICROCHIP AT91
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.38.1

