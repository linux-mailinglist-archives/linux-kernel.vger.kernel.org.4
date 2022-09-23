Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D775E74AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:17:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2B12A48C;
        Fri, 23 Sep 2022 00:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv3OGB4McI7/oXWmhvp0QIsVlMdLNlMeqlJEpmo/KVx/ihB+ms9ccTbCH5ey0sSOPixMXCqcVLZjYgZ9lOEn2N/22ciYqG1yDrzUb47R59zO9JWr8y9L+0qzn/38lSfRwQXQaMyEnJjMpkfO5lhrHmp98QZW/K2yANe4A4yvqBjcPnnNmkDuz7UoHY1h5V9feqtrlpmrtSU2rt0Xh1YxgdTg7QvQBAS7fgP3TEyjsm1+BmBe/uz9wILJoe0rl8oqBYWiDwyorGS+r4P7z47hj/t4jFUOvJUIPLE7hOQ78VhcC1QDaNpxyXZ41GblG0Kncicw0URwqfttc9XSmkmBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZPNzbGnF3bdAmJBreEWb8mX+pdoRg0GVFKks/IvH4w=;
 b=jZIdhlX4rl4iReBqcegkz7BkY9rdgp35mCZIEcq+/49Bj8zobrVEhOcH+TO8WnnTaq+W8VXCi2l6qfYkAadmazNRU+/uO7RZnrfQqBsVLa+t131z0Zx7rx37NILx5l1AmNeB9R4OCaTfijzAgonL32rwwIgD0mjFh1VFzAS1N4C8S0LjNFWiSbnQlVp2SNAAD94fy9oM1yFwWSgoMFI2W9PRcUz2PefTBkG6386S5y1/Wlvrtzf82iKKIcIxFlHCqKB8rno9aJxR55DMsB3YQudTySZ26enmntIGxAkq0noavKooy0a1wLYUcUSDTRdpaewwYKS35VJx7mc/0ik0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZPNzbGnF3bdAmJBreEWb8mX+pdoRg0GVFKks/IvH4w=;
 b=D7BQliRzborA6G37n6tT66Mnb1ItcITrXia911aCmBew3pmAN3DwpdGRISmzv9xXCVeCUR0ASub3tHqWEtrEQRh03fJlCneFvwoIUJ3CR3pvrf7nTW2U4CC24ZAA9elnVu+8FmIaed5mYimU/vS5puRXEaqhl7wiEq5cFjZAVWPCUgF/C8GdlXg/mpzMy6irrOFb2mouWgicjwl1Jc83fIDN91UsLBjcIQiWwQgIZgyyWJTifL0SvW1aGuxyI4Chn2mikH8FLhgBETcPBQrUGYWnL7u3dQOf8xDclarPX3mpDzcqJ9PlYF3BeKD6DbwY9ZntTuiLc0ryr0lIxS3i2w==
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:17:03 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::fa) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Fri, 23 Sep 2022 07:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:17:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:16:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 00:16:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:16:51 -0700
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
        <shameerali.kolothum.thodi@huawei.com>, <tglx@linutronix.de>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <yangyingliang@huawei.com>, <quic_saipraka@quicinc.com>,
        <jon@solid-run.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v6 0/5] Define EINVAL as device/domain incompatibility
Date:   Fri, 23 Sep 2022 00:16:29 -0700
Message-ID: <cover.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 59104706-5c5f-472b-46e6-08da9d339d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNSvFFngBScVRTWHkQ+8yom9BR5m4PdAf1WOovXIKr4J4pPt3A/1Wx/+BhhR2Wtiv9ZDCSS/+gjOHYonpULw6bcixdfJGG3vtDwMRjx8FSgtTHxlw7U6/54dV/18w97AXnPB27TGbVQC4msdVYmd9fUObJ6RpDdihyEw2P9Q56A66kmZsB9GejYnZjiajuNx+BAuQSmlYLlV12PMHiY7GRQtJfcCuH9y6/uASx5ymaPd8dhRpPO93TNPsBZIgWz+lBAdPImD/yXZc3gO4VXp0z7HASScCqevIfCdW9ZmOmbUzOG7jHcoGoJsJ9L7DsjFMBbwRwK9fBJ5NZ3LdgnPgYAG4jBAXjMfAkR1vrwv6WPU7ZNPVbABeqi4IAbZVJAfoKMkOqpmozQJeJNKeU0VLJRuf6OFPPNHUAEaBbmtgfppsT8zew+gUJv3nz5kaBqHnn7zQDXH+vY8pO5LBQcY9VAzg3ySFvTeb6SqEnFLjDUClqIoMclpugk6h5k/gmUbTQtxoVpoKcQ+jrZlQoGAIyPKZZJhGAwv3iPbX0qxg79MStMrxjfSCWRflLEHGrGlM+JZy1H9+sU962w2ex+8/zEUzKqdcMcRj4zLToNCugZtzREcCSRKvyPdGituxhBZ+YjNOn+g7NlPat0Vq4zA+n4YZI59LxkPKDZHWsNlWtLUqu4vRSwDNlNmyvYZf60ZT7x7tkne6tsZpNSX4f8VpYByUkOiwoW+q8H/hqYEJ2latwGteb/hHg2A7GR4odXQRCX6OzEpBhbR0c7DgHcwESss/iMLZ2ljXOmsOUmOjFoplwdVQOVn64i8lClvMkFhVU9y9cVe8SBnKT99Vse1RxagBYH3bV4lJYvHBXbElqWoYxi/V2Qnj1kbKVxKlfakHy7V+pHjD1AJ2CTjDjPH+A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2616005)(426003)(336012)(83380400001)(66899012)(7696005)(40480700001)(966005)(478600001)(41300700001)(110136005)(54906003)(316002)(36860700001)(47076005)(36756003)(6666004)(2906002)(26005)(82740400003)(86362001)(186003)(40460700003)(7636003)(4326008)(356005)(8936002)(70206006)(70586007)(5660300002)(7406005)(7416002)(8676002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:17:03.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59104706-5c5f-472b-46e6-08da9d339d5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v6

Changelog
v6:
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

