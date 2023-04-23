Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02576EBDBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDWHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjDWHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:41:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB72132
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxHCM2C7QAf7Va8pAVmsOSMAaA99DGoT9/aipFZ1OlyiUeod/ARNMp+uWInbX/eQp/AWV7UD53Xx3+MFmWcaCh4DhcDLcGwAq47w/hq2x4KrqcjAKKiV5exr0gLcbQLAFmzMYjSV4lf24Zyx8j3mH3ne4Qi//L63P9RRXxQAlw/27HMjP+6AKUlBgn1fBUX4Cn/2DBVl98cCSWJ9RwzhozLMyMWd3+10WKXHkF9I8gJuF8lDpygKjSrzO02qmp+es4XkhxcShb/jL1bfTpnHOGWi37ionLQtj2B+D/7yvywEL71tzY+18HE7TKnhKIMTh3LnG829IXDx/MOG86ezig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqZhqt0b08JYj1JYZFArb+zrEwKlF1ko5nnULbdPVXI=;
 b=TA8QlqIdZGLUydd0HGA8xYGNdOTXutowrTw0uUPzpwb0uJBhDJOrwXoF11bbVMG5jaTjdWzvhgl6k5Vku02JKd3TE6HkPYWnly1BRkpuBumQQBCSSLP2/SenElRMHDnRJLMUllvbCh90JI2RYIu77T4/vH+phjBAZKFJJhmap7qeaCuPXXvN0tfjP9LaswI3YzFCt30dJKdlyFFci2U7EeM1I25wo0lPGMm9lxPioQDaLvyMypC5qw5SKcR3Y48aMetZvDct1+yAKhagWlet4p0S1vpQIkGXocl/nY9JZwSz8AvNFlyWVyDq2EFMYUSK3xSFQ0yD81ODd9BvVtk1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqZhqt0b08JYj1JYZFArb+zrEwKlF1ko5nnULbdPVXI=;
 b=h0OpL4yo/3UNFLB6fLz4ZsrEe4ow6EW7Q7fQgV8H0uUL3K595ICyau8BR9i2C7xycqyPx9lZFcYIRzqywZKBRqqsDq3K1+iIA1zOTiU1hHB96o1mEziNQIpAq99EwLL4/WbTNqhEhErsHXC1U4AjHgBh9YyopYoZrF+K1lwwlVmRLxFeDdTOyU4mobmH2yb1G61Z+YZk1mUkKJrcgSxJEQzJUbdFDKj6Z+zdzKHm/meo3Afa9sP7S5J1NnUswGbf9Y482KH8p8Fe9FH22lwamWtSZXY9cmjEXBuooR/NJl7vmoUIRkd7C7UbgCEFG77NosPTthibUJAYKeJ3JRBuMw==
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 07:41:22 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::2a) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Sun, 23 Apr 2023 07:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 07:41:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 00:41:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 00:41:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 00:41:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3 4/4] iommufd/selftests: Add coverage for IOMMU_DEVICE_SET/UNSET_DATA
Date:   Sun, 23 Apr 2023 00:40:34 -0700
Message-ID: <6df9a4e5ad00b1386220f984ec640cab6237ca37.1682234302.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682234302.git.nicolinc@nvidia.com>
References: <cover.1682234302.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: e07730eb-9097-408d-8f52-08db43ce2291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5BOnazjnPZ4fkCfdnoehtwjlEbxlOVDCjn7SUEtjWNLHQPtqAWkIwGvwEa0X/Yw2Yx+5+xS8DAXoer8HTq7Uxs5J/kajOLwsASLdyFXXQWwP/F2D+RIiZ24HDjhMZTSesYUTxPjn2v779gHsnpISFE0DybMhWAF99oJOKy9aZcD/o0C935vq80V5B8lhAAOGnS++lPNhaCOtUPBqN+2T+UTt/El1QVSzgb8o5IZ/RA6c6SR9w5XS3T6M215cztFP2RnAVM5VGv9aue5pxgDDbOCi/WEG7UdP9flYfan71DEcu5pmIAniAYZWv+Y9TKIiH/zgKir1aCXnVDDp8lYip6juTGPtTRY8Z52CRAsZFHi+1itnpavvpeLliCnqOu/LayRykOicRDV4gGIcsxjIJzMDsibQEDo9uFcEWR2Pu6gKN/Un7uJYT/NWF3N6mGoeUNJOW8Drnelx5LOnz6YDZTZC3KMrF09AhTb9ylBRYGUvWiQhILpOLkpM/D/TooiDkGl/+Ulwl0Yk666NLVEu/hCgURlasPnyzLNEFh8iYEpl30ZsnuFOrAJkCQn0kJvMkwdSKANwmZRrDlGocu/Ia8hcvDa+w7OJ+zKhtxzKFhl3HrsK7gBCMKy5Lz5ABhvwNZ2b8qQXa28mkLfgoRuUAi//u+gBGcD0pPLVkxFUBGPqbbjMhYn7UgkvmjbtM9+YO1Hbc/EQdCPY/4CCs67MCEpexFvcsVkpb9yOXWlDNw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(34020700004)(186003)(2906002)(36756003)(54906003)(41300700001)(110136005)(2616005)(26005)(426003)(336012)(82310400005)(83380400001)(47076005)(86362001)(7416002)(5660300002)(7696005)(6666004)(82740400003)(8676002)(8936002)(40460700003)(316002)(7636003)(478600001)(356005)(70586007)(70206006)(4326008)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:41:22.3783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07730eb-9097-408d-8f52-08db43ce2291
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 7291e1c4242a..8265ec6a0606 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1483,6 +1483,26 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
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
index f8ba7b09078b..da04f802c675 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -445,3 +445,62 @@ static int _test_cmd_device_get_hw_info(int fd, __u32 device_id,
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
2.40.0

