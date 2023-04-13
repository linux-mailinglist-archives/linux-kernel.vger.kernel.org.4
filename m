Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698FE6E1412
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDMSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDMSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:23:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F32B61AE;
        Thu, 13 Apr 2023 11:23:53 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 94AF86603221;
        Thu, 13 Apr 2023 19:23:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681410231;
        bh=KpDLVmY7MLRSnWayLikD4zY8rROUxg2D6rCjRLznobU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbhrVWG2OsHm7fJqsv6mJONTZF7mu8HIroXjj4b1nkr2ZMJD0FQxyyByntADT+ZjO
         YDoLBlrvgqS2Q3t18BLk60R90YlJbomF6IQKFMk9EptMhZ5HLEGGLt8RX1qmhsBcrb
         rpcYxIZahfATD/ww/UlfynrAo5NIK7DLotWsmXplAj4Nasxjvxx+D5+B5pSTzRDqd5
         4jGkI6+dOzPkjCflw6eEh0vFH6vipziG/9f1Lxz0f1gx65EDF7pm/4StnzEvAx+x6Y
         ud4zP3Po7BzSBxMFhiatgWfB8dzexV2c2QqCG0BcsklApPwgNIATJRJDQwpibuTM8D
         a99yA40QCXRnQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 90FCD4807F1; Thu, 13 Apr 2023 20:23:48 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 4/5] arm64: dts: rockchip: rk3588: add combo PHYs
Date:   Thu, 13 Apr 2023 20:23:44 +0200
Message-Id: <20230413182345.92557-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413182345.92557-1-sebastian.reichel@collabora.com>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all 3 combo PHYs that can be found in RK3588.
They are used for SATA, PCIe or USB3.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  | 21 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 42 +++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index d085e57fbc4c..fe1866a3697a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -7,6 +7,11 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	pipe_phy1_grf: syscon@fd5c0000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5c0000 0x0 0x100>;
+	};
+
 	gmac0: ethernet@fe1b0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1b0000 0x0 0x10000>;
@@ -55,4 +60,20 @@ gmac0_mtl_tx_setup: tx-queues-config {
 			queue1 {};
 		};
 	};
+
+	combphy1_ps: phy@fee10000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee10000 0x0 0x100>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_REF_PIPE_PHY1>, <&cru PCLK_PCIE_COMBO_PIPE_PHY1>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY1>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_REF_PIPE_PHY1>, <&cru SRST_P_PCIE2_PHY1>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 422b31e342ca..7227c918f825 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -944,6 +944,16 @@ php_grf: syscon@fd5b0000 {
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
 	};
 
+	pipe_phy0_grf: syscon@fd5bc000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5bc000 0x0 0x100>;
+	};
+
+	pipe_phy2_grf: syscon@fd5c4000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5c4000 0x0 0x100>;
+	};
+
 	ioc: syscon@fd5f0000 {
 		compatible = "rockchip,rk3588-ioc", "syscon";
 		reg = <0x0 0xfd5f0000 0x0 0x10000>;
@@ -2200,6 +2210,38 @@ dmac2: dma-controller@fed10000 {
 		#dma-cells = <1>;
 	};
 
+	combphy0_ps: phy@fee00000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee00000 0x0 0x100>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_REF_PIPE_PHY0>, <&cru PCLK_PCIE_COMBO_PIPE_PHY0>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY0>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_REF_PIPE_PHY0>, <&cru SRST_P_PCIE2_PHY0>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
+		status = "disabled";
+	};
+
+	combphy2_psu: phy@fee20000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee20000 0x0 0x100>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_REF_PIPE_PHY2>, <&cru PCLK_PCIE_COMBO_PIPE_PHY2>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY2>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_REF_PIPE_PHY2>, <&cru SRST_P_PCIE2_PHY2>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy2_grf>;
+		status = "disabled";
+	};
+
 	system_sram2: sram@ff001000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0xff001000 0x0 0xef000>;
-- 
2.39.2

