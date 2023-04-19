Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386256E81BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjDSTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDSTQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:16:04 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F85B99;
        Wed, 19 Apr 2023 12:16:00 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1ppDHa-0003rR-2a;
        Wed, 19 Apr 2023 21:15:58 +0200
Date:   Wed, 19 Apr 2023 20:15:53 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] arm64: dts: mt7622: declare SPI-NAND present on BPI-R64
Message-ID: <ZEA96dmaXqTpk8u8@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI-NOR node in the device tree of the BananaPi R64 has most likely
been copied from the reference board's device tree even though the R64
comes with an SPI-NAND chip rather than SPI-NOR.

Setup the Serial NAND Flash Interface (SNFI) controller, enable
hardware BCH error detection and correction engine and add the SPI-NAND
chip including basic partitions,

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index af3fe61e40938..d583e816684cf 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -248,14 +248,42 @@ &nandc {
 	status = "disabled";
 };
 
-&nor_flash {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_nor_pins>;
-	status = "disabled";
+&bch {
+	status = "okay";
+};
 
+&snfi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial_nand_pins>;
+	status = "okay";
 	flash@0 {
-		compatible = "jedec,spi-nor";
+		compatible = "spi-nand";
 		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		nand-ecc-engine = <&snfi>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bl2";
+				reg = <0x0 0x80000>;
+				read-only;
+			};
+
+			partition@80000 {
+				label = "fip";
+				reg = <0x80000 0x200000>;
+				read-only;
+			};
+
+			ubi: partition@280000 {
+				label = "ubi";
+				reg = <0x280000 0x7d80000>;
+			};
+		};
 	};
 };
 

base-commit: 13961ef828cbc254cc272221b7fc54851caa39a7
-- 
2.40.0

