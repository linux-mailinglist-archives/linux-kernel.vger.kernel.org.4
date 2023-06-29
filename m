Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51551741FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjF2FOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:14:30 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:12352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbjF2FNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYeLgwkG4AVB8twE1ROuyZ8oMdsjso/46GalHGj3YYf3RjbWk2KoOMWmaeyl4J7+j85rCaZw2UDn30oLIRhTvv0uNxSeykhUKnHMQ/8kVkMoyV+/bC8Ogr3zFRqUhqYn6MsoDdDiIo4VXpiHuaZiL/AZHpmmAaP6H9boiyDf58hkOwThU8p+WmzC9euWx604pJoNIwcx+A+vwXYwKie+m6nWwu8lFX+Tl10wy9CqFkpufNJK3wIghZ+PkJUw7xkRQR6QjR0XpckKAQrybgHYgJUAckb5xnSU1YB3CRDOXsDtOH9muegbkBXT5x1ncqgjmXBOq+JxZPHo5dPfrhzFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGrVWp+S+O/NaInoHUg2uGXRtbSVDGzMISV7CfhHRhM=;
 b=jwJsnd4Y/vFXIJsZG8s4Duj/nx9PGdzOamRvyelamXKHs4C+YqKqiaWv2/OtRP1nRx9Dm4LKTjSeS97T2d3AEYDew+wSmdAL4iQvnK1uN+hYbDvuZlt1GDIWn9sGMCds2wZgPBjaGLPvq7pZzLZVl2VaSj0VcN8KJkMyupQXTmrUmj3m44q762yay2KvyzUTfhO9ZkLtwDmKnJIJicPs2+PYULIvcclEGaDy1lZe1h59r3aqSso5jSq3cHYvilClQ3tTeJwVaNvEEEu4zJcJvjKJxyeWN45SMXHGuqkEQqk+8Pc7yqYYtZIg2hy1QmW/ipuXM7DmM1BYvaGNZvhbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGrVWp+S+O/NaInoHUg2uGXRtbSVDGzMISV7CfhHRhM=;
 b=C5WMKVvN5MWrYp3wQPxKwyLagEl9QzfJ2gYkNAfMebP46cVkmMc0TIqVQxYLbRqo/MaiMrnFd4QnQG1J1JHXyVKN1cvjzlPHVjRdQ9nCfzcYMrqzJhRF6AgEAB6ZliWCOgHBgmcyuWGVLXo3xdlLXTN0qsXPiGBuZxI0Ma26xxZGWgO6BHgG/Me3WzSUgpExnis1EFRMDqkSJDqa85/52aqSLPFs71NvWAFIBVbrm6VRBI1KNOvD4LegQuJ3Xt3YDXPBMaTELUtbT5BKNnPsdd55LWOb2ZfqY8CtzqbccodF5WsFJoPZLk5yS2+2U4uRvMLWvGLrTx2NFVx96/1kVQ==
Received: from DM6PR13CA0042.namprd13.prod.outlook.com (2603:10b6:5:134::19)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 05:13:09 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::9b) by DM6PR13CA0042.outlook.office365.com
 (2603:10b6:5:134::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8 via Frontend
 Transport; Thu, 29 Jun 2023 05:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 05:13:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 22:12:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 22:12:57 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 22:12:53 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 5/5] arm64: tegra: Update AHUB clock parent and rate
Date:   Thu, 29 Jun 2023 10:42:17 +0530
Message-ID: <1688015537-31682-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2285d522-abbc-4074-a500-08db785f8755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X2/hemBpqeNgMUeMbKlWZPHhT5FZ7xtQZGqTudFDg0dsn5Iru9c/qeb+24ZlckMf4YLfXd4cBiMIoxmpQvaw+saRrUlku/trjx9o4U70t5L6jl5mSDMb/RtjAPUfU7KbNxgQ5UTMfs/FUf0ZU5K+n5qKH2WqIlkEy+T7UYBdOlOs5Ms50QcwtcRxTdwBri/YsuvKM6IJkbJBx5qMkvBnTXNXR14b3meOiaxsC2XYW4i50qr2FY51te5vEoVzgT7NEUPxEeeQr6/ns3vclDc+C+TwY3024TBXn5Z7hKoi/CxijudSAA2RZOMDB6a6XU3F0dFl7pRHdmx9Z8OU14WgijITBD9ZIYdGKW19oi7Zz+6ngoMef+w0/hUWL6IbIEtWc/zGRT/6g97PxW4Y+v2nZOhnhq9W/5YIkIjimabuqsYz0LEUHmri3RnKMB/FaTnqsbFXo4N33HB34lixNZrxPfQ+IWZpAEPoPrgiL4mkQps4ohCYueMmQhQE4bIUlb3IHG0y9OVNZ6u81tkBy4Dsx+twidHznJLVOcrDS0d42VVUXkMhRaQ+GXN0EljFG61yXQg4u/0+/Rlwgn7vGhCzmtKuwfqMcXQ5D7LP5ZAv/EbdF8WF2+6srWfV7WF25ZElZMTdXSjMiEi9TZVuLnODKdFovFZpaKRacf9stXKXREbPWxlOcDVWWHDT5MknjIcLCdvdW/Ioe7QQ/QwYqUyBD5U95pdlp4SXEr1wKOfxXk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36860700001)(36756003)(356005)(5660300002)(86362001)(41300700001)(7416002)(70206006)(8936002)(8676002)(40480700001)(40460700003)(82740400003)(316002)(7636003)(4326008)(70586007)(110136005)(478600001)(47076005)(15650500001)(2906002)(426003)(26005)(54906003)(186003)(336012)(7696005)(83380400001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:13:08.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2285d522-abbc-4074-a500-08db785f8755
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

