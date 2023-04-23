Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FB6EBDB8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDWHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:41:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3F1FCC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei0BmFOC4ii1p8cyJiYcf4QWNSKFk/kBOFqJPMRUYtunuXFjiFsj6/G4qA62BtPFoWwcXkykfXuxAelwqs398s9dtftjNrreXkHsOY0NCmhhYkXzaaE2yaqWz/XpP68touwG+TORVla9dUvXmUUZU/SoelNpth51ohMUNISLToQPXyGc1T0BtgArPymYvOx0teS01rnW7BE5X9ROyJUjyPjGjqX488ZJwp1HiAsICAyjm6pjDi+hN6QXrwlphYJCbA4MSfP7f6mLK8cJ8ck/NQ41zj/TNys71VGCuFHmsqcCb8oF6GADfV/8FdzdpxkK+UGEYaRdjNCv8J67o1sfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h8bFsY1cYly2esFXp36S2kufQYdt/NkN7n87TZxGBs=;
 b=fO0/KT1bjbuYO6hIiTJF/XGVIjJ+d6OPu7EDZiMfrNaw2evnnQRtRNiqvu5i1XWRICtBpc4EjTv1IQf4J69gURwbEZdmpA12INupKotmzCEoywrJZbDtFg0rwh9ShjPVSDMcnYv+V1FkBhbln3LYf58q2tL9SYNdU9tNBQnSBQ895iTcuL1SoypxXdnKNDZ5FIjfROqWp9cSxwZoBDMmSMRvS8Wm5hrQH3UjvuXzIVl6zn5HIz3g39XgJ/q3IMtksRYedhPV6YR6MSfTlI46neVYptLsOoKXwcFOiPG+vf/WvOj200KKg0HTbib8eg7TghIVcRcLXCRlUDzDnGeKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h8bFsY1cYly2esFXp36S2kufQYdt/NkN7n87TZxGBs=;
 b=nAZTOhEVs0ZSCS0wEWlPaD0CtnoDmWgQo5XPJZedxU2LDFFrGMHCE9MvqTEbWBxOPW8r06PSMEKw8S5IApZiGDplwCxe/MEkFKgFZKG6toGUIqpkpUSV4aA3hbGdYfCS3rLg3OLwnnK/R70W2dV8DumWmTTeOlpV918d829aNJUAozQGvzdGIk5/bsCCqjXfzsWG05VG6jgbEE0MojOwAWdSUp9gNcZ54dqNxVfy0u4SFxFI90hhJ+4garlg57e0xqeNG2y2Zh92nj/Q/uTeec3wUUWra985PWYGt9W5LlxVyT7doMId+j3d9NVQ8YeQberjw/rimLAMUvrayiELJg==
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 07:41:17 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::3c) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32 via Frontend
 Transport; Sun, 23 Apr 2023 07:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 07:41:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 00:41:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 00:41:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 00:41:07 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3 0/4] Add set_dev_data and unset_dev_data support
Date:   Sun, 23 Apr 2023 00:40:30 -0700
Message-ID: <cover.1682234302.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4dc375-25e1-4d69-c21c-08db43ce1ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwjMMgsWDmcMYdpTzMeg9RPwRFUMGArv53jWGE/R25ZZZC3qQXyt4GRSMqcSAqP2SljzfGd4+mmya/D5x1bDHwH1AuS2fweM4I0HPS10GvK5jFSTze+/CuaDH2Dvm/2YBO4f0oIrVqYzpjyjcd6luPSETxNtdej5FWxW89rGF5JUsbArPIkWq2EaQ5Gq/IipKDmAqBLD5rSb+BGUuOXQuXUQ8HKDuVNAaFwCrfWFsiFdTQyGNBH3X+6nFLYf0KicbbDuwqPdlcafy4sbrLFQci1Jin3jWtGZp6pXGNuHFago8Vda6ZrlerOM7VyQRqOVWNjOP+sLhpbN3M1Xj8ru9g+WStNSlx3+Vo7ve9+2CDLqgkQFr5M5pvRKm9mnKIxMTetqKY71X36ntMjfRpwBinrXx5wbGDfvyrMvha192xUHqv5lvSxornkQAoy6HzLsOPtbDFO/EWVNM1t0t7w6QjAGNHBFJ28uV/wdgcnkTnS1TP6CXjVCJ/vmOMMZQlssxcksYEAmrJoCIg80j77MfZqav4cc5ondPn8LOW6unxSWskedwGwMrwEqKgQ3ZUIqaYuhHerJGgfjQh8z78MMzOPwZnM3q0QDPejt81Bo0+P78ruV82401CwEEWUWwRdxQxatNvJbrGYyGVokha798Ftbj6VB85PqgsLtIbP9t5PVmSdXLz2QL0imKxh6VMow4lb+CyH2mz+BQ3VBMH7pn+bcWD3WRp8jELPvKOhxQJTMGI5YT+SUzQgLEdnRT1l7rp3J9cW/LqFIPV0w96to0ERnNnYZlN9fnEtZsRnBjiB8rXmtt/wIlXrrFl5FPaVA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(966005)(26005)(40480700001)(336012)(426003)(2616005)(34020700004)(36756003)(83380400001)(36860700001)(47076005)(186003)(40460700003)(7636003)(356005)(82740400003)(70206006)(70586007)(478600001)(86362001)(8936002)(8676002)(54906003)(7416002)(110136005)(5660300002)(7696005)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:41:16.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4dc375-25e1-4d69-c21c-08db43ce1ef7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v3:
 * Reverted the data in VFIO BIND ioctl to a set of new iommufd ioctls
 * Replaced the iommu_device_data_size array with a dev_user_data_len
   variable in the iommu_ops structure.
 * Added has_dev_data check and locking protection
 * Added selftest coverage
v2:
 https://lore.kernel.org/all/cover.1681976394.git.nicolinc@nvidia.com/
 * Integrated the uAPI into VFIO_DEVICE_BIND_IOMMUFD call
 * Renamed the previous set_rid_user to set_dev_data, to decouple from
   the PCI regime.
v1:
 https://lore.kernel.org/all/cover.1680762112.git.nicolinc@nvidia.com/

This is a pair of new uAPI/ops for user space to set an iommu specific
device data for a passthrough device. This is primarily used by SMMUv3
driver for now, to link the vSID and the pSID of a device that's behind
the SMMU. The link (lookup table) will be used to verify any ATC_INV
command from the user space for that device, and then replace the SID
field (virtual SID) with the corresponding physical SID.

This series is available on Github:
https://github.com/nicolinc/iommufd/commits/set_dev_data-rfc-v3

Thanks!
Nicolin

Nicolin Chen (4):
  iommu: Add set/unset_dev_user_data ops
  iommufd: Add IOMMUFD_CMD_DEVICE_SET_DATA and
    IOMMUFD_CMD_DEVICE_UNSET_DATA
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_DATA
  iommufd/selftests: Add coverage for IOMMU_DEVICE_SET/UNSET_DATA

 drivers/iommu/iommufd/device.c                | 81 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  3 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 ++++
 drivers/iommu/iommufd/main.c                  |  4 +
 drivers/iommu/iommufd/selftest.c              | 42 ++++++++++
 include/linux/iommu.h                         | 13 +++
 include/uapi/linux/iommufd.h                  | 32 ++++++++
 tools/testing/selftests/iommu/iommufd.c       | 20 +++++
 tools/testing/selftests/iommu/iommufd_utils.h | 59 ++++++++++++++
 9 files changed, 269 insertions(+)

-- 
2.40.0

