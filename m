Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC74C6B836B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCMVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCMVAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565D5ADE4;
        Mon, 13 Mar 2023 14:00:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so22895648edb.6;
        Mon, 13 Mar 2023 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kz7FOBiHHhh/zlH3kQlXXhwfkt+v8/mMn6Sm83CJvA=;
        b=ldeb1HzDf48Nbe42vraHtGT9G8/DKvJya4e2SWRFWACjLyifgQfmHB2PMmw9I+PV3d
         DaHeSiVdQv/l7BsKq9G3EjNX8OEuxjT4TiabKxvKqcFnhI4jAWcAma73AEOUavzuZDut
         RlMmrQg62qT9DSQ6/LMkG2PqGN5fNtrfnQNUBNJh+rT3AZt4sgXudC+SUy6t+JWUTIx2
         1h7v7DEKw8o7yXO563EqIWxe/I3c/yxDTiSG1H2YcQZJfndHFjnBBxUwA63wqXbj9PE6
         uSip349PT+3QwPvFd15hK/I+6+iCJFwS0sGhhkkLBoopKZaqa/s630bFoHrEMvmvDX+A
         YVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Kz7FOBiHHhh/zlH3kQlXXhwfkt+v8/mMn6Sm83CJvA=;
        b=Jo1w+GgA3Z1OuF00tHJ/KYJSljeed5qmqf+KP1n3eIOcm3mxpe6KDC/Kg0RSrQD4BZ
         BCdB4uCHvpMbd3Db7mmFEt5cSDbYE6m021zG24hZd22UsSlS4Zw/c3scuRcun4etRe7k
         PIwPkACV+hju+iTBT5z5GWxCBosy85nwMHRH/TMYykwSovHUbhnv+EzLaVDWpu7Jqb86
         w4lTvxZtyqXoakJKrRQ20nhZuuPoncK3gGnVhFgNx/PMgcGxdXY2/JjaAamjFiKAXk9h
         1gtr1UHJ97iVB48r1W8ejrwSelGp9kyN/oKl+fxlC/eJtvOeAainrTSTLOsghz7qreoN
         h4mw==
X-Gm-Message-State: AO0yUKULPyPzRa5QXJMRF22gHIhY4ErDymQ725YON2iD9kdhiga/cH9v
        n+2PARXBDItUSj6BMn85a3Q=
X-Google-Smtp-Source: AK7set++yU5hKWGum0vWkHhKhxL0nBNOOZoBb1pfyR6ZKzIpUWGypAFeKlIJ5e9sbw+kp0ci9bn7Gg==
X-Received: by 2002:a17:907:7f88:b0:92b:f019:a9ef with SMTP id qk8-20020a1709077f8800b0092bf019a9efmr571279ejc.31.1678741209715;
        Mon, 13 Mar 2023 14:00:09 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:09 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 07/21] dt-bindings: pinctrl: ralink: drop quotes from referred schemas
Date:   Mon, 13 Mar 2023 23:59:07 +0300
Message-Id: <20230313205921.35342-8-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
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

Drop the quotes from the referred schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index b25e0db77cb3..cde6de77e228 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -636,7 +636,7 @@ patternProperties:
                   enum: [i2c, spi cs1, uart0]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 60f6273930f5..fb8c5459ea93 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -240,7 +240,7 @@ patternProperties:
                   enum: [wdt]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 4f3e0af7d18f..e51667316b2e 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -120,7 +120,7 @@ patternProperties:
                   enum: [pci]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 9e45d851def6..8b1256af09c3 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -253,7 +253,7 @@ patternProperties:
                   enum: [spi_cs1]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 4bea19d4ad7b..adc4f42a175d 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -240,7 +240,7 @@ patternProperties:
                   enum: [uartlite]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.37.2

