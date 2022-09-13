Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD665B6976
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiIMIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIMIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:24:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D11401D;
        Tue, 13 Sep 2022 01:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEofIU3dLllKzl+bxYGHo8YiIkZG91ibxL8XzNBGNvnaQOKyahYvigyImVYGJu7sYemGzDkFbofTvhtzp+ez2jObfWWW+EWr8I7Bu9qb/TgzPIlim7zlQ1lmEn3elH6PJ3w1VjVnfNVOhyVl3eg5TjxvNS922vSRSyQUy+bud7551iI1/MnBto+gp8SHHNGHWhAK/fFSlJCk3zS0194o7htCHtQsnAySYf8iBKa/LkW3I+9IRd+M3nr9YwwV5dyfVYXnPRCW8td+dNofc/wU3LucLu4rIFrgngstRhAl9UIv/VC1q/90l846qnPizzPIhrd4zsDj5Nm3eX+T0NZ7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ4/fyZCnjIg7QgMmsopcMYiM+CksOqR8A6+qGvlwcs=;
 b=Oqjo+WlGtKnuw5K0GMubqJJ0y6cFrpyMnFUJkduyYxRe3vQPUKpYRib27KL7AKHDsFHfjS9Bnl3Unguv6S+ZdYxZ+pDraVOKiNoLmIvS3cckerFv1+aMbqbF1mEDD36GFqu2T7Rca6ZAxkcyHJNtqQh3wuaBg+jZhkCKskMKNYFfe6TkczSaUC+0Ve2ikbCfFDDlcA/RzFTDs5iiUDCH3LzXvxcN7rb401uP5byGXDpWqutEJwwFHuD5NwLdJLJ7dJp2R1cQ+l3DjiM98RGYrseIMrCcvrFZ/Fv55t4WJ8QAOpwTxXayZ5EbWSqpSlkF5uoXX7t5oUQ5UAdvyTYCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ4/fyZCnjIg7QgMmsopcMYiM+CksOqR8A6+qGvlwcs=;
 b=JOvm+yiLXV03MSvlCUXIrq7/3jWTMCprIWyHRcoS33ZYf0s3M/p37BOxTruJgSrSqKS72/volSOu1omSp2Q0FnGzfPJusM6IJxXWdvl9/gXo94e2UKhwZz0liABWpByETt+PIAW1OU+siRsVVDMEYNHMOhqW1XRZWIV6Sn+JyyrpoFnOiaw39zha5jU6XujhmnpKqDOBWm4BCqk0MsXn8xQ+dkKHyxLjoEEXA1Bqip36uWH3W5DqK6i+NbAQaRHi8B1Z69ZXH6kBPIX1KaJyQJKaNX35M+L7u0+01GnZJRF36ml83dL082IlKFoM/fRp3Mdi6D5fvUICM7Es6f8NzQ==
Received: from BN1PR14CA0002.namprd14.prod.outlook.com (2603:10b6:408:e3::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 08:24:55 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::66) by BN1PR14CA0002.outlook.office365.com
 (2603:10b6:408:e3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Tue, 13 Sep 2022 08:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 08:24:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:24:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:24:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:24:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 0/5] iommu: Define EINVAL as device/domain incompatibility
Date:   Tue, 13 Sep 2022 01:24:43 -0700
Message-ID: <20220913082448.31120-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a05856-dc4e-4e42-ff64-08da95617009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y2AbQPrwctxHIY7UMKfGY8ElMlqnq0bOeMWoffIIMDk4wivNZ+F/VDf/ht47?=
 =?us-ascii?Q?0M1h2i5OvYWlJEDrQdi0iA7wLVQbuOdiuPZfnbYNPp26/aVan14F7mFt4Siu?=
 =?us-ascii?Q?CVLjV6I/z7gL4eFi8DDueFvqmMSXPEBwVkNWTfElTy3asA8kBBruV5tD7/9x?=
 =?us-ascii?Q?kIZCkwFu9N+FKvrkyCbHo1ngqDcazl1mMstczgbh6OiPUmmbbJc++mM1mNFE?=
 =?us-ascii?Q?2aJQMX7TRToEJ+/AHn79zShhD+GEan3VSABEn1CKQqGbta3XReLYgknxQbLN?=
 =?us-ascii?Q?d5XCR2UTxbkXR3nXPkJXljNsah0YDi8Z+fnx0Bfk2yD7bBBke8brobhcGqrr?=
 =?us-ascii?Q?yg7UFTaiNMZWTSN+exbE474s0JYSKDf6UVfo3iUYKZcWeweHRT8ysx2Tkz4Q?=
 =?us-ascii?Q?EQP7W7VQ8IHwM52EICjvI0DZEyuUkhLig7pctQsMxi19bBFzb6tPIvGSM7GO?=
 =?us-ascii?Q?Kr8nz6OPEOtS2M0UaSSLj1s19nV5VuxnRE+/hGKgrJKFbD3Gtj4S04VDpv9+?=
 =?us-ascii?Q?kw/9E2rCB00lrOyzoYZsaohAskaz4iehSNs3HXe5K8+exjYCM9EWcllQ+n2p?=
 =?us-ascii?Q?17ZG0BIhg5KlXc25PNGxjny3iM3CqOF5xZdDgH9mcc1vwz7AzN7v1xy5maw2?=
 =?us-ascii?Q?Xza86eL6+1Jc+etndobVXOe1lqcqq6z10fVm/V3RvSPVVRGsmqRA4b2d4XN3?=
 =?us-ascii?Q?wbvOddpLyV/b4ezgBYb5KsRNC53pUMIe51EwJFlzUOT7f5xa/e8MILVIdYBo?=
 =?us-ascii?Q?QRUeMulL4wLR+P6/A1tGfHWF9sncOIkkS9M0nAcfb7L7RFhiCOvSU/PxrgyX?=
 =?us-ascii?Q?GHxujHWNyt0XMVNS8M/W+TIvYBF8TxbvLMD737n6NLymYc+/j2GSSDHrBJsi?=
 =?us-ascii?Q?rqebUlEVitBWgEUVyhWBMngNy+k3FEWz2GpDccEjkPod0HBcD54AIJ5ZRBqz?=
 =?us-ascii?Q?9cuQsB57Be69RmeOH+kiBYVFzpqc8D1bkROd6vPkrOM=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(186003)(4326008)(26005)(82740400003)(54906003)(921005)(478600001)(82310400005)(36860700001)(2616005)(86362001)(356005)(7416002)(316002)(41300700001)(8676002)(7696005)(70586007)(110136005)(83380400001)(426003)(6666004)(966005)(36756003)(70206006)(81166007)(336012)(8936002)(47076005)(40460700003)(2906002)(7406005)(40480700001)(5660300002)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:24:54.8696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a05856-dc4e-4e42-ff64-08da95617009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/

The purpose is to regulate all existing ->attach_dev callback functions to
use EINVAL exclusively for an incompatibility error between a device and a
domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
try a different domain with the same device.

Among the five patches, the first two are preparatory changes. And then a
patch to update kdocs and another two patches for the enforcement efforts.

Although it might be ideal to merge the previous VFIO series together with
this series, given the number of new changes, the review in the IOMMU list
might need a couple of rounds to finalize. Also, considering that v6.0 is
at rc5 now, perhaps we could merge this IOMMU series and the VFIO one in
different cycles to avoid merge conflicts. If there's less concern for it,
I can respin the finalized version of this series with the previous VFIO
one to merge together into the VFIO tree.

This series is also available on Github:
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev

Thanks!

Nicolin Chen (5):
  iommu/msm: Add missing __disable_clocks calls
  iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
  iommu: Add return errno rules to ->attach_dev ops
  iommu: Regulate errno in ->attach_dev callback functions
  iommu: Use EINVAL for incompatible device/domain in ->attach_dev

 drivers/iommu/amd/iommu.c                   | 12 ++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++-----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  7 ++-----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  9 ++-------
 drivers/iommu/fsl_pamu.c                    |  6 +++---
 drivers/iommu/fsl_pamu_domain.c             |  4 ++--
 drivers/iommu/intel/iommu.c                 | 10 +++-------
 drivers/iommu/intel/pasid.c                 |  2 +-
 drivers/iommu/ipmmu-vmsa.c                  |  4 +---
 drivers/iommu/msm_iommu.c                   |  2 ++
 drivers/iommu/mtk_iommu.c                   |  9 ++++++---
 drivers/iommu/omap-iommu.c                  |  6 +++---
 drivers/iommu/rockchip-iommu.c              |  4 +++-
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/tegra-smmu.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  6 +++---
 include/linux/iommu.h                       | 11 +++++++++++
 18 files changed, 49 insertions(+), 64 deletions(-)

-- 
2.17.1

