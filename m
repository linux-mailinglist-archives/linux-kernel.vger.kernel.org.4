Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A6648317
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLIN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:56:23 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DF750B5;
        Fri,  9 Dec 2022 05:56:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb7JUsBCnTaap2vo4jrgZX+X3ocPYDrjwKODlKur8IDNzML6T42mypSDSaFUCKcHbh/Okjl1T0Xaw+gfGZIVSEQAzp8CPoS+sgpFKA+AbmzUN2WmOl3umsdDqHkXu0jhLK0lORP+lbUmBF0Yf0JfnshwTLg/r9P7kZpbvjwf0ht1RKTJFBKe6OjwhxioM6D1A1Q7sRsBrcDfTiiLfRPdYwzd88mvk2hwknCGrLJYtMt+C5ZqPNps5wlKm2AxXshV0N/xBBs7fcaEowUuajINO3RnTNQEpY9I2RmCbyp0qXeSUrw76fO4uUL/420vndynKG93Y260L8tkGGuDjm9T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k5h5lhr2PvmljMYoRTa4p4OJEL171/4zdWGy2YOz8w=;
 b=SpnM79Be30V+n989FYKy6f/4N0T6RqofkHiM19Nbk7vgpuMar3039mBxM3g6hMkhM83tLefytLlRFBUcuTJFVHAtPu/72R/rw7q+4u/0laEczxUP1t9ky7gtBUH9TqLIXPUSCZ6y/fkfhMXCZuEM7HdsMPI7YFmWMwSNVifU05Gw8ycWJIy77WPzYEkDsQ3SdJUFiGlD2H6e2FVnc10vhFKD/PeGfFO+dt+QIEuXozOZmwu9CegPwG+VLRSHJqoc5HhX/BYF2l1VuVGfQlCKJVRywjiFhrsPtavMgAD+sAnADwkBVwOAi4eQn2oqTWhNmKIHt2kKM9erV2vl0y8Lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k5h5lhr2PvmljMYoRTa4p4OJEL171/4zdWGy2YOz8w=;
 b=XMIQuoJjGHNz+8WjTlkjkxE4Bxqp/YvXTJWhXWm/RLXlxU44dvv/d4J8LzdoBS80r6odqz625kAIFwJHT4xUzgjTSUWb44/yUa/L9ZYxkDf1I8cDNVt9oVqHQ9O1LF+ajhILB62Hv12L4ma/5B3QqhXl6YiqmsU656rdbTNJYY4=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.18; Fri, 9 Dec 2022 13:56:19 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::54) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 13:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Fri, 9 Dec 2022 13:56:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 07:56:18 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible string
Date:   Fri, 9 Dec 2022 14:56:15 +0100
Message-ID: <718283a9f5493ab63b4aaa12337dd5cab6538ff5.1670594172.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: b706bb9b-02b5-4d8d-ef34-08dad9ed2612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cPJZELbIfyKT1HURUB94K5p319U2tVdefqJ/FU44CedoaBRMhfaDkLzGXwSv/uwWS6KQ+KpaEG7r1k0UjQgJ6SSoz2/R5XTpUfaGQra1+CclxDoZduDLIIHaGYFNlPF0WTAR9HoQRcWp3FHrQqKhk5jxZK6SoMHDXlGH3769gpO+FaiXhgdb5xSQzg0AX3KMofxjcYEnGWhJAJ9mivLTBhXqAeIbST2PeTdR5lzOo+NC7LAGRI/ZVYA+rqbx7BEYikZX9cq+O8i5G89aIeQJuN5xs7es+96NT/H7P0OjwWEGL0T5AKUn2/Kx0GObr7zPQPj0qrfghci2XpK6r39CvS/FY3GISBL+OhnYa8de7tBFkVR2p0mFDo8fBe0AU2Q3wsprrHRIc7TlxmeUQCW+fUpfM1mWWGwPWT3/+QwGV2/u/g8oK+WL82dOI6SOmP6+W19Abon7p9rKRAy9ew0w3kLYRcAVLPhSTXP7iXpaoUq+yyhORmmeaHz3s5Jk2ReFzJGqP+O3RA3vOQyEBKyoXrSAUCOgT6u/Pyrf83SnVQ/ND3dIQa+xcslTwSw3/FFx5xwrgoZRSUZ5PLvr2IRFGmT52HOqnVB9LNGlT1vP+PH82DoPZ6erHUFJDhlEj/ZGViST3mV7+4BZa9/5WenR0EU4KkyepissvysNxa8Aj8PKL7WLsanz6sH1k3RF/yec8mcTeat2bqLqmTrGiVhWo4xkrsN9Y26JpCSqZeH+Z1UfuzDTs5e64tJBNVvTitu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40480700001)(26005)(2616005)(6666004)(81166007)(4326008)(8676002)(186003)(16526019)(40460700003)(7416002)(36860700001)(110136005)(426003)(47076005)(356005)(478600001)(44832011)(5660300002)(8936002)(41300700001)(36756003)(70206006)(70586007)(336012)(316002)(54906003)(2906002)(83380400001)(82740400003)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 13:56:19.4816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b706bb9b-02b5-4d8d-ef34-08dad9ed2612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@amd.com>

cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
favour of xlnx prefix. Add this new compatible string and retain
the existing string for compatibility with uboot drivers.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 8553299f12eb..233127d94204 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -507,7 +507,7 @@ nand0: nand-controller@ff100000 {
 		};
 
 		gem0: ethernet@ff0b0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 57 4>, <0 57 4>;
@@ -522,7 +522,7 @@ gem0: ethernet@ff0b0000 {
 		};
 
 		gem1: ethernet@ff0c0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 59 4>, <0 59 4>;
@@ -537,7 +537,7 @@ gem1: ethernet@ff0c0000 {
 		};
 
 		gem2: ethernet@ff0d0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 61 4>, <0 61 4>;
@@ -552,7 +552,7 @@ gem2: ethernet@ff0d0000 {
 		};
 
 		gem3: ethernet@ff0e0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 63 4>, <0 63 4>;
-- 
2.36.1

