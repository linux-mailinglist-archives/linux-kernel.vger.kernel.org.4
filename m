Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5E5B80A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiINFPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiINFP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF4402DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrtJlSQGfzXvuj4esd8iinwKplIW70AjHYxMO5980IS4m+oFDY8FMMlHVhpdJzXBcxPHj7NlrG/yrhnMV0lVJBJZLgebkq2ffZoORvqOrHpPmNJTCEaqFb3mPJz00/EC6lKhAt/+V63lDiva7bJpyUXcWzk0R98CuGUf5MHlkPC6Gbh5lCrhuiuc6cRz2lrKoStPaZGSkcBpc6M9EdOZ69jHtO5HTR8PT4Y3yiKPJDEKUm3yb3o4VA/zNxWXN1A9aIwv7I2SpuxTV0tGMNElog3cLaWaIxRbWjo7KDwSMKIKsmsGsj6QvPKpGjS3X0C4GXfAtFylZ8g1HbQYDTRVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv4dDL/oyBOs5W3tmA+R73rPiuqf9GfnSaM/XeW1pz8=;
 b=ME9maX58h2UG4crOwuiQx3Og6LsTsvYfvII4Xu3k8VBZimucBqboE8Yz/6JhGWhJHd6S/1DHssrF0P7+2eadjjHsG8h9Wmr7Fx5KD9VIJquziLOrXtBswVhd9Gq5Z6qpYEgj//2RSQwEBa80JevI+tMJsSPcSzieJhsL1Ewsu4RAKA7dD2BtJayVXiNiAIZp4NZAfAr5G4s7mPzme2w0Ckd9jSde8tT8SSK8bsYz9gz5+P4o9YSe6Xqlmd5meToAJsVAsdVRZj+1OQNJPa7bBtnvSez4L6ooqZCAUMgKWMhKivfukK7BvPHF9zxTK9BxZxw9w5PlM5e/ndNHM/EZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv4dDL/oyBOs5W3tmA+R73rPiuqf9GfnSaM/XeW1pz8=;
 b=SpIFgFtAPdWf0nHqanUiLpXnGb0Q7hep/w/TUgVd2VLLB2jVtwm6h60TgUS5tpy/zi+W4fS4AMwhgoIWi6+UZk5I8wNEgxEeWDA7qB3eh24StE5mqiZgmjCs/PsBEpyPuABDS7AC7v+qyf2YmcwzvL0C26sa9IfwcNd+qMFqEuQKiio7OVQ+YoN/5C4jHiskK4ivgfbREM7AG2f0SkT4vLQWhJSHIjpF3dqBKzhMhjLvSj40kgsNzVBlfn/YBHi+/5xWDxzw2khZ0OmY/lEeLJpgbvu+NiQnZa7cjbl5AO/Ay/zD09esKgx8HQ20rgcXme8qZ4jTz7fJBzJrpKvkzg==
Received: from BN0PR04CA0194.namprd04.prod.outlook.com (2603:10b6:408:e9::19)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:24 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::14) by BN0PR04CA0194.outlook.office365.com
 (2603:10b6:408:e9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/13] iommu/ipmmu-vmsa: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:02 -0700
Message-ID: <20220914051503.10348-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914051503.10348-1-nicolinc@nvidia.com>
References: <20220914051503.10348-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 77345248-1270-4293-59e1-08da961020ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTURu+dddH/xXeyfrc4kcUKNK3m8CjJwEFR8knqB7T/H4AOe8eEhyKwzm8rgSROBj1DfgTK+V9+ZRcF6GRTcn5hiRnvHk37/B102sGM0TaqNCfxb0HhNaM6nBKgpNrAlmQ3QRv6Vnoha8NgRW3htZuc2ue8LbAlNijRzZ9IbQ8sFVP9UgE6YtVOFAxGiR0cY5Tt54e7midLhZ41bVHgjFnnnyDHeFsnV9ZFuYN+mnbVYSVGnzvkKc69SVEn7qqLU2OfAVvDAXl/PwJmCAZi4NzoHLskLAD8L8KhhI9dw9Be7kSjEloHbODHIHYIDCo+YsPDudxIU7lZuc1IDNPK1iOqvb/7vlWikdAyc+pX1PxQNX98161fRBf3SE1mexZhkIGNjAWq82jRJV1XxXySnvNCPkd8g67Cn/TCTB/Yu89qW/0a2C4UUamDaGx51GhFPc8dBV+OZwMeoBArRr+ObbjK4JJqecPz/yzgDSf//0f1lkkXNfCOet22TfmBHBG9H0OQnzy0ke9FzpgVzM9b5NfGr3o7H5ppUT4XA61jf2e9bF/5OK7tiXNSWRdfKzAeZln37szS8pKHEdTFjokrzqoB1l150th/abSm1YVKigLkzpMuhq1BqK+NoDoUmuB4qckMdT3fcmdEAeSXjKjlDMKhJRpVKhdn0f8ZLX8o7lMerDiGbG5u1LixwEupJPJnv90/Noj+e1Ck4OHA3pdNq5PSS3KHrV2BHp0l+0XqYzffWQgK2lJKWkp9xOw1pu+RLwZofog+nCM/kVVNHj6wDnA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(86362001)(7696005)(478600001)(2616005)(8676002)(426003)(26005)(47076005)(7636003)(110136005)(5660300002)(40460700003)(2906002)(316002)(41300700001)(70586007)(36860700001)(83380400001)(82740400003)(36756003)(54906003)(40480700001)(82310400005)(336012)(1076003)(8936002)(70206006)(186003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:24.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77345248-1270-4293-59e1-08da961020ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

Also drop any dev_err next to -EINVAL, following the attach_dev op kdocs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1d42084d0276..73e7d0c261c4 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -452,8 +452,10 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	 * Find an unused context.
 	 */
 	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = -ENOMEM;
 		return ret;
+	}
 
 	domain->context_id = ret;
 
@@ -462,7 +464,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	if (!domain->iop) {
 		ipmmu_domain_free_context(domain->mmu->root,
 					  domain->context_id);
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	ipmmu_domain_setup_context(domain);
@@ -607,7 +609,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 
 	if (!mmu) {
 		dev_err(dev, "Cannot attach to IPMMU\n");
-		return -ENXIO;
+		return -ENODEV;
 	}
 
 	mutex_lock(&domain->mutex);
@@ -628,8 +630,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 		 * Something is wrong, we can't attach two devices using
 		 * different IOMMUs to the same domain.
 		 */
-		dev_err(dev, "Can't attach IPMMU %s to domain on IPMMU %s\n",
-			dev_name(mmu->dev), dev_name(domain->mmu->dev));
 		ret = -EINVAL;
 	} else
 		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
-- 
2.17.1

