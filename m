Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296276785C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjAWTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:06:26 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166C2FCF6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:06:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:6083:1fd7:ba05:ea8d])
        by michel.telenet-ops.be with bizsmtp
        id CK6L2900F4604Ck06K6Lbw; Mon, 23 Jan 2023 20:06:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pK28y-0076NW-LM;
        Mon, 23 Jan 2023 20:06:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pK296-00Ekpx-Iu;
        Mon, 23 Jan 2023 20:06:20 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] arm64: dts: renesas: white-hawk: Add CAN-FD support
Date:   Mon, 23 Jan 2023 20:06:19 +0100
Message-Id: <a19d0a70aacaf4c3517a226bf32ea49db3542da4.1674500205.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1674500205.git.geert+renesas@glider.be>
References: <cover.1674500205.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable confirmed-working CAN-FD channels 0 and 1 on the White-Hawk
development board:
  - Channel 0 uses an NXP TJR1443AT CAN transceiver, which is be enabled
    through a GPIO,
  - Channels 1-7 use Microchip MCP2558FD-H/SN CAN transceivers (not
    mounted for channels 4-7), which do not need explicit description,
    but channels 2-3 do not seem to work.

Inspired by a patch in the BSP by Kazuya Mizuguch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH 2/2] phy: phy-can-transceiver: Add support for
NXP TJR1443"
https://lore.kernel.org/all/0bfa1e4c43632e49c9512b4e7daa970545545dcf.1674037830.git.geert+renesas@glider.be

Changed compared to the BSP:
  - Add can_clk,
  - Add missing can_transceiver0,
  - Disable channels 2-7.

Tested using cansend, candump, and canfdtest.

  - Channel 2 does not work: "bus-off" error message.

  - Channel 3 does not work:
      - Using cansend on another interface, and candump on can3 shows
	that nothing is received.
	However, my scope does see the data on the bus, and it is not
	sent repeatedly, hence it must have been acked by the receiver.

      - Using canfdtest on can3 gives:

          can3: Message ID mismatch!
            expected: 0078: [8] 01 02 03 04 05 06 07 08
            received: 0077: [8] 00 01 02 03 04 05 06 07

Note that describing a plain gpio-hog instead of can_transceiver0 is not
sufficient, as the enable signal must not be asserted before
initialization of the CAN-FD controller,
---
 .../boot/dts/renesas/r8a779g0-white-hawk.dts  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
index 04a2b6b83e743f32..eff1ef6e2cc83aba 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
@@ -13,6 +13,33 @@
 / {
 	model = "Renesas White Hawk CPU and Breakout boards based on r8a779g0";
 	compatible = "renesas,white-hawk-breakout", "renesas,white-hawk-cpu", "renesas,r8a779g0";
+
+	can_transceiver0: can-phy0 {
+		compatible = "nxp,tjr1443";
+		#phy-cells = <0>;
+		enable-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		max-bitrate = <5000000>;
+	};
+};
+
+&can_clk {
+	clock-frequency = <40000000>;
+};
+
+&canfd {
+	pinctrl-0 = <&canfd0_pins>, <&canfd1_pins>, <&can_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	channel0 {
+		status = "okay";
+		phys = <&can_transceiver0>;
+	};
+
+	channel1 {
+		status = "okay";
+	};
 };
 
 &i2c0 {
@@ -23,3 +50,20 @@ eeprom@51 {
 		pagesize = <8>;
 	};
 };
+
+&pfc {
+	can_clk_pins: can-clk {
+		groups = "can_clk";
+		function = "can_clk";
+	};
+
+	canfd0_pins: canfd0 {
+		groups = "canfd0_data";
+		function = "canfd0";
+	};
+
+	canfd1_pins: canfd1 {
+		groups = "canfd1_data";
+		function = "canfd1";
+	};
+};
-- 
2.34.1

