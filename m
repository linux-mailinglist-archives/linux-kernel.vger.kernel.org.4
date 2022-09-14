Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8D5B80A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiINFQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiINFQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:16:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080884F679;
        Tue, 13 Sep 2022 22:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US4diebhRP0SAQo8b1ud3UJ8RegS4Ly1VahSLNXaFnF+Tv2cx/y47LXn1wV/g0LJUJ4KgvaW2R3kzTVZIxbgeCH1hyjEBij0B53CreyXd0wAxTtH32tZFCvplah3g6xXqQLb1YGYk78lJt6mJotffuU9aqQ7+xUPRuKWGL7yrkN7ynsKmCLAHKdtE7eyD8GPWvtITISzlElDjBKr/IWyPOkHpfg8asnBRNSroWujmr09+GR3vjTnjbFfVl3aszuoZ+zQtwZobFoSuTnUQXIDRzQKyYoADV3O/zZL5PHQ3mzmJTpmSy3MakKP7OniX4n/92KJEjWxHate8eaxDIW94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7L/ZEz0mnJDAirQ7IaiZj0uUz+07k0HLsCJki+zbxg=;
 b=GEo7Z/aqubuZxSGHWQVlZTYIMYxtEmDeNLe3gkq0VQzcO71zbQsYEIgVnxlZUfSHbJX5uG7MIN3z28Jhv7Y1qYi+UnRmXe5aU8lbMkyD2SNWqvbN4lkWeOtTg58qn90SJ+/VphV2ZoE0uIYQxKXbozrG4euLpMBFaFfPCsrD5f6ml/nDQ832/+1d5cg4xbGpFRnghC789L/OeFo5wkpscngVQqQNEvBIdo6wcEUvuhpNLB7qoT2l511fdbtUa0tFDLZdKRdqVx15nakkngKUK/bqXgIrORCvZIdQcc7jGIdcQS/DMlxPqsle95Yo8vOh6/6tHDPbTc1cjVNmOfvu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7L/ZEz0mnJDAirQ7IaiZj0uUz+07k0HLsCJki+zbxg=;
 b=saJITpVZL1Yoc+hE9xqsSj0aAtwjsCxMX0qoEjTYYi2eqERGCaFw7ULCaZiNJAUcWedMBpCciH3t3ZtLPnRV857xlII8IYebl/ZLG8m5zhIpS+u/0SbuCLHdNgE5SDKoRPyEKCHrejulQy7fkGZi533omQuHTsouKmaor4jMPf/0YPNaW/Hv2Vwd4aCJ7Ge0fQYh+d1aKhD3EpdwVqmmoJPgA0gySpWxm4TnHzDaN/aLlsGysLSC25YRpzVjIZsyv+y4lxhKvJzzevrgFLLP87k7DXn6FU2A0hwYp6v50xVGbMpRDllphZde552mWvVBqN8xCRn9l1TTw/jGCwNXqA==
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:16:08 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d8) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:16:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:48 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/13] iommu/tegra: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:48 -0700
Message-ID: <20220914051548.10644-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e14d466-5088-4010-1dc3-08da96103b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyXS+pla+pEWMNHYxmjIA9feIxgGrRXHZqb0VI4ZvC7VqPUZDMFxiS9pLomHi7t9Rq6ZlEjN9R7bLwITBRzLkSWHSXsdtc6Kqew4UrarfRpoUssSdUep6HxJEV+046oQrFeoSzozndGI+ahK5kF9grGMmAs0SVsnx8Q2ivplZGiBYIX8vuHm5+VRa7X0e1w4KeoT/a2H6UX0jHJn3Su18kydWtaNydQ6WQuum07saSauLAuKthjTNvlfXjqMDH1MDnAwsVukfDedXgJUdcM72Xb2UOPsOv2s6KZr0j4DyqNHZSPLlNg3iLtMnqjauSAZeq9CPhgDicx+QwwpqX0ryKXMnIhHabb4mVXUf7PHJ/5gVXBYCkCHw0zZRe7S3HCcABOEM2CRDD72Hn+ozCFpTJ1Pb0BMpuzcES2SZ91cQR9Wd5za3VnOydfFa82r25jDyggZbNyx3a9l5cMK6vMMnT3l/WKoj0su5Wle1IYIeqL7w+4BC6fH92RljXZo6pnolDK5AqEl1G8h40CQsO/fLXaOHvQz4zpISrjGjz/t8f8+eMldHTkO5nEG+J5Rqnc3U1Kh3Eas5oNsQadY38DI1VHMO/ED0sHoLP2KNVLlosKzaFsyQQ9FdvKtB8R8jQaoEwZKKsuTquELaJruX0ZzI8ty+0ZS3vizsLJViSMed/wkTGva1625i1vwyyXxZ7hnpqFGV+ahINzJGFwnWFVsopE+BZuTtSUzR9VtHDO82jAv/TsgHXoh8Aurw2KTdOboO6jphyke8TEb/zRbgGJhcQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(4326008)(2616005)(1076003)(426003)(336012)(186003)(54906003)(82740400003)(36756003)(86362001)(40460700003)(110136005)(478600001)(8936002)(8676002)(7636003)(70206006)(2906002)(47076005)(36860700001)(26005)(5660300002)(70586007)(316002)(40480700001)(7696005)(82310400005)(41300700001)(83380400001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:16:08.1123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e14d466-5088-4010-1dc3-08da96103b30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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
 drivers/iommu/tegra-gart.c | 2 +-
 drivers/iommu/tegra-smmu.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e5ca3cf1a949..ed53279d1106 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -112,7 +112,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	spin_lock(&gart->dom_lock);
 
 	if (gart->active_domain && gart->active_domain != domain) {
-		ret = -EBUSY;
+		ret = -EINVAL;
 	} else if (dev_iommu_priv_get(dev) != domain) {
 		dev_iommu_priv_set(dev, domain);
 		gart->active_domain = domain;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2a8de975fe63..fe68bf94dc4b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -432,8 +432,10 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	}
 
 	err = tegra_smmu_alloc_asid(smmu, &as->id);
-	if (err < 0)
+	if (err < 0) {
+		err = -ENOSPC;
 		goto err_unmap;
+	}
 
 	smmu_flush_ptc(smmu, as->pd_dma, 0);
 	smmu_flush_tlb_asid(smmu, as->id);
@@ -487,7 +489,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	int err;
 
 	if (!fwspec)
-		return -ENOENT;
+		return -ENODEV;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
-- 
2.17.1

