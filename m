Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B76EBDBC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDWHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDWHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:41:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3563D268C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9ppGJ/O0a/QFj6G1I12KontsE7LyeReDA9GvJ22kviCWONQeWlrr6C+Ns+DHgHU9HPxenm5GZ82YEUv7J9tjGYAKHxflWY4mSKkZh4M147OfdQuU+qdE08UEVtvNudEs/GLhERVkX3jnBCdnARSt6pN5p/rPJ/WIz9tXbbjP1dKnywl1AMbxm+SBhDe8bmFy4/Uo+FQX6LnMKqJ6VXX+0J7BWCI2gfd5ChokSneyUWZLUsz4RTXGQj7zopQFS54jIDcn94DcStKPWLQOZaDFIN4eKIo8fVKZ12dl36HWcVqto8Ngo1Qzf70G9s7rwUSZiMysnIGIdzXfDwtvY3ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbdE4D/g0b6iv249wekdyBf/yAnvC5a9SkPSARvHk1c=;
 b=ayfBVmrLElyRu0GnFMZIhUebQXQJp2UgjtAgk7vJ4KVEx3KQ6Iu/SPSbu9o4m0y0chfblaJ3MwIKMB0Mhev9HDwEqNwExOv+Wc+xjCVLVCu2BPlVk5nm0x0VvRnOv9YIgy6bhpYXdyMjzvYdWEsX9cppc5j8sqhWE6WvwE9j20PuUaLxXKDzbQWnCCWNxE/1MTzqB0rZPIzTOqqmutO2S/q7m1QemnMJhTqpagyXz9Jv08oqjelZvLqZu8qLAlnWSBobShrtx4KvN9DXyxrVGubgohn1A8koJZaJO+Rakyoj5/283x2HrjkI2y7r7Tveqo/0Cnxotu86fOzdNNvptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbdE4D/g0b6iv249wekdyBf/yAnvC5a9SkPSARvHk1c=;
 b=tojOsmmKlzLvQ8DzeaMXc+pCwvUAcdcMBgjHnjdDC17+4oikFmHKSKzVcN4sjG/D5/tjoZs/3MKeoYV+16d7MfQXsXfwiOYGQd735YavoqhK6C+SZpcJSqhScHKzQJ8SHwAfNQNwUfs50KxGhZwRgJK+HVmbnjDLOZY5gS8M6mm9PCLyl2IdhI83X6MXc70z5t3RwPor5U1O01onSUDTesoErF8phU6nAIjj5emI/H2CmffaD14NEgr00WvAXeKL131YkVhLuiA2H7Wyq0m/OkxQd2LcyVoxKzzIekQjxnjKOpk6uLoQU5GPAIrg5EewmD9ez8lZa6690EdZsdew/A==
Received: from MW4PR04CA0329.namprd04.prod.outlook.com (2603:10b6:303:82::34)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Sun, 23 Apr
 2023 07:41:19 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a3) by MW4PR04CA0329.outlook.office365.com
 (2603:10b6:303:82::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32 via Frontend
 Transport; Sun, 23 Apr 2023 07:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 07:41:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 00:41:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 00:41:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 00:41:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3 2/4] iommufd: Add IOMMUFD_CMD_DEVICE_SET_DATA and IOMMUFD_CMD_DEVICE_UNSET_DATA
Date:   Sun, 23 Apr 2023 00:40:32 -0700
Message-ID: <08604f9f4835d5a6b0d2d75de69722194abf7747.1682234302.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682234302.git.nicolinc@nvidia.com>
References: <cover.1682234302.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 494d4e2b-d118-4fb9-ecb9-08db43ce20b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hg5w6B2ZqhdmhHs0QygyoZFrYnYScyRrPDvvgjhLs+HpmoSXXbGaspWRSJpgsmnL0K2/xc2JocDerZCIjDt/d9VzUdDMWG21PAQMswGsz/bLzkX4ji1F4wPrfPAtDEvLsh1NIgZrZ/cG7wHQRGUxrUYWNtjw584EZC5/JCCVTEOdDczY68NJPHvyZf8xixGGUVYxpmweY+DQwk11wiPYCxrXiSiZW9N13kt32ORxY5e6gh1ql9VQWRPJoPeKEpxNPWRojTxA6pH7hl5zOQeXbNJFbdXiMxOnIxhpUGZrxI4aaeEFWaAbtKDLGcsZYxk+iZVMvsVmS3Y71Nk5O5fLH5qdotdfv9HhoUCKwDtbaj+ALqAW2q3xrwtQYvM8ycp68OdqiMRItRD3wV/jMliFOP89IiICnLi4XqheKiQ+dclft0q9Fs3fHec0yaXBIeA9OQ8jo+vSDzUdoy03Nn6ShgB+QeZahu1agW5V1F8+H03BlYmykVNWAmToD4n+LyPRiCZfwNktYdVmkPodA0WnhDUPpvMzBdsUhsXBJNScoVOS1jjSqFgWtaT1VjOdNH2xcTT08TcxJ8mdhqiYFS3Z5cKc2z/+DcxUVw2NhjRX94ni5fGo9Z+iCbyLHlMU+jRV4Ao00FsZQGid2CfWA/NEEZ+rXhB/BzlxglHnqwhVnuSEmYtDUUo1Sj5qgkJ1Fcb+UQ4X08/d7UNJ0WSl6pmawRs+8Ikn/h4JMg+ze5zMFDk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(356005)(82740400003)(7636003)(6666004)(7696005)(34020700004)(478600001)(110136005)(54906003)(40460700003)(2906002)(40480700001)(336012)(83380400001)(426003)(47076005)(186003)(2616005)(36756003)(36860700001)(4326008)(82310400005)(5660300002)(70586007)(316002)(26005)(70206006)(7416002)(41300700001)(8676002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:41:19.2874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494d4e2b-d118-4fb9-ecb9-08db43ce20b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index c649a3403797..9480cd36a8bd 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	if (WARN_ON(idev->has_user_data))
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
index b84b22487b7d..bd4753512990 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -326,6 +326,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
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
index ac023ea6040a..b39b0e2e46b1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,8 @@ enum {
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_DEVICE_SET_DATA,
+	IOMMUFD_CMD_DEVICE_UNSET_DATA,
 };
 
 /**
@@ -626,4 +628,34 @@ struct iommu_hwpt_invalidate {
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
2.40.0

