Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308266F453D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjEBNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjEBNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7636A68;
        Tue,  2 May 2023 06:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy3MLjl9HaclLBAO/xWPeru3NGyYShkh7j/ClvnfNa7H997HIPZ1s2dTn/qcx3M5BN9rXJtdAtZNrAvcFYJjWrCU1uUqNblLljAzR043qQfnJFrSlT9FMS825nEAwf5rA3+9YjUhD10Ea/p47XiD5yQ5CIqzyBqtOTXetSTn/8MlWiUiRYDomT3TnPAGE2Hy8HpCmWsl9drlhmRpVSEp6NoCFF/G+OfksID8dvgUuLPD0p0G4u4v9voqz51sP5Q5yTXDq82yIBrKjBL/v1JirYUVjusm8NQWDnvq+Z5KfaEK2jOdwXsLssi0pqOfGxUFKRPl7dqjrMsfNbpKPWxKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNiveV60GuuaJ0XYxjjVasyQZ671WbS96Ms8V5ryStE=;
 b=aAJK9bdVjH2d/vGPXDv1Pl+NpTh8AF952oJkdoggjjommjXl8sLVD+NZQ3dlpLyYD8KfvNpTt6H3e9a3H16MRHTeh3Zt58Jb5viC51ALkAUAKT86QTRmMaS88hp1G/obWmltpYFVS/osUQDdc0SIfkklbVcREmwXNqGRlHPUlFdEjZMWRVmZfGu6oLtqcMSkltRiTnZAD7/aRX1cb3cUn7mE0fBCNhfzGjBjt8WdDTA75jarFZ0y1TGjfZHq9EWkf9cTWEiD22pXSHmKQCF6Z+ZrGAEtxVIkhI6mfvsSu06ivBIQHTOw3U0YAVzjsXIj88l/cLKw36CPyOwHKSYTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNiveV60GuuaJ0XYxjjVasyQZ671WbS96Ms8V5ryStE=;
 b=r91CXhNXZTYazMC+Ujz40necvXTv+947lP4/JQn1bJsiNAMYYkB0+ZUr0ncIr6oygIbJFAlG1Y8u9V1Zbt59/oCPyOMVrBaZd8LsalKM6AeY0iMrLTkixgaxeDhhzhvFmbfV0zSrPg0i+qK8kQDxrZ16iXqpnY/PtpPCY6N3Poc=
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:38:52 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:38:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:44 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        "Vishal Sagar" <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 18/23] arm64: zynqmp: Setup clock for DP and DPDMA
Date:   Tue, 2 May 2023 15:35:46 +0200
Message-ID: <807e22371394222f728ff7d6b190a96a12145439.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e02d32-4c35-4f63-dba1-08db4b129151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7O9q3E25MMZp6VdWd8ozuBIFi6r8yTnTYKOYInXj6c8rcyyp/bG9wOZPGmBLnAANh/vptUS4Fdx5SurtXtTYdKWuvjdocRsy1oWsCO6rKDmStjtX3Iq7v9g4A8XcixMOOy4xKltIUByOkGL2PMU8L1dyqlWvrTvT8CydcqWn32tE7LgAur3PkyxElpovv8h79AaiZ8NWSAcNHcxpA71BqiRn9bUosbSpuL5sA5uI2Die3azYlqqOogDWm6LQhFRjmYN0epxHDEmLWDgQWYz1I0ttOWuMd+bMZIrw36tBfUKqhPRni+XGOC6FqJ+PQIW2sUJP+pDbSAnlRaK14XGhF3wyHbZZzSQfU9RQ0skAc9crGT5ZYNcPq+sbs9Ydnu6KbEnfy4jC6ZTilgNVvSX3Qa10Ss4kPMofD8ghxOZjjUP+UvHoBiiXNhh5M+kTvtkL8VJY+w1w37J0rxrxGwDDQ/gOdYkzECRsC6JZf9li/RQMj3mYl3JQdaAM9IzjUld4hOW0LOuh5O/RMO6jPehic5o0m/shhpNHXuTTzeVwb53lCaQL/EzYiPMAO1ZJxm3rghgFecNJ6NeThNCQ1etOUO2RlviJs3vmHjQomXU1Kdp8u4+jMvnhb5C0+ycXp9hO8LjQljit93252eBFww/m9GccbxoKMMWpleCsi5DYcXjlkc4QwZnkRmrTX+RbtT9SD6EqqPCw56zoGNdeTGCpGtAHiSLg/ofDqF2BCpB0mwGces7e0+JNIxCu9U7myo+w
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(44832011)(7416002)(2906002)(40460700003)(86362001)(82310400005)(41300700001)(4326008)(70586007)(70206006)(478600001)(316002)(5660300002)(110136005)(40480700001)(8676002)(8936002)(54906003)(82740400003)(36756003)(81166007)(356005)(26005)(16526019)(186003)(2616005)(83380400001)(47076005)(336012)(36860700001)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:52.1831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e02d32-4c35-4f63-dba1-08db4b129151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks are coming from shared HW design where these frequencies should be
aligned with PLL setup.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 681885c9bcbb..581221fdadf1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -248,10 +248,14 @@ &xilinx_ams {
 
 &zynqmp_dpdma {
 	clocks = <&zynqmp_clk DPDMA_REF>;
+	assigned-clocks = <&zynqmp_clk DPDMA_REF>; /* apll */
 };
 
 &zynqmp_dpsub {
 	clocks = <&zynqmp_clk TOPSW_LSBUS>,
 		 <&zynqmp_clk DP_AUDIO_REF>,
 		 <&zynqmp_clk DP_VIDEO_REF>;
+	assigned-clocks = <&zynqmp_clk DP_STC_REF>,
+			  <&zynqmp_clk DP_AUDIO_REF>,
+			  <&zynqmp_clk DP_VIDEO_REF>;  /* rpll, rpll, vpll */
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 817d756142ab..4f18b3efcced 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -99,10 +99,12 @@ &zynqmp_dpsub {
 	status = "disabled";
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
+	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 };
 
 &zynqmp_dpdma {
 	status = "okay";
+	assigned-clock-rates = <600000000>;
 };
 
 &usb0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index e07cec231ee0..77bc806b15a1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -80,10 +80,12 @@ &zynqmp_dpsub {
 	status = "disabled";
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
+	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 };
 
 &zynqmp_dpdma {
 	status = "okay";
+	assigned-clock-rates = <600000000>;
 };
 
 &usb0 {
-- 
2.36.1

