Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40005B85AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiINJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiINJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:56:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A72FC33;
        Wed, 14 Sep 2022 02:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6WMPM8tshymWAgrZRW+Jyt6gztcEgRw8BkeZWB9NErRZEHOAHEmm6Tnny8F5/T8RKJHl/iTLytNDDh6TBeOIJ/z8qfBqO7M0CTSxXwCYMq23WUx+SpmYJFjKAqTOCoQbRZqQUg9Cpi/GMjgUDPAc1wVnAULIdozBj6jeSysSI8mL9XAWk+hH4+jxtnzAUa9YvxeLs2lKVll0x5hL9xLV0iMLhwbQh0p4eI97CB1kz+zpX3deQ5SGCNIbRxkzwke2HtQRM5kZCsmiDIFeVaoo+h0pkpksS7HOEVlNXt8UNtCKLR88l2exJCA4tNZksd0jH7YMKIru+m1KB77pXkTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7eSoDIQs+BITe4ZITRsdI1l2XWfLwFq00VTUmSpQ28=;
 b=jcGIklpDq8ARSbnYyYM1KAbiuyCSNMKvGZhvwXrYBDVFLwkQFI90n0Tq7NNcW+3SQX1pDVj6xaYbSqqgYHPQbxJ76kKlqQneX0MbwlTQInvy3MW0WYL8t2eCX1Lb9s/BoyqpsQtRpV+ufKn7IX4ZoMiBrW77QgE4cEFJXOaW/vOUk07BU8iZnQmXyy2nrOSFySZgER7cDeaXxDdluHaPyKDhIdtWeDkm8wYdulQSz2AghEiYLD5pYnXweQqQIihR5WfVsgpJpzRXk3r1UE2mOnjdB+5bO2DeL/jOIlF2x5V+xRzbTPCm6kFo5e+XUvZFzK0byWAYljK+BuDz6vZGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7eSoDIQs+BITe4ZITRsdI1l2XWfLwFq00VTUmSpQ28=;
 b=crD5B4f1TBLdU/YsucHcrzv59C52XyJY+ELgXt7+3j9Qp6rL5oh9x0q34yAbef27WnE+FCgYABf1jV5eZ/xXGsTkQWInEoVvxWHdGo2vjOMmI25EHroAljle4FBoBDIpL+6unqB1d3ONma4+fsIjpzk2CWME+OT+ZfsoRD1AQbMoqel/DcocyBNZ0T6BIHy14DKAhYBJndnk1u4Fejsn3eQR8LpmLG+PDtfBaM8imYuCkOs04UHDkk2trddLL+jVSig3DlpKYw1pf4COh6N9PnD9kMYkt3WP1PGOzolsKe0hzC2guI4XoduBakwrpvZf0dw6mRDVYsFwu+iPf14Q5g==
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 09:56:49 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 09:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 09:56:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 02:56:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:56:33 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 02:56:30 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v2 1/4] mmc: sdhci-tegra: Separate T19x and T23x SoC data
Date:   Wed, 14 Sep 2022 15:26:25 +0530
Message-ID: <20220914095628.26093-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: cf231c77-1de6-4266-a9d5-08da9637708e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkGQE8Aem8RORblhTspbc/bAi1nf87+Z/0uwiyHBPfjyNb0560dsGAKZ3vwyCvONA9KpuSPWTbOZMReUwObjkA6P2Y1SJsVoCGMaomodZ6PcaH4FyL54PLp4f4CIJfV0CGJlWJDmUuE4x33kcz1pJ1Nz+WHSN9Gf8tCGVKh4J8cioxRjgTYg0pdxC1CNe7Vdwq82m2w0uKE1jrtDCDp6a5DlnMplprIHNLZ1zbdyBXo2EF87ueqqI76oi1YJ7uXyw7NwbgTBJWyndH8L3M3rWTEi7+1tRH3jXrfSRXCx/gOX1eEi/RLrl5TzxvOr8gfVUmOkZMhVqFS/Yhu+O12bwgCWPmvMkaBA7anEemhSAqtBlbszpHa/vjCIpWcEisJuCQwVaaZLHNyq7k0pzDjvWQIISlkL9eWys/drNQ/Hl5uLjn1ghXo6jeUg72WhhHPT0EQYDOkfLs1uURnEcFb90Hol3eb7vh2WwIMbAYxM5BdGytOEPGHL+i7KZdft7BVs+Y2aDF7cUn7BfMQ6ZMiTO68SO5J5HOXguc0L+iVE9ZbMgXT5LIM0hjVPFlCV3cOzNQElEQe5IHHL9L4XjMKLBnOE3nICVCScDhxZyJbgkXiMwz/Kcf/v18xfcJSnOONxLLNcX2CXhYMfMQ9F174BOOt4YZbVCPLRjwsbnC8RoKUEcu6qYJYwIG2SgKPJZ6VClnbqeY9ZFqMKu1CX+6Y19hAg9N9EGC6/fV6mvjE4iHr1eB2YQ4JZerKbuLmFpyY0q7zonPHF3AnBYMarCUV7Bg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(36860700001)(8936002)(40460700003)(40480700001)(1076003)(82310400005)(2616005)(6666004)(107886003)(2906002)(8676002)(356005)(36756003)(47076005)(426003)(7636003)(82740400003)(316002)(336012)(41300700001)(70586007)(86362001)(54906003)(70206006)(186003)(110136005)(478600001)(26005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:56:48.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf231c77-1de6-4266-a9d5-08da9637708e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for T23x platforms.

StreamID programming is one of the additional feature
added in Tegra234 and later chips

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
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

