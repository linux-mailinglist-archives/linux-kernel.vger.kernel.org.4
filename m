Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF16B50A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCJTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCJTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:54 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC313131B;
        Fri, 10 Mar 2023 11:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7uoKkrJuiFaC/NC0svVKUapz0bjVRSIMAZKOARVQ8PS3YGw9FcjX9ZH6fK/DrmtuLHM//Ymyw9egQhEJEtITMDGjQnK5JSi5KBtyd0NDRFZC3Yr1GN1fE9YnDjTRRd5U6UKVBL96OA5VVjOEkOpzjBaUupQBmrD7y3TV+XN2fQUx6Qu87hM/Lno0wIpqE15snf9cCM9/96lmgHSoWLDbgTxX8oFYwabYLFGMFCwi1z1LYpBSDyn3IL1sFfH4XGy10NTAu9IqtM311OFBi/ieOsiWjYD6mko245pviYh/roF5EdSLFX/ydKOUoY5VsVpJ482bm39nwEOTR/oa7kY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLMd7hf6vEuwQ2gOleXhlQ+951OiArMNK/PD1K057bA=;
 b=YdDDbZEpqjf2FqubraEHwyTv642+Aj0myKrR7/387Rj+eHsLDYy3JieKqbpuESgQDVd9NWWdSx+FuAm1o2mxHKP/ZeQMfoG4EuIBImYEqcvgc5XHbkaWInDvgnbzWY3bWlKX4Es8l0AevrIQwWbNpo95j8zU0c/X0wI+QqQoB+efiUEOZ6V0X313Tkz6Ab0y/4IkA7nssFffxer/h9KUJOrsnGoif9djFBcq7rfcM2vLKk/i5kCYR5sqtVP30nzvZlolfaVuRHMqipsLNT1i4iba8dmMvzAEFr+sKOu5TizzaKdWLsQlOaZfstiK+Cj3RN43LVuy6o8WlQyCxrW2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLMd7hf6vEuwQ2gOleXhlQ+951OiArMNK/PD1K057bA=;
 b=o85lAwf13fjrt8qolQdBt8biwafg4UtKCh3aMYQ9tFA0AR0RDrd5pcsQ7w511VC0X3VbLVbYE4A5Fnk9n5hOUAbwvbJv0Yhcqie9ZImSu6KsAHlkr74Q/oJRm5jinyz5NSa0b8mHRDECk+8qwf058aSLhmxoKMIdjIyc+5A3waYWmJC7UW6imbbkO5sh9XjDxPZp/N++UmGYP8o5mhi9a5fKwTACUzRTpDVgIgSYuOWfF8ptUt2Vbvm/vNJCP2YHhY5Lm+0bLCTYi15ol1m3Yom7Fd3xh5kWwGrhsKqi6aqOFHHEyPTFr+1NIo/Vqf4HSTEhV5YyZvKtReFj+Bbcpw==
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:50 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::d) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 19:06:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:41 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:41 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:41 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 6/6] arm64: tegra: Add GTE nodes
Date:   Fri, 10 Mar 2023 11:06:34 -0800
Message-ID: <20230310190634.5053-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|SA0PR12MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 303dbcaa-6113-43cc-cc03-08db219a9a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYq2G/lsXR/L+tfghzT/iPPSnimKqDrdHOx2bHE66HK/XA6lvoJMlmmwLBRHJwyyJp9uDCj6FdJ/E9dH5vgga3eue2GrXumP+M5a7h7Wdqi5sHE12cLpjx6V4XsYwsRN5lL+BUhztwjH3sj+eYbZTOWQxDeS43LwwaL8aB/Q3JXHepbWFW77ebKxhp/tN0NicyS12nRyf7MW6iIu8eVDlPL268EU79QBzfhCPc1O8SqwZmS9gM1kCASmOLdIKAtGB4mHGIrDu5fo1gD3P1wXbzkD1gZ7UlDB2zrxgIZYaWe5KHczudszuqo/VGC6sJwCQ5bStrmLS7HpCfFT0GMM8fbBpwXMVgp/yqJaL4MTc0btt2M+pwcIAsix286Co7GUf0wlV3YBnVAvfVzgB94IG42+wk48EXYScTJtPYbrH4yWC5iKJ6hOX3+74xGM2T4RljdVEczBw6a3NJRAUeY0D3EqFvsPvscsBv8elmcJT/JnQj47eMoTTo5wKHXvandTU9tLF2D4gMwW9bFT6uXbF9uHGUqMvLgKEIuT/LupCW3cEiPOv5Aw2lZ1gNNTKFWfjOo21M+aGUoG2QLjgzBs+8VJ6jOOycIUtNtGIvv8gAoADW4k9q5kPnx1YNnB21vQj9fC0CTb1YUER0JTyEdfTqEKjL2rDtkanXXKaughaAEV4/M4FotA/juh1Jl1A1x1TQThmFCrycajgKqYp6dIwiSrZHRcPzn117eZjl3CWcQZmWP7GnuKLx5zMHRtiV2crTCj2PCgzUbFhlq3Jv9WraKcSFXHZzCRy/eXWFCZwyFB+DKlGUa7dfPtQeleTy94
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(7636003)(82740400003)(2906002)(83380400001)(82310400005)(36756003)(40460700003)(5660300002)(7416002)(40480700001)(70586007)(8936002)(70206006)(8676002)(921005)(356005)(478600001)(316002)(4326008)(36860700001)(110136005)(86362001)(7696005)(47076005)(426003)(107886003)(336012)(2616005)(26005)(186003)(1076003)(6666004)(41300700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:50.1817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303dbcaa-6113-43cc-cc03-08db219a9a6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GTE nodes for the tegra234. Also modify AON GTE nodes for the
tegra194 to remove nvidia,slice property and add nvidia,gpio-controller
property to specify AON GPIO controller node so that GTE driver can
do namespace conversion between GPIO lines provided by the gpiolib
framework and hardware timestamping engine subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 +--
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 133dbe5b429d..7065643af275 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1355,7 +1355,6 @@
 			reg = <0x0 0x3aa0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			nvidia,int-threshold = <1>;
-			nvidia,slices = <11>;
 			#timestamp-cells = <1>;
 			status = "okay";
 		};
@@ -1578,7 +1577,7 @@
 			reg = <0x0 0xc1e0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			nvidia,int-threshold = <1>;
-			nvidia,slices = <3>;
+			nvidia,gpio-controller = <&gpio_aon>;
 			#timestamp-cells = <1>;
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8fe8eda7654d..54790c6b6a2c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1156,6 +1156,14 @@
 			clock-names = "fuse";
 		};
 
+		hte_lic: hardware-timestamp@3aa0000 {
+			compatible = "nvidia,tegra234-gte-lic";
+			reg = <0x0 0x3aa0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			#timestamp-cells = <1>;
+		};
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0 0x03c00000 0x0 0xa0000>;
@@ -1673,6 +1681,15 @@
 			#mbox-cells = <2>;
 		};
 
+		hte_aon: hardware-timestamp@c1e0000 {
+			compatible = "nvidia,tegra234-gte-aon";
+			reg = <0x0 0xc1e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			nvidia,gpio-controller = <&gpio_aon>;
+			#timestamp-cells = <1>;
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0 0xc240000 0x0 0x100>;
-- 
2.17.1

