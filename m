Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA906FBE72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjEIEw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEIEwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:52:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE23730FB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU6Mzs1XGyRPhHlHic2XsPdm5+H1rMuUHlQdcDEV0ziUU4Qq67F5PYLLPziJL1SI3Qwz940QB+gWH+I9lAFO7zTjhyBETQq1tJJ8GS4G/RfOdn+DlT4F8aNaZ2xoaHBGrk3/BBQ+kG7YqCo5rojAMAuAOnoaL8W1vpljEuaGmERINHv8du8FjzVpqruPsFNevvaB2/w9HX61WiHiBJi/aYjEKbxZQFfuBZkrq6V9QW97VWgdyKqopyihz/J40jJ6fpQph08i1Ztlx8pSVLHZ7RaPzM1ToFfBjk16eV98r69YOgWt7HbBxibyMuydahg6VLW7/pT1rFl+dhyBWlr+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqeG6xI/4LdEZnRI5ulmNiNG6l3Vbq04jAj6Uq86cFg=;
 b=HqRDLwh5MGPhTjDPltHKLfhgzKBTez5ZmIVcG8u62jXL34pCVFk1LajOrGfBUmA69YehDgjQBLVHwLkWQGhgh4x8Ip/QQUc5F5DyTNMG+eYpqLUC5QUHx7EGt8wXPqJmduX3E5nFFuo/iqqriYZWA/ay1icvChVOcYgV6lrUwvxenN6fTVMwP/c3juLMzgR1E6rNN/zFR04tDf59Px1C9n7YiKKWtZ9PqwE0pnjKJHZHdlWR+lqm3982HjbVzqq56oVgqXm4YnFVyF3RH0dEJ9ujlNQZ/HrlbEBckG6FmnTTNfOpqU/gpAazWJ0OhmgWkNa0NGK4xaQw2O9dQ0fXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqeG6xI/4LdEZnRI5ulmNiNG6l3Vbq04jAj6Uq86cFg=;
 b=lCjRO5lF5nhbcgHqG9NSYKErPV/6VasC9jKaO0c1LVja2ASqsflYECNjr+SuGHn03+RILdwAG+JPMxCrjfclyzLbCwdDO9zwM+1l3+DvFmD1uYpV6+WhQs7Z8TSQMmAmq7LrQJJmLm09m3ANv84cY8KRZ+/lAqDoOZS0BvwK45/gGZmpE9VjIEMgXJ32cM8DUKxUx2KTlNshBWt4rjieQMA3zx4Ow3m9hgtKE01dUzmxyFK8NmjVXYVJmabZYWCUk1/jfoKz6Wglq//zkhBKz9vSG/XjLg4mbeL8bjO9cccUTwjhBzivh4+Wfc8zppxumrGX2kFLet4NXf6wCntHyA==
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 04:52:10 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::5b) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Tue, 9 May 2023 04:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:52:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:51:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 21:51:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:51:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 2/4] iommufd: Add IOMMUFD_CMD_DEVICE_SET_DATA and IOMMUFD_CMD_DEVICE_UNSET_DATA
Date:   Mon, 8 May 2023 21:51:48 -0700
Message-ID: <f3e1a593b1d8d6c70f60508d983250bac4d87c66.1683593949.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593949.git.nicolinc@nvidia.com>
References: <cover.1683593949.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: f2681aa8-ab64-4eff-c843-08db5049259e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 119IYNbx6xjZ1wrJ5b9eDDNKQlzzoDPiHhiN3uRjvKvuiQv6Xjg8RGA/MtHFl+uk8r2Dam507Kaws7pYuffPP4bEg9UzvmhUXAuwFobD8dh6l/pTgCwyLppLQFMr3s3H7kjLHgubx6PVKt8LIO91ZQ74sG+XQa08tfyr7w8mSAa5BzDiR+nTSpG3hOFFnnhaHf3IGK+D6BOq2fuq/CgyowgpTbE/9S5RJGDXIxp2eghvtUOSgqcx9do7itCCJSJjiMm0ohPujzLB0l+3nv647e+2DxH35/ek2Bx+YmkTYe1HN8/+AtyzCmn6C44bxPO46p2tpjkrTPrcaclc5QIl2XfJRMn6CP1rpVEt5YndF6oIjHjh4kJagjFOMtpXFxar34hNJFqx1ivPGVzuAEes9qLiXSlijn00Q/UbvKhJmekDJ3P5iINGeDuDGcxXrT0ddK/dNz1NKsmJPpC1xn0TUTRG76EecibhzY4rmh3m+NFTbSHq37C3Gp4l9S6nmlATrrIewqUo04tWutVXCxTU/68Lkn5xl9FqMHlz5ueBLSmX0K4hRi3PO6lXx7bw/c08dWCmUFouQbB/h+nQYZW8AiNjEh7Ooy13U4Bs3Xz7cOf/X0QtYzWGSIR17OPwOJPPxDI8xB6o9cJENwbbJq9Lu7zljcmz5vV7QFCpV3F6kpHthzqECctjHwcvhMf+mNcA1VAIPIuIhLf01RmTv+JUiA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(110136005)(54906003)(316002)(4326008)(70206006)(70586007)(478600001)(7696005)(6666004)(40480700001)(82310400005)(8936002)(5660300002)(8676002)(7416002)(2906002)(41300700001)(82740400003)(7636003)(356005)(186003)(2616005)(26005)(36860700001)(47076005)(336012)(426003)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:52:09.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2681aa8-ab64-4eff-c843-08db5049259e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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

Add a new pair of ioctls to allow user space to set and unset its iommu-
specific device data for a passthrough device that's behind the iommu.

On platforms with SMMUv3, this new uAPIs will be used to forward a user
space virtual Stream ID of a passthrough device to link to its physical
Stream ID and log into a lookup table, in order for the host kernel to
later run sanity on ATC invalidation requests from the user space, with
ATC_INV commands that have SID fields (virtual Stream IDs).

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 81 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 drivers/iommu/iommufd/main.c            |  4 ++
 include/uapi/linux/iommufd.h            | 32 ++++++++++
 4 files changed, 120 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 790e94baf11c..e40f576fdf0e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	if (idev->has_user_data)
+		dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -726,6 +728,85 @@ void iommufd_device_detach(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
 
+int iommufd_device_set_data(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_device_set_data *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	void *data = NULL;
+	int rc;
+
+	if (!cmd->data_uptr || !cmd->data_len)
+		return -EINVAL;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+	if (idev->has_user_data) {
+		rc = -EEXIST;
+		goto out_unlock;
+	}
+
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops->dev_user_data_len ||
+	    !ops->set_dev_user_data ||
+	    !ops->unset_dev_user_data) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	data = kzalloc(ops->dev_user_data_len, GFP_KERNEL);
+	if (!data) {
+		rc = -ENOMEM;
+		goto out_unlock;
+	}
+
+	if (copy_struct_from_user(data, ops->dev_user_data_len,
+				  u64_to_user_ptr(cmd->data_uptr),
+				  cmd->data_len)) {
+		rc = -EFAULT;
+		goto out_free_data;
+	}
+
+	rc = ops->set_dev_user_data(idev->dev, data);
+	if (rc)
+		goto out_free_data;
+
+	idev->has_user_data = true;
+out_free_data:
+	kfree(data);
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
+int iommufd_device_unset_data(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_device_unset_data *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+	if (!idev->has_user_data) {
+		rc = -ENOENT;
+		goto out_unlock;
+	}
+
+	dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
+	idev->has_user_data = false;
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 void iommufd_access_destroy_object(struct iommufd_object *obj)
 {
 	struct iommufd_access *access =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 35d1294b2f06..98eaef9c41d3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -309,6 +309,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool has_user_data;
 };
 
 static inline struct iommufd_device *
@@ -321,6 +322,8 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd);
+int iommufd_device_set_data(struct iommufd_ucmd *ucmd);
+int iommufd_device_unset_data(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
 	struct iommufd_object obj;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 6392f94af179..30f91ea1c5a5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -324,6 +324,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_DEVICE_SET_DATA, iommufd_device_set_data,
+		 struct iommu_device_set_data, data_len),
+	IOCTL_OP(IOMMU_DEVICE_UNSET_DATA, iommufd_device_unset_data,
+		 struct iommu_device_unset_data, dev_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index bc9b08baeb1e..8b4268107c66 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -48,6 +48,8 @@ enum {
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_DEVICE_SET_DATA,
+	IOMMUFD_CMD_DEVICE_UNSET_DATA,
 };
 
 /**
@@ -478,4 +480,34 @@ struct iommu_hwpt_invalidate {
 	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * struct iommu_device_set_data - ioctl(IOMMU_DEVICE_SET_DATA)
+ * @size: sizeof(struct iommu_device_set_data)
+ * @dev_id: The device to set an iommu specific device data
+ * @data_uptr: User pointer of the device user data
+ * @data_len: Length of the device user data
+ *
+ * The device data must be unset using ioctl(IOMMU_DEVICE_UNSET_DATA), before
+ * another ioctl(IOMMU_DEVICE_SET_DATA) call or before the device itself gets
+ * unbind'd from the iommufd context.
+ */
+struct iommu_device_set_data {
+	__u32 size;
+	__u32 dev_id;
+	__aligned_u64 data_uptr;
+	__u32 data_len;
+};
+#define IOMMU_DEVICE_SET_DATA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_SET_DATA)
+
+/**
+ * struct iommu_device_unset_data - ioctl(IOMMU_DEVICE_UNSET_DATA)
+ * @size: sizeof(struct iommu_device_unset_data)
+ * @dev_id: The device to unset its device user data
+ */
+struct iommu_device_unset_data {
+	__u32 size;
+	__u32 dev_id;
+};
+#define IOMMU_DEVICE_UNSET_DATA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_UNSET_DATA)
 #endif
-- 
2.40.1

