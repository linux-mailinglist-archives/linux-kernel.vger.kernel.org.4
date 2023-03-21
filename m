Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1136C3B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCUUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCUUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:06:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8663ABC;
        Tue, 21 Mar 2023 13:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ1lAECjXGswk5o6eE95Ac/72wyADXYO1dWkrfcsOwq/xkpUh5LVfLjBCrHFYZdCHYYfEqOKwK2384+8sFusekZN4sor+X0Puj9KFYByiswp/gdLDg3XIvRco91icu8fiW1Gn6ZgyLwyMrEEUJW02KAzx5WaFrth6UHkU89oY1t8VKYMxRFULUPTylKTIVnYck59qpH5TlkMeZDfAqbL49bpNTkl4XeM/SdXSt22QIvxuN7EUD82sAlm4vbOy9DlispKsgt89cPEe6qZFcf89kA9dGRVah2oMNl8ZIfQ1I6gcXvj6Ule43vBcoRqEBZchfZ9CZOlMQPXwIwdnfIgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaTVIU8zhOHlL80zAzC3QFJ3OY+G0CRpVUUUDOi2A4Q=;
 b=ELpNK/s/5SwM8LmSOHudVng9qfbtGu1VCYRk+AuoCQCA11Usby9/MmB33RoZ75OT/g1CSSewqWcbPvfaAj9tDRhdRzLGpl50UIUAGnx6fOqXCZIMvZ9YgffU2xW8wEBBxpdzVuPM6f360UKOh3lWwPtwH7Ahv/JEWaZpW7AIBL5lBYdm0QUdE8R526qWdKaVtLpbS0vCewcWv5b7vazTpLjlGFuG2Uv4tyeDlhxO+oFRiPbx3Zgr3tNEDg6RBtgHI6xiIp8hHEo/RPVd5CRY5ja8ReX6Jrpg5HCLpQOEDekn0k7r479pIIU5h/BTVf4ZSTzSR6RQXALEKw2f8jeiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaTVIU8zhOHlL80zAzC3QFJ3OY+G0CRpVUUUDOi2A4Q=;
 b=W+VaWeV0Odj0/06+PuzQfR7GV8EEIf9mdBSr3YOfXoj+q8BpnAdAp0C1QCSqI5irgkZbzMGR1j9PDmEMOyizKth6eOJWf8tNn2Ca+wWWv5mLwvXi4+6u9D/sNZ0c7NuQqehbvbA0b00/rJhrPK/3SIoqxtkdhPy2Vgh6Yl0iVHXMExqNlJ7DYVWrbCuTGm1pWHPuF/rxL140W2CtjEYShuJ4xBOolXlLS7EbP2BcM5rSsPmXL3Vd1MZwKY9tYoCS3kAmFGWO2B/2cxYD4gdUQc6MVSoPtIZ4RY4Z+/3d7fyTaDS+zFmb/nMYdTkmqyLPahO3NIRaZYoqzEzN7J5X0A==
Received: from BN9PR03CA0230.namprd03.prod.outlook.com (2603:10b6:408:f8::25)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 20:06:34 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::14) by BN9PR03CA0230.outlook.office365.com
 (2603:10b6:408:f8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 20:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 20:06:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 13:05:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 21 Mar 2023 13:05:56 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Tue, 21 Mar 2023 13:05:55 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <suzuki.poulose@arm.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] arm64: defconfig: enable ARM CoreSight PMU driver
Date:   Tue, 21 Mar 2023 15:05:35 -0500
Message-ID: <20230321200535.10584-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: d9449bcd-4afb-4e90-372a-08db2a47c4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ0T2KCumYcHUisYu9nTS8jM6VJLuYkQNcA5+X5cjG9s3AxbIMNzdempz56UyYfY68uTIlHniSzeR+y8VLECddTAGmoLY9nzOASWBIjyntGSH0UFDAjE1NhppJ3xgD79G9K3cWY6/MLwcxUwvFBden8Ci08i6AMaUit1R+mTxogvPfgpfSSC+ytAfiao0UuJQPpTsKws5iazanCSvjuq6D05EimeH3+tUmjpH0MMSm7H8knfPwYZhOKBU3t6RJ1sIyCffrswwK+ITF90z90scqezMjaBiJJeWfKT+0tDepjK6LrDBb0BKZ6u7otGTYu/OFjbYlWqfloUSFU4/AEIQKSNA95e9eExWvhcDR798WXL2IrJOe0ZD+Fi5Hf5FgniXH4tHZ3MIS/fgMN4xXZyc0wggz2cromiIgOCOcPOhxyWJKWEqpiZQu1sWX1CMJpKo5I6ogiFK4Mlnk9FLgTfpvNqapd7ABx67WpqGhwh5ug7b99ZRvMqbjmJDeaZMBF30zwZByIWTvKeWc9rkoTQxG0x0T9RRl3/IAdwMuhjb/YTrs1aJdxLJxd2Q8G3KNbRRecs/hMb808phv5Ks9yi1pKQKlOjPy6aMNWmrLxOEpQGf0a1Z7RepIVFcwtKNEHZizTrmEyXh2HN/Jf/LF0ft9gpwBOUAuQnLJAzmzE8jMkXwocUYR5wOiod1Cmf4e6qCamdPS+fl800pBCEz7y2ogvcbFMIseFQKyO9GtWc5orN0aZLxrbBX043dZqTwL4A
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(1076003)(336012)(110136005)(26005)(54906003)(41300700001)(70586007)(40480700001)(36860700001)(6666004)(107886003)(316002)(2616005)(186003)(426003)(70206006)(36756003)(47076005)(478600001)(40460700003)(7696005)(356005)(8676002)(86362001)(4326008)(82740400003)(2906002)(7636003)(5660300002)(82310400005)(4744005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 20:06:32.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9449bcd-4afb-4e90-372a-08db2a47c4c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Coresight PMU arch device.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5029ff92eb68..40b74a236c4a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1334,6 +1334,7 @@ CONFIG_PHY_J721E_WIZ=m
 CONFIG_ARM_CCI_PMU=m
 CONFIG_ARM_CCN=m
 CONFIG_ARM_CMN=m
+CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_ARM_DSU_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m

base-commit: 73f2c2a7e1d2b31fdd5faa6dfa151c437a6c0a5a
-- 
2.17.1

