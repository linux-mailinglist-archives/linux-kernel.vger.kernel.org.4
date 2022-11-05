Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29361D914
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKEJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:25:15 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE012D1D2;
        Sat,  5 Nov 2022 02:25:14 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 0559C3FF4C;
        Sat,  5 Nov 2022 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667640313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uo/Ed4Y8qzNEfRX3DlUQeK2B620x/akI0gmr6lmZoIk=;
        b=tJRiiCW4T8C535oIw7XEGzfdHkLOJEeBTBHNc+7v+rRh5FxfmBDPtnXVa7z59fwFQBURQZ
        ep58WRxghVtLoG4LCiNVASVMlGQbGrd9Mpi/NL8k4HpJFg2EDWi/BSatEf/GY+WThn7TT8
        qTMvIA3EGswSmHvvGkerktD/Ddf3dCA=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id EEEBC1003E5;
        Sat,  5 Nov 2022 09:25:11 +0000 (UTC)
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
Subject: [PATCH v3] dt-bindings: pinctrl: update uart/mmc bindings for MT7986 SoC
Date:   Sat,  5 Nov 2022 10:25:00 +0100
Message-Id: <20221105092500.12145-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 19b8833f-3e9d-48d4-bf07-755f1bc822c7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Some pinmux pins of the mt7986 pinctrl driver is composed of multiple
pinctrl groups, the original binding only allows one pinctrl group
per dts node, this patch sets "maxItems" for these groups and add new
examples to the binding documentation.

Fixes: 65916a1ca90a ("dt-bindings: pinctrl: update bindings for MT7986 SoC")
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
sorry, messed up email-list, so resend it

v3:
- squashed version from sam
- v2 was ack'd by Krzysztof, but sams patch included updated emmc-names
  and different structure for uart to allow 2 pingroups
v2:
- wrap on col 80
---
 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 75766956cfad..b2b9c01efd70 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -87,6 +87,8 @@ patternProperties:
           "wifi_led"        "led"       1, 2
           "i2c"             "i2c"       3, 4
           "uart1_0"         "uart"      7, 8, 9, 10
+          "uart1_rx_tx"     "uart"      42, 43
+          "uart1_cts_rts"   "uart"      44, 45
           "pcie_clk"        "pcie"      9
           "pcie_wake"       "pcie"      10
           "spi1_0"          "spi"       11, 12, 13, 14
@@ -98,9 +100,11 @@ patternProperties:
           "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30,
                                         31, 32
           "spi1_1"          "spi"       23, 24, 25, 26
-          "uart1_2"         "uart"      29, 30, 31, 32
+          "uart1_2_rx_tx"   "uart"      29, 30
+          "uart1_2_cts_rts" "uart"      31, 32
           "uart1_1"         "uart"      23, 24, 25, 26
-          "uart2_0"         "uart"      29, 30, 31, 32
+          "uart2_0_rx_tx"   "uart"      29, 30
+          "uart2_0_cts_rts" "uart"      31, 32
           "spi0"            "spi"       33, 34, 35, 36
           "spi0_wp_hold"    "spi"       37, 38
           "uart1_3_rx_tx"   "uart"      35, 36
@@ -157,7 +161,7 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [emmc, emmc_rst]
+                  enum: [emmc_45, emmc_51]
           - if:
               properties:
                 function:
@@ -227,8 +231,12 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [uart1_0, uart1_1, uart1_2, uart1_3_rx_tx,
-                         uart1_3_cts_rts, uart2_0, uart2_1, uart0, uart1, uart2]
+                  items:
+                    enum: [uart1_0, uart1_rx_tx, uart1_cts_rts, uart1_1,
+                           uart1_2_rx_tx, uart1_2_cts_rts, uart1_3_rx_tx,
+                           uart1_3_cts_rts, uart2_0_rx_tx, uart2_0_cts_rts,
+                           uart2_1, uart0, uart1, uart2]
+                  maxItems: 2
           - if:
               properties:
                 function:
@@ -362,6 +370,27 @@ examples:
         interrupt-parent = <&gic>;
         #interrupt-cells = <2>;
 
+        pcie_pins: pcie-pins {
+          mux {
+            function = "pcie";
+            groups = "pcie_clk", "pcie_wake", "pcie_pereset";
+          };
+        };
+
+        pwm_pins: pwm-pins {
+          mux {
+            function = "pwm";
+            groups = "pwm0", "pwm1_0";
+          };
+        };
+
+        spi0_pins: spi0-pins {
+          mux {
+            function = "spi";
+            groups = "spi0", "spi0_wp_hold";
+          };
+        };
+
         uart1_pins: uart1-pins {
           mux {
             function = "uart";
@@ -369,6 +398,13 @@ examples:
           };
         };
 
+        uart1_3_pins: uart1-3-pins {
+          mux {
+            function = "uart";
+            groups = "uart1_3_rx_tx", "uart1_3_cts_rts";
+          };
+        };
+
         uart2_pins: uart2-pins {
           mux {
             function = "uart";
-- 
2.34.1

