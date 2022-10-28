Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297FB61161B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJ1Pgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJ1PgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:36:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E318953C;
        Fri, 28 Oct 2022 08:35:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so13899707ejd.0;
        Fri, 28 Oct 2022 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7fZm7ApuXTgcuAlV5HSEAH+WmHyvrZrCXZs8igo6kk=;
        b=gtZ582/rkHjfMwapj9rlMJw6dyYkxpynZ15f3IkfF7bvHLK8/81Ygiuj8sth0PlAEi
         G+lunjEZ40yngQgr1vytiDorjO8jcHCKL7X0WqCHIpiDW7UCAsl+BzhRpmT/tKNT/e31
         Wda9fGJ5NnDvr+X4UYHmG4WXOPpfSr7R7aW+cRIJWjD+isN3h067tNR4X9hCEPLwv4OD
         D3em+NuO8vCLe+wqb6DkSTxli120JA10Xm6fVn0M4b74HZ+RaBFcOdH1KnPo3iSKkpL6
         sSDmzIJccrWnxcCO4RoNa72B/Vh603hVkB5opMA18BkEe45qDpc0ddk45NibvFQMoZ+3
         arkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7fZm7ApuXTgcuAlV5HSEAH+WmHyvrZrCXZs8igo6kk=;
        b=lMJ0qb6UU0Hperof/rFpPibC5dEMRRf7VuFn4r1hndWU0S9hBqrEG3tAPZIUg38LVB
         Oj4XX0PaGQMFQJOikfXqi3eTl/618TIgyNExbRlUHS493GEIGsV/yR1XNDh+vlqvS5Fp
         AilzneRtLVUPl0MdXM2rQ5pYlshgTLVhELlh7labGTP0ark/BRsy1Kf7vFW2blIWN0jE
         j9Tfu9EEXkBBubcef80cWtrYdSSY+BVa87Zvv6JIqtCEokSHrtArp8fpcbjZW4V/7tdC
         +4tSxWhoSV6Kiz27ht/Wwu3mHj2vxbrxsPtwnyZvOxSql6upWsunKzi6Mzk6UGMlmLSH
         ZTwQ==
X-Gm-Message-State: ACrzQf3gY/K810kqdSDk0tq0d1nFCK+8DWWxA3L5RgMkdudKAEXYTlcr
        U4U5Pn63/BT+8+iNxgnUBJ4=
X-Google-Smtp-Source: AMsMyM4JcT+lpYOacyBB/sxbZjLjpvA6Xdz7LKGpsNPSTcIxvrM+GhjuHbqF2ew97DA8atIJbEewtQ==
X-Received: by 2002:a17:907:7f8f:b0:791:a840:56b4 with SMTP id qk15-20020a1709077f8f00b00791a84056b4mr43123034ejc.540.1666971345136;
        Fri, 28 Oct 2022 08:35:45 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:44 -0700 (PDT)
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
Subject: [PATCH v4 12/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6735 pin controller
Date:   Fri, 28 Oct 2022 18:35:04 +0300
Message-Id: <20221028153505.23741-13-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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
index 88a4c4ef28e5..2c124b168bc5 100644
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
@@ -151,6 +154,42 @@ patternProperties:
 
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
+        patternProperties:
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
@@ -349,18 +388,32 @@ examples:
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
index 4fd8037263d9..ba5ac4422f00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16314,6 +16314,12 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
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

