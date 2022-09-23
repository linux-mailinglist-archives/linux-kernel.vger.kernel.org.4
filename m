Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E35E74B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIWHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiIWHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:17:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C112B489
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUYq5CHDmrU7fmrGGV7gfKgEA3dF/DVJSns94QCdv/tcwOd2TE50LyAqWojYipxYxc8ojQMiV6E/aDI/9ZNH+1I5/Y+tjNhtjiqPH9yIkwfveazPtTiQZTsf3zgHoDf2UjHHfhI52tmbYsY3O2zHVJy8krdFYE5lCy5q7SJhnbrh86tRBOxtXxiYu0atMa1+2F+Gd4Wvvnc7ZNrYp+/qjnHB10q0HTta/JYBe37Xyoa7TTc78nwDKVjKzwSq+aNz51c/F2cwaKg+oDWpiBEN1QsH0vEXGqHo8JWbat+wGgPkqbe7g6rgR/yvntnGVaP/lsA2bzy23oJtz777Brl+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB80d3+zufLsFYg0tOQC+fyM3vmYoMYu61U0bFKxbp8=;
 b=mKv28YLtZ9alPTT+xYnpdcaUEAlT1puBF1qtXVTQ929YtwSGFGhCrtkIgGjAeDitI5xRxc2V5N18FABY2+IwGgymGsqD2hMEdzfQunOpKZbTV26cnpUxgXf9GTegKpPOeXrFOva9AZLr9h26u5pntzJB1au/ERYgwC/6wCbNDYGnCAIn7m24ctTqSTkHywXMsSB2zV6oM48HlHA0hbqp4PdZy6rp5o4Vfoq3vVyWepRXwRcb9psMiIGxgolCI38MBsxaufqW9iueFIIR1ST8h+eEEt/FrOA2H/N97huur8819M3lCIXvtj6UhqINX5o592nEl8R2BxiYx+qDe//2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB80d3+zufLsFYg0tOQC+fyM3vmYoMYu61U0bFKxbp8=;
 b=cMDu1/K5Wmymh0JbJQeVePLF6hA6hk/iGDKoErb0/CVBCTp7v8nnInPWqKTHkO83EnCYqRI9kDR0n2mKB5a/LkZDwWqKse45jZrguApdHQ+j3wjRBZZ8tbwmgQ9RI+2yZZjRSn1F22NwzrtLBXQjm6PcsgH9eAZdX92u4ciPwhwVIyt043Xf0uwA2izsrWSVYqnYYdj2YRBHlF57NW00tvkZdXCEHt4CiVJ/1vp5KisKhL0LRez3L90W2rgVpf98L9rw+9RVP2hPyWjGojOa/tS8lMQDA7G9y3SgLCF2CNBuUy4qxN6ynv/MaauBc2YRCqkm8nNivnfxW+EWY+caDw==
Received: from DS7PR05CA0042.namprd05.prod.outlook.com (2603:10b6:8:2f::29) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Fri, 23 Sep
 2022 07:17:50 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::44) by DS7PR05CA0042.outlook.office365.com
 (2603:10b6:8:2f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Fri, 23 Sep 2022 07:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:17:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:17:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 00:17:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:17:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 3/5] iommu: Regulate EINVAL in ->attach_dev callback functions
Date:   Fri, 23 Sep 2022 00:17:41 -0700
Message-ID: <03bbdfd598344f2b28674cb9a739e29049fb3cec.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce0af2d-ab9b-400a-340a-08da9d33b93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MpLkg/dqQ0pJPE5JFeTg/ISuPgY2S0fWOzthrYR6MwBFLjfwAWgUZUKiuyu8YsFi4JTCmumA5La2X16l9zpaxE/4FKe5WSge8ANJIkSMqZpEFnEmU2NnPX7PAJYkQUqUOVDVMGOHafMWjLoUuMZN2is6DLYEAOIDrtz9yS3hM3+Y924KDO3F539FgoQdEGcvoJaOBDLrtrGvxvg3zxO1hvujaeVG7B4S3RNnpD8OabaTF7ZIdfO4u81mHYEnPB5kHZFCdm0oWiQzAS+saJyjUiHKOiB6kLiTbOtss1FcdwOeU36LxC23w+Qe/vwjEQc9QRkFScsWSXMwJMsBs9/AZQKKHVkmViBqus+1n0/30OJtJOFhl34jMJHmLdgN7vAwDOz9iJMmsWS+UIoHgJetm22Nq7LywKfvSu85tVrfJpcYGF8rhU7BDBX4pS8+3BK2FogZIQbeVMfaCAzuENClKTFsCGaLuYZGuxK1//GUSTchuuPbovcKbdcLg9BwCSIQScnHH+TGw9VDA5PfqlpCL1LKbLHUQfpBKMeEB64JqWOkcboT8YGIO4rmv7V1KqkeAGDIAf3Mat8agtq7MS5FUPz3GJtcRoyTtCnFn9zjlFMV1LAilSMkyuhncCw/vOSkEc1zFIJ3Lik4tVjDwNLfoSLkis4E2ra+Bu1kQ6Swnc2C2sNsQY8PeF7l5sWxtAs6zYQP7a7C3qZqUx4Uwicqrhglkt+YuSAuGxUv7f42pCCNJp3jYlUX53llI/mIRImvIiBbdm5BuOCwRJSHUJAzg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(110136005)(70206006)(4326008)(316002)(82740400003)(70586007)(356005)(7636003)(8676002)(47076005)(54906003)(426003)(2616005)(186003)(82310400005)(5660300002)(478600001)(36860700001)(7696005)(336012)(36756003)(86362001)(83380400001)(40480700001)(26005)(2906002)(41300700001)(7416002)(8936002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:17:50.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce0af2d-ab9b-400a-340a-08da9d33b93f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the new rules in include/linux/iommu.h kdocs, EINVAL now can be
used to indicate that domain and device are incompatible by a caller that
treats it as a soft failure and tries attaching to another domain.

On the other hand, there are ->attach_dev callback functions returning it
for obvious device-specific errors. They will result in some inefficiency
in the caller handling routine.

Update these places to corresponding errnos following the new rules.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/fsl_pamu.c        | 2 +-
 drivers/iommu/fsl_pamu_domain.c | 4 ++--
 drivers/iommu/intel/pasid.c     | 6 ++++--
 drivers/iommu/mtk_iommu.c       | 2 +-
 drivers/iommu/omap-iommu.c      | 4 ++--
 drivers/iommu/virtio-iommu.c    | 2 +-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 0d03f837a5d4..2eb3211c8167 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -211,7 +211,7 @@ int pamu_config_ppaace(int liodn, u32 omi, u32 stashid, int prot)
 		ppaace->op_encode.index_ot.omi = omi;
 	} else if (~omi != 0) {
 		pr_debug("bad operation mapping index: %d\n", omi);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	/* configure stash id */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 011f9ab7f743..b4a1c0f79c3e 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -258,7 +258,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	liodn = of_get_property(dev->of_node, "fsl,liodn", &len);
 	if (!liodn) {
 		pr_debug("missing fsl,liodn property at %pOF\n", dev->of_node);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
@@ -267,7 +267,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 		if (liodn[i] >= PAACE_NUMBER_ENTRIES) {
 			pr_debug("Invalid liodn %d, attach device failed for %pOF\n",
 				 liodn[i], dev->of_node);
-			ret = -EINVAL;
+			ret = -ENODEV;
 			break;
 		}
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..aff1a9caa496 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -101,8 +101,10 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	might_sleep();
 	info = dev_iommu_priv_get(dev);
-	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
-		return -EINVAL;
+	if (WARN_ON(!info || !dev_is_pci(dev)))
+		return -ENODEV;
+	if (WARN_ON(info->pasid_table))
+		return -EEXIST;
 
 	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
 	if (!pasid_table)
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..be1a7d1cc630 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -607,7 +607,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	/* Update our support page sizes bitmap */
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..447e40d55918 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1414,7 +1414,7 @@ static int omap_iommu_attach_init(struct device *dev,
 
 	odomain->num_iommus = omap_iommu_count(dev);
 	if (!odomain->num_iommus)
-		return -EINVAL;
+		return -ENODEV;
 
 	odomain->iommus = kcalloc(odomain->num_iommus, sizeof(*iommu),
 				  GFP_ATOMIC);
@@ -1464,7 +1464,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!arch_data || !arch_data->iommu_dev) {
 		dev_err(dev, "device doesn't have an associated iommu\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	spin_lock(&omap_domain->lock);
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80151176ba12..4c652773fd6c 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -669,7 +669,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
 			viommu_page_size, PAGE_SIZE);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
-- 
2.17.1

