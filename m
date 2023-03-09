Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133DA6B21ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCIKy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCIKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:47 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45DE8431
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjSfRz5VzoQxDXVAM87C0Nhmm87t6a9HS/KUrt3qdjqLiHoLhDHicMinoHpRmHIs3bhYWCGuQ2xfBWDtqka2VUVjQsYPVyNWiF0VV4S70Wk5wxQXk8YeB30oyZ7q5yGV3EYvD55kJsfw6haO4PTvMZIIHVVMxLy1Z1GIOLgYIOu+AXwRmDbAaI+DMS894ICkj3IlBRCQ37Y+f44P3G1ItuRBFZeP5QoxLIeNOWU9sHz2gy6MFpgArcA90jiluJzShIhlMIRD08upQOnpNHHEqcuh33HOlkURAMvacSNJAcp6oKudk3mgAwJasT5ZPvKOoWKD9oOVwT8WBPpIZZxIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBbsr844qhGdT77+34PYYP8eNcCA1ykLIVeWfrAaWZ0=;
 b=I+2vD4rsrKfqC32xcFpDVFCjNqcmrm4Yi4ezThCsaoscrAhMlDEEkS+B5VNfqoYQpHs15Mt03qqzNtUF329u6GeDoXQ6H+f1AO4RGS0zBggPcklx+M5KBTesfyUE8sCbtB4ZqQ6OMUpl0+AChvZ6yiRrpyXVtXumGRfkMzk9oDhWpPA8Jks8ZS3vQWLyGwuZVNSxiABXUXPrzX7JCkC7IQAbrXb+UJ8O3IGgf9aLdGtWLOQpEgX4KIHwpg6k1sahvoHxIU+vwsfIOc58AVNeLNCeDzYKAWcBhwktc78qx9xujWR+W6TioJ0k31Sl5qAzLbXqPdpJa7TL7xDHHkAg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBbsr844qhGdT77+34PYYP8eNcCA1ykLIVeWfrAaWZ0=;
 b=WSUnrsbpU/KqeYieqJxczB+UZkiT9Ras//V+SALQLretI/T45/gQJI7mvemRdcuTCLS7oclqpmWspMiHOvEIASLozglMweedP+WlVf71+TBdmPfQiqpnY2c12DIP9/BIOVMVzIdV1CwbCo7C6pgasHY2dvlKcxE4EwotOUkScp4kI1wgLyrXSsoa6tQ6RUKtcc/u6gTLGzR02csZ6W8nMlHIjDYrBzNsGJJ+pvIPcfVBM+esZxI1CZ1XEq1GD1Jw1jNJ6BknjSicZ7zRrWuDHh8sz9El59ywUVj0WcuBur3zvOGCSNhug0Gw/zvdasJVrMkTWeBYaRFK2PsHpuImPw==
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:42 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::70) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 10:54:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:33 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Date:   Thu, 9 Mar 2023 02:53:37 -0800
Message-ID: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|CH0PR12MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d3ea8f-7eb0-491f-397a-08db208cafdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yk84aD8Dv/eDWYMltwGPtGgg8kPBtET+w0WBdpof+Kzh4yExMsc5VXZQLlF61rgP/cdhaQ7vG4NnUpnNSK+SQEBMuAEGd9kOgjujm3Dti9P4M5mH7mVGMZy0ItvJTRnSDA28mHADah+0rMTi3+M+184bj6ZIJ3gkVgl/1qJDbtAmmCUQjS9vuIBnNTv8v+QBq7q9G+U1NdU+4iFiMIQqdbwLFiIavZR93zaN7yu6ixdm6dVEJqqMumQT6/PWMC6Oj7I9ILNC6LEm+t2N1sAILNrsaD3iKsh/8RRqhwaufJOqnnVo3OASAweim4evFzsDOE5SUgFsm706fJQhkgAx3+1tQcMFnSKJ83ZVVLXcqaqjCtG2/zBnHdo5cOryApwX68uNq4U5YIoudyTA7HxPSo4bHb+/AIgypNPFJ7KWwymubwvDufukSgMEpNMcsSdegBhZ2S8p2CjE2pn6zWOsOq8gUOXfcMGJ5+AK0vezsY12kO3Gvzo9j0h7JrFtCCfQ4nOmjDKz1N7/H+0Axp7zZIoQfy0d50wCfuLMP+sDOl1XNR4Oto3T5Qe4NUO7zft49KD0ZkwXMr5cMLkeoJRj95/GR+oBkGzd5e/G6C3PakkadLBtFrWK7vha/rXnMasLceN6zWj6yYOlOWdoLpPaAYfJE+vcq2h+APdKvPSLHdZk1CEwImxRgsiDQsA4UU/M5eDYyL9GEmGHvnWer8SRyhbzq9unMnQgLXagzOja9QAb/FwX/utnSdxsveYWzQRX
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(82740400003)(36860700001)(83380400001)(426003)(47076005)(36756003)(478600001)(40480700001)(54906003)(110136005)(7636003)(356005)(316002)(336012)(7696005)(2616005)(40460700003)(186003)(26005)(7416002)(5660300002)(70206006)(70586007)(41300700001)(8936002)(4326008)(2906002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:41.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d3ea8f-7eb0-491f-397a-08db208cafdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nature of ITS virtualization on ARM is done via hypercalls, so kernel
handles all IOVA mappings for the MSI doorbell in iommu_dma_prepare_msi()
and iommu_dma_compose_msi_msg(). The current virtualization solution with
a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
guest-level IO page table via a RMR region in guest-level IORT, aligning
with an IOVA region that's predefined and mapped in the host kernel:

  [stage-2 host level]
  #define MSI_IOVA_BASE		0x8000000
  #define MSI_IOVA_LENGTH	0x100000
  ...
  iommu_get_msi_cookie():
	cookie->msi_iova = MSI_IOVA_BASE;
  ...
  iommu_dma_prepare_msi(its_pa):
	domain = iommu_get_domain_for_dev(dev);
	iommu_dma_get_msi_page(its_pa, domain):
		cookie = domain->iova_cookie;
		iova = iommu_dma_alloc_iova():
			return cookie->msi_iova - size;
		iommu_map(iova, its_pa, ...);

  [stage-1 guest level]
  // Define in IORT a RMR [MSI_IOVA_BASE, MSI_IOVA_LENGTH]
  ...
  iommu_create_device_direct_mappings():
	iommu_map(iova=MSI_IOVA_BASE, pa=MSI_IOVA_BASE, len=MSI_IOVA_LENGTH);

This solution calling iommu_get_domain_for_dev() needs the device to get
attached to a host-level iommu_domain that has the msi_cookie.

On the other hand, IOMMUFD designs two iommu_domain objects to represent
the two stages: a stage-1 domain (IOMMU_DOMAIN_NESTED type) and a stage-2
domain (IOMMU_DOMAIN_UNMANAGED type). In this design, the device will be
attached to the stage-1 domain representing a guest-level IO page table,
or a Context Descriptor Table in SMMU's term.

This is obviously a mismatch, as the iommu_get_domain_for_dev() does not
return the correct domain pointer in iommu_dma_prepare_msi().

Add an iommu_get_unmanaged_domain helper to allow drivers to return the
correct IOMMU_DOMAIN_UNMANAGED iommu_domain having the IOVA mappings for
the msi_cookie. Keep it in the iommu-priv header for internal use only.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c  |  5 +++--
 drivers/iommu/iommu-priv.h | 15 +++++++++++++++
 include/linux/iommu.h      |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99b2646cb5c7..6b0409d0ff85 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 
 #include "dma-iommu.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -1652,7 +1653,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1685,7 +1686,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
 	const struct iommu_dma_msi_page *msi_page;
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index a6e694f59f64..da8044da9ad8 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -15,6 +15,21 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
+static inline struct iommu_domain *iommu_get_unmanaged_domain(struct device *dev)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev)
+		goto attached_domain;
+
+	ops = dev_iommu_ops(dev);
+	if (ops->get_unmanaged_domain)
+		return ops->get_unmanaged_domain(dev);
+
+attached_domain:
+	return iommu_get_domain_for_dev(dev);
+}
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 080278c8154d..76c65cc4fc15 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -275,6 +275,8 @@ struct iommu_ops {
 						  struct iommu_domain *parent,
 						  const void *user_data);
 
+	struct iommu_domain *(*get_unmanaged_domain)(struct device *dev);
+
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
-- 
2.39.2

