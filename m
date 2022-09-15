Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799245B95C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIOHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIOHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:54:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9659249;
        Thu, 15 Sep 2022 00:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNnjYCkw6tyUXsT7TJEOiNqppYCM0k4F+K2qA+jNg/pwmFDJqEFyXBfq0JSo2Wnx/lFNTAI6fubMarndH7EzhjIkszaFgh77Cd9nXQSg4P8VLdqLRvS42UT/Zaw5CJL+hCbhYdyeQD5elzKrTopJJa53uA0oYoFRZAXiayNhMNeoeLXaqeiViDtOk9YNG8RtOUGSO7rmnYM2nGHnAUjXA3NlkQkQC1N7MDzNFaEkt6cEK9GhqcXr2lZwCXNnzI7oBKLjJiD9w5NMUgieNbKOE6HI0ooGyrtT3PwdKbElsPbAxuhA1YbeOh9PUk/vsk+nHu/LDLRu8cuwclpwizY2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbZk+6M1tnVlZy6oC51uthw/w2lD8Qhf6m/SBIPvr+Q=;
 b=fmhGfkaMJLZJRL285XDWR2GnRQ/gRPRYNcBLos0VWbzJcaacDwTcAdLtRaskAYB3hoZEhwZDnG9HMyOK/dQJ3/uxT8lNxjmL5Navj8J9vvTJ4hvDyiXA0CoPy+38+mVTx9tu/u+nf0OtAq5BgUXxxs5WsKuVcDiZLgeqM49g95ppFTMAT/lN2tcBwIwgSvLFZyyPx8XPOnaGe6JOw3QZ3xfGgI6eDK9e4rzjmyckHtT+gRF89r+SGN+vsdJ07Z1GUoxCWPsLB99U2xBSuCEt7csSLLWpsaKetgxb8GGa2/WNb7wYu6A6U2HHRjtTGkuN+8RLP9ZVpi/acDS0UW825g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbZk+6M1tnVlZy6oC51uthw/w2lD8Qhf6m/SBIPvr+Q=;
 b=ofmzKrl2m1JmXY0mGfz8QP3vnP+06JElQMkBPvy1whwtv1cSi1AZYpxaUaCqFohRnD4l6Wy6dMv4gYqGr5/oc+UXMqhYFxJ0mdeDS1YwEplld4go+SUHKYZeXAXNeU1jP2Ffike7JWZT1hVawOMBHt7evDn3JW5q9yESOMVXGpLMXpq7XVjPb1KmuqHpEVoe+VZt0kCrS5X8nuX4tpoP+hkXfoubiN7PJvlSCkaQAO5GKA9Uvztz5EAx7ZjUY3wrrU1FJEWNqDmCforbn6jqjlVMXdCMlMnt1IIDskF1J6cGDPLAP4yzfXJ8+TZgivUAAP8MdMK1CkHNuC0RmyyQww==
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 07:54:04 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c5) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:54:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:53:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 00:53:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 00:53:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:53:49 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <jean-philippe@linaro.org>, <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <konrad.dybcio@somainline.org>, <yong.wu@mediatek.com>,
        <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
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
Subject: [PATCH v3 0/6] Define EINVAL as device/domain incompatibility
Date:   Thu, 15 Sep 2022 00:53:35 -0700
Message-ID: <cover.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df70259-09ef-474c-0d51-08da96ef75d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?topI1eXwytKB4wbkISJwNRDDCOeXbHqDycpH+1oyBgE114jT9EO184h+7IlK?=
 =?us-ascii?Q?qy8xF4a8CYMisVNUxV9uuTjudAbGS7sGHxA0PRSERa2vl4uPuEKA/Ilblsxt?=
 =?us-ascii?Q?wsRrNRly2Nd1UjccvAbEZvvpZfa4vQpqNw0Lym+S7KMv/BgMos11tjQb1H8T?=
 =?us-ascii?Q?eQkH5LljRnWncYg7wpjwmGeeBko3MQk3JwEPMGtKRpp9fh+b8u/33ZcG+Sfs?=
 =?us-ascii?Q?dk8Vs3pU7NDRYZADooED6supzewhKMhO86Q6um/f0DK4NSmYEDPHu5bQlfeo?=
 =?us-ascii?Q?Ox+ZT3PmUzgnbjIA0NQKPwxC2xRpSqeXd81oiGtkqGh8id+1CKP793Kc6y+q?=
 =?us-ascii?Q?PZghF4CaU83xc87zbVkdW1zfYXp1kdECwSmgB/Sogb7OjJvOHMtiRKm+j3An?=
 =?us-ascii?Q?5oA9r56XAsBSi58Oj7kT+r5Pcn2bM84rt/CHXE9trEjikbY8dscAGmyOAFx+?=
 =?us-ascii?Q?vdPvq0mXdjZ2inMsexZpAd1FIzvicaEOpDvsJYkcHXptvAc7ZV+dREeSD4Ow?=
 =?us-ascii?Q?Bojqcr8XLEu+159jgzPNGxhfw5zqe3xo14SBIzK6Wm6UURjYQv/OqoTClAcv?=
 =?us-ascii?Q?nDYXNC5n1fM0RBg8Nwp5wdc0s9MgVTuI08lfWAk27yzcDgrsUBsHwT5OxVb2?=
 =?us-ascii?Q?3o8i1knNeKztl4r/UsGA3vKNRfy8HClKhl63jCnjRhWSRnwljxmIQybf5dB7?=
 =?us-ascii?Q?QSOA8D2Ia/DqbA2fCaQdwYuh7hzHVQ2hgKRKqr1AvfQ6SHDopVh5JKmsVPsp?=
 =?us-ascii?Q?H6hViknYJ3BAMCFDpki2ADolw2SW6AJacWEJ/Cu5YMCF3s6B2VNxbmVlEels?=
 =?us-ascii?Q?/4ZiAheNl4gmZ5pdQmOq8UAKvnrJ23i3RFdQu21Yo8RZn5XoKY26FhTSSqP1?=
 =?us-ascii?Q?fYQEBwtZqOD9jxsiWDhYFpXi/FrYc0rNp7u4flgLbMk260zjDbVATl1OQ7C5?=
 =?us-ascii?Q?uH5vS3VJfazktWj4hE5EXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(110136005)(966005)(40460700003)(6666004)(316002)(2906002)(41300700001)(426003)(2616005)(7636003)(8676002)(47076005)(26005)(70206006)(36756003)(8936002)(7406005)(66899012)(336012)(356005)(186003)(36860700001)(83380400001)(70586007)(40480700001)(82310400005)(478600001)(921005)(54906003)(82740400003)(4326008)(86362001)(7416002)(7696005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:54:04.3096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df70259-09ef-474c-0d51-08da96ef75d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v3

Changelog
v3:
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
  iommu/msm: Add missing __disable_clocks calls
  iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
  iommu: Add return value rules to attach_dev op and APIs
  iommu: Regulate EINVAL in ->attach_dev callback functions
  iommu: Use EINVAL for incompatible device/domain in ->attach_dev
  iommu: Propagate ret for a potential soft failure EINVAL

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
 drivers/iommu/msm_iommu.c                   |  2 ++
 drivers/iommu/mtk_iommu.c                   |  4 ++--
 drivers/iommu/omap-iommu.c                  |  6 +++---
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  5 ++---
 include/linux/iommu.h                       | 12 +++++++++++
 17 files changed, 61 insertions(+), 55 deletions(-)

-- 
2.17.1

