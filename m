Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623936EBDB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDWHl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDWHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:41:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E81FEF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZL3o2g39Q4H4UT+p7jAwO+tiopEnVasfk9wEUVcbpDHZqnpIvqrGl4iyAHepQZE5j2sAoyN6ULXTl+gqGnMY8NVi6uXqG4MRe+yz2h0JFrmbQZZ1mjPT5d8rSvs4yM6TxQ3vOW0OvVlPfyy+LKDe9JRtq7Ocu/UnvQZqspik+rVQWRosfwlJmRkOZaCah2lyZbDsNWDBwoJFcKLxTpHJItZURTiIhniHKwTEEJ+rMA0vUXG9RX2CNMXXijRrvKlM0+s+1LTheYRjLVMdCeXpJsA7AEu/+YH5X9w0XcVQgVbtQRQoST+0N6JOP8N9ngZzhY/hsTOBhmQCLBfOTxFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba7B2OHFYMEYz/AQFnUwp4+uykVtWQbYYCfz4zdvST8=;
 b=fnqXbU5eIE8EzUYYT4VtZK9166QDFImgEPzrUZBHnuIzFTWmrt8OJHa+1NMGmPBW9BXmOa7t/9cbca5j90xp77CIZPP1QIOQzTKtPUVsYyx6rqf8yAuv/0EQWuzuv/cm2Nzl6dc6ShtNTBC7TDAG/khhmIUb8E0S1cXNJIVhneq+DOnNlB7w3Yx2G1YNqgVliF+r7kICVu5wiflYq9ce1Rj2EwappHgudrSNyU/wS0TkMhE+aZqIyo3O8sEO05KsC6690qA88DuMGLBZJUAJ7E49rHBI7thWQTea2OODsS4ekXOSalpFJ77hZE3IkX2d61fA1T1iwNNCiYAxiV/pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba7B2OHFYMEYz/AQFnUwp4+uykVtWQbYYCfz4zdvST8=;
 b=mAamBfweD4nk4pQuXfjhfNp+1eRra4MwU933ThJAfwtWWHQfr3WKzrnkDco2uRCBUzWbJAVbTps4iptm+LfyfL7SHnC1a5nurR803yipIjEq/cVyddS5Pu0yniggc4lmSYCkClOPo+kp87K24nAuN/Qg857JojsYyHvf2NiXdEEaeNGiAY/F+GCPUFtOVdEE/gmTBtsXYEGJ+WHIShKMHIH7j3LXTxhgDvu+jo4Y1bnfOd/s3CNy4lh6dQjzut0R+kAfO4mx0byJptYUVcTQWxN5u10A/hVfFn9g1BjMSCwXq/iL7xqS8MUCGTHzRsWn0MOr9FvecwoGcGiVVCh+AQ==
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sun, 23 Apr
 2023 07:41:17 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::47) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32 via Frontend
 Transport; Sun, 23 Apr 2023 07:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Sun, 23 Apr 2023 07:41:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 00:41:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 00:41:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 00:41:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3 1/4] iommu: Add set/unset_dev_user_data ops
Date:   Sun, 23 Apr 2023 00:40:31 -0700
Message-ID: <cec62a4649113a09165294052aa4c250572846fd.1682234302.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682234302.git.nicolinc@nvidia.com>
References: <cover.1682234302.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 091d7648-9c50-4458-9a72-08db43ce1f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knqzOrVNz+MvWfR6iPRxLDkD/aQOs2k8sJOzDAzAMrgb1sOTSZpovMOq2fKRyw3XJchDgnhtJs/XNgm6Rrq8EoF0T4RF7jeawvAqmxGT/rrlbEfDRLNdWs/rmquaxNseTq0VGhWN8JdSQqVampufhFWTJZsDm0pDU5KCvksBhpQLR/KJx2qJ2OPNd8C703d3znYamvu87QlHUm5sv+b3DRi/ScT7FI6KPB1Ms1oX17NSleOr5Q3pcxl8oNyXQBVOXcYsV5Jgh/l2KZ3iTKaaOpp6GiJvFz6y1dRa0kbhK3tdcOz1X9UDaZh08K7Z77j20mdHuIWBamQUG0zEmXb+d2wqLHTGrshlVzQkiSBRtymefBjuYOpUKytrxFnt1rQ+Ds8mzmk8NES+rr7NIMs6dE4JGmWyKAnrayIDedPOyjQTWdO8ZUscc9UEFClRp7djzWNtkd29cTnICZbMG8WWC/o0p0/6cLBVTuFymgw83qp59h5UbcdsXWpg7jca3Z20/dwVCJdMtWAjsmZRQyyaJktKtUZzGtvfd5tIVfxDZHK0jQ/PTxvutaxQfBPPvW7IMxmCO50vH2s49zr+gHTS2XH+LjoW8JStNuibWIuhmPrpCR4S/k35r5vm5yIuRkJRUgNXzCcbdxO/xhKvSPxmyQETfpKpMok/w2L3wV1cSx1l1fXkqBbK2KH+aJexraVH4LQZhAcO/o+v05EsKGG0JVa88Rff0qydWyTyN9fZAfI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(82310400005)(2906002)(40480700001)(6666004)(7696005)(36860700001)(34020700004)(186003)(2616005)(47076005)(426003)(336012)(83380400001)(26005)(4326008)(70206006)(70586007)(110136005)(40460700003)(478600001)(316002)(41300700001)(5660300002)(82740400003)(356005)(7636003)(54906003)(7416002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 07:41:16.8499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d7648-9c50-4458-9a72-08db43ce1f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device behind an IOMMU might be used in the user space by a VM. So, it
might have some user space data. For example, a device behind an SMMU has
a static stream ID. In a virtualization use case, both a host environment
and a guest environment have their own Stream IDs. A link (a lookup table)
between the physical Stream ID and the virtual (user) Stream ID is needed
when the host handles the user cache invalidation commands.

Add a pair of new ops to allow user space to forward user_data of a device
via iommufd, and a new dev_user_data_len for data structure sanity done by
the iommufd core.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5c99aeaccd1d..33b11d87b374 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -257,6 +257,15 @@ struct iommu_iotlb_gather {
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @set/unset_dev_user_data: set/unset an iommu specific device data from user
+ *                           space. The user device data info will be used by
+ *                           the driver to take care of user space requests.
+ *                           The device data structure must be defined in
+ *                           include/uapi/linux/iommufd.h.
+ * @dev_user_data_len: Length of the device data from user space (in bytes),
+ *                     simply the "sizeof" the data structure defined in the
+ *                     include/uapi/linux/iommufd.h. This is used by iommufd
+ *                     core to run a data length validation.
  * @hw_info_type: One of enum iommu_hw_info_type defined in
  *                include/uapi/linux/iommufd.h. It is used to tag the type
  *                of data returned by .hw_info callback. The drivers that
@@ -303,6 +312,10 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
+	int (*set_dev_user_data)(struct device *dev, const void *user_data);
+	void (*unset_dev_user_data)(struct device *dev);
+	size_t dev_user_data_len;
+
 	const struct iommu_domain_ops *default_domain_ops;
 	enum iommu_hw_info_type hw_info_type;
 	unsigned long long hwpt_type_bitmap;
-- 
2.40.0

