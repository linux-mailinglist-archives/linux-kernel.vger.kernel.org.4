Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA96B21EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCIKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCIKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F325E8CD0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyEVzyegBGuoCz8RorXkZBJIoSH8baR1J/72YxFWNm2mX2NGedtxLMwkCmswl8wp2xG25wKFGzb0jAgYfuXF6QQl2yZzV7asSys6fGASvDKPXshP7f+FD8Zz7QbCuh4qz/Db58QjZtNwniB0yomJYZb1Jl38Oxjnm2MMTzJQ2N4Hd+BzTesFBiXhpjXC+zF0hsWoEoRrsOt/NObUgpwMeuunrPaj9RS0M3t40b80Iy71zBdAs8cEQugdCmgU+b+6uE9rcNzC0n8wWZHKhzxQMnrGHqON1Cyaicv/M5rLoRT9N530OFBVoELscPZ3n2EeeksNbSAVu9iKSvauhHYF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmoi4KBsEm3qJEPXGjA0t/NaPSxtMhS24o6WqAYI6cU=;
 b=Frjjc1UK5f4fb8Ej38b2lVd/KmkNrLv+1cvf7IxbWLzVuHoORJnAwafJTgYDGm+Dmo3teoZb0ynkysrJ5aAag57pgJQoj7reunBWAJoQrAzUUGrv3vAy4s1A2JvufYyIVsE90yy+ZtR75GK7dkdbAHCAG7ujKvfAKTBPCkaSXiPsBKlX2WcEbGYRTjqcKxewmyavKUQLPTV8L+LyuMDYazweq9TomUKtOhg/oxnnj/eHILLZpLJ8buK/5YFQB2p/ixMFE1rbxpSvgchZ/6REyRVkhhyhpG8F9iA4lB/WIk321DG0iM/B0cgRo2n920WNLZrgSnTSGQ5lvw0g5TvACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmoi4KBsEm3qJEPXGjA0t/NaPSxtMhS24o6WqAYI6cU=;
 b=sOS5WwxqPSaKlWS9Wu3Lo7mOT1V19Cy5XZPefiTxW3OsmgNeNUX6oEsYiUb6e8wq0n0dWn1ifxDBLP29sWlI62JrGNKldmBd8H0F8cxf5ZYDrFInzPVVm8/hk1EakUSUeZc7MjSGGgr4M2dsuiHM/CXyxZXANyXuqaQLbKiJ6Q45i+LeAwq9XDqFNwItL8OEHso28+6yKeeN9ozooYaVN8F/iCIiMCCsYfQEANbGUdxEs/Y/Q5Fz62eo74iCcmQ0XDkEIqx4aGCFpuoA8TbesqNL9iWSxyH6NECcoIR5+o3neiDgibksDmv6AWRyWUcKp6M+URrNwXiYDOzEdHMk7A==
Received: from MN2PR04CA0031.namprd04.prod.outlook.com (2603:10b6:208:d4::44)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:54:40 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::65) by MN2PR04CA0031.outlook.office365.com
 (2603:10b6:208:d4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Thu, 9 Mar 2023 10:54:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:32 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/14] Add Nested Translation Support for SMMUv3
Date:   Thu, 9 Mar 2023 02:53:36 -0800
Message-ID: <cover.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: cb89da64-aadb-453f-e781-08db208cae8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo3IEhZlm+i1LLgRF79amTzo3Of0jJMzkO1harKAv1svd+qGb7+BvrU7K4FDg7p0Ztt1+QyexkpLK5XD4pV7q0GeYzDMrohzZ1cgt1NghUcFxHjordusQEO6JXBvw7EqvNsNrMO7qE2GHr2yPQyJUn+zgpLoLxi38L+RCfO9HXrfwVvYb/VUDVwQXNldNzPucGo0X+K3OwBbolk8OS0OIW08rNV5mUaJ/LLr99HrJKjqLtrydKUhdNewp7RDNoTq0mWu3ZD2MwMPraCFi5OVvWGfbY+InUidTajnVbaJLzI83IsW8KBPTKPYhAMk2GyGcdKQ2Aqz70fD3UMlVe7+f1gLB8drvzbj5eLJufNYyTOncku19vt0Q6S43A6NL3bKkLEYoVuroJh0k6ZnMp081j06HleHcPROwnKSKXQG1703p4xY4oa/z2eXTbkRl+JTNrKvaPZEpTDBTZ11DhQ9EeYsIe2j8JVZdqW9LVXRXzuT5K3hL0GZeTCEZgHx/e897CZvJeNMSju7T1XgWZ3BsXJDMIuDNFqVGdzwWfTzblkYJBNww8vhi1FSscikWrJHOb81dQkftSMo9mlne4jrnYl2odAbThAHtgP/AVcRMQqdWF0CfR9eynJ/gA6Xuby/utPvK1WXXNNdp8axIKVbe2B1SF79ivY+YbHgzBZj3pG7YS5blKYkPb7XVq7vEvmV6NWgExDA11lkw+weMKjAeIdw96KIuiiEVWjhZf7RuplIuznrsIanmtCJNZvCBxC78BXv2qGlNXb1PP6s631pBcwI40uXqcUHMdCicaXHlrTjAeb3DxHMEhZ3jznDDAupctZBRj5AwfI+YIOrSYh3fQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(47076005)(426003)(36860700001)(26005)(36756003)(86362001)(478600001)(966005)(316002)(110136005)(54906003)(356005)(82310400005)(186003)(336012)(41300700001)(83380400001)(40460700003)(7636003)(2616005)(5660300002)(70586007)(40480700001)(7416002)(7696005)(8936002)(8676002)(2906002)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:39.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb89da64-aadb-453f-e781-08db208cae8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series of patches add nested translation support for ARM SMMUv3.

Eric Auger made a huge effort previously with the VFIO uAPIs, and sent
his v16 a year ago. Now, the nested translation should follow the new
IOMMUFD uAPIs design. So, most of the key features are ported from the
privous VFIO solution, and then rebuilt on top of the IOMMUFD nesting
infrastructure.

This series is rebased on top of the Intel VT-d nesting changes, so as
to reduce merge conflicts at the uapi header updates.

The essential parts in the driver to support a nested translation are
->hw_info, ->domain_alloc_user and ->invalidate_cache_user ops. So this
series fundamentally adds these three functions in the SMMUv3 driver,
along with several preparations and cleanups for them.

One unique requirement for SMMUv3 nested translation support is the MSI
doorbell address translation, which is a 2-stage translation too. And,
to working with the ITS driver, an msi_cookie needs to be setup on the
kernel-managed domain, the stage-2 domain of the nesting setup. And the
same msi_cookie will be fetched, via iommu_get_domain_for_dev(), in the
iommu core to allocate and creates IOVA mappings for the MSI doorbell
page(s). However, with the nesting design, the device is attached to a
user-managed domain, the stage-1 domain. So both the setup and fetching
of the msi_cookie would not work at the level of stage-2 domain. Thus,
on both sides, the msi_cookie setup and fetching require a redirection
of the domain pointer. It's easy to do so in iommufd core, but needs a
new op in the iommu core and driver.

You can also find this series on the Github:
https://github.com/nicolinc/iommufd/commits/iommufd_nesting

The kernel branch is tested with this QEMU branch:
https://github.com/nicolinc/qemu/commits/wip/iommufd_rfcv3+nesting+smmuv3

Thanks!
Nicolin Chen

Eric Auger (2):
  iommu/arm-smmu-v3: Unset corresponding STE fields when s2_cfg is NULL
  iommu/arm-smmu-v3: Add STRTAB_STE_0_CFG_NESTED for 2-stage translation

Nicolin Chen (12):
  iommu: Add iommu_get_unmanaged_domain helper
  iommufd: Add nesting related data structures for ARM SMMUv3
  iommufd/device: Setup MSI on kernel-managed domains
  iommu/arm-smmu-v3: Add arm_smmu_hw_info
  iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
  iommu/arm-smmu-v3: Prepare for nested domain support
  iommu/arm-smmu-v3: Implement arm_smmu_get_unmanaged_domain
  iommu/arm-smmu-v3: Pass in user_cfg to arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Add arm_smmu_domain_alloc_user
  iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED type of allocations
  iommu/arm-smmu-v3: Add CMDQ_OP_TLBI_NH_VAA and CMDQ_OP_TLBI_NH_ALL
  iommu/arm-smmu-v3: Add arm_smmu_cache_invalidate_user

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 267 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   7 +-
 drivers/iommu/dma-iommu.c                   |   5 +-
 drivers/iommu/iommu-priv.h                  |  15 ++
 drivers/iommu/iommufd/device.c              |   5 +-
 drivers/iommu/iommufd/hw_pagetable.c        |   4 +
 drivers/iommu/iommufd/main.c                |   1 +
 include/linux/iommu.h                       |   2 +
 include/uapi/linux/iommufd.h                |  64 +++++
 9 files changed, 323 insertions(+), 47 deletions(-)

-- 
2.39.2

