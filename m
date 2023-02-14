Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF76962D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBNL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjBNL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F324C99;
        Tue, 14 Feb 2023 03:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aszBClSYwplZpgre2VAqvGc9WFYBoqaodUa3GV82uKY0qLnyxpHK5DH3niS8wayIfBbGpSOVbwXCCEKajqwBWJsZmPAAD3Qe5UK6RySKd6ObkFL/4DY1hNPiU7oi81Gn4Ac/PswfABcT1JZIxE/UPoYGZGd8JF4JxDJ3j9TDSK8bdB1dLK2wM681w3yhgTRIFuhw1rcNL5XY8K78WdCM0M0tcXI3xKk5kIZUoZmJ4KAWViG5SGv7uVr+NixgCXx5/uJehztttpce/Y7ryvsJTE1OaZsuMWS2uCBvLzajf6zQcP+o2QfU8MSigfrTymEa/VfxUTrGAQhwfO+wCMBojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7d8U2b5VRjx266Ds+P6gjeWYis/y1BO30+E/CMtmgg=;
 b=aG+NLYDMlwyW1R/LG/S1PAg/hH9PWY/tvP4u/gYh+6LdJJ/EctBF4yTFVRFaaXlsxbj/+VRf3a25T79kROi0p1/vnFk8waBFYNAGqFeL9XSFPuimOs6sqRGmHFItXWfo3SWozEjzEyn1Mp8Sx0hSPPlw0dCQs9AoIcXJnkwxD2UuDfGypl1DVO9MVINMrV0qcMnUXcjRVs90SaWQ3Jm/Yt2sDzqo0gV5PwAtk2Dy+FJZeM5QcyE5Kyba2ML9lPKtteSvaZE8BetE9OUIVR0SpzxBaFGEET4EWucPp7iYbD2s1UPavjEn2troobE83b8G03ek9Xh2Ip1I2npqELFIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7d8U2b5VRjx266Ds+P6gjeWYis/y1BO30+E/CMtmgg=;
 b=XUZcxCXd7zg7adJTul0AHEoSa78tUS73nVIal3oBV6G0IJVeJaGDvFUevl5R1M+MZuUZTSiWniLKnzaSIYFmI17eSMF4TOc2zke/6W9RL10eKl0w9UrRJ+ng6JRpoYz5WfbffDlXagY7UH/ybd45iRv9eQsdvyYiQzwt1XkG9qTQtaBKpsOJBsOcLrgQ4H9Mt5W2at+R7gbGZVqrC+bRz2KTGSKbBdtOwz/sc2q+1SwAYQ+K+9sbOEUHeZVzRqnTbLmYMxpVsWUSFtlmsoVJcjS3T6i7RdkWM7NOVThtkohKR/WdzffMJ6LnJhgcNBegfKYxZudLdtdSq4Ych6e1KQ==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:56:12 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::23) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:02 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:56:02 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 6/6] arm64: tegra: Add GTE nodes
Date:   Tue, 14 Feb 2023 03:55:53 -0800
Message-ID: <20230214115553.10416-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: deed0e13-8fde-46c9-bc6f-08db0e8277b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpSvSIs60o5EJRvzudYTxuV6pS3FkrQF1vN1X7ti2G0X2FnS8vGU/rK8as97xgWI9mLqRTEvur71UbVjrrL4p8Lib589eK50BeJSqXEmhM+ke1ZSOIaji580W6hfYcjeUewkiRTpwRN1BgLLzoxstAcJ1g0IWm/ggWlVwzKOC4xjHZSsg8r8sYCZ/m/NJZeNevMO4RMl48m4khccURas86eru3DlsnmybIp65LSmp+NmEY2Q9Lx6e9X9IVWQ2c2V0LcV77WLiineEyWNzD23Pq06c5H42OnehKsRSyv8bwnLABACk4dThEiRNDoozsri4hc66pZ3iqavPppH95t6wv8bC6BNdEVfeZYazGdNjFuMwYh3X0Y89bUNrE3Qtr7nHt9gKEta4sH2AUxHQUKSZF2GUNZ1Qpd37J8+NKmKpXSaZpMHSMXU7PcqYVtn6vmqbjddTW8fZIcmxTDzCb24XOrebRYOzg0Vexk6Rz2iSIAkbuJlJW+Kfq0vwOjXJGVoC+YIhTeal24zKQIrPFfLmpmY2dPmn1v3eTDr/HyCEeZXLUbHU4wa3ieYHH9O17PLtSDbAzqiBtaq6Rw48PK+cK4WP48iqM265BW8t4My9j5q5Y08jojhDHOQcBMP57hL7TDhQbtiJFKo1Bj4BmsH+0yYewZ3sJ32cFf0vicQvspsKyThXKEcBOzEz4MM1LO3CU4P9SC0kuPtQV2/xBYS3wKwHuu2lKTmKmHcjoIUt8ZAZt1pdRPfPbvsIgvWlt6jfzq+AaVF2BRx7xZVn7JSYg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(70586007)(36860700001)(7696005)(41300700001)(8676002)(70206006)(4326008)(8936002)(5660300002)(356005)(921005)(86362001)(7636003)(107886003)(83380400001)(1076003)(186003)(26005)(6666004)(40460700003)(478600001)(426003)(336012)(2616005)(47076005)(36756003)(82310400005)(110136005)(316002)(40480700001)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:11.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deed0e13-8fde-46c9-bc6f-08db0e8277b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GTE nodes for the tegra234. Also modify AON GTE nodes for the
tegra194 to remove nvidia,slice property and add nvidia,gpio-controller
propertyto specify AON GPIO controller node so that GTE driver can
do namespace conversion between GPIO lines provided by the gpiolib
framework and hardware timestamping engine subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 +--
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4afcbd60e144..4c92850b1ec4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1363,7 +1363,6 @@
 			reg = <0x3aa0000 0x10000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			nvidia,int-threshold = <1>;
-			nvidia,slices = <11>;
 			#timestamp-cells = <1>;
 			status = "okay";
 		};
@@ -1586,7 +1585,7 @@
 			reg = <0xc1e0000 0x10000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			nvidia,int-threshold = <1>;
-			nvidia,slices = <3>;
+			nvidia,gpio-controller = <&gpio_aon>;
 			#timestamp-cells = <1>;
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index eaf05ee9acd1..4a87490c5fd4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1086,6 +1086,15 @@
 			clock-names = "fuse";
 		};
 
+		hte_lic: hardware-timestamp@3aa0000 {
+			compatible = "nvidia,tegra234-gte-lic";
+			reg = <0x3aa0000 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			#timestamp-cells = <1>;
+			status = "okay";
+		};
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x03c00000 0xa0000>;
@@ -1603,6 +1612,16 @@
 			#mbox-cells = <2>;
 		};
 
+		hte_aon: hardware-timestamp@c1e0000 {
+			compatible = "nvidia,tegra234-gte-aon";
+			reg = <0xc1e0000 0x10000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			nvidia,gpio-controller = <&gpio_aon>;
+			#timestamp-cells = <1>;
+			status = "okay";
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0xc240000 0x100>;
-- 
2.17.1

