Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB96B8366
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCMVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCMVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B597746FC;
        Mon, 13 Mar 2023 14:00:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cy23so53929596edb.12;
        Mon, 13 Mar 2023 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAK7OFgepYzb1OPPB99RCciV8FJkq+rUyJDpQPMElR0=;
        b=Dc2pqy25AaPPIl0orWAHwkaLgNJssU1xWezj39He4MzGOylxI5SGGGGxjt7Mzt/OuT
         r9V3sfNVHmt92JEFMPdwXVicmZPUlt7aMjWsBjnYGfgthNbvfOvqN20Mqq/36RM8lxXo
         bI17F4pbAHupcAIQHoOPo1m4K3IGMVr3AAe6NhC3aPGK/IyHRbrDr3kQK+tYJmeHWK/o
         vniyV/6ANT4pvrtjlETi80YzbKDTSxwOH4lvazGfDMYgo4H/jBFV/lcySDmTSYL35iZQ
         YDtFniL843wUS2T50wRU4k3TqUeDpqZlO/Fx/111DvBnTw5UdQHWisJUI2mGoC+U3acH
         7jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAK7OFgepYzb1OPPB99RCciV8FJkq+rUyJDpQPMElR0=;
        b=ubfBM1nkd9QLipANq1ZyQg5TmSxZxFOv/yCHD+GFP7I6M4WAPzmDIedg8vzdLzo4jP
         IwxqMpqXLKeGhXUMaY2n2RfwQCKcNOf/PYo6GLxuMgS2wwzNf8Plv6YmrUmD8O1oPih/
         y8LfKUWwVtah7ZC4ueZJwSylhHYwH3RJNFCxFqhlumyvrVLmZ4uX8wlpQO0Dmxl3J/Dh
         YM9+7MebKS3GgTbCs2z3MttbD1mT17aRtjuC966R7FS+c+JKN2/oysUPLOAxedoGwM2c
         PTn27IE8Anjb2FMow3K0OEM67xOJxhrbBM4lHmHkjFY8xjJEixtOdiXFtNxli1reEDru
         q2PQ==
X-Gm-Message-State: AO0yUKUaG5jgagNC05IaaNmxNAoVV4xqcOzAOBbX+aCZPoDd7xDdf+mY
        U65GbhJYOCyAtCxxcIAedzg=
X-Google-Smtp-Source: AK7set9VYMbr4fJOe8wWFcpq/B6PFWmcNTymZ1EDTAZN9sKvcBxSXoIPhz/uqlyY4wetxCcHhZlS0w==
X-Received: by 2002:a17:906:dfca:b0:884:37fd:bf4c with SMTP id jt10-20020a170906dfca00b0088437fdbf4cmr34231752ejc.19.1678741207365;
        Mon, 13 Mar 2023 14:00:07 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:06 -0700 (PDT)
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
Subject: [PATCH v2 06/21] dt-bindings: pinctrl: ralink: move additionalProperties to top
Date:   Mon, 13 Mar 2023 23:59:06 +0300
Message-Id: <20230313205921.35342-7-arinc.unal@arinc9.com>
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

Move additionalProperties to the top. It's easier to read than after a long
indented section.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++----
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 1e63ea34146a..b25e0db77cb3 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -632,10 +635,6 @@ patternProperties:
                 groups:
                   enum: [i2c, spi cs1, uart0]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 1b1d37b981d9..60f6273930f5 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -236,10 +239,6 @@ patternProperties:
                 groups:
                   enum: [wdt]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 7fd0df880a76..4f3e0af7d18f 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -116,10 +119,6 @@ patternProperties:
                 groups:
                   enum: [pci]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 4d66ca752a30..9e45d851def6 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -23,11 +23,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -249,10 +252,6 @@ patternProperties:
                 groups:
                   enum: [spi_cs1]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 008d93181aea..4bea19d4ad7b 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -236,10 +239,6 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
-- 
2.37.2

