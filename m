Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0072C724B45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbjFFSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbjFFSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922121707;
        Tue,  6 Jun 2023 11:22:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNdt022993;
        Tue, 6 Jun 2023 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075743;
        bh=WquSXcRNdLQWpibsSzw3AC7SJDkwSmubH79URJL1F6c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WmdeZWgus1FQafg03Ulsc6ic9aLLQyz5DhS01vzqEsivpdhDPJaLIUF8B9RMJHIcy
         X9cZMDJxJ6UvSW8pQM8b70K+67oHUuLBmndmqmPmYlULX+U5AdxsjS9zX90pzMTKj3
         5a4QzlJHdhX1oR2qpyQUuFknq2tVsLiiER9cr1fs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNsf094574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNJj040850;
        Tue, 6 Jun 2023 13:22:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH V2 05/14] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandles array
Date:   Tue, 6 Jun 2023 13:22:11 -0500
Message-ID: <20230606182220.3661956-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When referring to array of phandles, using <> to separate the array
entries is better notation as it makes potential errors with phandle and
cell arguments easier to catch. Fix the outliers to be consistent with
the rest of the usage.

Cc: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since v1:
* Rebased on previous fixups

V1: https://lore.kernel.org/r/20230601152636.858553-4-nm@ti.com
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index a3f602e4fb45..2d8fa17b7d25 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -682,7 +682,8 @@ &main_gpio7 {
 
 &wkup_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_adc0_pins_default &mcu_adc1_pins_default &mikro_bus_pins_default>;
+	pinctrl-0 = <&mcu_adc0_pins_default>, <&mcu_adc1_pins_default>,
+		    <&mikro_bus_pins_default>;
 };
 
 &wkup_gpio1 {
@@ -766,7 +767,7 @@ serdes2_usb_link: phy@1 {
 
 &usbss1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss1_pins_default &mcu_usbss1_pins_default>;
+	pinctrl-0 = <&main_usbss1_pins_default>, <&mcu_usbss1_pins_default>;
 	ti,vbus-divider;
 };
 
@@ -1008,55 +1009,55 @@ mbox_c71_0: mbox-c71-0 {
 };
 
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
 
 &c66_0 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
 };
 
 &c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
-- 
2.40.0

