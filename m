Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790D5B697E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiIMIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiIMIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:25:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674918B25;
        Tue, 13 Sep 2022 01:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+MyTyCchmbR1yBpBcX+GKzveSOlynt4qWQxx+dhhe4bYr8SlKZxKDl6Icg4J5XOahZgOlQ3EiaSfjqppb7sSaCzKx9uXRJOZ91txaKSEC8D98UGuTccxBPoIpxzlr37k9y4nabmZo3YsVRWuTfmbz8VOtHXo6ma99JF+XcQE+vlaMjtNUsOGUn/xhZDElqxIV9L9GQKHDlfDPNNQqbK9URYOFKydgDCJzq8FISvt0m563YAV/28zt2b8qwUbpWCwaawgWDZc/jGP3G70JftFqQnD6tWBMzEEe4wF9zqfNK+fMu0BPsRMfVKXDvpFTQlS5i7bAOzm+7908zOerdLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsxEJK7z38CdL6mDy4FyT2UUv4L1+9wadUkpAg14zQA=;
 b=XAQI8KSsEJ/poJQ/Wl4XidRJbMrG+P2xHq0wZpJ0EQfSBKcS4Jpk1l428pDfk97MzEdycuGRVojNZOVPLB7+EtwR1kJE16H9HwKfLbP8+678smaWibqG9tdYaYxOJyKh3G0MQnE1KSoZpxlW8cP5v7D6vn6unQKXugNF/aVPmOxLhFblnHAriN9it6nmwsJ9HRVbe+ctil+lYY6C5hJJE0u2BWoDKwBBSqQafLdyd/Sj78ULgT2fVSvc6h1penUqpoSad1A8DDmGFDHbQsKdfqYR7Z62qQfIkZYdooLg8GujOtOF3J4EryVbfnrepssVraWb46SuKT5868sTUSb2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxEJK7z38CdL6mDy4FyT2UUv4L1+9wadUkpAg14zQA=;
 b=LGtaqDneVzCVMNCQ8Aw5FrpscN4JOJ3E2roiQbdIas4Drdlw+uS7/+LaTktgpU0G+TK+Ghcj//aRR9PbMPV16qgp52ldWVd+iuNP0fJ1OGsm/ndMo+vjGhc9iPGcva2V8c6oXSyfG9iiJGqDzDLO16OM5j+IkhYvnPbQZY2HAcbD6Fs7/NaD6CU3SeujbJ7mQ3zrHXcl9rRxereEK7/Tla+p3bMS9AGQo4UPt6HiNgK3gCS2fsQOtcIpwJLyobiGBV8CfJ9s41hJGduB24wLaM3hNun6zln/A7RDcYnnSO81BAV6VjXZvwErWe+Mlgz8TE/yQM6FwE383KgRhjhBIQ==
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Tue, 13 Sep 2022 08:24:59 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::b) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Tue, 13 Sep 2022 08:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 08:24:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:24:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:24:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:24:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/5] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Tue, 13 Sep 2022 01:24:45 -0700
Message-ID: <20220913082448.31120-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913082448.31120-1-nicolinc@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 730928f1-b9bc-43d6-0d14-08da9561728b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVmi6DYCGq7EbKqgE8HSUT5+ruMd8Vs8P7yG2y+pjfD+yMTDwd+4Db5j+juDAQfUxeOWF3heITR+fUlXqJeKGW2TX0Rol5BlDNCGs3HlAxzOp+nwo/Cd4dOjiiopWTAHZPtzu/6CEtfEZlrp+WuSEaDQFd7o4HXtWqGrYLboArqOU//MYmTPGyQVUUlhARhTP0IeOjFwERXF4jc9ym7EZzfXvssIGm7LMaQXrB0nKgE/BT7xALVD7PpLuvgVuGA8bUiaZ2V295bNCaQ4baaMlJ00rUHC6vUw8qqJERQzsPLRN21LmjdsJ7sGmESKxGivBME+D+mOKZnA6cpseix9JBvDI/AZQ7niWP1Is6/7fKIla6GQDLJc36hKZWIHaEHa31tZVWHURpczWgg6wLFTfCtTb0cQXIItMpTZDnN92HtuoNvbUVUdyDTFUZ5lwHzgChx8849FwG0EbytBjCLy/yVf/FHRHckHLTVh/kx2pmklSHRnXSMN5lXqkL6YvkujEPDxpQz1SW9kAg5zulhihmbZ2ryNvihJjLhQDVxz8Vc79ewwbC3NC8P4Yv7HOxnc38wU/OySS0yXBFa+nSGuyz7hfjLOexGIqB/cwhpIllnCoIBge73cqPHSEZ1bAXgNqOkbQjeohF2BkNVqvByHrSCci0hz2uv+FmkpR7i1M26EySoqOzymP3XarlIuC3AWTuatkTKRPu+4r+H6HLC8cQBk/YvpCbByxKPlOoG2SZ9XhjmjN5zQTQkwxlFoT5NEY83rxGnh43lI9OT2K4f94oWYp0xv+tsjq5h20eeWkF/dJWuiVSUdo4dl8lBbeyQZAyrY/qZ54HeyhPhyU0+XEGkTYS7duvTA01Gw9qksyUiJ5mRnfMYnik56OsaTbtUY
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(7406005)(478600001)(2616005)(336012)(5660300002)(47076005)(426003)(81166007)(7416002)(921005)(1076003)(2906002)(316002)(7696005)(8936002)(6666004)(4326008)(41300700001)(26005)(36756003)(70586007)(83380400001)(70206006)(40460700003)(8676002)(186003)(36860700001)(110136005)(82310400005)(356005)(86362001)(40480700001)(82740400003)(54906003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:24:59.1022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730928f1-b9bc-43d6-0d14-08da9561728b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device any more.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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

