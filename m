Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C673B244
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFWIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFWIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:01:47 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DC4E1BE2;
        Fri, 23 Jun 2023 01:01:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,151,1684767600"; 
   d="scan'208";a="168666974"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jun 2023 17:01:44 +0900
Received: from mulinux.home (unknown [10.226.93.17])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 838C4400B9F5;
        Fri, 23 Jun 2023 17:01:40 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl names
Date:   Fri, 23 Jun 2023 09:01:35 +0100
Message-Id: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        LOTS_OF_MONEY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original commit uses the same names ("data" and "ctrl")
for the subnodes of pinctrl definitions for both eMMC and
SDHI0 (emmc_pins, sdhi0_pins, and sdhi0_pins_uhs) leading to
the below issue:

pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 85000000.mmc; cannot claim for 85020000.mmc
pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reverse things back

This commit fixes the problem by making the names for the
pinctrl subnodes of eMMC and SDHI0 unique.

Fixes: b6c0be722b0c ("arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 39fe3f94991e..11c5cffea5a5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -167,7 +167,7 @@ &i2c2 {
 
 &pinctrl {
 	emmc_pins: emmc {
-		data {
+		emmc_data {
 			pinmux = <RZV2M_PORT_PINMUX(0, 0, 2)>, /* MMDAT0 */
 				 <RZV2M_PORT_PINMUX(0, 1, 2)>, /* MMDAT1 */
 				 <RZV2M_PORT_PINMUX(0, 2, 2)>, /* MMDAT2 */
@@ -179,7 +179,7 @@ data {
 			power-source = <1800>;
 		};
 
-		ctrl {
+		emmc_ctrl {
 			pinmux = <RZV2M_PORT_PINMUX(0, 10, 2)>, /* MMCMD */
 				 <RZV2M_PORT_PINMUX(0, 11, 2)>; /* MMCLK */
 			power-source = <1800>;
@@ -197,7 +197,7 @@ i2c2_pins: i2c2 {
 	};
 
 	sdhi0_pins: sd0 {
-		data {
+		sd0_data {
 			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
 				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
 				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
@@ -205,20 +205,20 @@ data {
 			power-source = <3300>;
 		};
 
-		ctrl {
+		sd0_ctrl {
 			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
 				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
 			power-source = <3300>;
 		};
 
-		cd {
+		sd0_cd {
 			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
 			power-source = <3300>;
 		};
 	};
 
 	sdhi0_pins_uhs: sd0-uhs {
-		data {
+		sd0_uhs_data {
 			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
 				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
 				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
@@ -226,13 +226,13 @@ data {
 			power-source = <1800>;
 		};
 
-		ctrl {
+		sd0_uhs_ctrl {
 			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
 				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
 			power-source = <1800>;
 		};
 
-		cd {
+		sd0_uhs_cd {
 			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
 			power-source = <1800>;
 		};
-- 
2.34.1

