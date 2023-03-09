Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BD6B21F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCIKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCIKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:55:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB3E8CCD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDTNhIw6PFhnVmUmfnuvzvX7Nj8NxV48mR+xYUAznTkinpsei+sIyt61KA5ny60YItMobwisW2xa7/x6R0f4B4hvIFtiw5RFCnpuYHh3iBS9qxIQ4FOmPQbRM9PyrUKh/EPRihicct3C3oH3A21s8vdM0fJOmBsTaQQCWCyrxVdZSBwcFAZdnoiS3pfnSZIB5YGJwk7D+9dWQ9Uyf6xKikqZrTuI5bkGFmuL6cSmPmsdoyIVewGMOWR6orB0snIW8lUPAlKPik9uUzFoRAF8+bfbxCsLD3RCBf/eOuyacPT68Dv+hoQkFaLqFzrtlxmZ485QSmK/55WgzmmSqriaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu2hNAgMKUWJWkJKPV/u8sJ3QMgIzwQ7mZzx+VX3FjM=;
 b=CqaGTSGw7/t8G3IoP601v8NuzLw4GsyuI1ACgc267y5xXdwTp8bwj0foc293sNqTAbiYy3X1LhUCZYTzxQqm3EkMMfRUqNjfMoVfj6x4tF/+PzX7sqlHT2xxv1bneeWOLCv/Foto3hvd2G/RFn9NGdMVMXvUOBEUG5zMvudmZdhiPSed+kDd80iLXFs7nWyS0Yvn3llnwYXr7k4byNjBHUrQKqhmwn04fhc+so1B/S4Oqbcm74HxbTDFUlJ/1mTIYjJif9WPzA2jZiNYBcNnV4DRUsWY9Y3aUR5N8nZX40PpW49bfRC7VpyUHJqFxtRZsPo4XsboipN26RtD9+PH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu2hNAgMKUWJWkJKPV/u8sJ3QMgIzwQ7mZzx+VX3FjM=;
 b=NmXYk98QBrBh9bWMXFV26mGCZ/jRZoACEZRE6Xx3P3h81P5BzwMT0cyMcFBbtDJPA2vxvP+1SvDToXoZogS4wZ4z2gcsfu+j9EpgrF46yLTAd8W6mdyWa5QvNvpws1D2AzzftX0X0pfQ6M2+VTDcRZoEaNbQ47pLgV5npRPl6zSHnxCZyEgUqtcsnITmneJ08YBglaGoZrl6YmopTepifFNBcvkhrqbhvtHexw1bd/rb9HQG0O4HHEJ0MXjN5uYldYu+2gZkSirErMX5TwAJsNhySXItQij77iqSfS4QePLIgXptWDLRhbAz6EPbdSmCQJo3bhBLNtPgLJL9EFe9sw==
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 10:54:54 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::25) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Thu, 9 Mar 2023 10:54:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:40 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/14] iommu/arm-smmu-v3: Pass in user_cfg to arm_smmu_domain_finalise
Date:   Thu, 9 Mar 2023 02:53:46 -0800
Message-ID: <118863752be19884bfe9c2f7384f9ad19a1c2083.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cdb2f8-ec02-4917-2953-08db208cb6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yChfbPS2e+FBgyjNUxLqFnlDC4iPzyZH2jdhvVTIMNsJ4bDL9i+OSD+f5dSBwFp7XIfzkPum2wCU0e+U2zzY0S7JbAEckKuI6NLJYqhzUXDffcy1IC3sFtn6+yZJahE92HcFXJARL9pL9WZpSP6wM8kesC99DRh5V2IMhGxJ9dUnMMzqv+t/UVNf8q+I5fLKeWdeH7kwmMI01Gd/qtrFQOQfw06lVeis0Jv3hb72LFcWSNxctOYWLTb98EpcLsehqdsvdf9hcBD6u9rvNOuwQMNjqrYCLcW9XWdBhquOh/BnIWeZ0C9TfIcbCaWaIUsCkLVju1wuJOHdmJroc1ogMUlW/H56IM5HLYC1TULQJiq+rqzSdliXJD69Z6y1cVo9cIfpCASk4bssyqQvU6U6QbLbhEC2aXJVF9FPdsGrxJS8n0EOn5ev4OL05p5UgJSgancmNX9Wa5asWSPsLWnubaDp6EyWeHoME6iwZGhMgjiuKdIEtBCPzZkY5tDA6Isv5yBDJDZdR347PVjj69f78RQsR/I/0xT4DjR9wnU9bckf/p2shlfme++2V/YlhQrByKdD6GHAuF/wGq/dhfuEOMOZHQMwA8tq2EKvypX6c8HqbvJctIdqt96QQJ6QrZ+CBM/LCnxcM71NQ6wBM76LokpeHnDQcva+NKzOyarNp6ZLe6/n5VrH9P4PYl21eUqVDGURwyYEjngzqi+MiVt3LUCGYpo3S9EXpTRFBSzyrF8baqbUGii1mehcPkR9kUk/
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(70586007)(70206006)(36860700001)(316002)(47076005)(41300700001)(83380400001)(8676002)(4326008)(426003)(7636003)(36756003)(54906003)(110136005)(336012)(82740400003)(2906002)(356005)(5660300002)(40460700003)(2616005)(7416002)(478600001)(7696005)(82310400005)(8936002)(186003)(86362001)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:53.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cdb2f8-ec02-4917-2953-08db208cb6ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct iommu_hwpt_arm_smmuv3 contains the userspace Stream Table Entry
info (for ARM_SMMU_DOMAIN_S1) and an "S2" flag (for ARM_SMMU_DOMAIN_S2).

Pass in a valid user_cfg pointer, so arm_smmu_domain_finalise() can handle
both types of user domain finalizations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 18ab5d516cf2..2d29f7320570 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <uapi/linux/iommufd.h>
 
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
@@ -2223,7 +2224,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+				    struct arm_smmu_master *master,
+				    const struct iommu_hwpt_arm_smmuv3 *user_cfg)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2235,12 +2237,18 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	bool user_cfg_s2 = user_cfg && (user_cfg->flags & IOMMU_SMMUV3_FLAG_S2);
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
 		return 0;
 	}
 
+	if (user_cfg_s2 && !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		return -EINVAL;
+	if (user_cfg_s2)
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
@@ -2484,7 +2492,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain, master, NULL);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
-- 
2.39.2

