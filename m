Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F426B21F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCIKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCIKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:55:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F85BAD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIzp3NGPHl+ag0Lb7tEvVpd/x+g9stHdzXvYQ4/AwCwerp+dmE59Lfsq9Lm54JyxGfixM00oB4iXvA+Z5SSxl2keHl4f5lyHZGMi096VXRbIXcjNWc6xJfr6XY4tVtoYyJXz53mgeEMiys89s4ajnvZLWhYi89NiD/RcVQVLmwG85CPGxZK29sSwYsE1yLncNIgfHefPbb4LXCTPz9Lv1d8xJpd2kTnFRvghw0AuhBcGGqMgMzuESqw1ln74hWVkeFC2BSSQSa3toK64IwzpLNC0BoITj/I866nSKHDS0ownu6MalaBUchZwviI3wyM3BEPLH1VRT7FhPTFdiB1Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZVXA4L9BTJ0E+4M8b1F5QLwtubB6Sh0NdsH8STRMr8=;
 b=OxfszRkm7qKyEukFDDLYVzTLph97XBQvIXGAE2hdkYj/kRI0LLIHGLvr6cX2Qrh/wzT54+9Tt6a+i6JoaybG7eQkyObLN+N8bFxQ7J+74sMXkcWdk2oJjIVhxpd1QJVBrnzWhySEchfbCBJTL7xwBYOevKXJmNy88L50fGZlt7guBaE8g/eGOdhPOcfiHveSEj5RAZwboXdaXVG57CVE8S3Li0uBmjR5zP6ZBgcOP01OAEiTkkn5BWpTON3ZqDsknmyr3ZRXTP031f7r8f66iHKGvSlL6NaxzVZcOOlD+zoIt/1faN5iXQ1mrtOXcGY+z17jSGgixM3e1CuPU30XHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZVXA4L9BTJ0E+4M8b1F5QLwtubB6Sh0NdsH8STRMr8=;
 b=EBzQXLRouFhbdPB/7sMthAy1u6OC1/ylb1jP6Tdt1V2BFYnR0BgNv81OAZkMAVxL+6tC1uN69e2MchGoKWoLrRt+LOayCxUcTUkt9LcCSCho9FnCIgLaaR7Gwvrb83iDY7ixtKgr1j54bEKkfa7CcYRmC7Ez5fF8Z6toiz5vTFg8feMQp6Wklyb7ThvCIi4DdBGRUzmHKBYMjSk46fBzR5f7x9AsDb2vMpvqQ9gJQ7FeIDxPKC6evwmvsD9G/BJubho9kMzq/JSc1d1HHyYHJoE6gtIz62174PhA3ADMMyOl1S36tLIAbP+lQYFW4RswQJ7jVD4SejXOxyyKsMGF9g==
Received: from BL1PR13CA0075.namprd13.prod.outlook.com (2603:10b6:208:2b8::20)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 10:54:52 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::29) by BL1PR13CA0075.outlook.office365.com
 (2603:10b6:208:2b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Thu, 9 Mar 2023 10:54:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:41 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 11/14] iommu/arm-smmu-v3: Add arm_smmu_domain_alloc_user
Date:   Thu, 9 Mar 2023 02:53:47 -0800
Message-ID: <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 753e7895-e0be-4266-bcd3-08db208cb5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2FPmZkq0+MOofBck0p2ZGL7tAgDXMSpmyCbI9rasYvCbwYgXB874UI7yMCR147hCdbXg6aC9ddCMdLczxh3dWJhnR30A84C01jX7DfmVha5bsaxxmiC24Jj1QchpHeXwZD474DMpLpSfuD3lwhgedIjfuk3NeIuPvOyBtHBB+O1TUmPfJI63wwz0YwMvRlQeRH0sHgyFaa+rFw+1RRtYfoJ9fO+E6D3mQoajMtK3sUZyF8PMCVMJr9Oxwi98NrBdmVNec5YxE9Gkp22mrDMNAVx9D3WaCcsOVRiIemBtcXcGJgN9OnuheW4IQCnX0qtukcPfW2I3WWW6DFqAlUDOLCSNR4fWzJAOKptBcWOGgaP8okyIN1/qlGT5OHnBGs+5sn5tZEAd381rQ+UqeydJ6lvgV6ZLG29U3ydwwZVIzLDt+5a+5XN5uoK+EAzl08ZdGoAI1Vtzysu4QchYC4CfbnBEmbovb0n3rnkI54QKkCxGFez0ogqMQvQuYfnrX8UMhin6V3vTjxjSipjhkSA9396F1TU4uIPblof0XguVoT+NG4targ2k8WMMwkmRbAoRb4P/iet8ZzAlb4eCXIr5Jt3Gub6vKLGH5qU1mew2GpwRbduutxzei95jRLCVRlysqpFkwm5pAwoGFf3+Lu0dzbYqOTD7oQ+6TcAXHYxvgEj7R816NjMf/8G/IJa2mYIIyubb/fJv+UWF/co9phK+Z8o76kP/d/J9IzZz4ISE6t46ZN1niOrs4iq7EMNwvMv
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(2906002)(7416002)(8936002)(5660300002)(336012)(47076005)(70586007)(41300700001)(426003)(86362001)(7696005)(316002)(70206006)(36756003)(40460700003)(110136005)(40480700001)(54906003)(8676002)(4326008)(83380400001)(7636003)(2616005)(186003)(26005)(36860700001)(356005)(82310400005)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:52.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753e7895-e0be-4266-bcd3-08db208cb5f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_smmu_domain_alloc_user callback function is used for userspace to
allocate iommu_domains, such as standalone stage-1 domain, nested stage-1
domain, and nested stage-2 domain. The input user_data is in the type of
struct iommu_hwpt_arm_smmuv3 that contains the configurations of a nested
stage-1 or a nested stage-2 iommu_domain. A NULL user_data will just opt
in a standalone stage-1 domain allocation.

Add a constitutive function __arm_smmu_domain_alloc to support that.

Since ops->domain_alloc_user has a valid dev pointer, the master pointer
is available when calling __arm_smmu_domain_alloc() in this case, meaning
that arm_smmu_domain_finalise() can be done at the allocation stage. This
allows IOMMUFD to initialize the hw_pagetable for the domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++-------
 1 file changed, 65 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2d29f7320570..5ff74edfbd68 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2053,36 +2053,6 @@ static void *arm_smmu_hw_info(struct device *dev, u32 *length)
 	return info;
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
-{
-	struct arm_smmu_domain *smmu_domain;
-
-	if (type == IOMMU_DOMAIN_SVA)
-		return arm_smmu_sva_domain_alloc();
-
-	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_DMA_FQ &&
-	    type != IOMMU_DOMAIN_IDENTITY)
-		return NULL;
-
-	/*
-	 * Allocate the domain and initialise some of its data structures.
-	 * We can't really do anything meaningful until we've added a
-	 * master.
-	 */
-	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
-	if (!smmu_domain)
-		return NULL;
-
-	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
-
-	return &smmu_domain->domain;
-}
-
 static struct iommu_domain *arm_smmu_get_unmanaged_domain(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
@@ -2893,10 +2863,75 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
+static struct iommu_domain *
+__arm_smmu_domain_alloc(unsigned type,
+			struct arm_smmu_domain *s2,
+			struct arm_smmu_master *master,
+			const struct iommu_hwpt_arm_smmuv3 *user_cfg)
+{
+	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain *domain;
+	int ret = 0;
+
+	if (type == IOMMU_DOMAIN_SVA)
+		return arm_smmu_sva_domain_alloc();
+
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_DMA_FQ &&
+	    type != IOMMU_DOMAIN_IDENTITY)
+		return NULL;
+
+	/*
+	 * Allocate the domain and initialise some of its data structures.
+	 * We can't really finalise the domain unless a master is given.
+	 */
+	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
+	if (!smmu_domain)
+		return NULL;
+	domain = &smmu_domain->domain;
+
+	domain->type = type;
+	domain->ops = arm_smmu_ops.default_domain_ops;
+
+	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->devices);
+	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+
+	if (master) {
+		smmu_domain->smmu = master->smmu;
+		ret = arm_smmu_domain_finalise(domain, master, user_cfg);
+		if (ret) {
+			kfree(smmu_domain);
+			return NULL;
+		}
+	}
+
+	return domain;
+}
+
+static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+{
+	return __arm_smmu_domain_alloc(type, NULL, NULL, NULL);
+}
+
+static struct iommu_domain *
+arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
+			   const void *user_data)
+{
+	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	unsigned type = IOMMU_DOMAIN_UNMANAGED;
+
+	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc		= arm_smmu_domain_alloc,
+	.domain_alloc_user	= arm_smmu_domain_alloc_user,
 	.get_unmanaged_domain	= arm_smmu_get_unmanaged_domain,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
-- 
2.39.2

