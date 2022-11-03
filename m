Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E66175B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKCEjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCEjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:39:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A4B7F7;
        Wed,  2 Nov 2022 21:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd8twesI+cBCyYzCHwVVK71fwBKfMBSkRYj9FGX7ooPbtI+/+5iFeetUtNc5ZeZaSFd1kWAX3vqXA3VAkQ5iUbMM+gZZYhr6TEuUKyI1FB34t6eCv/oKPpniq2rPFATvGYhFAj3gssA8thR67dj8naEySofvX/fVGjvmkGJH0Un9zz62bBuxbUDVn5gBdhLdJeNCdR0US1lzHEEMgURN/HZ/gJ4HAWGfVvYvDgWGOhhJ3r+v2pry63NoD1l0r2kOijzrwhhPF9vTjEN2cEMNJS6KFDI2AOBhmyU73E6nHvqKASj72Tp4MDs/Yb4caGRkr7B/vF3NdklM/KpDLZjsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=eWqpdjdIwzWrea05w/hy6QgrJnDKDTfaAMnvbWFpHZxuSf3UyVvya8Cf6vCBpH82ZggsrLiAnf+IczHZGgFstHRHOi5DWPT1vp7cPj6ENVU5ADkUvt4iZjYVLhma3da7VA3H4fryk+9n3+IEBGv0J2Lvntgyx3SisF7ZvvEageZF1hynT9126DJGDv5HhBhvHCdIRbl1AZwD7exuN8om1yqL20iqUoOmnrmQT9Kr745EtsKxBbkvWOZpmbFVD8/vDd/ArSvSBpwtyU3Q1KILojF/7GvatO1uK/OgzW7eSgvXGMDb2KVIpr8mLZ5E65gpRHEjWrYk/J7BV7gWfc8LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=h/XzTIIifMKCxsY7WFBTCCCjGFppBe5QGO3GRD2eUkHwhVfO5xO0fhZ7ZbFlJHMgsNU4CUCwWlT5CQMlWuRO+rReGzplTmAtZ8I/vUj3AXRlwIsZWg70CfWlw0iEyQHi6oYBgcr57RobBTuz0GD9XAJf4vfuNnFzbEKz10HMr+CSuYfBIVZVeglZb2jMzUQYr//yhPJyMDci2IBAiF+sofoLAqMSi9gFCYRRooNPnYTh4GWKxlqMRlhOnOjoIGrIYl0sQGcWLARRBdpgOBPwp8PmwnYvOa7PZ3rsHm/RMplqaBgZeoUNg0g8QxO/XzR49UMX9ITC4IA9yTuiAv58xw==
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 04:39:13 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::c3) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Thu, 3 Nov 2022 04:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:39:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 21:39:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:39:05 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 21:39:00 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v10 2/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Thu, 3 Nov 2022 10:08:50 +0530
Message-ID: <20221103043852.24718-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb1e026-b703-4ce8-c8db-08dabd555b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYmjK55TxOWCgPnhIP4XVjquE2W8FLuSzcGccxngxMtnUg6V9oVjvzhbkXKon+C1yq2btOxpsJNeHK5tQUT5ac7B2XnYCgSsnEtX4J8OibtGQNjZrC3uLgLcOIrdKZGpTqIJcvXrare+RY4xfdNOz1lJ3FPLY/SilXsFqQXGI/5Ac7AfClL0ad0d/eFNBvi5vOZmGVU0yG3KEiS3UKq1dYNRZfOEE82kQGRYGXd8EU/Jx5Nexi6ZNlVJkSjlp6GXuUL6pNkfSHe6V+kwYAP6ziolm0ANF/Wg4Y9fRlr1IgxmTGgAACo4XJrRyEIoYgy1mma3USz/w443cWutZEA8EJlm2p8O8nf2STjD7qFPqxgqN5tM8b6zHVezXvN/rsxscS+kB9sp31auccau+UwWO7V5j6YNuXyRPujGsAOLiaF/O8O/q5mGuf7bYbZda1fycLapIsDt3E5MyzhSwjbVtqlqPDAHVL7/Cr8Jc4kaTslNFZU1edrjyF4uMySoKBlpIHMWZNT8m8EhgBuOs1EEsSkjWTp1RNzTBwkNNJ3OB/PakLRtAd/9J2Da+ZXcfNGYDK4b+/v5gme4jxqxIbHrksi2zJ8K55mFf4FAyOTxjl4DX1FbjqZUdDa6GgXuynphSALa7voEG5Bqp/rcPGqLAV6iksrp6mTQDN0UqQT2ailvA9grLwo4sG52qVXaA7LcLqGEMQTq29cGfCpheSji6o2RXdoTQmH+oDnBYBNMqzy33aSr1Q4Ex7f+W1vC0PnlN80i3ePtxY496lFxGb2Ytg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(316002)(2616005)(83380400001)(426003)(186003)(336012)(1076003)(86362001)(8676002)(40480700001)(4326008)(36756003)(82310400005)(356005)(82740400003)(36860700001)(70206006)(7636003)(26005)(8936002)(2906002)(40460700003)(107886003)(6666004)(110136005)(5660300002)(41300700001)(54906003)(7696005)(70586007)(478600001)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:39:12.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb1e026-b703-4ce8-c8db-08dabd555b54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Thierry Reding <treding@nvidia.com>
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

