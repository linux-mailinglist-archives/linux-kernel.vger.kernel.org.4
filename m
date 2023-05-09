Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886266FBE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjEIEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIEwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:52:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0FB30E3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VstwDOMQW8bS0Oghkj0o3NHUQRh+2odL4DxB3U91YYtVRwB/nXNI+J3SNCEFDBcgJdUJAAUJlFk3N36E7fLDpOqYmjlBDsq+HeCoyPbRKvthuSslo31Ntjt7gZXz37rK1i2nC5kDLEVY4lvHOkUrGR+u91Y9nAHg2CCNRLbAucHvejw8YVPriDzNQ3eNnHkbLkV2yd7lipcp6MXWZEdp6rA+S/DaKwTuapCESG19ihL7b2ReTDVE3tDH4bRgF4yTHpjfetUO024bVkbY1qaaTSXagvhBmRS2VVewEq676VrY9dNC6Av9WQzT7WcUA+vQG3JYoirG/HsjvwHHFsF+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ef5NRH8tC9RA5J8xFZhniNG9977Rwv/V6yHHHmCvhg=;
 b=bbOlShlghMQ7bLlAZrwlTwqqCK/FsfAUsWBJiGAXa58c+0MvUtm9SLw2pcazERGFuQmT/pwsSV7GRKYRNvLTzWv3R6Bjp3pJnksxWkzxloV9Mdqq9QCWoohCu8FKN/E9T+W9zZr5nwiFTcwmyGVZDeU0HutsN4bGKPSvAIfyRHMaDcPMitU+m/tylx7xuX7+56c/RO8VdqopaVAEeK9k3rSwUEOsUlAqAKyOEYVY89psLVXjc0d6IirfGfYAJcFhdh2NmcUaqL/0AVPGumTDNMYcHFpU7bmvoVYhsSvy8MEYFe28x9i/FF+f5VC4ux7OfzHUAtskdMdhvvtzTXBE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ef5NRH8tC9RA5J8xFZhniNG9977Rwv/V6yHHHmCvhg=;
 b=DOg95UXBYD/A7+GqUKy3f7mZqtOPNYWWjsS7cnmklnAXs3upQm2ByG/ykptpcI+8nLxrI/hnbJHk1Ide0Ue4jiCNH/dc6VPtRepgrc96+vlT2EW+jLYgeKDOj9u6/ZlXFrmDFOgjAyaBXckV7WVqJ5WGcflY+M/4ooYJlAfoA+hXrOP/ODylfqtUm7bmkNSuDcaP9nrXngoL24TRbCqN+6+hK7+9MPfQsm8/b/YXMbtuvGKjVtZAd+7C6XNUjtgFxQ4MybEVHt8dxMOCB5fqjOXDZK4Gclnr4HwMAxGO/VSn84Ot9sxPHRv0v6bVvaYa3lIyAL97ePcLT410aDj6dw==
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 04:52:07 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::7d) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:52:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:51:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 21:51:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:51:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 0/4] Add set_dev_data and unset_dev_data support
Date:   Mon, 8 May 2023 21:51:46 -0700
Message-ID: <cover.1683593949.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2439d380-f712-43a2-8f47-08db5049243d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjtdlsGYFXV4oHeWuPup0czmUAiADfrc77Gg0oB0qpIKnVngORlWbh54Ttth8Q4ijd4MbrDTKbeAJ4tl17Cn1cllDckrq28ZTnF/fMFFsScZxtmU4WlJESKyKfPpqG8druAp2JXB1W5ta7I4PXUqHYp4jBy83cUJCHEVtQZa+4P73eD5FYIPU2e9DNLgdeF0K/j/b4uAAJIuHcS7ppsDSy8d10WHjJOPR6+H6y8qeHINwJ9/8mwe57G1JE9ZBYKsX4Mr4v+dKnSxlZKRXKHPXd9zcNL0IIOzyQzWAx/Wtxu1CgEmbesH1DPsaOqGm5idEUYw1CDyDLht06Hdz2uS+hecTSVfv54/Zq92Zm5d1m0LUXHyOvTSAPtsWXVSAsEVradgg1cOub6/AWPanidlzb/NNYk1xMSs7AhFLMErLbTEDtg1guddL7roH9FSJAhKgQLevKuCQbg8R+WNYCFbKa2UisBUnrbhkjElX41V3LYsIPOh4ybtWLop549kqRvm53smBW43TqQF3TqDI2yaS3McXiWIfv7GUuK8wtqo0b47e2V6B21gWFwA4QmHkA8EdO1AFT09RGNa3rhlZwOEErWvc+VURsJZC/TRC/7LWJiehCUUFcwSxta626bTTYo7av5jTvHOzsJEVnj4bV54wzuM/rHEsBzce0vvTPtAUmJ1n5gAVJxiUOlsGmFaixvwqmvq+yfn1cVyCOC3lrztPC/W2oz50zbYCriE6v9fpemVxS/YG9I4e5T9Lb6grA0oLQq+hePRJHTet0HrxKfhV6+TLFceoDt5rEcU7JoLEMI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(83380400001)(40460700003)(36860700001)(2616005)(336012)(426003)(40480700001)(86362001)(54906003)(356005)(7636003)(82740400003)(110136005)(26005)(7696005)(6666004)(966005)(186003)(36756003)(478600001)(47076005)(2906002)(8676002)(8936002)(7416002)(82310400005)(316002)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:52:07.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2439d380-f712-43a2-8f47-08db5049243d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v4:
 * Rebased on top of v6.4-rc1, and iommufd_nesting-v2 (candidate)
 * Dropped WARN_ON in the destroy()
v3:
 https://lore.kernel.org/all/cover.1682234302.git.nicolinc@nvidia.com/
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
https://github.com/nicolinc/iommufd/commits/set_dev_data-rfc-v4

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
2.40.1

