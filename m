Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB05E5DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiIVIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIVIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:54:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0AB6559
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIloc2d0h+ONO0q9hd8UDSPKfQdekx8vM/SFwp3llI/bibUrMeR7ed741ZSxm7cazUzkEN38PpZQoJ4otkh2ZgaekR0cWChmgin3IY0Gy25p3IEQOcUsPodMLO2+4kaIC/Acr/Rfjh5ctESpHWe261sCWw7ljWDDljHvBIccH+C0snOrRQn1s0lojPaK3HCHhWk5Mqg85/4S2q6sMZlr3KzXmC96XIa0cAW0+fB8RA6lwv5GZ6W5RdObN/sLquCVSmsSrNpUft00lVrjtQJwVsXJBk3fVNiuYUH/wTn6UJU4vjoJJRO6WfTZm1jbQdHXxHis2YwuIVisJ6VapQ5Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=XE+eNpLmkolLyHVtMQs0zLQWx6F1DXFC2vwrhcYpiUSnOArIi6KS24bJ5KqvZS9QIh/L17WDV3W6hFsUds2I9Us/qHm0+eDVnyEazFS3UYRfGMIyiAtu5naM2ix3iEWEzIe4ym5kgDIfOPpB7TMJh99FGyRH79Es5JhJ542hHdHYzTR3FAc0g+HLXxRB2I+OICotpFRrVAP/vr42+gy/Tf5/NPfRiK90Rvqsj+hHx9FgUfIF+iCwu5/3V9Gj40XdEpFqqaBRAm06Ifj5SB/tlO759afxGSG8Cez6MQpXu02eYVmmEzJQ62tJWWARqXbJsrJYofGp6LelfPQFaxgZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=kliVKQGa6bIM/jo239Oye9Jbo4NWY+g2SoX/PJK5mvm9lzSAdnIjKff2YaKWFU4InkNxlFshB9Bv0topR6Ld7bz38DiPlWh321d7CWuoP/JYWbUsT9ePJN6yhdAGDTtSal+lyAJOQsOOvBPQ4TOx91qRkiZXHC6x6h7s58CBz0rbv9uDQ3VpQu9ynSHttbOh80jp5Bi9GKuUig9PvjyetuhBdJzFWvNr2aF9yPMPy1i8J3pTUGug6Tv8MaNX9wSWFsMnCOR+U0tziIVWCt+3j3WhLdaSD1Wh8txd/nJeWztgyh5Kt2ZSsGdsTUlmsgMR2oZpN3l+zgx23mljQ3T/bg==
Received: from DS7PR03CA0166.namprd03.prod.outlook.com (2603:10b6:5:3b2::21)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 08:54:07 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::d0) by DS7PR03CA0166.outlook.office365.com
 (2603:10b6:5:3b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 08:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 08:54:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:53:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail203.nvidia.com (10.129.68.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:53:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:53:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:53:53 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/6] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Thu, 22 Sep 2022 01:53:52 -0700
Message-ID: <b7402679fd29226d544ce6e3a31032c0d5656b34.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: e28657cb-b68c-4ed8-2b25-08da9c780212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xdUazzHNCGaZkrqRgk1AlYostShkNa6ZK4TKIgDCHZFgQUA7eMCLuWGKTj5eExsqJpppyOdaB68J0lByUpY0/ZY1IpJHkujn4spSObpPweEJr6jVujvJFqdzUH97gzYN+WIx7S+r9IFnwdE+PkqfMyqX2GwI7kX3mh4KK/uWP67Ssgu4Wi7S0bof/Ng/fPHz1yDuZhldW2HR7MffCQguljY8er5ofnyCJM5h8JM9uoNuMgGAO1Ll0nHPRNrU+my6r95dww7qGpuYauVv77lcK0E72KEwk5oQm8Xoq3PpFVDn1aZjedDpCCZ3rKoGch46s+eh02qnTitDSDWD4JVyk17dzpLeUl4n5QJA7bEqJWJKJ5qEt7XovgWIqq3U0CBpgLpFGctHVpxxBGqNBgdrrneL+FQGwQFsE2GKmtdqmZeIJHKnduBdNzX7IJYUhbmwKKFZCNF7RXxxyhIpdGP0baPjxaZHeypXOaX/dEZ1F4m1yFaJ5tz2N81FgPiqantWyofnvuW67tneQxyUHvRfdQN6RFlPSwc7E07ohvHcCbL/uatK92kmx4VjkroiQ94ScnFI9f77WMxRHl0SXOlWLx4Uq0l1E5qDbDacqaLV35+/eM/XBiIw5C41/0PV6xQEahe8bMU9g2bU2SWgksM8CNV2h32UVp2MuRhjfmt+UTdRuoyTombLMRQgO+Gqgw/aIv0NJCeJn5b17AwAZNjGbXG5PTAp/Tc2awQHiWzi6fYlIYMooUgvzXKvZ0ypCFGkPdQjYF7/ho2MmJEeRDJeA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(7636003)(86362001)(356005)(316002)(110136005)(54906003)(2906002)(336012)(83380400001)(26005)(426003)(47076005)(2616005)(186003)(82740400003)(7696005)(36860700001)(4326008)(40480700001)(41300700001)(478600001)(36756003)(5660300002)(40460700003)(70586007)(8676002)(70206006)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:54:06.9380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28657cb-b68c-4ed8-2b25-08da9c780212
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device anymore.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 828672a46a3d..930d9946b9f7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2135,21 +2135,13 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
-	if (!check_device(dev))
-		return -EINVAL;
-
-	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_data->domain)
 		detach_device(dev);
 
-- 
2.17.1

