Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E66FBE71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjEIEwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjEIEwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:52:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737230F7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCed5Epf8IpeykM7XT2Dh5/r12X5SDa28V7XUlUKNbdTpWvx6ElDLcIUF9qHME15S9pQ761Ra4NcM1GWPHTJF6n1P27maW0dNPz5FPnRyq7iE4AsV4caxZ5Y6ph+kkYQMoLJTQ/KlkfKfKqd79S3CWKh8IYlZ8d6K/Ty/8BstZWsJZryUhTcOB6p8yMS8Hp0w6Fyw82RglpdP36+D5WWq7d4S2qSh2PTfGkpbvp4cqRYSXIrq1ubboAsNumBUrOqQharrODJ3MITVMrudH7wdSf5wIxefh6ZRjqk3A4dVnBFsaoIVHwtHb9qiXlV/v6CBsHdIikg3wlfgJXg0I27gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f94slq4ZIEql9YvVc/21MmU11JQ0VTeFHEumHYXAy/Y=;
 b=Sglh6W4WzXY4fRGz28ZiEObDf4l2XdSK0s8DAPAvScbf9u3s69V46TLvM/uBDa7LXMwv3IlR8E6NKVOftu768jGH0MiPHR6BvnNNVr6w33yaXXymIBVICD/ho1C70zsMROiutXws9g1No74TYuYjGlIjjRcg02COcCb7Cx7ls674Cr4yPFYGi8ADdzQwTPZqCuPv9TyDPVTBQJEc1kd6F4gKfWIXcuThDx/v079kVjICfEd3LhCEeFeqVpiCiV/2aNwSBrglNg/dOR6fXptO/tV3ScYThqBZTY9oat65P6hEfxtxtohp26azfPnTd+NuusGWhnVNsmjfN6nHXVLhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f94slq4ZIEql9YvVc/21MmU11JQ0VTeFHEumHYXAy/Y=;
 b=e6HI3IxQw3qq5TLKdUK2XCEwYGedd/Ap3pNSklZAwTqkDVXZWEM8Tscu9wqRuU03uDC/YJorrwY7XK+coKlXK1yPxES12mD2ubTqUu/JO8ZbTh1RWUjlQeh7QcmFTaugXTI/wE+HCRS7x1lf4KjzBqZsui8ikw/4xrLk4lRShtYf0BaNj4P7Y8AU0Q2juCCrOYDMxlk7yiP3Ete74aH+3myZxChnVWaTpgXUg/+GFKJuHg/HoY+N5cjy83ydtPvzLok4lKVlpIi/sjMX/w+iDOAqYpBnm8WUGvn7P82Vz9/b6fuDEnwSxTgEcIKmVi0hQSicakUH5zphjxV537ePhw==
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 04:52:12 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::1d) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:52:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:52:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 21:52:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:51:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 4/4] iommufd/selftests: Add coverage for IOMMU_DEVICE_SET/UNSET_DATA
Date:   Mon, 8 May 2023 21:51:50 -0700
Message-ID: <688dc847fd15e92c9fadd72d1dc92c2f15161606.1683593949.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593949.git.nicolinc@nvidia.com>
References: <cover.1683593949.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 151435a1-5270-44b8-f685-08db5049269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0a/ao+ykzGe+/YwzsTcVX2fl3E8QDvpiJEgO+ArRLDk9bgZoVYqi/m+x49exiRWFvLkweeuKWyAdUrV+mFIrErEmCVoWxPtcRlkX0R18p8/i2PAmErY6f1bwlD4p2DgFMSddC55N4WvkKyZFLg0IyjEcOedVDSnztSm++aEjHc5v+nrFSQnij9yO+URnwlfl/TYdDTxnrlqVJBm45VfAwGatji3kXT4e26fylZwx68beuOkmy3nEBKA9LVeUFNEfhhzwlmynI2tVKgYx4oJvPuCadNXzwCwvcK9ZiP5jw1mssVc962lFH3YWgwx3W1ochN29QEYoCC5lI1OfREDiBZ2ZCVjHNSC3zD412v6G3khqBbaDTsBB3+mQ2ytn3MzmHP048wZw08fH6vfrl83nada2y7pBkpBYykLZqmUK133UL0/JT5c2IdfGVnHKQ0iIUAUCUReeusr7xpnTLGhZXwj6FHZGPOrHE3IsTRd8996/yGzP+R/VxEvLNhuQuNl3rA4GhsRT+LaFLqHJxa3UEp0cW6x3nReP84/CGj48QgZkk6c7ihBlJ6jx/xeqT+dTl2aOOMccg9yZbcDo9B6TuQBz2ZtTvxGabT+1b1xMONovJRhsNYWtr4xLkUgjvBzNT3z1i1pDn73jD3nMBWUK4N8lx/7slWwsqUfMyxEcRjxf83xKzmwp+ZZdtvSQ77GU6kuc5GgjuRJUIycNRHpcQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(336012)(36756003)(86362001)(54906003)(110136005)(478600001)(70206006)(4326008)(6666004)(70586007)(7696005)(316002)(82310400005)(40480700001)(8936002)(41300700001)(7416002)(8676002)(5660300002)(2906002)(186003)(356005)(7636003)(82740400003)(83380400001)(2616005)(26005)(36860700001)(47076005)(426003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:52:11.1903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151435a1-5270-44b8-f685-08db5049269d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

Add a new IOMMU_TEST_OP_DEV_CHECK_DATA to verify whether the dev_data
is properly set/unset by the IOMMU_DEVICE_SET/UNSET_DATA.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 20 +++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 59 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 031e222cebf9..2987e8603418 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1517,6 +1517,26 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 	}
 }
 
+TEST_F(iommufd_mock_domain, set_dev_data)
+{
+	struct iommu_test_device_data dev_data = {
+		.val = IOMMU_DEVICE_DATA_SELFTEST,
+	};
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		test_err_device_set_data(ENOENT, 0, &dev_data);
+		test_err_device_set_data(EINVAL, self->idev_ids[i], NULL);
+		test_cmd_device_set_data(self->idev_ids[i], &dev_data);
+		test_err_device_set_data(EEXIST, self->idev_ids[i], &dev_data);
+		test_cmd_dev_check_data(self->idev_ids[i], dev_data.val);
+		test_err_device_unset_data(ENOENT, 0);
+		test_cmd_device_unset_data(self->idev_ids[i]);
+		test_err_device_unset_data(ENOENT, self->idev_ids[i]);
+		test_cmd_dev_check_data(self->idev_ids[i], 0);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index fef17fb46160..487d45c29c6d 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -444,3 +444,62 @@ static int _test_cmd_device_get_hw_info(int fd, __u32 device_id,
 	EXPECT_ERRNO(_errno,                                           \
 		     _test_cmd_device_get_hw_info(self->fd, device_id, \
 						  data_len, data))
+
+#define test_cmd_dev_check_data(device_id, expected)                           \
+	({                                                                     \
+		struct iommu_test_cmd test_cmd = {                             \
+			.size = sizeof(test_cmd),                              \
+			.op = IOMMU_TEST_OP_DEV_CHECK_DATA,                    \
+			.id = device_id,                                       \
+			.check_dev_data = { .val = expected },                 \
+		};                                                             \
+		ASSERT_EQ(0,                                                   \
+			  ioctl(self->fd,                                      \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_CHECK_DATA), \
+				&test_cmd));                                   \
+	})
+
+static int _test_cmd_device_set_data(int fd, __u32 device_id,
+				     struct iommu_test_device_data *dev_data)
+{
+	struct iommu_device_set_data cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_uptr = (uint64_t)dev_data,
+		.data_len = sizeof(*dev_data),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_DEVICE_SET_DATA, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_device_set_data(device_id, dev_data) \
+	ASSERT_EQ(0, _test_cmd_device_set_data(self->fd, device_id, dev_data))
+
+#define test_err_device_set_data(_errno, device_id, dev_data) \
+	EXPECT_ERRNO(_errno,                                  \
+		     _test_cmd_device_set_data(self->fd, device_id, dev_data))
+
+static int _test_cmd_device_unset_data(int fd, __u32 device_id)
+{
+	struct iommu_device_unset_data cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_DEVICE_UNSET_DATA, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_device_unset_data(device_id) \
+	ASSERT_EQ(0, _test_cmd_device_unset_data(self->fd, device_id))
+
+#define test_err_device_unset_data(_errno, device_id) \
+	EXPECT_ERRNO(_errno,                          \
+		     _test_cmd_device_unset_data(self->fd, device_id))
-- 
2.40.1

