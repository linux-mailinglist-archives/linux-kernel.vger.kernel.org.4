Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B074D3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGJKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGJKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:52:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCCCC;
        Mon, 10 Jul 2023 03:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezMUKklfNwhwxxILkv3vW+GWZLdtyl9yIjYx5nIh4JUQKY8aE1dhnSbiW/SHofR3/WQMGk/v6GpOSQZ6XxjNri4HCOcxy/JA65jbk7CP2whGZvnOaiIpO8McIbHLhXAutjgcb/HV+q2jcq29SwqCv633pyo4Di4ZrVwTmQC3HjASWdZ9Qx3IrjbE/cZuQYddN0qNd3N8NT0Yw3EOEW+FlLPqClj8s90PzZfrjKZtnXD+2r8BRdBFryiwvBP5fu+z0jXF+gQMIRvrzBn5zfxnyCDXZIiS7b2adhyoo82dBKTRzQ7ncly4lLSWxR5jKm0gp41j8c+voQB0PNaI/IWBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/46CWlz/FfkPWH8OoT2ZoTe+9zE8HBkqhN5eiVLCGx8=;
 b=XGxrmJF8v3QpPFbpi46Hvk1C+QtqDvEYlkO0J+SkJWBKL6Mn/wXL82OPKovidwftv3NGl0wp66gY039Nze1OqFEARb+OSHrCWx12SVacyrJ4VnIKSHiq2ErordTcpQPAQlzaCRzpIxE1XQVNV1kPAPr4ApOo240Ynn4x80JgeD10tUJiJ9l2AVfEqIhzU8brUUB6spiIPXiNt/Fc0R9PMWl48RWruR8AUHZFJrELKQvYcCSeQ3LN90MwOv26EW8gvwD387/zgHUOpqY1va/apZKyd7d4aKn0ZrEe9VNJJRA3q/z7h9ub7nJScGdMWQSsd37912g2JSZ9UxPPxhTnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/46CWlz/FfkPWH8OoT2ZoTe+9zE8HBkqhN5eiVLCGx8=;
 b=zOxTc4EvqWDwmV1usSVHGx+zHdtodAwZIzlnhpxUhc90YrheEmt8nfOToNFaUK0HzIVKfpWkptZivWB14HokAKtwJ/zzJ2KhPifZ0OMt8kXEOMoGZeYTHkfGv55XgwUxctvKs/RjY6b2d4z6zmEgZgJPOZEx3KFVAU13gMR12h0=
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:52:24 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::45) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 10:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 10:52:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 05:52:21 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Describe interrupts by using macros
Date:   Mon, 10 Jul 2023 12:52:19 +0200
Message-ID: <9d5bd17f37772be186cab17b06cc21351d36ff62.1688986332.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22948; i=michal.simek@amd.com; h=from:subject:message-id; bh=aLKXs4kvqhlVj0oodh2OLtjNPZOh8gtgWUVwoXCFdbY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTVj+6yae6Lcn58gD14SrfpItGrv0xiK7muPpm0aI5P9 ymeXbz7O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEMlwY5hddU31amy/8S2vT P1Xf55tnnPPMm8owz6j46YeLxWefT0lOn8jaYflxVeLEqwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0eba0e-fc72-4fee-d63a-08db8133be84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyGlFYW0LsFgHY56+7rLsDC9nrGn00Zt8JyAyVo7ii0fqCzln8FYTFlLlEkg2HwjRglLw9yN9JCkxfQhXFfkQ0oJR1xYbex3eu8qxBqzWf4n9heaTvDJqPYgx1TuexjJ5xMSqMP+Kjcp/pe9yFpjbbqUUT5fZ/ia9LVWa/KltbDLV1OZiHBpxsCZ866+Zkcg1odC2jF68Zt94q4CbxphoSVhw4tnvUPpTGqosSXAK4o9GOO88cVlBqiLwa3JtZEVU6wu4J+z5qHwX5TAAZBcaxrB/Fo7IVkGYb+ujQPgs17w/mmTA+V5qSi8UdM4pr93lsSSQG1ZREH43qs79FJvaqrZ8fGoVBukoOZdnnIq59EWTq/Hop7Q8524y85o6fZngX1OIRrlt4dk7x/OcbV9ASlcRxOPy/xKFgu4hGTKDTy+ZUyVC+Y0qJyHq7a1jHyDm8YVEVc2aim/X/p2YOLuTUVOU7p3pyXBr1ruG3L0wvw3hUNJbT6/LItnUJsgWt8t2Gy7WwHlaFIcLkLQpMd+jpLttrSkmn9GeuKp65BwOJ8Enw5M7g9WLFCG/vn77yPdEWB5GTFpH4pndcWr7CA+R7TtD3TWROlnRnN8dtnXdQlc3OykfqSfPlCGMyArHz4128ZtSlqNeH+xbsBzbtuEVy56I80o/Jh+wDIS+jP8pbgwGfSPeX3nLQiqc4jpfgf5qMHV1HxsY09M7NSnfKUo/yXAS6+FyRiUI6ZjimOqQmbrC24b7pdAE4qK2gbQwvwgPmo7i9XoxINQcOdyMOU+w0k/vAnUnibYcmrKs/1SJuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(110136005)(54906003)(36860700001)(47076005)(426003)(83380400001)(36756003)(86362001)(40460700003)(40480700001)(2616005)(30864003)(2906002)(70206006)(82310400005)(336012)(70586007)(26005)(16526019)(186003)(966005)(81166007)(82740400003)(356005)(8676002)(4326008)(5660300002)(316002)(41300700001)(8936002)(44832011)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:52:24.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0eba0e-fc72-4fee-d63a-08db8133be84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use arm-gic.h and irq.h for interrupt description. It helps to improve
readability of device tree file.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Discussed at https://lore.kernel.org/r/20230621141307.GC18703@pendragon.ideasonboard.com
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 185 +++++++++++++++----------
 1 file changed, 110 insertions(+), 75 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74898f3a3537..b61fc99cd911 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -14,6 +14,8 @@
 
 #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
@@ -131,7 +133,7 @@ zynqmp_ipi: zynqmp_ipi {
 		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
-		interrupts = <0 35 4>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		xlnx,ipi-id = <0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -161,10 +163,10 @@ dcc: dcc {
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
-		interrupts = <0 143 4>,
-			     <0 144 4>,
-			     <0 145 4>,
-			     <0 146 4>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>,
 				     <&cpu1>,
 				     <&cpu2>,
@@ -187,7 +189,7 @@ zynqmp_power: zynqmp-power {
 				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
-				interrupts = <0 35 4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 				mboxes = <&ipi_mailbox_pmu1 0>, <&ipi_mailbox_pmu1 1>;
 				mbox-names = "tx", "rx";
 			};
@@ -231,10 +233,10 @@ modepin_gpio: gpio {
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	fpga_full: fpga-full {
@@ -274,7 +276,7 @@ can0: can@ff060000 {
 			status = "disabled";
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff060000 0x0 0x1000>;
-			interrupts = <0 23 4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
@@ -286,7 +288,7 @@ can1: can@ff070000 {
 			status = "disabled";
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff070000 0x0 0x1000>;
-			interrupts = <0 24 4>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
@@ -305,11 +307,11 @@ pmu@9000 {
 				compatible = "arm,cci-400-pmu,r1";
 				reg = <0x9000 0x5000>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>;
+				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -319,7 +321,7 @@ fpd_dma_chan1: dma-controller@fd500000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd500000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 124 4>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -332,7 +334,7 @@ fpd_dma_chan2: dma-controller@fd510000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd510000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 125 4>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -345,7 +347,7 @@ fpd_dma_chan3: dma-controller@fd520000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd520000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 126 4>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -358,7 +360,7 @@ fpd_dma_chan4: dma-controller@fd530000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd530000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 127 4>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -371,7 +373,7 @@ fpd_dma_chan5: dma-controller@fd540000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd540000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 128 4>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -384,7 +386,7 @@ fpd_dma_chan6: dma-controller@fd550000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd550000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 129 4>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -397,7 +399,7 @@ fpd_dma_chan7: dma-controller@fd560000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd560000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 130 4>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -410,7 +412,7 @@ fpd_dma_chan8: dma-controller@fd570000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd570000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 131 4>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -427,7 +429,7 @@ gic: interrupt-controller@f9010000 {
 			      <0x0 0xf9060000 0x0 0x20000>;
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		gpu: gpu@fd4b0000 {
@@ -435,8 +437,12 @@ gpu: gpu@fd4b0000 {
 			compatible = "xlnx,zynqmp-mali", "arm,mali-400";
 			reg = <0x0 0xfd4b0000 0x0 0x10000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 132 4>, <0 132 4>, <0 132 4>,
-				     <0 132 4>, <0 132 4>, <0 132 4>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1", "ppmmu1";
 			clock-names = "bus", "core";
 			power-domains = <&zynqmp_firmware PD_GPU>;
@@ -451,7 +457,7 @@ lpd_dma_chan1: dma-controller@ffa80000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa80000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 77 4>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -464,7 +470,7 @@ lpd_dma_chan2: dma-controller@ffa90000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa90000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -477,7 +483,7 @@ lpd_dma_chan3: dma-controller@ffaa0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaa0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 79 4>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -490,7 +496,7 @@ lpd_dma_chan4: dma-controller@ffab0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffab0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 80 4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -503,7 +509,7 @@ lpd_dma_chan5: dma-controller@ffac0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffac0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 81 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -516,7 +522,7 @@ lpd_dma_chan6: dma-controller@ffad0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffad0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 82 4>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -529,7 +535,7 @@ lpd_dma_chan7: dma-controller@ffae0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffae0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 83 4>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -542,7 +548,7 @@ lpd_dma_chan8: dma-controller@ffaf0000 {
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaf0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 84 4>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -554,7 +560,7 @@ mc: memory-controller@fd070000 {
 			compatible = "xlnx,zynqmp-ddrc-2.40a";
 			reg = <0x0 0xfd070000 0x0 0x30000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 112 4>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		nand0: nand-controller@ff100000 {
@@ -563,7 +569,7 @@ nand0: nand-controller@ff100000 {
 			reg = <0x0 0xff100000 0x0 0x1000>;
 			clock-names = "controller", "bus";
 			interrupt-parent = <&gic>;
-			interrupts = <0 14 4>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x872>;
@@ -574,7 +580,8 @@ gem0: ethernet@ff0b0000 {
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 57 4>, <0 57 4>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -589,7 +596,8 @@ gem1: ethernet@ff0c0000 {
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 59 4>, <0 59 4>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -604,7 +612,8 @@ gem2: ethernet@ff0d0000 {
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 61 4>, <0 61 4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -619,7 +628,8 @@ gem3: ethernet@ff0e0000 {
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 63 4>, <0 63 4>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -636,7 +646,7 @@ gpio: gpio@ff0a0000 {
 			#gpio-cells = <0x2>;
 			gpio-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 16 4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x0 0xff0a0000 0x0 0x1000>;
@@ -647,7 +657,7 @@ i2c0: i2c@ff020000 {
 			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 17 4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff020000 0x0 0x1000>;
 			#address-cells = <1>;
@@ -659,7 +669,7 @@ i2c1: i2c@ff030000 {
 			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 18 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff030000 0x0 0x1000>;
 			#address-cells = <1>;
@@ -676,11 +686,11 @@ pcie: pcie@fd0e0000 {
 			msi-controller;
 			device_type = "pci";
 			interrupt-parent = <&gic>;
-			interrupts = <0 118 4>,
-				     <0 117 4>,
-				     <0 116 4>,
-				     <0 115 4>,	/* MSI_1 [63...32] */
-				     <0 114 4>;	/* MSI_0 [31...0] */
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,	/* MSI_1 [63...32] */
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;	/* MSI_0 [31...0] */
 			interrupt-names = "misc", "dummy", "intx",
 					  "msi1", "msi0";
 			msi-parent = <&pcie>;
@@ -710,7 +720,7 @@ qspi: spi@ff0f0000 {
 			compatible = "xlnx,zynqmp-qspi-1.0";
 			status = "disabled";
 			clock-names = "ref_clk", "pclk";
-			interrupts = <0 15 4>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
@@ -735,7 +745,8 @@ rtc: rtc@ffa60000 {
 			status = "disabled";
 			reg = <0x0 0xffa60000 0x0 0x100>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 26 4>, <0 27 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "alarm", "sec";
 			calibration = <0x7FFF>;
 		};
@@ -745,7 +756,7 @@ sata: ahci@fd0c0000 {
 			status = "disabled";
 			reg = <0x0 0xfd0c0000 0x0 0x2000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 133 4>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
@@ -757,7 +768,7 @@ sdhci0: mmc@ff160000 {
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 48 4>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			iommus = <&smmu 0x870>;
@@ -772,7 +783,7 @@ sdhci1: mmc@ff170000 {
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 49 4>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			iommus = <&smmu 0x871>;
@@ -789,18 +800,30 @@ smmu: iommu@fd800000 {
 			status = "disabled";
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		spi0: spi@ff040000 {
 			compatible = "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 19 4>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff040000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
 			#address-cells = <1>;
@@ -812,7 +835,7 @@ spi1: spi@ff050000 {
 			compatible = "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 20 4>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff050000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
 			#address-cells = <1>;
@@ -824,7 +847,9 @@ ttc0: timer@ff110000 {
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff110000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_0>;
@@ -834,7 +859,9 @@ ttc1: timer@ff120000 {
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 39 4>, <0 40 4>, <0 41 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff120000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_1>;
@@ -844,7 +871,9 @@ ttc2: timer@ff130000 {
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 42 4>, <0 43 4>, <0 44 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff130000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_2>;
@@ -854,7 +883,9 @@ ttc3: timer@ff140000 {
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 45 4>, <0 46 4>, <0 47 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff140000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_3>;
@@ -865,7 +896,7 @@ uart0: serial@ff000000 {
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 21 4>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff000000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_0>;
@@ -876,7 +907,7 @@ uart1: serial@ff010000 {
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 22 4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff010000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_1>;
@@ -901,7 +932,9 @@ dwc3_0: usb@fe200000 {
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "host", "peripheral", "otg";
-				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "bus_early", "ref";
 				iommus = <&smmu 0x860>;
 				snps,quirk-frame-length-adjustment = <0x20>;
@@ -928,7 +961,9 @@ dwc3_1: usb@fe300000 {
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "host", "peripheral", "otg";
-				interrupts = <0 70 4>, <0 70 4>, <0 74 4>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "bus_early", "ref";
 				iommus = <&smmu 0x861>;
 				snps,quirk-frame-length-adjustment = <0x20>;
@@ -941,7 +976,7 @@ watchdog0: watchdog@fd4d0000 {
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 113 1>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <60>;
 			reset-on-timeout;
@@ -951,7 +986,7 @@ lpd_watchdog: watchdog@ff150000 {
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 52 1>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
 			reg = <0x0 0xff150000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
@@ -960,7 +995,7 @@ xilinx_ams: ams@ffa50000 {
 			compatible = "xlnx,zynqmp-ams";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 56 4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xffa50000 0x0 0x800>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -986,7 +1021,7 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
 			compatible = "xlnx,zynqmp-dpdma";
 			status = "disabled";
 			reg = <0x0 0xfd4c0000 0x0 0x1000>;
-			interrupts = <0 122 4>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			clock-names = "axi_clk";
 			power-domains = <&zynqmp_firmware PD_DP>;
@@ -1002,7 +1037,7 @@ zynqmp_dpsub: display@fd4a0000 {
 			      <0x0 0xfd4ab000 0x0 0x1000>,
 			      <0x0 0xfd4ac000 0x0 0x1000>;
 			reg-names = "dp", "blend", "av_buf", "aud";
-			interrupts = <0 119 4>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			clock-names = "dp_apb_clk", "dp_aud_clk",
 				      "dp_vtc_pixel_clk_in";
-- 
2.36.1

