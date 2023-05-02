Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FC6F4557
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjEBNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjEBNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:41:04 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167526189;
        Tue,  2 May 2023 06:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyxrmO3kHTP/gVp3RbmVnfTvyLv9iwG3oCqC98dwb5I6ufQffaII9SitK1zgvgcshIm6LRmzyelTqKF9xmiCvFTBUYHvuYd+svxienfZUVFBvajAz0MuaqpshOWb51kcoBIkoN9ofwqLFrzA1enUrJUfFkg0nc49cVhd+rngc1UIR4mRXhQgPeULyH0fwvuHI4G7eiGd55dAVcdDzv5XGqk1EI+h7yzvlohj3ennTnnzXcOIPw7MVLba2ZUfgh98zuBjYXyYxHRm2xQ3NCmSchvfWhdtfg6iAt+Si8fvWrEAt/smspnzgdmS/+vIJQd+EjC1F7whw4zDGssOu4XI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDyOsaEKWMexbMyEOdfZ3fg075U0MSF6yVl5CtldHHY=;
 b=ANkVvs6ddqaGd+fg6EBUcz8n+go5hFD9PqHVOgR9d1asN2nXSeJVwEWrkXx0nqFE0rSwjGmuiwUM2fPY6xffljXloSYTcW8K+g29MdNF+sq4e7HloQe3kH7K6IK9ZfINFQvmp8j/X0UKu0SPbQLA17VL6KRGyhWAIa/3jbkJ7439r5SLYztYHKNK2qR9hfkfhzcWoag+CpAY+khVcB4NkKCffGnnKWHbfmlM6JuXJnjEbKTaJnca0bHhS9BXJswNv13BbR2G0yQK1vgpuhcB/lFgAMtMOLW8FPR59UoFs6TAuQjZundsKPNkwKYSM93qy09Wh8bE9Re7TEAYzRa4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDyOsaEKWMexbMyEOdfZ3fg075U0MSF6yVl5CtldHHY=;
 b=cmDGxzIAm+MUignqRAVcKuonjmJPIOBaKRgeMZ8CQ8q6JfH+axg2rHB4ZoMSkpdv+rcHMR/QTvqB/5AUhrBp9JSfqCvxCn/Ho132PMIEeUxH4+xF3XPJlUDpEFiE5fryzlax4L1tlmtQNA6NHBOSfM+ocKm4sQn3MMTLIthiArQ=
Received: from DM6PR10CA0001.namprd10.prod.outlook.com (2603:10b6:5:60::14) by
 PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:39:29 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::f0) by DM6PR10CA0001.outlook.office365.com
 (2603:10b6:5:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:39:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:39:04 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 23/23] arm64: zynqmp: Add phase tags marking
Date:   Tue, 2 May 2023 15:35:51 +0200
Message-ID: <48b554aef75d11e6ad2ef7d21f22accb35432112.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 25618646-c487-4d76-9338-08db4b12a724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/WBX0n7k6ZIkTuWJ+PMYDN0CCerGhsH7EQVteFfinFdrqx/4pc5tseNJFsVAV+nF8qxWWd1tFHWf2Dl6JIqAVXihQkYW58E1c8lNKucCBjgfepISwD0LRVS6wT7UhMXLqdBNJH3Xt9dU4hKZbRJlMS7/Y54HDvJcZVLvQKTbkz3BC6U+3k1Hdh19ZaWVPaJ2iRX6zW57MZ3DJwo5e2V75OxQBOA6mjSqI8R/B2KWah3PEDDSl12Hte4yZYfYshF1PiRJZo7DwDtcGbamJKkkuA2Pg9PGs/ghWvuFysfCtN51z7LF5aMSZk908S0rikBNkOgRfWJVyfJmqkA3cO5KjFbVrh6x6RF0lPcerRieVVYXv7JT9UDqtubu1tiPyFh9NRLRJoe6pE0yT7KS6ystBfvNAdccns/btAvOBoxIHMfTFLn2uKDqDNLTkBP25m44vL5GF/BTVtDe246CV96lj2x37XgGwgIMU8G5wQZGFHYPkWz+MxlBhfcpII+CPyh5/dwLWZeF3LcmdI997B1VGeLnXw5m7K4jpXBsCizYlozge5dfMEWedwlslKRAkgA5XoWVQXzsXPR4x/1k2hkm3cTOyCFyfpHWB4L/io6pBUDG0QOd7Rj1GySkHCwOC6X5Mrs0qEEOZw1nAO39r91R5rq82dNcVJ+GdhN/hbADLqxKOZLiMJfZU7Uxd5dtq1cmgKOJoWIuINWSNZJO64HPj/kzEIfxFzi7SoPbhXiwQNFuKXUWMHg3W4r5Mog7Tba
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(5660300002)(7416002)(4326008)(8676002)(82740400003)(8936002)(70206006)(70586007)(81166007)(44832011)(356005)(316002)(41300700001)(40480700001)(2906002)(336012)(186003)(16526019)(26005)(6666004)(36860700001)(47076005)(426003)(83380400001)(36756003)(2616005)(82310400005)(110136005)(54906003)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:39:28.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25618646-c487-4d76-9338-08db4b12a724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
That's why add it also to Linux to be aligned with bootloader requirement.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi    |  6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts |  3 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 581221fdadf1..719ea5d5ae88 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -11,30 +11,35 @@
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
 	pss_ref_clk: pss_ref_clk {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
 	};
 
 	video_clk: video_clk {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
 
 	pss_alt_ref_clk: pss_alt_ref_clk {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
 	};
 
 	gt_crx_ref_clk: gt_crx_ref_clk {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <108000000>;
 	};
 
 	aux_ref_clk: aux_ref_clk {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
@@ -43,6 +48,7 @@ aux_ref_clk: aux_ref_clk {
 
 &zynqmp_firmware {
 	zynqmp_clk: clock-controller {
+		bootph-all;
 		#clock-cells = <1>;
 		compatible = "xlnx,zynqmp-clk";
 		clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>,
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 78ff6a9b3144..8afdf4408a78 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -243,17 +243,20 @@ tpm@0 { /* slm9670 - U144 */
 
 &i2c1 {
 	status = "okay";
+	bootph-all;
 	clock-frequency = <400000>;
 	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
 	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
 
 	eeprom: eeprom@50 { /* u46 - also at address 0x58 */
+		bootph-all;
 		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
 		reg = <0x50>;
 		/* WP pin EE_WP_EN connected to slg7x644092@68 */
 	};
 
 	eeprom_cc: eeprom@51 { /* required by spec - also at address 0x59 */
+		bootph-all;
 		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
 		reg = <0x51>;
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index d01d4334c95f..51b8349dcacd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -127,6 +127,7 @@ rproc_1_fw_image: memory@3ef00000 {
 	};
 
 	zynqmp_ipi: zynqmp_ipi {
+		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
 		interrupts = <0 35 4>;
@@ -136,6 +137,7 @@ zynqmp_ipi: zynqmp_ipi {
 		ranges;
 
 		ipi_mailbox_pmu1: mailbox@ff9905c0 {
+			bootph-all;
 			reg = <0x0 0xff9905c0 0x0 0x20>,
 			      <0x0 0xff9905e0 0x0 0x20>,
 			      <0x0 0xff990e80 0x0 0x20>,
@@ -152,6 +154,7 @@ ipi_mailbox_pmu1: mailbox@ff9905c0 {
 	dcc: dcc {
 		compatible = "arm,dcc";
 		status = "disabled";
+		bootph-all;
 	};
 
 	pmu {
@@ -177,8 +180,10 @@ zynqmp_firmware: zynqmp-firmware {
 			compatible = "xlnx,zynqmp-firmware";
 			#power-domain-cells = <1>;
 			method = "smc";
+			bootph-all;
 
 			zynqmp_power: zynqmp-power {
+				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
 				interrupts = <0 35 4>;
@@ -258,6 +263,7 @@ r5f-1 {
 
 	amba: axi {
 		compatible = "simple-bus";
+		bootph-all;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -699,6 +705,7 @@ pcie_intc: legacy-interrupt-controller {
 		};
 
 		qspi: spi@ff0f0000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-qspi-1.0";
 			status = "disabled";
 			clock-names = "ref_clk", "pclk";
@@ -745,6 +752,7 @@ sata: ahci@fd0c0000 {
 		};
 
 		sdhci0: mmc@ff160000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -759,6 +767,7 @@ sdhci0: mmc@ff160000 {
 		};
 
 		sdhci1: mmc@ff170000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -851,6 +860,7 @@ ttc3: timer@ff140000 {
 		};
 
 		uart0: serial@ff000000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -861,6 +871,7 @@ uart0: serial@ff000000 {
 		};
 
 		uart1: serial@ff010000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -982,6 +993,7 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
 		};
 
 		zynqmp_dpsub: display@fd4a0000 {
+			bootph-all;
 			compatible = "xlnx,zynqmp-dpsub-1.7";
 			status = "disabled";
 			reg = <0x0 0xfd4a0000 0x0 0x1000>,
-- 
2.36.1

