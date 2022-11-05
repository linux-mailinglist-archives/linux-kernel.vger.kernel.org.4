Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD061DBB1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKEPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKEPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:33:40 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E58C76B;
        Sat,  5 Nov 2022 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XqHpqs8kOpAGqjTe6Cxdek+b0q7L48oS3swMyp4A1Kg=; b=TWjb1YEmfOpNLBpw6cgQaAq34G
        LIBBrziYiG1Xpv7XNw4i866DsRfc5iFQ+azH8216/o0adKnnxz8HX0Oxsxul6GI3lPm91rMM3Kwky
        ZZaNeyCIWKtIm/zSpCGG7gKhFuz4stZcaHDaQE0GR1JfmfZoUnlJZ+1M0BrijmtbQTbpIh/Cdggww
        7FS24JSOfJUa3xjJ2Vc7yd5xpAlX4Sv3AtbbJSZ82dJgdxDlHIqUCRH6bAuu5fLE5PzOzDwP686OL
        IU+3D6iy2Dc1kL+4jVt2MsmY8hnjCJtCa44J5vEmkdNRbepglDpU83KxI2whrB0IbZyLNT/hcP5vU
        SU/L3v+g==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1orLAp-004CNe-Po; Sat, 05 Nov 2022 15:33:30 +0000
From:   Bastian Germann <bage@debian.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bastian Germann <bage@debian.org>
Subject: [PATCH v2 1/1] arm64: dts: allwinner: a64: enable Bluetooth on Pinebook
Date:   Sat,  5 Nov 2022 16:33:19 +0100
Message-Id: <20221105153319.19345-2-bage@debian.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221105153319.19345-1-bage@debian.org>
References: <20221105153319.19345-1-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
and uses PL5 as device wake GPIO and PL6 as host wake GPIO.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Bastian Germann <bage@debian.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 620cb3ef5f6c..50ed2e9f10ed 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -406,6 +406,20 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 };
-- 
2.38.1

