Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98505BF916
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIUIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIUIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:23:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F754C82
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUo8YHzGqCK3BCsEepWc5awnQm50a9CSBva/eijKQs8SBLd/uBTVBx7NTzm7XtCi3po6KePRvbC2ynWs1Km5MPqQM0D7zZ0N0FPb3yk/iQX6XHPw6nV2mgkiMg12q8suDQxjsEWsy6b2qjEet8SY+hSqvIXBXAD2Xf1ysH7nB93y3kSAqHKqPnfQYqCysbEDv5uU1RmjFNtlmVoQmjEwM0pVPGXmbqp465rz3Vjz1BqbLIluqmHCVxZcG35JQRtVpZ6JhCYk/nrED2YRBtLzYUYoxn07bx8aKKnZ/ZngNQUqllN+KyrkwbmoZKxMiptfGIlu5aEx+bT0MBk8ytRl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9+qEiTVW/SvsvRS/QghPXFkTHmzCWf++LylwJRai00=;
 b=D+SPYFZcy0olfnmFbUsBq9FfUh2QtV3ozL/IMQyI/i8jduBCJHzVW21JnfgAsKqOOCKr7E+KSySs3jvQDFVUYehXG1D+pYN7Qwi3tOVdEe/NFjD8xaxa4NNgFa9oZp/c7ZbnzmgsqNMms3yOfK5VsyU1RWc9sN2/x+1jP2YaOVzqm7ldB2Q/Ky82y04Sib157QMr3ZiLuMLF1zNOTxH61U4l8C4nrQc2Yl7uuD6KBAA7waFlkyMAe8E9O6u1rXR+204wTkq/CNImlNlJBn/mVjkakNORkQjxTH4eZ16z0RwhswTzbXpTHu0McVhoEGPy3cbcfLkiebb890wE6wFTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9+qEiTVW/SvsvRS/QghPXFkTHmzCWf++LylwJRai00=;
 b=Thj3iSawfKBPorUXLCOcuQs6AFdweU6HWKZLD/qqA/Jxvhu8IyXg4QhM0SKya99Hvc+8fD2DbIqMUqHfD+/tKah86RjZtmNLO4Ht6lFt2mhnx3tHDmZBbtz4Vad76FAwihRO9svzWoluJtUPLjXiAH6pVQFQT1Y9inKFnbICuf1+sBaJ0LIkgxI41Ub2sZ72JXagT+NeT2KQeZerItFi661n/Ya9P3tYeE8lsnE5jRsPuqUP4pYO6etKVEeb85cmSXR/0aSAF27s0xd0GYpWUBKNzqkLxvt/DMng8UwexafNvd4SgJSAs9o2Vu9+RTQA7zUNOVJmmvuF8zIi7rOTSg==
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 08:23:46 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::78) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 08:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 08:23:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:23:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:23:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:23:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 4/6] iommu: Regulate EINVAL in ->attach_dev callback functions
Date:   Wed, 21 Sep 2022 01:23:28 -0700
Message-ID: <6c48822600154314778157ab7f72a7b55f5e2c65.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bd10bb-3d08-49bb-4ba6-08da9baa9a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FKap5FC5SM/KoxsWoYq41gcMM59OevgWYbJSmJArYbvFdJtZE2deN9wPW6HRzqPfkg50pMTkZ1XyDjiLrXV8ICWqPFe+TT+IBg11b3gfC6CbcINsEEdN/wDq5Umv6QPy2AIOvmOZVo89J0AMc59Ko8KM6cYNBGdW7GbIhsFGtlxJ/oy1xXHtVeXZorOwzqBpqm4pZUf7nzX0yOSVXjbMRmOO/3oQmSmfVMjVxw1sx7fZlB5tkKI3oEPziW2KJZ9egsXEx9uZsZ4LqCmGrVRHi6xydBarSLKcD0mmhxBAs77ttlLF3RGeMNv52o8eHXVVuOzraWtjYI1q1GzauDSM/7YmTr+YXYWHTbjsvJuJEzSRygWGRLtDK6WOY65Lx5LfOHGl01K7qyLZZJM5aBPOaAowcf4kYJ/bryiwVm7g6npuQSOXcy7K5HTe/WiPDUizmMz4uLnun+3X2Mza/9XQRi8b0jeQBEMfmsFdU/9CwzwZdaaEROimK36OgDOX76U3nmoaJ8S3Pjh8U9/xQlBUnLTCoFEsZOfCsrwoOametaz173S3mCIneiNRLDpXq5A13c9GKN1iZr7KxxN2IuGr/dR+kz7nzsvb2EUmH2wRTsMxVEmL7nfa7x43BM0NpRi21PQnVUz6LXEVTYmr1Hu32PDxjzfmeNBa0k6T32U5C85pdLZ1aVUK9Y0SZ6u4BeYRYqJH0hpkHSLWCrBARnde4ysvz+VU+81IkEGAvKYWQSUTWQHhCw9ioTlimwP6W09nq8/v4cSlwvyMfVP0cAc6A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(82740400003)(7416002)(36860700001)(83380400001)(47076005)(110136005)(26005)(316002)(40480700001)(54906003)(2906002)(478600001)(40460700003)(82310400005)(426003)(336012)(356005)(7636003)(186003)(2616005)(8936002)(36756003)(86362001)(41300700001)(70206006)(70586007)(8676002)(4326008)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:23:46.0810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bd10bb-3d08-49bb-4ba6-08da9baa9a55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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

