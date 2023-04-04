Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB926D5FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjDDL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjDDL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:58:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6B2D43;
        Tue,  4 Apr 2023 04:58:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93EA46603158;
        Tue,  4 Apr 2023 12:58:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680609513;
        bh=CsUF6Di6DyBAFY8sgAr6L6XZ0o8G3dhq5m+UPRstjME=;
        h=From:To:Cc:Subject:Date:From;
        b=TesMwdzRzzf6fcpSAa3Sg9YYsy8wAVY5ezwOZ4oIoymyT4MuN9+RrouxJIB689zmC
         +wuXJtesapsTSQFz8xAVDwoiOJs20KmjTThjGNCLXg2T3Hcs5XEqvMUT0WNwyNnzZF
         llAw+wOxEeztJf18pHnFE4XMa+zzsoELTQEBzqL5KeXb0ZZvlDBIF/enS2LCgQpfX/
         EGFnUER2J/Cl9bn75UMTJHjyN8iyJGAOE7Pb1XNtJ82Gb/+RHqFkXnh1ciCu0jlW+N
         O/FGqKF7GQAcDrs5YeDeelHZWfmm0Ixa/nQ8FZP2VMTZSab2XeFPTmERVsjy0N5cD7
         VkWP2lpUMzkZg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] arm64: dts: rockchip: Add RTC support for RK3588
Date:   Tue,  4 Apr 2023 17:28:02 +0530
Message-Id: <20230404115802.33693-1-shreeya.patel@collabora.com>
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

Add DT node to enable RTC support on RK3588 board.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 95805cb0adfa..a32bfa8d914a 100644
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
@@ -42,3 +67,5 @@ &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
+
+
-- 
2.30.2

