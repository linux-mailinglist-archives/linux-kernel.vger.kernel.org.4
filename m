Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB66B21F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCIKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCIKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:54 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC218B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhardJhDAsAc9EY2XkCWlrAfZe1LpGLR/NIgIOLpQjIWvNqxiI/TUOdkeTLPl+C/M5llNyuDZWOq3wHScsOSJKWhPRTK4wBajDoZNWS3l75drDuNxq8YxwYrcXHMXvIrj+BsjjwUHnD8pdLSW3e5AVS/3XFAKTLoMzhsUk142qDt+8fGWjtLPzhGKq+SQXVhx+jB2k9kSz6F0adJkGPP3HMP10yEA2uW79Zsnnq9Vzm1ps/nKiPAJDCVQ4WAfLdck39LCaF/6aLxVQd6dN2X3QsHM2w/mq5oTG8RsmExJQ9p6pqguUPMHzObS3R7V16n8mmqdXvgxGyYEXY7+P8pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n79L2CX87paRCe6UZUTXdwVr8iA8ZUEUlBJsOnbdWk=;
 b=m4DLIm7kpkWrdNI0sL3LZk9qCT7yK7CfyM3mmqidIhR9PT3kbbMc1wMwHN9pnuG1qPl0Lqk77T9DVSwGJlc1A027xnGItZ7jmrqIbbvupXZuJ54jsV+O2A19UFYR6avL+Rdu9XCmg9QCzUOY5wmt46fppFHHB/DsF07FX1++wZbzmC6wMVQzf7U6kuYU+d03flOAdPSh8AcA6tyrvXQouMelQxsMN2PgEzRoOV4zLT6QUN9z8jDgoL6afqeyELnKVUcpGwYMokvN/dx49pRczPzCosW3B1Nakb/8HXy67nY2VpNl9yxdX5A3wr40lF7cO+BOz+4EXIeCbh5CwvfvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n79L2CX87paRCe6UZUTXdwVr8iA8ZUEUlBJsOnbdWk=;
 b=o6mi//CpQkeV7PXElN6lsb8diyuB/LIg0V8vMluQ6VPpVEw3P7wDNiROU516PTQSGzNN5HiCRv64uUiJnuKSRY8LQj37xN4lziDK3XSzpZh6AEluxK/ehRigAdQK0bltTnQotiouRseYFzmpvVSeqF1F3hJFbIesQxLe6IPoOsX0/f1pLBcn6EzPhSDyrDiXAP5kRuvUqvidqWg5KA5o2k0kFPqLVp/TiAOObiNsjfABkUHhjBUZIjvnePDGCBSDRgf6muYlt4dMub0LCf8MQuv8tuH9/2DTrumGJk+o7qTRa+h7fI3IkGssqWRXYULOjkMWNnfW9mIvBjig4j9r6A==
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 10:54:47 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::b7) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Thu, 9 Mar 2023 10:54:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:37 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:36 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 05/14] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
Date:   Thu, 9 Mar 2023 02:53:41 -0800
Message-ID: <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: df00ed52-7200-42a6-deee-08db208cb2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGUHFIx8lNVzJbHhdgSOlnXiWRykm+XT+cQhZKFI9jbeooV0qoEsyJhIzyoqHRacTBXfKDFMjKt2FdhCM2TCw6uR9ZWOhUYPFbEX+uptCOA1z+8n1/fpjbJaBeJMq+SGs9c08tY5j1RkCjsJu+plC/1Si33VDU1BuWAMJhPM0UiKQAQu/t9WT1Awhgx/eFXV96rjCLem+qImiYnuQq+5MWVsqQGd36W1OtQu6ss2l1a7XpqUrslskR2Qh5efVDmzn8Tnamoakq7a8oqOirdf7pmmtZZRRub7d7KeoBt23I9t6n5pJLqa6AzhuNjJ/I/XscllvjbntlKIAMxZBuk59Yr2vZk6UCU1KDsbzwFgrFqq7yMMrZGhHx51LYCwIDyw5O8VtgjYAMVcVt2KGpaw9myVFgFvTmrUDJBYVEpiehOyV5k7tMxiyKmnom2dLWG6XyemFkbteMzLk3jD2/UOuHEsNy9qXlKVvobL2I5z/TNHsiiCwQGKtmcMh2uToyxL9egtoz683H4l/oWH0Dj36IXhRm2MA5qu6KiH1tWaQJQMkwrXjqXNzhse6iOo95SoO8cs4nmgY5lEV81ulIMrlmJAH6ELocjbuQHVi8DSJGVWezNkkv2tx9nGO5RzEJO/sijQIz3N0CNT9xdU2QDKsfEtCxxAc0iUqQ+8qmBhvyi5VG4/3p3HhbjLJL8wfBnwOQO0xo8o3Nv5LrdkcDhjM9JHM70ePMRsMP/acwJj24qa9Gsr3HfOlkukBb/B/u38
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(6666004)(70586007)(7696005)(70206006)(40480700001)(36756003)(7416002)(4326008)(41300700001)(356005)(7636003)(82740400003)(86362001)(478600001)(8936002)(36860700001)(8676002)(5660300002)(316002)(110136005)(54906003)(82310400005)(40460700003)(2906002)(426003)(83380400001)(47076005)(336012)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:46.9315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df00ed52-7200-42a6-deee-08db208cb2d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMUFD designs two iommu_domain pointers to represent two stages. The S1
iommu_domain (IOMMU_DOMAIN_NESTED type) represents the Context Descriptor
table in the user space. The S2 iommu_domain (IOMMU_DOMAIN_UNMANAGED type)
represents the translation table in the kernel, owned by a hypervisor.

So there comes to no use case of the ARM_SMMU_DOMAIN_NESTED. Drop it, and
use the type IOMMU_DOMAIN_NESTED instead.

Also drop the unused arm_smmu_enable_nesting(). One following patche will
configure the correct smmu_domain->stage.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c1aac695ae0d..c5616145e2a3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1279,7 +1279,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			s1_cfg = &smmu_domain->s1_cfg;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
 			s2_cfg = &smmu_domain->s2_cfg;
 			break;
 		default:
@@ -2220,7 +2219,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
-	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
 		ias = smmu->ias;
 		oas = smmu->oas;
@@ -2747,21 +2745,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
-static int arm_smmu_enable_nesting(struct iommu_domain *domain)
-{
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	int ret = 0;
-
-	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
-		ret = -EPERM;
-	else
-		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-	mutex_unlock(&smmu_domain->init_mutex);
-
-	return ret;
-}
-
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2890,7 +2873,6 @@ static struct iommu_ops arm_smmu_ops = {
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
-		.enable_nesting		= arm_smmu_enable_nesting,
 		.free			= arm_smmu_domain_free,
 	}
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ba2b4562f4b2..233bfc377267 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -704,7 +704,6 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
-	ARM_SMMU_DOMAIN_NESTED,
 	ARM_SMMU_DOMAIN_BYPASS,
 };
 
-- 
2.39.2

