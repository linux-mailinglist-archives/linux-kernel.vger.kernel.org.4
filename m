Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241EB5BF913
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIUIYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiIUIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:23:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057B86FF4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5MexUYm/YLFPDjV5tzeWvhGqs/PmS8XLUjJSbdAY09/P9nSIRQ0789ndpPQawg5ZP6nU0GhqkErhwkvXXtp9GQILgaU9kgb0G3e2bMti1ab+wRBEJ0rNuteOIm+fLW/Csl7wX6aUscod06EpyUQUx84VDJSTscqYfkOt4tbL2n9lljpLAuv+Y0rCoue/JDHSPMn9MQ+95OI9TVKe3qNLMgVZ/zZ32AF8FIfTRzZTD+3FaQmQ2iF3P/i9XrUKzz4GhK1kEPrzpXVREfmUPYasFh2Tn0ITTFbHyl7NjE6bxSyVxa+lDZjsCBKjNOqAhV08QISWfZCv3Vk45/G7QkIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=niI+i/HNJkI5G65/V3ja5v30OMIeoKHzSPW0eyHT6kXrvEeA7ZD5Nmm14sKpyyo0gLCiA7NPIZGt3hlvIgxTeNCoHr31OvRuQMKeQyvMK/l4uDJNEr5iOP0SbO66rfTcldMfb6Fipyrd34dpNyEjrsdNImqC3ocW/a1vD2Yo9cDRt7vMiizDVzIHeQXdIMVJqWm+VHXVoyUbBheGG/HWuZXhxF9CyOrwT01ZHyd3qN2sj9r0Hgj71BhuE8zwng0ief3gvDlnyQE8FFp5YcrbZOShZDfu7y3tucx7X11OliVp/3t4OgHt5yyRciOW+DVO0nvv4ARQX0I0RT7tIN6eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=Tey2jryknV73DPkrpiYvQCdkvJKCp1utvMIoguKsykSgtIwMiCKHuacuNAaNJZowr4cPwF2cVFdpDLWMBvUOSS0h5WrW2KdSR91bwJ+RTjKdTMTPC6STbfLPYo/y9fPY78GJPiiCydsNwWO1d2OZ58MxJHWp2fZk6uJ/QwjGvdUzz7wToGRCvJwWHBDCz5VxxN+ULFHaIOFiHuFVzFExTGj9Y2Rbbxdq3b5xrSFdJ5JCvthZTJtDaMSedsgZWZK3vVCkMwVPhagFM8UkxfUmGmkyIV4i1UMprwUFkkynzyhNUONx90NFuUqIMa+lyudsRGaRQsZJI8JM688i2Z76Vw==
Received: from DM5PR07CA0115.namprd07.prod.outlook.com (2603:10b6:4:ae::44) by
 DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 08:23:20 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::47) by DM5PR07CA0115.outlook.office365.com
 (2603:10b6:4:ae::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 08:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 08:23:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:23:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:23:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:23:07 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Wed, 21 Sep 2022 01:23:05 -0700
Message-ID: <00ae068bb1e75e1bd04a53076e11b193dfc039da.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5631641a-b58f-423a-e024-08da9baa8a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYlPHyhyYzha2Syo6sRVpZ8oegtxGt17FdYTW9aZTsNN36NKzn7YM2qruQimx7rnOJX6J36fhX1KuNkgTuHT+7/7dLchdutUWGPQc+BEBwNEe34q5bjdlM2bAW3rPNLTZV+v0xXw2gh6BoWnj3jO7PKhKu8mTCN6Rx49jcNDaT83HvCmnhYRRRJ78R8J/wFwLdKTldmdZxUr1YLq7QRmeSJQH7RvFa/EokGxJYVGZM1Rm7EVn20qRWI2dPB0azhpS3yv89yviGqoxG3TSX7qvQgGiVuGRfh+RiCorR1yv3ZBLwfk6OkzsZefH7N0YKI26+LvGY9agOADCEdtBzbrtSYWOMS4+6OsZzvr2gSXVoZzIeokufAmd6z01oXDcT21b6W98ZOfKrG/CNZu840uBxqsn8mj8ORgdEjIxSg2SGc4pU/YSO3eTV3GgviZSr5bNMaW6rLT1SDIi/3QCG1i4iCP6j8j/96hNiE46ojIDoKOBQanosx6jqYbNZ+y2msZORoEOr348FMptUV/+50NI2sGLT5LBcAMMkQ4IZKw3nFiQiMU3GSgJVcX8KiJVzaZqx0sIZx8yoGjmCuO/aTFm91ufLITH+5U5Ij1nQs/y5GDbjFO3pXt0SGQKMwtSwZ59fQr3P8ZT6OZHaw2gI4Hubdp/LVuG0H+IK2FMjtjGCEkxqgzoyFvM8pTCrhCrvHvtw81FFXaI1YZhCdzQF7QIgcCNq1zRCWbw9sWhpVdgMkFdAF7VqdJ5YJpU2c6o/w4oVnIaKpPAohJzroo9hjZfw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(41300700001)(36756003)(4326008)(5660300002)(8936002)(8676002)(316002)(110136005)(54906003)(70586007)(70206006)(82310400005)(7636003)(36860700001)(356005)(82740400003)(40480700001)(26005)(186003)(2616005)(7696005)(40460700003)(83380400001)(336012)(426003)(47076005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:23:19.7157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5631641a-b58f-423a-e024-08da9baa8a9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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

