Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6E6F4525
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjEBNih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjEBNiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:38:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FB659F;
        Tue,  2 May 2023 06:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0ozlpgmFjVggfKAli/ZF2L85pXCk4rviFZ9fiNc6CNnHk8g3FO3MTimzipgyLlY4Fos/H0qfgkPhH2YopW7nuWOkWG0MvcclbJ+eWyLh6zOQRD8CD4GxTcmk/LMVx9/UqDxf7tHBxeZOZ43/IUPIoG867R7zdE8dNshboDdSqxpCYd194pARKCIM4PmGARgq4Fi4eq9LtAuMOLnguYrnm0tCc8zlJK11/z4TseayHeHF00OMZZr3WDC33Ayldmr10eMkkZag/zXKSzfELt02ODhRMDmG6nW2rDyt8mOVPgk8SCQKTvmR5OjzXhOM3rXehTFJoYqV82DVJvUzDiFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fofahKMjfO5rrYTTxVK0trn6gvPhnCOU0fr+xlH0Pg=;
 b=ayLuHCjAlpgqPoyl46bnNTL9Zrbtzxkaj9U0E2+uZbwJgAuiX/qZdSl+NL4ybPcuyjKz8kbmgWoJZNjXhQ2+BiaH1GBrlkKgJ3Yl8QyodqxZtTVxP/PZpkQq2RIcNNDDgT78aiTWsvw+rQcXvgPR2HbM95USQ81PD+MtyywMpvKZg5vhCkpQDPNNdtHcZkzS5D5zjjhE6uzL1Z5sKlfeLokT5YB6XkDeOBmtUiR53+9mNXjWUzugP0x18CK99oASx6X1V9ZWqAK5KS+vmiUBoEGP+zib0pPkHcE/kdA+pewaQx5fRzfVlMQ6gbiHyxpsfBAPIND/3GaxzgZgyfxEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fofahKMjfO5rrYTTxVK0trn6gvPhnCOU0fr+xlH0Pg=;
 b=OPUHdnQQ8rcP5VmvT9kA/dvooNahy4HumG1qPLL18ORMvT3SfJbjupP9hYtmvK32zzV73Q259ocNCyYiDrO/7pUi2wrKsnE3s1oqQKtXmwzs8BR7rXDMH1NRVscKlnmigFReM5USSUk/SU+jyIRrdg+zlb5RNKoU4BfFAITWUb8=
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Tue, 2 May 2023 13:37:18 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::24) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:37:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:54 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        "Srinivas Neeli" <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 11/23] arm64: zynqmp: Use assigned-clock-rates for setting up SD clock in SOM
Date:   Tue, 2 May 2023 15:35:39 +0200
Message-ID: <cf5a4e412e1674500a71a0b1eed7fa8393f37ae9.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: bda28322-b85c-478b-ee1f-08db4b12595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1NMfNIs43JjILmw333IWdBWlwd3WLymJ4CReK6zBq3c33T9snjM76i/2FJzVo/Ochbhu5IaqFBJie+HVSEcPmu8ob/mcA+FuMqgYGVnSw7rhgJ1gn3FMWn6QriifcXcdQj4wIzRHjWVo6bIA9wzuf3f6xAzUg2HsJVqiGGuW2503IGUrK6sps+lMbohwOGR7DhZm4RCV/awkWGKWQMn745U6bNtpHyLgjlySXe8AKrWTIIs5epSYUEHohNBXUvglbKh5YzZkHHQBOFjagNpzktahkLB2jMl45sKwvH9CJu6R/Evgw4zJv7/5eQWDHxNNKc+cP14ibZLGzukE+bQOEIFkN76SPnxHPIrkKDGaGe+h7/8Enj1wjiwxRg6PdYXsslyrqix7YUM7tQWOavi1tK8DtsQ/GbXOak/YaTOyl2/25Uw3kWZTR6EA3KvdjeaPWPGm+jaeXpzmrsCGR6xFDj1eLk87ndcEKzk8iGq4ohQxxeMdgbzYKEjouNxoZuEe0maBXhITmSX/LAaGPPmwqQNuSxnzL5/SoquPvZn0OqHNQLunWwzVNM0V2aZeaNLVe+KN5AGFrdWiwGkZiZfcWdh0qpUe/B3gkq9xT5XMsUOZafTCF8x10vKiABP90aWZrphi44cAY1HQDds+rOAzWl1qMcQVVNDuQUdnyKyQEMuYl0TumnRkA9jFsml4kaGqOMrIQhfCA15pc89VuZsDpUzWVEHkNtAHIV2auaRYpj2YzkFK5ZX9W2K0PbcF1iW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(4326008)(82740400003)(70206006)(70586007)(81166007)(356005)(316002)(2906002)(40480700001)(40460700003)(41300700001)(7416002)(44832011)(8936002)(8676002)(5660300002)(16526019)(26005)(186003)(6666004)(82310400005)(36860700001)(83380400001)(47076005)(336012)(426003)(36756003)(2616005)(478600001)(54906003)(110136005)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:37:18.3032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda28322-b85c-478b-ee1f-08db4b12595c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With limited low level configuration done via psu-init only IPs connected
on SOM are initialized and configured. All IPs connected to carrier card
are not initialized. There is a need to do proper reset, pin configuration
and also clock setting.
The patch targets the last part which is setting up proper clock for EMMC
on production SOMs and SD on kv260-revB.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 5e7e1bf5b811..681885c9bcbb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -2,7 +2,8 @@
 /*
  * Clock specification for Xilinx ZynqMP
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -185,10 +186,12 @@ &sata {
 
 &sdhci0 {
 	clocks = <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk SDIO0_REF>;
 };
 
 &sdhci1 {
 	clocks = <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
+	assigned-clocks = <&zynqmp_clk SDIO1_REF>;
 };
 
 &spi0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 2f7a17ec58b4..cb4a5126c4ec 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -133,6 +133,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
+	assigned-clock-rates = <187498123>;
 };
 
 &gem3 { /* required by spec */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 4695e0e3714f..31bc120dee49 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -116,6 +116,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	clk-phase-sd-hs = <126>, <60>;
 	clk-phase-uhs-sdr25 = <120>, <60>;
 	clk-phase-uhs-ddr50 = <126>, <48>;
+	assigned-clock-rates = <187498123>;
 };
 
 &gem3 { /* required by spec */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 340a5c43a8b6..d3c6a9feb114 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -178,6 +178,7 @@ &sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A */
 	disable-wp;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
+	assigned-clock-rates = <187498123>;
 };
 
 &spi1 { /* MIO6, 9-11 */
-- 
2.36.1

