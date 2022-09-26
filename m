Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430D5EB020
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIZSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIZShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:45 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E936714B;
        Mon, 26 Sep 2022 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=C74rqivx+N+6zuXC/egdmBHbQEJxHH+CvqYoF/RHe8Y=; b=RifnPLG0VWe/0BtO0Lnr66d6bS
        jI6B4TpkDV98xItnvFto5xcI8NQj9sz98UPxEZUQwFlE+BpAgHW+5XdFSjXHuu/Tiw4QrchXb0djH
        ulPi5WfxcQ7y6JvfYT8jansjm1Z8RYVcxkWOrbO88wNNBY6pXPC/xVCxVJR4E90zGxQMj9w4OYmwM
        9jjM0VWpTIOvvFObc/NSlJPI9DRLxkS977xSzPBMkf1dIfUhGsuCwYZJMHiwLUuv7V+NtUJDeJ8nI
        5wIOIG2f5KQjqIcpzgkcDjWQEFDMnPOq37t7Y7r4h6ho1U1+7M8BbQvbfmUhaIeqe9G2ZT5XoCAnf
        66ToPTnw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz3-00B9PW-8V; Mon, 26 Sep 2022 20:37:37 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wc6-1e;
        Mon, 26 Sep 2022 20:37:35 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 05/13] arm64: dts: rockchip: Add analog audio on ODROID-M1
Date:   Mon, 26 Sep 2022 20:37:19 +0200
Message-Id: <20220926183727.1893566-6-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926183727.1893566-1-aurelien@aurel32.net>
References: <20220926183727.1893566-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the ODROID-M1, the I2S1 TDM controller is connected to the rk809
codec in I2S mode. It is used to provide a stereo headphones output and
a mono speaker output. A GPIO with an external pullup is used as an
headphone detection input.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 877b9515ad98..3079abbec5dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -59,6 +59,31 @@ led_work: led-1 {
 		};
 	};
 
+	rk809-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det_pin>;
+		simple-audio-card,name = "Analog RK817";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphones",
+			"Speaker", "Speaker";
+		simple-audio-card,routing =
+			"Headphones", "HPOL",
+			"Headphones", "HPOR",
+			"Speaker", "SPKO";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	vcc3v3_sys: vcc3v3-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
@@ -131,10 +156,15 @@ rk809: pmic@20 {
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
 		#clock-cells = <1>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
 		vcc1-supply = <&vcc3v3_sys>;
 		vcc2-supply = <&vcc3v3_sys>;
 		vcc3-supply = <&vcc3v3_sys>;
@@ -340,6 +370,11 @@ regulator-state-mem {
 	};
 };
 
+&i2s1_8ch {
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
 &mdio0 {
 	rgmii_phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -365,6 +400,12 @@ pmic_int_l: pmic-int-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	rk809 {
+		hp_det_pin: hp-det-pin {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pmu_io_domains {
-- 
2.35.1

