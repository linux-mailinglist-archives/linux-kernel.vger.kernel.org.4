Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2781961E0BC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKFIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKFIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:01:32 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE356353;
        Sun,  6 Nov 2022 01:01:31 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 3D64E604C3;
        Sun,  6 Nov 2022 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667721690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHVO61sMpRHTxKeTwC3bQjHXnh5eWGHHpN5gb6vKtgc=;
        b=YcXi9KioWqywKeslw1CSVwgIpPPBqSnWmU/T/7zpHpkPG70MAcld+jx1xJTNjGw7LIDJ2q
        4tL3cumd7hbidPickQ+sGRYf2v78KQPyNo4H09iYhEHfUr4Wd2r9jXBO30JMicskfNgdcr
        7uRFy33CnM/M29UyC/kY9pTpLu+802c=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 9223A3602A8;
        Sun,  6 Nov 2022 08:01:29 +0000 (UTC)
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
Subject: [PATCH v2 3/6] dt-bindings: pinctrl: mt7986: add generic bias-pull* support
Date:   Sun,  6 Nov 2022 09:01:10 +0100
Message-Id: <20221106080114.7426-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106080114.7426-1-linux@fw-web.de>
References: <20221106080114.7426-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 5333ed4a-a8b8-42f9-93fa-0fd8ca8d62b3
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

