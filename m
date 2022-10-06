Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83C85F6752
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiJFNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJFNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:07:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4DA599E;
        Thu,  6 Oct 2022 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoInPB+Yv4njzBOSSIsU5wwjo6tSRbeXZqS4nwo4BZqNGClGK7SAGHfhX8e41S/FFyjXkXhjOsjfvSPFvXTAB4+/GqX60+R7u+REZQIa+qgMHie0qflWYUWmeGuqrUBaj1p13bS3eLXJtyRQf3qrzF5Y5en9nkXbeGGVbuKzCzL9UE/UnHeJPVZMgNjZtIf7YFzkkjOSzVs6oEle77vmlPSpUDhbOwikrGlF6B0JfnloUO0ccfDKSKXyHWNb7D//nHqOz0MA1zUxk1McUC89unw+gV19DpVch9wE9qrhqV17I+r3gBpvt/LicH6y8z16gGSPz4Ruizf9cTRNoQDfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnZ4xyvpS6vy5pVf/9oMn0ElhmveCx8I5Uha65hb+2Y=;
 b=M08Qf2xpYqsT75mk2J7/+y+hv28eayN9ZBs486Za9VDDNxqRBMQE7GtKdjV0CbY3HxoIlZSS/YmLMJPmccYk8/c+rL/iwxxy5MPZSa/79csAzF/w8igZwAAqrXGFKpZPMy/i95Z9CDOC0bbAGuwNakYJRDdeh0LmyjCAa6ypjknKXd7WKz9LNokrhx5P/uGreY5TstJpD5Iyhi/C5lfY39VLMC98JCJmFsDQkcw9gTIzdZmSsfRgjtPzLiTFo1YENovMHM7NyC1I62Gu2CywZjymvUcx3ulUUsOTcLyU/8TWcrayMOQ1LOXZZ6/po51zvhmOy2ummhxCywEF+VG4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnZ4xyvpS6vy5pVf/9oMn0ElhmveCx8I5Uha65hb+2Y=;
 b=Y9eoWjWpgMpD/xWclAMUIjiLRp1VxlzuTdUfIGSnbtIrqL2CmHRpIPiwvGGRdDzpznCiKQy1J7axc9iBlJCa/w61CpNS3DywMQhCPoQ4j9YhpbqXROIWPmVTI2gGC4mCfZODKHciiTTkiP2BPod+q0pzVHW0+NUc4FO4DnJHDyNgebhpUcX9cZaZCXR3J/nCBJ/knmgysZcbwciCIqIUdsVuzGhoZfQabdnp9efu6aKzsM/PaKaQQ9JuJLOf6rlF2i9jiL2DIo4tOXDeYku5PFSO1PCIzPtfMD8jTX217XsU+sEcgcaxyBV8UIeOYFmJHku+gTSx1Ie0Hch9PeJUYQ==
Received: from BN0PR04CA0151.namprd04.prod.outlook.com (2603:10b6:408:eb::6)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 6 Oct
 2022 13:07:01 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::15) by BN0PR04CA0151.outlook.office365.com
 (2603:10b6:408:eb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 13:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 13:07:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 06:06:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 06:06:42 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 6 Oct 2022 06:06:39 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v7 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Thu, 6 Oct 2022 18:36:22 +0530
Message-ID: <20221006130622.22900-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130622.22900-1-pshete@nvidia.com>
References: <Yz6zfrVq9cP/wrJb@orome>
 <20221006130622.22900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: f1169c69-2aba-4750-b1a2-08daa79ba846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4COCASO2XnAlK/gl708k2mJrBF9Wu8Bsu6bDf+5J614rmnbh0FfTNn51gncyAs+0zNFM/Q0vOzm7i3Q4o2dPxoh65JDzc+/tYVKP+EpLQe9zLNUhoWL9jqvNSY6Tsesb3WASGLhW2uxzc2wO2bvepcwes3bHJBXtB35ILIW5Ta9etaTRXg9cYJfBAaYXGAzZAwdZP/dFl++hrB1+aDiU80gifpLCYuKzpBoVH6oEZtbDCuAD2eYaJd4Q0qrHc9+OuYGSbKS9IARjVwhOAJfyeeQkD50IwudyVlLYh40vS9M4fUNo61EJd2xvBV/cvpMOsM5eLrf5cLiSxy7rSev/B4UD5fXqoUoJuTss/5/LTRWFBNSs8A6D7FPSNNemVg2E1XWfoljlNlqI+bfTJk7d7ilrb1jkx+3EaHLi20qe4PgxYDQs52bCXGvhEJxlWB53riZO5XyUwPeyoTkZXn7qvRtJ7UcjxR2/u1yEkEg/Ag/DTE8wXTItISOPy+6hvrVCXbRCkIsLnH70kddPAMjxBAd4gSndkenggUk0HN91/9ZFNONzJIiOHjkGMJ3RZPYS5HzF0P3VJuF0t8Mrqsh55zqi+K0MRHJQdtDNdye/hPJkVyHXLIxATSK8yjsrfjffY32QQyo2qtmBZXFaudGVqMDdPRJAsYmGOtZ3w3RAvASe19KuGMQd8tKRquWCQvfCYrrBrb+Pb5L1p4kDCoqmLZBbBNnFI4COSZQC9nMUicdv/7Orp1WeRLweHD4eLZWOwgSo0Wkok8icErIKRHrjww==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(83380400001)(6666004)(47076005)(82740400003)(426003)(316002)(7636003)(336012)(2616005)(70206006)(8676002)(1076003)(186003)(70586007)(54906003)(36756003)(356005)(40480700001)(86362001)(110136005)(4326008)(107886003)(40460700003)(26005)(41300700001)(7696005)(36860700001)(8936002)(478600001)(5660300002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 13:07:00.9290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1169c69-2aba-4750-b1a2-08daa79ba846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
instead of requested clock rate for proper use during tuning correction
algorithm. Actual clk rate may not be the same as the requested clk
frequency depending on the parent clock source set. Tuning correction
algorithm depends on certain parameters which are sensitive to current
clk rate. If the host clk is selected instead of the actual clock rate,
tuning correction algorithm may end up applying invalid correction,
which could result in errors

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3663c5d0efe0..ccbb26a66284 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -783,7 +783,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

