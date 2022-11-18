Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA062F3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbiKRLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbiKRLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35D8B10E;
        Fri, 18 Nov 2022 03:32:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g2so5143181wrv.6;
        Fri, 18 Nov 2022 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU/IiR7cE8k8Ct2BKn6U4+LCrt9eTga1yn5tJ+jqm7I=;
        b=XZt1krBP4I4YMmZTtsRb8PoArBkkhRzClzELdbnB5ejdZ4NA34wczquYn/Vy7w8/vt
         m7s4uMTorTn88kQ5valu/42tKfvDAn2ifSk6rTUsKWtbOvJwRMjciFEBnMTqKefhuEhK
         YqFj0SKjt18qtN9zzgBzC/DFiUzzJy7ippC/u4qewlHoc4COmr6RkOaI8Y2RcqY9qlCy
         TK2MnZkY+3j6Mu/DCX7eBE5NG/nGnYp5vuotgBngn3oI18hPrEiErRv0XU+nvmBnfyyJ
         Kj5pbLSVu/KiGi4Xx34qb/9JMie3B3akZZDitKYW3Tdri7VutjJa5CwTYT4dlupJtw85
         5+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU/IiR7cE8k8Ct2BKn6U4+LCrt9eTga1yn5tJ+jqm7I=;
        b=JE4avhdzq7Mkwdh+UveS7vnHlx+cJOpTe29aFotlM4PZC6o7uFicm7fnP+yi/5WOyt
         PJy7Lr0obwjog+sagh+5Ocb0M13/tqLIhoESetMMNheDeIJrX0wbq9RgFn5QRHSUqfe2
         3OXi2pDyfZSuEauUdwWOgxOJWBt1BfKvhS+c0oyOx6oczYUqPWH4iyzJsi0lfUezZ36B
         M9J9lUmi1uSnvIh/t58LCJ7rGrzNUXJS5M3QpfbD2oX+U/KPR4velN508toKOboH96uQ
         +RXvDbgTFy1yKmuYG87udJa2ichXAkXaqZvLKJAJ02Nvez99RnVNUvyp1EhiWlAAYKyP
         hpsA==
X-Gm-Message-State: ANoB5pmMg9gkJmN2fq0UWqXojXY54eQFwLQZKyitSV35M307Tu0o/vZo
        xp5Yya+iV8X9xfeLvhmuFn0=
X-Google-Smtp-Source: AA0mqf58I23NR4/4SbZugVPX22dvJKHqj02BlJmyoF4W6patuvX4oUKC+TZI5TXiGQgbCePFhMYy4w==
X-Received: by 2002:adf:ce04:0:b0:241:7277:95dc with SMTP id p4-20020adfce04000000b00241727795dcmr3917637wrn.620.1668771121020;
        Fri, 18 Nov 2022 03:32:01 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm9894817wms.5.2022.11.18.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:32:00 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve pinctrl subnode and property descriptions
Date:   Fri, 18 Nov 2022 14:30:23 +0300
Message-Id: <20221118113028.145348-3-y.oudjana@protonmail.com>
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

Change "subnodes" to "subnode" in subnode description for better grammatical
accuracy, capitalize pinmux description, wrap all descriptions at 80 characters,
and remove literal style indicators from descriptions that don't need their new
lines preserved.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index d6231d11e949..9d481311cc6b 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -118,11 +118,12 @@ patternProperties:
     patternProperties:
       '^pins':
         type: object
-        description: |
-          A pinctrl node should contain at least one subnodes representing the
+        description:
+          A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input schmitt.
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, pullups, drive strength, input enable/disable
+          and input schmitt.
         allOf:
           - $ref: pinmux-node.yaml
           - $ref: pincfg-node.yaml
@@ -130,9 +131,9 @@ patternProperties:
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in boot/dts/<soc>-pinfunc.h directly.
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in boot/dts/<soc>-pinfunc.h directly.
 
           bias-disable: true
 
@@ -141,7 +142,7 @@ patternProperties:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: Pull up PUPD/R0/R1 type define value.
-            description: |
+            description:
               For normal pull up type, it is not necessary to specify R1R0
               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
               will set different resistance values.
@@ -151,7 +152,7 @@ patternProperties:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: Pull down PUPD/R0/R1 type define value.
-            description: |
+            description:
               For normal pull down type, it is not necessary to specify R1R0
               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
               will set different resistance values.
-- 
2.38.1

