Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5355F0434
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiI3FOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiI3FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:13:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E861664A9;
        Thu, 29 Sep 2022 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=CzlWQu3A1mClcSu8Q/+U0oU9SfnYjCXu1cD9OxHY0xA=; b=Pr99J+e7Xmh2eC7NtAyWjs9UyS
        V5p1C8QM9DSIzKalgw6gibz3OB97t3La6sxPtS4A6eMiJHN0gtxV2z23KWFVW2+dwUR0sqAgqCOo6
        Dpu38kFowhi8NakcfbrxMcaGnKh+dbV39ZDRvzjn8N/4+KODMSQhUQfKAD6iEjzjd+EhmxRWEFoOD
        2+c4eTc7AL+LniqUASXtlMSlNhUc04Uhuap3e5xUXBWZ0u2pSn9bRL85ln5KVxlXRv1R/qC70Blj/
        lX8jOUvrRLOuBQ84G4adcmadHOddVUVes1ykokV5SFFrxyrY0MlDnQ8mA5NIT1F1PzjYliWQ9E/6f
        XQOXpZgQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kd-00DjeY-9F; Fri, 30 Sep 2022 07:13:03 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kc-001duk-2S;
        Fri, 30 Sep 2022 07:13:02 +0200
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
Subject: [PATCH v3 04/13] arm64: dts: rockchip: Add NOR flash to ODROID-M1
Date:   Fri, 30 Sep 2022 07:12:37 +0200
Message-Id: <20220930051246.391614-5-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930051246.391614-1-aurelien@aurel32.net>
References: <20220930051246.391614-1-aurelien@aurel32.net>
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

Enable the Rockchip Serial Flash Controller for the ODROID-M1 and add
the corresponding SPI NOR flash entry. The SFC is used in dual I/O mode
and not quad I/O mode, as the FSPI_D2 pin is shared with the EMMC_RSTn
pin.

The partitions addresses and sizes are taken from the ODROID-M1
Partition Table page on the ODROID wiki.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 112c65af3f55..94e839c9afab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -351,6 +351,20 @@ rgmii_phy0: ethernet-phy@0 {
 };
 
 &pinctrl {
+	fspi {
+		fspi_dual_io_pins: fspi-dual-io-pins {
+			rockchip,pins =
+				/* fspi_clk */
+				<1 RK_PD0 1 &pcfg_pull_none>,
+				/* fspi_cs0n */
+				<1 RK_PD3 1 &pcfg_pull_none>,
+				/* fspi_d0 */
+				<1 RK_PD1 1 &pcfg_pull_none>,
+				/* fspi_d1 */
+				<1 RK_PD2 1 &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		led_power_pin: led-power-pin {
 			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -409,6 +423,50 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&sfc {
+	/* Dual I/O mode as the D2 pin conflicts with the eMMC */
+	pinctrl-0 = <&fspi_dual_io_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "SPL";
+				reg = <0x0 0xe0000>;
+			};
+			partition@e0000 {
+				label = "U-Boot Env";
+				reg = <0xe0000 0x20000>;
+			};
+			partition@100000 {
+				label = "U-Boot";
+				reg = <0x100000 0x200000>;
+			};
+			partition@300000 {
+				label = "splash";
+				reg = <0x300000 0x100000>;
+			};
+			partition@400000 {
+				label = "Filesystem";
+				reg = <0x400000 0xc00000>;
+			};
+		};
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.35.1

