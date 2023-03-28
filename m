Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5762C6CCBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjC1VCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1VCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:02:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ABC3AA0;
        Tue, 28 Mar 2023 14:02:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F2616603163;
        Tue, 28 Mar 2023 22:02:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680037327;
        bh=vLuPLrQ150EuvyOIDT/l5G5BueMNkQv42XadApxWJmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WN64Tbqw7jmk/KbtubS6IeljHEBU6AyfryGC8+TB3NOddenzs7kFj0imi4dDLiykw
         dHK4nRh7UH2grrSwZapjsiyHDUU2kbmEuQEsxEYyMM0zfzEbjQGTzQghwd6/zvSmKJ
         cC0JbZiVJzpos0SVaKxKP7fqW9R0AcHmTyW175YE0pclc2D91aqo0O1knt9FYqag8o
         iqS+YOJIOKM3XbZ0Rh4S4YTerP7oJIhksOAx7PSQpq7306UmuLfqmVlcgLaCKGNgsN
         loYt/et1qztIoJMdc6zYyIcP9fRHHz9lQG55wuv81TSZpDjCGQTLkV1dXUOnV9cXE2
         ENMd2W/2i2yAQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jamie@jamieiles.com,
        heiko@sntech.de
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable watchdog support for RK3588
Date:   Wed, 29 Mar 2023 02:30:47 +0530
Message-Id: <20230328210048.195124-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328210048.195124-1-shreeya.patel@collabora.com>
References: <20230328210048.195124-1-shreeya.patel@collabora.com>
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

Add DT node for watchdog support in RK3588.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 005cde61b4b2..20793f67c079 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1226,6 +1226,14 @@ i2c5: i2c@fead0000 {
 		status = "disabled";
 	};
 
+	wdt: watchdog@feaf0000 {
+		compatible = "rockchip,rk3588-wdt", "snps,dw-wdt";
+		reg = <0x0 0xfeaf0000 0x0 0x100>;
+		clocks = <&cru TCLK_WDT0>, <&cru PCLK_WDT0>;
+		clock-names = "tclk", "pclk";
+		interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+
 	spi0: spi@feb00000 {
 		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
 		reg = <0x0 0xfeb00000 0x0 0x1000>;
-- 
2.30.2

