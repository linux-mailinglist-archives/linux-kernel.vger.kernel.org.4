Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE37601CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJQXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiJQXBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23B7C31E;
        Mon, 17 Oct 2022 16:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkjfrfln+0ocpdCiXnpfXxJ9LmEVLrxZx+NDzGduHBD14cca/MoRVZ1BCsy/6XigttJkjCJeLk29EOBvteU2Crkj8/IZChrvbg/Yle3n1AO99bm7yYdZOMTkMYjxqNF53zqYPuYGe+R6rEmlVG5WNU1xzYlbu8enVArU+Re8z5H22R5lo7Tx0+cfMiOi1USxniGfhf1IgtA1XQppDS4MU7Kk5nRvj0IEn7YL0ZG/a+D2YcVZFazOxbP2Tu/98y+5VX1pVTRB96lqzlcBGaa2rAkRU0i/v0f1qS2F6bYhkSw48DRCBhUxl/IF4nxHbMO70IQya53zKMXnXwVqpE4fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxnLI95/4sqZIsYYsWz2cdPfygxHCfe3e9GeHAaMKA0=;
 b=JZ0rVbFFNjx9866QYTmzoYMaQrJZqokoNqtZBCaty5OuFUOyG3UjEkxNpOVg+jdXyLx1RL43r5o/fGHsUKWKKxoEE865ZCcXeLK5UhWdmhwMRNRZiVde7NVIy98dW29PJATSHbFKO8NFGA/z4jCVtmxSWhRFJdVdflVSP/AF3qCMCKIwqB+F+8laGuh4qhKIeKxGBgtbvlCUflZgLLRA5PVOu8c2/cnEzw/MuqJVEQ8suB8OMMXJtZH+b962cDSPMtNP9SFv3FIQ+nru+spxS1bfoUc4f2sPF8LTMzakUCWsJWKYOzSavj0PGAbLCpAozPCEU2E7R8E/zV57dI7xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxnLI95/4sqZIsYYsWz2cdPfygxHCfe3e9GeHAaMKA0=;
 b=fcr8h6DxMuznREjkHUXvv9eCnwLIf9voJ5mx8uyhgNXskmWfHb6e6FWgwwy4m/Lfohss3eM/LgnpnK+UszlVxRkEhBb8mB/6/LsuHeRA+NHqmaKrhEhVIbpTLn1MALYdJIk+5vHRHfPNtBVXnX/ZT7A2r/ynWVjeAiOhf6mcIdkRgpormjK+zHr+NV8/4elJIBR2vw2OreciMasvuUHD0Fi7zC2oijwiE8ZjRVLCs6+8Nsm+YII886hqJWr+gSVc+pSHIZ1K1wb9JkGBXWobNYA4rUksJ1+LNB6SN5KhOKykFwEcNCTdgSvay/35OXLoaAUkJvFj3reFf/fAIJH5aw==
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 23:00:55 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::be) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 23:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:00:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:00:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 16:00:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:00:36 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <quic_jjohnson@quicinc.com>, <suravee.suthikulpanit@amd.com>,
        <robdclark@gmail.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <yong.wu@mediatek.com>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <jean-philippe@linaro.org>,
        <tglx@linutronix.de>, <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <yangyicong@hisilicon.com>,
        <yangyingliang@huawei.com>, <quic_saipraka@quicinc.com>,
        <jon@solid-run.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v7 0/5] Define EINVAL as device/domain incompatibility
Date:   Mon, 17 Oct 2022 16:00:29 -0700
Message-ID: <cover.1666042872.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: f6db7ab7-1102-4752-fedb-08dab0937223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yElfNDeM6HQnph5cqV538mrn7N3uxXVx6wuSoR/n074cJzNGgiqftW5fH+5bWPvno3Sds9BqpCqAVORs68hW3rxOdpVuMi0QOtRH7npSWuEQCqCM6XjxDTYPT1HUwpbfPrzpqNUSbRWnFUT06UNWhMNUF1akmVy+zwDgRP7boeSOWDq22ZKfJGh6qUQ0rsV/c+GWSgncZvL9XbHzqqDZfe3LpRjuzi6we7dJaR2YL+dov6yK1f3JqKksRVH7Tnq5Imr+srcAp3M6dOAgErbB9yotXLIVt0RLX+U/niwIO3lJleeKNjdn1PkhKqCognObbfJBHnG6Uy3jIhhlWIbuhROKVRo8fqk620PppPMG1BmuNDUaqt6wrvlX2kY3ctE4QsYqSzjW+X603p69XhyBFZLm9Ube6SekSPnjN20TPruic+yBZ704dLm2tOla9WLjlO3pZJQqSO3PwiPuCx+BIykLIMRE2FiLCicoOTukCQIe4iraJ5AeZ15e3MdLI/9h+ZeGPBVJRoE3tbGxKMpFqr6dg0rjnzqIlg/sNYgdCZFsQ78LCJIca/r7RJioQVmftyC0H9+4bzxgZkg6VjdYqrrSP0jo4W+lIOhYY/Gu4F9nXAZP5FOGsy+TvKFlytNnSMC+jR2oyYjol/0Ph5iT1b9hK8Fn9kA/GSZcf+lKg7O4BA03q3vcHfYPDFoP0GKdVBj28YHUzjIDdi3ZZw4FFRLuOWicCbPxQnetnoYg34Z21xA22u+Pby946VRKf0hlJhfvSMkDPla5dr6+CjvzBXcmh2YlpfYV4cY8LDT8Ns8U4XyEey1+/LYhbG+X5GXTSdxIauy2rER9RPkpKSTYAdu1xzmRv/cfPTFLDspcTHHXJVn+CviUJ3cIM4zROIEnXmXAybtHXDAXUPI+1kQAtQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(426003)(336012)(82310400005)(82740400003)(7636003)(356005)(36756003)(40460700003)(86362001)(40480700001)(36860700001)(316002)(6666004)(478600001)(966005)(54906003)(110136005)(66899015)(41300700001)(7416002)(7696005)(7406005)(26005)(2616005)(5660300002)(8676002)(4326008)(70586007)(70206006)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:00:54.6895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6db7ab7-1102-4752-fedb-08dab0937223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Among all the patches, the first two are preparatory changes. And then one
patch to update kdocs and another three patches for the enforcement effort.

Although it might be ideal to merge the previous VFIO series together with
this series, given the number of new changes, the review in the IOMMU list
might need a couple of rounds to finalize. Also, considering that v6.0 is
at rc5 now, perhaps we could merge this IOMMU series and the VFIO one in
different cycles to avoid merge conflicts. If there's less concern for it,
I can respin the finalized version of this series with the previous VFIO
one to merge together into the VFIO tree.

This series is also available on Github:
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v7

Changelog
v7/resend:
 * Rebased on v6.1-rc1
v6: https://lore.kernel.org/linux-iommu/cover.1663899032.git.nicolinc@nvidia.com/
 * Added "Reviewed-by" from Jason to all the changes
 * Added "Reviewed-by" from Yong to the mtk_iommu change
 * Dropped the msm patch as it needs a bigger change to fix
v5: https://lore.kernel.org/linux-iommu/cover.1663836372.git.nicolinc@nvidia.com/
 * Updated kdocs to correct "attach" narratives
 * Updated kdocs to be more concise and accurate
 * Added "Reviewed-by" from Kevin to most of changes
 * Added "Reviewed-by" from Baolu to the intel_iommu changes
 * Added "Reviewed-by" from Jean to the virtio-iommu changes
v4: https://lore.kernel.org/linux-iommu/cover.1663744983.git.nicolinc@nvidia.com/
 * Refined kdocs with Kevin's input
 * Fixed an EINVAL conversion in the intel_iommu driver
 * Added missing error-out routines in the msm_iommu driver
 * Added a missing EINVAL conversion in the virtio-iommu driver
 * Updated commit message and added "Reviewed-by" from Kevin to the last patch
v3: https://lore.kernel.org/linux-iommu/cover.1663227492.git.nicolinc@nvidia.com/
 * Added "Reviewed-by" from Vasant to the AMD patch
 * Dropped all unnecessary errno enforcement patches
 * Updated kdocs and brought back the kdocs for the helpers
 * Added a separate patch to propagate "ret" for potential EINVALs
 * Converted to ENODEV those existing EINVAL places that are device-specific
v2: https://lore.kernel.org/linux-iommu/20220914051234.10006-1-nicolinc@nvidia.com/
 * Fixed kdocs format
 * Grouped with the virtio patch from Jean (with a small change)
 * Separated previous ENODEV and EINVAL changes to per-driver ones
 * Redone some of the changes to have explicit return values in the
   ->attach_dev() callback functions or their direct sub-functions.
v1: https://lore.kernel.org/linux-iommu/20220913082448.31120-1-nicolinc@nvidia.com/

Thanks!

Nicolin Chen (5):
  iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
  iommu: Add return value rules to attach_dev op and APIs
  iommu: Regulate EINVAL in ->attach_dev callback functions
  iommu: Use EINVAL for incompatible device/domain in ->attach_dev
  iommu: Propagate return value in ->attach_dev callback functions

 drivers/iommu/amd/iommu.c                   | 12 ++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +---------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +-----
 drivers/iommu/fsl_pamu.c                    |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  4 ++--
 drivers/iommu/intel/iommu.c                 | 10 +++------
 drivers/iommu/intel/pasid.c                 |  6 ++++--
 drivers/iommu/iommu.c                       | 24 +++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c                  |  2 --
 drivers/iommu/mtk_iommu.c                   |  4 ++--
 drivers/iommu/omap-iommu.c                  |  6 +++---
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  7 +++---
 include/linux/iommu.h                       | 12 +++++++++++
 16 files changed, 60 insertions(+), 56 deletions(-)

-- 
2.17.1

