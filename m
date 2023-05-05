Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0EC6F8497
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEEOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEEOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:14:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3847132A2;
        Fri,  5 May 2023 07:14:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EEB6m017122;
        Fri, 5 May 2023 09:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683296051;
        bh=A6MY1RpIq6O6rWiub7FmaVtJ2q4gONym7Vg55BSgnWc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fAqfuX4vTjLwVkA64W6k7e+CT+52fuv2JC3Up8bPZsn1ZixDFOgZQS994knC1SXI+
         3DrdkMyTNMtPpgRCaSrCQvPhdTUKZODAozLhnGcocTj+he57C6zlxLSkgCl6WGUoqI
         Ow7dwjgpGzIrKMpvA79wVFTmt0QEN5RVcMvNBZRk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EEBUf011659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:14:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:14:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:14:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EE93J029704;
        Fri, 5 May 2023 09:14:10 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
Date:   Fri, 5 May 2023 19:44:04 +0530
Message-ID: <20230505141407.15134-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505141407.15134-1-vaishnav.a@ti.com>
References: <20230505141407.15134-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E has a Flash SubSystem that has one OSPI and one HyperBus with
muxed datapath and another independent OSPI. Add DT nodes for HyperBus
controller and keep it disabled and model the data path selection mux as a
reg-mux. Also the register region range for FSS only have description
for registers up to 0x7c, update that and fix the fss node name to fix
DT compile warning.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 24e8125db8c4..6dfd76619a4a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -174,13 +174,34 @@
 		status = "disabled";
 	};
 
-	fss: fss@47000000 {
+	fss: bus@47000000 {
 		compatible = "simple-bus";
-		reg = <0x0 0x47000000 0x0 0x100>;
+		reg = <0x0 0x47000000 0x0 0x7c>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
+		hbmc_mux: mux-controller@47000004 {
+			compatible = "reg-mux";
+			reg = <0x00 0x47000004 0x00 0x2>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+		};
+
+		hbmc: hyperbus@47034000 {
+			compatible = "ti,am654-hbmc";
+			reg = <0x00 0x47034000 0x00 0x0c>,
+				<0x05 0x00000000 0x01 0x0000000>;
+			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+			clocks = <&k3_clks 102 0>;
+			assigned-clocks = <&k3_clks 102 5>;
+			assigned-clock-rates = <333333333>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			mux-controls = <&hbmc_mux 0>;
+			status = "disabled";
+		};
+
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
-- 
2.17.1

