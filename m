Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D85B95CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIOH6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:58:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DEB97500
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFQlOQTUTrR81Zw3GprDQtkNlilBZx6MoVoYHQW794bCOx0b6eBEccHOq2kG7VWxcn3S2a6x2FqkPHKk1fZcTjhEahbzx/lPN82P5Ionblnld7bV2oDBjsJIvhQ0p4ozJdz80KKBRXzXRJ74PmZTXgoYySbmoc227Af4V1oVBvqUu5AV64rsDwmprz+gNghCD3surMRbh6VJ+KjHPL7Nj6mItYSzQVoxwVEeiOoq1/Gqi4RBRMOHOGTN6595gFyoXh6fw7nV8w+fjwQWgdZlNRDBn2+Z0LEIEp3P69RJoDkD4b1lVvKynXgbmbnsBDvmZ2SnWolONBSistCpsYVxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJfH8Poz1xtRvTXzuGTECwbGRWb45/l3U0wob21yavM=;
 b=jeRFJtMX6e/wQnPH15mCZwIgN01phSNHxvzVAXpaDL8D2i2bchYDxft2fC+mml39CyQoBwoM4ST03NidbZYBiVk7uM2YDXyLCdwPwFoEFVDIqi1zH5HisvpLzGE8HDzvmgyGspjZOzu5zzFm8jxkjMUgCz5Apnzr/e05CbBhBQxjwqL5p6W3iMqx9iBbR9Hly26v7lIMeriiq7GT2VSVqGQaqbWWZYOkMJ5QFrCG5Ey27zUXSYT2k5F2uGOKzTtH9EZsij506skWgYNg3sYpUhkI68qEjHy8tYabWdmWcbrlDa5MfNS7cbivJsGzA2r9R72q2SZ/zQTrTvmZ2Rb6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJfH8Poz1xtRvTXzuGTECwbGRWb45/l3U0wob21yavM=;
 b=s1B/JCBsqk+U0NCUL7vUHbcUv/WZuE7q2RtoehUsh0FuYoNf8OLmcMN4GGTzt/8pc2m7bW8z8MM0kJOYpHZCkk0/6JPL0NxeCjyff72d3D7adM04T4QRYtTVXFMV2IR29uf33Ic6q3nGbn8/SJ8GDEXudoabk0YXdZUhmBRulA7i+mybM6XlvbdQ7Xs3SuH7oyiE/7kntLyhu+09RepVjE1ZkjRdTHogBE3PeGhDYrqjc2VmMTAWOGa7xugJLkCHQ8qsmffneHac3L8XIpcUqWPlwjkBLgwKjXpMQ4bamUXm2QaMFJXyHsLNhYgx9ccaVpg01sYrpJTiuhl9I5BJUA==
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 07:58:35 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::73) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Thu, 15 Sep 2022 07:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:58:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:58:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:58:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:58:32 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/6] iommu: Regulate EINVAL in ->attach_dev callback functions
Date:   Thu, 15 Sep 2022 00:58:30 -0700
Message-ID: <253f8098664f78f5b5a8a7deb816af8ad7d37122.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663227492.git.nicolinc@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: b77d1d42-8eb2-445b-92fb-08da96f01730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SocX25x3lEs0ANA1D6LG8TP80pT/632jY9XCgd19NMhnwZNcGJFvrXugJfdM8Oqzm/37uXhofz/ZJTsY4DLjwPcfnsEf/UascJIsEzMO5WGbK3/RABLKm2ZxkG/kh8V6LiJu/YH9hjDkPg8U4ZgUerc8tU7/g9z73Ag97LjYT+4A08/KltXHnv0dO30Yib/ohN7Ac5YZOLa8ziPIN5ukZ3CGP71xs3ZtyL4cuqW+q65M0go33+9B5ujKaFtqXnFmHFGQvr7t3jjxEjR+neMxguVJu+AEtNPoKNeWBc1z8s9fHyIVFefAPio8qOYgR+oANVrSJBKHMmG1lt2FvBzW2SZbC2Xw3PI86qme9c14q9PXVgCbmX9X7jLMTr5Cug+SlIPXPZm5U2cexX1iC+bn5TZW5ZoGr/+S6qh1yzwe64qdlzAkeYCgmmDcoVWhjnB/QDPQO0HWI1xKdfDYkS0hbAPZEtQJp1B/G8anqUZ8ZB1lWqsTCM+MxLvc6TULx3K6+my5vekAAHKtlNzulMGu09zeTlYjP7IfapgDxWkKpdOSk7ayqAWRfqYwQj4jmz68uiBSQZ0K0hl291gBz5DUskhmZMsxnUBRfn7YoX4OjoXI2p435Su4LrsX/k52r3mUbjeG5QEiyiNgIFrSmba2AaAZK+eX8Y8avIK4MBAubWTEcKATd4Jn/5LbBpwNCZNRhjArjMe0ox4s5Y2IJ4hhDIQ409pLzGZy4Yg6deN9TyJTVu7AnkC7716tT9SUhpYx1akdS+f2e/dEIAH1G3DJkQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(7696005)(186003)(41300700001)(336012)(2616005)(82740400003)(26005)(36756003)(54906003)(110136005)(83380400001)(426003)(478600001)(40460700003)(47076005)(82310400005)(40480700001)(36860700001)(86362001)(8936002)(356005)(4326008)(70206006)(8676002)(70586007)(7636003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:58:35.0317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77d1d42-8eb2-445b-92fb-08da96f01730
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 5 files changed, 10 insertions(+), 8 deletions(-)

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
index c5e7e8b020a5..4cadbd744b7f 100644
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
+		return -EBUSY;
 
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
-- 
2.17.1

