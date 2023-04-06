Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC56D8F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjDFG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjDFG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:26:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59B93C8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlLK5PkHzHqiZLqw7Cmjv6HqYKR6V2mnYTaK/nN4KLsteL84rCvVGsuzLpxSrxjjHy/yuWdis044azdZ75wY8F/igwp7D2CyOcK1LTj0Ab45vRIBpEffZ/bZB02uGk3omqT6tbnyCJqgqgB+BwjmfW/B0DO0ax4ERn7HuqGVfHpkfWFXRqXgHC/hqMmtZk1ezv03nk4nbBdNRzLnPssAWcRZh3bkTfOx4VdN2gBPVdB0168x5+ov+d3QfheD+sP4PnjnsEHcL/xbCBaSVEHl722Axs3s+9pC8BIJ4zwWFu4crAQDp0Wp35Hu20xFu2zo97606G4Vq3M6L7zEmIPhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FWAzBExbmyJdVTG4OGhaVnzVTBB+BljON2XqecxAZ8=;
 b=BC5a9m958tmbeutruOyi6RS29TufcqZaO8Ni9oJF/OyT5TmwQTiRZ5ucZ+W1MpN+Wyn8uzb3QgitO65o4/RA88S3BLx0QMYNJmL4ST/npLjfZoi+9fQhm0SscKQBY6q2hY+pOz8OzqDjN6vP9c9X+hE7OetxZWV3AX8TvHZGdpxr+tHKG8OroaNcXldsYdAe48v/Pe74aBJ3OmbLfkbsHlz2eR9o7ZyPru3rdwSYu6lt9iazu05vG/rbPCdIl+d6SD8si4YbLdeUadY+Ne63pq5BgKea1oUDBnn/7Jub4Yr6glLKthUdj77RLpwgLZ13h1RAsk//w/QUyqr2HK51Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FWAzBExbmyJdVTG4OGhaVnzVTBB+BljON2XqecxAZ8=;
 b=Byisae3GL65OG4OxiIKBIpojDCHm88nveOcQ30CyhB+2MpT8vZgk/OcI2R5jpChEj1AO1KQdTEce40tXzedTT03IbIIsTEj/tRsTlOv1Jn2QmKNoNbiOEi1hcNcwROuMGW+z8pRSgB4YtPRBsff+QD2QKgwPdjVIFEvurHElDomD+sgBSYWTLQ/0ZaUmR0ifi1ge3ffM8c9VrZMcWWgi7vfNcXK5ZzKXZPLTzeRaG6HomRow5r+863be/n9C4x4NeIPGYDoC1oXJjaH5E2IKsq6A5Vm5rI8j5XH8vQTO4zHZBShVlQrnJbz3scFL932jSsvyDY+Gj6LsIGAnVD11EA==
Received: from BN8PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:94::44)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:26:36 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::9e) by BN8PR03CA0031.outlook.office365.com
 (2603:10b6:408:94::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Thu, 6 Apr 2023 06:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 06:26:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 23:26:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 23:26:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 23:26:21 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <kevin.tian@intel.com>
CC:     <eric.auger@redhat.com>, <yi.l.liu@intel.com>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v1 2/3] iommufd: Add IOMMUFD_CMD_DEVICE_SET_RID and IOMMUFD_CMD_DEVICE_UNSET_RID
Date:   Wed, 5 Apr 2023 23:25:35 -0700
Message-ID: <70520cb453d3a2521fb982776080adf4b2e40047.1680762112.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680762112.git.nicolinc@nvidia.com>
References: <cover.1680762112.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea39927-e66c-48a0-622e-08db3667df72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBO7xULMwUjelzH78DGRvfOi9fGlWCHmeFvcrV8OXV7UEqcOxwQycmrW3xsFvTMXjDGkXlToOCoFa5Rs8EGBf1usKYFZ8BiFr83JqxukdIwDWFgy2w6kniVGR8LkMPk8QwqKoRvJdAjQCtRAbdNpY5mKKk1gGMxs0IMD35cY4W8MUqOygFpSYN2mCdXno+1CGNcwqW2LbJdvzMJVbiOeknRyX61YO1EXgQ67TTE8lemE5JD0DHaLftTw0mz6El9VsjZNfrx/3s4yqtFos10M4tJLUcCkAHx5I3S4lJveS1bJR+MaV2bRkIhqZ6n25W8PauXE04MTj99TVBrR08VS/GU1H6S9HJEgWdWygvWBdo45+mEwgjakg9gOG9CmiR6qs+QP2acSZLcxSH+6GUZkSX3HWYq4LoW/3jXwILGr5qatx8FVA1xbVnix3xw0IGHHihpkZBvzNho46Jmkhr9dl+NdMQvSYrGKim7zxSJ7w7/NTCsQMZsO8Q0iwm3ctl1DnHkubu2XGzlekWc8KXIuinD0lhSrq8UQHbvauOHevoDJ/sKYWdfg3FA6al/3nkwE3CtCt5APHcjd2U7qRp99KL9XAb+smY7EWI4wM47KoQVoMmmEo2nHXL3IVGL5//SBnMuACMQw32rwuYDD+mpcU6A/dXAfVzrgLX4NLGwGP2UsfoXpsibMMWOKqNxSGocN993+Av/wOahdl6nNWfcI3LnUIDJneanISaGVPdEWcxD7iKesvFubXldZ8LAeNyUv
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(7636003)(8676002)(82740400003)(356005)(70206006)(70586007)(336012)(426003)(7416002)(41300700001)(8936002)(5660300002)(82310400005)(316002)(4326008)(110136005)(47076005)(478600001)(2906002)(40460700003)(54906003)(6666004)(86362001)(83380400001)(186003)(40480700001)(36756003)(7696005)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:26:35.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea39927-e66c-48a0-622e-08db3667df72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new pair of ioctls to allow user space to set user space Request ID
for a passthrough PCI device. This is to create a link between a physical
RID and a virtual RID in the IOMMU driver that cares.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 39 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 drivers/iommu/iommufd/main.c            |  4 +++
 include/uapi/linux/iommufd.h            | 31 ++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 207b0e3fd9c8..db756e5cd77b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -735,6 +735,45 @@ void iommufd_device_detach(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
 
+int iommufd_device_set_rid(struct iommufd_ucmd *ucmd)
+{
+	struct iommufd_device_set_rid *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	int rc = 0;
+
+	if (!cmd->rid)
+		return -EINVAL;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (ops && ops->set_rid_user)
+		rc = ops->set_rid_user(idev->dev, cmd->rid, cmd->rid_base);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
+int iommufd_device_unset_rid(struct iommufd_ucmd *ucmd)
+{
+	struct iommufd_device_unset_rid *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (ops && ops->unset_rid_user)
+		rc = ops->unset_rid_user(idev->dev);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 void iommufd_access_destroy_object(struct iommufd_object *obj)
 {
 	struct iommufd_access *access =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e52fd9d8c160..d65617727c0c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -320,6 +320,8 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd);
+int iommufd_device_set_rid(struct iommufd_ucmd *ucmd);
+int iommufd_device_unset_rid(struct iommufd_ucmd *ucmd);
 
 extern const u64 iommufd_hwpt_type_bitmaps[];
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 7ec3ceac01b3..113fac4d4de0 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -317,6 +317,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_DEVICE_SET_RID, iommufd_device_set_rid,
+		 struct iommufd_device_set_rid, rid_base),
+	IOCTL_OP(IOMMU_DEVICE_UNSET_RID, iommufd_device_unset_rid,
+		 struct iommufd_device_unset_rid, dev_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 59a44ceff27d..5188a4318e22 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -48,6 +48,8 @@ enum {
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_DEVICE_SET_RID,
+	IOMMUFD_CMD_DEVICE_UNSET_RID,
 };
 
 /**
@@ -482,4 +484,33 @@ struct iommu_hwpt_invalidate {
 	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * struct iommufd_device_set_rid - ioctl(IOMMU_DEVICE_SET_RID)
+ * @size: sizeof(struct iommufd_device_set_rid)
+ * @dev_id: The device to set a Request ID
+ * @rid: PCI Request ID
+ *       Bits [15:8] are the Bus number.
+ *       Bits [7:3] are the Device number.
+ *       Bits [2:0] are the Function number.
+ * @rid_base: Base ID to map PCI Request ID
+ */
+struct iommufd_device_set_rid {
+	__u32 size;
+	__u32 dev_id;
+	__u32 rid;
+	__u32 rid_base;
+};
+#define IOMMU_DEVICE_SET_RID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_SET_RID)
+
+/**
+ * struct iommufd_device_unset_rid - ioctl(IOMMU_DEVICE_UNSET_RID)
+ * @size: sizeof(struct iommufd_device_unset_rid)
+ * @dev_id: The device to unset a Request ID
+ */
+struct iommufd_device_unset_rid {
+	__u32 size;
+	__u32 dev_id;
+};
+#define IOMMU_DEVICE_UNSET_RID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_UNSET_RID)
 #endif
-- 
2.40.0

