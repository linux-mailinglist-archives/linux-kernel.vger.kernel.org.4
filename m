Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B2601D64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiJQXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiJQXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:11:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B785AA7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY+NWR3+apZvhwmzqF5AZQeOrsL6Ko2J86y98O70ykDEr+UDpl1UmRq6ff3cSiJU8+jl+Ri5Cavc7bGxiZTo5kf/hinBl+24JF0UiuI0zbGFTQDyRbhldHxHqhp6lN85IokN9P4LUsQUP86efnW37EMk+ck8X0oSG518F9YHpZyhRDbCnEqAp+qELk6Uyh1tj2yPuzevR79qjhk0AfkItw7HjkXaWSxEc0AOAQTOgi8j8vPEi566jMSlceorBxPWkd2tQb/wdblUDLUCQM9KZpIP6n7wO5BxNWyzhyVJevqlw0HhL7JzX2Y8CIv/4RMGZuUEniDVsKyaBiTGgA5aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md+2EX1dSQkKHGoKCzmI58GHG+0xMrjwQG+DK8rY6Wg=;
 b=Olu+dyEYCICqZ+cOUTJiIlVGMLN+YeZaisVrmwh1KF+8xUpp/+dndg+gstPe3JlIZhgMQ/phPK59uCGpeDtJkCTv5+b1eOYYMXnRralW7vet6S4ozvpcS/Me2MdEHgSA2XRSCQDhpGA75yqyB4X2rSo7/Mwb7EP8BhqUv/2BecKN4KiYX4xUT22UzKhEBOFVa2/85aHIiLrdNfUpoOtImt4vxIrXYz0ifojM8M32qY+Y0yEFJFnsKYeiWc5CpB8SZcnrI47U1YaGkeKZEkSk6/xn1LrZqu8bg+zOpZiVg+u9szQ/woMcihPyUhIpv184vYCBrJoctqDpisjtUtS7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md+2EX1dSQkKHGoKCzmI58GHG+0xMrjwQG+DK8rY6Wg=;
 b=hDDDKKmUUpA1y1Tcf/Q18HzDWjPQFmSuUgFM9+X3ykj0w5l7+uqrdRlPyk8SCQrC/56d/mFcaQTT4RNjopE4qfaSa9+KdA1SeuWIkRuIRS1rjZzYvsrHCtGEoVV4U2rVkmCT8dxHC5FJsBIHly/srXsZhQYFDLKphKZ6bHj9B51ERmd3G9pUe/5jUoNXfZiL1DtG7n+xBJJjkX3KkOzLoZLJ7ResllXZ5VuToxKxLoKA8FCl9mQPKlVNjL9wgdkZ7ls+RehQIoP4o/DYSA9wgqKSL3/CuMk5kXK41oGP/IrPNYK1ezpOAw51VxIHvopDdN15TXhUnrzf82LCtBRVvA==
Received: from MW4PR04CA0239.namprd04.prod.outlook.com (2603:10b6:303:87::34)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 23:02:21 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::81) by MW4PR04CA0239.outlook.office365.com
 (2603:10b6:303:87::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 23:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:02:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:02:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 16:02:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:02:15 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <yong.wu@mediatek.com>,
        <matthias.bgg@gmail.com>, <jean-philippe@linaro.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/5] iommu: Regulate EINVAL in ->attach_dev callback functions
Date:   Mon, 17 Oct 2022 16:02:13 -0700
Message-ID: <5924c03bea637f05feb2a20d624bae086b555ec5.1666042872.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ad0e01-35c4-42fe-691c-08dab093a5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alLEcC7RG1asN5GjKte4DPx/QnrXOpncwp6ZAaWaZjKNr8Y7wmjWfzkUrYfzIw7l5CxBEjKHVH59DGIjM1ajdBBOQDwsIFlSlL8OeC9hxoBwpH83edFGMoO3zdy+nITYwyeNdedaSYUVrcU/J+tUULSvoXsorl6XlbZOGWnYoSjbkjRsEo/nWQLKyXO2PDQQNHNCezeSNkIxxxitaw5blM3bnVWSTzK9WvdwvEy3dU7Z+87z42Lv8RcRSjhZnC0Ku0I4Ll6hPI2ZMt92r+z5zuz9h9n3I5/DV3I+OEvVembCxFThHDMLkVYIAV7VfvevuburCufNNdl3N1kST2cMKKs/mTkvU+HF7ePqDm/Jb7rO8dYiDLFtQ8riJ+Y86uh1suCuqBAIlOfBMeBMCQEj6yOw98yBVWrxlx/ouB9ZaGxyMhrvGauJQspY15mZ3szJjY3G/0rXk82LdbjQDfC9AtQvpqohoA9fxmNVqYl1w3IJiHX8f36A4ZmEzWu1pt9aTaKCXx/CuHJIVGfbmDIwVLytcieEYWfrCWh7MTGs7oiN6dMDeDdMSVUgE04sH3Z/6T2zhpAhM/4ufb7tiLPM8fQcxua9gWfJwiZfUsHBf6gM35S/zyrTJQPIcIs34sBtJhL3aZ+2big+qnNB7tl+3ayep4SNi8Kr8VQR5+1ujAyL/afdFgjhyBcUfgvsFd8GE6HnkIdsLYx3BfL0sq+sNLqw+ZooATb8qNEKfNZkrCwfU++254653/jhLNZ2C7MuxT/o7QhhCznrGy+QPRnqmQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(47076005)(186003)(2616005)(426003)(7636003)(83380400001)(356005)(86362001)(36860700001)(336012)(5660300002)(7416002)(82740400003)(2906002)(4326008)(82310400005)(40480700001)(8676002)(40460700003)(41300700001)(478600001)(8936002)(7696005)(316002)(70586007)(110136005)(70206006)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:02:21.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ad0e01-35c4-42fe-691c-08dab093a5da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
index fa20f4b03e12..4408ac3c49b6 100644
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
index c30ddac40ee5..95d73f19ab61 100644
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
index 5a4e00e4bbbc..f3dc2aba188e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -609,7 +609,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	/* Update our support page sizes bitmap */
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 07ee2600113c..3f153f9e0ac5 100644
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
index b7c22802f57c..f0caf9a4f6f8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -668,7 +668,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
 			viommu_page_size, PAGE_SIZE);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
-- 
2.17.1

