Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1D6FBE70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjEIEwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjEIEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:52:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE930E3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E61OnIdanhN1/gWddEL2UJcOQCI+i3zpLT2ts8bK4uMmPn4KIaU8bzndGSdaDeKW4lOFKRIcCXUbuxluos34Slq+ojAGS5+9BhD3Z+QktHZBu8ubH95UMnF5Xb9MvsCs0X/YF9BDaa2DXz/k2deIRpPQdrOE6LwtMuH/E/CgGn+0X6Vjbbr53qKgXg/0qP8uDPgJQavBnhmOqezAvHkh5OPNRNr85Tj6S7ieasFvR/l9Z7AigY4JWMWUP+LGrDBC9r7uzdiVBx1tJkj/HotsQ23SQXYZ0nQOD/soUd9aGVWOLe/TpkhhRFEnz9NsgQKRh21onOiLAvYNUm5OIuUuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whyV+1ypaFjM7PJhtYvdNFA55/krPie68ZvBso9S9go=;
 b=jxltSW4nJ3G49QM6D8E9JofT1gcf0WVwrwl8zSj7CLzColnqS78PQF0KbXW2l8NfY+1tr9rfJtdpSXPnlcyg4KSKlcv9RtRjcyeDjDTY0IzdHYcI5N7Xjcfi7uw+XYtn6q4xkMgCqIO0x4fSU13YUYDm/LqYzKENnPSjSM02xeSt9kFcKJr+Zb0EReetoCGCZK7hnmTMoKXx+vslF2nvbgKf4JodKz9/UD4wz0CX5aH5h51wLgMrkiAhrUv3WE48UgXJJUUbOBsxhA7nINi1Xlv6MDCItkMZejNYvgqHEYt/bfNBIc9dRog+bWgkKCpGdNU2NnAIbwvirfh4PbFvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whyV+1ypaFjM7PJhtYvdNFA55/krPie68ZvBso9S9go=;
 b=C6WLYKK3V1xUL9JKGZkw03d610Y7zDAm9itkgv9qwL3adJtyCcWxrslXk5oTDvGz1yLwWMfArT2J2TZ+aqYjAD/zW+eD/xdYRAu/BR1kNVn1WQq3RFfostBDxuox7cNreWLROJpaOcRBLUQJPTrobJ7TRl2A8jFeXuZayiKzTP3BQHMHmeEgOpM7QG+cTDD13lFtUSGvzLRW0fJJOnlr6RQF8nGbmXpYC0XGBzhWMj9IP5Zs1sT7A8LZhlTzfvuoQ5LjKMeJ6ibt6nAzKrWyjoJxNCj8RHocelJCdMEqM1LS4yaCtos8GuoatHxjcbiSk7oj2xWEZ8OUThkjEU25+w==
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 9 May
 2023 04:52:13 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c3:cafe::96) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17 via Frontend
 Transport; Tue, 9 May 2023 04:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:52:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:51:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 21:51:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:51:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 3/4] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_DATA
Date:   Mon, 8 May 2023 21:51:49 -0700
Message-ID: <0783fcf9eca9fa2dc462a43574c4a0ab76d367fa.1683593949.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593949.git.nicolinc@nvidia.com>
References: <cover.1683593949.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: d394e0a6-5261-46a0-80a5-08db50492764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pDoeb5qJYDzopixgg2oDEuJ5jNj12Zus0PyYUsZmHjsjo4bLjIUXR+YEmGw0C6qE+j/7IdbagkR5NXx2M6uob6bgzZOXUv+DOmVhgkwMDAtP3FRhIGclsSJo7AqDAQzgpdv6rLLrn0pbmsiAGphXcVkW71mw1ebGz8PFnI3FzGNFH6EAp+ZWxZgzP+fEsfI3ed+MnrPL1VYSvWkSeA3LeUgnyyDt1o3tZDAo+1GL8w5YXhGMmRDf3dGdVPmfrM6eoA+bWyWiih3ZWazbMTe86UC6kuhxxEAq1/t9AEaV5qBoh/SQ/i+2X2Jz3UQMs67yQShBpzJmA8+FSxx5SIr0BbT2czAKML3aHd8ei5v4f+qVfzgHVxVAIZjjynh+Up6O6mNAf0JU9uB099pS9Owiv6ominn/Qrr44HsoldDkrpzaOvF6EtaOzhYmtw6IWItGsiOxc7VKWQq1Wv7XIBPTaZi4iKwEGbd3II9k/S1bzHOi6IF8EaCteDdZ/FZ7G8qCYL6P0bCL4H2qQxFvlQQehuOgCGg0s4fDb9ImUebjK9XLOD5emoRA1sC7Jas/qfBHrkCZbjnDq8uph+lPZAI+Dearr2JOnlZyvtA5iKvz3qJHda2tCOuHutsmz8T+B22sIwb/5aEmSLhluIfQXMQD1XtCaPGF6zIRYB0blWRc2ZoH7kHWlqs95YniMkKxYGmk3okJ31Hg0SlASMg2f5fhg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(41300700001)(70586007)(8676002)(316002)(70206006)(356005)(2906002)(40480700001)(7416002)(40460700003)(5660300002)(82740400003)(8936002)(7696005)(36860700001)(26005)(83380400001)(6666004)(426003)(7636003)(82310400005)(47076005)(186003)(336012)(36756003)(2616005)(478600001)(54906003)(86362001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:52:12.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d394e0a6-5261-46a0-80a5-08db50492764
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

Add mock_domain_set/unset_dev_user_data and iommufd_test_dev_check_data to
allow testing on IOMMUFD_CMD_DEVICE_SET/UNSET_DATA ioctls from user space
selftest via IOMMU_TEST_OP_DEV_CHECK_DATA.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 15 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 42 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 99db8ee9daee..10a04631797c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -20,6 +20,7 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_DEV_CHECK_DATA,
 };
 
 enum {
@@ -99,6 +100,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 val;
+		} check_dev_data;
 	};
 	__u32 last;
 };
@@ -119,6 +123,17 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
+#define IOMMU_DEVICE_DATA_SELFTEST	0xdadbeef
+
+/**
+ * struct iommu_test_device_data
+ *
+ * @val: Should be set to IOMMU_DEVICE_DATA_SELFTEST or unset to 0x0
+ */
+struct iommu_test_device_data {
+	__u32 val;
+};
+
 /* Should not be equal to any defined value in enum iommu_hwpt_type */
 #define IOMMU_HWPT_TYPE_SELFTTEST		0xdead
 #define IOMMU_HWPT_TYPE_BITMAP_SELFTTEST	U64_MAX
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index dbc5cc44c80e..ba3b578ac5a6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -95,6 +95,7 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	u32 dev_data;
 };
 
 struct selftest_obj {
@@ -332,6 +333,23 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 	 */
 }
 
+static int mock_domain_set_dev_user_data(struct device *dev,
+					 const void *user_data)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	const struct iommu_test_device_data *data = user_data;
+
+	mdev->dev_data = data->val;
+	return 0;
+}
+
+static void mock_domain_unset_dev_user_data(struct device *dev)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	mdev->dev_data = 0;
+}
+
 /*
  * Note that having IOMMU_HWPT_TYPE_SELFTTEST (0xdead) ends up with a very large
  * array. But this simplifies the core when handling the user data. And the size
@@ -353,6 +371,9 @@ static const struct iommu_ops mock_ops = {
 	.domain_alloc_user_data_len = mock_domain_user_data_len,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
+	.set_dev_user_data = mock_domain_set_dev_user_data,
+	.unset_dev_user_data = mock_domain_unset_dev_user_data,
+	.dev_user_data_len = sizeof(struct iommu_test_device_data),
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -717,6 +738,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_dev_check_data(struct iommufd_ucmd *ucmd,
+				       u32 dev_id, u32 val)
+{
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = container_of(idev->dev, struct mock_dev, dev);
+
+	if (mdev->dev_data != val)
+		rc = -EINVAL;
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1133,6 +1172,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
 		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
 						   cmd->check_iotlb.iotlb);
+	case IOMMU_TEST_OP_DEV_CHECK_DATA:
+		return iommufd_test_dev_check_data(ucmd, cmd->id,
+						   cmd->check_dev_data.val);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
-- 
2.40.1

