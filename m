Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3B739FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFVLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFVLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429D2130;
        Thu, 22 Jun 2023 04:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNINejg5mrav2fw13DndTNzYL7QSSANn0yThmW4hpJewgzVAmMesvzbrJIH8/kuuBHDMHmELyPmMAWKO1P59dUOIXPwjiB5nVg4CQyMrftR1nCojxc8Cpc0gLs2Yg9qZY1X3JB0KAyLHIcxW6Mqyh/O4v/nyzCFr8BoHHOUs2aXn8MRCeJ11DqZtA5m0wL1po3vI/1HxZWeUNO8pWlqdb3Na95wO+al33Iw47Uooe0xWJjpuKpNAIl1Zr2Uva5mViP2gFgvWYfEX+IBSi4cMVc7RoOv8QvoxGHqRPLmYmnrCjafe0W4RMwk8h1sqN7g3+/XNNtWscgr9slrF1Kp9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGrVWp+S+O/NaInoHUg2uGXRtbSVDGzMISV7CfhHRhM=;
 b=M/YKIF4t0Jn1CqP4x1UinJr2Qq3vawSWgPeNA0jVwk96ojxVCYuS61QBK280ojacAR+g7931PV0rG4oL8EUVsy2K5RF3W8u6rrOmoGS6tkSMcrAnbcRKaUeP2uRA8C407UqH+PX+lsrwp9GDgcqYD6jZj9GJSZJvrr9GfsnrBf2bg/rcWjoJbrlXM7oPFuLFmObQ+2o+w1ot5niNP7pmz3cqk0b3cO9BqB4waS6Ulzp/VXGPspEug0r7oeR6MgYTNVskJU+kICdIaaECDhI4EyqAh0MA2xR7roVwe/dBYYAgumtG9i74b2W3Bjtg0MGkVuma4k9ap9MDdbeTnhASDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGrVWp+S+O/NaInoHUg2uGXRtbSVDGzMISV7CfhHRhM=;
 b=Wvw7ikTidQn1Bkr5qyQwEAtgC8cwL0G0R/l28aIXQlsopLMgXC6CAhGGdipumaojxcsgb9cmewOP1D/dXpswgUO4FY2UdYAwtW5rQ/EKe0X2Ah0YyOTGQztpVwFmw3+TP2apMH+wM8ynKKOmrWqLZOupO9ZiaPHlI0vCTnpFhb1CO0wGG12zw8MFqrnachOJI+H8g60Q2tlroseH1TjvNJlJXuWm7DBtxkD6nreadkenxcJFyxpeA8cWHywhTbLqKwrDANH5iT4iAy9zokAlTOLMu9D1PEzz2MTlzjrJp/opXyGX5oLzOj7lkyhMxyxAZnuGiLPWrv4/DVkL+IFgbg==
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 11:35:10 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::7a) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 11:35:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 04:35:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 04:34:59 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 22 Jun
 2023 04:34:55 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 8/8] arm64: tegra: Update AHUB clock parent and rate
Date:   Thu, 22 Jun 2023 17:04:16 +0530
Message-ID: <1687433656-7892-9-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 00150a81-5e68-4995-f4dd-08db7314bcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLNWgnyiHDn5jeyx7KSvzrLHDygUxZf+PEDfhXNVdbazwqktAuHqzfzNcpRWcet4ita1otDsxI/N9TwDu21WpcB/foFToHT6okeLyKR1EqX07aLdrKJHvc2gEAD9+GsVRMxzwFth/3TBVX/cTX20072qrmoxPrVYGGVRdrcit0+bbCa41q6e4Zg81RwnT1zcjUsd5n+Qkfo+eDo4fYq0Bta2LT1Wb6ZJsVjN/tYeOKfH4265Y1hWri4WkJ7Vx/GpHh0rRWJJDSxtpb476B/1EiKFyNEXK5S6liMpE7eADg+8AfwB/1L5wnf2+tt4kqffU6CJi/5Xskbuzvk2wNqU6PHkJ+kW4LKrwk9itEZbdDEbbF9R+L2fCYBT1Ocpxob0d6LjihrY4DIUoR8G/6WMcDU6OhsE9z9WhRK3R8qk4SRImSF3PjsZiL1XUlUbqMEc43Mq/irPk3sNWS7yfD6zzoT51BiTlEohZyKBY9mDUCkjL8vuhE4wnJvZgj8RArpM/MSnmj0F7D89CgO8HpTq4qKa7KGVz56J80VtdMY9H5Ics3SZLWhWpIGqaiQtdilXoYrizSdpu7wxXUnpLLZBLK2v+4kh0MHB8/ujaHDy6bWx1zRTHkUPesPei4IKSs6MyKkUxnCWmlqa01BVLTyBE++roiyCfpgda6Ffv8oFW/W1JR5YgatciuyhZ8A0zW2dXFwxe/vlZyDSqhqzobMk+lSkemCM6wZkiaJ30Qje1BM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(83380400001)(82310400005)(186003)(7636003)(356005)(40480700001)(36756003)(336012)(426003)(2616005)(47076005)(36860700001)(40460700003)(316002)(70206006)(4326008)(70586007)(2906002)(7416002)(8936002)(8676002)(26005)(86362001)(15650500001)(5660300002)(41300700001)(54906003)(110136005)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:35:10.4741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00150a81-5e68-4995-f4dd-08db7314bcb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S data sanity test failures are seen at lower AHUB clock rates
on Tegra234. The Tegra194 uses the same clock relationship for AHUB
and it is likely that similar issues would be seen. Thus update the
AHUB clock parent and rates here as well for Tegra194, Tegra186
and Tegra210.

Fixes: 177208f7b06d ("arm64: tegra: Add DT binding for AHUB components")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 3 ++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 3 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7e4c496f..2b3bb5d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -135,7 +135,8 @@
 			clocks = <&bpmp TEGRA186_CLK_AHUB>;
 			clock-names = "ahub";
 			assigned-clocks = <&bpmp TEGRA186_CLK_AHUB>;
-			assigned-clock-parents = <&bpmp TEGRA186_CLK_PLL_A_OUT0>;
+			assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLP_OUT0>;
+			assigned-clock-rates = <81600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x02900800 0x02900800 0x11800>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 154fc8c..33f92b7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -231,7 +231,8 @@
 				clocks = <&bpmp TEGRA194_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA194_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 617583f..e7b4e30 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1386,7 +1386,8 @@
 			clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
 			clock-names = "ahub";
 			assigned-clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
-			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
+			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_P>;
+			assigned-clock-rates = <81600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x702d0000 0x702d0000 0x0000e400>;
-- 
2.7.4

