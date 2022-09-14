Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCF5B80A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiINFPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiINFP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5E3341B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ykX0VvmrGSYGpGmBx8an8TF9UGKD2gjdl/kxjiP2Gmika+NZTs9cXzUovI/G74u6HDnkoiOg9b5Nm+ApVxUZRMmSdfLYxlTi/lqmsGEQl9IFoN0Jhd900Kqbj4aQy1bKY6I5HrqhaaO1MYlb4R5W7GDgwo7URJblslOzwAb7ADXVnwlyZlwN1EnEQlT53Ahtzor2PmmrspUt2BoBxMV5Qniv8TjxPAPGQWMTBs8C2jczyaAJyoWmkq12z1T81RTFUtgmpUpMqXy9dDnIYRW3MjnHBTXFEEg0EmmK+MWmOIP6rQGD6sKGU4VeUrnpNl2rzfJsPRWcKVPTt8cAmVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phH0P3nL5bp3YNkMzKf5viBr9Vxo5qa8MAB2LQCJP6M=;
 b=bWc2JY6Xu417SVZUMSROKyCMcym7LH0duQagTotYYeWwnE4XcMBRdxHNrsUsNEJpSZnVXrynSVEyHqMz4k3kUTF4syDvn4yaMdUWBw6PnXenKROaAo/HcOyE9nKVJbS+SRmbEC2N7uzdh+Pu8pcLJjoNmKu7VN/T+JbhtnEb/9Ey5HysGVq3W0dV27n9h13sajb3VfulEIayt6bvwEWEj3u+vPBvE14qIjlNgS7bV8oMGlLWb12pmbsjObnNx0iLI6vd48MC8bNXfS5QwfAFe49MWciLo7aJKEEWHvZqzI90XCZ1VbMDIA9n8yJ6OT886IaqWtAJMQcHkypclyrPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phH0P3nL5bp3YNkMzKf5viBr9Vxo5qa8MAB2LQCJP6M=;
 b=UnjM10iXqDCTkExx4pVVVWWsMFsqUDaiLIKNi/zp7JNeYqKNFqwYzvgCesYc11IQ/NadXHFJK1+dEvkDRijCOno3oZ6F12VAglYioYd/4kLzFUyiZJXRWbm+ofe0gIrpMfcsdn8GhWuLwYZJZstDp6jKQiUp/kECHhuKOsVDHysJCp52EC+IVy3y8QehguN7tIaUg2y1mxkFsbo/zb3HMY5YYx71j43ndVbsh0zpCm7w3YJHZx4yDwJ72MOBBXSLPW7r0mJIScWwAk1Dx+O59j0IrnP/wA89Nlq+oC8Pe78EoDm4jbB91FBGcuENiwh2ictrN3AqAqdPk2/4Lz+lKw==
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:20 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::88) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/13] iommu/fsl: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:01 -0700
Message-ID: <20220914051503.10348-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 545367b1-4cd8-4582-bbc6-08da96101e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F9Ks9I7zwn8H9MUq7krVRAMHv137Sawpnn5CVW/Ci5VFdaGeRQA/ygs85w4QL3Mydf/UauK7BPFBEfc0NkBAX7hPXc26c0EinWmDwkLdHzhHuWBwT9fknf7BCzIpynpRRuy43p6e24J/n3M6tIx9o9ZcjJD7x0p3/hA8+B+96QuelHrDS5xQhW/y8Ya1L00EUw58K66tiTC7RKAWPRbJag72dgG2KJQOmdIFJUjt32muQFRSfc0Ug08wqm6nW6jAxbgdBmx3d+9IgQCVxKjShbxhi4BSwUhu0Qgi98kkaQ6NI5sjbVU+BvRc3pYCp7ZQpeu6bY4o9GsTQSLFXJFRGt9FL/6Vzoq6bneAkmk8kYUGnDaVgmsjICgtJ3rRyeOiyGxjE6kdE1SG0Zf1uxVdTuOQrBIAZq3c8OpGs7+12U5VCKgBl8YLAJVdrNgZcbK1IGCu2fAyVZGncNM0lVdJRTWAA3EV0ew5kCJiLtoDV8MyRYLAVk9ZoOCFWNIEIxr5XrWSu36aFtc//G7noQhY3h1Tibi4k4no9tKiCWjkyF3dnd/0jbKKqKOrWyVPD/9UwvgFggTezV3ziVmzQVJvdMsEQJGhf9C9K2VfqgdfKnPmvbjocNgDStJpXa3Z9zaQEF93k5A7Nc8+OCUtQeYO/BytMmThOr4ySyjEhz3oworlDmkG1R+0cwMOYzaXFsEzH2aVHcF0dg30ARJ2c/wNgZlsZf0utdSer+y71l9FMWd4qa0Vk8ihhNZ6aq8cp/VnQtrq6xNwgqyRf0RbATPGw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(4326008)(82740400003)(2616005)(83380400001)(40480700001)(2906002)(47076005)(41300700001)(26005)(478600001)(316002)(8936002)(36860700001)(356005)(5660300002)(7696005)(70206006)(86362001)(82310400005)(36756003)(8676002)(7636003)(40460700003)(110136005)(186003)(70586007)(1076003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:20.0014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545367b1-4cd8-4582-bbc6-08da96101e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure attach_dev() callback functions only return errno values expected
from the attach_dev() op. In particular, only return -EINVAL when we are
sure that the device is incompatible with the domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/fsl_pamu_domain.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 011f9ab7f743..a391ac733b5e 100644
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
@@ -267,17 +267,21 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 		if (liodn[i] >= PAACE_NUMBER_ENTRIES) {
 			pr_debug("Invalid liodn %d, attach device failed for %pOF\n",
 				 liodn[i], dev->of_node);
-			ret = -EINVAL;
+			ret = -ENODEV;
 			break;
 		}
 
 		attach_device(dma_domain, liodn[i], dev);
 		ret = pamu_set_liodn(dma_domain, dev, liodn[i]);
-		if (ret)
+		if (ret) {
+			ret = -ENODEV;
 			break;
+		}
 		ret = pamu_enable_liodn(liodn[i]);
-		if (ret)
+		if (ret) {
+			ret = -ENODEV;
 			break;
+		}
 	}
 	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
 	return ret;
-- 
2.17.1

