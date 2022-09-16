Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39FD5BA945
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiIPJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:18:14 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3A3135E;
        Fri, 16 Sep 2022 02:18:12 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B6692000E;
        Fri, 16 Sep 2022 09:18:07 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linus.walleij@linaro.org, david@ixit.cz,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: add i2s0 I2S/PDM/TDM 8ch controller to px30
Date:   Fri, 16 Sep 2022 11:17:46 +0200
Message-Id: <20220916091746.35108-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The Rockchip PX30 SoC has three I2S controllers, i2s1 and i2s2 are
2-channel I2S/PCM controllers handled by the same controller driver, and
i2s0 a 8-channel I2S/PCM/TDM controller handled by another controller
driver.

This adds the device tree node required to enable I2S0 on PX30.

This was tested in a 2-channel I2S with TX BCLK/LRCK for both TX and RX
(rockchip,trcm-sync-tx-only) setup on a soon-to-be-released board.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 214f94fea3dc..bfa3580429d1 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -365,6 +365,28 @@ uart0: serial@ff030000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@ff060000 {
+		compatible = "rockchip,px30-i2s-tdm";
+		reg = <0x0 0xff060000 0x0 0x1000>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S0_TX>, <&cru SCLK_I2S0_RX>, <&cru HCLK_I2S0>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac 16>, <&dmac 17>;
+		dma-names = "tx", "rx";
+		rockchip,grf = <&grf>;
+		resets = <&cru SRST_I2S0_TX>, <&cru SRST_I2S0_RX>;
+		reset-names = "tx-m", "rx-m";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_8ch_sclktx &i2s0_8ch_sclkrx
+			     &i2s0_8ch_lrcktx &i2s0_8ch_lrckrx
+			     &i2s0_8ch_sdo0 &i2s0_8ch_sdi0
+			     &i2s0_8ch_sdo1 &i2s0_8ch_sdi1
+			     &i2s0_8ch_sdo2 &i2s0_8ch_sdi2
+			     &i2s0_8ch_sdo3 &i2s0_8ch_sdi3>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2s1_2ch: i2s@ff070000 {
 		compatible = "rockchip,px30-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff070000 0x0 0x1000>;
-- 
2.37.3

