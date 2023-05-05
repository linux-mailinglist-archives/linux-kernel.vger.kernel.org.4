Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632C46F8261
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjEEL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEEL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:59:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538B30F7;
        Fri,  5 May 2023 04:59:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345Bx5As119261;
        Fri, 5 May 2023 06:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683287945;
        bh=mWCCYMK6drSmveVnuahFRASrK8ntgKM85dBE7RuKDO0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vAYCE2/gdcm3qecFP7RtcSW59eo9f5hY5xrReMbVEPtiX/b/RsAu76IVywlOOM5ol
         v28UQ6weaq+azaT3L/ORoyGycG/DeIq3rqZFPnJBCXljLWz1PLCY0ZWzVI6wA83wni
         HZKUTW8jo/Awc4D9UCdD7MRlX18fhOKADwQq2S+s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345Bx5Vc123195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 06:59:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 06:59:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 06:59:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345Bx4NT100001;
        Fri, 5 May 2023 06:59:05 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss node and hbmc_mux
Date:   Fri, 5 May 2023 17:28:58 +0530
Message-ID: <20230505115858.7391-4-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505115858.7391-1-vaishnav.a@ti.com>
References: <20230505115858.7391-1-vaishnav.a@ti.com>
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

From: Nishanth Menon <nm@ti.com>

fss node claims to be a syscon node, while it actually is a simple bus
where ospi, hbmc peripherals are located and a mux for path select
between OSPI and Hyperbus which can be modelled as a reg-mux. So model
it accordingly and use reg-mux to describe the hbmc-mux. Also update
the region size to the correct values as per the TRM.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
 * Address feedback from Udit to limit the FSS register region size as
 per TRM.
 * Use reg-mux changes to simplify the hbmc-mux modelling.
 * Update commit message to reflect changes.

Depends on:
 https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index b58a31371bf3..333564ca9c91 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -338,22 +338,23 @@
 		status = "disabled";
 	};
 
-	fss: syscon@47000000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x47000000 0x00 0x100>;
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x47000000 0x0 0x7c>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		hbmc_mux: hbmc-mux {
-			compatible = "mmio-mux";
+		hbmc_mux: mux-controller@47000004 {
+			compatible = "reg-mux";
+			reg = <0x00 0x47000004 0x00 0x2>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4 0x2>; /* HBMC select */
 		};
 
 		hbmc: hyperbus@47034000 {
 			compatible = "ti,am654-hbmc";
-			reg = <0x00 0x47034000 0x00 0x100>,
+			reg = <0x00 0x47034000 0x00 0x0c>,
 				<0x05 0x00000000 0x01 0x0000000>;
 			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 			clocks = <&k3_clks 102 0>;
-- 
2.17.1

