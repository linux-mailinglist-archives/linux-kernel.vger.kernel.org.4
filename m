Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB15EBF45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiI0KKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0KKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:10:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B273923;
        Tue, 27 Sep 2022 03:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doV8ZI9io0rF7IS1kt7VlvmPNmtySuDra2XVMGiXRq9LgrgqLcRmmIhiXwpnUzn798h0N9ZGdevIIavvlXXkqctuSBX10D8lp9ZkuCXSQRuFX+DzQMtI2kBcEd8+MpBswttaFkhK0QTYdzsCwKVWUWhfBdzSyI+thHbDNaPaM959XJlK/QyWskBl0BYQXV4eW2pLtidwJKaRsrCUOu7hA2/xjJ/YCoNkelpXLSyNttGdlMn1/RjRNuHdc4F7XYXKfJlYcvyU9bdXoYO6ngQIJhaLnlLqgpuLVB7SOSxwTQ/uWuvKvGpLIpUwDqKri0pfNPkme2T/02FWpTXpdNyhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=IaNjVUO1fvGnD274bMhKUw/Dxm9bX09ATbczdNgso9lWmBSq19oMVIBydnZTF8gsvpAGnet2pII1Iyp/Q5BiGoqhx3AHy/aQPmQlDue+KmosAe7obktB0Rg8oJr2+UPtbTcD7EZyUuQzLyg7+mIAEd08dAbeyfQjErCS/Sb+TLbUVCTDp++D4nE6W3ngfWOvrErSNObovaDeXermtGVVeKAyVxDd+Q7oXGSHdnXFbrVCm782hHpmwBZjhwnB1fnezWRW5ScoWmPCQMVr7eW5L2MgjV8ToUIiLvrAigldNm27kDg6YE0CyC5Rt1GAvxh0cIaO80hSNWqsFQgdgx/m/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=Z6Vl7+B4BjgSpsK5nX0YGsB2Nv8/qYd+z7BoJAGRCZs2eq9T2zpag9ImfBY/21VCrMRPxkiRzyf5s7gqAm/3Qly4ttGdzxPDnhmazSvb1kDqxqfThp90in7TewOSa2OzoAnqVRwj+NtdsOjvcfWrP8XnYQTmHCtehaU+6QdoxMz3+Lp37wvTXQe4XpVDwy30K052oOiSVWvjcXaJSMGgm+Ftb1pHYfeMxwb4qnYPiNp0Sum1eKq6AO9LR0lVw2AgUClKrs3c7ntcgqne1l24LEbGerTVYvTPWZDlO2fXRQUdsbesXQtcoKM8HiIh+diiPh9aEokxiDJg7bk49wPkQQ==
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 10:10:02 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::ce) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 10:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 10:10:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 03:09:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 03:09:51 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 03:09:47 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v4 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Tue, 27 Sep 2022 15:39:43 +0530
Message-ID: <20220927100946.19482-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
References: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: dd910862-3b6e-4d48-ce03-08daa07070c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAxrQC4egdmcMKjDqCDpOxRW1GVduWDSgxNSuDyfgz7WIG1dqJYAbHneDBhkBvDk7iTW6iD7wQnK1GGYIG7XsUHtDMOoMCaqzmquVcHqBl7sBQpM4JNKiOt6q0VvuYMCq4fZzt1nT3963ste6CkkapF+F+dqzwxm42hrLatXbXUw76zSjaiSYyigMBY14OoITOJukLYEKWvHC9TchLO1hIODbzaFxZktaAzpp1Tyr/ZPFWD5rLsU+AWD2LvnKBGxDMXn0LvuptyTSpo68iJ2ZhbiAVKZJklcAum728TdE0fIPtC5+wkQAwkgw+tKSlw6bkfIzyXJw1aFPyYhmtWFGeCfFNV16LRs3zNQVLSwsudLJxkV02LBlM0awccB6c2RjsvyYpy9jmWjvTnEoNlLNgY5CkKwqZ10evPzYhYuRzkVLtQgt7X0Yh8tMTiieXj39+1pGPEzqUbe2RTysTq1/NqCycHqOiDeTxS6GDeiZVSYuL5awICHx3L5ZUn40NplBuML2EOIvK2VfoEzJRsNnGCMQdMGDdq5PtXb0pvxbqP70RfneLejcURkNhIP2mULhwuD9oKwGyNYiGOiLwGy4giHTN4g3CsROm0JXgOQ6gzWEUAjDvtQmid1+UR33ZUz9/rzjpvD2mpXuAEWW7rlU9+U4fAx26CxaV4/d6+hbIi2HTtImS+jlMbNWTbm/2ovjovHXzbae4AFQbBlxz5tD6vs/8dkX47HJ+Y6rIaSg2EfNxl6GG5H46X7+6YTUOSUedJsKc55oqLZL9Z/6hCN+A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(5660300002)(47076005)(426003)(7696005)(8936002)(83380400001)(70586007)(70206006)(110136005)(4326008)(8676002)(54906003)(40460700003)(478600001)(316002)(86362001)(40480700001)(107886003)(36756003)(6666004)(356005)(82310400005)(41300700001)(82740400003)(7636003)(1076003)(186003)(26005)(2616005)(2906002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:10:01.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd910862-3b6e-4d48-ce03-08daa07070c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for Tegra234 platforms.
Additional features, tap value configurations are added/
updated for Tegra234 platform hence separate Tegra194 and
Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..a6c5bbae77b4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.17.1

