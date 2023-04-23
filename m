Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEF6EBDBA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDWHla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:41:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0271FCC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt32G3nn80nC8Pa7TEpJB1ev4BMWkub65TND1p+XObupAgtuROka9pUFtHPMXqgZ/JVzUGgYZslTqJmc0fBMjirbXTqWiHEIPFakiTCbOuPjv5hRLVAiU11tlTFiOjbiziWXz+CD24Y0eHuTkLtkA7jisYWMA6ArJNOsrSh3cOa7itYnsDHAUP0v+NPNTQb5QDP4wCkpLU2r+DQeuYM2z1xqFdiTZ5VTr5Se0oCrYLaNp9Imf/uZCjt9Uc5ZNBDUisP1fV1lmY9k2Eo2Cj5ZYwS4Q3+A9c+OBiJ8UC6JvZtXR0KyGwCLaPbcgqIbTeIaCDPo6fDPU0NL3xH62GIrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npTtfCWluekQWpwb0rMYbbNRmEY6+WZAZVvBuX9pgBg=;
 b=VSbtaUUR5nVl7cks17ut6W3LRj8fs6ElSZ6wL4eivQOt83eqzekjySd6/xt912qdJfsFstq9fnfHZB0FbwYXCt17wT7JLRRyrABOTMiYU7sfq94E3O3p197HeVAEYy0vOasZhQl4Nf1/wDTCc6QX77eZvRCkVkaUYFbvf6rBz6WQOFxEXLNATcPhAwxSl7HBz9y/7NpHBydwqf7CFyc7PaO2HwyHx2M24L9LAurylwR5SdCF60aC+hDP1RlOtj7IwifD1WbzMdWwK7ZRRFDqFMucMQTcWxSvWkNlaSER9GNW9cns6aQRR6DbR0LJUo6/sDhMDBlYn+bf5n8bxdwU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npTtfCWluekQWpwb0rMYbbNRmEY6+WZAZVvBuX9pgBg=;
 b=CWoAabqtyyqCrysttzjY7bCEtz973Q7/fjZ8vSs1XtBT1oa80EUX8pM1LceSWQPbG1JCCXOWLb35LbXc38jC6oIkuS+KX6YfaKqkrP2AXy4SfD0nE8yXHPO8ggHgWOntoulJfrkwkvWNqx4g2rMxyTXEMXbNcpSpqZQyqObLoX1+SPWWJQSGvg3JyrrTC8eKLA1vaApy81Lamy6M8G6H/o6h/oJpmzbQcMZHsZdzkdAvygz/jfOjBvSb9a9zbeu5Uts/7XKPGcLFTT2V1k57J/i5i2GDyplaIugPAdtkiRGnL694Tp/Hkt+beKeCKwg+aqkoLNW8kTVvmP9pgrRlzg==
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sun, 23 Apr
 2023 07:41:20 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::f8) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32 via Frontend
 Transport; Sun, 23 Apr 2023 07:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 07:41:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 00:41:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 00:41:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 00:41:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3 3/4] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_DATA
Date:   Sun, 23 Apr 2023 00:40:33 -0700
Message-ID: <ec90e8de171d671cabbb37f6c71d7e328dadf239.1682234302.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682234302.git.nicolinc@nvidia.com>
References: <cover.1682234302.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: d61e8a51-f0ed-460d-87bb-08db43ce2131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v20ozb9YKVtiUxjmkupSGShBjlKDS/Pip2p934/fPxrAGD0GszsMI3xbLYlMwTSC5sjJu6Qna8NJGeNOvd87qAXPlmdyEK4xy8WWgzfpQNQnvHpHVvQ2NApgN8UOZjjTOvdji/kdfp82GtRhZN/rgRxB9kDZRsYUA3LzkgJ/9zSht2sMGcJuBOyKeH4dGOrncSGV1QEpbp+ttnRjhYNv21dygbFcZKD40xdHiDnXptwzQsE0APj5B25971NOwDoEd1vr7Rhp9cD7OTBGzfmfUY9QzLiNTz9po6BPeN2sZexz6JArndh5g2+EYYVvWbZG1GHFb88Wgm6tUXIQ1d3Vq9W7DwXEnFRUQBxLv039lXLYBR/WxjE/pNwNigQ/4uXrH75W2VaMNSZzE2fdIQjBTioOhi1BXob/TMtS7OzB6WIOjlDnt4d7XSH97x3eF6B9IZIdi6okP4cL/7nM3yvonbHHDaiX07C7fJAP8xafEW6AFR/FhO9pH1FASjt9Vrlp7oEBqT/VoDAtTdq2xDpFV3B6TRpmVP965qUyADQrvgXVrV5sIGsLa5POGF9RUxtWRBCim7jDsMyp9jXEqf5qCUeyiNfzL4gpmabtntJ0AXpQgDld8uwaz1ZQwWWzGNthKpkIl8x/SL4gmovHVUxUbrRDjPCWMFSEovNQ8ga4sjXADDvjtVBKKmxlqahiDiNsFusEqcG0FY3B3rMqYtJtJA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(346002)(376002)(451199021)(46966006)(36840700001)(40480700001)(36860700001)(6666004)(4326008)(70586007)(70206006)(478600001)(8676002)(316002)(54906003)(8936002)(5660300002)(110136005)(7636003)(356005)(7416002)(82740400003)(41300700001)(336012)(47076005)(186003)(426003)(83380400001)(2616005)(7696005)(34020700004)(26005)(82310400005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:41:20.0244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e8a51-f0ed-460d-87bb-08db43ce2131
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8f93d83fb52a..b27db4cfb230 100644
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
 #define IOMMU_HWPT_TYPE_SELFTTEST	0xbadbeef
 #define IOMMU_HWPT_TYPE_BITMAP_SELFTTEST	U64_MAX
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index dc2b696acf2a..698976547d2d 100644
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
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -342,6 +360,9 @@ static const struct iommu_ops mock_ops = {
 	.domain_alloc_user = mock_domain_alloc_user,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
+	.set_dev_user_data = mock_domain_set_dev_user_data,
+	.unset_dev_user_data = mock_domain_unset_dev_user_data,
+	.dev_user_data_len = sizeof(struct iommu_test_device_data),
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -704,6 +725,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
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
@@ -1120,6 +1159,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
2.40.0

