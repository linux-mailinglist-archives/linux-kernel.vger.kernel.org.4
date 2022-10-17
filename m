Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D560179C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiJQT0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJQT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C637677A;
        Mon, 17 Oct 2022 12:26:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPaFP120489;
        Mon, 17 Oct 2022 14:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034736;
        bh=Z2q1Q66QyTJq9WylCRn2c0NgmvRjm7dbKSJ4DAG5Ofg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xkItbTS5Yfo/ntHWlW6Y8HRrJYoGg91rjF6No3nQtC27CJqq7+5cygmPKpAK/buGZ
         expqSQqpXG9OJaXuz3laboIEx4PydV/2tS8rLA75PXZEUf/psih/fyIQi8w/EUFMzm
         NHHVaq+htuCRPSCBI5Nyt8J8MtOyQfLNTtzl0om0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPaVx086728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:36 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXN026106;
        Mon, 17 Oct 2022 14:25:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 06/10] arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:28 -0500
Message-ID: <20221017192532.23825-7-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with a SerDes PHY.
And usually only one of the two modes can be used at a time as they
share a SerDes link.

As the PHY and mode is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the PCIe nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 8 --------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ef1833f65bdc..b193f88a7a0f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -871,6 +871,7 @@ pcie0_rc: pcie@f102000 {
 		ranges = <0x01000000 0x00 0x68001000  0x00 0x68001000  0x00 0x0010000>,
 			 <0x02000000 0x00 0x68011000  0x00 0x68011000  0x00 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000010 0x0>;
+		status = "disabled";
 	};
 
 	pcie0_ep: pcie-ep@f102000 {
@@ -889,6 +890,7 @@ pcie0_ep: pcie-ep@f102000 {
 		clocks = <&k3_clks 114 0>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <1>;
+		status = "disabled";
 	};
 
 	epwm0: pwm@23000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 43d50ecfb211..2dec25d90240 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -553,6 +553,7 @@ serdes0_pcie_link: phy@0 {
 };
 
 &pcie0_rc {
+	status = "okay";
 	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
@@ -563,7 +564,6 @@ &pcie0_ep {
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
-	status = "disabled";
 };
 
 &ecap0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 8b9987ccdc1b..58c71608d925 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -557,14 +557,6 @@ &main_r5fss1_core1 {
 			<&main_r5fss1_core1_memory_region>;
 };
 
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
 &ecap0 {
 	status = "okay";
 	/* PWM is available on Pin 1 of header J3 */
-- 
2.37.3

