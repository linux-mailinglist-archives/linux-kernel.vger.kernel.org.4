Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8682C69FB65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjBVSlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBVSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161433E636;
        Wed, 22 Feb 2023 10:40:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so8350468wrb.3;
        Wed, 22 Feb 2023 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93GncC/YMq/sLoJhUEjsPCJ56rRoBeF7sm8+y73s7Mk=;
        b=E+Vb5T8FT+Ye+67Qb+aNplspFmHXbtd5U08wTEttHwIwNpkiYDC8uD5NQSx/f/ZpjF
         Os7FrxTTU43Zrp7+2dvjzaLH+pm8N/PBaigLPTcEXubTqWPFoPtdDvC3maibU+2t1Fof
         Fu+Bh1plW8gl8lieS+ZhJjtNR94xLuyKtLJ+9xTTgrAmzr+tb2utmVMJ1jPnJ6p6NR+H
         yGWNnJEI8BZ5jNTqP7ETWO3fShvvgJ7N0W9zDWt3iWiniUUO9PjA+7k8SLmfyG4VXiaR
         454D6qbHzW6vIBUJ9oMgKrqwDvnNC/G/D21tMlDnBp+71Et5NfMRxGLtKPU/O2qarBey
         /PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93GncC/YMq/sLoJhUEjsPCJ56rRoBeF7sm8+y73s7Mk=;
        b=4cTCz+aTmQcuQul0yTpS8xagK5QeCpbldIVgLMmPlyCw7etmW3u321pVS/EVNimRP4
         YeYS20EscsFIY2Bvmc0lqFkQDhGaVIY01xd9wpGIoDyhlvQK+rlui1LCac1LS2PHJCTY
         tafW3xt1NJgwiFfJpKUk1Ezh26dcEzuAd5C6QhOCjGxXyV2grrH2GAGxyPxLTfHqHC3i
         GXVLLP2xwMrmnb51DBn/b80B6nFRQGnJjXdd+N5ONo7QIKMFfnmplIimj78cfavMZJwq
         umTgKuGodXpzMvnwMJRqHvvPQUKG+vgII5hbyZcbIWpO2rvQgIJOHpxc6xMnIDYGyVyU
         aUjA==
X-Gm-Message-State: AO0yUKXJU5tCFBwXIz5g+ix9KmESUfQug3q87QH+gfD69GUnetOsBkvi
        m+uU8LIK/ywRSicu//jxc7w=
X-Google-Smtp-Source: AK7set+5TsQLLq8jvQah+3Ch7FDP4duQj6VzOpjRIUXYKG9wJPfXn9hnPOz+M9oBSvDU76T6n9ORQA==
X-Received: by 2002:a5d:67c8:0:b0:2c6:75be:f2d7 with SMTP id n8-20020a5d67c8000000b002c675bef2d7mr6843257wrw.51.1677091220529;
        Wed, 22 Feb 2023 10:40:20 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:20 -0800 (PST)
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
Subject: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new compatible strings
Date:   Wed, 22 Feb 2023 21:39:23 +0300
Message-Id: <20230222183932.33267-8-arinc.unal@arinc9.com>
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

Add the ralink,rt2880-pinmux compatible string. It had been removed from
the driver which broke the ABI.

Add the mediatek compatible strings. Change the compatible string on the
examples with the mediatek compatible strings.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 1e63ea34146a..531b5f616c3d 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -17,7 +17,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7620-pinctrl
+    enum:
+      - mediatek,mt7620-pinctrl
+      - ralink,mt7620-pinctrl
+      - ralink,rt2880-pinmux
 
 patternProperties:
   '-pins$':
@@ -647,7 +650,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,mt7620-pinctrl";
+      compatible = "mediatek,mt7620-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 1b1d37b981d9..74923ca35c81 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -17,7 +17,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7621-pinctrl
+    enum:
+      - mediatek,mt7621-pinctrl
+      - ralink,mt7621-pinctrl
+      - ralink,rt2880-pinmux
 
 patternProperties:
   '-pins$':
@@ -251,7 +254,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,mt7621-pinctrl";
+      compatible = "mediatek,mt7621-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 7fd0df880a76..aceea6248614 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -17,7 +17,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt2880-pinctrl
+    enum:
+      - mediatek,rt2880-pinctrl
+      - ralink,rt2880-pinctrl
+      - ralink,rt2880-pinmux
 
 patternProperties:
   '-pins$':
@@ -131,7 +134,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,rt2880-pinctrl";
+      compatible = "mediatek,rt2880-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 4d66ca752a30..4c87fe201809 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -18,7 +18,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt305x-pinctrl
+    enum:
+      - mediatek,rt305x-pinctrl
+      - ralink,rt305x-pinctrl
+      - ralink,rt2880-pinmux
 
 patternProperties:
   '-pins$':
@@ -264,7 +267,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,rt305x-pinctrl";
+      compatible = "mediatek,rt305x-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 008d93181aea..71049a2b2779 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -17,7 +17,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt3883-pinctrl
+    enum:
+      - mediatek,rt3883-pinctrl
+      - ralink,rt3883-pinctrl
+      - ralink,rt2880-pinmux
 
 patternProperties:
   '-pins$':
@@ -251,7 +254,7 @@ additionalProperties: false
 examples:
   - |
     pinctrl {
-      compatible = "ralink,rt3883-pinctrl";
+      compatible = "mediatek,rt3883-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
-- 
2.37.2

