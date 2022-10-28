Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1664C611615
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJ1PgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJ1Pfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA3A923E9;
        Fri, 28 Oct 2022 08:35:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so13809779eja.6;
        Fri, 28 Oct 2022 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxvxwP13Oo8DvUfVqMfH08d+kvLAOGlAq8O3gsMECtE=;
        b=ZNaMMNbeoUwH7+bPTsNzycGJur13H+wf6oDTAonavPrvZVvVTgRGSULUmKflQP2zDo
         6FPoolNweiUUzU2FecKF/PEgBdhYWHjdBHXVK8+pMrRuC3hlUp2CyYJEqhWa6ljafYHT
         S76Yn6n+5lpfUFwBlIG0i+RG+n0I/0Q1VNuJB8Fko6QXcElP7EMBY8REr7efSp68FRlY
         wf3mQbmmqAt+klXPwUV/PDOAk+3oT19MxZW959lfG7DDJ5YCIeFz5PAUPXQ4OyKghXQP
         L6BI9+0Hezn4DhNQ4t7SqFsmnea+kCbaWWpBlnaAdEx7+WOSm71kBNKWTGI7rL0vUj/d
         gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxvxwP13Oo8DvUfVqMfH08d+kvLAOGlAq8O3gsMECtE=;
        b=nefyPXyl3PKWTQu5PS9lHSteC5ARwiQLkkF/haVE6OrSry14Fxf1Po83M1qhBujMe3
         xBRa1GAoi9e/WE82ui32phZgTPTumJ6h1G4s8U4L6GdzCJZErjKTK9i9jnAdokzEfAIP
         o4zUOrwQ2+aG+yBooccVR/RW6NG66KAUw3bakU1WmP0Xgg+eN8JWgEPE/DinDOw4ohZ4
         owSSX2p3wKsK3HGk86oP0Nt0ydqYJH0yWJ3HN1UDgoiG88oNBOhBgJeTRj0Ih7FuQ2Ul
         hLLyIV48SJlFvN9WxuD7Q3bxW/8RctBJoGQ/uCe/KGi91qTBvu7TXIdr3ZnmVV/71KXO
         pZZw==
X-Gm-Message-State: ACrzQf2XG7kwdtHLaidxbM9z41UqifWBAKQRUV55rMeHyIFm98AhHe/S
        7ZF9OXPagsjToBAC8w/majI=
X-Google-Smtp-Source: AMsMyM4KKmE92ZXYz/QYmfOEna73upeg1C64cfq81I/bW1gxQcBebKnyCs1ojjIy0Uo+0Z6o8pUFng==
X-Received: by 2002:a17:907:728b:b0:7a1:b545:b39b with SMTP id dt11-20020a170907728b00b007a1b545b39bmr29446607ejc.661.1666971336984;
        Fri, 28 Oct 2022 08:35:36 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:36 -0700 (PDT)
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
Subject: [PATCH v4 08/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve pinctrl subnode and property descriptions
Date:   Fri, 28 Oct 2022 18:35:00 +0300
Message-Id: <20221028153505.23741-9-y.oudjana@protonmail.com>
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

Change "subnodes" to "subnode" in subnode description for better grammatical
accuracy, capitalize pinmux description, wrap all descriptions at 80 characters,
and remove literal style indicators from descriptions that don't need their new
lines preserved.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 23b1f7867afb..70e4ffa2d897 100644
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

