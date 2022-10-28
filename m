Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1361147C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiJ1OZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AFEA9;
        Fri, 28 Oct 2022 07:24:32 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOO13026566;
        Fri, 28 Oct 2022 09:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967064;
        bh=XblxHme2I1/9BjL7cSQ0qB05D+8VlqfedcTr4tTCMV8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vJGA5udZVWPDEl0PhgKIpWOyucnnhZUGGvf6RbZlPs5Mkz+15SNEK4ashjtGbah2u
         ylArqUwAReI6mOd1YGxSBXWzXPdmWkd5n9XGkgsJ1tqj1cR6kp3Ie9gLh5qGo5filK
         f8+gpHBtJIvGTUsZ4q5V03CI2vD+3/KLeRCHvu5A=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOOqY072899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:24 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:23 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfX039275;
        Fri, 28 Oct 2022 09:24:23 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 08/11] arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:14 -0500
Message-ID: <20221028142417.10642-9-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCAN nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the MCAN nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 8 --------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 8 --------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 35af8798f208e..c431d670757ba 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -650,14 +650,6 @@ &pcie1_rc {
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
 };
 
-&m_can0 {
-	status = "disabled";
-};
-
-&m_can1 {
-	status = "disabled";
-};
-
 &pcie1_ep {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 22f30174621e2..9ceae8a5b7e2d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -177,6 +177,7 @@ m_can0: mcan@40528000 {
 			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	m_can1: mcan@40568000 {
@@ -192,6 +193,7 @@ m_can1: mcan@40568000 {
 			     <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	fss: fss@47000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index beac2c563e831..bf6a6fe3d7ba3 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -431,14 +431,6 @@ &pcie1_ep {
 	status = "disabled";
 };
 
-&m_can0 {
-	status = "disabled";
-};
-
-&m_can1 {
-	status = "disabled";
-};
-
 &mailbox0_cluster0 {
 	interrupts = <436>;
 
-- 
2.37.3

