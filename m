Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4386017A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiJQT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJQT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB857757B;
        Mon, 17 Oct 2022 12:26:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPcUG007828;
        Mon, 17 Oct 2022 14:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034738;
        bh=wCcPCuvaCg+ey7MRHCWFhkNdrMbGlF3epBK7kwiZVOg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bzzwpu6RzaxHjRDj4RJ9KxaRT65GTWw5gfJJDcfuf1EgaFIRK6ezcatbx6gXrRViY
         4Jc99gQ5y7MBhWi2ah7nbwORzEObbRF8yYiEjGQrHZR33J9PKi9mY4UixN6cmbjDhI
         ZUbT0kXr69y2AkEOzBy7Oe22RzBawlLqrhCiWLr0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPbT9120645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:38 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:37 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXQ026106;
        Mon, 17 Oct 2022 14:25:37 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 09/10] arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:31 -0500
Message-ID: <20221017192532.23825-10-afd@ti.com>
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

MCAN nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the MCAN nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 8 --------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7ea07f7fe5a2..d6218038055a 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1326,6 +1326,7 @@ main_mcan0: can@20701000 {
 			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan1: can@20711000 {
@@ -1340,6 +1341,7 @@ main_mcan1: can@20711000 {
 			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	crypto: crypto@40900000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 9a3bf852810c..666f5d3a2d95 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -577,12 +577,14 @@ &ecap0 {
 };
 
 &main_mcan0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan0_pins_default>;
 	phys = <&transceiver1>;
 };
 
 &main_mcan1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 451e1483f3e4..3e6df16fcb59 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -567,14 +567,6 @@ &ecap0 {
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
 
-&main_mcan0 {
-	status = "disabled";
-};
-
-&main_mcan1 {
-	status = "disabled";
-};
-
 &gpmc0 {
 	status = "disabled";
 };
-- 
2.37.3

