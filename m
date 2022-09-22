Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC75E5DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiIVIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiIVIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:53:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B0B07F5;
        Thu, 22 Sep 2022 01:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c29xseiriYqIvBqZ7ihC52QQGtyTSqYzhxjv4T/T+YRgl+yE4pM9EzJCSwWFjqzgSm3mu3KBCt+QE5aiQz2/THUPQhaFFMo0kC5gY0cBsXup2T9lS7bb8C6dru8xePgOEhQOHj5gHa7saCd/cg8K/vC3GsrTCpw1qKaBE44rduY5Y4jKyxwe87zgIes5DRyzmywdsVqUVJliD24BY2wOYDyFL656UuPjWSSHDgeyhznwUao3nsnsarb3ySYy+ek1y1d12hl4PGXTAt7CGlqPI6dzQMzwfaLjgNvIs1YnjvZLJJfnxTD2aLpyUv1K5TBkxrfpBdbM5HUYvWg3SWc/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN3goOaODWT4pgSlbtUftgvaqDKQIRPe+rNmTTmE7+Q=;
 b=WFTYogTqIrjHudkaYTGDOJUYWgHdSDdBMQVks5DOaS8mkB2r98fXxE91tnxD57fCCUmu8tEHT5gIEozC3n9yLjI3Z2Kk63V3Wfd3oA8AHdliNIfCmDPCUp2LOMyWh9ftbtRV5dLYK4OjM7hN0Y8P/LpInsU1b87X6uj6yRc2Hmu2HnCbu66rXmYlfbI9rRXEx3z3PxB86mHYhaxAm7L4HOfi1QnSgxexuKlJchC3HSHcKvOSbN+ZpiEOYJXcSc6e+HLf0/MHHQJmLrtcO4LK+CiCdYdjW5vf5c1kLYb9ptT8dODN1EtO6HG5dnCpEqkXDM3rYd3zDp6IAxJWPQXzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN3goOaODWT4pgSlbtUftgvaqDKQIRPe+rNmTTmE7+Q=;
 b=aVsy6fz4IUtJSAJFEDo9vw0qTOjvM5+sset6T/FYdfITCWqronHEDsCnXKuR3q9R31QplEWyhxKzpDW9aMcmArnNY2vW1hwPTaeAstqOXqzTUJBnlQjCVqryVx68UlaEHZZ85qb/V/yh01L+lt+vf36cLzanYDokN3bzUipZbl23SotB6SfYWl+G71pCuoTazNm7AA3dLcdvEzOFtmvTiNV2LSk5ScHUQlnD7Dm24boogbJbdO30ujm8UFpqjfPAQqLo3O+O+IraXCMck8iStzTC2Uij/V/hFToK1eiQg5UDd/P2YSaI7vQNpMXhbN5LVCYBdHwqYoXnSlwMn3KnBA==
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 08:53:50 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ca) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 08:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 08:53:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:53:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 01:53:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:53:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <jean-philippe@linaro.org>, <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <quic_jjohnson@quicinc.com>, <konrad.dybcio@somainline.org>,
        <yong.wu@mediatek.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <quic_saipraka@quicinc.com>, <jon@solid-run.com>,
        <yangyingliang@huawei.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v5 0/6] Define EINVAL as device/domain incompatibility
Date:   Thu, 22 Sep 2022 01:53:31 -0700
Message-ID: <cover.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|BL1PR12MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a632b5f-d5d3-4d4f-861f-08da9c77f84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqLl+7f+tI9yE58G2XJN3PdfmVgJwuUE6w0Rof7e9SUHAcseoR2UTMDlX0FP?=
 =?us-ascii?Q?9Hk35ztwr+pb5dAO5+icHMzPbBVy/TwXZscki3m3yN7biohSZf4SgCWKXzbE?=
 =?us-ascii?Q?LJ5XvcQWT3Mmxq3Z2xnUwqYNmve7VtAbg+zyb373ogdTYX3t028IiWt+pFs6?=
 =?us-ascii?Q?u//js3mM7pm6Tz9QCpMGCFzQDX3tCdlFWMIcMX0dy0p6TsXR2MckLELS7kLO?=
 =?us-ascii?Q?5BqC8FocYsYlrhBUVBKvmvxi71cHtwXKVe67Oz+bWACd01sB8cF4H5JbeBHc?=
 =?us-ascii?Q?BsbaURFlnRM+cDcIdUo7Cb+lgt9uoc9LRYiVGipcJcW4U91TqgT14nYnePLO?=
 =?us-ascii?Q?AoTu9qvmC6L4MSZIqVjH7t37fQIHr6rtiNabP70TCT9PcByuTy4yEZ4POS3c?=
 =?us-ascii?Q?DJWJvdRFOnWw637q9srf3Dssv0Jq4SKSxG87AP7ebmhzZ7VCX3fkwaw/xllr?=
 =?us-ascii?Q?D8zY35Q2htSpuuTvTLnLlSVQwqdYEc91uH2VWDy4NfxW+7EoQHsBmuXltMth?=
 =?us-ascii?Q?PZ0/O/0yOgoXaYwzllloVJz2BCoQcPOpd3bacCNMZ9BROMnCn/YndQVdPWvi?=
 =?us-ascii?Q?V3aDA53DhekbK8RxnTYUS1DfskXHKFL9Y8dOkZAU46ziHe0EhtrzU3gfOARQ?=
 =?us-ascii?Q?h2QFcK4VwXB1oTny7+cpgzgNi1IdeJY0KJKchOcZdsff2Jn3bDqmuwDiS/4E?=
 =?us-ascii?Q?vtaNyVL+WiwXjAV/ba2NZLkn2njoAo+ctfIJghYOAdhfH1drIRiQGtGQp/Ah?=
 =?us-ascii?Q?783HqpXPuMV0gWXzHU8qz96ttagdf7p1ZJdoQ2TD9Hwa6LZmECuFPehGYlBV?=
 =?us-ascii?Q?gK9Dp8hOtTOvEELgE/OYkyckUkQZa1qGRVPwd9toFiOc6j6+9biWwGURIUQi?=
 =?us-ascii?Q?UIDcj7Ee7dsmSfN7SgWSut5ZJLl51T/tTMFD5rENc5PN/7ybn/zcgTqcD4HJ?=
 =?us-ascii?Q?GS6x4IMZeEswGek1043waQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(316002)(54906003)(110136005)(7406005)(921005)(356005)(5660300002)(7416002)(2906002)(426003)(8936002)(36756003)(82310400005)(70206006)(4326008)(70586007)(8676002)(41300700001)(86362001)(47076005)(186003)(336012)(2616005)(40480700001)(83380400001)(36860700001)(6666004)(7696005)(40460700003)(478600001)(966005)(7636003)(82740400003)(26005)(66899012)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:53:50.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a632b5f-d5d3-4d4f-861f-08da9c77f84a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v5

Changelog
v5:
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

Nicolin Chen (6):
  iommu/msm: Fix error-out routine in msm_iommu_attach_dev()
  iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
  iommu: Add return value rules to attach_dev op and APIs
  iommu: Regulate EINVAL in ->attach_dev callback functions
  iommu: Use EINVAL for incompatible device/domain in ->attach_dev
  iommu: Propagate return value in ->attach_dev callback functions

 drivers/iommu/amd/iommu.c                   | 12 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 --
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +--
 drivers/iommu/fsl_pamu.c                    |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  4 +-
 drivers/iommu/intel/iommu.c                 | 10 ++--
 drivers/iommu/intel/pasid.c                 |  6 ++-
 drivers/iommu/iommu.c                       | 24 +++++++++
 drivers/iommu/ipmmu-vmsa.c                  |  2 -
 drivers/iommu/msm_iommu.c                   | 59 +++++++++++----------
 drivers/iommu/mtk_iommu.c                   |  4 +-
 drivers/iommu/omap-iommu.c                  |  6 +--
 drivers/iommu/sprd-iommu.c                  |  4 +-
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  7 ++-
 include/linux/iommu.h                       | 12 +++++
 17 files changed, 92 insertions(+), 83 deletions(-)

-- 
2.17.1

