Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3958169FB47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBVSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjBVSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F83E61C;
        Wed, 22 Feb 2023 10:40:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so8587145wrz.6;
        Wed, 22 Feb 2023 10:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb3s2WfXtxyN5ca68ejOPubf8a8GMk5C8l935KnSJi4=;
        b=TH9c+7lDaHFNxfnvz2Yx+/7tDuONcI+e4TKhn+LtTzYBCJiRIQLyqgJ624+2fb4Cek
         3+ef2gBgyXu5sSaVqChdSshg8XsuQyuBFf+MfGkC/wRnTCJmf9SIKkosPOCnx9eBilT/
         FuIFuwwFma9/BmVEQir0VAlk7pT9OCU/rM2Iki4oeCJGXXm2FClwIVW8QQ2BQJLSS+GG
         s/W8RbUBhduSoG+MDAwGYlSFIcPuxKVc9fEuR97zdd5KyxFX/82D6iYogyLpXXnet56/
         2KiF4BE0DY2Jis6WBk6k2UCNnwTHnqnvYpk2ytgjENNlgLedc9vAFMRoS1Dt7t5XUMt9
         e9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb3s2WfXtxyN5ca68ejOPubf8a8GMk5C8l935KnSJi4=;
        b=Srv7hEAgkZFzskduOkrtJ1ZVwWF36/t5zj9qvktBY0pkjCSIpKqjA5xfelbXVoQ3Pd
         /KWj8JNPt+qsuqrwLlJCDH6Cy6/iGk3bg953Pbi2XpX8HkL9mm+iTWarlnwYsSc+1Jh0
         t7AHk7Mc3QjjcMZwEiAQ3mFDvbEcYQgUZXSqgc4mddJ8L67uPCA7z1xZ+xISVieXmmsC
         PcutUOBCuAaOJkaUC1ZTniSWhSIocbW80StO40M+HYiBnTI3u4V/CpatrrGsT3sm3wcA
         7qibm3AVoPujjpxnfVK4JzI8QwIN7osSOv7h/ZrC+Ap+EhpUysSMG8H3TdqQm/bw6iMy
         iXBA==
X-Gm-Message-State: AO0yUKUeP3/otDcRUK7vKStaCXGPI+LO9rLObuOcHwJOq7tJ3mUaI3l/
        sr3Zv9+OF6KFLPJRDe8UWF0=
X-Google-Smtp-Source: AK7set+IPymHO1XxqQ3hy1/GK0MeXI/BbYuMYgxuI9Cmu6brAd4AXFNhXCDcT9YwA2IVPhnbkAf+OA==
X-Received: by 2002:a05:6000:18c:b0:2c5:8d7d:baa3 with SMTP id p12-20020a056000018c00b002c58d7dbaa3mr6806434wrx.42.1677091229663;
        Wed, 22 Feb 2023 10:40:29 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:29 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 11/16] MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl
Date:   Wed, 22 Feb 2023 21:39:27 +0300
Message-Id: <20230222183932.33267-12-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The Ralink pinctrl driver is now under the name of MediaTek MIPS pin
controller. Move the maintainer information accordingly. Add dt-binding
schema files. Add linux-mediatek@lists.infradead.org as an associated
mailing list.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 MAINTAINERS | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a851eb053ca..a75e6ffc0866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16541,6 +16541,28 @@ F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
 
+PIN CONTROLLER - MEDIATEK MIPS
+M:	Arınç ÜNAL <arinc.unal@arinc9.com>
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
+F:	drivers/pinctrl/mediatek/pinctrl-mt7620.c
+F:	drivers/pinctrl/mediatek/pinctrl-mt7621.c
+F:	drivers/pinctrl/mediatek/pinctrl-mt76x8.c
+F:	drivers/pinctrl/mediatek/pinctrl-mtmips.*
+F:	drivers/pinctrl/mediatek/pinctrl-rt2880.c
+F:	drivers/pinctrl/mediatek/pinctrl-rt305x.c
+F:	drivers/pinctrl/mediatek/pinctrl-rt3883.c
+
 PIN CONTROLLER - MICROCHIP AT91
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -17486,13 +17508,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/boot/dts/ralink/mt7621*
 
-RALINK PINCTRL DRIVER
-M:	Arınç ÜNAL <arinc.unal@arinc9.com>
-M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
-L:	linux-mips@vger.kernel.org
-S:	Maintained
-F:	drivers/pinctrl/ralink/
-
 RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
-- 
2.37.2

