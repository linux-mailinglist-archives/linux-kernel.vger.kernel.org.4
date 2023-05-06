Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66A6F8F06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjEFGLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEFGLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:11:16 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B038A55;
        Fri,  5 May 2023 23:11:15 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-331ad4cd4fdso5367415ab.1;
        Fri, 05 May 2023 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683353474; x=1685945474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeOh/jbw7iDiPTNUt32wL663Pm37i/7RVXxftZBbGlQ=;
        b=MxfpDO0DEBvt9ZnisBSuQQHSrg6OgJiYroiATFpEeTjdjIjsy37kHKhjcA8YGsnQk0
         gV5xqrEf9AVyz5a/NhryQBrhP+FSEvtg7hHLI6bUSi8RSltdFRyniABrgYNN+4BcGHpd
         8Qpj8+9o4UdnKESUYjGTeFHH35tD0BGSRv/QEIh2GhqSkdHcCjHdPxPnDNNNizasotEP
         /h9hlD/fzcZg+/me2GOC/d2LxNMC4nr7FJBXG37/hwxX2P/zWoH0eiuNtZ4Z51jFg6Hr
         QMMB4Ocvw/loctmsD4mlXLFKxvCdx1f1nHAl3bhzox/FcEfVc1bwy9DZTx1swhvijR22
         Rgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683353474; x=1685945474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeOh/jbw7iDiPTNUt32wL663Pm37i/7RVXxftZBbGlQ=;
        b=ClrCTVkumtN/GtBJ0miiE7bBEh7JNWPU075huHV6K9/AcJsIL/td+78R8bGooNAaPL
         HH8ipAs402Wt16OjypdqXBPv52yHJEdDLznFU5LoRtTCa30yGORF0KU8/dBdjnvv0a2A
         kkntn6fBHF9C3yUbyMc7Z/d9ZXxfLqxlJsmDVLAdDIJMvz5LDsSkbNeB4bUFOvnmapGA
         rjUoiwvdfaKSSmhZaWoPpKGIAV+J+hINQ9Zc4tLHh6EArRQuusvDqXWWJ7cW7R9PZ5ep
         KZbqVlqmEgO5uf8rD8GabVyl17z2y6gQRtEvBsac79fLcZgkiEsztGhBDhCUURiE+Z/h
         5EcQ==
X-Gm-Message-State: AC+VfDy/of4HOfbZobyEIxSWMHqwIQSKzBmZVfnccZVRPMbLhqgTIOff
        HGwgqVIQxw0aGaizrs1Ip8M=
X-Google-Smtp-Source: ACHHUZ5Kt4gUCn4HovMuT78+lcZfuPQPI3cBXbSG3OUgEbXKAcvviV1euPj3XUcoGTrE0bSV4xPeMQ==
X-Received: by 2002:a92:d452:0:b0:32b:50d1:3403 with SMTP id r18-20020a92d452000000b0032b50d13403mr2447113ilm.7.1683353474371;
        Fri, 05 May 2023 23:11:14 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id b16-20020a92c850000000b0032e28db67dcsm413047ilq.84.2023.05.05.23.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:11:13 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add Lunzn Fastrhino R68S
Date:   Sat,  6 May 2023 14:11:08 +0800
Message-Id: <20230506061108.17658-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230506061108.17658-1-cnsztl@gmail.com>
References: <20230506061108.17658-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's similar to Fastrhino R66S with the following changes:
+ 2/4GB LPDDR4 RAM
+ 2x 1000 Base-T (native, RTL8211f)
+ ADC button
+ 16GB eMMC on-board
- No SD card slot

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

Changes in v2:
* Fixed gmac pull type: pcfg_pull_down -> pcfg_pull_up

---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3568-fastrhino-r68s.dts    | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 15089a78555a..1cf105d7407f 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r68s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
new file mode 100644
index 000000000000..e1fe5e442689
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "rk3568-fastrhino-r66s.dtsi"
+
+/ {
+	model = "Lunzn FastRhino R68S";
+	compatible = "lunzn,fastrhino-r68s", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		mmc0 = &sdhci;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <1750>;
+		};
+	};
+};
+
+&gmac0 {
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+	snps,reset-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 15ms, 50ms for rtl8211f */
+	snps,reset-delays-us = <0 15000 50000>;
+	tx_delay = <0x3c>;
+	rx_delay = <0x2f>;
+	status = "okay";
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+	snps,reset-gpio = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 15ms, 50ms for rtl8211f */
+	snps,reset-delays-us = <0 15000 50000>;
+	tx_delay = <0x4f>;
+	rx_delay = <0x26>;
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		pinctrl-0 = <&eth_phy0_reset_pin>;
+		pinctrl-names = "default";
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		pinctrl-0 = <&eth_phy1_reset_pin>;
+		pinctrl-names = "default";
+	};
+};
+
+&pinctrl {
+	gmac0 {
+		eth_phy0_reset_pin: eth-phy0-reset-pin {
+			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	gmac1 {
+		eth_phy1_reset_pin: eth-phy1-reset-pin {
+			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	status = "okay";
+};
-- 
2.40.1

