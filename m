Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E15ECBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiI0SQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiI0SPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:15:48 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BF5300B;
        Tue, 27 Sep 2022 11:15:44 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 37D068000EC;
        Wed, 28 Sep 2022 02:15:38 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, michael.riesch@wolfvision.net,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
Date:   Wed, 28 Sep 2022 02:15:31 +0800
Message-Id: <20220927181531.5546-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927181531.5546-1-amadeus@jmu.edu.cn>
References: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
 <20220927181531.5546-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkwYVh5PSkhOHktMSB0ZTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46DDo5Pj0sDA4ePRMiPAhL
        TBwKCxJVSlVKTU1PSEtJTkhDQ0lKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQU9JTks3Bg++
X-HM-Tid: 0a8380295ec5b03akuuu37d068000ec
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nodes to Radxa ROCK3 Model A board to support PCIe v3.
Also changed the vin-supply of vcc3v3_pcie regulator to
ensure that pcie is probe properly.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 1b195355da2a..097cee13885d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -67,6 +67,38 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-boot-on;
 	};
 
+	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* pi6c pcie clock generator */
+	vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pi6c03";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	/* actually fed by vcc5v0_sys, dependent on pi6c clock generator */
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -76,7 +108,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		regulator-name = "vcc3v3_pcie";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc3v3_pi6c_03>;
 	};
 
 	vcc3v3_sys: vcc3v3-sys-regulator {
@@ -547,6 +579,20 @@ &pcie2x1 {
 	status = "okay";
 };
 
+&pcie30phy {
+	phy-supply = <&vcc3v3_pi6c_03>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	/* mPCIe slot */
+	pinctrl-names = "default";
+	pinctrl-0 = <&minipcie_reset_h>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	cam {
 		vcc_cam_en: vcc_cam_en {
@@ -583,6 +629,10 @@ pcie_enable_h: pcie-enable-h {
 			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		minipcie_reset_h: minipcie-reset-h {
+			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		ngffpcie_reset_h: ngffpcie-reset-h {
 			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.25.1

