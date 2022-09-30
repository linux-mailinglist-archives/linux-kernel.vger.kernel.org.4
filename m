Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAF5F042D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiI3FN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiI3FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:13:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C669C1664A6;
        Thu, 29 Sep 2022 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=qq4c1qCdY2ad+VBqPzxONr8nb5OSEU3D+xvzA/5hS94=; b=DQm0aLh2wAjdj0mnH7/WqBHljL
        4DiNuZueJ+b3gbMvsQhBL0rUmeqNo5ovtp4XP1erR4I5cNr19o3HD3EejDoOd64qtG1RyKSqyMLhh
        XfbbCnDB8UGp19qv7vxKgGCYUbMaBhbOb6wIUbXYEEPg2vnVIgKOPTQU8GoEQU9CX5DXSoLGpqui1
        zaD8LTs8UvQH5ziHj6gfuTH+NmQxcuCbw7btH07/tNAgxFin5q1g9etBS7KdH5CbZdIEm+GXX3jvy
        n6O2BsZK7eylg+0gDUlVbNP3XADqrJ6IZwHKFL86PmpQ7RLTsTBlYCw39+ueTV265wmpK6R2lu9zV
        0jbQN4ag==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kf-00Djfi-Jv; Fri, 30 Sep 2022 07:13:05 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Ke-001dvv-3A;
        Fri, 30 Sep 2022 07:13:04 +0200
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
        Aurelien Jarno <aurelien@aurel32.net>,
        Dan Johansen <strit@manjaro.org>
Subject: [PATCH v3 10/13] arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
Date:   Fri, 30 Sep 2022 07:12:43 +0200
Message-Id: <20220930051246.391614-11-aurelien@aurel32.net>
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
Tested-by: Dan Johansen <strit@manjaro.org>
---
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 2e4cc20bd676..9a84a7e76d7a 100644
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
@@ -490,7 +514,7 @@ usb {
 		vcc5v0_usb_host_en_pin: vcc5v0-usb-host-en-pin {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-		vcc5v0_usb_otg_en_pin: vcc5v0-usb-otg-en-pin {
+		vcc5v0_usb_otg_en_pin: vcc5v0-usb-dr-en-pin {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
@@ -600,6 +624,11 @@ &usb_host0_ohci {
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
@@ -608,6 +637,24 @@ &usb_host1_ohci {
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

