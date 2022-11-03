Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583A618686
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiKCRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiKCRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05F1AF22;
        Thu,  3 Nov 2022 10:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHP6M7NnR8lWAjzw4wN32kuoda64YH851ke5FqKyTMp7xZKMDHhlt9WrDmvdtg0mNIyjRnS+OWcen9V/fYLcyl8SWksWkljBjI8Cv2bQH7uGz6gnuzOWdav4jfJEsT3w5oJJ0W2RYRYrp62jX7j4E/kyRt0xaa48DfC3Hlcrx2Zlamcxep4k6rukSCHl7GISZKE8WqfCXPPL7cYHKx8ZWwEDcylXFzGwudpnATtad0+7G0fcjoZ8R/BIClAq07TVUlq5O98itrFz9E1SUaWSHaUxkxFrDD0gGYv1chzcfuqTT7l4MH0lroqEXV2Q3W0gsaUeFTOKV9P3AdIHvaXR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jcl42L3FloEax58T988/vqZBnqDNnqpkHemK2a54Yo=;
 b=dwcrdOaPsJPVM53nfAAgbYppVE6MFV18AUaUQmHs/DC3M84hnaEsb5N73I+m8ArEwLYfkMASx9gAIikDaq5B1xlDmcNbCr2zvq4OxYHUSp+7qZAjUyAn07YpSI/Q7ITjDGebURSFk3VZjhChMyJMJFmxP2ktHTrcgV+5tznVwe1/kB2C+MV3ra56ViaewBDqtGJBk1Py4eE36fwru6Hu6SVDikB0RiXgzgDrCmI+UZ/BcF89WzP3kiZBuIVPdo1DeJ9iZDPfHLF+2PsRCVyz9fYfaIoEvSl6wKRsHuKPBuPSUjMJYUlJrvNPUVB6S28En0VWDYnoNrCNNz1C2yX5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jcl42L3FloEax58T988/vqZBnqDNnqpkHemK2a54Yo=;
 b=ZjMlipZ1tFcjPC5o8C6QQp3aUVFDoRzn7GNjSqKPEAiO+oVKMpc1aI9NzTbXTHea9CK5mm3rOzALvHQhADIgQc7FMMbXooPuBVYnHL/qYqMyESd/2otW2ax5xxG3eCO42BuytJQx16mkReeSQPjJqp358kXD7dJ8sxlj5/9QyPHUIv63eRfZix6m78jh9VT/ePo3WH9941hEZyCTzLDFZDxN5fWq7RQXYU/oT7BpEAGrw1jZ4WB5086Syun6gGIumkdi1EUrWkth0k3BvE4zl0QqiOd1Zvq7sdbMAnJyJ82egFjAJ6tTO2LEXU/TMEydUoZHODgPpBCL24idyWvfZQ==
Received: from BN8PR12CA0035.namprd12.prod.outlook.com (2603:10b6:408:60::48)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 17:45:53 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::80) by BN8PR12CA0035.outlook.office365.com
 (2603:10b6:408:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:36 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:36 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 6/7] arm64: tegra: Enable GTE nodes
Date:   Thu, 3 Nov 2022 10:45:22 -0700
Message-ID: <20221103174523.29592-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: e794a843-7ffd-477b-4937-08dabdc34101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXWrQ1P7mCNXg6SFGP0IecPmUmUPz7afCgT6tVNvuAYOUYFe6Z8zG4VTFMSXkxqx/x9HVjkqUFKpG/H+jpgl0kk0UzIRYnNivJNumlgEHgX931PGQrDPQ/NbdQ1uPGNaUbfwJS93WMWi3JtqMmniaUmhxDRNHIc/yz/ZRSZT2JIARVewmzyhXAWjJv7ZweATvr9TNQk4kH+MlpKubMRJBgeBK80X7HpPtyDfh50CSoa2EBxwjQfym/P7RJdvAvsLOHhDRjLctYwGA2pdIDBlebYmniuuDlLt/ysMTsteEZhlzMS1+LLlv7bwhh0owNsqJ9/2GVERbz3YCBn5gqT3IzSY/4wGlWvXKfjmtEEt7yefZdMj8Q5rfy9PWKsO9tk4oECBygSNiphUEsADhdsL5H1+hE7rQA/QCssj8q/AJF2EqQtPj9T+Hd2n4iQpGC3FnmJnzFzNyeMdxHzxshWsVyd6c3cOYlR5Yk+eo9HvilOaWzy+utDhEpqeqha1XaFir0b4ZaGQ4ow11hgbpLLLU8Z8Sx2/vX/rcH0E5+oFUp+mrBo+UmNM9Pmi3+1WMoFzd/59x2KBxIuQVNL1rYydlweJcXqyE3UctLHUaGDpo1D/jIdXvKF+q5Iw/VdV2J4O7LriIZU/Yiq88BJSqE0bIlcblbIQkIu++QWjmIQFOQqNSdO+AtPlWV4LEePXuw3VxckP12Ekfgsctd2uvuw95Ovt12WfUquBNd1aqDSFpkfknMhfcwhAG/ZHmcR/fCjpYaIthqWWjZ6pWULrLbt7dAOvxHfYBIp3ES5oUyO4Z5I=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(6666004)(107886003)(316002)(110136005)(70206006)(7696005)(70586007)(8676002)(4326008)(478600001)(5660300002)(40460700003)(336012)(41300700001)(8936002)(426003)(36756003)(26005)(83380400001)(2616005)(36860700001)(186003)(82740400003)(47076005)(7636003)(356005)(82310400005)(1076003)(2906002)(40480700001)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:53.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e794a843-7ffd-477b-4937-08dabdc34101
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and enable AON and LIC GTE nodes by default.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 41f3a7e188d0..67927d97956e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1366,6 +1366,16 @@
 			status = "disabled";
 		};
 
+                hte_lic: hardware-timestamp@3aa0000 {
+                        compatible = "nvidia,tegra194-gte-lic";
+                        reg = <0x3aa0000 0x10000>;
+                        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+                        nvidia,int-threshold = <1>;
+                        nvidia,slices = <11>;
+                        #timestamp-cells = <1>;
+                        status = "okay";
+                };
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra194-hsp";
 			reg = <0x03c00000 0xa0000>;
@@ -1579,6 +1589,16 @@
 			#mbox-cells = <2>;
 		};
 
+                hte_aon: hardware-timestamp@c1e0000 {
+                        compatible = "nvidia,tegra194-gte-aon";
+                        reg = <0xc1e0000 0x10000>;
+                        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+                        nvidia,int-threshold = <1>;
+                        nvidia,slices = <3>;
+                        #timestamp-cells = <1>;
+                        status = "okay";
+                };
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0c240000 0x10000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..fecf9ab1bf17 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -949,6 +949,16 @@
 			clock-names = "fuse";
 		};
 
+                hte_lic: hardware-timestamp@3aa0000 {
+                        compatible = "nvidia,tegra234-gte-lic";
+                        reg = <0x3aa0000 0x10000>;
+                        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+                        nvidia,int-threshold = <1>;
+                        nvidia,slices = <17>;
+                        #timestamp-cells = <1>;
+                        status = "okay";
+                };
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x03c00000 0xa0000>;
@@ -1466,6 +1476,16 @@
 			#mbox-cells = <2>;
 		};
 
+                hte_aon: hardware-timestamp@c1e0000 {
+                        compatible = "nvidia,tegra234-gte-aon";
+                        reg = <0xc1e0000 0x10000>;
+                        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+                        nvidia,int-threshold = <1>;
+                        nvidia,slices = <3>;
+                        #timestamp-cells = <1>;
+                        status = "okay";
+                };
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0xc240000 0x100>;
-- 
2.17.1

