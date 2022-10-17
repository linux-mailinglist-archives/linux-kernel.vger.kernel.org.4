Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8260179A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJQT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJQT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E16D77551;
        Mon, 17 Oct 2022 12:26:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPaNd120485;
        Mon, 17 Oct 2022 14:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034736;
        bh=m8x/qeVu9au51LYr+ryzo61c3z3eN15boOt8bGNAa/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MpVYR7r+wQfSHbHl6WsGSIsg8YmDahDuGNqcjgnYtUrA6wx9HrpfIwrWnlez73aVs
         48MC4+PpToqY17UDpbkb3ybCq4xuG8DQxEfYelNTCzgWrdzOJk5HCf907kWNvBbTrz
         /3TteOneZfRhBnqcDQGVjyWIGbkrVVEHJ/QzFsHo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPZXq086722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:36 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:35 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXM026106;
        Mon, 17 Oct 2022 14:25:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 05/10] arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:27 -0500
Message-ID: <20221017192532.23825-6-afd@ti.com>
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

ECAP nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information. (These and the EPWM nodes could be used to trigger internal
actions but they are not used like that currently)

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the ECAP nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 9 +--------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 9 +--------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 672575f44529..ef1833f65bdc 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -988,6 +988,7 @@ ecap0: pwm@23100000 {
 		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 51 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	ecap1: pwm@23110000 {
@@ -997,6 +998,7 @@ ecap1: pwm@23110000 {
 		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 52 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	ecap2: pwm@23120000 {
@@ -1006,6 +1008,7 @@ ecap2: pwm@23120000 {
 		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 53 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_rti0: watchdog@e000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index cef3afa10c39..43d50ecfb211 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -567,19 +567,12 @@ &pcie0_ep {
 };
 
 &ecap0 {
+	status = "okay";
 	/* PWM is available on Pin 1 of header J12 */
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
 
-&ecap1 {
-	status = "disabled";
-};
-
-&ecap2 {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 51f4ae165c13..8b9987ccdc1b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -566,19 +566,12 @@ &pcie0_ep {
 };
 
 &ecap0 {
+	status = "okay";
 	/* PWM is available on Pin 1 of header J3 */
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
 
-&ecap1 {
-	status = "disabled";
-};
-
-&ecap2 {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.37.3

