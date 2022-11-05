Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539361D8E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKEItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKEItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:49:20 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF092251B;
        Sat,  5 Nov 2022 01:49:17 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 2A4295FC59;
        Sat,  5 Nov 2022 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667638156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHVO61sMpRHTxKeTwC3bQjHXnh5eWGHHpN5gb6vKtgc=;
        b=dlXu0jSWNQwNTQJIZrwdsITPltGvR3rP+HMF9m7a1iDRR4Wbc0IpY55eH2PjQBa0twnde/
        WiWUuZA53S0GO0CiO8lbUeXN5MtjdhuO67gPL5tRRKEvypbMlxFdEhIYB5qQCyKUBzI+GF
        PYawopFRghqx8B0FOLpx0rlwzRBwGKA=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 706811003E5;
        Sat,  5 Nov 2022 08:49:15 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: pinctrl: mt7986: add generic bias-pull* support
Date:   Sat,  5 Nov 2022 09:49:02 +0100
Message-Id: <20221105084905.9596-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105084905.9596-1-linux@fw-web.de>
References: <20221105084905.9596-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e97ff404-521a-4664-9485-df946569a965
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

Since the bias-pull-{up,down} attribute already defines in pinctrl driver
of mediatek MT7986 SoC, this patch updates bindings to support mediatek
common bias-pull* function.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 50 +++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index b2b9c01efd70..216b356cd519 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -292,9 +292,23 @@ patternProperties:
 
           bias-disable: true
 
-          bias-pull-up: true
-
-          bias-pull-down: true
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+                description: normal pull up.
+              - enum: [100, 101, 102, 103]
+                description: |
+                  PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
+                  dt-bindings/pinctrl/mt65xx.h.
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+                description: normal pull down.
+              - enum: [100, 101, 102, 103]
+                description: |
+                  PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
+                  dt-bindings/pinctrl/mt65xx.h.
 
           input-enable: true
 
@@ -346,6 +360,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/pinctrl/mt65xx.h>
 
     soc {
       #address-cells = <2>;
@@ -412,5 +427,34 @@ examples:
           };
         };
 
+        mmc0_pins_default: mmc0-pins {
+          mux {
+            function = "emmc";
+            groups = "emmc_51";
+          };
+          conf-cmd-dat {
+            pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+                   "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+                   "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+            input-enable;
+            drive-strength = <4>;
+            bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+          };
+          conf-clk {
+            pins = "EMMC_CK";
+            drive-strength = <6>;
+            bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+          };
+          conf-ds {
+            pins = "EMMC_DSL";
+            bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+          };
+          conf-rst {
+            pins = "EMMC_RSTB";
+            drive-strength = <4>;
+            bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+          };
+        };
+
       };
     };
-- 
2.34.1

