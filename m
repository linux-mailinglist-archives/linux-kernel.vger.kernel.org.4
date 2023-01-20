Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8BF674925
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjATCFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATCFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:05:50 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DBA5780;
        Thu, 19 Jan 2023 18:05:49 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15f83e0fc63so4728595fac.11;
        Thu, 19 Jan 2023 18:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahhjesBQPoRdOxI0FPgtGG53bpvUK7B+pZWktlNNyHw=;
        b=DpAyh35U0WNEKT3DcELoBmWIRAZrNOI6r2J7FpvZ6us+uU+Nh2Uy5LjHwl7mD5q+VX
         LD8oB0VSPKqvPi21BmHkAAroBaogIXEz6AgvueEOcxmv3q04/htjJ/zmUDWZF1iOccTt
         OQPy6N1Dtt6k4Lqd3fL04Qr0WNzbWednpuIRvektvmYsJZSo5/RM44cun+8zITjKa6X2
         UilVP6g/lbjENEjqxIF0Y06dtTPd1XDMaUlCpwHqviYvkqvCaUxUz53ugnzuqT0eoUYc
         MBb71m//EuOdMvOWTjFjNiOoeixrv21FQuVkKhi19YN1/oNZj/4ZnCIN4/fV1AmVeq6x
         8DWQ==
X-Gm-Message-State: AFqh2kogduizTXkL5Qlya0EEhFweeisZUv3FzlFGEZgDzdxwU5ZMz63q
        V2tRXxzFPJZe3O5eg8pPyA==
X-Google-Smtp-Source: AMrXdXuVokQY0W5Usg208to2n7Uk2JpiCm76ol2hFYEa7ATCcSTjsWD0UYD70pahcOTNicoL/zCxlQ==
X-Received: by 2002:a05:6870:54d4:b0:15f:2ffe:8d54 with SMTP id g20-20020a05687054d400b0015f2ffe8d54mr7546883oan.47.1674180348439;
        Thu, 19 Jan 2023 18:05:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z13-20020a05687042cd00b0015f83e16a10sm4073504oah.44.2023.01.19.18.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:05:47 -0800 (PST)
Received: (nullmailer pid 3230582 invoked by uid 1000);
        Fri, 20 Jan 2023 02:05:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: mediatek: Fix child node name patterns
Date:   Thu, 19 Jan 2023 20:05:36 -0600
Message-Id: <20230120020536.3229300-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The child node name patterns in Mediatek pinctrl bindings don't match
reality. I don't know where '-[0-9]+$' came from, but I don't see any nodes
with a matching pattern. Also, patterns such as 'pins' or 'mux' are
ambiguous because any prefix or suffix is allowed. If that's desired, it
should be explicit.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml    | 12 ++++++------
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml    |  8 ++++----
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml    |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index 1b44335b1e94..a55c8e4ff26e 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -70,11 +70,11 @@ allOf:
   - $ref: "pinctrl.yaml#"
 
 patternProperties:
-  '-[0-9]+$':
+  'pins$':
     type: object
     additionalProperties: false
     patternProperties:
-      'pins':
+      '(^pins|pins?$)':
         type: object
         additionalProperties: false
         description: |
@@ -158,7 +158,7 @@ examples:
               <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
               <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 
-          i2c0_pins_a: i2c0-0 {
+          i2c0_pins_a: i2c0-pins {
             pins1 {
               pinmux = <MT8135_PIN_100_SDA0__FUNC_SDA0>,
                 <MT8135_PIN_101_SCL0__FUNC_SCL0>;
@@ -166,7 +166,7 @@ examples:
             };
           };
 
-          i2c1_pins_a: i2c1-0 {
+          i2c1_pins_a: i2c1-pins {
             pins {
               pinmux = <MT8135_PIN_195_SDA1__FUNC_SDA1>,
                 <MT8135_PIN_196_SCL1__FUNC_SCL1>;
@@ -174,7 +174,7 @@ examples:
             };
           };
 
-          i2c2_pins_a: i2c2-0 {
+          i2c2_pins_a: i2c2-pins {
             pins1 {
               pinmux = <MT8135_PIN_193_SDA2__FUNC_SDA2>;
               bias-pull-down;
@@ -186,7 +186,7 @@ examples:
             };
           };
 
-          i2c3_pins_a: i2c3-0 {
+          i2c3_pins_a: i2c3-pins {
             pins1 {
               pinmux = <MT8135_PIN_40_DAC_CLK__FUNC_GPIO40>,
                 <MT8135_PIN_41_DAC_WS__FUNC_GPIO41>;
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index c9ea0cad489b..ac93eb8f01a6 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -61,11 +61,11 @@ then:
     - "#interrupt-cells"
 
 patternProperties:
-  '-[0-9]+$':
+  '-pins(-[a-z]+)?$':
     type: object
     additionalProperties: false
     patternProperties:
-      'mux':
+      '^mux(-|$)':
         type: object
         additionalProperties: false
         description: |
@@ -244,7 +244,7 @@ patternProperties:
                 groups:
                   enum: [wf0_2g, wf0_5g]
 
-      'conf':
+      '^conf(-|$)':
         type: object
         additionalProperties: false
         description: |
@@ -348,7 +348,7 @@ examples:
           gpio-controller;
           #gpio-cells = <2>;
 
-          pinctrl_eth_default: eth-0 {
+          pinctrl_eth_default: eth-pins {
             mux-mdio {
               groups = "mdc_mdio";
               function = "eth";
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index 0d2484056a0f..c30cd0d010dd 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -67,11 +67,11 @@ required:
   - gpio-ranges
 
 patternProperties:
-  '-[0-9]+$':
+  '-pins(-[a-z]+)?$':
     type: object
     additionalProperties: false
     patternProperties:
-      'pins':
+      '^pins':
         type: object
         additionalProperties: false
         description: |
@@ -210,7 +210,7 @@ examples:
           interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
           #interrupt-cells = <2>;
 
-          i2c0_pins_a: i2c-0 {
+          i2c0_pins_a: i2c0-pins {
             pins1 {
               pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
                 <PINMUX_GPIO49__FUNC_SDA5>;
@@ -219,7 +219,7 @@ examples:
             };
           };
 
-          i2c1_pins_a: i2c-1 {
+          i2c1_pins_a: i2c1-pins {
             pins {
               pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
                 <PINMUX_GPIO51__FUNC_SDA3>;
-- 
2.39.0

