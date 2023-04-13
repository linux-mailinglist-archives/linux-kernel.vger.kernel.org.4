Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118766E1413
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDMSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDMSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:23:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7EF526F;
        Thu, 13 Apr 2023 11:23:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80B5B6603258;
        Thu, 13 Apr 2023 19:23:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681410233;
        bh=U9HSGHcaBoWrjSZxqEllJenGE2UR8Js0ktkaIRChRy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgkE4oQtBFKdiYImvtpJ8CSwauNcg6VIpuQW7ccw5sgIbMXxtH3WUd9FpQdWR60eX
         /XxutSMY5vwZ4HeGfWJrlgspK3sSnjYBnrWZmdCirbmyho6aLreuR6j776K7h3CuFX
         MnkOtYMugm12bhXVyU5DpuVmbjnH1Qr6xqSrOXlSUn0lgVkvk+LjcsgJDPP3apqDZ/
         3k50bSdGImu2IFvz4AowC4QYqJck34VEVGEX090k79n9+g3JJ1sNMfxAoOvZzNnTUW
         9EeST+r151EUvkoPa++NQUYNp6H2WdPafE0N3DwoOvR3yFXgrtmorch7TAxyY1+VZy
         G12k623CB9rwA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 934E44807F2; Thu, 13 Apr 2023 20:23:48 +0200 (CEST)
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
Subject: [PATCHv1 5/5] arm64: dts: rockchip: rk3588: add SATA support
Date:   Thu, 13 Apr 2023 20:23:45 +0200
Message-Id: <20230413182345.92557-6-sebastian.reichel@collabora.com>
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

Add all three SATA IP blocks to the RK3588 DT.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  | 23 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 48 +++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index fe1866a3697a..65d818964bff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -61,6 +61,29 @@ gmac0_mtl_tx_setup: tx-queues-config {
 		};
 	};
 
+	sata1: sata@fe220000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe220000 0 0x1000>;
+		clocks = <&cru ACLK_SATA1>, <&cru CLK_PMALIVE1>,
+			 <&cru CLK_RXOOB1>, <&cru CLK_PIPEPHY1_REF>,
+			 <&cru CLK_PIPEPHY1_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy1_ps PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
 	combphy1_ps: phy@fee10000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee10000 0x0 0x100>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 7227c918f825..2124c654f665 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -9,6 +9,8 @@
 #include <dt-bindings/power/rk3588-power.h>
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/ata/ahci.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -1666,6 +1668,52 @@ gmac1_mtl_tx_setup: tx-queues-config {
 		};
 	};
 
+	sata0: sata@fe210000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe210000 0 0x1000>;
+		clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
+			 <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
+			 <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy0_ps PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
+	sata2: sata@fe230000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe230000 0 0x1000>;
+		clocks = <&cru ACLK_SATA2>, <&cru CLK_PMALIVE2>,
+			 <&cru CLK_RXOOB2>, <&cru CLK_PIPEPHY2_REF>,
+			 <&cru CLK_PIPEPHY2_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy2_psu PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
 	sdhci: mmc@fe2e0000 {
 		compatible = "rockchip,rk3588-dwcmshc";
 		reg = <0x0 0xfe2e0000 0x0 0x10000>;
-- 
2.39.2

