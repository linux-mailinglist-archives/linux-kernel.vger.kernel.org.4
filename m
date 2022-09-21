Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E835BF903
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiIUIXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIUIXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:23:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5586FE3;
        Wed, 21 Sep 2022 01:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEFOcsu9nVVWlaASDda5wM1nX7ddHQ8Iv2gwz7NbCM3fTgpen+HdDH1CX5xDkPanML02USlGMgxkhvo1ZCoDfcNpyI83kyxea1uWFRv1ifQ7xabG+S1NXOkpxQC3yccNOgEkUyEcTtoMglTON/uc69FmCE/c2n38mBldCkPfzfHMfb1WJ3C+vYSMXsEARdjZVx0yAGuf76kxwDreK13leCbqx67kwf+iHhag+yy1/6+XOnY9uZED/9Z0NXrKlJF8KykakJt8VTwkQvl4PfEMNXrmG5cBmhBvoyQx7WSxXuGDM8D5fRLABMrXiLfdgi8oWy7AtqIO7ugsHUHsBptesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo9tgJcuPtU5bqrMEj1O+VgX2/d9bdP4lVcq2Zhv7T0=;
 b=U1eF6Q3Hbf3NFS0xi7vK+ee7TO3MArGQX4MlkxRux4Fo0H4EUSpgTxF7dInNFtUHThKKpj7+39e36aD7ztKnQf2VtOM8VAtJ0fTbPTdGiMrkthfzlwXS6Vfy6k6Pj1t96s6rg1gpj7diiBMAduPFLmEOEtrXwtG77WY3iWGGMfTTeYVl/Ws7uNDHVauT5D8nsxV75tFgNMfbI/t49l7Yjg6KdxTDswQwL/jlUlv9fvan4qhzrk4ovaYV0Lz2jq74PyGDiqPl3plV2ZPuHmJaCVYjaRRZ4M7QNPFg6HVqbtd0HeqwUdNqqoOHdMkp2Bua4MgNgrDxIZEgvxsg4zdQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo9tgJcuPtU5bqrMEj1O+VgX2/d9bdP4lVcq2Zhv7T0=;
 b=ojyk11rCKddYqoU4o9xTOEdvQuTikeRnfp35x08TBZNhDGZev3DiJrbauruJKphkJpSfm+p4ki8lo+s5oNzybOVTq8VYQk1LYBjH8yu1bG4/9uBzzJdj+Z6WRoaQ21AzFST1szoiJsP2jYCF7V+hCuZ9VfyMDIH7GBlKs+56KL/q4hj84g+eu36gd8M1z0rAqaRa36uMZvUkmo4SwjN6FBy/j6aJ8VJH5ifmPZf9e44NTfIQvdH6rB3lh6v0LQo5i4RgZ7JQ4Z9PRxYuRDPe8bLCCuylUOfgbkHxOD3zAzR0ocWsi3ezRXxSfSTeGzNFhFaPB9tDzFj9/UhwsUA5Cw==
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 08:23:02 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8c) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 08:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 08:23:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:22:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:22:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:22:45 -0700
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
Subject: [PATCH v4 0/6] Define EINVAL as device/domain incompatibility
Date:   Wed, 21 Sep 2022 01:22:31 -0700
Message-ID: <cover.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: ab678dff-4d9f-490c-fa6b-08da9baa7fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OwlnUFD1AlN3gP4Yb3pQrv5FlLKJ5B8bnygyifARXSD4jgNbkOocHaVK1cy?=
 =?us-ascii?Q?cmgNpSvilMNb98N85/WfnbzMYavyQeR44+2FIuxu7q0OENi/nC5/9l1uxYO4?=
 =?us-ascii?Q?TW3AJx2tGkK+u4EY1XVBZAIK+btTDzoooDajDnuxUKjdinwnD1hBmRKvsVlC?=
 =?us-ascii?Q?eGZMdoozEpFEib+l/YojeJ2sfmc+mYo8Su++P7CEZLue+hZjQnuIv2FhLRdZ?=
 =?us-ascii?Q?qmOv4KaqWDgfO3SkOKKaSjWmIFK1K220HysKXY9FGb/DCO0XQbU9iDIeaHTR?=
 =?us-ascii?Q?9GP/sMQuUBro0oPu6AMqyOQuY/To+JtQUXDRhcSGHrCHyEg59qubtGfpca+h?=
 =?us-ascii?Q?KCeu5B9PZw/NQr3XX1br/4KijzmvZnJxEi+AgDRlA4KslOF8zh/ygYGlxU84?=
 =?us-ascii?Q?FaXat878zoiflEGvaa+OcNoDLdraICXWaRnhGM10T9pr8Beozm39ySsicQZg?=
 =?us-ascii?Q?eBwR13nMTnBnXiLQbLV/5k9pcRav1d0aSrAaGX6eeDB//PzStr4dQKvA6E/z?=
 =?us-ascii?Q?DD/FO2wN8FiP+ed+L+nGGMSh/0ydHZGL7CiBrFE8G35HEpPaIqoZWn6xpSyp?=
 =?us-ascii?Q?5K4px9VETr7Hko8qH86LnL5D1LSJNaZECX9dyEfe41uae8X/l+JkLUKEgVv8?=
 =?us-ascii?Q?FAGXCdGsCXEctNQh8M9dxgQU4leQfaHIXy1bEkEf8S14QadRD9wOqSIpCCMu?=
 =?us-ascii?Q?Ry2jA8nvPixB6KjVhixWAWNxp9i/vcCP1/ARYve/a0WtnUH19i3W6sOqHOty?=
 =?us-ascii?Q?MBzM/05rfB8aH651cKoz4FSFaCTRiyDvuet0fJwxjkdpXHfc8t367xYOIRCp?=
 =?us-ascii?Q?CVZcLoFAt/PpCHnzgwJeE+klclXJaPIGXdS8oS3+ni7908OU1ONmMs3TiJDJ?=
 =?us-ascii?Q?Ypci6bL0RSPtxm8Lj5nVdKRNaYrAhnDofjDqEdj2vrs13aRvtDmZFC7SGI4E?=
 =?us-ascii?Q?fHx10kgZZgBOJZjTwYX4dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(336012)(83380400001)(426003)(40480700001)(41300700001)(6666004)(186003)(82310400005)(2616005)(47076005)(36756003)(36860700001)(26005)(82740400003)(86362001)(66899012)(7636003)(921005)(356005)(40460700003)(70206006)(70586007)(8936002)(8676002)(4326008)(5660300002)(7406005)(7416002)(316002)(110136005)(54906003)(2906002)(966005)(478600001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:23:01.8366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab678dff-4d9f-490c-fa6b-08da9baa7fee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
https://github.com/nicolinc/iommufd/commits/iommu_attach_dev-v4

Changelog
v4:
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
 drivers/iommu/iommu.c                       | 22 ++++++++
 drivers/iommu/ipmmu-vmsa.c                  |  2 -
 drivers/iommu/msm_iommu.c                   | 59 +++++++++++----------
 drivers/iommu/mtk_iommu.c                   |  4 +-
 drivers/iommu/omap-iommu.c                  |  6 +--
 drivers/iommu/sprd-iommu.c                  |  4 +-
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  7 ++-
 include/linux/iommu.h                       | 12 +++++
 17 files changed, 90 insertions(+), 83 deletions(-)

-- 
2.17.1

