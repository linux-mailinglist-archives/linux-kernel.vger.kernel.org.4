Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364FA5E74AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIWHRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIWHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:17:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7336F12A49C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQU3LSojxYZheTQFQx9b49qV1QfyNovtwiM8JvSvr0AMOFeI6jy9Kdgbua4MGqhJx+P7LX2gkBzkp0mVd/Pv8FaTJh2NqqOzutXfYAkAhR++Cqf8yreGNXv1jjGvO20hi8fJhVC2TsI1SM4QbmGeHU4qLAq63TdNwD15yaErepzK/AN2lf1Bjyrgr0fv+NIsJM2Hex0VYfWrzeFysD/sPl+PL/B2MNu0ZZi+r9qqKktFATj85n5V8RNFQARAgjbsYAdtC5zSqGn+P+a/Cvj3Hvdi0GqdTPkQTd9Ua177AO4E4nSiL2gvjIEQRYQsKbuPEuBgFbq9P3Rh/tw00v6naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPTMkRQypvtl/yUZc41S4bOFvbfPegjDDjGQk8KnpBk=;
 b=lYujeZVg2cPWAHT01H+bvPIKaHoYF72cEc0VCGZbpSjydNMhbOJCIBT6mtqBWisIhyFYFyskBZF9Px1wcF2B890QWPIBFbQ6YOLLB2c4MhaDezT4iLbME6XXAEp9PQk3pr2EzDXjCcRwv6wTk2vXWJne7YP1Z9wDn/nfvZS5c0YGWCc/4vt7mbbvM7rdwqVpOsfr1+mapPpI+5Ji4EhFJUPqQu/5frO52qbKdVNvtG5+wKCQDFuBHUdUt6S732zAhxd2DmkzNaR9qKCOu13wUoWnvW/ZUoGCZndJsk9Fy2qVEXr77N4AUub+NpUwmw1SsDUFQ+TYal/ZPqIVWGcxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPTMkRQypvtl/yUZc41S4bOFvbfPegjDDjGQk8KnpBk=;
 b=UBNTgSx4JSaXdiJY/gTWqrxF+tlcZWOX8u8qJYPsfkF1lON/O4mzFTnIGuVssBSbyc/YvxUb+5v6raij93gLdcbh/Q71Lswj6RqObBxBT72Zsbt49tD3zheKdNKBouKa1EK56WFQg2PvJy+tWLcs8OnxyhrKCIuT1G384SZZ7hYJfW2SaCDrNz5S+9b2llnk2jGMAlNM2cQ9XCXRmEYu9TB8bkHUQ5OtuR4EImz+TJoOMCqmtOIgStakP8xjWtghNiz5hqe2XuSSZPbu9VaEmLaWFgwsZaA9THy87+XcciI6yXlL1D+qSn3KLeu+30jPUrl7X4u6HAhCdsQ6SEsh1g==
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Fri, 23 Sep
 2022 07:17:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f1) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Fri, 23 Sep 2022 07:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:17:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:17:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 00:17:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:17:07 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/5] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Fri, 23 Sep 2022 00:17:01 -0700
Message-ID: <66bc4f0d6677bae5300f06023b0e1b9c53c8e883.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: be06b6fe-b11d-41dc-4aad-08da9d33a6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuElOOFETLvOnNBb8iwmqgmVHPpkNrBW21LHXJ9FvU8lPXWhHvk2daj9zxVQHqJc9ZEJusXHnskZAKY2na0YXAKb8Z11x2WTbkN4OajzJaDmcpjSfzkAT7gKGFFvIz+4MAevL96IpebR1oOdX7rznQhkLRVoTW7HnHqcOyUIwDz8TirVex9cwCYQp9zvFj3LjwMQE7/kM5byR7G+01lzvoQ+10xohKV5WF+lsCg2Ie/Bsko2CmMH4oqTeSrhKgu8dINFMrNSuyFfT+xGdls3Ns9RXg7xxr/NA/IEmx1SkoGW9d7X8yeHEO83gCe/K41PnugUwA2pKwr4lZ+Af4/KnRjx/+bcxee9hyqY0iS3vqT6FBxKvfoRPSbEUkEA4mn3yF6AX91pCca5t3kcdKoH2E+vLVrOXfVX7DT8cd0pw9fMReXqdOcmUSZFUYhF/F9JyRd6Fs2xsYhvJtX5HlmI7GNYASRm5+22UctemWSVwvzNndfLvbB+DuV1XKQSxF2Db1UkroWa7C8V/hL+HqlrSktAPeZAbyA2XLjoK5II+0Y2C0ZdT36cEi7qCw8sVnupfvpEpIt5k7kveQw+2YRez/eeqnZCtF0ZrbniTn5c6L44VIoE/ojwe3X7ioU8XKwRop/7R4GIbhVLM6gBenj2U9mAc/clfLaiaa8KUUj1+sN5T+MglU2O4gsVtEZAC7HFgP9xT/c4/6ww0nyd4oZLJd79DNuHNusQ82poJ/d74J5ClW5J4ovtVJAgksMA2FWVus8e+y/IFZrk7yKPIio1fA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82310400005)(40480700001)(186003)(110136005)(40460700003)(54906003)(316002)(356005)(336012)(478600001)(8676002)(2906002)(7696005)(26005)(82740400003)(41300700001)(4326008)(6666004)(5660300002)(2616005)(36860700001)(70206006)(70586007)(8936002)(7636003)(426003)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:17:19.0576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be06b6fe-b11d-41dc-4aad-08da9d33a6b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device anymore.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

