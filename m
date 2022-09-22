Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42095E5E01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIVIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIVIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:54:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD591145F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH7j8x2sX5pAcb6Zpmdty3vFXD8VmLk40CLGLBwm1HBxwbMYHN57DEQyw4nEnwHsUNpdXX+/bWFCZ42rfvaX4d1F/vfmhPWeIHrUcy4sJ2dTVx+rTEh9Vc1+KS5mtx2DTDXlyH8JBqlxPgMq1yMsnVB8qTnmUftVM8F7UUtaXre1hUNaZAQOHaA9vRefJeTu6yghZcC0M8Gkk6n3l1bbXLGjC18m0VHsJloDQDBcxECPfrMF1VUr9PlHUYWKCHSPYkZCVvlz4jQOHGU4faDUhwqCu3kMAacAYPGPz4q8x48ze+5czcHgLQ9lIc6RoeHwd+MkJBbK1phV1FGSiZRrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvESo+xNb5flyvvAFKJxqVCnPKzV4HTHa+GH9fp0DhE=;
 b=G3UUm8PTo/r5UUDuKd6vx8hfkGPuJ/TYuJHmBylEo318p8qhPorGjQJjuwfoVF+/IMYdhrroBvQrjGBSKj/AmT42VKzJeBQzA7Fty8+SYyt9hHuY0NqC5xZDF8u7uE0rg3PUD4GWrpuTn3yobH3P5TOAk7Z35S8kVHBverbuMstjDmPylXR4kObXng/ynflFTpcNVwcyii7+rQYGC7xIr4Fywhuf0JHz/PRugs8CicpeUvHrU5OkvaA6PsKr8/MkLq62iPpy/EHvjIjfty9L1aqbJw0x/FOcAn7EH0Cf78mr/8H2hOm0E5MHtrrdrfCWLVzm6xTssr+OlxYbIoWqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvESo+xNb5flyvvAFKJxqVCnPKzV4HTHa+GH9fp0DhE=;
 b=ICnnmhy0Ng+01aLXSXDmd6DPTm7f+DN2jAwEquLU2HoVgAGxSEzG5G3gfUDMYYng9VGA9OiFe04w31YC0LbRWwYdAzrjgJ/zrhnBMOX484JbWV5+mbKHX5niL90Xzt/GmMMTs1iLuW7fyTTaSxZXCNxPRajeRz11u971w2J3n1Vn3ULZQuu79XHjxp6FMi/rTQJc/U4a+VEiJyVkj1cRPVCray3RgFNgKkresryKTGCgxWAma+w1eoR9EHdNMgP4MKfsEl2++hmhiwm0u+LMh5DN6uo0KLJj+IxlOcCwkAHvgUc2wLIHe7a4aHSXwUDbQxpJwCVaT0L8Js+bbxEpDA==
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 08:54:37 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::97) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 08:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 08:54:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:54:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:54:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:54:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:54:22 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 4/6] iommu: Regulate EINVAL in ->attach_dev callback functions
Date:   Thu, 22 Sep 2022 01:54:20 -0700
Message-ID: <1316cc05c7b62f32a3012957220b87dff3317554.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 96be1acd-7235-4888-fec5-08da9c781449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhAs9dEnsHS0T7vP+V33ZwnlHvaRZq3S19E2p3HcU7mOOBbIDMK4EcMTJ78foUCz78IcdlZZSNPeyqSANdlUEdxsns1mYhAAR/BzKt4gguPKBtLWv+bqhLc3q+sao3RQhpSPLJlr0cCRFEV0fTzjiAoCWOZXfcZFSyF6bmmGjP9X8/2xS6GFYPmweO6LoUPnPM+gdmp9aRpIUk3WqiB6fYkomoZ2rOpRdSzFGUZTAKB7G55gXcXd5A1OgvQgvCcYAX0bZiWMChDJ/jG4c3RkGWT+cROpzROW+92tP+kjHG6SmpxdA9Uz/L7DRkGByJWKOX655VeTBX+8Z9cbosyFVOQaPt4jeC+gNDTEyujLtcLJMJcOp45IquVp2o7xuUVFYIYfnSlmWqrwR0J2rc4J9P7bx7KBMFjUXuTAri3K4Ykw5tzzU6FrY+q+u9P0v0zkUwYU+2epu8SUo/rsVAL4CGztaJTNAZ3n9QKcD5wFcPxjX4t14fYLycfxK9VENto6NojfovzLax63ZicOMw31LjoKpaqqT21bQy4U7dBNy5tBDU6e3sR9zO8n7e5hPZAq+qbqBxiWXU4jCQnyAS3+EKyQjvkEw/tjFhXHHlrrnnOKa5S74lX3zdhJ0lveGHOY1U0gk+NQXP1BqG7IpGIk//VLjSyQdLa1dTtlvh8EbvVd10BdWbF11bgNceBTchfVbtyi7cxeSQjJKRVHXfjA++4EzyEMdKbFrxupKBPPBGfp7ySf2Q6K2y+C5FtHXLTAOLKfzMKB3iyc7Fvw4pzvFw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(426003)(83380400001)(47076005)(2906002)(70586007)(356005)(54906003)(110136005)(478600001)(86362001)(8676002)(4326008)(8936002)(40460700003)(70206006)(82310400005)(336012)(186003)(7416002)(2616005)(26005)(5660300002)(7636003)(7696005)(41300700001)(316002)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:54:37.4717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96be1acd-7235-4888-fec5-08da9c781449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

