Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BF741FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjF2FNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:13:51 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:12961
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231848AbjF2FNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODApN4UDHklRmBOeP9KKVp7kssrJTSJ944+0eJKFBIywXW2acUzdP8gY2VnzpMpge4Z/vHq119krquiP676IVUWLjvSeZWY1KyUANSXNxJ2CKhlsF4aS8lE3zzHu47y4IRSYrOEhQHpTzFikJihxw1F8ib0lFutzZRNWpmeX9EwGT0onaCWWeubA5VkvJkjkovBsX2TQCF4TrbXdViRXsUj50WyHMM5hA1W834TyokVm9KynIwNZgoDwdZl05/HptaNq4GI9gcAxIjK6BTXfxTyyAAYgcuE1uLcZKWOrO0/NTIlNDaNOAPRsOHvWRGocJS+kSVn1gcao5NpLtrvgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuCwMM3vyXtufdb1uc4t1V6RwotqPAeFw7Fjw46Fgxc=;
 b=Zg+EUhCKZTY9Fe+XsCK9vVouy8iImOrgCRBsH/i2kCOiCw4ePhaBoIOnaiE6qCAxw4ngi3jeQv3bfLrtUQxIQWrMtIO0N7JYDvbMvlcBdcA5FY9MLYmTE0ChKk25iJCMRK56qehFUA5IgQSiBmHxyvoXntCJVl+ZjA4a8IL2Sfs/cwhEblxifzH6O3BHfmr8D07oVWj/QDGAwfA0ta+OC12eirlz15BOyxte9+O7XeVuXHZVP3qAabnnm5qv9qaxme6ETiWdw8fooT7sTgnKOtF0wiG51Bk46+1GpClEhoEePiusYDbdZrk2Ql28B0mPHA6uPV0a/0wrhlP8AySN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuCwMM3vyXtufdb1uc4t1V6RwotqPAeFw7Fjw46Fgxc=;
 b=OhtxVqL5H4B7iFgb49vaT97D+27BXdOXjzG3lUI3WanS+KJCKldlUO8pujktf583kcYz1NmmX0qcbXOMpetis2zbSDHBiJbOsppgAetEcVeYN04PzNjDEi2jjIx43jcqW8NGXU67u3P+vnYdX2EMd2H8uebHc86R39t4xVkgj2WDDSZMEkfACS/URWkaqHopPSMHiCLoY4rYRzECkoR0XtOQYGz15N4szi1R5+eRFm9yMOzO6Oyq9Hc51wW+edEfCE8YTgq4zsqB5aSQd737E4zH/62fRlWZS65k8PT5j/4ZloAfpCpvbKicVD6venj9MI8n0QaFZY9rrqc0vMsBqw==
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 05:13:05 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::f5) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.6 via Frontend
 Transport; Thu, 29 Jun 2023 05:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 05:13:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 22:12:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 22:12:53 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 22:12:49 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 4/5] arm64: tegra: Update AHUB clock parent and rate on Tegra234
Date:   Thu, 29 Jun 2023 10:42:16 +0530
Message-ID: <1688015537-31682-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d58e787-e01f-4b7d-f5bc-08db785f84ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a+NXPR5I2IRaN3SetKaA4vsN6VGYaiXergXyDBVlkNjKy6QIluyx986o2whVwph3k36sc+y05EdFgGkPmsjJOOwS+l3Pgc0qoAXDuRY7m0WR8LH57ma+/Bf7PidoZ+qsjSh/5G++tl+TpAjkXT8Zqat6E5AQjTwD65G8zvQ02B0PMPBBT5myp4L5H5YE4M+3ByG2+ePuUKU+bfCKAV69iCw+eOUqhqbVY5woUuxsqlDbUYaXKin4kMg7hYbLt8yhQNgBRYBbfBfzIwKzcSGjRoAp4aa4YwAhkF7eCNVXKcuiTzaEAYmlYphGYS8/UGWAq16dkpRMcuiTFqjVR7iS3zaufhuJWbNAZ3k+fj1xkM4TTRVrGHjqegAFISEj6GU97+8wiOYe9yIqjRZiL16CGpLgV2yy17thNniALyO4/AKL5o894nPf6mcRZc6aZ7MCixX8pDS8LT34Xo4fEy5d8rPQIbQh5qB846crcYyqCwgAfo7Z95/IEC696V6GTs2LPUyHXCh2tfqVGRSEXZcqOUggMgti9AfXfbGovr5ZOY/b8N/WWvc3hcBYKdQIUz9DOvaLArWvQgieGhTSqOn9LCuGF4DCSfpdEZgQl25u1R/V5HO0YdsI/dX/p3UKr3MvyReIwlBGl+M8JvH7iMfW+hoMH4emT4yfHyDxb9Vnr2nJwz06KUDiTAtnriVPZ7AxNcqsGHM6rsVboXSJ+7SQLpQjlWE3fPdmDhiKMC0Dl21rvzWOESOe4W8Vfl+7DKR
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(7416002)(70586007)(316002)(70206006)(8676002)(8936002)(2906002)(41300700001)(40480700001)(40460700003)(82310400005)(356005)(7636003)(82740400003)(86362001)(36756003)(36860700001)(6666004)(186003)(26005)(7696005)(478600001)(4326008)(110136005)(54906003)(83380400001)(47076005)(426003)(2616005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:13:04.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d58e787-e01f-4b7d-f5bc-08db785f84ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal <sheetal@nvidia.com>

I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
This happens because the AHUB clock rate is too low and it shows
9.83MHz on boot.

The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
clocks. It is recommended that AHUB clock operates higher than this.
Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
PLLA_OUT0 and fix the rate to 81.6MHz.

Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f4974e8..0f12a8de 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -180,7 +180,8 @@
 				clocks = <&bpmp TEGRA234_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA234_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;
-- 
2.7.4

