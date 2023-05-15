Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80437037B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbjEORXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbjEORXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:23:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495C5FC4;
        Mon, 15 May 2023 10:21:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLfT2021835;
        Mon, 15 May 2023 12:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684171301;
        bh=5Bn2akr6gA+EsKPuX9IZMqXU+VZigh8oWkYRin7Nvw8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KgnWVk6KLipsYQZlNdcLNppWj8A7U87iKQdRlYXh9+7fTSP4FxwtXYHHXE2y6PJRY
         LCKfFlldzPKb1sYFJhP62WvDzyaHrAK3ndeRvWdXk2vd0npSJ4F7lsWG8sKjkQlfgY
         EVPxt6LkKBStnz7UXXqKZdIYLIelxsQqzR1pKlMU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHLfRQ010867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:21:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:21:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:21:41 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLcpY002823;
        Mon, 15 May 2023 12:21:40 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 5/5] arm64: dts: ti: k3-j721e: Enable MDIO nodes at the board level
Date:   Mon, 15 May 2023 12:21:37 -0500
Message-ID: <20230515172137.474626-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515172137.474626-1-afd@ti.com>
References: <20230515172137.474626-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDIO nodes defined in the top-level J721e SoC dtsi files are incomplete
and will not be functional unless they are extended with a pinmux.

As the attached PHY is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the MDIO nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts    | 10 ----------
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  8 --------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                |  8 --------
 4 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index be0c5431119e..a7b686cab3e6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -883,16 +883,6 @@ &pcie1_rc {
 	reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_HIGH>;
 };
 
-&icssg0_mdio {
-	/* Unused */
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	/* Unused */
-	status = "disabled";
-};
-
 &ufs_wrapper {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 975a5161eb96..68afc3cedfd8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -843,14 +843,6 @@ &pcie2_rc {
 	num-lanes = <2>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
 &mcu_mcan0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 18f4661d37bf..65d087cf8cd9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2013,6 +2013,7 @@ icssg0_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -2154,6 +2155,7 @@ icssg1_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 66a8559b3755..94bf5057f363 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -893,14 +893,6 @@ &pcie1_rc {
 	num-lanes = <2>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
 &ufs_wrapper {
 	status = "disabled";
 };
-- 
2.39.2

