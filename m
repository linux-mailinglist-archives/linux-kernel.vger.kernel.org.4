Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29D64831B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLIN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:15 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FB76165;
        Fri,  9 Dec 2022 05:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw5l77L04niLAWb9Y3PLjA8OYgdeIQSRWeq8a4YowdfrSiLmxC2QKwsrbiENR6+9EeP9a69y4PIS2coYRtGYdxKTUYBj1a9D26HB9qxFwyVPgMh1wlhHoQ65RH+2EZonehnBftUIjstnSuH+0cJ1OLIvbH+0B5KKkz5kClyjdezp6sUUysqni+Njb6wXgHuylsuuFlnOgE+Z5bHcvyv6luE0v8jtv1mWsEOlpL/qIp4k8uhTkqGzHuWp5Mq7s0PojdkdujoYQLkik3FCHH/XHrBIT1LZTBHLRgd0fLR/WI4Qfeiqc64+EK69aQ01L7QosfGD0rVyvIxv53mjB/cVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6dHTthPkX5f9MPuEqQP5Jdbzvdd+pPIbfAVeThdQH0=;
 b=iG3IF91HNPW8g44flBKbfZCH9tEmrhRG7whBYKO2BMutH/NkzCLOVcjvP6NWXRF56ZTzOGPRB+3CPucYF46rbVLjTOPhynT+01VEIChrHEuavHDYHmLZT4tUm0wGvp/G4SujUB/gCWq1bvmCej242WcMvItJVvARFvCTrRLaHbgIXUgdgIPyo1xtd6lPxTW+bZNHsbBS7e1nqVYTyY1P2977p0+lKIlD6iNAKing6sZBACzU279SDgO3PPAwFfMdVc/T6f+DCnKvc8mlBp48lDouiz12cIaAB3uaibZU5mAeWAkO2akKlAB+Sx2YzZszL4S66kw38kgHvM4W52vcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6dHTthPkX5f9MPuEqQP5Jdbzvdd+pPIbfAVeThdQH0=;
 b=uJklbxXTTh/5eTySPJmZ3UYv6eM8dmdmr+qevIf/RFo87fOP8xLfB7FkAPoHDNAD61GbiHxWAsZr3PrSycKyu1yeehHAyAVXOK0OQ07O/ocaQUK1Oh5SOOB6IevK3ZJpKcGSQzn8C9bLiTkJmuKuDm75ZFO57FFXEADRF6H3bqM=
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 13:58:12 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::6d) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 13:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 13:58:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 07:58:10 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: zynqmp: Remove clock-names from GEM in zynqmp-clk-ccf.dtsi
Date:   Fri, 9 Dec 2022 14:58:07 +0100
Message-ID: <24ce27f91a55ed04ca7ee2ff7db0c674702ef722.1670594284.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|SA0PR12MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0507d1-ca6b-488e-a7ad-08dad9ed68ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXNfisOXOVNQhQNGUvaTEsoRPqX1BmClQuY+3AV/e1DcUW6O/ZbNApVTKZZYyItlkevur8O+3JrAlbw/wZSCymB/23K/+5WqIVTLnuGYRWKNHPv54P06xFSB61BXkQb7noSzRd7yGLtQm8DuivY1G/M449J7iQvd1+eObLainIbCjq7ar2t2FJH30jfcKnG84Hn4Nm9ozXa2URrr0v+B1ZthXG4qn1yr261a/GwbENEWIDJzE9yyyoemYn/hIODyL/QOZ52F79A2RjYzbRkq+bEPcXNuoIzjFGn1j9T+KSnGcAkNFZEd5fqINvoj1o8Bp0MVNbIRqqgjCB4wq4f1EPYk0+hUikwr1txVaEVfGgx9tN3pbTffNg35rMs+BsfYYz7tyRcKGbAPgNmd6eC+tYXGF1O+v42UynS0B2ZTEvvgR++OTazadLeFEnzw57BLSoNK+qOgXBP/EByZC6pnXs8L/qy05/EY9Jw5/L1upO0f/yrF/ZJP6QufSfvcA1/ahWPECdUNeS1I3axayhEES9nphdiWlG9HcqacudAYzwlG5gb33HDJTN8Hx5WF3RyU5mrXkSbJwNp8wnL1AN3IygAyIVJrBVlA944KyDGjvudYuJB95jQxJr19Hb7q0L2av+roiepCZ10LXl9HMGeu1fQT5LT7D6hSTXfLeJGjuk2BLJPMPThMUAOWC9reQfwQRZQ62kjC832pQ7boWx3y4FhbiB0BwYMHFjys/U+ODDrSRRm2aSapewA9n0ljq65a
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(356005)(40460700003)(44832011)(54906003)(81166007)(86362001)(8936002)(7416002)(5660300002)(82740400003)(41300700001)(4326008)(36860700001)(2906002)(186003)(70206006)(82310400005)(478600001)(40480700001)(336012)(426003)(26005)(47076005)(6666004)(2616005)(110136005)(70586007)(316002)(8676002)(16526019)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 13:58:11.6563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0507d1-ca6b-488e-a7ad-08dad9ed68ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove clock-names from GEM nodes from clk-ccf because they should be only
present in zynqmp.dtsi. And as is visible both clock-names defined didn't
really match.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 8 ++++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index e172fa05c9a0..3e9979ab60bb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -135,28 +135,24 @@ &gem0 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
 		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
 		 <&zynqmp_clk GEM_TSU>;
-	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 };
 
 &gem1 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
 		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
 		 <&zynqmp_clk GEM_TSU>;
-	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 };
 
 &gem2 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
 		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
 		 <&zynqmp_clk GEM_TSU>;
-	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 };
 
 &gem3 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
 		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
 		 <&zynqmp_clk GEM_TSU>;
-	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 };
 
 &gpio {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 233127d94204..518a3d98b4b9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -512,7 +512,7 @@ gem0: ethernet@ff0b0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 57 4>, <0 57 4>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
-			clock-names = "pclk", "hclk", "tx_clk";
+			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x874>;
@@ -527,7 +527,7 @@ gem1: ethernet@ff0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 59 4>, <0 59 4>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
-			clock-names = "pclk", "hclk", "tx_clk";
+			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x875>;
@@ -542,7 +542,7 @@ gem2: ethernet@ff0d0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 61 4>, <0 61 4>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
-			clock-names = "pclk", "hclk", "tx_clk";
+			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x876>;
@@ -557,7 +557,7 @@ gem3: ethernet@ff0e0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 63 4>, <0 63 4>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
-			clock-names = "pclk", "hclk", "tx_clk";
+			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x877>;
-- 
2.36.1

