Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B86B21F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCIKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCIKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECFE8AAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCNpUEGVgeh54aVvaPkVKnhYswAmIQV4YhPOO1tMEvo/AOCve7cMdccGwReB73VYV3jSZYHDBAwfq47HBsQd5YXZwWxn4ogJ0OibLf6oO3uwJPSGo3gTkOO0JCc6sIA1KaHrMNECHIuWzvReZK9QeJW3mWT+PMiyI1wSjievPefdh46Go8JNcjbyv7ZYLYkwha9Ye9dVk1wni8s7kljQy+feh1Ck+/i5rStl4sgHjbRbUc5hHeR3lpP849HhLBye5KPGKmCYe2JCbJk116kO0En7IXiWmiGOndVGk2SwX0DwD2qWOhrFuCQqFNiNn84hGCsZ1S+4hzpME31C2s0dXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APls1b12/0qHWZdaJX+Nl4MRhtKgoUW4jTruISisK5Y=;
 b=UvDEOh/CO8o9m0WDeH4NPfb52dHDTIQnRFVZ71gCkgTmIMthLbsl/6ChLCY/F1aYkfIQKC4CuQ+igf9aNcNVXMQXS4XlKuNgkck91WNqEeedBFw/RI0aD4hN63Diu96TSe93HWiCLvaVj7ouQgYgpEEEMV1+bEhF8Z6tUfjmdjop8GUZkIBj7J5v5TwqOleDKlTxkyIMJzMdHq9DLxHMv8Me80Beu07OL9GMVlZfpzal8hAuscm+YfFA/JRsjC7XYU/5+G6MJHa1K0fH9yOMGRR3VNGR21Kl1LmdleF4D0/TnKArGeL9H9LC7nzxejuCM1aj315ltpXB8sNuV/9JBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APls1b12/0qHWZdaJX+Nl4MRhtKgoUW4jTruISisK5Y=;
 b=Nczxip5cVnFczXQW7X5BazMX3cmDR0pJRKDj25b4q1vXnHIZZkEwTevubxd+lJ9D7/TyRuok5qF2CjK3Ce/VYldbKfh+KH9v0NmARj52Nkw06HVrX/+3IKJDrb1nf8tGZOsftMXFcz3JctRiIiufoeQgdf0huRZ2ychnn/FtLklnqeUsiQBH/Nb/7j1ceDh3FTfMNmEF8RXCfq6zNVzL3KMppKiPY7gcMU1oIc5FLqlkGiYUFvUqMJ/QI08FU+ucaBVRZG6adeoQLcKIV8/U6OV6QanQFzXbQhB0+OIFhUxBmaeoZfybkdP5Qi6uL6BjzIL3/AoPxBe3m7NYXykZqw==
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 10:54:48 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::86) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 10:54:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:36 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:35 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Date:   Thu, 9 Mar 2023 02:53:40 -0800
Message-ID: <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: e1751a30-cbd3-47a0-88a6-08db208cb295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yWS7+madUSpXEfIXUPKsS1D8jk1BRxg89LUvsg7Z2MnElN7yatYnHkKsfwdktT/qdb1EdoYZOCt/UOePpSVg7vPt+ZYuOSnb72oVQVS+wG8ZfCsesG06HukSAm9HpW2SJekFxCdSUQ01TYYnCNvDUSk5ahWWa31pC2Fi2aLR8o5lmXwQjSywaFK3gbgQXuXoc0JNYe7JvTWq263NAudDqZGOH8O2qhz3+xUC8JlMBNSABtNTnUt8J6wh5DPDjX+ykqWw4DfDAD2o3JO3aLlaI17/I6aOt2L4f3J5p/eTWKVbCNbFP4P4jkw870YvF/KowF7qAVeBXCzMvGHGSYmheDryvHWAN2P/T+tU1HENEjcFVJyQJGTNOQahGrshMaQ8YeW6tcTExx0eLhISgUIKsf94L8cIX+G7mCcN/AppHD61GdoxGk8U9tIaztZcajB3vvgVZc4TBTvzY/+QkJOSi7mVFWhkqgCpq8eTeQb4aN77PPsbf5XVC/SkvLe0Vxt9WtOp79QhU4rAhzPQ0+7voyYS0cQ4jGGZsURfjypJ1wwCSMb6GCnEBt1dYwj9d6w0ybw5l/9pJ+xDoAgo3R5J9w/dXBmGAkBDmyOrTUbIZts2696Nkh6iMSAUgOyhTLaiFf9lM0edErzCH0Ivh9vXknBFTiXAWxTRTR2zQzyuvfE/kOyddl8arhtuR0z+ff+7OfRofCJWl7XpHpGsRiLsM1Wo/DNgDRa+RcJH35OThi5N2TtaR3MOHr0eypcF0YA
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(54906003)(316002)(110136005)(478600001)(5660300002)(7696005)(7416002)(2906002)(8676002)(70586007)(70206006)(8936002)(4326008)(41300700001)(36860700001)(7636003)(82740400003)(26005)(356005)(40480700001)(86362001)(6666004)(2616005)(186003)(82310400005)(336012)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:46.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1751a30-cbd3-47a0-88a6-08db208cb295
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to forward the host IDR values to the user space, so the
hypervisor and the guest VM can learn about the underlying hardware's
capabilities.

Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
corresponding type sanity in the core.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 include/uapi/linux/iommufd.h                | 14 ++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..c1aac695ae0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static void *arm_smmu_hw_info(struct device *dev, u32 *length)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct iommu_hw_info_smmuv3 *info;
+	void *base_idr;
+	int i;
+
+	if (!master || !master->smmu)
+		return ERR_PTR(-ENODEV);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	base_idr = master->smmu->base + ARM_SMMU_IDR0;
+	for (i = 0; i <= 5; i++)
+		info->idr[i] = readl_relaxed(base_idr + 0x4 * i);
+
+	*length = sizeof(*info);
+
+	return info;
+}
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2845,6 +2868,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
+	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
@@ -2857,6 +2881,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.driver_type		= IOMMU_HW_INFO_TYPE_ARM_SMMUV3,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8d772ea8a583..ba2b4562f4b2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,8 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+#include <uapi/linux/iommufd.h>
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0d5551b1b2be..c7a37915b49c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -519,6 +519,20 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_smmuv3 - ARM SMMUv3 device info
+ *
+ * @flags: Must be set to 0
+ * @__reserved: Must be 0
+ * @idr: Implemented features for the SMMU Non-secure programming interface.
+ *       Please refer to the chapters from 6.3.1 to 6.3.6 in the SMMUv3 Spec.
+ */
+struct iommu_hw_info_smmuv3 {
+	__u32 flags;
+	__u32 __reserved;
+	__u32 idr[6];
+};
+
 /**
  * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
  * @size: sizeof(struct iommu_hw_info)
-- 
2.39.2

