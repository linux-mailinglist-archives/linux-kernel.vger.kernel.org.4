Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DA5B80AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiINFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiINFPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063574F679
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9488ydn3NBBVhEjzWpXC6v+PmzLJ+GUioTYsNwbj8qO+XkMMK2XYWwgNmCkX306ReveOu5t7weNjWAD0p2RznLe1TQdBUsqz89+RV2qfaN6BuD1WQKlCdd4m8d3ZopxN0Bs+NaDgmUQF/diRt4Ba6IOIwK2OuA/zH+04/TsLYZNd+gkxVNZWZZiIrvsVFyysXP6FJgLkuTvMgujq9UkTD47libU3ZB883lNR4TdeFgQHja9LZcGjFUeFSHkbvqRmISyZ0hnBreN+uw2uMJi3gTubOehBGQmg1/VcSlUiHbMXGU3ORpg/QfcC2VM3hRLnk1k1h8moc4RUjmghVbPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeXeIzDdh4ZqbaGDY5wizyl4Km2wSUTu4wpMlCtedhI=;
 b=J/f03MqBNBDv0YiM8HlSgkwxqUrBYqHzUrGT84EUJKGFFI9bETdvTpVikfX/gmX30aSeXxY6QXhYLdhPM0H4ZIwXxCWswGxKElNMotDfDB290Q+3odBSO0H22LRdTQ2DfTs/Qo6jSkYNTiP24jlBjZNKp6I2TAxecxQ5BX8Shgys/41JrvXdw9A51ifiI1cmFEdM5rk+zpP7PuuNHiXqcOJ7cDbdzRwNd0wWMbHR4g7byILt8qilVNm/XxEFU44Bro1kEQANgN8kMJp8kZzf77UHO+2V6YFKKAqAPL1CdErcccN8gTbVKIwHvL61syO7e2B3Cu+ravFnhCQFfe8DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeXeIzDdh4ZqbaGDY5wizyl4Km2wSUTu4wpMlCtedhI=;
 b=ghw0OC7L+hIEIsh7eFVt1qADEwuzzyctAEIVVyIcDyoH7R/nDXJ9111RMi1ymK8ZJ0Cqg6g0zNvV2ou1FpSXPadRP5/LSMrmk2njI3SShPffs7bdiLPJqcf+B58JqD9gJbKPJzJimzDYXudCRNLlKqNomN84scmBT+7t8RPhBi3kuwRkrawBgIu6CB8ZI7mA4hJJltJ2MSKA6O4ipPay4RL1Bp3hZbW2Kmk2uCtitYe6p6Nj53o6mdITftob8jdXESTKjZwyjMEUoDxPlnI3y5s+kbGXnVHRF/z82BM20CC2yvNO1moywAQf5gw8Wg/X2/wdCr2xheQw+6lQwDSjog==
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Wed, 14 Sep
 2022 05:15:51 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::4) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 22:15:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/13] iommu/sprd: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:26 -0700
Message-ID: <20220914051526.10518-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: c1410440-89fa-49fc-ad78-08da96103105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uu7L5O1ECS3/qJAHS3jRPvrJv82pO/n5Mr95LPtG08+OOTULzRYnoeimXFWCetSzCj6TZpp2J9oFEsvehQc7F604KjzdI8obrjjp1+meIqzt/FfPh5+7lEKeWfA1XXeVcyk0yhKpuS2G5WYoqQOpYvJBcPiTsYUPl5PtSdhjGTHYBEcltdKWk0a3CJzqupCeEqle2fT1qp8ytxMFtbjPotR0BkvJRU9CXiHFO9BwAKaA2+GeFbLluNzXvpVi11q3zM0lH//MD7XGCCBC/tkYSTItVDWJ2dl2G+nGVVv8uKInfHr6w4nCVoqb4q3MsivUH2vuHW0j4oFTun/VK687PCRfWXq0FhbVtUSIA65C7Qi8Z3r24bBEBVauC2e21ecmWchP6qdb6/5crvP7eI4+fBZ5MKExsIJ3wKsSx2xhqvbvzl6G0IBRyWobUEqcKfhD2F/tnQmZgE/+ZblWfM1NUr28G2SzPYu51ZrGs1FuXepRj9X0+5HYuFicF11wir+WCB16rmEHu2bHvSe+3xsfMUrM/0r3DVP1tbn3HdqG1M4fobT2vL/wo7UrJnFvF4IrDtmXs62XEmzAgyXp/1vj+58J3gmxqBfzAp6gsqVZz4Fzz+eJlNdCzICgD8V+cWqXZGeY1lhvAzEqMvxVRU8z3ncPnlLG55ptKN1Z6709EP0R3rRcqKx3D3XR/ZNtJv3+6P/T4vO7pKIeJllq+odxTSLimgTOmgx061b3VjpOhEvxghGeyIR9bYODDT+SuXKHiIuil7lCz8aVbKbsl5utA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7636003)(40460700003)(86362001)(336012)(83380400001)(36756003)(478600001)(70586007)(5660300002)(36860700001)(2906002)(47076005)(186003)(2616005)(356005)(4326008)(82310400005)(426003)(70206006)(1076003)(316002)(82740400003)(8936002)(41300700001)(26005)(40480700001)(8676002)(54906003)(110136005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:51.0257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1410440-89fa-49fc-ad78-08da96103105
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
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
 drivers/iommu/sprd-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 511959c8a14d..945576039c9e 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -237,10 +237,8 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
-	if (dom->sdev) {
-		pr_err("There's already a device attached to this domain.\n");
+	if (dom->sdev)
 		return -EINVAL;
-	}
 
 	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
 	if (!dom->pgt_va)
-- 
2.17.1

