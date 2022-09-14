Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B75B80A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiINFPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiINFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F21A398
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rubm/F1dRMFmhjqDM13rxu5aH4XCUCeLQaAz5qB+i9/shjZCHrjYpN9XTuhcbAce5HHvDuXePpJIpMqj1YFQzd/DOa0fddKLi89xjFkM/teVi/gurgQjvdtO8ybFlPs2BoLRexiKY2O1Xnd710BiHAUVEVb7AG/WQOoVJoe5lKqr8USs0q+mSNKU/rJPWPqiR/5IHLa8qiPLgw6Ra0C3qZPbs0FB1v7OQTjf8FTCoddDB9FJK/ffYp/q7oOrmuzazMw20K7OM41GxPHNzvAoX/KJ0KVDRqgp2YM/dt6NUk6RcHX4OHiJGR2NmKzrsCUM6UixwDbg+XYRPwpK5KtYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsxEJK7z38CdL6mDy4FyT2UUv4L1+9wadUkpAg14zQA=;
 b=bEsAU67JsULe3K++uRilSJbouNN2sObIqaanDHIu2NpmZHeqsDvl2WpWVPebVxVJ89pmAY2Fmhy39xIgYCJysenrhsFOc+2Rb9ylfmnNnl8c+apNBLZCudr3EC6Cu0Ngj9OHdcxaa+RkwhI5AKgMkFOj5qaNbmNNfCfJxCXcocQ8X1RjRqE6ZYav1kCuiG575OKLg4vj+0HE97S40+6tKphi5qlMBA2JkM0h9ZmoRYgMrjgggn5t9iS+zmsMmYeucaLRlTjHE/pF2xwjrdCayJLkRkb6X4ya6prrI5WVmdr2LNo0B7YVKFiH2DaPaPv3eOZvBhN0FKtYa3PR9L+Xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxEJK7z38CdL6mDy4FyT2UUv4L1+9wadUkpAg14zQA=;
 b=OVnqPgIhGAuWMW+9YxOxj0O7hNOVBy0PcfVdKMECKdw8Y4QYGFPtJmlU+QzPBPOTrvfM4DNvGHi83N6r32W3BaMvtnRkehHpywDhVx32U0TvYCMctPh5+Piq54DIcNlc0GRIOwhUOJ8ApJUvT58o/rrYdMF0CtcRHKALel4coP3z14mTy5xDGZJVEVGqWMccrwPnLppvohwLRdTgVMO8LXk8yv7gTDkxjUXRNsjKlTmyzpE4VINSC+04EkoDTOtF2miznWGMI9QVSfq1AW7yAejyhvzzp7wUdKL/E8yKqAR4EU8Me0Eze9kcMWCPfmX9QB2lUPL5itHSTrOTNGeFAA==
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 05:15:09 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::e4) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:14:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 22:14:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:14:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/13] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Tue, 13 Sep 2022 22:14:51 -0700
Message-ID: <20220914051451.10304-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL1PR12MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 697bac2c-5027-4c8f-03ff-08da961017d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHCte5uZ4FWPFpr2ymWzyvnbDwBcd70Em2u6FFWuOjU8uUks5UL9NBeBdwQzenmkC8q0lHZoOtHyzJk37ZVBtgfrt12A/455+vJN0OZIq/hEFe1lyeV3mim5FE550bp6+Ivg3mKq9cT9wL5fRqUONSy1XZWGZI67J6aGOoTN7NJddoLC15dRp9CvPgnBkoTZ+Xc5ctiHFl1UaakIhY7TDORwMOXSb1A0aS2pxZ/jpot3uiHyKh+Rgr8Ey/Us4+fBY/O019xvuG7CE10oq0L38G3CSe9ZSRR3fLgl/KjvVdT9K9IyaFfaPUfkTNpWw9Bh5ALkA5rNXfLOHGyRuV/WoTM7hynTdRV157ejKZ9S2nqZ55Hp5kypw6nBj1W9b+i8DNAG5XDCyYZpUFlxanraLkxiv/No46lTRWBvyGoJlCtD4Skuc0224pQUdkYIkLjsxSfyzlRPG5qXGNIXBPLKJDSM2y/hQEbPTlq2cZM9GeUBKE3KFPZwYuWweDwQgi/vA3AlJdccBKda2ZF60ycZRgdsLfvohqXrdjsIDjDOlp5uvMkESP6D+lPIbhnYZUPROi4eWbIfznusJso8i1lrebSprcj4LdoT2inKqMqIR7iNoZseP3QvK+bCA1OKNGz10slow00Mysq02guchVwI8Q3+eVszXHu02afGHNj0mnszQWVNsCOS2BF29ujouE66P3T1GsIpQac7NPS27a+3oSC0wNyKpGLOrlWs5M92dqXEdR7yo1oEhCsMQo5IkCdyzaDPOMA39myhWKXIMosKSA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(316002)(186003)(82310400005)(1076003)(336012)(41300700001)(82740400003)(26005)(47076005)(70586007)(40480700001)(2906002)(8936002)(70206006)(4326008)(7696005)(36756003)(5660300002)(2616005)(478600001)(8676002)(86362001)(356005)(40460700003)(110136005)(83380400001)(54906003)(7636003)(36860700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:08.8056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697bac2c-5027-4c8f-03ff-08da961017d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device any more.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 828672a46a3d..930d9946b9f7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2135,21 +2135,13 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
-	if (!check_device(dev))
-		return -EINVAL;
-
-	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_data->domain)
 		detach_device(dev);
 
-- 
2.17.1

