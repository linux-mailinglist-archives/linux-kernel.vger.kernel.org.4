Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E666D6AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjDDRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDDRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:41:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54552B4;
        Tue,  4 Apr 2023 10:41:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8B84660316F;
        Tue,  4 Apr 2023 18:41:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680630117;
        bh=eFM2DUmpK4asUDysohdMR8TB/pdKK8LNKe1onXMI9bA=;
        h=From:To:Cc:Subject:Date:From;
        b=dF06nkY6DUIwqs6bK/i6huSbsWUJnRAQzdGsSgZ9Lij0bIyX/5pJuOnBfoATxes1f
         0V6qIt/tE42Owec+9MZN4pypNXcazIegoFDsDa/W25Tyga2aK1IUphv5uHSF2MyUdA
         2k/e3M7BaMgesqF3luOqyCPH7bXb0y5zoizPYw852OJf12iUy1IhillZzBUbx9sWAr
         D66skznvlg8tzGansrW8ZNE7JLZ5I9d+4c/PFP5sxVZ58vXYWNdpaTjsJPwj/dE2TH
         IXQ8Uf18ys/RC9WpyPerbfmjcrcnnmollE4cz890q7Bm/Qmn33Uir76Gd9+wPqVINR
         MbXxrKloJfchw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shreeya Patel <shreeya.patel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2] arm64: dts: rockchip: Enable RTC support for Rock 5B
Date:   Tue,  4 Apr 2023 23:11:21 +0530
Message-Id: <20230404174121.38727-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node to enable RTC support for Rock 5B board.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 95805cb0adfa..fcb5af09e49b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -27,6 +27,31 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 	};
 };
 
+&i2c6 {
+	status = "okay";
+
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
-- 
2.30.2

