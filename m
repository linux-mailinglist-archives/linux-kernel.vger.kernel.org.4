Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C025EB023
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiIZSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIZShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:45 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2596969F4D;
        Mon, 26 Sep 2022 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=tAMiyMHYmqcRKZ4q0pvNj3OkA4K0ziUgR23bk4hzW2E=; b=V1s0PGxmNrVvjc01X106nIEY/o
        L/Y/0zT8Ea5qb+ckHtyh7ssuf2B8N1/jm7PWkRmgu9CgATg/JYy8dcubBKZu3JXZBSDbz/xmxuvMu
        e3g6wa1RoWNi4vGsIATwjNtJtl3tYV0uHoEdT7yJ9KHToXoAoCURvBWx3zbi9SG2o0FuE62OMb9ZM
        uBTmnCi75HJmk1uJP13DylH0pr+cSrFfzt8yMKGuToV4SOWL3ZUw+21rFnxS9w9M6/x84mYK9Hun+
        9ZVhHyiNwybDs0Bz+Y2ZaB+cd7tq1Q+9eaUaPGZi5C2HCP5Nw+uq7o784eWjP1t1KgxyIluc1FWPW
        PjQ9vjEA==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz4-00B9Pb-86; Mon, 26 Sep 2022 20:37:38 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wcP-23;
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
Subject: [PATCH v2 10/13] arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
Date:   Mon, 26 Sep 2022 20:37:24 +0200
Message-Id: <20220926183727.1893566-11-aurelien@aurel32.net>
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

The Rockchip RK3568 has two USB XHCI controllers. The USB 2.0 signals
are connected to a PHY providing one host-only port and one OTG port.
The USB 3.0 signals are connected to two USB3.0/PCIE/SATA combo PHY.

The ODROID M1 has 2 type A USB 3.0 connectors, with the USB 3.0 signals
connected to the two combo PHYs. For the USB 2.0 signals, one connector
is connected to the host-only PHY and uses the same power switch as the
USB 2.0 ports. The other connector has its own power switch and is
connected to the OTG PHY, which is also connected to a device only
micro-USB connector. The purpose of this micro-USB connector is for
firmware update using the Rockusb vendor specific USB class. Therefore
it does not make sense to enable this port on Linux, and the PHY is
forced to host mode.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 595f56c41a15..8f7c9dd8c47c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -127,6 +127,30 @@ vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb_otg";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en_pin>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy0 {
+	/* Used for USB3 */
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&combphy1 {
+	/* Used for USB3 */
+	phy-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
 };
 
 &cpu0 {
@@ -476,7 +500,7 @@ usb {
 		vcc5v0_usb_host_en_pin: vcc5v0-usb-host-en-pin {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-		vcc5v0_usb_otg_en_pin: vcc5v0-usb-otg-en-pin {
+		vcc5v0_usb_otg_en_pin: vcc5v0-usb-dr-en-pin {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
@@ -585,6 +609,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -593,6 +622,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.35.1

